from common import *

def P(scad, D, pid, name, count, col, info=""):
    return dict(id=pid, name=name, count=count, pieces=1, exports=[(D + [f'part="{pid}"'], col[1], "alle")], colors=[col], info=info)

def model():
    scad = MOD("container_40ft")
    A = ANL("anl_container")
    D = ["scale_denominator=87"]
    blau, dunkel = ("blau", "#2F5F8F"), ("schwarz", "#3a3a3a")
    parts = [
        P(scad, D, "floor", "Boden", 1, dunkel, "kopfüber gedruckt"),
        P(scad, D, "front_wall", "Stirnwand", 1, blau),
        P(scad, D, "rear_frame", "Türrahmen", 1, blau),
        P(scad, D, "side_wall", "Seitenwand", 2, blau),
        P(scad, D, "door_left", "Türflügel links", 1, blau),
        P(scad, D, "door_right", "Türflügel rechts", 1, blau),
        P(scad, D, "pin", "Scharnierstift", 2, ("silber", "#c0c4c8"), "oder Filament Ø 1,75"),
        P(scad, D, "roof", "Dach", 1, blau),
    ]
    dd = D + ['part="none"']
    cam = "320,-280,220,70,14,15"
    def S(n, c=cam): return R(A, c, dd + [f"schritt={n}"])
    steps = [
        dict(title="Boden", parts=[("floor", 1)], text=["Den Boden mit den Eckbeschlägen nach unten hinlegen."], render=S(1)),
        dict(title="Stirnwand und Türrahmen", parts=[("front_wall", 1), ("rear_frame", 1)], text=["Stirnwand vorne und Türrahmen hinten mit ihren Zapfen in den Boden stecken."], render=S(2)),
        dict(title="Seitenwände", parts=[("side_wall", 2)], text=["Beide Seitenwände in die Nuten des Bodens stellen."], render=S(3)),
        dict(title="Türflügel", parts=[("door_left", 1), ("door_right", 1), ("pin", 2)],
             text=["Türflügel an die Laschen des Rahmens halten.", "Stift (oder Filament Ø 1,75 mm, ca. 25 mm) von oben durch alle Scharnieraugen schieben – er liegt unten auf dem Boden auf."],
             render=S(4)),
        dict(title="Dach", parts=[("roof", 1)], text=["Dach aufsetzen – es hält Wände, Pfosten und Stifte fest."], render=S(5)),
    ]
    return dict(
        title="40-Fuß-Container", subtitle="ISO-Container mit beweglichen Flügeltüren", scale_txt="1:87 (H0)",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "330,-300,230,70,14,15", D, (1600, 1100)),
        final_renders=[R(scad, "330,-300,230,70,14,15", D, (1400, 1000)), R(scad, "-140,-220,160,70,14,15", D, (1400, 1000))],
        material=material(["Filament-Stück Ø 1,75 mm als Scharnierstift (2 × ca. 25 mm), falls die Stifte nicht gedruckt werden"]),
        druck=druck(["Boden kopfüber, Wände und Türen mit der Innenseite nach unten, Stirnwand stehend"]),
        system=["Der Container wird nur gesteckt: Zapfen und Nuten halten die Wände, das Dach sichert alles.",
                "Beweglich: Die Türflügel drehen sich auf einem Stift und öffnen bis ca. 180°.",
                "Der Spreader der Containerbrücke passt auf diesen Container."],
        clip_png=None,
        massstab_hinweis="Diese Anleitung zeigt den Maßstab 1:87 (H0) – der Container ist in 1:43 länger als 22 cm. Maßstab in container_40ft.scad über scale_denominator wählen (z. B. 160 = N, 120 = TT, 87 = H0, 64). High Cube über high_cube.",
        final=["Türen öffnen und schließen – sie drehen frei auf dem Stift.", "Farbe und High-Cube-Variante im Customizer ändern."])
