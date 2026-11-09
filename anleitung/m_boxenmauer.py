from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"bm{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def model(mst=43):
    scad = MOD("boxenmauer")
    A = ANL("anl_boxenmauer")
    D = [f"massstab={mst}"]
    log = echo(scad, mst)
    m = re.search(r"Element ([\d.]+) mm lang", log); el = float(m.group(1)) if m else 0
    andere = 87 if mst == 43 else 43
    names = {"mauer": "Mauerelement", "zaunfeld": "Fangzaun", "verbinder": "Clips", "podest": "Podest", "treppe": "Treppe",
             "pult": "Pult", "monitore": "Monitorleiste", "hocker": "Hockerreihe", "seitenwand": "Seitenwand + Glas",
             "gelaender": "Geländer hinten", "dach": "Dach", "banner": "Teamschild"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"mauer": "aufrecht, Clip-Taschen unten", "zaunfeld": "liegend, Knickteil steigt schräg auf", "verbinder": "flach",
            "podest": "kopfüber (Deck unten)", "treppe": "liegt flach, Handlauf unten", "pult": "liegt auf der Frontplatte",
            "monitore": "flach, Bildschirme unten", "hocker": "stehend auf der Schiene", "seitenwand": "flach; Scheibe flach",
            "gelaender": "liegt flach", "dach": "kopfüber", "banner": "flach, Schrift unten"}
    for p in parts:
        if p["id"] in lage: p["info"] = lage[p["id"]]
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VB, VS = "0,0,0,62,0,35,0", "0,0,0,62,0,320,0"
    def S(n, cam=VB, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    steps = [
        dict(title="Mauer und Fangzaun", parts=P("mauer", "zaunfeld", "verbinder"),
             text=["Mauerelemente Ende an Ende stellen, Clip von unten in die Taschen drücken.",
                   "Zaunfelder mit den Zungen in die Mauerkrone stecken (Knick zur Strecke)."], render=S(1, "0,0,0,62,0,210,0")),
        dict(title="Podest und Treppe", parts=P("podest", "treppe"),
             text=["Podest an den Mauerfuß schieben, zwei Clips von unten in die Taschen.",
                   "Treppe mit der Zunge hinten ins Podest stecken."], render=S(2)),
        dict(title="Pult, Monitore, Hocker", parts=P("pult", "monitore", "hocker"),
             text=["Pult vorne ins Podest stecken, Monitorleiste in die Tischplatte.",
                   "Hockerreihe mit der Schiene in die Nut drücken."], render=S(3)),
        dict(title="Seitenwände und Geländer", parts=P("seitenwand", "gelaender"),
             text=["Glasscheiben von der flachen Seite in die Wände drücken.",
                   "Seitenwände und Geländer in die Schlitze des Podests stecken."], render=S(4, VS),
             inset=dict(scad=A, cam="0,0,0,70,0,20,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True), inset_txt="Glasscheibe"),
        dict(title="Dach und Teamschild", parts=P("dach", "banner"),
             text=["Dach auf die Zungen der Seitenwände drücken.",
                   "Teamschild mit der Schrift zur Strecke aufs Dach stecken."], render=S(5, VS)),
    ]
    extra = f"In 1:{andere} sind die Bauschritte gleich."
    return dict(
        title="Boxenmauer mit Kommandostand", cover_note="FDM, alle Teile stützfrei", subtitle="Mauer mit Fangzaun, verlängerbar, dazu der Kommandostand des Teams",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,62,0,35,0", defs=D, size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,68,0,200,0", defs=D, size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,35,0", defs=D + ['teil="explosion"', "elemente=2"], size=(1400, 1000), auto=True)],
        material=material([f"Ein Mauerelement ist in 1:{mst} ca. {el / 10:.1f} cm lang – beliebig viele aneinander",
                           "Kein Zubehör, kein Kleber"]),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Glasscheiben der Seitenwände werden gesteckt; Werbefläche, Bildschirme und Schrift sind Farbzonen (AMS/MMU) – einfarbig einfach weglassen",
                     "Passung im Customizer: einsatz_spiel (Zungen, Schiene, Glas), spiel (Clips)",
                     "Fangzaun: feines Geflecht – 0,12–0,16 mm Schichthöhe"]),
        system=["Mauerelemente: an beiden Enden dieselbe Schwalbenschwanz-Tasche, ein Clip von unten verbindet sie – wie beim Rennbahn-Deko-Set.",
                "Der Kommandostand hängt mit zwei Clips am Mauerfuß.",
                "Alles andere wird gesteckt: Zungen in Schlitze, die Hockerschiene in eine Nut, Glas in den Falz."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Boxenmauer", "boxenmauer.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Tipps",
        final=["Im Customizer: Anzahl der Plätze (2–8), Text des Teamschilds (banner_text), Zaunhöhe und Knickwinkel, alle Farben.",
               "Für eine lange Boxenmauer einfach weitere Mauerelemente und Zaunfelder drucken.",
               "Der Kommandostand passt an jedes Mauerelement (Clip-Taschen auf der Boxenseite)."])
