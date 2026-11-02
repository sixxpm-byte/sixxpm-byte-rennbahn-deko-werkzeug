#!/usr/bin/env python3
"""Bebilderte Druck- und Aufbauanleitungen (Lego-Stil) für die Deko-Bausätze."""
import os, re, sys, subprocess, hashlib, json, concurrent.futures as cf
from reportlab.lib.pagesizes import A4, landscape
from reportlab.pdfgen import canvas
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.lib.colors import HexColor, white, black
from reportlab.lib.utils import ImageReader
from PIL import Image

W = os.environ.get("DEKO_CACHE", os.path.join(os.path.expanduser("~"), ".cache", "deko_anleitung"))   # Zwischenspeicher für Renders
os.makedirs(W, exist_ok=True)
FD = "/usr/share/fonts/truetype/liberation/"
pdfmetrics.registerFont(TTFont("S", FD + "LiberationSans-Regular.ttf"))
pdfmetrics.registerFont(TTFont("SB", FD + "LiberationSans-Bold.ttf"))
PW, PH = landscape(A4)
BLAU = HexColor("#1f5fa8"); GELB = HexColor("#ffcf1a"); HELL = HexColor("#e3eef8"); GRAU = HexColor("#5a6470"); ROT = HexColor("#d23a2a")

def h(s): return hashlib.md5(s.encode()).hexdigest()[:12]

def run(cmd):
    return subprocess.run(cmd, capture_output=True, text=True)

def xvfb(cmd):
    return run(["xvfb-run", "-a"] + cmd)

# ---------------------------------------------------------------- Rendering
def stl(scad, defs):
    f = os.path.join(W, "p_" + h(scad + "|".join(defs)) + ".stl")
    if not os.path.exists(f):
        r = run(["openscad", "-o", f] + sum([["-D", d] for d in defs], []) + [scad])
        if not os.path.exists(f):
            print("STL FEHLT", scad, defs, r.stderr[-400:]); return None
    return f

def thumb(items, size=(1100, 880), cam="0,0,0,55,0,25,0"):
    """items = [(stlpfad, farbe)] -> PNG (alle Teile zusammen, Druckorientierung)"""
    items = [i for i in items if i[0]]
    key = h(json.dumps(items) + cam + str(size))
    png = os.path.join(W, "t_" + key + ".png")
    if not os.path.exists(png) and items:
        sc = os.path.join(W, "t_" + key + ".scad")
        open(sc, "w").write("\n".join(f'color("{c}") import("{p}", convexity = 10);' for p, c in items))
        xvfb(["openscad", "-o", png, f"--imgsize={size[0]},{size[1]}", "--colorscheme=Tomorrow", "--projection=p",
              "--viewall", "--autocenter", f"--camera={cam}", sc])
    return png if os.path.exists(png) else None

AUTO_ZOOM = 2.0   # --viewall lässt viel Rand: doppelt so groß rendern, crop() schneidet zu -> scharfe Bilder in der PDF
def render(scad, defs, cam, size=(1500, 1100), autoview=False):
    if autoview: size = (min(3200, int(size[0] * AUTO_ZOOM)), min(3200, int(size[1] * AUTO_ZOOM)))
    key = h(scad + "|".join(defs) + str(cam) + str(size) + str(autoview) + str(os.path.getmtime(scad)))
    png = os.path.join(W, "r_" + key + ".png")
    if not os.path.exists(png):
        cmd = ["openscad", "-o", png, f"--imgsize={size[0]},{size[1]}", "--colorscheme=Tomorrow", "--projection=p", f"--camera={cam}"]
        if autoview: cmd += ["--viewall", "--autocenter"]
        r = xvfb(cmd + sum([["-D", d] for d in defs], []) + [scad])
        if not os.path.exists(png): print("RENDER FEHLT", scad, defs, r.stderr[-600:])
    return png if os.path.exists(png) else None

def crop(png, pad=24):
    """weißen Rand abschneiden (Hintergrund Tomorrow #f8f8f8)"""
    if not png: return None
    out = png[:-4] + "_c.png"
    if os.path.exists(out): return out
    im = Image.open(png).convert("RGB")
    bg = Image.new("RGB", im.size, im.getpixel((2, 2)))
    from PIL import ImageChops
    diff = ImageChops.difference(im, bg).convert("L").point(lambda v: 255 if v > 12 else 0)
    bb = diff.getbbox()
    if bb:
        bb = (max(0, bb[0] - pad), max(0, bb[1] - pad), min(im.size[0], bb[2] + pad), min(im.size[1], bb[3] + pad))
        im = im.crop(bb)
    if max(im.size) > 2000: im.thumbnail((2000, 2000), Image.LANCZOS)   # reicht für A4 quer, hält die PDF klein
    im.save(out)
    return out

