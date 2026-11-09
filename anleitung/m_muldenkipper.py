from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"mk{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def mm(x): return f"{float(x):.0f}"

def werte(log):
    v = {}
    m = re.search(r"Länge ([\d.]+) x Breite ([\d.]+) mm \| Höhe Schutzdach ([\d.]+) mm", log)
    v["laenge"], v["breite"], v["hoehe"] = (float(m.group(1)), float(m.group(2)), float(m.group(3))) if m else (0, 0, 0)
    m = re.search(r"Kipplager ([\d.]+) mm, Zylinder oben ([\d.]+) mm, unten ([\d.]+) mm", log)
    v["stifte"] = [mm(m.group(i)) for i in range(1, 4)] if m else ["30", "40", "40"]
    return v

def model(mst=43):
    scad = MOD("muldenkipper")
    A = ANL("anl_muldenkipper")
    D = [f"massstab={mst}"]
    v = werte(echo(scad, mst))
    andere = 87 if mst == 43 else 43
    va = werte(echo(scad, andere))
    names = {"rahmen": "Rahmen mit Hinterachse", "vorbau": "Vorbau", "kuehlergrill": "Kühlergrill", "leuchte": "Scheinwerferplatte",
             "rueckleuchte": "Rückleuchte", "achszapfen_vorne": "Achszapfen vorne", "achszapfen_hinten": "Achszapfen hinten", "rad_vorne": "Rad vorne (Reifen + Felge)", "rad_hinten": "Zwillingsrad hinten (Reifen + Felge)",
             "oberdeck": "Oberdeck", "kabine": "Kabine + Glaskern",
             "gelaender_vorne_rechts": "Geländer vorne rechts", "gelaender_vorne_links": "Geländer vorne links",
             "gelaender_seite_rechts": "Geländer Seite rechts", "gelaender_seite_links": "Geländer Seite links",
             "spiegel": "Außenspiegel", "auspuff": "Auspuff", "treppe": "Diagonaltreppe", "leiter": "Leiter",
             "zylinder": "Kippzylinder (Rohr + Stange)", "muldentraeger": "Muldenträger", "mulde": "Mulde", "schutzdach": "Schutzdach"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"rahmen": "aufrecht", "vorbau": "aufrecht", "kuehlergrill": "Rückseite unten, Lamellen oben", "leuchte": "Rückseite unten, Leuchten oben",
            "rueckleuchte": "liegt auf der Unterseite", "achszapfen_vorne": "liegt flach", "achszapfen_hinten": "liegt flach", "rad_vorne": "liegend, Innenrand unten; Felge flach", "rad_hinten": "liegend, Innenrand unten; Felge flach",
            "oberdeck": "flach, Zapfen oben", "kabine": "kopfüber (Dach unten); Glaskern als Block", "spiegel": "liegt flach", "auspuff": "stehend, Loch unten",
            "treppe": "liegt flach, Handlauf unten", "leiter": "liegt flach", "zylinder": "Rohr und Stange liegend, Augen unten",
            "muldentraeger": "liegt flach", "mulde": "aufrecht, Boden unten", "schutzdach": "kopfüber, Zapfen oben"}
    for p in parts:
        i = p["id"]
        if i in lage: p["info"] = lage[i]
        elif i.startswith("gelaender"): p["info"] = "liegt flach"
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VP, VH = "0,0,0,62,0,125,0", "0,0,0,62,0,300,0"
    def S(n, cam=VP, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    st = v["stifte"]
    steps = [
        dict(title="Rahmen und Vorbau", parts=P("rahmen", "vorbau", "kuehlergrill", "leuchte", "rueckleuchte"),
             text=["Kühlergrill und Scheinwerferplatten in die Taschen des Vorbaus drücken.",
                   "Vorbau von oben auf die Steckzungen der Längsträger schieben, Rückleuchten hinten einstecken."], render=S(1)),
        dict(title="Achszapfen und Räder", parts=P("achszapfen_vorne", "achszapfen_hinten", "rad_vorne", "rad_hinten"),
             text=["Achszapfen in die Rautenlöcher stecken: kurze vorne, lange hinten.",
                   "Felgen in die Reifen drücken, Räder aufschieben – sie drehen sich."], render=S(2)),
        dict(title="Oberdeck und Kabine", parts=P("oberdeck", "kabine"),
             text=["Oberdeck auf die Zapfen des Vorbaus drücken.",
                   "Glaskern von unten in die Kabine schieben, Kabine mit den Eckzapfen ins Deck stecken."], render=S(3)),
        dict(title="Geländer, Spiegel, Auspuff", parts=P("gelaender_vorne_rechts", "gelaender_vorne_links", "gelaender_seite_rechts", "gelaender_seite_links", "spiegel", "auspuff"),
             text=["Geländer und Spiegel mit den Zungen in die Schlitze im Deck stecken.",
                   "Die zwei Schalldämpfer auf die Zapfen hinten rechts drücken."], render=S(4)),
        dict(title="Treppe und Leitern", parts=P("treppe", "leiter"),
             text=["Treppe unten in die Stoßstange, oben in den Schlitz über dem Grill stecken.",
                   "Leitern von unten in die Schlitze der Stoßstange stecken."], render=S(5)),
        dict(title="Kippzylinder", parts=P("zylinder"),
             text=["Kolbenstange von vorne ins Rohr schieben (flache Seiten zusammen).",
                   f"Bolzen ({st[2]} mm) durch beide unteren Augen und den Rahmen stecken."], render=S(6, VH)),
        dict(title="Mulde", parts=P("muldentraeger", "mulde"),
             text=["Muldenträger mit den Zungen in den Muldenboden drücken.",
                   f"Mulde aufsetzen, Kipplager-Bolzen ({st[0]} mm) durch Träger und Rahmen."],
             render=S(7, VH), inset=dict(scad=A, cam="0,0,0,65,0,300,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True), inset_txt="Kipplager"),
        dict(title="Zylinder oben und Schutzdach", parts=P("schutzdach"),
             text=[f"Mulde anheben, Stangen herausziehen, Bolzen ({st[1]} mm) durch Augen und Träger.",
                   "Schutzdach mit den Zapfen auf die Stirnwand drücken."], render=S(8, VH, extra=["winkel=35"])),
    ]
    extra = (f"In 1:{andere} sind die Bauschritte gleich, nur die Bolzen sind {va['stifte'][0]} / {va['stifte'][1]} / {va['stifte'][2]} mm lang.")
    return dict(
        title="Muldenkipper", cover_note="FDM, alle Teile stützfrei", subtitle="Starrrahmen-Muldenkipper der 180-t-Klasse mit Kippmulde und drehbaren Rädern",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,62,0,125,0", defs=D, size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,72,0,215,0", defs=D + ["mulde_winkel=45"], size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,125,0", defs=D + ['teil="explosion"'], size=(1400, 1000), auto=True)],
        material=material([f"Filament 1,75 mm für 3 Bolzen ({st[0]}, {st[1]} und {st[2]} mm)",
                           f"Länge in 1:{mst} ca. {v['laenge'] / 10:.0f} cm, Höhe ca. {v['hoehe'] / 10:.0f} cm"]),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Farbbauteile (Felgen, Glaskern, Grill, Leuchten, Kolbenstangen, Geländer, Spiegel, Auspuff, Rückleuchten) werden gesteckt: mit AMS/MMU aus der 3MF oder einfarbig jede STL einzeln",
                     "Die dunkle Kante am Schutzdach ist eine Farbzone (AMS/MMU) – einfarbig einfach weglassen",
                     "Passung im Customizer: einsatz_spiel (Felgen, Glaskern, Einsätze, Zapfen), zylinder_spiel (Kolbenstange – kleiner = Mulde hält besser)"]),
        system=[f"In 1:{mst} passen alle Teile ungeteilt aufs Druckbett – Clips brauchst du nicht.",
                "Alles wird gesteckt: Achszapfen für die Räder, Steckzungen für Vorbau, Geländer, Treppe und Leitern, Rautenzapfen für Deck, Kabine und Schutzdach.",
                "Die Mulde kippt am Kipplager. Die teleskopischen Kippzylinder halten sie durch Reibung in jeder Stellung.",
                "Die Bolzen drehen sich lose im Rahmen; in den Augen der Zylinder und im Kipplager der Muldenträger sitzen sie stramm."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Muldenkipper", "muldenkipper.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Mulde vorne anheben: sie kippt bis etwa 45°, die Kolbenstangen fahren aus und halten sie.",
               "Hält die Mulde nicht, zylinder_spiel im Customizer verkleinern (Standard 0,1 mm) und die Stangen neu drucken.",
               "Alle vier Räder drehen sich; die Vorderräder sind starr (nicht lenkbar).",
               "Farben im Customizer ändern – z. B. eine andere Muldenfarbe (farbe_mulde)."])
