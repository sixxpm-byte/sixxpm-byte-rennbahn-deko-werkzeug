from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"kb{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def bolzen(log):
    m = re.search(r"Filament-Bolzen[^\[]*\[(.*?)\]\"", log)
    out = {}
    if m:
        for n, l in re.findall(r'"([^"]+?) ([\d.]+) mm"', m.group(1)): out[n] = f"{float(l):.0f}"
    return out

def model(mst=43):
    scad = MOD("kettenbagger")
    A = ANL("anl_kettenbagger")
    D = [f"massstab={mst}"]
    b = bolzen(echo(scad, mst))
    g = lambda n: b.get(n, "?")
    andere = 87 if mst == 43 else 43
    names = {"unterwagen": "Unterwagen", "kette": "Raupenlaufwerk", "oberwagen": "Oberwagen", "kabine": "Kabine + Glaskern",
             "handlauf": "Handlauf", "spiegel": "Außenspiegel", "ausleger_links": "Ausleger links", "ausleger_rechts": "Ausleger rechts",
             "stiel_links": "Stiel links", "stiel_rechts": "Stiel rechts", "duebel": "Dübel (4 Stück)",
             "zylinder_ausleger": "Hubzylinder (Rohr + Stange)", "zylinder_stiel": "Stielzylinder (Rohr + Stange)",
             "zylinder_loeffel": "Löffelzylinder (Rohr + Stange)", "loeffel": "Tieflöffel", "umlenkhebel": "Umlenkhebel", "koppel": "Koppelstange"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"unterwagen": "aufrecht", "kette": "liegt auf der Innenseite", "oberwagen": "aufrecht", "kabine": "kopfüber; Glaskern als Block",
            "handlauf": "liegt flach", "spiegel": "liegt flach", "ausleger_links": "flach, Außenseite unten", "ausleger_rechts": "flach, Außenseite unten",
            "stiel_links": "flach, Außenseite unten", "stiel_rechts": "flach, Außenseite unten", "duebel": "liegen flach",
            "zylinder_ausleger": "liegend, Augen unten", "zylinder_stiel": "liegend, Augen unten", "zylinder_loeffel": "liegend, Augen unten",
            "loeffel": "Öffnung unten", "umlenkhebel": "liegt flach", "koppel": "liegt flach"}
    for p in parts:
        if p["id"] in lage: p["info"] = lage[p["id"]]
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    V1, V2 = "0,0,0,65,0,125,0", "0,0,0,70,0,160,0"
    def S(n, cam=V1, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    steps = [
        dict(title="Laufwerk", parts=P("unterwagen", "kette"),
             text=["Beide Raupenlaufwerke auf die Steckzungen des Unterwagens schieben (Relief außen)."], render=S(1)),
        dict(title="Oberwagen", parts=P("oberwagen", "kabine", "handlauf", "spiegel"),
             text=["Glaskern von unten in die Kabine, Kabine in die Plattform; Handläufe und Spiegel in die Schlitze.",
                   "Oberwagen auf den Königszapfen setzen – er dreht sich."], render=S(2)),
        dict(title="Ausleger und Stiel", parts=P("ausleger_links", "ausleger_rechts", "stiel_links", "stiel_rechts", "duebel"),
             text=["Je zwei Dübel in die Taschen einer Hälfte drücken (lange für den Ausleger).",
                   "Zweite Hälfte aufdrücken – die Gabeln liegen innen."], render=S(3, "0,0,0,55,0,20,0")),
        dict(title="Zylinder", parts=P("zylinder_ausleger", "zylinder_stiel", "zylinder_loeffel"),
             text=["Kolbenstangen in die Rohre schieben (flache Seiten oben und unten)."], render=S(4, "0,0,0,55,0,20,0")),
        dict(title="Ausleger montieren", parts=P(),
             text=[f"Auslegerfuß zwischen die Wangen, Bolzen {g('Auslegerfuß')} mm.",
                   f"Hubzylinder: unten Bolzen {g('Hubzylinder unten')} mm durch den Bock, oben {g('Hubzylinder oben')} mm durch den Ausleger."], render=S(5)),
        dict(title="Stiel montieren", parts=P(),
             text=[f"Stiel in die Gabel, Bolzen {g('Stielgelenk')} mm.",
                   f"Stielzylinder: Rohr am Ausleger ({g('Stielzylinder am Ausleger')} mm), Stange am Stiel ({g('Stielzylinder am Stiel')} mm)."], render=S(6, V2)),
        dict(title="Löffel und Gestänge", parts=P("loeffel", "umlenkhebel", "koppel"),
             text=[f"Löffel ({g('Löffelgelenk')} mm), Umlenkhebel innen ({g('Umlenkhebel am Stiel')} mm), Zylinder am Stiel ({g('Löffelzylinder am Stiel')} mm).",
                   f"Koppeln außen: am Löffel und am Gelenk mit Hebel und Stange (je {g('Koppel am Löffel')} mm)."], render=S(7, V2),
             inset=dict(scad=A, cam="0,0,0,70,0,150,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True), inset_txt="Gestänge"),
    ]
    bl = ", ".join(f"{n} {l}" for n, l in b.items())
    extra = f"In 1:{andere} sind die Bauschritte gleich, nur die Bolzen sind anders lang (siehe LIESMICH)."
    return dict(
        title="Kettenbagger", cover_note="FDM, alle Teile stützfrei", subtitle="Hydraulikbagger der 50-t-Klasse – Oberwagen dreht, Ausleger, Stiel und Löffel beweglich",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,65,0,125,0", defs=D, size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,62,0,35,0", defs=D + ["drehung=60", "ausleger_winkel=45", "stiel_winkel=-60", "loeffel_winkel=40"], size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,65,0,125,0", defs=D + ['teil="explosion"'], size=(1400, 1000), auto=True)],
        material=material(["Filament 1,75 mm für 11 Bolzen (mm): " + bl, "Kein Kleber"]),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Farbbauteile (Glaskern, Kolbenstangen, Handläufe, Spiegel) werden gesteckt; nur das dunkle Band am Oberwagen ist eine Farbzone (AMS/MMU)",
                     "Passung im Customizer: zylinder_spiel (kleiner = Stellung hält besser), einsatz_spiel (Dübel, Zungen), spiel"]),
        system=["Alle Gelenke sind Bolzen aus 1,75-mm-Filament: in den äußeren Teilen sitzen sie stramm, innen drehen sie sich lose.",
                "Ausleger und Stiel bestehen aus zwei Hälften mit Dübeln – so entstehen die Gabeln ohne Stützen.",
                "Die Kolbenstangen gleiten in den Rohren und halten Ausleger, Stiel und Löffel durch Reibung in jeder Stellung.",
                "Löffelgestänge wie beim Vorbild: Umlenkhebel am Stiel, Koppelstange zum Löffel, der Zylinder greift am gemeinsamen Gelenk an."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Kettenbagger", "kettenbagger.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Oberwagen dreht rundum. Ausleger 0–50°, Stiel und Löffel schwenken über den ganzen Arbeitsbereich.",
               "Hält eine Stellung nicht, zylinder_spiel verkleinern (Standard 0,1 mm) und die Kolbenstangen neu drucken.",
               "Bolzen bündig abschneiden; ein zu lockerer Bolzen hält mit einem Tropfen Kleber im äußeren Teil."])
