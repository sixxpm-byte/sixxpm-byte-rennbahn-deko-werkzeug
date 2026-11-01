from common import *
from m_riesenrad import part

def model():
    scad = MOD("boxengarage")
    A = ANL("anl_boxengarage")
    D = ["massstab=43"]
    wand, tor, dach, gel = ("weißgrau", "#e4e4e1"), ("silbergrau", "#b9bec4"), ("dunkelgrau", "#5c6066"), ("grau", "#8a9096")
    parts = [
        part(scad, D, "boden", "Bodenplatte", 3, None, fps=[("A", "#9c9a96", "grau"), ("B", "#f2c200", "gelb")]),
        part(scad, D, "endwand_links", "Endwand links", 1, wand),
        part(scad, D, "endwand_rechts", "Endwand rechts", 1, wand),
        part(scad, D, "trennwand", "Trennwand", 2, wand),
        part(scad, D, "rueckwand", "Rückwand", 3, wand),
        part(scad, D, "tor", "Rolltor", 3, tor),
        part(scad, D, "torblende", "Torblende", 3, None, fps=[("A", "#1f4e9c", "blau"), ("B", "#f5f5f5", "weiß")], info="Boxnummer im Customizer"),
        part(scad, D, "dach", "Dach", 3, dach),
        part(scad, D, "gelaender", "Dachgeländer", 3, gel),
        part(scad, D, "zubehoer", "Zubehör", 1, ("bunt", "#c0392b"), 1, "Werkzeugwagen, Reifen, Tank …"),
        part(scad, D, "verbinder", "Clips", 1, ("grau", "#8a8f94"), 1, "14 Clips"),
    ]
    dd = D + ['teil="none"']
    cam = "-430,-830,620,130,90,80"
    def S(n, c=cam): return R(A, c, dd + [f"schritt={n}"])
    steps = [
        dict(title="Bodenplatten verclipsen", parts=[("boden", 3), ("verbinder", 14)],
             text=["Die Bodenplatten nebeneinanderlegen, umdrehen und an jeder Fuge Clips in die Taschen drücken."], render=S(1)),
        dict(title="End- und Trennwände", parts=[("endwand_links", 1), ("endwand_rechts", 1), ("trennwand", 2)],
             text=["Die Endwände außen, die Trennwände genau auf die Fugen in die Nuten stellen."], render=S(2)),
        dict(title="Rückwände", parts=[("rueckwand", 3)], text=["Rückwände von oben in die hinteren senkrechten Nuten schieben."], render=S(3)),
        dict(title="Rolltore", parts=[("tor", 3)], text=["Rolltore von oben in die mittleren Nuten schieben – sie bleiben in jeder Höhe stehen."], render=S(4)),
        dict(title="Torblenden", parts=[("torblende", 3)], text=["Blenden mit Teamname und Boxnummer in die vorderen Nuten schieben."], render=S(5)),
        dict(title="Dächer", parts=[("dach", 3)], text=["Dachplatten auflegen – sie halten alle Wände zusammen."], render=S(6)),
        dict(title="Dachgeländer", parts=[("gelaender", 3)], text=["Geländer in die Löcher am Dachrand stecken."], render=S(7)),
        dict(title="Zubehör", parts=[("zubehoer", 1)], text=["Tore hochschieben und Werkzeugwagen, Reifenstapel & Co. in die Boxen stellen."], render=S(8)),
    ]
    return dict(
        title="Boxengarage", subtitle="Modulare Boxenreihe mit Rolltoren – hier 3 Boxen", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "-430,-830,620,130,90,80", D, (1800, 1200)),
        final_renders=[R(scad, "-430,-830,620,130,90,80", D + ["tor_offen=[1, 0.5, 0]"], (1500, 1100))],
        material=material(),
        druck=druck(["Platten flach, Wände liegend, Dach kopfüber, Endwände mit der Außenseite nach unten"]),
        system=SYSTEM_CLIP + ["Erweiterbar: Jede weitere Box braucht Bodenplatte, Rückwand, Tor, Blende, Dach, Geländer und eine Trennwand (anzahl_boxen im Customizer)."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Boxengarage", "boxengarage.scad", "Die Stückzahlen gelten für 3 Boxen."),
        final=["Rolltore nach oben schieben – sie verschwinden hinter der Blende und bleiben durch zwei Federzungen in jeder Höhe stehen.",
               "Teamname, Boxnummern, Anzahl der Boxen und Zubehör im Customizer ändern."])
