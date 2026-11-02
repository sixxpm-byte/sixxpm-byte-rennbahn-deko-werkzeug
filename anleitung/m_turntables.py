from common import *
import re

def model(mst=43):
    scad = MOD("turntables")
    A = ANL("anl_turntables")
    D = [f"massstab={mst}"]
    log = run(["openscad", "-o", os.path.join(W, f"tt{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr
    ms = re.search(r"1x Tonarm \(([\d.]+) mm\)", log); st = f"{float(ms.group(1)):.0f}" if ms else "10"
    mc = re.search(r"Verbinder-Clips gesamt: (\d+)", log); n_cl = int(mc.group(1)) if mc else 0
    parts, _ = druck_parts(scad, D, {"verbinder": "Clips"})
    pcs = {p["id"]: p["pieces"] for p in parts}
    for p in parts:
        if p["id"] == "gondel": p["info"] = "je 4× in 4 Farben"
        if p["id"].startswith("rueckwand"): p["info"] = "Nummer = Platz von links"
        if p["id"] in ("deck", "scheibe", "bodenkreuz"): p["info"] = f"{p['pieces']} Teile + Clips" if p["pieces"] > 1 else "einteilig"
        if p["id"] == "verbinder": p["info"] = f"{max(n_cl, 4)} Clips"
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VH, VK = "0,0,0,58,0,20,0", "0,0,0,62,0,35,0"
    def S(n, c=VH, extra=(), size=(1500, 1100)): return dict(scad=A, cam=c, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    def clip_txt(i, wort): return [f"Die {pcs[i]} {wort} mit Clips verbinden (Teile umdrehen, Clips in die Taschen)."] if pcs.get(i, 1) > 1 else []
    n_st = pc.get("stufe", 7)
    steps = [
        dict(title="Bodenkreuz", parts=P("bodenkreuz") + (P("verbinder") if n_cl > 0 else []),
             text=clip_txt("bodenkreuz", "Stücke des Bodenkreuzes") + ["Der schräge Lagerbock mit der Achse kommt in die Mitte."], render=S(1)),
        dict(title="Blenden und Podest-Deck", parts=P("blende_aussen", "blende_innen", "deck"),
             text=clip_txt("deck", "Deck-Segmente") + ["Außen- und Innenblenden in die Nuten unter dem Deck stecken und das Deck auf das Bodenkreuz setzen."],
             render=S(2)),
        dict(title="Treppe", parts=P("stufe"), text=[f"Die {n_st} Treppenblöcke vorne an das Podest schieben."], render=S(3)),
        dict(title="Plattenteller", parts=P("scheibe"),
             text=clip_txt("scheibe", "Teller-Stücke") + ["Teller auf die schräge Achse setzen – er dreht sich frei."], render=S(4)),
        dict(title="Gondelkreuze", parts=P("kreuz"), text=[f"Die {pc.get('kreuz', 4)} Kreuze auf die Zapfen des Tellers stecken."], render=S(5)),
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
             text=["Masten, Zäune und Mischpult-Panels in ihre Schlitze im Podest stecken.",
                   f"Tonarm-Säule einstecken, Tonarm mit einem Filamentstift (Ø 1,75 mm, ca. {st} mm) daraufsetzen – er schwenkt."],
             render=S(10)),
        dict(title="Kasse: Bodenplatte", parts=P("haus_boden"), text=["Die Bodenplatte der Kasse aufstellen."], render=S(11, VK, ["nur_haus=1"], (1200, 1100))),
        dict(title="Kasse: Wände", parts=P("haus_wand_vorne", "haus_wand_hinten", "haus_wand_links", "haus_wand_rechts"),
             text=["Die vier Wände in die Nut der Bodenplatte stellen (vorne/hinten außen)."], render=S(12, VK, ["nur_haus=1"], (1200, 1100))),
        dict(title="Kasse: Dach", parts=P("haus_dach"), text=["Dach aufsetzen – es hält die Wände zusammen."], render=S(13, VK, ["nur_haus=1"], (1200, 1200))),
        dict(title="Kasse: Schild", parts=P("haus_schild"), text=["Schild mit den Zapfen in die Löcher des Dachs stecken."], render=S(14, VK, ["nur_haus=1"], (1200, 1200))),
    ]
    return dict(
        title="Turntables", subtitle="DJ-Fahrgeschäft mit Plattenteller, Kugelturm und Kasse", scale_txt=f"1:{mst}",
        scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,58,0,20,0", defs=D, size=(2000, 1250), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,55,0,-30,0", defs=D + ["drehung=60", "tonarm_winkel=0"], size=(1600, 1100), auto=True),
                       dict(scad=scad, cam="0,0,0,40,0,200,0", defs=D + ["kassenhaus_zeigen=false"], size=(1400, 1100), auto=True)],
        material=material([f"Filament-Stück Ø 1,75 mm für den Tonarm (ca. {st} mm)"]),
        druck=druck(["Kugeln stehen auf ihrer 45°-Fase, Kopfhörer-Hälften liegen flach – keine Stützen",
                     "Mehrfarbige Teile (Rückwand, Teller, Gondeln …) mit AMS/MMU oder einfarbig mit farbteil = alle",
                     "Clip-Taschen auf der Unterseite der geteilten Teile werden kurz überbrückt – keine Stützen einschalten"]),
        system=(SYSTEM_CLIP if n_cl > 0 else SYSTEM_CLIP[:1] + ["In diesem Maßstab ist kein Teil geteilt – Clips brauchst du nur für die Rennbahn-Taschen."]) +
               ["Beweglich: Der Plattenteller dreht sich auf der schrägen Achse, die Kreuze auf ihren Zapfen und jede Gondel einzeln. Der Turm steht fest."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Turntables", "turntables.scad", "", mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Plattenteller drehen – Kreuze und Gondeln drehen sich mit und frei auf ihren Zapfen.",
               "Den Tonarm nur in Ruhestellung lassen: über dem Teller stößt er an die Gondeln.",
               "Farben, Texte (Schild „TURN/TABLES“, Kasse) und Neigung des Tellers im Customizer ändern."])
