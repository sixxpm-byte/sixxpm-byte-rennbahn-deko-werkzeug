from common import *

def model():
    scad = MOD("turntables")
    A = ANL("anl_turntables")
    D = ["massstab=43"]
    parts, _ = druck_parts(scad, D, {"verbinder": "Clips"})
    for p in parts:
        if p["id"] == "gondel": p["info"] = "je 4× in 4 Farben"
        if p["id"].startswith("rueckwand"): p["info"] = "Nummer = Platz von links"
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    cam = "380,-850,700,0,30,60"
    hcam = "-110,-190,170,28,22,35"
    def S(n, c=cam, extra=()): return R(A, c, dd + [f"schritt={n}"] + list(extra))
    steps = [
        dict(title="Bodenkreuz", parts=P("bodenkreuz", "verbinder"),
             text=["Die Stücke des Bodenkreuzes mit Clips verbinden (Teile umdrehen, Clips in die Taschen).", "Der schräge Lagerbock mit der Achse kommt in die Mitte."],
             render=S(1)),
        dict(title="Blenden und Podest-Deck", parts=P("blende_aussen", "blende_innen", "deck"),
             text=["Die 4 Deck-Segmente mit Clips zu einem Ring verbinden.", "Außen- und Innenblenden in die Nuten unter dem Deck stecken und das Deck auf das Bodenkreuz setzen."],
             render=S(2)),
        dict(title="Treppe", parts=P("stufe"), text=["Die 7 Treppenblöcke vorne an das Podest schieben."], render=S(3)),
        dict(title="Plattenteller", parts=P("scheibe"),
             text=["Die 5 Teller-Stücke mit Clips verbinden.", "Teller auf die schräge Achse setzen – er dreht sich frei."], render=S(4)),
        dict(title="Gondelkreuze", parts=P("kreuz"), text=["Die 4 Kreuze auf die Zapfen des Tellers stecken."], render=S(5)),
        dict(title="Gondeln", parts=P("gondel"), text=["Je 4 Gondeln auf die Zapfen jedes Kreuzes setzen (Farben nach Wunsch mischen)."], render=S(6)),
        dict(title="Kugelturm mit Kopfhörer", parts=P("turm_kegel", "turm_kragen", "turm_kugel", "turm_ring", "turmstifte", "kopfhoerer"),
             text=["Kegel, Kragen, Kugeln und Ringe mit den Vierkantstiften aufeinanderstecken.", "Die beiden Kopfhörer-Hälften zusammenkleben und oben aufsetzen.",
                   "Turm auf das Achsende drücken – die Abflachung sorgt dafür, dass der Kopfhörer nach vorn schaut."],
             render=S(7)),
        dict(title="Equalizer-Rückwand", full=True, parts=P("rueckwand_1", "rueckwand_2", "rueckwand_3", "rueckwand_4", "rueckwand_5", "rueckwand_6", "rueckwand_7", "wandstuetze"),
             text=["Paneele 1–7 der Reihe nach in die Nuten am hinteren Podestrand stecken (Paneel 6 trägt später das Schild).", "Hinter jedes Paneel eine Stütze stecken."],
             render=S(8)),
        dict(title="Markisen und Vinyl-Schild", parts=P("markise", "vinylschild"),
             text=["Markisen in die Schlitze der Paneele schieben.", "Das große Schild auf die Zapfen von Paneel 6 drücken."], render=S(9)),
        dict(title="Lichtmasten, Zäune, Mischpulte, Tonarm", parts=P("lichtmast", "zaun", "mischpult", "tonarm_saeule", "tonarm"),
             text=["Masten, Zäune und Mischpult-Panels in ihre Schlitze im Podest stecken.", "Tonarm-Säule einstecken, Tonarm mit einem Filamentstift (Ø 1,75) daraufsetzen – er schwenkt."],
             render=S(10)),
        dict(title="Kasse: Bodenplatte", parts=P("haus_boden"), text=["Die Bodenplatte der Kasse aufstellen."], render=S(11, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Wände", parts=P("haus_wand_vorne", "haus_wand_hinten", "haus_wand_links", "haus_wand_rechts"),
             text=["Die vier Wände in die Nut der Bodenplatte stellen (vorne/hinten außen)."], render=S(12, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Dach", parts=P("haus_dach"), text=["Dach aufsetzen – es hält die Wände zusammen."], render=S(13, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Schild", parts=P("haus_schild"), text=["Schild mit den Zapfen in die Löcher des Dachs stecken."], render=S(14, hcam, ["nur_haus=1"])),
    ]
    return dict(
        title="Turntables", subtitle="DJ-Fahrgeschäft mit Plattenteller, Kugelturm und Kasse", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "420,-760,620,-30,40,80", D, (2000, 1250)),
        final_renders=[R(scad, "330,-720,600,0,40,60", D + ["drehung=60", "tonarm_winkel=0"], (1600, 1100)),
                       R(scad, "120,-330,330,0,0,140", D, (1400, 1100))],
        material=material(["Filament-Stück Ø 1,75 mm für den Tonarm (ca. 3 cm)"]),
        druck=druck(["Kugeln stehen auf ihrer 45°-Fase, Kopfhörer-Hälften liegen flach – keine Stützen",
                     "Mehrfarbige Teile (Rückwand, Teller, Gondeln …) mit AMS/MMU oder einfarbig mit farbteil = alle"]),
        system=SYSTEM_CLIP + ["Beweglich: Der Plattenteller dreht sich auf der schrägen Achse, die Kreuze auf ihren Zapfen und jede Gondel einzeln. Der Turm steht fest."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Turntables", "turntables.scad"),
        final_title="Beweglich & Tipps",
        final=["Plattenteller drehen – Kreuze und Gondeln drehen sich mit und frei auf ihren Zapfen.",
               "Den Tonarm nur in Ruhestellung lassen: über dem Teller stößt er an die Gondeln.",
               "Farben, Texte (Schild „TURN/TABLES“, Kasse) und Neigung des Tellers im Customizer ändern."])
