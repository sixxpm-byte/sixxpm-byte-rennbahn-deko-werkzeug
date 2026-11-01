from common import *

def part(scad, D, pid, name, count, cols, pieces=1, info="", fps=None):
    if fps:
        ex = [(D + [f'teil="{pid}"', "stueck=0", f'farbteil="{fp}"'], hx, fp) for fp, hx, _ in fps]
        colors = [(n, hx) for _, hx, n in fps]
    else:
        ex = [(D + [f'teil="{pid}"', "stueck=0"], cols[1], "alle")]
        colors = [cols]
    return dict(id=pid, name=name, count=count, pieces=pieces, exports=ex, colors=colors, info=info)

def model():
    scad = MOD("riesenrad")
    A = ANL("anl_riesenrad")
    D = ["massstab=43"]
    w, g, st, ach, gr, orng, holz, rot, gelb = ("weiß", "#ecf0f1"), ("dunkelgrau", "#555555"), ("dunkelblau", "#2c3e50"), ("grau", "#7f8c8d"), ("hellgrau", "#95a5a6"), ("orange", "#d35400"), ("creme", "#f5deb3"), ("rot", "#c0392b"), ("gelb", "#f1c40f")
    parts = [
        part(scad, D, "grundrahmen", "Grundrahmen", 1, gr, 3),
        part(scad, D, "einstieg", "Einstiegspodest", 1, orng),
        part(scad, D, "strebe", "Seitenstrebe", 2, st),
        part(scad, D, "radscheibe", "Radscheibe", 2, w, 7, "Nabe + 6 gleiche Ringsegmente"),
        part(scad, D, "achse", "Achshälfte", 2, ach),
        part(scad, D, "querstange", "Gondelachse", 12, g),
        part(scad, D, "gondel_korb", "Gondel-Korb", 12, ("bunt", "#e74c3c"), 1, "Farbe frei wählbar"),
        part(scad, D, "gondel_dach", "Gondel-Dach", 12, w),
        part(scad, D, "stuetze", "A-Stütze", 2, st, 4),
        part(scad, D, "haus_boden", "Kasse Boden", 1, ("silbergrau", "#bdc3c7")),
        part(scad, D, "haus_wand_vorne", "Kasse Wand vorne", 1, holz),
        part(scad, D, "haus_wand_hinten", "Kasse Wand hinten", 1, holz),
        part(scad, D, "haus_wand_links", "Kasse Wand links", 1, holz),
        part(scad, D, "haus_wand_rechts", "Kasse Wand rechts", 1, holz),
        part(scad, D, "haus_dach", "Kasse Dach", 1, rot),
        part(scad, D, "haus_schild", "Kasse Schild", 1, None, fps=[("A", "#f1c40f", "gelb"), ("B", "#c0392b", "rot")]),
        part(scad, D, "verbinder", "Clips", 1, ("grau", "#8a8f94"), 1, "76 Clips"),
    ]
    dd = D + ['teil="none"']
    cam = "-700,-950,700,0,0,280"
    hcam = "-110,-190,170,28,22,35"
    def S(n, c=cam, extra=()): return R(A, c, dd + [f"schritt={n}"] + list(extra))
    steps = [
        dict(title="Grundrahmen", parts=[("grundrahmen", 1), ("verbinder", 6)],
             text=["Die 3 Rahmenstücke umdrehen und mit Clips verbinden."], render=S(1, "-420,-560,420,0,0,40")),
        dict(title="Einstiegspodest", parts=[("einstieg", 1)], text=["Podest auf die Zapfen in der Rahmenmitte setzen."], render=S(2, "-420,-560,420,0,0,40")),
        dict(title="Seitenstreben", parts=[("strebe", 2)], text=["Die Streben in ihre Schlitze links und rechts stecken."], render=S(3, "-420,-560,420,0,0,80")),
        dict(title="Erste Radscheibe mit Achse", parts=[("radscheibe", 1), ("achse", 1), ("verbinder", 24)],
             text=["Nabe und 6 Ringsegmente mit Clips verbinden (Clips von der Seite ohne Lampen).",
                   "Scheibe flach hinlegen (Lampen nach unten) und eine Achshälfte von innen durch den Sechskant stecken."], render=S(4)),
        dict(title="Gondelachsen", parts=[("querstange", 12)], text=["Die 12 Gondelachsen in die D-Löcher am Radkranz stecken."], render=S(5)),
        dict(title="Gondeln", parts=[("gondel_korb", 12), ("gondel_dach", 12)],
             text=["Jedes Dach auf die Eckpfosten seines Korbs kleben.", "Gondeln mit den Augen über die Achsen schieben – sie pendeln frei."], render=S(6)),
        dict(title="Zweite Radscheibe", parts=[("radscheibe", 1), ("achse", 1), ("verbinder", 24)],
             text=["Zweite Scheibe genauso zusammenbauen, Achshälfte einstecken.", "Scheibe auflegen und alle Gondelachsen in ihre D-Löcher drücken."], render=S(7)),
        dict(title="A-Stützen", parts=[("stuetze", 2), ("verbinder", 22)],
             text=["Die 4 Stücke jeder Stütze verclipsen.", "Stützen auf die Lagerzapfen der Achse schieben (Lagerring zur Scheibe)."], render=S(8)),
        dict(title="Rad in den Rahmen setzen", full=True, parts=[],
             text=["Das Rad mit beiden Stützen absenken: die Füße gleiten in die Schlitze des Rahmens,",
                   "die Strebenzapfen in die unten offenen Kerben der Stützen. Das Rad dreht sich nun frei."], render=S(9)),
        dict(title="Kasse: Bodenplatte", parts=[("haus_boden", 1)], text=["Die Bodenplatte der Kasse aufstellen."], render=S(10, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Wände", parts=[("haus_wand_vorne", 1), ("haus_wand_hinten", 1), ("haus_wand_links", 1), ("haus_wand_rechts", 1)],
             text=["Die vier Wände in die Nut der Bodenplatte stellen."], render=S(11, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Dach", parts=[("haus_dach", 1)], text=["Dach aufsetzen – es hält die Wände."], render=S(12, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Schild", parts=[("haus_schild", 1)], text=["Schild in die Löcher des Dachs stecken."], render=S(13, hcam, ["nur_haus=1"])),
    ]
    return dict(
        title="Riesenrad", subtitle="mit Kassenhäuschen – drehbares Rad, pendelnde Gondeln", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "-760,-1050,640,40,-40,280", D, (1600, 1300)),
        final_renders=[R(scad, "-700,-950,700,40,-40,280", D + ["radstellung=12"], (1400, 1200)), R(A, "-110,-190,170,28,22,35", dd + ["schritt=14", "nur_haus=1"], (1200, 1000))],
        material=material(),
        druck=druck(["Radscheiben, Stützen und Platten flach, Gondeln und Dächer aufrecht, Achsen liegend mit Abflachung"]),
        system=SYSTEM_CLIP + ["Beweglich: Die Achse sitzt mit Sechskant fest in den Scheiben und läuft rund in den Stützen – das Rad dreht sich, die Gondeln hängen immer senkrecht."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Riesenrad", "riesenrad.scad"),
        final=["Rad vorsichtig drehen – jede Gondel pendelt an ihrer Achse und bleibt waagerecht.",
               "Gondelanzahl, Raddurchmesser und Kassen-Schriftzug lassen sich im Customizer ändern."])
