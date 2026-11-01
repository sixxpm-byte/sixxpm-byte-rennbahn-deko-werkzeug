from common import *
from m_riesenrad import part

def model():
    scad = MOD("containerbruecke")
    A = ANL("anl_containerbruecke")
    D = ["massstab=43"]
    blau, weiss, dunkel, beton, gelb = ("blau", "#1f5fa8"), ("weiß", "#ecf0f1"), ("dunkelblau", "#2c3e50"), ("grau", "#9e9e9e"), ("gelb", "#f1c40f")
    parts = [
        part(scad, D, "schiene", "Kranschiene", 8, beton, 1, "2 Stränge à 4 Segmente"),
        part(scad, D, "fahrwerk", "Fahrwerk", 4, dunkel),
        part(scad, D, "portalrahmen", "Portalrahmen", 2, blau, 10),
        part(scad, D, "konsole", "Trägerkonsole", 4, blau),
        part(scad, D, "mastriegel", "Mastriegel", 1, blau, 2),
        part(scad, D, "traeger_links", "Brückenträger links", 1, weiss, 4),
        part(scad, D, "traeger_rechts", "Brückenträger rechts", 1, weiss, 4),
        part(scad, D, "endriegel", "Endriegel", 1, weiss, 2),
        part(scad, D, "ausleger_links", "Ausleger links", 1, weiss, 4),
        part(scad, D, "ausleger_rechts", "Ausleger rechts", 1, weiss, 4),
        part(scad, D, "spitzenriegel", "Spitzenriegel", 1, weiss, 2),
        part(scad, D, "maschinenhaus", "Maschinenhaus", 1, weiss, 2),
        part(scad, D, "katze", "Laufkatze", 1, gelb, 2),
        part(scad, D, "kabine", "Fahrerkabine", 1, gelb),
        part(scad, D, "spreader", "Spreader", 1, dunkel, 2),
        part(scad, D, "verbinder", "Clips", 1, ("grau", "#8a8f94"), 1, "125 Clips (mehrere Platten)"),
    ]
    dd = D + ['teil="none"']
    cam = "-2600,-1400,2100,0,300,450"
    low = "-1500,-1200,900,0,0,100"
    def S(n, c=cam): return R(A, c, dd + [f"schritt={n}"])
    steps = [
        dict(title="Kranschienen", parts=[("schiene", 8), ("verbinder", 6)], text=["Je vier Segmente hintereinanderlegen und an den Stößen unten verclipsen."], render=S(1, low)),
        dict(title="Fahrwerke", parts=[("fahrwerk", 4)], text=["Die vier Fahrwerke auf die Schienen setzen."], render=S(2, low)),
        dict(title="Portalrahmen", parts=[("portalrahmen", 2), ("verbinder", 46)],
             text=["Jeden Rahmen aus seinen 10 Stücken zusammenclipsen (Teile umdrehen, Clips in die Stoßplatten).", "Rahmen mit den Beinen in die Fahrwerke stecken."], render=S(3)),
        dict(title="Trägerkonsolen", parts=[("konsole", 4)], text=["Je zwei Konsolen mit dem Zapfen durch jeden Portalrahmen stecken."], render=S(4)),
        dict(title="Mastriegel", parts=[("mastriegel", 1), ("verbinder", 2)], text=["Mastriegel verclipsen und durch beide Mastspitzen stecken."], render=S(5)),
        dict(title="Brückenträger und Endriegel", parts=[("traeger_links", 1), ("traeger_rechts", 1), ("endriegel", 1), ("verbinder", 27)],
             text=["Träger verclipsen und in die Kerben der Konsolen setzen (Kreuzverbindung).", "Endriegel landseitig durch beide Träger stecken."], render=S(6)),
        dict(title="Ausleger", parts=[("ausleger_links", 1), ("ausleger_rechts", 1), ("spitzenriegel", 1), ("verbinder", 24)],
             text=["Ausleger verclipsen und mit je einem Filamentstift (Ø 1,75 mm, ca. 20 mm) an die Träger hängen.", "Spitzenriegel einstecken. Der Ausleger klappt hoch und wird oben mit einem Raststift gehalten."],
             render=S(7)),
        dict(title="Maschinenhaus", parts=[("maschinenhaus", 1), ("verbinder", 10)], text=["Maschinenhaus auf den Rückausleger setzen."], render=S(8)),
        dict(title="Laufkatze und Kabine", parts=[("katze", 1), ("kabine", 1), ("verbinder", 7)], text=["Katze auf die Träger legen – sie gleitet bis zur Auslegerspitze.", "Kabine unter die Katze stecken."], render=S(9)),
        dict(title="Spreader und Abspannung", parts=[("spreader", 1), ("verbinder", 3)],
             text=["Spreader an 4 Fäden unter die Katze hängen (Löcher in Katze und Spreader).", "Optional: Abspannungen vom Mast zu Ausleger und Träger als Faden spannen.", "Der Spreader passt auf den 40-Fuß-Container."],
             render=S(10)),
    ]
    return dict(
        title="Containerbrücke", subtitle="Ship-to-Shore-Kran – Laufkatze, klappbarer Ausleger, Spreader", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "-2600,-1400,2100,0,300,450", D, (1600, 1300)),
        final_renders=[R(scad, "-2600,-1400,2100,0,300,450", D, (1400, 1100)), R(scad, "-2600,-1400,2100,0,300,600", D + ["ausleger_hoch=true"], (1400, 1100))],
        material=material(["Filament-Stücke Ø 1,75 mm: 2 × Auslegergelenk, 2 × Raststift (je ca. 20 mm)", "Nähfaden für Spreader und Abspannungen"]),
        druck=druck(["Alle Fachwerke liegen flach – an jeder Naht sitzt eine massive Stoßplatte mit Clip-Tasche",
                     "Tipp: In 1:43 wird die Brücke über 1,3 m lang – für H0 (1:87) im Customizer den Maßstab wählen"]),
        system=SYSTEM_CLIP + ["Beweglich: Laufkatze verschieben, Spreader an Fäden, Ausleger hochklappen, Fahrwerke rollen auf den Schienen."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Containerbrücke", "containerbruecke.scad"),
        final=["Ausleger hochklappen: Stift aus dem Anschlag ziehen, Ausleger anheben und mit dem Raststift sichern.",
               "Laufkatze bis zur Auslegerspitze schieben, Container mit dem Spreader anheben."])
