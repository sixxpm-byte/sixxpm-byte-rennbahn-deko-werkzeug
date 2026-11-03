from common import *
import re

def echo(scad, mst):
    return run(["openscad", "-o", os.path.join(W, f"rs{mst}.csg"), "-D", f"massstab={mst}", "-D", 'teil="none"', scad]).stderr

def mm(x): return f"{float(x):.0f}"

def werte(log):
    v = {}
    m = re.search(r"Fahrgestell ([\d.]+) x ([\d.]+) mm \| Höhe \(Ausleger\) ([\d.]+) mm \| Winkel (\d+)", log)
    v["laenge"], v["breite"], v["hoehe"], v["winkel"] = (float(m.group(1)), float(m.group(2)), float(m.group(3)), m.group(4)) if m else (0, 0, 0, "20")
    m = re.search(r"Lager ([\d.]+) mm, Zylinder unten ([\d.]+) mm, oben ([\d.]+) mm, Kopf ([\d.]+) mm", log)
    v["stifte"] = [mm(m.group(i)) for i in range(1, 5)] if m else ["30", "30", "30", "20"]
    m = re.search(r"40' Boden/Dach (\d+) Stück\(e\), Seitenwand (\d+) Stück\(e\), (\d+) Clips", log)
    v["c40"], v["c40w"], v["clips"] = (int(m.group(1)), int(m.group(2)), int(m.group(3))) if m else (1, 1, 0)
    m = re.search(r"Zapfen Ø ([\d.]+)", log); v["zapfen"] = m.group(1).replace(".", ",") if m else "2"
    return v

