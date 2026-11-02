#!/usr/bin/env python3
"""Slicing-Probe für alle STL eines Exportordners (PrusaSlicer-Kommandozeile).

Aufruf:  python3 werkzeuge/slicen.py ausgabe/<n>/STL_1-43 [--duese 0.4] [--schicht 0.16] [--jobs N]

Je Bauteil werden die Farbteile (teil_A__farbe.stl, teil_B__…) zu einem Objekt zusammengefasst –
so wie sie mehrfarbig gedruckt werden – und mit 100 % Füllung, ohne Retract, organische Stützen nach Bedarf
(Brücken ohne Stütze) gesliced. Zusätzlich wird jedes Farbteil einzeln gesliced,
um zu dünne Farbdetails zu finden.

Geprüft wird:
  STÜTZE   der Slicer setzt organische Stützen (freie waagerechte Überhänge; Brücken zählen nicht)
  SCHRÄG   schräge Unterseiten flacher als 45° (Netzprüfung, > 1 mm²)
  DÜNN     gedrucktes Volumen < 85 % des Modellvolumens (Stellen dünner als die Düse fallen weg)
  LÜCKE    Schichtlücke im G-Code (schwebender Teil ohne Verbindung nach unten)
  AUFLAGE  Erste Schicht < 4 mm², oder Teil sehr hoch im Verhältnis zur Auflage (kippt -> Brim)
Gleiche Teile in mehreren Farben (teil_A__rot, teil_A__blau …) werden nur einmal gesliced.
  FEHLER   Slicer bricht ab
Ergebnis: Tabelle je Bauteil, Summe Druckzeit, Zeile „Slicing-Hinweise: n“, Bericht ausgabe/<n>/slicen_STL_1-43.txt.
"""
import argparse
import math
import os
import re
import shutil
import subprocess
import sys
import tempfile
from concurrent.futures import ThreadPoolExecutor

import numpy as np
import trimesh

ap = argparse.ArgumentParser()
ap.add_argument("ordner")
ap.add_argument("--duese", type=float, default=0.4)
ap.add_argument("--schicht", type=float, default=0.16)
ap.add_argument("--jobs", type=int, default=os.cpu_count() or 2)
ap.add_argument("--duenn", type=float, default=0.85, help="Grenze gedrucktes/Modellvolumen")
a = ap.parse_args()

PS = shutil.which("prusa-slicer") or shutil.which("prusaslicer")
if not PS:
    sys.exit("prusa-slicer fehlt: apt-get install -y prusa-slicer")

FIL = math.pi * (1.75 / 2) ** 2
tmp = tempfile.mkdtemp(prefix="slicen_")


def teil_of(fn):
    base = fn[:-4].split("__")[0]
    return re.sub(r"_[A-E]$", "", base)


def slice_mesh(mesh, name):
    stl = os.path.join(tmp, name + ".stl")
    gc = os.path.join(tmp, name + ".gcode")
    mesh.export(stl)
    cmd = [PS, "--export-gcode", "--nozzle-diameter", str(a.duese), "--layer-height", str(a.schicht),
           "--first-layer-height", str(max(a.schicht, 0.2)), "--fill-density", "100%", "--fill-pattern", "rectilinear",
           "--support-material", "--support-material-auto", "--support-material-style", "organic",   # organisch: Brücken bleiben frei
           "--use-relative-e-distances", "--retract-length", "0", "--gcode-comments",
           "--bed-shape", "0x0,220x0,220x220,0x220", "--center", "110,110", "-o", gc, stl]
    r = subprocess.run(cmd, capture_output=True, text=True, timeout=900)
    if r.returncode or not os.path.exists(gc):
        msg = (r.stderr + r.stdout).strip().splitlines()
        return dict(fehler=msg[-1] if msg else f"rc {r.returncode}")
    typ, z, ev, sup, zs, zsup, t, e1 = "", 0.0, 0.0, 0.0, [], [], "", 0.0
    h1 = max(a.schicht, 0.2)
    for line in open(gc):
        if line.startswith(";TYPE:"):
            typ = line[6:].strip()
        elif line.startswith(";Z:"):
            z = float(line[3:]); zs.append(z)
        elif line.startswith("G1") and " E" in line:
            m = re.search(r" E(-?[\d.]+)", line)
            e = float(m.group(1)) if m else 0
            if e > 0:
                if typ.startswith("Support"):
                    sup += e; zsup.append(z)
                else:
                    ev += e
                    if z <= h1 + 0.001:
                        e1 += e
        elif "estimated printing time (normal mode)" in line:
            t = line.split("=")[1].strip()
    os.remove(gc); os.remove(stl)
    zs = sorted(set(zs))
    gaps = [(zs[i - 1], zs[i]) for i in range(1, len(zs)) if zs[i] - zs[i - 1] > a.schicht * 1.6 + 0.01]
    return dict(vol=ev * FIL, sup=sup * FIL, zsup=(min(zsup), max(zsup)) if zsup else None, zeit=t, gaps=gaps,
                flaeche=e1 * FIL / h1, hoehe=zs[-1] if zs else 0)   # erste Schicht ≈ Volumen / Schichthöhe (100 % Füllung)


