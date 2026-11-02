from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"bf{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def mm(x): return f"{float(x):.1f}".replace(".", ",").replace(",0", "")

def werte(log):
    v = {}
    m = re.search(r"Armlager \(([\d.]+) mm\)", log); v["stift"] = mm(m.group(1)) if m else "9"
    m = re.search(r"1x UFO \(([\d.]+) mm\)", log); v["ufo"] = mm(m.group(1)) if m else None
    m = re.search(r"Ruhestellung: Flügelspitze ([\d.]+) mm", log); v["ruhe"] = float(m.group(1)) if m else 0
    m = re.search(r"Verbinder-Clips gesamt: (\d+) \(([\d.]+) je Naht\)", log)
    v["clips"], v["je_naht"] = (int(m.group(1)), int(float(m.group(2)))) if m else (0, 0)
    m = re.search(r"Podest: (\d+) Stück", log); v["podest"] = int(m.group(1)) if m else 1
    return v

def model(mst=43):
    scad = MOD("babyflug")
    A = ANL("anl_babyflug")
    D = [f"massstab={mst}"]
    v = werte(echo(scad, mst))
    andere = 87 if mst == 43 else 43
    va = werte(echo(scad, andere))
    names = {"podest": "Podest-Ring", "boden": "Kunstrasen-Boden", "saeule": "Mittelsäule", "kopf_unten": "Drehkopf unten",
             "kopf_oben": "Drehkopf oben", "krone": "Pavillon", "dach": "Dach", "ufo_unten": "UFO unten", "ufo_oben": "UFO oben",
             "arm": "Arm", "jet": "Jet-Gondel", "mast": "Ringelmast", "gelaender": "Geländer", "leuchtmast": "Leuchtschild",
             "leuchtmast_fuss": "Leuchtschild-Fuß", "kasse_boden": "Kasse Fahrgestell", "kasse_treppe": "Kasse Treppe",
             "kasse_wand_vorne": "Kasse Wand vorne", "kasse_wand_hinten": "Kasse Wand hinten", "kasse_wand_links": "Kasse Wand links",
             "kasse_wand_rechts": "Kasse Wand rechts", "kasse_dach": "Kasse Dach", "kasse_schild": "Kasse Schild", "verbinder": "Clips"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    geteilt = v["podest"] > 1
    for p in parts:
        i = p["id"]
        info = {"podest": f"{p['pieces']} Hälften, diagonal aufs Bett" if geteilt else "einteilig",
                "boden": "8 Laschen + Säulenzapfen", "saeule": "mit Achse", "kopf_unten": "Lagerschalen oben offen",
                "kopf_oben": "steht auf den Lagerschalen", "arm": "liegt flach", "jet": "je 2× in 4 Farben",
                "ufo_unten": "kopfüber gedruckt", "mast": "steht – mit Brim drucken", "gelaender": "liegt flach",
                "leuchtmast": "liegt flach", "leuchtmast_fuss": "mit Rennbahn-Tasche", "kasse_boden": "kopfüber gedruckt",
                "kasse_treppe": "liegt auf der Seite", "kasse_wand_links": "mit Tür",
                "verbinder": f"{max(v['clips'], 4)} Clips auf einer Platte"}.get(i)
        if info: p["info"] = info
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VH, VK, VL = "0,0,0,58,0,25,0", "0,0,0,62,0,-55,0", "0,0,0,75,0,20,0"
    def S(n, cam=VH, extra=(), size=(1500, 1100)):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    farben = ", ".join(f.replace("gruen", "grün").replace("weiss", "weiß") for f, _ in next(p for p in parts if p["id"] == "jet")["colors"][:4])
    ruhe = "auf dem Rasen" if v["ruhe"] < 1.5 else "knapp über dem Rasen"
    steps = []
    if geteilt:
        steps.append(dict(title="Podest verclipsen", full=True, parts=P("podest", "verbinder"),
             text=[f"Die {v['podest']} Podest-Hälften umgedreht aneinanderlegen.",
                   f"An jeder Naht die {v['je_naht']} Clips von oben in die Taschen der Unterseite drücken, dann das Podest umdrehen."],
             render=S(1), inset=dict(scad=A, cam="0,0,0,35,0,20,0", defs=dd + ["detail=1"], size=(1100, 800), auto=True), inset_txt="Unterseite mit Clips"))
    steps += [
        dict(title="Kunstrasen-Boden einsetzen", parts=P("boden") + ([] if geteilt else P("podest")),
             text=["Den Kunstrasen-Boden mit dem Zapfen nach oben auf den Tisch legen.",
                   "Den Podest-Ring von oben darübersetzen – die 8 Laschen des Bodens greifen in die Taschen unter dem Ring und halten alles zusammen."],
             render=S(2)),
        dict(title="Mittelsäule", parts=P("saeule"), text=["Die Säule mit der D-Bohrung auf den Zapfen in der Bodenmitte stecken."], render=S(3)),
        dict(title="Drehkopf unten", parts=P("kopf_unten"),
             text=["Den unteren Drehkopf mit den offenen Lagerschalen nach oben auf die Achse schieben.",
                   "Er sitzt auf der Schulter der Säule und dreht sich frei."], render=S(4)),
        dict(title="Arme mit Achsstiften", parts=P("arm"),
             text=[f"Durch die Bohrung jedes Arms ein Filament-Stück 1,75 mm, {v['stift']} mm lang schieben – beidseitig gleich weit überstehend.",
                   "Die Arme mit den Stiften in die Lagerschalen legen, das Armende zeigt nach außen."],
             render=S(5), inset=dict(scad=A, cam="0,0,0,70,0,35,0", defs=dd + ["detail=2"], size=(1000, 800), auto=True), inset_txt="Stift durch den Arm"),
        dict(title="Drehkopf oben", parts=P("kopf_oben"),
             text=["Den oberen Drehkopf mit den Lagerschalen nach unten aufsetzen – Achse und Stifte richten ihn aus.",
                   "Ab jetzt halten die Arme jede Stellung: einfach von Hand heben oder senken."], render=S(6)),
        dict(title="Jets aufstecken", parts=P("jet"),
             text=["Jeden Jet mit der Tasche im Boden auf den Zapfen am Armende stecken, die Nase zeigt gegen den Uhrzeigersinn.",
                   f"Farben abwechselnd: {farben}."], render=S(7)),
        dict(title="Pavillon", parts=P("krone"), text=["Den Pavillon mit dem Vierkantloch im Boden auf den Schlüssel am Hals des Drehkopfs setzen."], render=S(8)),
        dict(title="Dach", parts=P("dach"), text=["Das Dach mit der Nut auf der Unterseite auf die Pavillonwände setzen."], render=S(9)),
        dict(title="UFO", parts=P("ufo_unten", "ufo_oben"),
             text=([f"Die beiden UFO-Hälften mit einem Filament-Stück ({v['ufo']} mm) verbinden, bei Bedarf mit einem Tropfen Kleber."] if v["ufo"]
                   else ["Die beiden UFO-Hälften aufeinanderkleben (in diesem Maßstab zu flach für einen Stift)."]) +
                  ["Den Stiel in die Dachspitze stecken – das UFO dreht sich frei."], render=S(10)),
        dict(title="Ringelmasten", parts=P("mast"), text=["Die 16 Masten mit dem Zapfen in die Löcher an den Ecken des Laufstegs stecken."], render=S(11)),
        dict(title="Geländer", full=True, parts=P("gelaender"),
             text=[f"Die {pc.get('gelaender', 15)} Geländer mit ihren zwei Zapfen in die Schlitze zwischen den Masten stecken.",
                   "Eine Seite bleibt offen: das ist der Eingang (blauer Pfeil). Daneben steht später der Kassenwagen."], render=S(12)),
        dict(title="Leuchtschild", parts=P("leuchtmast", "leuchtmast_fuss"),
             text=["Den Mast mit dem Zapfen in den Fuß stecken.",
                   "Der Fuß hat eine Rennbahn-Tasche – mit einem Clip lässt er sich an die Strecke koppeln."], render=S(13, VL, size=(900, 1300))),
        dict(title="Kasse: Fahrgestell und Treppe", parts=P("kasse_boden", "kasse_treppe"),
             text=["Das Fahrgestell auf seine Beine stellen.", "Die Treppe an die linke Seite schieben – dort ist später die Tür."],
             render=S(14, VK, size=(1300, 1100))),
        dict(title="Kasse: Wände", parts=P("kasse_wand_vorne", "kasse_wand_hinten", "kasse_wand_links", "kasse_wand_rechts"),
             text=["Die vier Wände in die Nut des Wagenbodens stellen: Fenster nach vorn, Tür zur Treppe."], render=S(15, VK, size=(1300, 1200))),
        dict(title="Kasse: Dach und Schild", parts=P("kasse_dach", "kasse_schild"),
             text=["Das Dach aufsetzen – es hält die Wände zusammen.", "Das Schild mit den Zapfen in die Schlitze vorne im Dach stecken."],
             render=S(16, VK, size=(1300, 1300))),
    ]
    stifte = f"8 Stücke à {v['stift']} mm" + (f" und 1 Stück à {v['ufo']} mm für das UFO" if v["ufo"] else "")
    unterschied = []
    if va["podest"] != v["podest"]:
        unterschied.append("Podest-Ring einteilig (keine Clips)" if va["podest"] == 1 else f"Podest-Ring aus {va['podest']} Hälften mit Clips")
    if bool(va["ufo"]) != bool(v["ufo"]):
        unterschied.append("UFO-Hälften geklebt" if not va["ufo"] else f"UFO-Hälften mit Stift ({va['ufo']} mm)")
    if va["stift"] != v["stift"]:
        unterschied.append(f"Achsstifte {va['stift']} mm lang")
    extra = (f"In 1:{andere} sind die Bauschritte gleich, Unterschiede: " + ", ".join(unterschied) + ".") if unterschied else ""
    return dict(
        title="Babyflug", subtitle="Kinder-Flugkarussell – 8 Jets, heb- und senkbare Arme, UFO, Kassenwagen", scale_txt=f"1:{mst}",
        scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,62,0,20,0", defs=D, size=(1700, 1150), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,60,0,-35,0", defs=D, size=(1400, 1100), auto=True),
                       dict(scad=scad, cam="0,0,0,70,0,150,0", defs=D + ["kasse_zeigen=false", "leuchtmast_zeigen=false", "arm_winkel=-20"], size=(1400, 1100), auto=True)],
        material=material([("Die Podest-Hälften liegen diagonal auf dem Bett" if geteilt else "Der Podest-Ring ist einteilig"),
                           f"Ein Rest Filament 1,75 mm für die Achsstifte: {stifte}"] +
                          ([] if v["ufo"] else ["Sekundenkleber für die UFO-Hälften"])),
        druck=druck(["Fahrgestell der Kasse und UFO-Unterteil kopfüber; Arme, Geländer, Wände und Leuchtschild liegen flach; Jets, Pavillon und Dach stehen aufrecht",
                     "Die Arme flach drucken: so wird die Stiftbohrung exakt rund – sie muss stramm auf dem Filament sitzen",
                     "Die Ringelmasten stehen beim Druck: mit Brim (Rand) drucken, damit die hohen, dünnen Masten nicht kippen",
                     "Mehrfarbige Teile mit AMS/MMU – Lichter hängen an Leitungen, jede Lichtfarbe ist ein zusammenhängender Körper"]),
        system=(SYSTEM_CLIP if geteilt else SYSTEM_CLIP[:1] + ["Der Podest-Ring ist in diesem Maßstab einteilig – Clips brauchst du nur für die Rennbahn-Taschen."]) +
               ["Beweglich: Der ganze Oberbau dreht sich auf der Achse der Mittelsäule. Jeder Arm schwenkt auf einem Filament-Stift – die Jets heben und senken sich und bleiben in jeder Stellung stehen.",
                "Rennbahn-Taschen am Podestrand und am Fuß des Leuchtschilds koppeln das Karussell an die Strecke."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Babyflug", "babyflug.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Oberbau von Hand am Pavillon drehen – Arme, Jets, Dach und UFO drehen sich gemeinsam auf der Säule.",
               f"Arme einzeln heben und senken: zwischen Ruhestellung (Jets {ruhe}) und Flughöhe bleibt jede Stellung stehen. Die Jets legen sich dabei wie im Kurvenflug schräg.",
               "Arm zu schwergängig? Die Bohrung mit einem 1,8-mm-Bohrer von Hand aufreiben. Zu leichtgängig? Den Stift mit einem Tropfen Sekundenkleber im Arm fixieren – dann bremst das Lager im Drehkopf.",
               "Zum Umstellen das Karussell am Podest tragen, nicht am Dach anheben – Pavillon und Dach sind nur aufgesteckt.",
               "Die Clip-Taschen am Podestrand und am Leuchtschild-Fuß passen an Leitplanken, Reifenstapel & Co. der Rennbahn-Deko-Reihe."])
