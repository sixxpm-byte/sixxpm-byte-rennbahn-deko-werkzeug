#!/usr/bin/env python3
"""bauen.py – Lego-Anleitung(en) als PDF bauen.

  python3 anleitung/bauen.py raupenbahn [weitere ...]   -> ausgabe/anleitungen/<name>_anleitung.pdf
  python3 anleitung/bauen.py gartenhaus@87               -> ausgabe/anleitungen/gartenhaus_anleitung_1-87.pdf
                                                         (Maßstab nur bei Modellen, deren model() ihn annimmt)
  Optionen: --kerne N (parallele Renders, Standard = Prozessorkerne)
Jedes Modell braucht anleitung/m_<name>.py (Teile, Schritte, Texte) und
anleitung/scad/anl_<name>.scad (Bauschritt-Szene mit Parameter schritt).
"""
import os, sys, importlib
HIER = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, HIER)
from anl import build
a = sys.argv[1:]; kerne = os.cpu_count() or 2
if "--kerne" in a: i = a.index("--kerne"); kerne = int(a[i + 1]); del a[i:i + 2]
out = os.path.join(os.path.dirname(HIER), "ausgabe", "anleitungen"); os.makedirs(out, exist_ok=True)
for arg in a:
    name, _, mst = arg.partition("@")
    mod = importlib.import_module("m_" + name)
    m = mod.model(int(mst)) if mst else mod.model()
    build(m, os.path.join(out, f"{name}_anleitung" + (f"_1-{mst}" if mst else "") + ".pdf"), workers=kerne)