def model(mst=43):
    scad = MOD("reachstacker")
    A = ANL("anl_reachstacker")
    D = [f"massstab={mst}"]
    v = werte(echo(scad, mst))
    andere = 87 if mst == 43 else 43
    va = werte(echo(scad, andere))
    names = {"fahrgestell": "Fahrgestell", "kabine": "Fahrerkabine", "rad_vorne": "Zwillingsrad vorne", "rad_hinten": "Rad hinten",
             "kotfluegel_links": "Kotflügel links", "kotfluegel_rechts": "Kotflügel rechts", "gelaender": "Geländer",
             "ausleger_aussen": "Ausleger Grundrohr", "ausleger_innen": "Ausleger Innenrohr", "zylinder": "Hubzylinder",
             "haenger": "Spreader-Aufhängung", "spreader_rahmen": "Spreader-Rahmen", "spreader_arm": "Teleskoparm",
             "c20_boden": "Container 20′ Boden", "c20_dach": "Container 20′ Dach", "c20_seite": "Container 20′ Seitenwand",
             "c20_stirn": "Container 20′ Stirnwand", "c20_tuer": "Container 20′ Türseite",
             "c40_boden": "Container 40′ Boden", "c40_dach": "Container 40′ Dach", "c40_seite": "Container 40′ Seitenwand",
             "c40_stirn": "Container 40′ Stirnwand", "c40_tuer": "Container 40′ Türseite", "verbinder": "Clips"}
    parts, _ = druck_parts(scad, D, names)
    order = list(names)
    parts.sort(key=lambda p: order.index(p["id"]) if p["id"] in order else 99)
    geteilt = v["clips"] > 0
    lage = {"fahrgestell": "aufrecht – Stützen unter den Gegengewicht-Flügeln", "kabine": "aufrecht", "rad_vorne": "liegend, Außenseite oben",
            "rad_hinten": "liegend, Außenseite oben", "kotfluegel_links": "liegt auf der Außenseite", "kotfluegel_rechts": "liegt auf der Außenseite",
            "gelaender": "liegt flach", "ausleger_aussen": "kopfüber", "ausleger_innen": "aufrecht", "zylinder": "liegend",
            "haenger": "aufrecht", "spreader_rahmen": "aufrecht", "spreader_arm": "kopfüber, Zapfen oben",
            "verbinder": f"{max(v['clips'], 4)} Clips auf einer Platte"}
    for p in parts:
        i = p["id"]
        if i in lage: p["info"] = lage[i]
        elif i.endswith("_boden") or i.endswith("_dach"):
            p["info"] = "kopfüber" + (f", {p['pieces']} Teile + Clips" if p["pieces"] > 1 else "")
        elif i.endswith("_seite"):
            p["info"] = "Innenseite unten" + (f", {p['pieces']} Teile" if p["pieces"] > 1 else "")
        elif i.endswith("_stirn") or i.endswith("_tuer"):
            p["info"] = "Außenseite unten"
    pc = {p["id"]: p["count"] for p in parts}
    def P(*ids): return [(i, pc[i]) for i in ids if i in pc]
    dd = D + ['teil="none"']
    VP, VC, VB = "0,0,0,62,0,215,0", "0,0,0,62,0,35,0", "0,0,0,70,0,150,0"
    def S(n, cam=VP, size=(1500, 1100), extra=()):
        return dict(scad=A, cam=cam, defs=dd + [f"schritt={n}"] + list(extra), size=size, auto=True)
    st = v["stifte"]
    steps = [
        dict(title="Räder", parts=P("fahrgestell", "rad_vorne", "rad_hinten"),
             text=["Zwillingsräder vorne und Einzelräder hinten mit der Innenseite auf die Rautenzapfen schieben – sie drehen sich."], render=S(1)),
        dict(title="Kotflügel mit Treppe", parts=P("kotfluegel_links", "kotfluegel_rechts", "gelaender"),
             text=["Kotflügel mit den Rautenzapfen seitlich in die Front stecken, Treppe nach hinten.", "Geländer in die Schlitze im Podest stecken."], render=S(2)),
        dict(title="Fahrerkabine", parts=P("kabine"), text=["Die Kabine auf die zwei Zapfen hinter dem Zylinderbock setzen, Frontscheibe nach vorn."], render=S(3)),
        dict(title="Ausleger-Grundrohr", parts=P("ausleger_aussen"),
             text=["Das Grundrohr zwischen die beiden Lagerböcke hinten halten.",
                   f"Filament-Bolzen Ø 1,75 mm ({st[0]} mm) durch Lagerböcke und Rohr schieben."],
             render=S(4), inset=dict(scad=A, cam="0,0,0,70,0,40,0", defs=dd + ["detail=1"], size=(1000, 800), auto=True), inset_txt="Bolzen im Lager"),
        dict(title="Innenrohr", parts=P("ausleger_innen"),
             text=["Das Innenrohr mit dem schwarzen Kopf nach vorne in das Grundrohr schieben.",
                   "Es gleitet stufenlos – vom eingefahrenen Zustand bis zum vollen Hub."], render=S(5)),
        dict(title="Hubzylinder", parts=P("zylinder"),
             text=[f"Unten mit einem Bolzen ({st[1]} mm) am Zylinderbock anbauen, Stange nach oben.",
                   f"Oben Bolzen ({st[2]} mm) durch beide Augen und die Konsole – der Ausleger steht starr auf {v['winkel']}°."], render=S(6)),
        dict(title="Spreader-Aufhängung", parts=P("haenger"),
             text=[f"Aufhängung zwischen die Laschen am Kopf halten, Bolzen ({st[3]} mm) durchstecken – sie pendelt frei."], render=S(7)),
        dict(title="Spreader", parts=P("spreader_rahmen", "spreader_arm"),
             text=["Rahmen mit dem Drehzapfen von unten in die Aufhängung stecken (drehbar).",
                   "Teleskoparme von den Enden in die Kanäle schieben: 20 Fuß eingefahren, 40 Fuß ausgezogen."], render=S(8)),
    ]
    if geteilt:
        steps.append(dict(title="40-Fuß-Container verclipsen", full=True, parts=P("c40_boden", "c40_dach", "verbinder"),
             text=[f"Boden und Dach (je {v['c40']} Teile) aneinanderlegen, die {v['clips']} Clips in die Taschen der Schotte drücken.",
                   "Die zweiteiligen Seitenwände Stoß an Stoß in die Nuten stellen."],
             render=dict(scad=A, cam="0,0,0,40,0,20,0", defs=dd + ["ansicht=2"], size=(1500, 1000), auto=True)))
    steps += [
        dict(title="Container: Boden und Stirnseiten", parts=P("c20_boden", "c20_stirn", "c20_tuer", "c40_boden", "c40_stirn", "c40_tuer"),
             text=["Stirnwand und Türseite mit der Feder in die Quernuten des Bodens stellen (40 Fuß genauso)."], render=S(9, VC, extra=["ansicht=1"])),
        dict(title="Container: Seitenwände und Dach", parts=P("c20_seite", "c20_dach", "c40_seite", "c40_dach"),
             text=["Seitenwände in die Längsnuten stellen, Sicken außen.", "Dach aufsetzen – die Nuten greifen über die Wände."], render=S(10, VC, extra=["ansicht=1"])),
        dict(title="Container aufnehmen", parts=[],
             text=["Spreader aufsetzen: die vier Zapfen greifen in die oberen Eckbeschläge.", "Für 40 Fuß beide Teleskoparme ganz ausziehen."], render=S(11)),
    ]
    unterschied = [f"Bolzen {va['stifte'][0]} / {va['stifte'][1]} / {va['stifte'][3]} mm"]
    if va["clips"] != v["clips"]:
        unterschied.append("40-Fuß-Container ungeteilt (keine Clips)" if va["clips"] == 0 else f"40-Fuß-Boden/Dach aus {va['c40']} Teilen mit {va['clips']} Clips")
    extra = f"In 1:{andere} sind die Bauschritte gleich, Unterschiede: " + ", ".join(unterschied) + "."
    return dict(
        title="Reach Stacker", cover_note="FDM, Stützen nur am Gegengewicht", subtitle="Container-Greifstapler mit Teleskop-Ausleger, Spreader und Container 20′/40′",
        scale_txt=f"1:{mst}", scad=scad, parts=parts, steps=steps,
        cover=dict(scad=scad, cam="0,0,0,64,0,215,0", defs=D + ["auszug=0.3"], size=(1600, 1200), auto=True),
        final_renders=[dict(scad=scad, cam="0,0,0,65,0,40,0", defs=D + ["auszug=0.8", "spreader_auszug=1"], size=(1400, 1000), auto=True),
                       dict(scad=scad, cam="0,0,0,62,0,215,0", defs=D + ['teil="explosion"', "container_zeigen=false"], size=(1400, 1000), auto=True)],
        material=material([f"Filament 1,75 mm für 4 Bolzen ({st[0]}, {st[1]}, {st[2]} und {st[3]} mm)",
                           f"Länge in 1:{mst} ca. {v['laenge'] / 10:.0f} cm, Höhe ca. {v['hoehe'] / 10:.0f} cm"]),
        druck=druck(["Alle Teile genau in der exportierten Lage drucken (siehe Druckliste)",
                     "Mehrfarbige Teile (Fahrgestell, Kabine, Räder, Innenrohr, Zylinder, Spreader-Rahmen, Container) mit AMS/MMU – oder einfarbig mit farbteil = alle",
                     "Bohrungen der Eckbeschläge stramm: zapfen_spiel im Customizer anpassen, falls der Container zu fest oder zu locker sitzt"],
                    stuetzen="Stützen NUR beim Fahrgestell: unter den Flügeln des Gegengewichts über den Hinterrädern (Stützen nur vom Druckbett). Alle anderen Teile drucken stützfrei."),
        system=(SYSTEM_CLIP if geteilt else SYSTEM_CLIP[:1] + [f"In 1:{mst} passen alle Teile ungeteilt aufs Druckbett – Clips brauchst du hier nicht."]) +
               ["Räder, Kabine und Kotflügel stecken auf Rautenzapfen – die Raute druckt in jeder Lage stützfrei.",
                "Der Container ist ein Bausatz: die Wände stecken mit Federn in Nuten von Boden und Dach.",
                f"Statt Twistlocks greifen vier Zapfen (Ø {v['zapfen']} mm) in die oberen Eckbeschläge – der Container sieht verriegelt aus und hält."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Reach Stacker", "reachstacker.scad", extra, mst, bereich="1:43 und 1:87"),
        final_title="Beweglich & Tipps",
        final=["Innenrohr ausziehen: der Ausleger wird länger, der Winkel bleibt starr.",
               "Die Aufhängung pendelt – der Spreader hängt bei jedem Winkel waagerecht und lässt sich drehen.",
               "Teleskoparme auf 20 Fuß einschieben oder für 40 Fuß ganz ausziehen.",
               f"Einen anderen Ausleger-Winkel im Customizer wählen (ausleger_winkel, jetzt {v['winkel']}°) – Zylinder und Aufhängung werden neu berechnet."])
