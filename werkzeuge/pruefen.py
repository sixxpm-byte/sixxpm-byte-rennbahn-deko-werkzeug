#!/usr/bin/env python3
"""pruefen.py – prüft alle STL eines Ausgabeordners: wasserdicht, passt aufs Bett,
nichts unter z = 0. Gibt nur Probleme und eine Summenzeile aus.

  python3 werkzeuge/pruefen.py ausgabe/raupenbahn/STL_1-43 [--bett 210]
"""
import glob, os, sys
import trimesh
d = sys.argv[1]
bett = float(sys.argv[sys.argv.index("--bett") + 1]) if "--bett" in sys.argv else 210.0
bad = 0
fs = sorted(glob.glob(os.path.join(d, "*.stl")))
for f in fs:
    m = trimesh.load(f); s = m.bounds[1] - m.bounds[0]
    ok = m.is_watertight and max(s[0], s[1]) <= bett + 0.01 and m.bounds[0][2] > -0.01
    if not ok:
        bad += 1; print("PROBLEM", os.path.basename(f), s.round(1).tolist(), "dicht" if m.is_watertight else "UNDICHT", round(m.bounds[0][2], 2))
print(f"{d}: {len(fs)} STL, Probleme: {bad}")
