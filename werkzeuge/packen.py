#!/usr/bin/env python3
"""packen.py – baut das Bausatz-Zip eines Modells:
   <modell>/  <modell>.scad (Einzeldatei), farb_export.py, LIESMICH.txt,
              STL_1-43/, STL_1-87/ (aus ausgabe/<modell>/), <modell>_anleitung*.pdf (falls vorhanden, auch je Maßstab)

  python3 werkzeuge/packen.py raupenbahn            -> ausgabe/raupenbahn_bausatz.zip
Erwartet: modelle/<modell>/<modell>.scad, modelle/<modell>/LIESMICH.txt,
          ausgabe/<modell>/STL_1-*/ und optional ausgabe/anleitungen/<modell>_anleitung.pdf
"""
import glob, os, sys, zipfile
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
m = sys.argv[1]
z = os.path.join(ROOT, "ausgabe", f"{m}_bausatz.zip")
files = [(os.path.join(ROOT, "modelle", m, f"{m}.scad"), f"{m}.scad"),
         (os.path.join(ROOT, "werkzeuge", "farb_export.py"), "farb_export.py"),
         (os.path.join(ROOT, "modelle", m, "LIESMICH.txt"), "LIESMICH.txt")]
files += [(f, os.path.basename(f)) for f in sorted(glob.glob(os.path.join(ROOT, "ausgabe", "anleitungen", f"{m}_anleitung*.pdf")))]
for d in sorted(glob.glob(os.path.join(ROOT, "ausgabe", m, "STL_1-*"))):
    for f in sorted(glob.glob(d + "/*")):
        files.append((f, os.path.join(os.path.basename(d), os.path.basename(f))))
with zipfile.ZipFile(z, "w", zipfile.ZIP_DEFLATED) as zf:
    n = 0
    for src, arc in files:
        if os.path.isfile(src): zf.write(src, os.path.join(m, arc)); n += 1
        elif not src.endswith(".pdf"): print("fehlt:", src)
print(z, n, "Dateien,", os.path.getsize(z) // 1024, "KB")
