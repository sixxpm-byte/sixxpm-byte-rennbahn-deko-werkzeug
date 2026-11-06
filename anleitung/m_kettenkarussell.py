from common import *

def model():
    scad = MOD("kettenkarussell")
    A = ANL("anl_kettenkarussell")
    D = ["massstab=43"]
    parts, _ = druck_parts(scad, D, {"verbinder": "Clips"})
    for p in parts:
        if p["id"] in ("dach", "volant", "sitz"): p["info"] = "je 8× in 2 Farben, abwechselnd"
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    cam = "420,-760,520,0,0,120"
    hcam = "-110,-190,170,28,22,35"
    def S(n, c=cam, extra=()): return R(A, c, dd + [f"schritt={n}"] + list(extra))
    steps = [
        dict(title="Mastfuß", parts=P("mastfuss"), text=["Den Mastfuß in die Mitte stellen."], render=S(1)),
        dict(title="Blenden und Podest", parts=P("blende", "podest", "verbinder"),
             text=["Die 4 Podest-Stücke mit Clips verbinden.", "16 Blenden in die Nut unter der Platte stecken und das Podest über den Fuß setzen."], render=S(2)),
        dict(title="Treppen", parts=P("treppe"), text=["Die beiden Treppen außen an das Podest stellen."], render=S(3)),
        dict(title="Mast", parts=P("mast"), text=["Den Mast durch die Manschette des Podests in den Fuß stecken."], render=S(4)),
        dict(title="Ausleger-Stern", parts=P("stern"),
             text=["Nabe und 4 Ringsegmente mit Clips verbinden.", "Stern auf den Lagerzapfen des Masts setzen – er dreht sich."], render=S(5)),
        dict(title="Dach", parts=P("dach"),
             text=["Die 16 Dachsegmente abwechselnd rot/weiß auf die Zapfen der Ausleger setzen und untereinander verclipsen."], render=S(6)),
        dict(title="Volants", parts=P("volant"), text=["Die Volants von unten in die Nut der Dachkante drücken (Farben abwechselnd)."], render=S(7)),
        dict(title="Laterne mit Wimpel", parts=P("laterne"), text=["Den Wimpel mit der Hülse von oben über den Fahnenmast schieben.", "Laterne oben auf die Dachspitze stecken."], render=S(8)),
        dict(title="Sitze einhängen", full=True, parts=P("sitz", "kettenstange"),
             text=["Je Sitz zwei Kettenstangen mit dem Zapfen in den Sitz stecken.",
                   "Die Augen links und rechts an die Auslegerspitze halten und ein Stück Filament (Ø 1,75 mm, ca. 17 mm) quer durchschieben.",
                   "Die Sitze pendeln frei – dreht man das Karussell schnell, fliegen sie nach außen."],
             render=S(9, "300,-520,330,0,0,110")),
        dict(title="Kasse: Bodenplatte", parts=P("haus_boden"), text=["Die Bodenplatte der Kasse aufstellen."], render=S(10, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Wände", parts=P("haus_wand_vorne", "haus_wand_hinten", "haus_wand_links", "haus_wand_rechts"),
             text=["Die vier Wände in die Nut der Bodenplatte stellen."], render=S(11, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Dach", parts=P("haus_dach"), text=["Dach aufsetzen – es hält die Wände."], render=S(12, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Schild", parts=P("haus_schild"), text=["Schild in die Löcher des Dachs stecken."], render=S(13, hcam, ["nur_haus=1"])),
    ]
    return dict(
        title="Kettenkarussell", subtitle="mit Verkaufshäuschen – drehbar, die Sitze fliegen nach außen", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "560,-760,520,60,-40,110", D, (2000, 1250)),
        final_renders=[R(scad, "420,-760,520,60,-40,110", D + ["schwenk=35"], (1600, 1100)), R(scad, "300,-520,330,0,0,110", D, (1400, 1100))],
        material=material(["Filament-Stücke Ø 1,75 mm für die Sitzlager (16 × ca. 17 mm)"]),
        druck=druck(["Sitze liegen auf der Seite, Kettenstangen flach – keine Stützen",
                     "Dachsegmente, Volants und Sitze in zwei Farben drucken (je 8 Stück)",
                     "Der Wimpel der Laterne steckt mit einer Hülse auf dem Mast (einzeln druckbar, Passung: einsatz_spiel); die Schild-Schrift ist ein Inlay – AMS/MMU oder einfarbig"]),
        system=SYSTEM_CLIP + ["Beweglich: Stern, Dach und Laterne drehen sich auf dem Lagerzapfen des Masts; jeder Sitz pendelt an seinem Stift."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Kettenkarussell", "kettenkarussell.scad"),
        final=["Karussell am Dach anstoßen: der Stern dreht sich, die Sitze schwingen nach außen.",
               "Sitzanzahl, Farben und Kassen-Schriftzug lassen sich im Customizer ändern."])
