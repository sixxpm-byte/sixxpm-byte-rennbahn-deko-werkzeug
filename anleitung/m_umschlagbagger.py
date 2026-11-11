from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"ub{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def bolzen(log):
    m = re.search(r"Filament-Bolzen[^\[]*\[(.*?)\]\"", log)
    out = {}
    if m:
        for n, l in re.findall(r'"([^"]+?) ([\d.]+) mm"', m.group(1)): out[n] = f"{float(l):.0f}"
    return out

def model(mst=43):
    scad = MOD("umschlagbagger")
    A = ANL("anl_umschlagbagger")
    D = [f"massstab={mst}"]
    b = bolzen(echo(scad, mst))
    g = lambda n: b.get(n, "?")
    andere = 87 if mst == 43 else 43
    names = {"fahrgestell": "Fahrgestell", "stuetze": "Abstützpratze", "achse": "Achse", "rad": "Zwillingsrad (Reifen + Felge)",
             "oberwagen": "Oberwagen", "handlauf": "Handlauf", "hubarm": "Hubarm", "traeger": "Kabinenträger", "kabine": "Kabine + Glaskern",
             "ausleger_links": "Ausleger links", "ausleger_rechts": "Ausleger rechts", "stiel_links": "Stiel links", "stiel_rechts": "Stiel rechts",
             "duebel": "Dübel (4 Stück)", "zylinder_ausleger": "Hubzylinder (Rohr + Stange)", "zylinder_stiel": "Stielzylinder (Rohr + Stange)",
             "greiferkopf": "Greiferkopf", "schale": "Greiferschale"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"fahrgestell": "aufrecht", "stuetze": "steht auf der Fußplatte", "achse": "liegend", "rad": "Innenseite unten; Felge Außenseite oben",
            "oberwagen": "aufrecht", "handlauf": "liegt flach", "hubarm": "liegt flach", "traeger": "kopfüber (Wangen oben)", "kabine": "kopfüber; Glaskern als Block",
            "ausleger_links": "flach, Außenseite unten", "ausleger_rechts": "flach, Außenseite unten",
            "stiel_links": "flach, Außenseite unten", "stiel_rechts": "flach, Außenseite unten", "duebel": "liegen flach",
            "zylinder_ausleger": "liegend, Augen unten", "zylinder_stiel": "liegend, Augen unten",
            "greiferkopf": "aufrecht, Schlitze unten", "schale": "liegt flach"}
    for p in parts:
        if p["id"] in lage: p["info"] = lage[p["id"]]
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    V1, V2 = "0,0,0,65,0,125,0", "0,0,0,70,0,160,0"
    def S(n, cam=V1, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    steps = [
        dict(title="Fahrgestell", parts=P("fahrgestell", "stuetze", "achse", "rad"),
             text=["Achsen durch das Fahrgestell, Zwillingsräder aufstecken, Felgen von außen eindrücken.",
                   "Die vier Pratzen mit dem Zapfen von unten in die Pratzenkästen stecken."], render=S(1, "0,0,0,62,0,35,0")),
        dict(title="Oberwagen", parts=P("oberwagen", "handlauf"),
             text=["Handläufe in die Schlitze auf Motorhaus und Tankkasten.",
                   "Oberwagen auf den Königszapfen setzen – er dreht sich."], render=S(2)),
        dict(title="Kabinen-Hubarme", parts=P("hubarm"),
             text=[f"Je zwei Hubarme links und rechts an den Turm: Bolzen {g('Hubarme am Turm')} mm durch die Augen und den Turm.",
                   f"Rastbolzen {g('Rastbolzen')} mm durch das mittlere Loch der unteren Arme in eines der vier Rastlöcher."], render=S(3, "0,0,0,62,0,215,0"),
             inset=dict(scad=A, cam="0,0,0,90,0,90,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True), inset_txt="Turm mit Rastlöchern"),
        dict(title="Kabine", parts=P("traeger", "kabine"),
             text=[f"Kabinenträger auf die Armenden: zwei Bolzen {g('Hubarme am Träger')} mm durch die Wangen.",
                   "Glaskern von unten in die Kabine, Kabine mit den Zapfen auf den Träger drücken."], render=S(4, "0,0,0,62,0,215,0")),
        dict(title="Ausleger und Stiel", parts=P("ausleger_links", "ausleger_rechts", "stiel_links", "stiel_rechts", "duebel"),
             text=["Je zwei Dübel in die Taschen einer Hälfte drücken (lange für den Ausleger).",
                   "Zweite Hälfte aufdrücken – die Gabeln liegen innen."], render=S(5, "0,0,0,55,0,20,0")),
        dict(title="Zylinder", parts=P("zylinder_ausleger", "zylinder_stiel"),
             text=["Kolbenstangen in die Rohre schieben (flache Seiten oben und unten)."], render=S(6, "0,0,0,55,0,20,0")),
        dict(title="Ausleger montieren", parts=P(),
             text=[f"Auslegerfuß zwischen die Wangen, Bolzen {g('Auslegerfuß')} mm.",
                   f"Hubzylinder: unten Bolzen {g('Hubzylinder unten')} mm durch den Bock, oben {g('Hubzylinder oben')} mm durch den Ausleger."], render=S(7)),
        dict(title="Stiel montieren", parts=P(),
             text=[f"Stiel in die Gabel, Bolzen {g('Stielgelenk')} mm.",
                   f"Stielzylinder: Rohr am Ausleger ({g('Stielzylinder am Ausleger')} mm), Stange am Stiel ({g('Stielzylinder am Stiel')} mm)."], render=S(8, V2)),
        dict(title="Greifer", parts=P("greiferkopf", "schale"),
             text=["Fünf Schalen mit der Zunge von unten in die Schlitze des Kopfes drücken.",
                   f"Öse in die Stielspitze, Bolzen {g('Greifer am Stiel')} mm – der Greifer pendelt."], render=S(9, V2),
             inset=dict(scad=A, cam="0,0,0,70,0,30,0", defs=dd + ["detail=2"], size=(1000, 800), auto=True), inset_txt="Greifer"),
    ]
    bl = ", ".join(f"{n} {l}" for n, l in b.items())
    extra = f"In 1:{andere} sind die Bauschritte gleich, nur die Bolzen sind anders lang (siehe LIESMICH)."
    return dict(
        title="Umschlagbagger", cover_note="FDM, alle Teile stützfrei", subtitle="Mobil-Umschlagbagger mit Mehrschalengreifer – Oberwagen dreht, Kabine hebt, Ausleger und Stiel beweglich",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,62,0,35,0", defs=D, size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,62,0,215,0", defs=D + ["drehung=40", "ausleger_winkel=65", "stiel_winkel=-120", "kabine_stufe=0"], size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,125,0", defs=D + ['teil="explosion"'], size=(1400, 1000), auto=True)],
        material=material(["Filament 1,75 mm für die Bolzen (mm): " + bl, "Kein Kleber"]),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Alle Farbbauteile werden gesteckt (Felgen, Glaskern, Kolbenstangen, Handläufe, Schalen) – keine Farbzonen nötig",
                     "Passung im Customizer: zylinder_spiel (kleiner = Stellung hält besser), einsatz_spiel (Zapfen, Achsen, Dübel, Felgen), spiel"]),
        system=["Alle Gelenke sind Bolzen aus 1,75-mm-Filament: in den äußeren Teilen sitzen sie stramm, innen drehen sie sich lose.",
                "Die Kabine hängt an einem Parallelogramm aus vier Hubarmen; ein Rastbolzen im Turm hält sie in einer von vier Höhen.",
                "Ausleger und Stiel bestehen aus zwei Hälften mit Dübeln – so entstehen die Gabeln ohne Stützen.",
                "Die Kolbenstangen gleiten in den Rohren und halten Ausleger und Stiel durch Reibung in jeder Stellung."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Umschlagbagger", "umschlagbagger.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Oberwagen dreht rundum, Räder drehen. Ausleger 25–70°, Stiel schwenkt bis zur Anlage; der Greifer pendelt am Stiel.",
               "Kabinenhöhe: Rastbolzen ziehen, Kabine schwenken, Bolzen ins nächste Rastloch stecken.",
               "Hält eine Stellung nicht, zylinder_spiel verkleinern (Standard 0,1 mm) und die Kolbenstangen neu drucken.",
               "Bolzen bündig abschneiden; ein zu lockerer Bolzen hält mit einem Tropfen Kleber im äußeren Teil."])
