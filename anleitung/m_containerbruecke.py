from common import *
import re

def model(mst=43):
    scad = MOD("containerbruecke")
    A = ANL("anl_containerbruecke")
    D = [f"massstab={mst}"]
    log = run(["openscad", "-o", os.path.join(W, f"cb{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr
    ms = re.search(r"2x Auslegergelenk ([\d.]+) mm", log); st = f"{float(ms.group(1)):.0f}" if ms else "20"
    mk = re.search(r"Verbinder-Clips für geteilte Teile: (\d+) \(\+ (\d+)", log)
    n_cl, n_sch = (int(mk.group(1)), int(mk.group(2))) if mk else (0, 0)
    clips = {m.group(1): int(m.group(2)) for m in re.finditer(r"Teilung: (\w+) -> \d+ Stücke, (\d+) Clips je Teil", log)}
    lg = re.search(r"Länge gesamt ([\d.]+) mm", log); laenge = float(lg.group(1)) if lg else 0
    names = {"schiene": "Kranschiene", "fahrwerk": "Fahrwerk", "portalrahmen": "Portalrahmen", "konsole": "Trägerkonsole",
             "mastriegel": "Mastriegel", "traeger_links": "Brückenträger links", "traeger_rechts": "Brückenträger rechts",
             "endriegel": "Endriegel", "ausleger_links": "Ausleger links", "ausleger_rechts": "Ausleger rechts",
             "spitzenriegel": "Spitzenriegel", "maschinenhaus": "Maschinenhaus", "katze": "Laufkatze", "kabine": "Fahrerkabine",
             "spreader": "Spreader-Rahmen", "spreader_kopf": "Spreader-Kopfstück", "verbinder": "Clips"}
    parts, _ = druck_parts(scad, D, names)
    pcs = {p["id"]: p["pieces"] for p in parts}
    pc = {p["id"]: p["count"] for p in parts}
    seg = pc.get("schiene", 2) // 2
    for p in parts:
        if p["pieces"] > 1: p["info"] = f"{p['pieces']} Teile + Clips"
        if p["id"] == "schiene": p["info"] = f"2 Stränge à {seg} Segment{'e' if seg > 1 else ''}"
        if p["id"] == "verbinder": p["info"] = f"{n_cl + n_sch} Clips" + (" (mehrere Platten)" if n_cl + n_sch > 60 else "")
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    def C(*ids): return [("verbinder", sum(clips.get(i.replace("_links", "").replace("_rechts", ""), 0) * (2 if i == "portalrahmen" else 1) for i in ids))] if any(pcs.get(i, 1) > 1 for i in ids) else []
    def zus(i, wort): return [f"{wort} aus {pcs[i]} Stücken zusammenclipsen (Teile umdrehen, Clips in die Stoßplatten)."] if pcs.get(i, 1) > 1 else []
    dd = D + ['teil="none"']
    VH, VL = "0,0,0,65,0,235,0", "0,0,0,55,0,235,0"
    def S(n, c=VH, size=(1500, 1100)): return dict(scad=A, cam=c, defs=dd + [f"schritt={n}"], size=size, auto=True)
    steps = [
        dict(title="Kranschienen", parts=P("schiene") + ([("verbinder", n_sch)] if n_sch else []),
             text=([f"Je {seg} Segmente hintereinanderlegen und an den Stößen unten verclipsen."] if seg > 1 else ["Die beiden Kranschienen parallel hinlegen."]),
             render=S(1, VL)),
        dict(title="Fahrwerke", parts=P("fahrwerk"), text=["Die vier Fahrwerke auf die Schienen setzen."], render=S(2, VL)),
        dict(title="Portalrahmen", parts=P("portalrahmen") + C("portalrahmen"),
             text=zus("portalrahmen", "Jeden Rahmen") + ["Rahmen mit den Beinen in die Fahrwerke stecken."], render=S(3)),
        dict(title="Trägerkonsolen", parts=P("konsole"), text=["Je zwei Konsolen mit dem Zapfen durch jeden Portalrahmen stecken."], render=S(4)),
        dict(title="Mastriegel", parts=P("mastriegel") + C("mastriegel"),
             text=(["Mastriegel verclipsen und durch beide Mastspitzen stecken."] if pcs.get("mastriegel", 1) > 1 else ["Mastriegel durch beide Mastspitzen stecken."]),
             render=S(5)),
        dict(title="Brückenträger und Endriegel", parts=P("traeger_links", "traeger_rechts", "endriegel") + C("traeger_links", "traeger_rechts", "endriegel"),
             text=(["Träger und Endriegel verclipsen."] if pcs.get("traeger_links", 1) > 1 else []) +
                  ["Träger in die Kerben der Konsolen setzen (Kreuzverbindung).", "Endriegel landseitig durch beide Träger stecken."], render=S(6)),
        dict(title="Ausleger", parts=P("ausleger_links", "ausleger_rechts", "spitzenriegel") + C("ausleger_links", "ausleger_rechts", "spitzenriegel"),
             text=(["Ausleger und Spitzenriegel verclipsen."] if pcs.get("ausleger_links", 1) > 1 else []) +
                  [f"Ausleger mit je einem Filamentstift (Ø 1,75 mm, ca. {st} mm) an die Träger hängen.",
                   "Spitzenriegel einstecken. Der Ausleger klappt hoch und wird oben mit einem Raststift gehalten."],
             render=S(7)),
        dict(title="Maschinenhaus", parts=P("maschinenhaus") + C("maschinenhaus"), text=["Maschinenhaus auf den Rückausleger setzen."], render=S(8)),
        dict(title="Laufkatze und Kabine", parts=P("katze", "kabine") + C("katze"),
             text=["Katze auf die Träger legen – sie gleitet bis zur Auslegerspitze.", "Kabine unter die Katze stecken."], render=S(9)),
        dict(title="Spreader und Abspannung", parts=P("spreader", "spreader_kopf") + C("spreader"),
             text=(["Spreader-Rahmen verclipsen."] if pcs.get("spreader", 1) > 1 else []) +
                  ["Kopfstück mit den beiden Zapfen in die Mittelstrebe des Rahmens stecken.",
                   "Spreader an 4 Fäden unter die Katze hängen (Löcher in Katze und Spreader).",
                   "Optional: Abspannungen vom Mast zu Ausleger und Träger als Faden spannen.", "Der Spreader passt auf den 40-Fuß-Container."],
             render=S(10)),
    ]
    groesse = f"In 1:{mst} wird die Brücke ca. {laenge / 10:.0f} cm lang – Platz auf der Anlage einplanen"
    return dict(
        title="Containerbrücke", subtitle="Ship-to-Shore-Kran – Laufkatze, klappbarer Ausleger, Spreader", scale_txt=f"1:{mst}",
        scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam=VH, defs=D, size=(1600, 1300), auto=True),
        final_renders=[dict(scad=scad, cam=VH, defs=D, size=(1400, 1100), auto=True),
                       dict(scad=scad, cam="0,0,0,70,0,235,0", defs=D + ["ausleger_hoch=true", "katze_pos=0"], size=(1400, 1100), auto=True)],
        material=material([f"Filament-Stücke Ø 1,75 mm: 2 × Auslegergelenk, 2 × Raststift (je ca. {st} mm)", "Nähfaden für Spreader und Abspannungen"]),
        druck=druck(["Alle Fachwerke liegen flach – an jeder Naht sitzt eine massive Stoßplatte mit Clip-Tasche", groesse]),
        system=SYSTEM_CLIP + ["Beweglich: Laufkatze verschieben, Spreader an Fäden, Ausleger hochklappen, Fahrwerke rollen auf den Schienen."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Containerbrücke", "containerbruecke.scad", "", mst, bereich="1:43 und 1:87"),
        final=["Ausleger hochklappen: die Katze ganz nach hinten schieben, Stift aus dem Anschlag ziehen, Ausleger anheben und mit dem Raststift sichern.",
               "Laufkatze bis zur Auslegerspitze schieben, Container mit dem Spreader anheben."])
