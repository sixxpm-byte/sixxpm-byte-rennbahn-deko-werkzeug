from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"rl{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def bolzen(log):
    m = re.search(r"Filament-Bolzen[^\[]*\[(.*?)\]\"", log)
    out = {}
    if m:
        for n, l in re.findall(r'"([^"]+?) ([\d.]+) mm"', m.group(1)): out[n] = f"{float(l):.0f}"
    return out

def model(mst=43):
    scad = MOD("radlader")
    A = ANL("anl_radlader")
    D = [f"massstab={mst}"]
    b = bolzen(echo(scad, mst))
    g = lambda n: b.get(n, "?")
    andere = 87 if mst == 43 else 43
    names = {"hinterwagen": "Hinterwagen", "oberbau": "Aufbau mit Motorhaube", "kuehlergrill": "Kühlergrill", "kabine": "Kabine + Glaskern",
             "vorderwagen": "Vorderwagen mit Turm", "knickbolzen": "Knickbolzen", "achse": "Achse", "rad": "Rad (Reifen + Felge)",
             "kotfluegel": "Kotflügel vorne", "leuchte": "Arbeitsscheinwerfer", "leiter": "Leiter", "handlauf": "Handlauf", "spiegel": "Außenspiegel",
             "hubarm": "Hubarm", "zylinder_hub": "Hubzylinder (Rohr + Stange)", "zylinder_kipp": "Kippzylinder (Rohr + Stange)",
             "kipphebel": "Kipphebel", "querrohr": "Distanzrohr", "koppel": "Koppelstange", "schaufel": "Schaufel"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"hinterwagen": "aufrecht", "oberbau": "aufrecht", "kuehlergrill": "Rückseite unten", "kabine": "kopfüber; Glaskern als Block",
            "vorderwagen": "aufrecht", "knickbolzen": "steht auf dem Kopf", "achse": "liegt flach", "rad": "Innenseite unten",
            "kotfluegel": "liegt flach", "leuchte": "liegt flach", "leiter": "liegt flach", "handlauf": "liegt flach", "spiegel": "liegt flach",
            "hubarm": "liegt flach", "zylinder_hub": "liegend, Augen unten", "zylinder_kipp": "liegend, Augen unten",
            "kipphebel": "liegt flach", "querrohr": "steht", "koppel": "liegt flach", "schaufel": "Boden unten"}
    for p in parts:
        if p["id"] in lage: p["info"] = lage[p["id"]]
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    V1, V2, V3 = "0,0,0,62,0,35,0", "0,0,0,62,0,215,0", "0,0,0,66,0,25,0"
    def S(n, cam=V1, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    steps = [
        dict(title="Hinterwagen", parts=P("hinterwagen", "oberbau", "kuehlergrill", "achse", "rad"),
             text=["Aufbau auf die vier Zapfen drücken, Kühlergrill von hinten einstecken.",
                   "Achse durch den Rahmen; Felgen von innen in die Reifen, Räder aufstecken."], render=S(1, V2)),
        dict(title="Kabine und Anbauteile", parts=P("kabine", "handlauf", "leiter", "spiegel", "leuchte"),
             text=["Glaskern von unten in die Kabine, Kabine in die Plattform; Handläufe von oben, Leitern von unten.",
                   "Spiegel vorne und zwei Scheinwerfer hinten in die Schlitze im Kabinendach."], render=S(2, V2)),
        dict(title="Vorderwagen", parts=P("vorderwagen", "achse", "rad", "kotfluegel", "leuchte"),
             text=["Achse durchschieben, Räder aufstecken.",
                   "Kotflügel mit der Zunge von beiden Seiten in das Fenster im Turm, Scheinwerfer in die Schlitze."], render=S(3)),
        dict(title="Zylinder", parts=P("zylinder_hub", "zylinder_kipp"),
             text=["Kolbenstangen in die Rohre schieben (flache Seiten oben und unten)."], render=S(4, "0,0,0,55,0,20,0")),
        dict(title="Hubarme und Hubzylinder", parts=P("hubarm"),
             text=[f"Hubzylinder: Bolzen {g('Hubzylinder-Fuß')} mm durch den Turm, Rohre außen aufstecken.",
                   f"Hubarme mit Bolzen {g('Hubarm-Lager am Turm')} mm am Turm; Stangen innen an die Arme (je {g('Hubzylinder am Hubarm (2x)')} mm)."], render=S(5)),
        dict(title="Kipphebel und Koppel", parts=P("kipphebel", "querrohr", "koppel"),
             text=[f"Bolzen {g('Kipphebel-Lager mit Distanzrohren')} mm: Arm, Distanzrohr, beide Kipphebel, Distanzrohr, Arm.",
                   f"Koppel unten zwischen die Hebel, Bolzen {g('Kipphebel unten')} mm."], render=S(6)),
        dict(title="Schaufel und Kippzylinder", parts=P("schaufel"),
             text=[f"Schaufel: Arme in die Gabeln (2 Bolzen {g('Schaufelbolzen (2x)')} mm), Koppel zwischen die Augen ({g('Koppel an der Schaufel')} mm).",
                   f"Kippzylinder: Rohr in den Schlitz im Turm ({g('Kippzylinder-Fuß')} mm), Stange zwischen die Hebel ({g('Kipphebel oben')} mm)."], render=S(7, V3),
             inset=dict(scad=A, cam="0,0,0,66,0,25,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True), inset_txt="Z-Kinematik"),
        dict(title="Knickgelenk", parts=P("knickbolzen"),
             text=["Säule des Vorderwagens von vorne unter den Gelenkbock schieben.",
                   "Knickbolzen von unten durch die Säule in den Gelenkbock drücken."], render=S(8)),
    ]
    bl = ", ".join(f"{n} {l}" for n, l in b.items())
    extra = f"In 1:{andere} sind die Bauschritte gleich, nur die Bolzen sind anders lang (siehe LIESMICH)."
    return dict(
        title="Radlader", cover_note="FDM, alle Teile stützfrei", subtitle="Knickgelenkter Radlader der 30-t-Klasse – Lenkung, Räder, Hubgerüst und Schaufel beweglich",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,62,0,35,0", defs=D, size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,72,0,40,0", defs=D + ["hub=100", "schaufel_winkel=-42", "knick=25"], size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,60,0,30,0", defs=D + ['teil="explosion"'], size=(1400, 1000), auto=True)],
        material=material(["Filament 1,75 mm für 11 Bolzen (mm): " + bl, "Kein Kleber"]),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Alle Farben sind eigene Bauteile (Glaskern, Felgen, Kolbenstangen, Grill, Anbauteile) – kein AMS/MMU nötig",
                     "Passung im Customizer: zylinder_spiel (kleiner = Stellung hält besser), einsatz_spiel (Zapfen, Achsen, Grill), spiel"]),
        system=["Alle Gelenke des Hubgerüsts sind Bolzen aus 1,75-mm-Filament: in den äußeren Teilen sitzen sie stramm, innen drehen sie sich lose.",
                "Z-Kinematik wie beim Vorbild: Der Kippzylinder drückt den Kipphebel oben nach vorne, die Koppel zieht die Schaufel unten ein.",
                "Die Kolbenstangen gleiten in den Rohren und halten Hubgerüst und Schaufel durch Reibung in jeder Stellung.",
                "Der Knickbolzen mit Senkkopf verbindet Vorder- und Hinterwagen; die Räder drehen auf den Vierkant-Achsen."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Radlader", "radlader.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Lenkung ±35°, Hubgerüst vom Boden bis ganz oben, Schaufel ein- und auskippen.",
               "Hält eine Stellung nicht, zylinder_spiel verkleinern (Standard 0,1 mm) und die Kolbenstangen neu drucken.",
               "Bolzen bündig abschneiden; ein zu lockerer Bolzen hält mit einem Tropfen Kleber im äußeren Teil."])
