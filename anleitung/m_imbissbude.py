from common import *
from m_riesenrad import part

def model():
    scad = MOD("imbissbude")
    A = ANL("anl_imbissbude")
    D = ["massstab=43"]
    holz, grau, dach, theke, rot = ("holzbraun", "#b07a45"), ("betongrau", "#a7a39b"), ("dunkelgrau", "#5b5f63"), ("creme", "#d8d2c4"), ("rot", "#c0392b")
    parts = [
        part(scad, D, "basis", "Bodenplatte", 1, grau, 1, "mit Küchenzeile"),
        part(scad, D, "wand_links", "Wand links (Tür)", 1, holz),
        part(scad, D, "wand_rechts", "Wand rechts", 1, holz),
        part(scad, D, "wand_vorne", "Wand vorne (Fenster)", 1, holz),
        part(scad, D, "wand_hinten", "Wand hinten", 1, holz),
        part(scad, D, "theke", "Theke", 1, theke),
        part(scad, D, "dach", "Dach", 1, dach),
        part(scad, D, "schild", "Dachschild", 1, None, fps=[("A", "#f4f1ea", "weiß"), ("B", "#c0392b", "rot")]),
        part(scad, D, "klappe", "Verkaufsklappe", 1, rot),
        part(scad, D, "stuetzen", "Klappenstützen", 1, ("grau", "#9aa0a6"), 1, "2 Stück auf einer Platte"),
        part(scad, D, "zubehoer", "Zubehör", 1, ("bunt", "#2e6b3a"), 1, "Tische, Tonne, Gasflaschen, Kisten"),
    ]
    dd = D + ['teil="none"']
    cam = "-90,-200,170,35,25,40"
    def S(n, c=cam): return R(A, c, dd + [f"schritt={n}"])
    steps = [
        dict(title="Bodenplatte", parts=[("basis", 1)], text=["Die Bodenplatte hinstellen – die Küchenzeile steht hinten."], render=S(1)),
        dict(title="Seitenwände", parts=[("wand_links", 1), ("wand_rechts", 1)], text=["Beide Seitenwände in die Nut der Bodenplatte stellen."], render=S(2)),
        dict(title="Vorder- und Rückwand", parts=[("wand_vorne", 1), ("wand_hinten", 1)],
             text=["Verkaufswand vorne und Rückwand hinten außen an die Seitenwände in die Nut stellen."], render=S(3)),
        dict(title="Theke", parts=[("theke", 1)], text=["Die Theke durch das Fenster schieben und auf die Brüstung setzen."], render=S(4)),
        dict(title="Dach", parts=[("dach", 1)], text=["Dach aufsetzen – es hält alle Wände zusammen."], render=S(5)),
        dict(title="Dachschild", parts=[("schild", 1)], text=["Schild mit den Zapfen in die Löcher des Dachs stecken."], render=S(6)),
        dict(title="Verkaufsklappe", parts=[("klappe", 1)],
             text=["Klappe an die Scharnieraugen halten und ein Filamentstück (Ø 1,75 mm, ca. 50 mm) seitlich durchschieben."], render=S(7)),
        dict(title="Klappenstützen", parts=[("stuetzen", 1)], text=["Klappe hochklappen, die beiden Stützen in Theke und Klappe stecken."], render=S(8)),
        dict(title="Zubehör", parts=[("zubehoer", 1)], text=["Stehtische, Mülltonne, Gasflaschen und Getränkekisten aufstellen."], render=S(9)),
    ]
    return dict(
        title="Imbissbude", subtitle="mit Verkaufsklappe, Theke und Zubehör", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "-110,-230,190,35,25,40", D, (1600, 1250)),
        final_renders=[R(scad, "-110,-230,190,35,25,40", D, (1400, 1100)), R(scad, "160,200,160,35,25,40", D, (1400, 1100))],
        material=material(["Filament-Stück Ø 1,75 mm für das Klappenscharnier (ca. 5 cm)"]),
        druck=druck(["Wände liegend (Außenseite oben), Dach kopfüber, Klappe mit Außenseite auf dem Bett"]),
        system=["Die Bude wird nur gesteckt: Wände stehen in der Nut der Bodenplatte, das Dach hält alles zusammen.",
                "An den Stirnseiten der Bodenplatte sitzen Clip-Taschen – damit lässt sich die Bude an Leitplanken & Co. der Rennbahn-Deko clipsen.",
                "Beweglich: Die Verkaufsklappe schwenkt auf einem Filamentstift und wird von zwei Stützen gehalten."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Imbissbude", "imbissbude.scad"),
        final=["Klappe öffnen und schließen – ohne Stützen hängt sie herunter.",
               "Schild-Text, Fassade (Holz, Blech, Putz) und Zubehör-Anzahl im Customizer ändern."])
