from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"sc{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def werte(log):
    v = {}
    m = re.search(r"\| ([\d.]+) x ([\d.]+) x ([\d.]+) mm \(", log)
    v["laenge"], v["breite"], v["hoehe"] = (float(m.group(1)), float(m.group(2)), float(m.group(3))) if m else (0, 0, 0)
    m = re.search(r"Hubhöhe ([\d.]+) m", log); v["hub"] = m.group(1).replace(".", ",") if m else "5"
    m = re.search(r"Tasche Ø ([\d.]+) x ([\d.]+) mm \(Magnet ([\d.]+) x ([\d.]+)\)", log)
    v["magnet"] = m.groups() if m else None
    m = re.search(r"Koni Ø ([\d.]+)", log); v["koni"] = m.group(1).replace(".", ",") if m else None
    m = re.search(r"im Containerdach von innen, ([\d.]+) mm ab Stirnseite, Dachhaut ([\d.]+) mm", log)
    v["ct_mag"] = m.groups() if m else None
    m = re.search(r"40' Boden/Dach (\d+) Stück\(e\), Seitenwand (\d+) Stück\(e\), (\d+) Clips", log)
    v["c40"], v["c40w"], v["clips"] = (int(m.group(1)), int(m.group(2)), int(m.group(3))) if m else (1, 1, 0)
    return v

def k(x): return f"{float(x):.1f}".replace(".", ",")

