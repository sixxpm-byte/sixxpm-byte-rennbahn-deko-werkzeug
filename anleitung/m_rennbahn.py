from common import *

COL = {"sockel": ("dunkelgrau", "#5f6368")}
PC = {"leitplanke": [("A", "silber", "#c9ced3")], "reifenstapel": [("A", "schwarz", "#262626"), ("B", "weiß", "#e9e9e9")],
      "betonwand": [("A", "weiß", "#ebe8e1"), ("B", "rot", "#c0392b")], "curb": [("A", "rot", "#c0392b"), ("B", "weiß", "#f2f2f2")]}

def seg(scad, D, p, form, name, n):
    d = D + [f'produkt="{p}"', f'form="{form}"', 'ansicht="druck"']
    fps = ([] if p == "curb" else [("sockel",) + COL["sockel"]]) + PC[p]
    return dict(id=f"{p}_{form}", name=name, count=n, pieces=1,
                exports=[(d + [f'farbteil="{fp}"'], hx, fp) for fp, nm, hx in fps], colors=[(nm, hx) for fp, nm, hx in fps],
                info=("je 12 m Vorbild" if form == "gerade" else "je 90°-Kurve (R 9 m)"))

def model():
    scad = MOD("rennbahn_deko")
    A = ANL("anl_rennbahn")
    D = ["massstab=43"]
    parts = [seg(scad, D, "leitplanke", "gerade", "Leitplanke gerade", 2), seg(scad, D, "leitplanke", "kurve", "Leitplanke Kurve", 2),
             seg(scad, D, "reifenstapel", "gerade", "Reifenstapel", 1), seg(scad, D, "curb", "gerade", "Curb gerade", 2),
             seg(scad, D, "betonwand", "gerade", "Betonleitwand", 2),
             dict(id="pylone", name="Pylonen (12er-Platte)", count=1, pieces=1,
                  exports=[(D + ['produkt="pylone"', 'farbteil="A"'], "#ff6a13", "A"), (D + ['produkt="pylone"', 'farbteil="B"'], "#f5f5f5", "B")],
                  colors=[("orange", "#ff6a13"), ("weiß", "#f5f5f5")], info="12 Pylonen"),
             dict(id="verbinder", name="Clips", count=1, pieces=1, exports=[(D + ['produkt="verbinder"'], "#444444", "alle")], colors=[("grau", "#8a8f94")], info="10 Clips")]
    for p in parts:
        if p["id"] == "reifenstapel_gerade": p["info"] = "Länge im Customizer"
    dd = D + ['produkt="none"']
    cam = "-260,-520,430,190,110,0"
    def S(n, c=cam): return R(A, c, dd + [f"schritt={n}"])
    steps = [
        dict(title="Leitplanke verbinden", parts=[("leitplanke_gerade", 2), ("verbinder", 1)],
             text=["Zwei Segmente aneinanderschieben.", "Teile kurz umdrehen und einen Clip in die Taschen über dem Stoß drücken (Detail)."],
             render=S(1), inset=R(ANL("clipdemo"), "-40,-75,80,0,0,8", [], (1000, 800)), inset_txt="Unterseite (Teile umgedreht)"),
        dict(title="Kurve anschließen", parts=[("leitplanke_kurve", 2), ("verbinder", 2)], text=["Die Kurvensegmente genauso mit Clips anschließen – jedes Ende passt an jedes Ende."], render=S(2)),
        dict(title="Reifenstapel", parts=[("reifenstapel_gerade", 1), ("verbinder", 1)], text=["Auch verschiedene Produkte passen zusammen: Reifenstapel an die Leitplanke clipsen."], render=S(3)),
        dict(title="Curbs", parts=[("curb_gerade", 2), ("verbinder", 1)], text=["Curbs an die Fahrbahnkante legen und untereinander verclipsen."], render=S(4)),
        dict(title="Betonleitwand", parts=[("betonwand_gerade", 2), ("verbinder", 1)], text=["Betonleitwand gegenüber aufstellen und verclipsen."], render=S(5)),
        dict(title="Pylonen", parts=[("pylone", 1)], text=["Pylonen von der Platte abbrechen und als Slalom aufstellen."], render=S(6)),
    ]
    return dict(
        title="Rennbahn-Deko", subtitle="Leitplanke, Reifenstapel, Betonleitwand, Curbs und Pylonen", scale_txt="1:43",
        scad=scad, parts=parts, steps=steps,
        cover=R(scad, "-260,-520,430,190,110,0", D + ['produkt="schaufenster"'], (1800, 1150)),
        final_renders=[R(scad, "-260,-520,430,190,110,0", D + ['produkt="schaufenster"'], (1600, 1000))],
        material=material(),
        druck=druck(["Segmente stehend mit dem Sockel auf dem Bett, Pylonen und Clips als Platte",
                     "Mehrfarbig: Sockel, Farbe A und Farbe B als getrennte Dateien – mit AMS/MMU oder einfarbig drucken"]),
        system=SYSTEM_CLIP + ["Alle Strecken-Produkte haben an beiden Enden dieselbe Tasche – jedes Ende passt an jedes Ende, auch an Imbissbude, Riesenrad oder Tribüne."],
        clip_png=CLIP_PNG,
        massstab_hinweis=hinweis("Rennbahn-Deko", "rennbahn_deko.scad", "Die Stückzahlen gelten für die Beispielszene; Länge, Radius und Winkel jedes Produkts sind frei einstellbar."),
        final=["Länge, Kurvenradius und -winkel, Plankenzahl, Reifenhöhe und Farbmuster im Customizer anpassen.",
               "Zu lange Strecken werden automatisch in gleich lange Segmente geteilt – die Konsole nennt die Anzahl."])
