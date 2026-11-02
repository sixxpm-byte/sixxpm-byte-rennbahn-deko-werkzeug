from common import *
import re

def model(mst=43):
    scad = MOD("zeitnahmeturm")
    A = ANL("anl_zeitnahmeturm")
    D = [f"massstab={mst}"]
    log = run(["openscad", "-o", os.path.join(W, f"zt{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr
    mc = re.search(r"Verbinder-Clips gesamt: (\d+)", log)
    n_clips = int(mc.group(1)) if mc else 0
    parts, _ = druck_parts(scad, D)
    for p in parts:
        i = p["id"]
        if i == "bodenplatte": p["info"] = "Platz und Sockel (2 Farben)"
        if i.startswith("eg_wand") or i.startswith("og_wand"): p["info"] = "flach, Außenseite oben"
        if i == "decke_2": p["info"] = "Karo-Band, 3 Farben"
        if i.startswith("kanzel"): p["info"] = "Glas = erste Schichten"
        if i == "kanzel_front": p["info"] = "vorne und hinten gleich"
        if i == "kanzel_rechts": p["info"] = "mit Glastür"
        if i.startswith("treppe"): p["info"] = "liegt auf der Außenwange"
        if i.startswith("podest"): p["info"] = "Zapfen zur Wand, Löcher fürs Geländer"
        if i.startswith("gelaender"): p["info"] = "flach liegend, Zapfen ins Podest"
        if i == "fahne": p["info"] = "Mast + Zielflagge, flach"
        if i == "verbinder": p["info"] = f"{n_clips} Clips"
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VR, VH, VL = "0,0,0,68,0,25,0", "0,0,0,68,0,-140,0", "0,0,0,68,0,-55,0"
    def S(n, cam=VR, extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=(1300, 1500), auto=True)
    steps = [
        dict(title="Bodenplatte", parts=P("bodenplatte", "verbinder"),
             text=["Die Bodenplatte hinlegen: Platz mit hellem Sockel und Nuten für den Technikraum.",
                   "Die Taschen an den Rändern passen zum Stecksystem der Rennbahn-Deko."], render=S(1)),
        dict(title="Technikraum", parts=P("eg_wand_vorne", "eg_wand_links", "eg_wand_rechts", "eg_wand_hinten"),
             text=["Front (Stahltür) und Rückwand außen, die Seitenwände dazwischen in die Sockelnut stecken."], render=S(2)),
        dict(title="Decke 1", parts=P("decke_1"),
             text=["Die Decke mit dem roten Rand auflegen – die Nut unten greift über die Wände."], render=S(3)),
        dict(title="Zeitnahme-Etage", parts=P("og_wand_vorne", "og_wand_links", "og_wand_rechts", "og_wand_hinten"),
             text=["Die vier Etagen-Wände in die Nut der Decke stecken. Die Tür zum Podest sitzt links hinten."], render=S(4)),
        dict(title="Zielflaggen-Band", parts=P("decke_2"),
             text=["Das Karo-Band auflegen – es ist zugleich der Boden der Kanzel."], render=S(5)),
        dict(title="Kanzel", full=True, parts=P("pult", "kanzel_front", "kanzel_links", "kanzel_rechts"),
             text=["Das Pult vorne in die Kanzel stellen.",
                   "Die vier Glaswände mit der Feder in die schräge Nut stecken: vorne und hinten gleich, rechts die Wand mit der Glastür (nach vorne).",
                   "An den Ecken treffen sich die Wände auf Gehrung."], render=S(6)),
        dict(title="Dach", parts=P("dach"),
             text=["Das Dach auflegen – die schräge Nut auf der Unterseite hält die Glaswände oben zusammen."], render=S(7)),
        dict(title="Schild und Fahne", parts=P("schild", "fahne"),
             text=["Schild RACE CONTROL vorne mit den zwei Zapfen ins Dach stecken, den Fahnenmast hinten rechts."], render=S(8)),
        dict(title="Stützen", parts=P("stuetze_1", "stuetze_2", "stuetze_3", "stuetze_4"),
             text=["Die vier Stützen in die Löcher der Bodenplatte stecken (Stütze 1 rechts hinten, 2 links hinten, 3 links vorne, 4 rechts vorne)."],
             render=S(9)),
        dict(title="Treppe 1 und Podest 1", full=True, parts=P("treppe_1", "podest_1"),
             text=["Treppe 1 an der rechten Seite mit den Zapfen in die Löcher der Wand schieben, unten steht sie auf der Platte.",
                   "Podest 1 rechts hinten mit den Zapfen in die Wand und dem Loch auf Stütze 1 setzen."],
             render=S(10), inset=dict(scad=A, cam="0,0,0,62,0,-160,0", defs=dd + ["detail=1"], size=(1100, 800), auto=True), inset_txt="Zapfen in die Wandlöcher"),
        dict(title="Treppe 2 und Podest 2", parts=P("treppe_2", "podest_2"),
             text=["Treppe 2 hinten einstecken, Podest 2 links hinten vor die Etagen-Tür setzen (Zapfen in die Decke, Stütze 2)."], render=S(11, VH)),
        dict(title="Treppe 3 und Podest 3", parts=P("treppe_3", "podest_3"),
             text=["Treppe 3 links einstecken, Podest 3 links vorne auf Stütze 3 setzen."], render=S(12, VL)),
        dict(title="Treppe 4 und Podest 4", full=True, parts=P("treppe_4", "podest_4"),
             text=["Treppe 4 vorne einstecken, Podest 4 vor der Glastür der Kanzel auf Stütze 4 setzen (Zapfen ins Karo-Band)."], render=S(13)),
        dict(title="Geländer rechts", parts=P("gelaender_1", "gelaender_4"),
             text=["Die Geländer von Podest 1 und Podest 4 von oben mit den Zapfen in die Löcher am Podestrand stecken.",
                   "Jede Podestkante hat einen eigenen Rahmen; an den Ecken stoßen sie aneinander."], render=S(14)),
        dict(title="Geländer links", parts=P("gelaender_2", "gelaender_3"),
             text=["Ebenso die Geländer von Podest 2 (links hinten) und Podest 3 (links vorne) einstecken."], render=S(15, VL)),
    ]
    return dict(
        title="Zeitnahmeturm", subtitle="Race Control mit Tower-Kanzel, Zielflaggen-Band und umlaufender Stahltreppe", scale_txt=f"1:{mst}",
        scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,70,0,25,0", defs=D, size=(1600, 1250), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,68,0,-140,0", defs=D, size=(1300, 1500), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,25,0", defs=D + ['teil="explosion"'], size=(1300, 1500), auto=True)],
        material=material(),
        druck=druck(["Wände, Kanzel-Glaswände, Schild und Fahne liegen flach (Schauseite oben), Glas in den ersten Schichten",
                     "Treppenläufe liegen auf der Außenwange mit dem Geländer; die Stufen stehen senkrecht, die Innenwange überbrückt kurz",
                     "Podest-Geländer liegen flach: geschlossene Rahmen mit Fußleiste, Knieleiste und Handlauf",
                     "Mehrfarbige Teile (Wände, Decken, Kanzel, Dach, Schild, Fahne, Treppen) mit AMS/MMU oder einfarbig mit farbteil = alle"]),
        system=SYSTEM_CLIP + ["Zerlegbar: Alle Geschosse sind nur gesteckt. Dach, Kanzel und Etagen lassen sich abheben."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Zeitnahmeturm", "zeitnahmeturm.scad", "Maße, Kanzel-Neigung, Schildtext, Fahne und alle Farben lassen sich im Customizer ändern.", mst),
        final_title="Tipps",
        final=["Dach abheben: Pult und Kanzel von oben ansehen. Für den Blick in die Etagen Band oder Decke abnehmen.",
               "Schildtext im Customizer ändern (z. B. Streckenname) – die Schrift passt sich der Schildbreite an.",
               "Der Turm passt mit den Taschen der Bodenplatte an die Streckenteile der Rennbahn-Deko-Reihe."])
