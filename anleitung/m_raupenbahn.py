from common import *
import re

def model():
    scad = MOD("raupenbahn")
    A = ANL("anl_raupenbahn")
    D = ["massstab=43"]
    log = run(["openscad", "-o", os.path.join(W, "rb.csg"), "-D", "massstab=43", "-D", 'teil="none"', scad]).stderr
    n_clips = int(re.search(r"Verbinder-Clips gesamt: (\d+)", log).group(1))
    names = {"podest": "Podest", "umgang": "Welliger Umgang", "treppe": "Treppe", "zaun": "Geländer", "koenigszapfen": "Königszapfen",
             "rotor": "Rotor (Drehkranz)", "ausleger": "Ausleger", "schiene": "Wellenbahn", "wagen": "Wagen", "sitz": "Sitzbank",
             "verdeck": "Verdeck (Raupe)", "verdeck_kopf": "Raupenkopf", "mittelbau_boden": "Baldachin Boden", "mittelbau_wand": "Baldachin Arkade",
             "mittelbau_deckel": "Baldachin Deckel", "kuppel": "Kuppel", "saeule": "Zuckerstangen-Säule", "dach": "Ringdach",
             "blende": "Frontblende", "notenschluessel": "Notenschlüssel", "schild": "Schild RAUPENBAHN", "pflanze": "Pflanzkübel",
             "haus_boden": "Kasse Boden", "haus_wand_vorne": "Kasse Wand vorne", "haus_wand_hinten": "Kasse Wand hinten",
             "haus_wand_links": "Kasse Wand links", "haus_wand_rechts": "Kasse Wand rechts", "haus_dach": "Kasse Dach",
             "haus_schild": "Kasse Schild", "verbinder": "Clips"}
    parts, _ = druck_parts(scad, D, names)
    for p in parts:
        i = p["id"]
        if i == "zaun": p.update(count=p["pieces"], pieces=1, info="13 Seiten, je eigene Wellenform")
        if i == "treppe": p.update(count=p["pieces"], pieces=1, info="links / Mitte / rechts (folgen der Welle)")
        if i in ("podest", "dach", "umgang", "schiene"): p["info"] = f"{p['pieces']} Segmente + Clips"
        if i == "verbinder": p["info"] = f"{n_clips} Clips auf einer Platte"
        if i == "wagen": p["info"] = "Wappen mit Krone, Zierräder"
        if i == "verdeck": p["info"] = "steht beim Druck auf der Stirnseite"
        if i == "verdeck_kopf": p["info"] = "Gesicht liegt auf dem Druckbett"
        if i == "notenschluessel": p["info"] = "Schauseite nach unten drucken"
        if i == "podest": p["info"] = "9 Segmente, kopfüber gedruckt"
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    G = "300,-640,380,0,0,30"        # Boden-Ansicht
    T = "380,-820,600,0,0,90"        # mit Dach
    hcam = "-110,-190,170,28,22,35"
    def S(n, c=G, extra=()): return R(A, c, dd + [f"schritt={n}"] + list(extra))
    steps = [
        dict(title="Podest verclipsen", full=True, parts=[("podest", 1), ("verbinder", 1)],
             text=["Die 9 Podest-Segmente umgedreht zusammenlegen (Mitte + 8 Ringstücke).",
                   "An jeder Naht die Clips von oben in die Taschen der Unterseite drücken, dann das Podest umdrehen."],
             render=S(1, "380,-800,480,0,0,20"), inset=R(A, "0,-330,430,0,-40,0", dd + ["schritt=1", "detail=1"], (1100, 900)), inset_txt="Unterseite mit Clips"),
        dict(title="Wellenbahn einlegen", parts=P("schiene"),
             text=["Die 4 Bahnsegmente in die Spurrille des Podests legen.", "An den Stoßschwellen je einen Clip von unten einsetzen."],
             render=S(2, "380,-800,480,0,0,20")),
        dict(title="Welligen Umgang auflegen", parts=P("umgang"),
             text=["Die Umgang-Segmente (unten mit Clips verbunden) außen auf das Podest legen.",
                   "Innen schließt der Umgang an die Außenwand der Wellenbahn an."],
             render=S(3, "380,-800,480,0,0,20")),
        dict(title="Königszapfen und Rotor", parts=P("koenigszapfen", "rotor"),
             text=["Den Königszapfen mit dem Vierkant in die Mitte des Podests stecken.", "Den Rotor auf den Zapfen setzen – er dreht sich frei."],
             render=S(4)),
        dict(title="Ausleger einlegen", full=True, parts=P("ausleger"),
             text=["Jeden Ausleger mit der runden Querachse in eine Mulde des Rotors legen – der Arm zeigt durch den Schlitz nach außen.",
                   "Außen liegt der Arm lose auf der silbernen Laufschiene. Nicht kleben – die Arme müssen kippen können."],
             render=S(5), inset=R(A, "115,-45,80,50,22,28", dd + ["schritt=5", "detail=2"], (1100, 900)), inset_txt="Querachse in der Mulde"),
        dict(title="Wagen und Sitzbänke", full=True, parts=P("wagen", "sitz"),
             text=["Jeden Wagen mit der Vierkant-Tasche im Boden auf den Zapfen am Armende stecken.", "Die Sitzbank hinten in den Wagen einlegen (Lehne nach hinten)."],
             render=S(6)),
        dict(title="Baldachin: Boden und Arkaden", parts=P("mittelbau_boden", "mittelbau_wand"),
             text=["Den Boden mit seinen 6 Löchern auf die Stützen des Rotors setzen.", "Die 12 Arkaden in die Nut des Bodens stellen."],
             render=S(7, "210,-340,250,0,0,70")),
        dict(title="Baldachin: Deckel und Kuppel", parts=P("mittelbau_deckel", "kuppel"),
             text=["Den Deckel mit der Nut auf die Arkaden legen – er hält sie zusammen.", "Die Kuppel über den Zentrierring stülpen."],
             render=S(8, "210,-340,270,0,0,80")),
        dict(title="Säulen einstecken", full=True, parts=P("saeule"),
             text=["Die 16 Zuckerstangen-Säulen durch die Löcher im Umgang stecken, bis der Vierkant im Podest sitzt."],
             render=S(9, T)),
        dict(title="Ringdach aufsetzen", full=True, parts=P("dach", "verbinder"),
             text=["Die 8 Dachsegmente umgedreht mit Clips verbinden.", "Das Dach auf die Säulen setzen – die Vierkantzapfen greifen in die Löcher der Unterseite."],
             render=S(10, T)),
        dict(title="Frontblenden und Notenschlüssel", full=True, parts=P("blende", "notenschluessel"),
             text=["Die 16 Blenden mit dem unteren Rand in die Nut am Dachrand stellen.", "In jede Ecke einen Notenschlüssel stecken – er deckt die Fuge zwischen zwei Blenden ab."],
             render=S(11, T)),
        dict(title="Schild RAUPENBAHN", parts=P("schild"),
             text=["Das Schild mit seinen zwei Beinen vorne in die Löcher der Dachwulst stecken."],
             render=S(12, "260,-560,420,0,-150,110")),
        dict(title="Treppen, Geländer, Pflanzen", parts=P("treppe", "zaun", "pflanze"),
             text=["Die 3 Treppen vorne ans Podest schieben (links, Mitte, rechts).",
                   "Geländer zaun_1 … zaun_13 gegen den Uhrzeigersinn ab rechts der Treppe in die Schlitze des Umgangs stecken."],
             render=S(13, T)),
        dict(title="Die Raupe: Verdecke", full=True, parts=P("verdeck", "verdeck_kopf"),
             text=["Nach Wunsch die Verdecke auf die Wagen setzen – der Kragen greift außen über die Wagenwand.",
                   "Das Verdeck mit dem Gesicht ist der Raupenkopf (im Bild ist das Dach ausgeblendet)."],
             render=S(14, "330,-520,260,60,-40,40", ["ohne_dach=1"])),
        dict(title="Kasse: Bodenplatte", parts=P("haus_boden"), text=["Die Bodenplatte der Kasse aufstellen."], render=S(15, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Wände", parts=P("haus_wand_vorne", "haus_wand_hinten", "haus_wand_links", "haus_wand_rechts"),
             text=["Die vier Wände in die Nut der Bodenplatte stellen."], render=S(16, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Dach", parts=P("haus_dach"), text=["Dach aufsetzen – es hält die Wände zusammen."], render=S(17, hcam, ["nur_haus=1"])),
        dict(title="Kasse: Schild", parts=P("haus_schild"), text=["Schild mit den Zapfen in die Löcher des Dachs stecken."], render=S(18, hcam, ["nur_haus=1"])),
    ]
    return dict(
        title="Raupenbahn", subtitle="50er-Jahre Rock'n'Roll-Edition – Wellenbahn, Raupen-Verdecke, Baldachin, Kasse", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "430,-820,300,0,-50,50", D + ["drehung=5"], (2000, 1250)),
        final_renders=[R(scad, "-420,-760,560,0,-20,70", D + ["drehung=5", "verdeck_zeigen=true"], (1600, 1100)),
                       R(scad, "640,-420,110,0,0,35", D + ["drehung=5", "kassenhaus_zeigen=false"], (1600, 1100))],
        material=material(),
        druck=druck(["Podest kopfüber, Umgang und Dach aufrecht – innen hohl mit Rippen, Brücken max. 15–20 mm",
                     "Verdecke stehen auf der Stirnseite, Notenschlüssel und Raupenkopf liegen mit der Schauseite auf dem Bett",
                     "Mehrfarbige Teile (Wagen, Blenden, Schild, Dach …) mit AMS/MMU oder einfarbig mit farbteil = alle"]),
        system=SYSTEM_CLIP + ["Beweglich: Der Rotor dreht sich auf dem Königszapfen. Jeder Ausleger kippt in seiner Mulde und gleitet über die Wellenschiene – die Wagen heben und senken sich."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Raupenbahn", "raupenbahn.scad", "Wagenanzahl, Wellen und Farben lassen sich im Customizer ändern."),
        final_title="Beweglich & Tipps",
        final=["Rotor oder Baldachin von Hand drehen: die Wagen fahren über die Wellen, Umgang und Geländer folgen der Welle starr.",
               "Verdecke drauf = Raupe, Verdecke ab = Fahrbetrieb bei offenem Wagen. Der Raupenkopf gehört vor den ersten Wagen.",
               "Wagenanzahl (12–24), Wellenzahl und -höhe, Schildtext und alle Farben im Customizer von raupenbahn.scad ändern."])
