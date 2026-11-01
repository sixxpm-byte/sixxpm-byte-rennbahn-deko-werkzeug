#!/usr/bin/env python3
"""kollision.py – Kollisionsprüfung im Zusammenbau mit manifold3d (schnell).

Eingabe: Ordner mit STL-Dateien in Weltkoordinaten (je Baugruppe eine Datei,
erzeugt mit kol_export.sh). Ohne Paarliste werden alle Paare geprüft.
Ausgabe: nur Überschneidungen > 0,001 mm³ und eine Summenzeile.

  python3 werkzeuge/kollision.py kol/m43 [paare.txt]
  paare.txt: eine Zeile je Paar, z. B. "wagen0 dach"; '#' = Kommentar
Berührflächen ohne Volumen (Zapfen auf Fläche) melden sich mit ~0,00x mm³ und flacher Box.
"""
import glob, itertools, os, sys
import numpy as np, trimesh
import manifold3d as m3d

def load(f):
    t = trimesh.load(f, force="mesh")
    if len(t.faces) == 0: return None
    return m3d.Manifold(m3d.Mesh(vert_properties=np.asarray(t.vertices, dtype=np.float32), tri_verts=np.asarray(t.faces, dtype=np.uint32)))

d = sys.argv[1]
names = sorted(os.path.basename(f)[:-4] for f in glob.glob(os.path.join(d, "*.stl")))
if len(sys.argv) > 2:
    pairs = [l.split()[:2] for l in open(sys.argv[2]) if l.strip() and not l.startswith("#")]
else:
    pairs = list(itertools.combinations(names, 2))
cache, bad = {}, 0
def g(n):
    if n not in cache: cache[n] = load(os.path.join(d, n + ".stl")) if n in names else None
    return cache[n]
for a, b in pairs:
    A, B = g(a), g(b)
    if A is None or B is None: print("  fehlt/leer:", a if A is None else b); continue
    c = A ^ B; v = c.volume()
    if v > 0.001:
        bad += 1; bb = np.array(c.bounding_box()).round(1).tolist(); print(f"SCHNITT {a} x {b}: {v:.3f} mm3  Box {bb}")
print(f"Paare: {len(pairs)}  Schnitte: {bad}")
