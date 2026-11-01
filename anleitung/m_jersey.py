from common import *

def two(scad, D, pid, name, n, info=""):
    d = D + [f'teil="{pid}"', "stueck=0"]
    return dict(id=pid, name=name, count=n, pieces=1, info=info,
                exports=[(d, "#cfcac0", "alle")], colors=[("beton", "#cfcac0")])

def model():
    scad = MOD("jersey_barrier")
    A = ANL("anl_jersey")
    D = ["massstab=43"]
    parts = [two(scad, D, "endstueck_anfang", "Endstück Anfang", 1, "Rampe"), two(scad, D, "element", "Element", 5, "beliebig viele"),
             two(scad, D, "endstueck_ende", "Endstück Ende", 1, "Rampe"),
             dict(id="verbinder", name="Gelenk-Verbinder", count=1, pieces=1, info="6 Gelenke auf einer Platte",
                  exports=[(D + ['teil="verbinder"'], "#555555", "alle")], colors=[("dunkelgrau", "#555555")])]
    dd = D + ['teil="none"']
    cam = "-160,-560,430,260,90,0"
    def S(n, c=cam): return R(A, c, dd + [f"schritt={n}"])
    steps = [
        dict(title="Anfangs-Endstück", parts=[("endstueck_anfang", 1)], text=["Das Endstück mit der Rampe an den Anfang der Reihe stellen."], render=S(1)),
        dict(title="Element mit Gelenk ansetzen", parts=[("element", 1), ("verbinder", 1)],
             text=["Den Knochen-Verbinder von unten in die Taschen beider Teile drücken.", "Die Fuge bleibt beweglich (bis ±15°) – so entstehen Kurven aus geraden Elementen."],
             render=S(2)),
        dict(title="Weitere Elemente", full=True, parts=[("element", 4), ("verbinder", 4)],
             text=["Beliebig viele Elemente genauso anhängen und jede Fuge auf den gewünschten Winkel knicken."], render=S(6)),
        dict(title="End-Endstück", parts=[("endstueck_ende", 1), ("verbinder", 1)], text=["Die Reihe mit dem zweiten Rampen-Endstück abschließen."], render=S(7)),
    ]
    return dict(
        title="Jersey Barrier", subtitle="Betonschutzwand – Elemente mit Gelenk, Kurven möglich", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "-160,-560,430,260,90,0", D, (1800, 1100)),
        final_renders=[R(scad, "-160,-560,430,260,90,0", D + ["vorschau_knick=-6", 'farbmuster="streifen"'], (1600, 1000))],
        material=material(),
        druck=druck(["Elemente aufrecht auf der Standfläche – alle Flächen neigen sich nach innen, Staplertaschen mit Spitzbogen"]),
        system=["Gelenk-Verbinder (Standard): verdeckter Knochen unter den Elementen – die Fugen bleiben drehbar.",
                "Alternativ im Customizer: T-Lock (senkrechter Schwalbenschwanz, starr) oder Rennbahn-Clip (kompatibel zu Leitplanke & Co.).",
                "Optional rot-weiße Streifen und gelbe Reflektoren als zweite Farbe (farbteil B)."],
        clip_png=None,
        massstab_hinweis=hinweis("Jersey Barrier", "jersey_barrier.scad"),
        final=["Jede Fuge lässt sich knicken – die Reihe folgt so jeder Streckenführung.",
               "Profil (New Jersey, F-Shape …), Höhe, Elementlänge und Bogenwinkel im Customizer ändern."])
