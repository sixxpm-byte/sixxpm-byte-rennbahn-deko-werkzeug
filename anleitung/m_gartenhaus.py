from common import *
import re

def model(mst=43):
    scad = MOD("gartenhaus")
    A = ANL("anl_gartenhaus")
    D = [f"massstab={mst}"]
    log = run(["openscad", "-o", os.path.join(W, f"gh{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr
    mc = re.search(r"Verbinder-Clips gesamt: (\d+)", log)
    n_clips = int(mc.group(1)) if mc else 0
    parts, _ = druck_parts(scad, D)
    for p in parts:
        i = p["id"]
        if i == "bodenplatte": p["info"] = "Terrasse grau, Sockel hell (2 Farben)"
        if i == "wand_vorne": p["info"] = "Front: Fenster + Türöffnung"
        if i.startswith("wand_") and i != "wand_vorne": p["info"] = "Glas = erste Schichten"
        if i == "tuer": p["info"] = "Zapfen oben und unten"
        if i == "rahmen_giebel": p["info"] = "Veranda-Giebel, flach gedruckt"
        if i.startswith("pfette"): p["info"] = "Zapfen vorne"
        if i.startswith("dach"): p["info"] = "Pfannen oben, Unterseite weiß"
        if i == "bruestung_seite": p["info"] = "links und rechts gleich"
        if i == "kuebel": p["info"] = "Kübel, Pflanze, Blüten"
        if i == "verbinder": p["info"] = f"{n_clips} Clips"
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    V = "0,0,0,62,0,22,0"            # vorne rechts, von oben
    def S(n, cam=V, extra=(), size=(1600, 1100)):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    def DET(n, extra, cam):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=(1100, 900), auto=True)
    steps = [
        dict(title="Bodenplatte", parts=P("bodenplatte", "verbinder"),
             text=["Die Bodenplatte hinlegen: graue Terrasse, darauf der helle Sockel mit den Nuten für die Wände.",
                   "Die Taschen an den Rändern passen zum Stecksystem der Rennbahn-Deko."],
             render=S(1)),
        dict(title="Front und linke Wand", full=True, parts=P("wand_vorne", "wand_links"),
             text=["Die Front (Fenster und Türöffnung) mit der Feder unten in die vordere Nut stecken.",
                   "Die linke Wand dahinter einsetzen – sie steht zwischen Front und Rückwand."],
             render=S(2)),
        dict(title="Rechte Wand und Rückwand", parts=P("wand_rechts", "wand_hinten"),
             text=["Rechte Wand und Rückwand einstecken. Die Wände halten sich gegenseitig, kleben ist nicht nötig."],
             render=S(3, "0,0,0,62,0,-35,0")),
        dict(title="Tür einsetzen", full=True, parts=P("tuer"),
             text=["Die Tür schräg halten und den oberen Zapfen von unten in das Loch im Sturz schieben.",
                   "Dann die Tür senkrecht stellen und den unteren Zapfen in das Loch im Sockel absenken. Sie öffnet nach außen."],
             render=S(4), inset=DET(4, ["detail=1"], "0,0,0,78,0,18,0"), inset_txt="oben einfädeln, unten absenken"),
        dict(title="Veranda-Giebel", parts=P("rahmen_giebel"),
             text=["Den weißen Giebel mit den Zapfen der Eckpfosten vorne in den Sockel stecken.",
                   "Die Taschen für die Seitenbalken zeigen nach innen zum Haus."],
             render=S(5)),
        dict(title="Seitenbalken", full=True, parts=P("pfette_links", "pfette_rechts"),
             text=["Jeden Seitenbalken mit dem Zapfen von hinten in die Tasche des Eckpfostens schieben.",
                   "Das Kopfband zeigt nach vorne unten, das hintere Ende liegt an der Front."],
             render=S(6), inset=DET(6, ["detail=2"], "0,0,0,55,0,150,0"), inset_txt="Zapfen in die Tasche (von innen)"),
        dict(title="Brüstung", parts=P("bruestung_vorne_links", "bruestung_vorne_rechts", "bruestung_seite"),
             text=["Die beiden Seitenteile und die zwei vorderen Brüstungen in die Sockelnut stecken.",
                   "Vor der Tür bleibt der Eingang frei."],
             render=S(7)),
        dict(title="Dach auflegen", full=True, parts=P("dach_links", "dach_rechts"),
             text=["Die Dachhälften auflegen: die Nuten auf der Unterseite greifen über Veranda-Giebel, Front und Rückwand.",
                   "Am First treffen sich die Hälften. Das Dach ist nur aufgelegt und lässt sich zum Hineinschauen abnehmen."],
             render=S(8)),
        dict(title="Gartenmöbel und Blumen", parts=P("bank", "stuhl", "kuebel"),
             text=["Bank auf die Terrasse, Stuhl auf die Veranda und die Blumenkübel neben den Eingang stellen."],
             render=S(9)),
    ]
    return dict(
        title="Gartenhaus", subtitle="Blockbohlen-Gartenhaus mit Veranda – Schwedenrot, Fensterläden, drehbare Tür", scale_txt=f"1:{mst}",
        scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,66,0,24,0", defs=D + ["tuer_winkel=45"], size=(2000, 1250), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,60,0,-140,0", defs=D, size=(1600, 1100), auto=True),
                       dict(scad=scad, cam="0,0,0,50,0,28,0", defs=D + ["dach_zeigen=false", "tuer_winkel=80"], size=(1600, 1100), auto=True)],
        material=material(),
        druck=druck(["Wände, Brüstungen, Giebel und Balken liegen flach (Außenseite oben); Fensterglas in den ersten Schichten",
                     "Dachhälften mit der Unterseite auf dem Bett: weiße Unterschicht und Kanten zuerst, darüber die Pfannen",
                     "Mehrfarbige Teile (Wände, Dach, Bodenplatte, Kübel) mit AMS/MMU oder einfarbig mit farbteil = alle"]),
        system=SYSTEM_CLIP + ["Beweglich: Die Tür dreht sich auf zwei Zapfen und öffnet nach außen. Das Dach ist nur aufgelegt."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Gartenhaus", "gartenhaus.scad", "Maße, Fenster, Brüstung und alle Farben lassen sich im Customizer ändern.", mst),
        final_title="Beweglich & Tipps",
        final=["Die Tür von Hand öffnen – sie schwenkt nach außen auf die Veranda.",
               "Dach abheben und hineinschauen: Sockel, Wände und Fenster sind auch von innen sichtbar.",
               "Im Customizer von gartenhaus.scad: Breite, Tiefe, Veranda, Dachneigung, Fenster an Seiten und Rückwand, Brüstung und alle Farben."])
