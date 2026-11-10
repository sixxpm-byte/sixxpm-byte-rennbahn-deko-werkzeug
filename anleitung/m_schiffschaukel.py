from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"ss{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def model(mst=43):
    scad = MOD("schiffschaukel")
    A = ANL("anl_schiffschaukel")
    D = [f"massstab={mst}"]
    log = echo(scad, mst)
    m = re.search(r"Filament-Stift Ø [\d.]+ x ([\d.]+) mm", log); stift = f"{float(m.group(1)):.0f}" if m else "10"
    geteilt = mst == 43
    andere = 87 if mst == 43 else 43
    names = {"bodenplatte": "Bodenplatte", "verbinder": "Clips", "zaun_vorne": "Zaun vorne", "zaun_hinten": "Zaun hinten", "zaun_seite": "Zaun Seite",
             "tor": "Ausgangstor", "abock": "A-Bock", "plattform": "Plattform", "achszapfen": "Achszapfen", "rumpf": "Rumpfkern",
             "duebel_mitte": "Dübel Rumpfmitte", "bordwand": "Bordwand", "grossmast": "Großmast", "mast": "Fock-/Besanmast", "bugspriet": "Bugspriet",
             "arm": "Schwingarm", "duebel_lang": "Dübel lang", "duebel_kurz": "Dübel kurz", "rampe": "Einstiegsrampe",
             "laterne": "Laternensäule", "laternenkopf": "Laternenkopf",
             "haus_boden": "Kasse Boden", "haus_wand_vorne": "Kasse Wand vorne", "haus_wand_hinten": "Kasse Wand hinten",
             "haus_wand_links": "Kasse Wand links", "haus_wand_rechts": "Kasse Wand rechts", "haus_dach": "Kasse Dach", "haus_schild": "Kasse Schild"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    lage = {"bodenplatte": "aufrecht", "abock": "flach", "plattform": "aufrecht", "achszapfen": "liegt flach", "rumpf": "auf der Seite stehend",
            "bordwand": "flach, Außenseite oben", "grossmast": "flach, Segel unten", "mast": "flach, Segel unten", "bugspriet": "flach",
            "arm": "flach", "duebel_lang": "liegt flach", "duebel_kurz": "liegt flach", "duebel_mitte": "liegt flach", "rampe": "auf der Seite, Geländer unten",
            "laterne": "aufrecht", "laternenkopf": "aufrecht", "tor": "flach", "zaun_vorne": "flach", "zaun_hinten": "flach", "zaun_seite": "flach"}
    for p in parts:
        if p["id"] in lage: p["info"] = lage[p["id"]]
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    V1, V2 = "0,0,0,62,0,335,0", "0,0,0,60,0,25,0"
    def S(n, cam=V1, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    steps = [
        dict(title="Bodenplatte und Zaun", parts=P("bodenplatte", "verbinder", "zaun_vorne", "zaun_hinten", "zaun_seite", "tor"),
             text=(["Plattenhälften mit 3 Clips von unten verbinden."] if geteilt else []) + ["Zaun und Tor mit den Zungen in die Schlitze am Rand stecken."], render=S(1)),
        dict(title="A-Böcke", parts=P("abock", "plattform", "achszapfen"),
             text=["A-Böcke in die Schlitze stecken, Plattformen oben aufsetzen.",
                   "Achszapfen von innen in die Rautenlöcher der Lagerköpfe drücken."], render=S(2)),
        dict(title="Rumpf", parts=P("rumpf", "duebel_mitte", "bordwand"),
             text=(["Kernhälften mit den 2 Mitteldübeln verbinden."] if geteilt else []) + ["Bordwände links und rechts an den Kern legen (Löcher deckungsgleich)."], render=S(3)),
        dict(title="Masten", parts=P("grossmast", "mast", "bugspriet"),
             text=["Großmast in die Mitte, Fock- und Besanmast auf die Lehnen stecken.",
                   "Bugspriet vorne ins Backdeck stecken."], render=S(4)),
        dict(title="Schiff einhängen", parts=P("arm", "duebel_lang", "duebel_kurz"),
             text=["Schwingarme auf die Achszapfen schieben, Schiff dazwischen halten.",
                   "Lange Dübel durch Arm, Bordwand, Kern, Bordwand und Arm; kurze Dübel an den Enden."], render=S(5, V2)),
        dict(title="Einstiegsrampen", parts=P("rampe"),
             text=["Rampen auf beiden Seiten in die Schlitze stecken – der Steg führt unter dem Arm bis an die Bordwand."], render=S(6, V2)),
        dict(title="Arretierung und Laterne", parts=P("laterne", "laternenkopf"),
             text=[f"Schiff in eine Raststellung schwenken, Filament-Stück (ca. {stift} mm) durch Knotenblech und Rastbogen stecken.",
                   "Laternensäule aufstellen, Kopf aufstecken."], render=S(7),
             inset=dict(scad=A, cam="0,0,0,75,0,200,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True), inset_txt="Arretierung"),
        dict(title="Kassenhäuschen", parts=P("haus_boden", "haus_wand_vorne", "haus_wand_hinten", "haus_wand_links", "haus_wand_rechts", "haus_dach", "haus_schild"),
             text=["Wände in die Nuten des Bodens stellen, Dach aufsetzen – es hält die Wände.",
                   "Schild in die Löcher des Dachs stecken."], render=dict(scad=A, cam="0,0,0,60,0,30,0", defs=dd + ["nur_haus=1"], size=(1300, 1100), auto=True)),
    ]
    extra = f"In 1:{andere} sind die Bauschritte gleich" + (" – Bodenplatte, Rumpfkern und Bordwände sind dort einteilig." if geteilt else "; Bodenplatte, Rumpfkern und Bordwände sind dort zweiteilig.")
    return dict(
        title="Schiffschaukel", cover_note="FDM, alle Teile stützfrei", subtitle="Piratenschiff zum Pendeln – mit Raststellungen, Einstiegsrampen und Kassenhäuschen",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,68,0,335,0", defs=D, size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,85,0,0,0", defs=D + ["schaukel_stufe=-2", "kassenhaus_zeigen=false"], size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,330,0", defs=D + ['teil="explosion"'], size=(1400, 1000), auto=True)],
        material=material([f"Filament 1,75 mm: ein Stück ca. {stift} mm je Seite als Arretier-Stift", "Kein Kleber"]),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Segel, Flagge und Zierleiste sind Farbzonen (AMS/MMU) – einfarbig einfach in einer Farbe drucken",
                     "Passung im Customizer: einsatz_spiel (Dübel, Zungen, Achszapfen), spiel (Achse der Arme, Clips)"]),
        system=["Das Schiff hängt an zwei Schwingarmen, die sich auf den Achszapfen der A-Böcke drehen.",
                "Lange Dübel gehen quer durch Arme, Bordwände und Rumpfkern – so hält das Schiff ohne Kleber.",
                "Raststellungen: Ein Filament-Stück durch das Loch im Knotenblech und den Rastbogen sichert das Schiff (−40° bis +40°)."]
               + (["Bodenplatte mit Clips, Rumpfkern mit Mitteldübeln – Bordwände über die Teilung gelegt."] if geteilt else []),
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Schiffschaukel", "schiffschaukel.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Ohne Stift pendelt das Schiff frei, mit Stift steht es in einer der Raststellungen.",
               "Im Customizer: 3 oder 5 Raststellungen und der Winkel je Stufe, Schildtext der Kasse, alle Farben.",
               "Die Rampen führen bis an die Bordwand – so steigen die Passagiere in jeder Seite ein und aus."])
