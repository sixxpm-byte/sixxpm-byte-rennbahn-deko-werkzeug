from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"pr{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def bolzen(log):
    m = re.search(r"Filament-Bolzen[^\[]*\[(.*?)\]\"", log)
    out = {}
    if m:
        for n, l in re.findall(r'"([^"]+?) ([\d.]+) mm"', m.group(1)): out[n] = f"{float(l):.0f}"
    return out

def model(mst=43):
    scad = MOD("planierraupe")
    A = ANL("anl_planierraupe")
    D = [f"massstab={mst}"]
    b = bolzen(echo(scad, mst))
    g = lambda n: b.get(n, "?")
    andere = 87 if mst == 43 else 43
    names = {"unterwagen": "Unterwagen", "kette": "Raupenlaufwerk", "schildrahmen": "Schildrahmen (C-Rahmen)", "kotfluegel": "Kotflügel",
             "rahmen": "Aufbau mit Motorhaube", "kabine": "Kabine + Glaskern", "schild": "Planierschild",
             "zylinder_hub": "Hubzylinder (Rohr + Stange)", "ripper": "Heckaufreißer", "zylinder_ripper": "Ripperzylinder (Rohr + Stange)"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"unterwagen": "aufrecht", "kette": "liegt auf der Innenseite", "schildrahmen": "liegt flach, Gabeln oben", "kotfluegel": "liegt flach",
            "rahmen": "aufrecht", "kabine": "kopfüber; Glaskern als Block", "schild": "Rückseite unten, Schneide oben",
            "zylinder_hub": "liegend, Augen unten", "ripper": "Rückseite unten, Zinken flach", "zylinder_ripper": "liegend, Augen unten"}
    for p in parts:
        if p["id"] in lage: p["info"] = lage[p["id"]]
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    V1, V2 = "0,0,0,62,0,35,0", "0,0,0,62,0,215,0"
    def S(n, cam=V1, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    steps = [
        dict(title="Laufwerk und Schildrahmen", parts=P("unterwagen", "schildrahmen", "kette"),
             text=["Schildrahmen so vor den Unterwagen legen, dass seine Schwenkzapfen neben den Steckzungen stehen.",
                   "Beide Ketten von außen aufschieben: Zungen in die Taschen, Zapfen in die Löcher (Relief außen)."], render=S(1)),
        dict(title="Kotflügel", parts=P("kotfluegel"),
             text=["Kotflügel mit den Rauten-Zapfen seitlich in den Unterwagen drücken (zweiten Kotflügel umdrehen)."], render=S(2, V2)),
        dict(title="Aufbau und Kabine", parts=P("rahmen", "kabine"),
             text=["Aufbau auf die vier Zapfen des Unterwagens drücken.",
                   "Glaskern von unten in die Kabine, Kabine mit den Zapfen in den Kabinenboden."], render=S(3)),
        dict(title="Planierschild", parts=P("schild"),
             text=["Schild mit den Taschen auf dem Rücken auf die zwei Zapfen des Querträgers drücken."], render=S(4)),
        dict(title="Hubzylinder", parts=P("zylinder_hub"),
             text=[f"Kolbenstangen in die Rohre schieben. Rohr-Auge an den Lagerbock: Bolzen {g('Hubzylinder oben (Lagerbock)')} mm von außen.",
                   f"Stangen-Auge in die Gabel am Schildrahmen: Bolzen {g('Hubzylinder unten (Gabel)')} mm."], render=S(5),
             inset=dict(scad=A, cam="0,0,0,55,0,25,0", defs=dd + ["detail=1"], size=(1000, 700), auto=True), inset_txt="Rohr + Stange"),
        dict(title="Aufreißer", parts=P("ripper", "zylinder_ripper"),
             text=[f"Arme in die Schlitze des Unterwagens, Bolzen {g('Ripper-Schwenkachse')} mm quer durch.",
                   f"Zylinder: Rohr in den Hubbock ({g('Ripperzylinder oben (Hubbock)')} mm), Stange an die Lasche ({g('Ripperzylinder unten (Lasche)')} mm)."], render=S(6, V2)),
    ]
    bl = ", ".join(f"{n} {l}" for n, l in b.items())
    extra = f"In 1:{andere} sind die Bauschritte gleich, nur die Bolzen sind anders lang (siehe LIESMICH)."
    halt = "Die Zylinder halten jede Stellung durch Reibung." if mst == 43 else "Die Hubzylinder halten die Stellung; der kurze Ripperzylinder nur bedingt – der Aufreißer ruht dann in der unteren Stellung."
    return dict(
        title="Planierraupe", cover_note="FDM, alle Teile stützfrei", subtitle="Kettendozer der 18-t-Klasse – Schild hebt und senkt sich, Aufreißer schwenkt",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,62,0,35,0", defs=D, size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,58,0,320,0", defs=D + ["schild_winkel=10", "ripper_winkel=0"], size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,55,0,30,0", defs=D + ['teil="explosion"'], size=(1400, 1000), auto=True)],
        material=material(["Filament 1,75 mm für 7 Bolzen (mm): " + bl, "Kein Kleber"]),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Farbbauteile (Glaskern, Kolbenstangen) werden gesteckt – keine Farbzonen, jedes Teil ist einfarbig druckbar",
                     "Passung im Customizer: zylinder_spiel (kleiner = Stellung hält besser), einsatz_spiel (Zungen, Zapfen, Glaskern), spiel"]),
        system=["Alle Gelenke sind Bolzen aus 1,75-mm-Filament: in Lagerbock, Gabel und Unterwagen sitzen sie stramm, in den Augen drehen sie sich lose.",
                "Der Schildrahmen schwenkt auf Rauten-Zapfen, die in beiden Ketten stecken – die Ketten halten ihn beim Aufschieben fest.",
                "Die Kolbenstangen gleiten in den Rohren. " + halt,
                "Kotflügel, Aufbau und Kabine stecken auf Rauten-Zapfen (Presssitz, einsatz_spiel)."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Planierraupe", "planierraupe.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Schild 0–10° (Schneide am Boden bis angehoben), Aufreißer 0–15°.",
               "Hält eine Stellung nicht, zylinder_spiel verkleinern (Standard 0,1 mm) und die Kolbenstangen neu drucken.",
               "Bolzen bündig abschneiden; ein zu lockerer Bolzen hält mit einem Tropfen Kleber im äußeren Teil."])
