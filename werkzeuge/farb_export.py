#!/usr/bin/env python3
"""
farb_export.py – exportiert alle Druckteile eines Deko-Modells mit Farben.

Liest die Zeilen  DRUCK|teil|stücke|farbteil|farbe|menge  und
                  FARBE|name|#rrggbb
aus der OpenSCAD-Konsole und erzeugt im Ausgabeordner:
  * eine STL je Teil und Farbe, Dateiname mit Farbe:  dach__rot.stl
    (gleiche Stücke werden zusammengefasst, die Menge steht in der Liste)
  * Farbliste.txt – nach Farben sortiert, mit Stückzahlen
  * <modell>_farbig.3mf – alle Teile mit Farbe (basematerials/displaycolor);
    mehrfarbige Teile (farbteil A + B) als ein Objekt mit zwei Teilen.
    Bambu Studio ordnet die Farben beim Import den Filamenten zu; in anderen
    Slicern steht die Farbe zumindest im Objektnamen.

Aufruf:
  python3 farb_export.py kettenkarussell.scad 43 ausgabe_1-43
  python3 farb_export.py raupenbahn.scad 43 ausgabe_1-43 --nur mittelbau_wand,kuppel
      (nur diese Teile neu rechnen, alle anderen aus dem Zwischenspeicher
       ausgabe_1-43/.cache des letzten Laufs – Farbliste und 3MF werden komplett neu gebaut)
  python3 farb_export.py kettenkarussell.scad 87 ausgabe_h0 -D 'farbe_dach_1="blau"'

Voraussetzung: OpenSCAD im PATH (oder Umgebungsvariable OPENSCAD), Python 3
mit numpy und trimesh  (pip install trimesh numpy).
"""
import os, re, sys, subprocess, zipfile, tempfile, concurrent.futures as cf
import numpy as np
import trimesh

OPENSCAD = os.environ.get("OPENSCAD", "openscad")


def run_scad(scad, defs, out):
    cmd = [OPENSCAD, "-o", out] + sum([["-D", d] for d in defs], []) + [scad]
    r = subprocess.run(cmd, capture_output=True, text=True)
    return r.stderr


