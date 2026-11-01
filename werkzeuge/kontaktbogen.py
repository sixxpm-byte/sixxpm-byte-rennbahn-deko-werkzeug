#!/usr/bin/env python3
"""kontaktbogen.py – viele Bilder/STL/PDF-Seiten auf EIN kleines Übersichtsbild
(spart Kontrollschritte: ein Bild statt vieler).

  python3 werkzeuge/kontaktbogen.py bogen.png bild1.png bild2.png ...      # PNGs
  python3 werkzeuge/kontaktbogen.py bogen.png --stl ordner/*.stl            # STL-Vorschauen
  python3 werkzeuge/kontaktbogen.py bogen.png --pdf anleitung.pdf           # PDF-Seiten
  Optionen: --spalten 4  --breite 450
"""
import glob, os, subprocess, sys, tempfile
from PIL import Image, ImageDraw
a = sys.argv[1:]; out = a.pop(0)
def opt(k, d):
    if k in a: i = a.index(k); v = a[i + 1]; del a[i:i + 2]; return v
    return d
cols = int(opt("--spalten", 4)); W = int(opt("--breite", 450))
tmp = tempfile.mkdtemp(); imgs = []
if "--pdf" in a:
    a.remove("--pdf"); subprocess.run(["pdftoppm", "-r", "45", "-png", a[0], tmp + "/p"])
    imgs = [(f, os.path.basename(f)[:-4]) for f in sorted(glob.glob(tmp + "/p*.png"))]
elif "--stl" in a:
    a.remove("--stl")
    for f in a:
        p = os.path.join(tmp, os.path.basename(f) + ".png"); s = p + ".scad"
        open(s, "w").write(f'color("#c8b89a") import("{os.path.abspath(f)}");')
        subprocess.run(["xvfb-run", "-a", "openscad", "-o", p, "--imgsize=600,470", "--colorscheme=Tomorrow", "--projection=p",
                        "--viewall", "--autocenter", "--camera=0,0,0,55,0,25,0", s], capture_output=True)
        imgs.append((p, os.path.basename(f)[:-4]))
else:
    imgs = [(f, os.path.basename(f)[:-4]) for f in a]
imgs = [(f, n) for f, n in imgs if os.path.exists(f)]
ims = [Image.open(f).convert("RGB") for f, _ in imgs]
H = max(int(W * im.size[1] / im.size[0]) for im in ims)
rows = (len(ims) + cols - 1) // cols
S = Image.new("RGB", (W * cols, H * rows), "white"); d = ImageDraw.Draw(S)
for k, (im, (_, n)) in enumerate(zip(ims, imgs)):
    im = im.resize((W, int(W * im.size[1] / im.size[0]))); x, y = (k % cols) * W, (k // cols) * H
    S.paste(im, (x, y)); d.text((x + 6, y + 4), n[:40], fill="black")
S.save(out); print(out, len(ims), "Bilder", S.size)