def model(mst=43):
    scad = MOD("straddle_carrier")
    A = ANL("anl_straddle_carrier")
    D = [f"massstab={mst}"]
    v = werte(echo(scad, mst))
    andere = 87 if mst == 43 else 43
    names = {"fahrwerk_links": "Fahrwerk links", "fahrwerk_rechts": "Fahrwerk rechts", "rad": "Rad (Reifen + Felge)", "kabine": "Kabine + Glaskern", "motor": "Motormodul",
             "innenbein": "Innenbein mit Stange", "oberrahmen": "Oberrahmen", "quertraeger": "Querträger", "mitteltraeger": "Mittelträger",
             "spreader_rahmen": "Spreader-Rahmen", "spreader_arm": "Teleskoparm", "kopftraeger": "Kopfträger", "motor_gitter": "Lüftergitter",
             "c20_boden": "Container 20′ Boden", "c20_dach": "Container 20′ Dach", "c20_seite": "Container 20′ Seitenwand",
             "c20_stirn": "Container 20′ Stirnwand", "c20_tuer": "Container 20′ Türseite",
             "c40_boden": "Container 40′ Boden", "c40_dach": "Container 40′ Dach", "c40_seite": "Container 40′ Seitenwand",
             "c40_stirn": "Container 40′ Stirnwand", "c40_tuer": "Container 40′ Türseite", "verbinder": "Clips"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"fahrwerk_links": "liegt auf der Innenseite, Zapfen oben", "fahrwerk_rechts": "liegt auf der Innenseite, Zapfen oben",
            "rad": "liegend, Innenrand unten", "kabine": "aufrecht, unten offen", "motor": "aufrecht", "motor_gitter": "flach, Stäbe oben",
            "innenbein": "Bein und Stange liegend, Fase unten",
            "oberrahmen": "liegt auf der Innenseite", "quertraeger": "liegt auf der Rückseite", "mitteltraeger": "liegt auf der Seite",
            "spreader_rahmen": "aufrecht, Drehzapfen oben", "spreader_arm": "kopfüber", "kopftraeger": "kopfüber, Magnettasche oben"}
    for c in ("c20", "c40"):
        lage.update({f"{c}_boden": "kopfüber", f"{c}_dach": "kopfüber, Magnettaschen oben", f"{c}_seite": "Innenseite unten",
                     f"{c}_stirn": "Außenseite unten", f"{c}_tuer": "Außenseite unten"})
    for p in parts:
        if p["id"] in lage: p["info"] = lage[p["id"]]
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VP, VL = "0,0,0,62,0,325,0", "0,0,0,62,0,145,0"
    VC = "0,0,0,55,0,215,0"
    def S(n, cam=VP, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    cm = v["ct_mag"]
    geteilt = v["clips"] > 0
    mg = v["magnet"]
    st_mag = [(f"Magnet Ø {mg[2]} × {mg[3]} mm in jeden Kopfträger kleben; " if mg else "") + "Arm von oben in die Aufnahme des Kopfträgers drücken.",
              "Arme in die Kanäle schieben, Spreader von unten in den Mittelträger stecken."]
    steps = [
        dict(title="Räder", parts=P("fahrwerk_links", "fahrwerk_rechts", "rad"),
             text=["Felge von außen in den Reifen drücken, bis sie auf dem Innenrand sitzt.",
                   "Räder (Innenrand zum Rahmen) auf die Achszapfen schieben."], render=S(1)),
        dict(title="Kabine und Motor", parts=P("kabine", "motor", "motor_gitter"),
             text=["Glaskern von unten in die Kabine, Gitter in den Motor drücken.",
                   "Kabine (vorne) und Motor auf die Zapfen am linken Fahrwerk stecken."], render=S(2, VL)),
        dict(title="Innenbeine", parts=P("innenbein"),
             text=["Je ein Innenbein und eine Kolbenstange nebeneinander in den Beinfuß stecken.", "Die silberne Stange zeigt jeweils zur Fahrzeugmitte."], render=S(3)),
        dict(title="Oberrahmen", parts=P("oberrahmen", "quertraeger", "mitteltraeger"),
             text=["Leuchtenleisten in die Querträger drücken, Querträger (Leuchten außen) und Mittelträger in einen Oberrahmen stecken.",
                   "Den zweiten Oberrahmen von der anderen Seite aufsetzen."], render=S(4)),
        dict(title="Spreader", parts=P("spreader_rahmen", "spreader_arm", "kopftraeger"), text=st_mag, render=S(5),
             inset=dict(scad=A, cam="0,0,0,30,0,60,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True),
             inset_txt="Arm von oben einsetzen"),
        dict(title="Oberteil aufsetzen", parts=[],
             text=["Das Oberteil mit den Schächten der Oberbeine über die vier Innenbeine schieben, bis es aufliegt."], render=S(6)),
    ]
    if cm:
        steps.append(dict(title="Magnete ins Containerdach", parts=P("c20_dach", "c40_dach"),
             text=[f"Je einen Magnet Ø {mg[2]} × {mg[3]} mm von innen in die Taschen an beiden Enden kleben.",
                   "Polung gegen die Spreader-Magnete prüfen, bevor der Kleber anzieht."],
             render=dict(scad=A, cam="0,0,0,40,0,20,0", defs=dd + ["detail=2"], size=(1500, 1000), auto=True)))
    if geteilt:
        steps.append(dict(title="40-Fuß-Container verclipsen", parts=P("c40_boden", "c40_dach", "verbinder"),
             text=[f"Boden und Dach (je {v['c40']} Teile) aneinanderlegen und mit den {v['clips']} Clips verbinden.",
                   "Die zweiteiligen Seitenwände Stoß an Stoß in die Nuten stellen."],
             render=dict(scad=A, cam="0,0,0,40,0,20,0", defs=dd + ["ansicht=2"], size=(1500, 1000), auto=True)))
    steps += [
        dict(title="Container: Boden und Stirnseiten", parts=P("c20_boden", "c20_stirn", "c20_tuer", "c40_boden", "c40_stirn", "c40_tuer"),
             text=["Stirnwand und Türseite mit der Feder in die Quernuten des Bodens stellen (40 Fuß genauso)."], render=S(1, VC, extra=["ansicht=1"])),
        dict(title="Container: Seitenwände und Dach", parts=P("c20_seite", "c20_dach", "c40_seite", "c40_dach"),
             text=["Seitenwände in die Längsnuten stellen, Sicken außen.", "Dach aufsetzen – die Nuten greifen über die Wände."], render=S(2, VC, extra=["ansicht=1"])),
        dict(title="Container aufnehmen", parts=[],
             text=["Den Straddle Carrier über den Container fahren: die Koni finden die Eckbeschläge, die Magnete halten ihn.",
                   "Für 40 Fuß beide Teleskoparme ganz ausziehen."], render=S(7)),
    ]
    for s in steps:
        if s.get("inset") is None: s.pop("inset", None); s.pop("inset_txt", None)
    sys_txt = [(f"In 1:{mst} wird nur der 40-Fuß-Container geteilt: Boden und Dach aus je {v['c40']} Teilen mit {v['clips']} Clips, Seitenwände zweiteilig."
                if geteilt else f"In 1:{mst} passen alle Teile ungeteilt aufs Druckbett – Clips brauchst du nicht."),
               "Alles ist gesteckt – auch die Farbteile: Felge, Glaskern, Lüftergitter, Leuchtenleiste und Kolbenstange sitzen in Taschen oder Schächten, der Teleskoparm hängt mit einem Schwalbenschwanz im Kopfträger. Einfarbig druckst du jede STL einzeln.",
               "Containerdach, Stirnwand und Türseite sind einfarbig; mit container_zweifarbig = true bekommen sie graue Beschläge (dann nur mit AMS/MMU druckbar).",
               f"Die Hubhöhe ({v['hub']} m) steckt in der Länge der Innenbeine – für eine andere Höhe nur die vier Innenbeine neu drucken."]
    if mg and cm:
        sys_txt.append(f"Container-Halterung: je ein Magnet Ø {mg[2]} × {mg[3]} mm im Kopfträger und – unsichtbar unter {k(cm[1])} mm Dachhaut – "
                       f"im Containerdach, {k(cm[0])} mm von jeder Stirnseite. Statt der Container-Magnete gehen auch Stahlscheiben. "
                       "Die Magnete heben das Dach – soll der Container am Spreader hängen, Wände und Dach am Boden festkleben.")
    mat = [f"Länge in 1:{mst} ca. {v['laenge'] / 10:.0f} cm, Höhe ca. {v['hoehe'] / 10:.0f} cm; Container 20′ und 40′ im Bausatz"]
    if mg: mat.insert(0, f"Neodym-Magnete Ø {mg[2]} × {mg[3]} mm: 2 für den Spreader und 2 je Container (oder Stahlscheiben), Sekundenkleber")
    extra = f"In 1:{andere} sind die Bauschritte gleich; Magnetgröße und -taschen stellst du im Customizer ein (Abschnitt Container-Halterung)."
    return dict(
        title="Straddle Carrier", cover_note="FDM, stützfrei", subtitle="Portalhubwagen mit Teleskopbeinen, Spreader 20′/40′, Magnet-Halterung und Container-Bausatz",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,62,0,325,0", defs=D, size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,62,0,145,0", defs=D + ["spreader_auszug=1"], size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,325,0", defs=D + ['teil="explosion"', "container_zeigen=false"], size=(1400, 1000), auto=True)],
        material=material(mat),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Farbteile mit AMS/MMU gemeinsam aus der 3MF drucken – oder einfarbig jede STL einzeln, sie werden gesteckt",
                     "Passung im Customizer: spiel (Innenbeine, Federn), zapfen_spiel (Schwalbenschwanz, Koni, Drehzapfen), einsatz_spiel (Felge, Glaskern, Gitter, Leuchtenleiste)"],
                    stuetzen="Alle Teile drucken stützfrei. Die Schächte in Fahrwerk und Oberrahmen haben ein gefastes Dach mit kurzer Brücke."),
        system=sys_txt,
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Straddle Carrier", "straddle_carrier.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Die Räder drehen sich, der Spreader lässt sich am Drehzapfen abnehmen.",
               "Teleskoparme auf 20 Fuß einschieben oder für 40 Fuß ganz ausziehen.",
               "Magnete abschalten oder anders dimensionieren: Customizer, Abschnitt Container-Halterung (gilt für Spreader und Containerdach).",
               "Eine andere Hubhöhe wählen (hubhoehe_m) – es ändern sich nur die Innenbeine."])