def schraeg(m):
    """Schräge Unterseiten flacher als 45° (ohne waagerechte Flächen = Brücken, die der Slicer bewertet)."""
    nz = m.face_normals[:, 2]
    zf = m.triangles[:, :, 2]
    sel = (nz < -0.72) & (nz > -0.996) & (zf.max(axis=1) > 0.3)
    A = m.area_faces[sel].sum()
    if A < 1.0:
        return None
    return A, zf[sel].min(), zf[sel].max()


def sek(t):
    s = 0
    for v, u in re.findall(r"(\d+)([dhms])", t or ""):
        s += int(v) * {"d": 86400, "h": 3600, "m": 60, "s": 1}[u]
    return s


def pruefe(teil, files):
    meshes = [trimesh.load(os.path.join(a.ordner, f)) for f in files]
    ges = trimesh.util.concatenate(meshes)
    ges.apply_translation([0, 0, -ges.bounds[0][2]])
    hin = []
    r = slice_mesh(ges, teil)
    if "fehler" in r:
        return teil, [f"FEHLER  {r['fehler']}"], 0
    mv = sum(abs(m.volume) for m in meshes)
    if r["sup"] > max(1.0, 0.005 * mv):
        hin.append(f"STÜTZE  {r['sup']:.1f} mm³ bei z {r['zsup'][0]:.2f}–{r['zsup'][1]:.2f} mm")
    sch = schraeg(ges)
    if sch:
        hin.append(f"SCHRÄG  {sch[0]:.1f} mm² Überhang flacher als 45° bei z {sch[1]:.2f}–{sch[2]:.2f} mm")
    if mv > 0 and r["vol"] / mv < a.duenn:
        hin.append(f"DÜNN    nur {100 * r['vol'] / mv:.0f} % gedruckt")
    for g in r["gaps"][:3]:
        hin.append(f"LÜCKE   keine Schicht zwischen z {g[0]:.2f} und {g[1]:.2f}")
    area, h = r["flaeche"], r["hoehe"]
    if area < 4:
        hin.append(f"AUFLAGE erste Schicht nur {area:.1f} mm²")
    elif h / math.sqrt(area) > 8:
        hin.append(f"AUFLAGE {h:.0f} mm hoch auf {area:.0f} mm² – kippt leicht, mit Brim drucken")
    # Farbteile einzeln: zu dünne Farbdetails
    if len(files) > 1:
        for f, m in zip(files, meshes):
            m = m.copy(); m.apply_translation([0, 0, -m.bounds[0][2]])
            rf = slice_mesh(m, f[:-4])
            if "fehler" in rf:
                hin.append(f"FEHLER  {f}: {rf['fehler']}")
            elif abs(m.volume) > 0 and rf["vol"] / abs(m.volume) < a.duenn:
                hin.append(f"DÜNN    {f}: nur {100 * rf['vol'] / abs(m.volume):.0f} % gedruckt")
    return teil, hin, sek(r["zeit"])


files = sorted(f for f in os.listdir(a.ordner) if f.lower().endswith(".stl"))
gruppen, gesehen = {}, set()
for f in files:
    base = f[:-4].split("__")[0]
    m = re.search(r"_([A-E])$", base)
    key = (teil_of(f), m.group(1) if m else "")
    if key in gesehen:          # gleiche Geometrie in anderer Farbe (z. B. Wagen je Farbe) nur einmal
        continue
    gesehen.add(key)
    gruppen.setdefault(teil_of(f), []).append(f)
# Geteilte Teile (podest_1, podest_2 …): farb_export.py fasst gleiche Farbteile zusammen (z. B. podest_1_B für beide
# Stücke). Fehlt einem Stück ein Farbteil, das ein Geschwister-Stück hat, wird es mit gesliced – sonst wirken Inlay-Nuten leer.
def farbteil(f):
    m = re.search(r"_([A-E])$", f[:-4].split("__")[0]); return m.group(1) if m else ""
for teil, fl in gruppen.items():
    m = re.match(r"^(.+)_(\d+)$", teil)
    if not m: continue
    da = {farbteil(f) for f in fl}
    for t2, fl2 in gruppen.items():
        if t2 != teil and re.match(r"^%s_\d+$" % re.escape(m.group(1)), t2):
            for f2 in fl2:
                if farbteil(f2) not in da and farbteil(f2) != "":
                    fl.append(f2); da.add(farbteil(f2))
with ThreadPoolExecutor(max_workers=a.jobs) as ex:
    res = list(ex.map(lambda kv: pruefe(*kv), sorted(gruppen.items())))
out, n, tz = [], 0, 0
for teil, hin, s in res:
    tz += s
    out.append(f"{teil:24s} {s // 3600:2d}h{s % 3600 // 60:02d}m  " + ("ok" if not hin else hin[0]))
    out += [" " * 33 + x for x in hin[1:]]
    n += len(hin)
out.append(f"{a.ordner}: {len(gruppen)} Bauteile, Druckzeit (1 Stück je Teil, 100 % Füllung) ca. {tz // 3600} h {tz % 3600 // 60} min, Slicing-Hinweise: {n}")
open(os.path.join(os.path.dirname(os.path.abspath(a.ordner)), "slicen_" + os.path.basename(os.path.abspath(a.ordner)) + ".txt"), "w").write("\n".join(out) + "\n")
print("\n".join(out))
shutil.rmtree(tmp, ignore_errors=True)
