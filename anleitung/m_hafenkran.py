from common import *
from m_riesenrad import part

def model():
    scad = MOD("hafenkran")
    A = ANL("anl_hafenkran")
    D = ["massstab=43"]
    rot, hell, dunkel, beton = ("rot", "#c0392b"), ("weiß", "#ecf0f1"), ("dunkelblau", "#34495e"), ("grau", "#9e9e9e")
    parts = [
        part(scad, D, "schiene", "Kranschiene", 4, beton, 1, "2 Stränge à 2 Segmente"),
        part(scad, D, "fahrwerk", "Fahrwerk", 4, dunkel),
        part(scad, D, "portal_seite", "Portal-Seitenrahmen", 2, rot),
        part(scad, D, "portal_quer", "Portal-Querträger", 2, rot),
        part(scad, D, "plattform", "Portalplattform", 1, hell),
        part(scad, D, "zapfen", "Königszapfen", 1, ("grau", "#888888")),
        part(scad, D, "drehbuehne", "Drehbühne (Oberwagen)", 1, hell, 2),
        part(scad, D, "turm", "Turmseite", 2, rot),
        part(scad, D, "traverse", "Traverse", 1, dunkel),
        part(scad, D, "ausleger", "Wippausleger", 1, rot, 3),
        part(scad, D, "wippstange", "Zahnstange", 2, dunkel, 2),
        part(scad, D, "hakenflasche", "Haken", 1, ("gelb", "#f1c40f")),
        part(scad, D, "verbinder", "Clips", 1, ("grau", "#8a8f94"), 1, "12 Clips"),
    ]
    dd = D + ['teil="none"']
    cam = "-1100,-1500,1100,150,0,330"
    low = "-650,-900,600,0,0,120"
    def S(n, c=cam): return R(A, c, dd + [f"schritt={n}"])
    steps = [
        dict(title="Kranschienen", parts=[("schiene", 4), ("verbinder", 2)], text=["Je zwei Schienensegmente hintereinanderlegen und unten mit einem Clip verbinden."], render=S(1, low)),
        dict(title="Fahrwerke", parts=[("fahrwerk", 4)], text=["Die vier Fahrwerke auf die Schienen setzen."], render=S(2, low)),
        dict(title="Portal-Seitenrahmen", parts=[("portal_seite", 2)], text=["Die Seitenrahmen mit den Füßen in die Fahrwerke stecken."], render=S(3, low)),
        dict(title="Portal-Querträger", parts=[("portal_quer", 2)], text=["Querträger mit ihren Zapfen durch die Seitenrahmen stecken."], render=S(4, low)),
        dict(title="Plattform", parts=[("plattform", 1)], text=["Plattform aufsetzen – die Laschen greifen in die Löcher der Rahmen."], render=S(5, low)),
        dict(title="Königszapfen und Drehbühne", parts=[("zapfen", 1), ("drehbuehne", 1), ("verbinder", 4)],
             text=["Die beiden Hälften der Drehbühne verclipsen.", "Zapfen von unten fest in die Drehbühne drücken und die Drehbühne mit dem Zapfen in die Plattform setzen – sie dreht sich."],
             render=S(6, low)),
        dict(title="Turm und Traverse", parts=[("turm", 2), ("traverse", 1)], text=["Beide Turmseiten in die Drehbühne stecken, die Traverse zwischen die Turmseiten schieben."], render=S(7)),
        dict(title="Wippausleger", parts=[("ausleger", 1), ("verbinder", 4)],
             text=["Die 3 Auslegerstücke verclipsen.", "Ausleger mit einem Filamentstift (Ø 1,75 mm, ca. 44 mm) am Turm lagern – er kippt."], render=S(8)),
        dict(title="Zahnstangen", parts=[("wippstange", 2), ("verbinder", 2)],
             text=["Die Zahnstangen mit einem Stift am Ausleger einhängen.", "Gewünschten Wippwinkel wählen und je einen Stift durch das passende Loch im Lager stecken."], render=S(9)),
        dict(title="Haken", parts=[("hakenflasche", 1)], text=["Einen Faden durch das Loch im Auslegerkopf fädeln und den Haken anknoten."], render=S(10)),
    ]
    return dict(
        title="Hafenkran", subtitle="Portal-Wippdrehkran – drehbar, Ausleger in 5 Stufen verstellbar", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "-1100,-1500,1100,150,0,330", D, (1500, 1300)),
        final_renders=[R(scad, "-1100,-1500,1100,150,0,330", D + ["stufe=5", "drehung=60"], (1300, 1200)),
                       R(scad, "-1100,-1500,1100,150,0,330", D + ["stufe=1", "drehung=0"], (1300, 1200))],
        material=material(["Filament-Stücke Ø 1,75 mm: Auslegerlager ca. 44 mm, Zahnstange ca. 56 mm, 2 × Lager ca. 15 mm", "Nähfaden für den Haken"]),
        druck=druck(["Fachwerke (Rahmen, Turm, Ausleger) flach, Drehbühne aufrecht – Löcher sind senkrecht oder als Tropfen geformt"]),
        system=SYSTEM_CLIP + ["Beweglich: Der Oberwagen dreht auf dem Königszapfen, der Ausleger kippt am Turm, der Wippwinkel wird über die Zahnstangen eingerastet."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Hafenkran", "hafenkran.scad"),
        final=["Wippwinkel ändern: Stifte aus dem Lager ziehen, Ausleger kippen, Stift ins nächste Loch – die Lochabstände passen genau zu den Winkeln in „wippwinkel“.",
               "Oberwagen drehen und das Portal auf den Schienen fahren lassen."])