# ---------------------------------------------------------------- DRUCK-Zeilen (neuere Modelle)
def druck_parts(scad, defs, names=None, skip=()):
    r = run(["openscad", "-o", os.path.join(W, "x.csg")] + sum([["-D", d] for d in defs + ['teil="none"']], []) + [scad])
    rows = [l.split('"')[1].split("|")[1:] for l in r.stderr.splitlines() if l.startswith('ECHO: "DRUCK|')]
    hexes = dict(l.split('"')[1].split("|")[1:3] for l in r.stderr.splitlines() if l.startswith('ECHO: "FARBE|'))
    labels = {}
    m = re.search(r'^teil = "[^"]*"; // \[(.*)\]', open(scad).read(), re.M)
    if m:
        for it in m.group(1).split(", "):
            if ":" in it: k, v = it.split(":", 1); labels[k] = v
    parts, order = {}, []
    for teil, n, fp, farbe, menge in rows:
        if teil in skip: continue
        if teil not in parts:
            parts[teil] = dict(id=teil, name=(names or {}).get(teil, labels.get(teil, teil)), pieces=int(n), exports=[], count=0, colors=[])
            order.append(teil)
        p = parts[teil]
        d = defs + [f'teil="{teil}"', "stueck=0"] + ([f'farbteil="{fp}"'] if fp != "alle" else [])
        hx = hexes.get(farbe, farbe)
        if fp in [e[2] for e in p["exports"]]:            # weitere Farbvariante desselben Farbteils
            p["variants"] = p.get("variants", []) + [(farbe, int(menge))]
            p["count"] += int(menge) if fp in ("A", "alle") else 0
            if (farbe, hx) not in p["colors"]: p["colors"].append((farbe, hx))
            continue
        p["exports"].append((d, hx, fp))
        p["colors"].append((farbe, hx))
        if fp in ("A", "alle"): p["count"] += int(menge)
    return [parts[t] for t in order], hexes

