from common import *

def model():
    scad = MOD("tribuene")
    A = ANL("anl_tribuene")
    D = ["massstab=43", 'anordnung="KBTBTBK"']
    names = {f"sitze_kurve_aussen_{i}": f"Sitzreihe Kurve – Reihe {i}" for i in range(1, 21)}
    names.update({"block": "Tribünenblock", "treppe": "Treppenblock", "kurve_aussen": "Kurvensegment", "sitze_block": "Sitzreihe Block",
                  "gelaender_block": "Geländer Block", "gelaender_treppe": "Geländer Treppe", "gelaender_kurve_aussen_vorne": "Geländer Kurve vorn",
                  "gelaender_kurve_aussen_hinten": "Geländer Kurve hinten", "bande_1": "Werbebande RACING", "bande_2": "Werbebande TURBO",
                  "bande_3": "Werbebande PIT STOP", "binder_block": "Dachbinder gerade", "binder_kurve_aussen": "Dachbinder Kurve",
                  "dach_block": "Dach Block", "dach_treppe": "Dach Treppe", "dach_kurve_aussen": "Dach Kurve", "fahne": "Zielflagge", "verbinder": "Clips"})
    parts, _ = druck_parts(scad, D, names)
    for p in parts:
        if p["id"].startswith("sitze_kurve"): p["info"] = "Reihe vorne = 1, hinten = 8"
        if p["id"] == "verbinder": p["info"] = "Clip-Platte"
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    far = "-300,-1500,1000,356,-190,60"
    near = "120,-640,430,420,-90,50"
    steps = [
        dict(title="Mittleren Block aufstellen", parts=P("block")[:1] and [("block", 1)],
             text=["Den ersten Tribünenblock in die Mitte stellen – die Stirnwand zeigt zur Strecke."],
             render=R(A, near, dd + ["schritt=1"])),
        dict(title="Treppen ansetzen und verclipsen", parts=[("treppe", 2), ("verbinder", 8)],
             text=["Je einen Treppenblock links und rechts an den Block schieben.", "Unten an jedem Stoß 4 Clips in die Taschen drücken (Detail)."],
             render=R(A, near, dd + ["schritt=2"]),
             inset=R(A, "-80,-150,120,0,60,-10", dd + ["schritt=2", "detail=1"], (1000, 800)), inset_txt="Unterseite (Teile umgedreht)"),
        dict(title="Weitere Blöcke und Kurven", full=True, parts=[("block", 2), ("kurve_aussen", 4), ("verbinder", 24)],
             text=["Außen je einen Block, dann je zwei Kurvensegmente ansetzen – jedes Mal 4 Clips pro Stoß.",
                   "Die Reihenfolge legt der Parameter „anordnung“ fest (hier K B T B T B K)."],
             render=R(A, far, dd + ["schritt=3"])),
        dict(title="Seitenwände", full=True, parts=P("seitenwand_links", "seitenwand_rechts"),
             text=["Die Zapfen der Seitenwände in die Löcher an den Enden stecken."],
             render=R(A, far, dd + ["schritt=4"])),
        dict(title="Sitzreihen aufstecken", full=True, parts=P("sitze_block", "sitze_kurve_aussen_1", "sitze_kurve_aussen_8"),
             text=["Jede Sitzreihe auf die Zapfen ihrer Stufe drücken.", "Kurven: Reihe 1 ganz vorne, Reihe 8 ganz hinten (Nummer im Dateinamen)."],
             render=R(A, far, dd + ["schritt=5"])),
        dict(title="Geländer und Werbebanden", full=True,
             parts=P("gelaender_block", "gelaender_treppe", "gelaender_kurve_aussen_vorne", "gelaender_kurve_aussen_hinten", "bande_1", "bande_2", "bande_3"),
             text=["Geländer vorne auf die Stirnwand und hinten auf den Umgang stecken.",
                   "Werbebanden mit den Zapfen in die Löcher der Stirnwand drücken."],
             render=R(A, far, dd + ["schritt=6"])),
        dict(title="Dachbinder", full=True, parts=P("binder_block", "binder_kurve_aussen"),
             text=["Binder senkrecht in die Köcher im oberen Umgang stecken (gerade Binder in Blöcke und Treppen, Kurvenbinder in die Kurven)."],
             render=R(A, far, dd + ["schritt=7"])),
        dict(title="Dachflächen", full=True, parts=P("dach_block", "dach_treppe", "dach_kurve_aussen"),
             text=["Dachflächen mit den Taschen auf die Zapfen der Binder legen – der Schriftzug zeigt zur Strecke."],
             render=R(A, far, dd + ["schritt=8"])),
        dict(title="Zielflaggen", full=True, parts=P("fahne"),
             text=["Ein Stück Filament (Ø 1,75 mm, ca. 79 mm) in die Hülse auf dem Dach stecken.", "Fahne mit der Masthülse aufschieben – sie dreht sich im Wind."],
             render=R(A, far, dd + ["schritt=9"])),
    ]
    return dict(
        title="Zuschauertribüne", subtitle="Modularer Bausatz – Block, Treppe, Kurve, Dach", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "-150,-1350,860,380,-190,70", D, (2000, 1200)),
        final_renders=[R(scad, "-230,-600,470,240,100,70", ["massstab=43", 'anordnung="BTBTB"'], (1600, 1100)),
                       R(scad, "-90,-150,190,70,80,85", ["massstab=43", 'anordnung="BTB"'], (1600, 1100))],
        material=material(["Filament-Stück Ø 1,75 mm für die Fahnen (7 × ca. 8 cm)"]),
        druck=druck(["Tribünenkörper: Unterseite ist offen, die Stufen werden zwischen den Rippen überbrückt (max. ca. 28 mm)",
                     "Werbebanden mit der Schrift nach unten – die Schrift ist ein Farb-Einleger in den ersten Schichten",
                     "Geländer: das Glas steckt im Falz und lässt sich einzeln drucken und von der Rückseite eindrücken (Passung: einsatz_spiel); Schrift, Kanten und Fahne brauchen AMS/MMU – oder die 3MF einfarbig drucken"]),
        system=SYSTEM_CLIP + ["Jedes Modulende hat dieselben Taschen: Blöcke (B), Treppen (T) und Kurven (K / I) lassen sich beliebig kombinieren und später erweitern."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Tribüne", "tribuene.scad", "Die Teileliste gilt für die Anordnung K B T B T B K (584 Plätze)."),
        final_title="Erweitern, bewegen, Tipps",
        final=["Mehr Plätze: in „anordnung“ weitere Buchstaben ergänzen (B, T, K, I) und nur die neuen Teile drucken.",
               "Die Zielflaggen drehen sich auf ihrem Stift. Dach, Sitzreihen, Geländer und Banden sind nur gesteckt und abnehmbar.",
               "Werbetexte, Dach-Schriftzug, Sitzfarben und Reihenanzahl lassen sich im Customizer ändern."])
