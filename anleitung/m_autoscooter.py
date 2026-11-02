from common import *
import re

def model(mst=43):
    scad = MOD("autoscooter")
    A = ANL("anl_autoscooter")
    D = [f"massstab={mst}"]
    log = run(["openscad", "-o", os.path.join(W, f"as{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr
    mc = re.search(r"Verbinder-Clips gesamt: (\d+)", log)
    n_clips = int(mc.group(1)) if mc else 0
    ms = re.search(r"Filament-Stangen Ø [\d.]+: (\d+) Stück à ([\d.]+) mm", log)
    n_st, l_st = (int(ms.group(1)), round(float(ms.group(2)))) if ms else (12, 0)
    names = {"podest": "Podest", "treppe": "Treppe", "bande_seite": "Bande Seite", "bande_hinten": "Bande hinten",
             "bande_vorne_aussen": "Bande vorne außen", "bande_vorne_mitte": "Bande vorne Mitte", "saeule": "Säule", "dach": "Dach",
             "prunkfront": "Prunkfront", "wagen": "Wagen", "kasse_boden": "Kasse Boden", "kasse_wand_vorne": "Kasse Wand vorne",
             "kasse_wand_hinten": "Kasse Wand hinten", "kasse_wand_links": "Kasse Wand links", "kasse_wand_rechts": "Kasse Wand rechts",
             "kasse_dach": "Kasse Dach", "kasse_schild": "Kasse Schild", "greifer_unten": "Greifautomat Schrank",
             "greifer_haube": "Greifautomat Haube", "boxer": "Box-Automat", "wohnwagen": "Wohnwagen", "deichsel": "Deichsel",
             "packwagen": "Packwagen", "verbinder": "Clips"}
    parts, _ = druck_parts(scad, D, names)
    for p in parts:
        i = p["id"]
        if i in ("podest", "dach", "prunkfront"): p["info"] = f"{p['pieces']} Teile + Clips" if p["pieces"] > 1 else "einteilig"
        if i == "prunkfront": p["info"] += ", Schauseite oben"
        if i == "treppe": p["info"] = "liegt auf der Seite"
        if i.startswith("bande"): p["info"] = "liegt flach"
        if i == "saeule": p["info"] = "steht, mit Brim drucken"
        if i == "wagen": p["info"] = "je 3× rot, blau, gelb, neongrün" if n_st == 12 else "Farben im Wechsel"
        if i == "kasse_wand_hinten": p["info"] = "mit Tür"
        if i == "greifer_haube": p["info"] = "kopfüber; Glas gern transparent"
        if i == "boxer": p["info"] = "liegt auf dem Rücken"
        if i in ("wohnwagen", "packwagen"): p["info"] = "liegt auf der Seite"
        if i == "deichsel": p["info"] = "kopfüber, Zapfen oben"
        if i == "verbinder": p["info"] = f"{n_clips} Clips auf einer Platte"
    pc = {p["id"]: p["count"] for p in parts}
    pcs = {p["id"]: p["pieces"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VR, VH, VD, VS = "0,0,0,62,0,25,0", "0,0,0,62,0,-150,0", "0,0,0,180,0,25,0", "0,0,0,72,0,-30,0"
    def S(n, cam=VR, extra=(), size=(1500, 1100)):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    geteilt = pcs.get("podest", 1) > 1
    steps = []
    if geteilt:
        steps.append(dict(title="Podest verclipsen", full=True, parts=P("podest", "verbinder"),
             text=[f"Die {pcs['podest']} Podest-Teile umgedreht zusammenlegen (Holz-Umgang vorne).",
                   "An jeder Naht die Clips von oben in die Taschen der Unterseite drücken, dann das Podest umdrehen."],
             render=S(1), inset=dict(scad=A, cam="0,0,0,40,0,20,0", defs=dd + ["detail=1"], size=(1100, 800), auto=True), inset_txt="Unterseite mit Clips"))
    else:
        steps.append(dict(title="Podest", parts=P("podest"),
             text=["Das Podest hinlegen, der Holz-Umgang zeigt nach vorn.",
                   "Die Taschen links und rechts passen zum Stecksystem der Rennbahn-Deko."], render=S(1)))
    steps += [
        dict(title="Treppen", parts=P("treppe"),
             text=["Die beiden Treppen vorne ans Podest schieben – die hohe Stufe zeigt zum Podest."], render=S(2)),
        dict(title="Banden", parts=P("bande_seite", "bande_hinten", "bande_vorne_aussen", "bande_vorne_mitte"),
             text=["Die 7 Banden mit ihren Zapfen in die Schlitze rund um die Fahrfläche stecken: 2 Seiten, hinten 2 Teile, vorne 2 äußere und die Mitte.",
                   "Vor den Treppen bleibt je ein Durchgang frei."], render=S(3)),
        dict(title="Säulen", parts=P("saeule"),
             text=["Die 10 Säulen mit dem unteren Vierkantzapfen in die Löcher am Podestrand stecken: 4 vorne, 4 hinten, je 1 seitlich."], render=S(4)),
        dict(title="Wagen mit Stromstangen", full=True, parts=P("wagen"),
             text=[f"In den Halter hinten an jedem Wagen ein Filament-Stück (1,75 mm, {l_st} mm lang) als Stromstange stecken.",
                   "Die Wagen frei auf der Fahrfläche verteilen – jetzt, solange das Dach noch nicht drauf ist."],
             render=S(5), inset=dict(scad=A, cam="0,0,0,65,0,30,0", defs=dd + ["detail=2"], size=(1000, 800), auto=True), inset_txt="Stange in den Halter"),
        dict(title="Kasse: Boden und Wände", parts=P("kasse_boden", "kasse_wand_vorne", "kasse_wand_hinten", "kasse_wand_links", "kasse_wand_rechts"),
             text=["Die vier Wände in die Nut der Bodenplatte stellen: Fenster nach vorn, Tür nach hinten."], render=S(6, "0,0,0,62,0,30,0", size=(1100, 1300))),
        dict(title="Kasse: Dach und Schild", parts=P("kasse_dach", "kasse_schild"),
             text=["Das Dach aufsetzen – es hält die Wände zusammen.", "Das Schild CHIPS mit den Zapfen in die Schlitze vorne im Dach stecken."],
             render=S(7, "0,0,0,62,0,30,0", size=(1100, 1300))),
        dict(title="Greifautomat", parts=P("greifer_unten", "greifer_haube"),
             text=["Die Glashaube von oben auf den Rand hinter dem Bedienpult setzen."], render=S(8, "0,0,0,62,0,30,0", size=(1100, 1300))),
        dict(title="Kasse und Automaten aufstellen", parts=P("boxer"),
             text=["Der Box-Automat ist ein einzelnes Teil.", "Kasse mittig, Greifautomat links und Box-Automat rechts auf den Holz-Umgang stellen."],
             render=S(9)),
    ]
    if pcs.get("dach", 1) > 1:
        steps.append(dict(title="Dach verclipsen", parts=P("dach"),
             text=[f"Die {pcs['dach']} Dach-Teile umgedreht zusammenlegen und an allen Nähten die Clips in die Taschen drücken."], render=S(10, "0,0,0,40,0,20,0")))
    steps += [
        dict(title="Dach aufsetzen", parts=[] if pcs.get("dach", 1) > 1 else P("dach"),
             text=["Das Dach mit den 10 Löchern der Unterseite auf die oberen Säulenzapfen setzen.",
                   "Vorne ist die Seite ohne Lichterkante – dort steht gleich die Prunkfront."], render=S(11)),
        dict(title="Prunkfront", full=True, parts=P("prunkfront"),
             text=([f"Die {pcs['prunkfront']} Teile der Prunkfront umgedreht verclipsen."] if pcs.get("prunkfront", 1) > 1 else []) +
                  ["Die Prunkfront mit ihren Zapfen in die Schlitze vorne im Dach stecken – Schauseite nach vorn."], render=S(12, "0,0,0,72,0,15,0")),
        dict(title="Wohnwagen und Deichsel", parts=P("wohnwagen", "deichsel"),
             text=["Die Deichsel mit der Lasche vorne unter den Wohnwagen in den Schlitz schieben – der Zapfen an der Spitze zeigt nach unten."],
             render=S(13, VS)),
        dict(title="Packwagen ankuppeln", parts=P("packwagen"),
             text=["Den Wohnwagen so absetzen, dass der Zapfen der Deichsel in das Loch der Kupplung hinten am Packwagen greift."], render=S(14, VS)),
    ]
    return dict(
        title="Autoscooter", subtitle="Kompakt-Autoscooter – Prunkfront, 12 Wagen, Kasse, Automaten, Wohnwagen und Packwagen", scale_txt=f"1:{mst}",
        scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,62,0,25,0", defs=D + ["fahrzeuge_zeigen=false"], size=(1600, 1150), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,66,0,20,0", defs=D + ["fahrzeuge_zeigen=false"], size=(1400, 1100), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,-150,0", defs=D, size=(1400, 1100), auto=True)],
        material=material([f"Filament 1,75 mm für die Stromstangen: {n_st} Stücke à {l_st} mm",
                           "Optional: transparentes Filament für die Glashaube des Greifautomaten"]),
        druck=druck(["Säulen stehen beim Druck: mit Brim (Rand) drucken, damit sie nicht kippen",
                     "Wohnwagen und Packwagen liegen auf der Seite, der Box-Automat auf dem Rücken, die Glashaube kopfüber; Banden, Prunkfront und Wände liegen flach",
                     "Mehrfarbige Teile mit AMS/MMU – jede Farbe ist ein zusammenhängender Körper (Lichter hängen an Leitungen, Bandenfelder an verdeckten Leisten)"]),
        system=SYSTEM_CLIP + ["Alles ist gesteckt: Banden, Säulen, Dach und Prunkfront halten mit Zapfen in Schlitzen und Löchern.",
                              "Beweglich: Die Wagen stehen lose auf der Fahrfläche. Der Wohnwagen lässt sich mit der Deichsel an den Packwagen koppeln."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Autoscooter", "autoscooter.scad", "Texte, Wagenzahl und alle Farben lassen sich im Customizer ändern.", mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Die Wagen stehen lose: zwischen den Säulen verschieben oder zum Umstellen die Prunkfront und das Dach abnehmen.",
               "Die Stromstange soll knapp unter dem Dach enden. Berührt sie es, einfach 1 mm abschneiden.",
               "Die Glashaube des Greifautomaten in transparentem Filament drucken – dann sieht man die Preise.",
               "Zum Umstellen den Autoscooter am Podest tragen, nicht am Dach anheben – Dach und Prunkfront sind nur aufgesteckt.",
               "Die Clip-Taschen links und rechts am Podest passen an Leitplanken, Reifenstapel & Co. der Rennbahn-Deko-Reihe."])