# ---------------------------------------------------------------- PDF
class Doc:
    def __init__(self, path, model):
        self.c = canvas.Canvas(path, pagesize=(PW, PH))
        self.c.setTitle(model["title"]); self.c.setAuthor("Rennbahn-Deko"); self.m = model; self.page = 0

    def footer(self):
        self.page += 1
        c = self.c
        c.setFillColor(BLAU); c.rect(0, 0, PW, 20, stroke=0, fill=1)
        c.setFillColor(white); c.setFont("S", 8.5)
        c.drawString(24, 7, f"{self.m['title']}  ·  Maßstab {self.m['scale_txt']}")
        c.drawRightString(PW - 24, 7, str(self.page))

    def header(self, title):
        c = self.c
        c.setFillColor(GELB); c.rect(0, PH - 46, PW, 46, stroke=0, fill=1)
        c.setFillColor(black); c.setFont("SB", 20); c.drawString(28, PH - 32, title)

    def img(self, png, x, y, w, hgt, align="c"):
        if not png: return
        im = ImageReader(png); iw, ih = im.getSize()
        s = min(w / iw, hgt / ih); dw, dh = iw * s, ih * s
        ox = x + (w - dw) / 2; oy = y + (hgt - dh) / 2
        self.c.drawImage(im, ox, oy, dw, dh, mask="auto")
        return (ox, oy, dw, dh)

    def para(self, txt, x, y, w, font="S", size=10.5, lead=None, color=black):
        c = self.c; lead = lead or size * 1.32; c.setFont(font, size); c.setFillColor(color)
        for raw in txt.split("\n"):
            words, line = raw.split(" "), ""
            for wd in words:
                t = (line + " " + wd).strip()
                if pdfmetrics.stringWidth(t, font, size) > w and line:
                    c.drawString(x, y, line); y -= lead; line = wd
                else: line = t
            c.drawString(x, y, line); y -= lead
        return y

    def bullets(self, items, x, y, w, size=10.5):
        for it in items:
            self.c.setFillColor(BLAU); self.c.circle(x + 3, y + 3.5, 2.6, stroke=0, fill=1)
            y = self.para(it, x + 12, y, w - 12, size=size) - 3
        return y

    def newpage(self): self.footer(); self.c.showPage()

    # ------------------------------------------------ Seiten
    def cover(self):
        c, m = self.c, self.m
        c.setFillColor(HexColor("#f8f8f8")); c.rect(0, 0, PW, PH, stroke=0, fill=1)
        self.img(m["cover_png"], 20, 120, PW - 40, PH - 140)
        c.setFillColor(BLAU); c.rect(0, 0, PW, 112, stroke=0, fill=1)
        c.setFillColor(GELB); c.rect(0, 112, PW, 6, stroke=0, fill=1)
        c.setFillColor(white); c.setFont("SB", 34); c.drawString(30, 62, m["title"])
        c.setFont("S", 14); c.drawString(32, 36, m["subtitle"])
        c.setFont("SB", 13); c.drawRightString(PW - 30, 70, "Druck- und Aufbauanleitung")
        c.setFont("S", 11.5)
        c.drawRightString(PW - 30, 50, f"Maßstab {m['scale_txt']}  ·  {m['n_prints']} Druckteile")
        c.drawRightString(PW - 30, 33, "FDM, ohne Stützmaterial")
        c.showPage(); self.page += 1

    def vorbereitung(self):
        c, m = self.c, self.m
        self.header("Bevor du beginnst")
        col = (PW - 3 * 28) / 2
        x1, x2, y0 = 28, 28 * 2 + col, PH - 78
        c.setFillColor(BLAU); c.setFont("SB", 13.5); c.drawString(x1, y0, "Das brauchst du")
        y = self.bullets(m["material"], x1, y0 - 20, col)
        c.setFillColor(BLAU); c.setFont("SB", 13.5); c.drawString(x1, y - 8, "Druckeinstellungen")
        y = self.bullets(m["druck"], x1, y - 28, col)
        c.setFillColor(BLAU); c.setFont("SB", 13.5); c.drawString(x2, y0, "So funktioniert der Bausatz")
        y2 = self.bullets(m["system"], x2, y0 - 20, col)
        if m.get("clip_png"):
            box = self.img(m["clip_png"], x2, max(40, y2 - 175), col, 160)
        c.setFillColor(HELL); c.roundRect(x1, 30, PW - 56, 46, 8, stroke=0, fill=1)
        self.para(m["massstab_hinweis"], x1 + 12, 60, PW - 80, size=9.8, color=GRAU)
        self.newpage()

    def druckliste(self, parts):
        c = self.c
        per_row, rows = 4, 3
        cw, chh = (PW - 56 - 3 * 12) / 4, (PH - 46 - 30 - 40 - 2 * 12) / 3
        for pi in range(0, len(parts), per_row * rows):
            self.header("Druckliste" + ("" if pi == 0 else " (Fortsetzung)"))
            c.setFont("S", 10); c.setFillColor(GRAU)
            c.drawRightString(PW - 28, PH - 31, "So ausgerichtet drucken, wie abgebildet (Datei ist schon gedreht)")
            for k, p in enumerate(parts[pi:pi + per_row * rows]):
                x = 28 + (k % per_row) * (cw + 12); y = PH - 60 - (k // per_row + 1) * (chh + 12) + 12
                c.setFillColor(white); c.setStrokeColor(HexColor("#c9d3dd")); c.roundRect(x, y, cw, chh, 7, stroke=1, fill=1)
                self.img(p.get("thumb"), x + 6, y + 44, cw - 12, chh - 70)
                c.setFillColor(black); c.setFont("SB", 10.5)
                nm = p["name"]
                while pdfmetrics.stringWidth(nm, "SB", 10.5) > cw - 60: nm = nm[:-2]
                c.drawString(x + 9, y + chh - 16, nm if nm == p["name"] else nm + "…")
                c.setFillColor(BLAU); c.setFont("SB", 17); c.drawRightString(x + cw - 9, y + chh - 19, f"{p['count']}×")
                fs = 8.5 if len(p["colors"]) <= 3 else 7.5
                yy = y + 30; xx = x + 9
                for fname, hx in p["colors"]:
                    wdt = 13 + pdfmetrics.stringWidth(fname, "S", fs) + 7
                    if xx + wdt > x + cw - 4: xx = x + 9; yy -= 11
                    c.setFillColor(HexColor(hx)); c.setStrokeColor(GRAU); c.circle(xx + 4.5, yy + 3, 4.3, stroke=1, fill=1)
                    c.setFillColor(black); c.setFont("S", fs); c.drawString(xx + 11, yy, fname); xx += wdt
                c.setFont("S", 8); c.setFillColor(GRAU)
                info = p.get("info") or (f"{p['pieces']} Druckstücke je Teil + Clips" if p.get("pieces", 1) > 1 else "")
                c.drawString(x + 9, y + 7, info[:60])
            self.newpage()

    def step_box(self, st, x, y, w, hgt, parts_by_id):
        c = self.c
        c.setFillColor(BLAU); c.setFont("SB", 40); c.drawString(x, y + hgt - 40, str(st["nr"]))
        # Teile-Kasten
        used = [(parts_by_id[i], n) for i, n in st.get("parts", []) if i in parts_by_id]
        bx, by = x + 62, y + hgt - 92
        if used:
            tw = min(74, (w - 62 - 14) / len(used) - 8); bw = min(w - 62, 14 + len(used) * (tw + 8))
            c.setFillColor(HELL); c.setStrokeColor(HexColor("#9fc0e0")); c.roundRect(bx, by, bw, 90, 7, stroke=1, fill=1)
            for k, (p, n) in enumerate(used):
                tx = bx + 8 + k * (tw + 8)
                self.img(p.get("thumb"), tx, by + 20, tw, 64)
                c.setFillColor(black); c.setFont("SB", 11); c.drawCentredString(tx + tw / 2, by + 6, f"{n}×")
        # Bild
        top = (by - 8) if used else (y + hgt - 50)
        ty = y + 8 + 14 * (len(st.get("text", [])) + 1)
        self.img(st.get("png"), x, ty, w, top - ty)
        if st.get("inset_png"):
            iw, ih = w * 0.36, (top - ty) * 0.42
            ix, iy = x + w - iw, ty
            c.setFillColor(white); c.setStrokeColor(BLAU); c.setLineWidth(1.5); c.roundRect(ix, iy, iw, ih, 6, stroke=1, fill=1); c.setLineWidth(1)
            self.img(st["inset_png"], ix + 4, iy + 4, iw - 8, ih - 20)
            c.setFillColor(BLAU); c.setFont("SB", 8.5); c.drawString(ix + 7, iy + ih - 12, st.get("inset_txt", "Detail"))
        # Text
        yy = ty - 6
        c.setFillColor(black); c.setFont("SB", 11.5); c.drawString(x, yy, st["title"]); yy -= 16
        for t in st.get("text", []):
            yy = self.para("• " + t, x, yy, w, size=10) - 1

    def schritte(self, steps, parts_by_id):
        i = 0
        while i < len(steps):
            st = steps[i]
            self.header("Aufbau")
            if st.get("full") or i + 1 >= len(steps) or steps[i + 1].get("full"):
                self.step_box(st, 28, 30, PW - 56, PH - 46 - 40, parts_by_id); i += 1
            else:
                cw = (PW - 56 - 24) / 2
                self.step_box(st, 28, 30, cw, PH - 46 - 40, parts_by_id)
                c = self.c; c.setStrokeColor(HexColor("#c9d3dd")); c.line(28 + cw + 12, 40, 28 + cw + 12, PH - 60)
                self.step_box(steps[i + 1], 28 + cw + 24, 30, cw, PH - 46 - 40, parts_by_id); i += 2
            self.newpage()

    def schluss(self):
        c, m = self.c, self.m
        self.header("Fertig!")
        imgs = m.get("final_pngs", [])
        n = len(imgs)
        if n:
            w = (PW - 56 - (n - 1) * 12) / n
            for k, p in enumerate(imgs): self.img(p, 28 + k * (w + 12), 190, w, PH - 46 - 200)
        c.setFillColor(BLAU); c.setFont("SB", 13.5); c.drawString(28, 166, m.get("final_title", "Beweglich & Tipps"))
        self.bullets(m.get("final", []), 28, 146, PW - 56)
        self.newpage()

    def save(self): self.c.save()


def build(model, out_pdf, workers=8):
    parts = model["parts"]
    # Teile-Bilder
    def mk(p):
        items = [(stl(model["scad"], d), hx) for d, hx, *_ in p["exports"]]
        p["thumb"] = crop(thumb(items))
        return p["id"]
    with cf.ThreadPoolExecutor(workers) as ex:
        for r in ex.map(mk, parts): pass
    pb = {p["id"]: p for p in parts}
    # Schrittbilder
    def rs(st):
        for key, out in (("render", "png"), ("inset", "inset_png")):
            if key in st:
                r = st[key]
                st[out] = crop(render(r["scad"], r.get("defs", []), r["cam"], r.get("size", (1500, 1100)), r.get("auto", False)))
        return st["nr"]
    for k, st in enumerate(model["steps"]): st["nr"] = k + 1
    jobs = list(model["steps"]) + [dict(nr=0, render=x) for x in [model["cover"]] + model.get("final_renders", [])]
    with cf.ThreadPoolExecutor(workers) as ex:
        for r in ex.map(rs, jobs): pass
    model["cover_png"] = jobs[len(model["steps"])].get("png")
    model["final_pngs"] = [j.get("png") for j in jobs[len(model["steps"]) + 1:]]
    model["n_prints"] = sum(p["count"] * max(1, p.get("pieces", 1)) for p in parts)
    d = Doc(out_pdf, model)
    d.cover(); d.vorbereitung(); d.druckliste(parts); d.schritte(model["steps"], pb); d.schluss(); d.save()
    print("PDF:", out_pdf, d.page, "Seiten")
