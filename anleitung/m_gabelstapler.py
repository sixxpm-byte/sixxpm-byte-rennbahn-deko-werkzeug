from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"gs{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def werte(log):
    v = {}
    m = re.search(r"bis Gabelrücken ([\d.]+) mm, mit Gabeln ([\d.]+) mm \| Breite ([\d.]+) mm \| Kabine ([\d.]+) mm", log)
    v["laenge"], v["gesamt"], v["breite"], v["hoehe"] = [float(m.group(i)) for i in range(1, 5)] if m else (0, 0, 0, 0)
    return v

def model(mst=43):
    scad = MOD("gabelstapler")
    A = ANL("anl_gabelstapler")
    D = [f"massstab={mst}"]
    v = werte(echo(scad, mst))
    andere = [m for m in (24, 43, 87) if m != mst]
    va = {m: werte(echo(scad, m)) for m in andere}
    names = {"fahrgestell": "Fahrgestell mit Heckteil, Sitz und Trittstufen", "kabine": "Kabine", "glaskern": "Glaskern (transparent)",
             "mast": "Hubmast", "gabeltraeger": "Gabelträger", "kotfluegel_links": "Kotflügel links", "kotfluegel_rechts": "Kotflügel rechts",
             "gabel": "Gabelzinke", "reifen_vorne": "Zwillingsreifen vorne", "reifen_hinten": "Reifen hinten", "felge_vorne": "Felge vorne",
             "felge_hinten": "Felge hinten", "rundumleuchte": "Rundumleuchte", "neigezylinder": "Neigezylinder", "ansaugrohr": "Ansaugrohr mit Luftfilter"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"fahrgestell": "aufrecht – Stützen in den Radkästen hinten und unter den Leuchtengehäusen",
            "kabine": "kopfüber (Dach unten) – Stützen unter Dachüberstand und Lamellen-Blende",
            "glaskern": "kopfüber, unten offen", "mast": "liegt auf der Rückseite", "gabeltraeger": "liegt auf der Vorderseite, Zapfen oben",
            "kotfluegel_links": "liegt auf der Außenseite, Zapfen oben", "kotfluegel_rechts": "liegt auf der Außenseite, Zapfen oben",
            "gabel": "liegt auf der Seite", "reifen_vorne": "liegend, Innenrand unten", "reifen_hinten": "liegend, Innenrand unten",
            "felge_vorne": "liegend", "felge_hinten": "liegend", "rundumleuchte": "kopfüber, Zapfen oben",
            "neigezylinder": "liegt auf der Seite", "ansaugrohr": "kopfüber (Kappe unten), Zapfen oben"}
    for p in parts:
        if p["id"] in lage: p["info"] = lage[p["id"]]
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VH, VV = "0,0,0,64,0,215,0", "0,0,0,64,0,35,0"
    def S(n, cam=VH, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    steps = [
        dict(title="Räder", parts=P("fahrgestell", "reifen_vorne", "reifen_hinten", "felge_vorne", "felge_hinten"),
             text=["Felgen von außen in die Reifen drücken (vorne Zwillingsreifen).",
                   "Räder mit dem Innenrand zum Fahrzeug auf die Rautenzapfen schieben – sie drehen sich."], render=S(1)),
        dict(title="Kotflügel", parts=P("kotfluegel_links", "kotfluegel_rechts"),
             text=["Kotflügel mit den zwei Zapfen seitlich in den schwarzen Vorderteil stecken.",
                   "Der schwarze Spritzlappen zeigt nach vorn."], render=S(2, VV)),
        dict(title="Kabine", parts=P("glaskern", "kabine", "rundumleuchte", "ansaugrohr"),
             text=["Glaskern über den schwarzen Sockel auf Deck und Heckteil drücken, Kabine darüberschieben.",
                   "Rundumleuchte ins Dach, Ansaugrohr hinter der Kabine ins Heckteil stecken."], render=S(3)),
        dict(title="Hubmast", parts=P("mast"),
             text=["Mast mit den zwei Löchern unten auf die Lagerzapfen vorne am Fahrgestell schieben."], render=S(4, VV)),
        dict(title="Neigezylinder", parts=P("neigezylinder"),
             text=["Zapfen hinten ins Dach stecken, das Auge vorne auf den Zapfen am Mastkopf.",
                   "So hält der Mast oben und unten."],
             render=S(5, VV), inset=dict(scad=A, cam="0,0,0,60,0,30,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True), inset_txt="Auge auf dem Mastkopf"),
        dict(title="Gabelträger und Gabeln", parts=P("gabeltraeger", "gabel"),
             text=["Gabelträger mit den Zapfen in eines der vier Lochpaare vorne im Mast stecken.",
                   "Gabeln oben auf die Leiste hängen – sie lassen sich seitlich schieben."], render=S(6, VV)),
    ]
    extra = "Größen in den anderen Maßstäben: " + ", ".join(f"1:{m} ca. {va[m]['gesamt'] / 10:.1f} cm lang (mit Gabeln)" for m in andere) + "."
    return dict(
        title="Gabelstapler 8 t", cover_note="FDM, Stützen an Fahrgestell und Kabine", subtitle="Schwerer Diesel-Stapler mit Vollkabine, Hubmast, Neigezylindern und Zwillingsreifen",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,66,0,35,0", defs=D + ["gabel_stufe=1"], size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,64,0,215,0", defs=D, size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,35,0", defs=D + ['teil="explosion"'], size=(1400, 1000), auto=True)],
        material=material([f"Länge in 1:{mst} ca. {v['gesamt'] / 10:.1f} cm (mit Gabeln), Höhe ca. {v['hoehe'] / 10:.1f} cm",
                           "Transparentes Filament (PETG oder PLA) für den Glaskern"]),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Farbbauteile (Felgen, Glaskern, Kabine, Mast, Gabeln, Reifen, Neigezylinder, Ansaugrohr, Rundumleuchte) werden gesteckt: mit AMS/MMU aus der 3MF oder einfarbig jede STL einzeln",
                     "Farbzonen am Fahrgestell (Trittnische, Schürze, Grill, Leuchten, Sitz) und der Spritzlappen am Kotflügel brauchen AMS/MMU – einfarbig die 3MF mit einem Filament drucken",
                     "Passung im Customizer: einsatz_spiel (Felgen, Glaskern, Kabine), spiel (Zapfen)"],
                    stuetzen="Stützen nur vom Druckbett: Fahrgestell (Radkästen hinten, Leuchtengehäuse, Kupplungsmaul) und Kabine (Dachüberstand, Lamellen-Blende, Türholm als Brücke). Alle anderen Teile drucken stützfrei."),
        system=[f"In 1:{mst} passen alle Teile ungeteilt aufs Druckbett – Clips brauchst du hier nicht.",
                "Räder, Kotflügel, Mast, Gabelträger, Neigezylinder, Rundumleuchte und Ansaugrohr stecken auf Rautenzapfen – die Raute druckt in jeder Lage stützfrei.",
                "Kabine und Glaskern sitzen im Presssitz auf dem Sockel – ohne Kleber abnehmbar."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Gabelstapler", "gabelstapler.scad", extra, mst, bereich="1:24, 1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Die Räder drehen sich auf den Zapfen.",
               "Gabelträger umstecken: vier Hubstufen von ganz unten bis 1,8 m.",
               "Die Gabelzinken seitlich auf der Leiste verschieben – passend zur Palette.",
               "Kabine abziehen: darunter sitzen Fahrersitz, Lenkrad und Armaturen."])