def main():
    if len(sys.argv) < 4:
        print(__doc__); sys.exit(1)
    scad, mst, out = os.path.abspath(sys.argv[1]), sys.argv[2], sys.argv[3]
    extra, nur = [], None
    a = sys.argv[4:]
    while a:
        if a[0] == "-D" and len(a) > 1: extra.append(a[1]); a = a[2:]
        elif a[0] == "--nur" and len(a) > 1: nur = set(a[1].split(",")); a = a[2:]
        else: a = a[1:]
    os.makedirs(out, exist_ok=True)
    tmp = tempfile.mkdtemp()
    base = [f"massstab={mst}"] + extra
    log = run_scad(scad, base + ['teil="none"'], os.path.join(tmp, "x.csg"))
    druck = [l.split('"')[1].split("|")[1:] for l in log.splitlines() if l.startswith('ECHO: "DRUCK|')]
    farben = dict(l.split('"')[1].split("|")[1:3] for l in log.splitlines() if l.startswith('ECHO: "FARBE|'))
    if not druck:
        print(log); sys.exit("Keine DRUCK-Zeilen gefunden.")
    modell = os.path.splitext(os.path.basename(scad))[0]

    # 1. Geometrien exportieren (je Teil/Stück/Farbteil einmal)
    geo = {}
    for teil, n, fp, farbe, menge in druck:
        for k in range(1, int(n) + 1):
            geo[(teil, k if int(n) > 1 else 0, fp)] = None
    cache = os.path.join(out, ".cache"); os.makedirs(cache, exist_ok=True)
    def exp(key):
        teil, k, fp = key
        f = os.path.join(cache, f"{teil}_{k}_{fp}.stl")
        if nur is not None and teil not in nur and os.path.exists(f) and os.path.getsize(f) > 0:
            return key, trimesh.load(f)          # unverändert: aus dem Zwischenspeicher
        d = base + [f'teil="{teil}"', f"stueck={k}"] + ([f'farbteil="{fp}"'] if fp != "alle" else [])
        run_scad(scad, d, f)
        return key, (trimesh.load(f) if os.path.exists(f) and os.path.getsize(f) > 0 else None)
    with cf.ThreadPoolExecutor(os.cpu_count() or 4) as ex:
        for key, m in ex.map(exp, geo):
            geo[key] = m
            print("exportiert:", key, "" if m is not None else "(leer)")

    # 2. gleiche Stücke eines Teils zusammenfassen
    def sig(m):   # gleich = deckungsgleich in Druckorientierung (keine Spiegelbilder)
        v = np.round(m.vertices - m.bounds[0], 2)
        v = v[np.lexsort(v.T[::-1])]
        return (len(m.faces), hash(v.tobytes()))
    eintraege = []   # (teil, k, fp, farbe, menge, mesh)
    for teil, n, fp, farbe, menge in druck:
        seen = {}
        for k in ([0] if int(n) == 1 else range(1, int(n) + 1)):
            m = geo[(teil, k, fp)]
            if m is None: continue
            s = sig(m)
            if s in seen: seen[s][1] += 1
            else: seen[s] = [k, 1, m]
        for s, (k, cnt, m) in seen.items():
            eintraege.append((teil, k, fp, farbe, int(menge) * cnt, m))

    # 3. STL-Dateien und Farbliste
    def name(teil, k, fp, farbe):
        return f"{teil}{'_' + str(k) if k else ''}{'_' + fp if fp != 'alle' else ''}__{farbe.replace('#', '')}"
    for f in os.listdir(out):
        if f.endswith(".stl") or f.endswith(".3mf"): os.remove(os.path.join(out, f))
    proFarbe = {}
    for teil, k, fp, farbe, menge, m in eintraege:
        n = name(teil, k, fp, farbe)
        m.export(os.path.join(out, n + ".stl"))
        proFarbe.setdefault(farbe, []).append((menge, n, m.volume))
    with open(os.path.join(out, "Farbliste.txt"), "w", encoding="utf-8") as f:
        f.write(f"{modell} – Maßstab 1:{mst} – Farbliste\n" + "=" * 60 + "\n")
        for farbe, L in sorted(proFarbe.items()):
            vol = sum(q * v for q, v in [(a, c) for a, b, c in L]) / 1000
            f.write(f"\n{farbe.upper()}  ({farben.get(farbe, farbe)})   massiv gerechnet ca. {vol * 1.24:.0f} g PLA\n")
            for menge, n, v in sorted(L, key=lambda x: x[1]):
                f.write(f"  {menge:3d} x  {n}.stl\n")
        f.write("\nMehrfarbige Teile (_A, _B, _C ...) liegen deckungsgleich übereinander:\n"
                "im Slicer beide Dateien als EIN Objekt laden (Teile) und Filamente zuweisen.\n")

    # 4. farbige 3MF
    mats = sorted({e[3] for e in eintraege})
    def col(fn):
        h = farben.get(fn, fn if fn.startswith("#") else "#808080").lstrip("#")
        return "#" + h.upper() + "FF"
    xml = ['<?xml version="1.0" encoding="UTF-8"?>',
           '<model unit="millimeter" xml:lang="de-DE" xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02">',
           f'<metadata name="Title">{modell} 1:{mst}</metadata>', "<resources>", '<basematerials id="1">']
    xml += [f'<base name="{m}" displaycolor="{col(m)}"/>' for m in mats]
    xml.append("</basematerials>")
    oid = [2]
    def mesh_obj(m, nm, farbe):
        i = oid[0]; oid[0] += 1
        v = m.vertices - [m.bounds[0][0], m.bounds[0][1], 0]
        xml.append(f'<object id="{i}" type="model" name="{nm}" pid="1" pindex="{mats.index(farbe)}"><mesh><vertices>')
        xml.append("".join(f'<vertex x="{a:.4f}" y="{b:.4f}" z="{c:.4f}"/>' for a, b, c in v))
        xml.append("</vertices><triangles>")
        xml.append("".join(f'<triangle v1="{a}" v2="{b}" v3="{c}"/>' for a, b, c in m.faces))
        xml.append("</triangles></mesh></object>")
        return i
    objekte = []   # (objektid, menge, breite, tiefe)
    gruppen = {}
    for e in eintraege:
        teil, k, fp, farbe, menge, m = e
        if fp != "alle": gruppen.setdefault((teil, k), []).append(e)
        else:
            objekte.append((mesh_obj(m, name(teil, k, fp, farbe), farbe), menge, m.bounds))
    def comp_obj(e, lo):
        teil, k, fp, farbe, menge, m = e
        i = oid[0]; oid[0] += 1
        v = m.vertices - [lo[0], lo[1], 0]
        xml.append(f'<object id="{i}" type="model" name="{name(teil, k, fp, farbe)}" pid="1" pindex="{mats.index(farbe)}"><mesh><vertices>')
        xml.append("".join(f'<vertex x="{a:.4f}" y="{b:.4f}" z="{c:.4f}"/>' for a, b, c in v))
        xml.append("</vertices><triangles>")
        xml.append("".join(f'<triangle v1="{a}" v2="{b}" v3="{c}"/>' for a, b, c in m.faces))
        xml.append("</triangles></mesh></object>")
        return i
    for (teil, k), L in gruppen.items():
        # je Farbvariante des Grundkörpers (A) ein Objekt, die übrigen Farbteile werden dazugelegt
        basis = [e for e in L if e[2] == "A"] or [L[0]]
        rest, seen = [], set()
        for e in L:
            if e in basis or e[2] in seen: continue
            seen.add(e[2]); rest.append(e)
        lo = np.min([e[5].bounds[0] for e in L], axis=0)
        hi = np.max([e[5].bounds[1] for e in L], axis=0)
        rest_ids = [comp_obj(e, lo) for e in rest]
        for bse in basis:
            ids = [comp_obj(bse, lo)] + rest_ids
            g = oid[0]; oid[0] += 1
            xml.append(f'<object id="{g}" type="model" name="{teil}{"_" + str(k) if k else ""} {bse[3]} (mehrfarbig)"><components>'
                       + "".join(f'<component objectid="{i}"/>' for i in ids) + "</components></object>")
            objekte.append((g, bse[4], np.array([[lo[0], lo[1], 0], hi])))
    xml.append("</resources><build>")
    x = y = zeile = 0.0
    for i, menge, b in sorted(objekte, key=lambda o: -(o[2][1][1] - o[2][0][1])):
        w, d = b[1][0] - b[0][0], b[1][1] - b[0][1]
        for _ in range(menge):
            if x + w > 1200: x = 0; y += zeile + 5; zeile = 0
            xml.append(f'<item objectid="{i}" transform="1 0 0 0 1 0 0 0 1 {x:.2f} {y:.2f} 0"/>')
            x += w + 5; zeile = max(zeile, d)
    xml.append("</build></model>")
    p3 = os.path.join(out, f"{modell}_1-{mst}_farbig.3mf")
    with zipfile.ZipFile(p3, "w", zipfile.ZIP_DEFLATED) as z:
        z.writestr("[Content_Types].xml", '<?xml version="1.0" encoding="UTF-8"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
                   '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
                   '<Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/></Types>')
        z.writestr("_rels/.rels", '<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">'
                   '<Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/></Relationships>')
        z.writestr("3D/3dmodel.model", "\n".join(xml))
    print("fertig:", out, "| Farben:", ", ".join(mats))


if __name__ == "__main__":
    main()
