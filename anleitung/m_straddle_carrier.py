from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"sc{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def werte(log):
    v = {}
    m = re.search(r"\| ([\d.]+) x ([\d.]+) x ([\d.]+) mm \(", log)
    v["laenge"], v["breite"], v["hoehe"] = (float(m.group(1)), float(m.group(2)), float(m.group(3))) if m else (0, 0, 0)
    m = re.search(r"Hubhöhe ([\d.]+) m", log); v["hub"] = m.group(1).replace(".", ",") if m else "5"
    m = re.search(r"Tasche Ø ([\d.]+) x ([\d.]+) mm \(Magnet ([\d.]+) x ([\d.]+)\), Abstand zur Mitte ([\d.]+) mm 20' / ([\d.]+) mm 40'", log)
    v["magnet"] = m.groups() if m else None
    m = re.search(r"Koni Ø ([\d.]+)", log); v["koni"] = m.group(1).replace(".", ",") if m else None
    return v

def k(x): return f"{float(x):.1f}".replace(".", ",")

def model(mst=43):
    scad = MOD("straddle_carrier")
    A = ANL("anl_straddle_carrier")
    D = [f"massstab={mst}"]
    v = werte(echo(scad, mst))
    andere = 87 if mst == 43 else 43
    names = {"fahrwerk_links": "Fahrwerk links", "fahrwerk_rechts": "Fahrwerk rechts", "rad": "Rad", "kabine": "Fahrerkabine", "motor": "Motormodul",
             "innenbein": "Innenbein mit Stange", "oberrahmen": "Oberrahmen", "quertraeger": "Querträger", "mitteltraeger": "Mittelträger",
             "spreader_rahmen": "Spreader-Rahmen", "spreader_arm": "Teleskoparm"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"fahrwerk_links": "liegt auf der Innenseite, Zapfen oben", "fahrwerk_rechts": "liegt auf der Innenseite, Zapfen oben",
            "rad": "liegend, Außenseite oben", "kabine": "aufrecht", "motor": "aufrecht", "innenbein": "liegt auf der Außenseite (Fase unten)",
            "oberrahmen": "liegt auf der Innenseite", "quertraeger": "liegt auf der Rückseite", "mitteltraeger": "liegt auf der Seite",
            "spreader_rahmen": "aufrecht, Drehzapfen oben", "spreader_arm": "kopfüber, Magnettasche oben"}
    for p in parts:
        if p["id"] in lage: p["info"] = lage[p["id"]]
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VP, VL = "0,0,0,62,0,325,0", "0,0,0,62,0,145,0"
    def S(n, cam=VP, size=(1500, 1100)):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"], size=size, auto=True)
    mg = v["magnet"]
    st_mag = ([f"Magnet Ø {mg[2]} × {mg[3]} mm in jede Kopfträger-Tasche kleben (Polung beachten).",
               "Arme in die Kanäle schieben, Spreader von unten in den Mittelträger stecken."]
              if mg else ["Arme in die Kanäle schieben.", "Spreader von unten in den Mittelträger stecken."])
    steps = [
        dict(title="Räder", parts=P("fahrwerk_links", "fahrwerk_rechts", "rad"),
             text=["Die Räder mit der Innenseite auf die Achszapfen der beiden Fahrwerke schieben – sie drehen sich."], render=S(1)),
        dict(title="Kabine und Motor", parts=P("kabine", "motor"),
             text=["Kabine (vorne) und Motormodul (hinten) außen auf die Zapfen am linken Fahrwerk stecken."], render=S(2, VL)),
        dict(title="Innenbeine", parts=P("innenbein"),
             text=["Die vier Innenbeine in die Beinfüße stecken.", "Die silberne Kolbenstange zeigt jeweils zur Fahrzeugmitte."], render=S(3)),
        dict(title="Oberrahmen", parts=P("oberrahmen", "quertraeger", "mitteltraeger"),
             text=["Querträger (Leuchten außen) und Mittelträger mit den Federn in die Taschen eines Oberrahmens stecken.",
                   "Den zweiten Oberrahmen von der anderen Seite aufsetzen."], render=S(4)),
        dict(title="Spreader", parts=P("spreader_rahmen", "spreader_arm"), text=st_mag, render=S(5),
             inset=dict(scad=A, cam="0,0,0,55,0,25,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True) if mg else None,
             inset_txt="Magnet in die Tasche" if mg else None),
        dict(title="Oberteil aufsetzen", parts=[],
             text=["Das Oberteil mit den Schächten der Oberbeine über die vier Innenbeine schieben, bis es aufliegt."], render=S(6)),
        dict(title="Container aufnehmen", parts=[],
             text=["Den Straddle Carrier über den Container fahren: die Koni finden die Eckbeschläge, die Magnete halten ihn.",
                   "Für 40 Fuß beide Teleskoparme ganz ausziehen."], render=S(7)),
    ]
    for s in steps:
        if s.get("inset") is None: s.pop("inset", None); s.pop("inset_txt", None)
    sys_txt = [f"In 1:{mst} passen alle Teile ungeteilt aufs Druckbett – Clips brauchst du nicht.",
               "Alle Verbindungen sind gesteckt: Achs- und Kabinenzapfen, Federn der Träger in Taschen, Innenbeine in Schächten.",
               f"Die Hubhöhe ({v['hub']} m) steckt in der Länge der Innenbeine – für eine andere Höhe nur die vier Innenbeine neu drucken."]
    if mg:
        sys_txt.append(f"Container-Halterung: Magnet Ø {mg[2]} × {mg[3]} mm in jedem Kopfträger. Gegenstück aufs Containerdach: "
                       f"Stahlscheibe oder Magnet, {k(mg[4])} mm (20 Fuß) bzw. {k(mg[5])} mm (40 Fuß) von der Container-Mitte, quer mittig.")
    mat = [f"Länge in 1:{mst} ca. {v['laenge'] / 10:.0f} cm, Höhe ca. {v['hoehe'] / 10:.0f} cm"]
    if mg: mat.insert(0, f"2 Neodym-Magnete Ø {mg[2]} × {mg[3]} mm, Sekundenkleber; für den Container 2 Stahlscheiben oder Magnete")
    extra = f"In 1:{andere} sind die Bauschritte gleich; Magnetgröße und -taschen stellst du im Customizer ein (Abschnitt Container-Halterung)."
    return dict(
        title="Straddle Carrier", cover_note="FDM, stützfrei", subtitle="Portalhubwagen mit Teleskopbeinen, Spreader 20′/40′ und Magnet-Halterung",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,62,0,325,0", defs=D, size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,62,0,145,0", defs=D + ["spreader_auszug=1"], size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,325,0", defs=D + ['teil="explosion"', "container_zeigen=false"], size=(1400, 1000), auto=True)],
        material=material(mat),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Mehrfarbige Teile (Innenbeine, Querträger, Teleskoparme, Räder, Kabine, Motor) mit AMS/MMU – oder einfarbig mit farbteil = alle",
                     "Sitzen Innenbeine oder Drehzapfen zu stramm: spiel bzw. zapfen_spiel im Customizer vergrößern"],
                    stuetzen="Alle Teile drucken stützfrei. Die Schächte in Fahrwerk und Oberrahmen haben ein gefastes Dach mit kurzer Brücke."),
        system=sys_txt,
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Straddle Carrier", "straddle_carrier.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Die Räder drehen sich, der Spreader lässt sich am Drehzapfen abnehmen.",
               "Teleskoparme auf 20 Fuß einschieben oder für 40 Fuß ganz ausziehen.",
               "Magnete abschalten oder anders dimensionieren: Customizer, Abschnitt Container-Halterung.",
               "Eine andere Hubhöhe wählen (hubhoehe_m) – es ändern sich nur die Innenbeine."])
