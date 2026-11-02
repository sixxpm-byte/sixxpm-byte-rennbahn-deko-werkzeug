from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"ff{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def mm(x): return f"{float(x):.0f}"

def werte(log):
    v = {}
    m = re.search(r"Höhe ([\d.]+) mm \| Podest ([\d.]+) mm \| Mast [\d.]+ mm, (\d+) Schüsse", log)
    v["hoehe"], v["podest_mm"], v["schuesse"] = (float(m.group(1)), float(m.group(2)), int(m.group(3))) if m else (0, 0, 1)
    m = re.search(r"1 x ([\d.]+) mm \(Sitzring\)", log); v["stift"] = mm(m.group(1)) if m else "40"
    m = re.search(r"Teilung Podest: (\d+) Stücke, (\d+) Clips", log)
    v["podest"], v["clips"] = (int(m.group(1)), int(m.group(2))) if m else (1, 0)
    return v

def model(mst=43):
    scad = MOD("freifallturm")
    A = ANL("anl_freifallturm")
    D = [f"massstab={mst}"]
    v = werte(echo(scad, mst))
    andere = 87 if mst == 43 else 43
    va = werte(echo(scad, andere))
    names = {"podest": "Podest", "treppe": "Treppe", "mast": "Mast-Schuss", "gondel": "Sitzring", "kopf": "Maschinenhaus",
             "zaun": "Absperrgitter", "portal": "Eingangsportal", "kasse": "Kassenhaus", "kasse_dach": "Kassenhaus Dach", "verbinder": "Clips"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    geteilt = v["podest"] > 1
    for p in parts:
        info = {"podest": f"{p['pieces']} Teile + Clips" if geteilt else "einteilig",
                "mast": "steht – Tasche unten, Zapfen oben", "gondel": "Ringplatte unten",
                "kopf": "steht auf der Rautentasche", "portal": "liegt flach, Schauseite oben",
                "zaun": "liegt flach", "kasse": "oben offen", "verbinder": f"{max(v['clips'], 4)} Clips auf einer Platte"}.get(p["id"])
        if info: p["info"] = info
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VP, VT, VK = "0,0,0,58,0,25,0", "0,0,0,72,0,25,0", "0,0,0,60,0,-30,0"
    def S(n, cam=VP, size=(1500, 1100)):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"], size=size, auto=True)
    steps = []
    if geteilt:
        steps.append(dict(title="Podest verclipsen", full=True, parts=P("podest", "verbinder"),
             text=[f"Die {v['podest']} Podest-Teile umgedreht aneinanderlegen.",
                   f"Die {v['clips']} Clips in die Taschen über den Nähten drücken, dann das Podest umdrehen."],
             render=S(1), inset=dict(scad=A, cam="0,0,0,40,0,25,0", defs=dd + ["detail=1"], size=(1100, 800), auto=True),
             inset_txt="Unterseite mit Clips"))
    steps += [
        dict(title="Treppe", parts=P("treppe") + ([] if geteilt else P("podest")),
             text=(["Das Podest hinstellen – die Sicherheitslinie zeigt nach oben."] if not geteilt else []) +
                  ["Die Treppe vorne mittig an das Podest schieben (vorne = die offene Seite der Absperrung)."], render=S(2)),
        dict(title="Mast stecken", parts=P("mast"),
             text=[f"Die {v['schuesse']} Mast-Schüsse übereinanderstecken: die Rautentasche unten auf den Rautenzapfen darunter.",
                   "Der unterste Schuss steckt auf dem Zapfen in der Podestmitte."],
             render=S(3, VT, (1000, 1500))),
        dict(title="Sitzring", parts=P("gondel"),
             text=["Den Sitzring von oben über den Mast schieben, die Sitze schauen nach außen.",
                   f"Filament-Stift Ø 1,75 mm ({v['stift']} mm) durch den Kragen stecken – er liegt auf einer Diagonale auf und hält den Ring."],
             render=S(4, VT, (1000, 1500)),
             inset=dict(scad=A, cam="0,0,0,65,0,30,0", defs=dd + ["detail=2"], size=(1000, 800), auto=True), inset_txt="Stift durch den Kragen"),
        dict(title="Maschinenhaus", parts=P("kopf"), text=["Das Maschinenhaus mit der Tasche unten auf den obersten Mastzapfen stecken."],
             render=S(5, VT, (1000, 1500))),
        dict(title="Absperrgitter", full=True, parts=P("zaun"),
             text=[f"Die {pc.get('zaun', 7)} Gitter mit ihren Zapfen in die Schlitze rund um den Turm stecken.",
                   "Vorne bleibt eine Seite offen – das ist der Einstieg."], render=S(6)),
        dict(title="Eingangsportal", parts=P("portal"), text=["Das Portal mit den beiden Zapfen in die Schlitze vorne im Podest stecken."], render=S(7)),
        dict(title="Kassenhaus", parts=P("kasse", "kasse_dach"),
             text=["Das Kassenhaus neben das Portal auf das Podest stellen, Schalter nach vorn.", "Das Dach auflegen."],
             render=S(9, VK)),
    ]
    unterschied = []
    if va["podest"] != v["podest"]:
        unterschied.append("Podest einteilig (keine Clips)" if va["podest"] == 1 else f"Podest aus {va['podest']} Teilen mit {va['clips']} Clips")
    if va["schuesse"] != v["schuesse"]:
        unterschied.append(f"{va['schuesse']} Mast-Schüsse")
    unterschied.append(f"Sitzring-Stift {va['stift']} mm")
    extra = f"In 1:{andere} sind die Bauschritte gleich, Unterschiede: " + ", ".join(unterschied) + "."
    return dict(
        title="Freifallturm", subtitle="Kirmes-Freifallturm – Gittermast, verschiebbarer Sitzring, Portal und Kasse", scale_txt=f"1:{mst}",
        scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,70,0,25,0", defs=D, size=(1200, 1600), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,62,0,-30,0", defs=D + ["gondel_pos=1"], size=(1000, 1400), auto=True),
                       dict(scad=scad, cam="0,0,0,60,0,25,0", defs=D + ["teil=\"explosion\""], size=(1000, 1400), auto=True)],
        material=material([f"Ein Rest Filament 1,75 mm für den Stift am Sitzring ({v['stift']} mm)",
                           f"Höhe in 1:{mst} ca. {v['hoehe'] / 10:.0f} cm – Platz nach oben einplanen"]),
        druck=druck(["Mast-Schüsse stehen beim Druck (Tasche unten, Zapfen oben) – die Gitter-Diagonalen sind mindestens 45° steil",
                     "Portal und Gitter liegen flach, Sitzring und Maschinenhaus stehen aufrecht",
                     "Mehrfarbige Teile (Podest, Mast, Sitzring, Maschinenhaus, Portal) mit AMS/MMU – oder einfarbig mit farbteil = alle"]),
        system=(SYSTEM_CLIP if geteilt else SYSTEM_CLIP[:1] + ["Das Podest ist in diesem Maßstab einteilig – Clips brauchst du nur für die Rennbahn-Taschen."]) +
               ["Mast, Podest und Maschinenhaus stecken mit Rautenzapfen ineinander – die Raute druckt in jeder Lage stützfrei.",
                "Beweglich: Der Sitzring gleitet auf dem Mast. Der Stift im Kragen hält ihn oben (vor dem Fall) oder unten (Einsteigen)."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Freifallturm", "freifallturm.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Sitzring hochschieben, Stift durch den Kragen stecken – er liegt auf der nächsten Diagonale und hält den Ring.",
               "Ring sitzt zu stramm? Die Bohrung mit Schleifpapier nacharbeiten, nicht den Mast.",
               "Den Turm am Podest tragen – Mast und Maschinenhaus sind nur gesteckt.",
               "Portaltext, Sitzanzahl und Farben im Customizer ändern."])
