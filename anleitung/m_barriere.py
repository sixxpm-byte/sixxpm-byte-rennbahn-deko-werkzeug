from common import *
from m_riesenrad import part

def model():
    scad = MOD("barriere_zaun")
    A = ANL("anl_barriere")
    D = ["massstab=43"]
    beton, stahl, draht = ("beton", "#cfcac0"), ("stahl", "#a9b0b6"), ("silber", "#c9ced3")
    parts = [part(scad, D, "barriere", "Barriere", 4, beton, 1, "beliebig viele"),
             part(scad, D, "pfosten", "Doppelpfosten (Fuge)", 3, stahl, 1, "1 je Fuge"),
             part(scad, D, "endpfosten", "Endpfosten", 2, stahl, 1, "Anfang + Ende (einmal umgedreht)"),
             part(scad, D, "zaunfeld", "Zaunfeld", 4, draht, 1, "Rautengeflecht")]
    dd = D + ['teil="none"']
    cam = "-260,-640,400,180,0,40"
    def S(n, c=cam): return R(A, c, dd + [f"schritt={n}"])
    steps = [
        dict(title="Barrieren aufstellen", parts=[("barriere", 4)], text=["Die Betonelemente Stirn an Stirn in einer Reihe aufstellen."], render=S(1)),
        dict(title="Pfosten einstecken", parts=[("pfosten", 3), ("endpfosten", 2)],
             text=["Doppelpfosten auf jede Fuge stellen: je ein Fußzapfen links und rechts der Fuge – so werden die Barrieren verbunden.",
                   "An Anfang und Ende je einen Endpfosten stecken (der rechte wird umgedreht)."], render=S(2)),
        dict(title="Zaunfelder", parts=[("zaunfeld", 4)], text=["Die Zaunfelder von der Fahrbahnseite mit den Stiften in die Löcher der Pfosten drücken."], render=S(3)),
    ]
    return dict(
        title="Barriere mit Fangzaun", subtitle="Betonschutzwand mit Doppelpfosten und Rautengeflecht", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "-260,-640,400,180,0,40", D, (1800, 1100)),
        final_renders=[R(scad, "60,-260,160,60,0,40", D, (1600, 1100))],
        material=material(),
        druck=druck(["Barriere aufrecht, Pfosten und Zaunfelder flach (Fahrbahnseite nach unten, Stifte zeigen nach oben)",
                     "Feines Geflecht: Düse 0,4 mm, langsam drucken – bei Bedarf masche_mm im Customizer vergrößern"]),
        system=["Die Pfosten verbinden die Barrieren: Jeder Doppelpfosten greift mit zwei Fußzapfen in beide Nachbarelemente.",
                "Die Zaunfelder werden nur gesteckt – einzelne Felder lassen sich austauschen.",
                "Optional: Clip-Taschen unten an den Enden (Rennbahn-System) zum Anschluss an Leitplanken & Co."],
        clip_png=None,
        massstab_hinweis=hinweis("Barriere", "barriere_zaun.scad", "Die Stückzahlen gelten für eine Reihe aus 4 Elementen."),
        final=["Für längere Reihen je Element 1 Barriere, 1 Pfosten und 1 Zaunfeld zusätzlich drucken.",
               "Zaunhöhe, Maschenweite und Pfosten pro Element im Customizer ändern."])
