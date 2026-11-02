from common import *
import re

def mm(x): return f"{float(x):.0f}"

def model(mst=43):
    scad = MOD("hafenkran")
    A = ANL("anl_hafenkran")
    D = [f"massstab={mst}"]
    log = run(["openscad", "-o", os.path.join(W, f"hk{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr
    ms = re.search(r"Auslegerlager ([\d.]+) mm, Zahnstange am Ausleger ([\d.]+) mm, 2x Lager ([\d.]+) mm", log)
    st_a, st_z, st_l = (mm(ms.group(1)), mm(ms.group(2)), mm(ms.group(3))) if ms else ("44", "56", "15")
    mk = re.search(r"Kranschiene: 2 Stränge à (\d+) Segment", log); schn = int(mk.group(1)) if mk else 1
    names = {"schiene": "Kranschiene", "fahrwerk": "Fahrwerk", "portal_seite": "Portal-Seitenrahmen", "portal_quer": "Portal-Querträger",
             "plattform": "Portalplattform", "zapfen": "Königszapfen", "drehbuehne": "Drehbühne (Oberwagen)", "turm": "Turmseite",
             "traverse": "Traverse", "ausleger": "Wippausleger", "wippstange": "Zahnstange", "hakenflasche": "Haken", "verbinder": "Clips"}
    parts, _ = druck_parts(scad, D, names)
    pcs = {p["id"]: p["pieces"] for p in parts}
    pc = {p["id"]: p["count"] for p in parts}
    for p in parts:
        i = p["id"]
        info = {"schiene": f"2 Stränge à {schn} Segment{'e' if schn > 1 else ''}",
                "ausleger": f"{p['pieces']} Teile + Clips" if p["pieces"] > 1 else "einteilig, liegt diagonal",
                "drehbuehne": f"{p['pieces']} Teile + Clips" if p["pieces"] > 1 else "steht aufrecht",
                "wippstange": "einteilig, liegt diagonal", "fahrwerk": "steht auf den Rädern",
                "verbinder": "Clips für Nähte und Rennbahn-Taschen"}.get(i)
        if info: p["info"] = info
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VL, VH = "0,0,0,62,0,25,0", "0,0,0,72,0,30,0"
    def S(n, cam=VL, size=(1500, 1100)): return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"], size=size, auto=True)
    steps = [dict(title="Kranschienen", parts=P("schiene") + (P("verbinder") if schn > 1 else []),
                  text=(["Je zwei Schienensegmente hintereinanderlegen und unten mit einem Clip verbinden."] if schn > 1 else
                        ["Die beiden Kranschienen parallel hinlegen."]) +
                       ["Die Clip-Taschen an den Enden passen auch an die Rennbahn-Deko."], render=S(1)),
             dict(title="Fahrwerke", parts=P("fahrwerk"), text=["Die vier Fahrwerke auf die Schienen setzen."], render=S(2)),
             dict(title="Portal-Seitenrahmen", parts=P("portal_seite"), text=["Die Seitenrahmen mit den Füßen in die Fahrwerke stecken."], render=S(3)),
             dict(title="Portal-Querträger", parts=P("portal_quer"), text=["Querträger mit ihren Zapfen durch die Seitenrahmen stecken."], render=S(4)),
             dict(title="Plattform", parts=P("plattform"), text=["Plattform aufsetzen – die Laschen greifen in die Löcher der Rahmen."], render=S(5))]
    db = dict(title="Königszapfen und Drehbühne", parts=P("zapfen", "drehbuehne"),
              text=([f"Die {pcs['drehbuehne']} Teile der Drehbühne umgedreht verclipsen."] if pcs.get("drehbuehne", 1) > 1 else []) +
                   ["Zapfen von unten fest in die Drehbühne drücken und die Drehbühne mit dem Zapfen in die Plattform setzen – sie dreht sich."],
              render=S(6))
    if pcs.get("drehbuehne", 1) > 1:
        db.update(full=True, inset=dict(scad=A, cam="0,0,0,40,0,20,0", defs=dd + ["detail=1"], size=(1100, 800), auto=True), inset_txt="Unterseite mit Clips")
    steps += [db,
              dict(title="Turm und Traverse", parts=P("turm", "traverse"), text=["Beide Turmseiten in die Drehbühne stecken, die Traverse zwischen die Turmseiten schieben."], render=S(7, VH)),
              dict(title="Wippausleger", parts=P("ausleger"),
                   text=([f"Die {pcs['ausleger']} Auslegerstücke verclipsen."] if pcs.get("ausleger", 1) > 1 else []) +
                        [f"Ausleger mit einem Filamentstift (Ø 1,75 mm, ca. {st_a} mm) am Turm lagern – er kippt."], render=S(8, VH)),
              dict(title="Zahnstangen", parts=P("wippstange"),
                   text=[f"Die Zahnstangen mit einem Stift (ca. {st_z} mm) am Ausleger einhängen.",
                         f"Gewünschten Wippwinkel wählen und je einen Stift (ca. {st_l} mm) durch das passende Loch im Lager stecken."], render=S(9, VH)),
              dict(title="Haken", parts=P("hakenflasche"), text=["Einen Faden durch das Loch im Auslegerkopf fädeln und den Haken anknoten."], render=S(10, VH))]
    return dict(
        title="Hafenkran", subtitle="Portal-Wippdrehkran – drehbar, Ausleger in 5 Stufen verstellbar", scale_txt=f"1:{mst}",
        scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,65,0,35,0", defs=D, size=(1500, 1300), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,65,0,35,0", defs=D + ["vorschau_stufe=5", "drehung=60"], size=(1300, 1200), auto=True),
                       dict(scad=scad, cam="0,0,0,65,0,35,0", defs=D + ["vorschau_stufe=1", "drehung=0"], size=(1300, 1200), auto=True)],
        material=material([f"Filament-Stücke Ø 1,75 mm: Auslegerlager ca. {st_a} mm, Zahnstange ca. {st_z} mm, 2 × Lager ca. {st_l} mm", "Nähfaden für den Haken"]),
        druck=druck(["Fachwerke (Rahmen, Turm, Ausleger) und Zahnstangen flach, Drehbühne und Fahrwerke aufrecht – Löcher sind senkrecht oder als Tropfen geformt",
                     "Lange, schmale Teile (Zahnstangen" + (", Ausleger" if pcs.get("ausleger", 1) == 1 else "") + ") liegen diagonal auf dem Bett – so bleiben sie ungeteilt und stabil"]),
        system=SYSTEM_CLIP + ["Beweglich: Der Oberwagen dreht auf dem Königszapfen, der Ausleger kippt am Turm, der Wippwinkel wird über die Zahnstangen eingerastet."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Hafenkran", "hafenkran.scad", "", mst, bereich="1:43 und 1:87"),
        final=["Wippwinkel ändern: Stifte aus dem Lager ziehen, Ausleger kippen, Stift ins nächste Loch – die Lochabstände passen genau zu den Winkeln in „wippwinkel“.",
               "Oberwagen drehen und das Portal auf den Schienen fahren lassen."])
