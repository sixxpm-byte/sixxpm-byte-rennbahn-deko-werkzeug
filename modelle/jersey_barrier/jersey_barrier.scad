// =====================================================================
//  JERSEY BARRIER  –  Betonschutzwand als Baukasten für den 3D-Druck
//  parametrisch, alle gängigen Maßstäbe, FDM-optimiert (stützfrei),
//  einzelne Elemente, steckbar, Kurven möglich
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    element             Standard-Element (gerade oder Bogen)
//    endstueck_anfang    Rampen-Endstück für den Anfang einer Reihe
//    endstueck_ende      Rampen-Endstück für das Ende einer Reihe
//    verbinder           Gelenk-Verbinder bzw. Clips
//    kette               Vorschau: Reihe aus mehreren Elementen
//
//  VERBINDUNGEN  (verbindung = ...)
//    gelenk  verdeckter Knochen-Verbinder unter den Elementen. Die
//            Elemente bleiben bis "gelenk_winkel" gegeneinander
//            drehbar – so entstehen Kurven aus geraden Elementen.
//    tlock   senkrechter Schwalbenschwanz wie beim T-LOCK-System.
//            Von oben einschieben, starr, sehr realistisch.
//    clip    Schwalbenschwanz-Clip von unten, kompatibel mit
//            rennbahn_deko.scad (Leitplanke, Reifenstapel ...)
//    auto    T-Lock, wenn die Wand oben breit genug ist, sonst Gelenk
//
//  DRUCK: aufrecht auf der Standfläche, alle Flächen neigen sich nach
//    innen, Staplertaschen mit Spitzbogen – keine Stützen nötig.
//    Zu lange Elemente werden automatisch geteilt (Clips von unten).
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "kette"; // [kette:Vorschau Reihe, element:Element, endstueck_anfang:Endstück Anfang, endstueck_ende:Endstück Ende, verbinder:Verbinder]
// Geteilte Elemente: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Mehrfarbig: A = Grundfarbe, B = Streifen und Reflektoren
farbteil = "alle"; // [alle, A, B]

/* [Profil (Vorbild)] */
profil = "new_jersey"; // [new_jersey:New Jersey, f_shape:F-Shape, single_slope:Single Slope]
// Höhe in mm (813 = 32 Zoll, 1070 = 42 Zoll)
hoehe_mm = 813;
// Elementlänge in m (3,81 = 12,5 Fuß; EU oft 4,0 oder 6,0)
laenge_m = 3.81;
// Bogenwinkel je Element (0 = gerade, positiv = Linksbogen)
bogen_winkel = 0; // [-45:45]

/* [Verbindung] */
verbindung = "auto"; // [auto, gelenk, tlock, clip, keine]
// maximaler Knickwinkel zwischen zwei Elementen (Gelenk)
gelenk_winkel = 15; // [0:30]

/* [Details] */
staplertaschen = true;
hebeanker = true;
reflektoren = true;
farbmuster = "beton"; // [beton:Beton einfarbig, streifen:Rot-Weiß-Streifen]
streifen_m = 1.0;

/* [Vorschau Kette] */
vorschau_anzahl = 5; // [1:12]
// Knick je Fuge in der Vorschau (nur Gelenk)
vorschau_knick = 8; // [-30:30]
vorschau_endstuecke = true;

/* [Druck & Passung] */
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;

// =====================================================================
//  Grundlagen
// =====================================================================
$fa = 2; $fs = 0.3;
e   = 0.01;
den = massstab == 0 ? eigener_massstab : massstab;
s   = 1 / den;
function sc(mm, mn = 0) = max(mm * s, mn);
function r2(x) = round(x * 100) / 100;
function inc(fp, g) = fp == "alle" || fp == g;
usable = druckbett - 2 * rand;
gap = 0.1;

// Rennbahn-Clip (identisch mit rennbahn_deko.scad)
function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] : d <= 20 ? [16, 6, 10, 3.2] : d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] : d <= 50 ? [10, 4, 7, 2] : [8, 3.2, 5.6, 1.6];
CT = conn_tab(den);
cL = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];

// =====================================================================
//  Profil  (Halbprofil als Punkte [halbe Breite, Höhe], Vorbild-mm)
// =====================================================================
HV = hoehe_mm;
function prof_v(p) =
    p == "new_jersey" ? let(z1 = 75, z2 = 330, w1 = 305 - (z2 - z1) / tan(55)) [[305, 0], [305, z1], [w1, z2], [w1 - (HV - z2) / tan(84), HV]] :
    p == "f_shape"    ? let(z1 = 75, z2 = 255, w1 = 305 - (z2 - z1) / tan(55)) [[305, 0], [305, z1], [w1, z2], [w1 - (HV - z2) / tan(84), HV]] :
                        [[305, 0], [305, 50], [305 - (HV - 50) * tan(10.8), HV]];
PV = prof_v(profil);
// skaliert, mit Mindestmaßen
H   = sc(HV, 5);
hw0 = sc(305, 2.2);
fz  = H / HV;                                // Höhenfaktor (Mindesthöhe wirkt auf das ganze Profil)
PH  = [for (p = PV) [max(p[0] * hw0 / 305, min_wand), p[1] * fz]];
top_w = 2 * PH[len(PH) - 1][0];
L   = sc(laenge_m * 1000, 12);
module profil_2d() polygon(concat(PH, [for (i = [len(PH) - 1 : -1 : 0]) [-PH[i][0], PH[i][1]]]));
function hw_at(z) = let(i = max([for (k = [0 : len(PH) - 2]) if (PH[k][1] <= z) k]), a = PH[i], b = PH[i + 1])
    a[0] + (b[0] - a[0]) * min(1, max(0, (z - a[1]) / max(b[1] - a[1], e)));

// =====================================================================
//  Pfad (gerade oder Bogen), lokal: x = Längsrichtung, y = links
// =====================================================================
$kurve = bogen_winkel != 0;
$R     = bogen_winkel != 0 ? L / (abs(bogen_winkel) * PI / 180) : 1e6;
$sgn   = bogen_winkel < 0 ? -1 : 1;
function adeg(sv) = sv / $R * 180 / PI;
module at(sv, u = 0) {
    if ($kurve) mirror([0, $sgn < 0 ? 1 : 0, 0])
        translate([0, $R, 0]) rotate([0, 0, adeg(sv)]) translate([0, -$R + $sgn * u, 0]) mirror([0, $sgn < 0 ? 1 : 0, 0]) children();
    else translate([sv, u, 0]) children();
}
module path_extrude(s0, s1) {
    if (s1 > s0) {
        if ($kurve) mirror([0, $sgn < 0 ? 1 : 0, 0])
            translate([0, $R, 0]) rotate([0, 0, adeg(s0) - 90]) rotate_extrude(angle = adeg(s1 - s0))
                translate([$R, 0]) mirror([1, 0]) children();
        else translate([s0, 0, 0]) rotate([90, 0, 90]) linear_extrude(s1 - s0) children();
    }
}
// Endlage eines Elements (für die Kette)
function end_pose(Ls) = $kurve ? let(a = adeg(Ls)) [$R * sin(a), $sgn * ($R - $R * cos(a)), $sgn * a] : [Ls, 0, 0];

// =====================================================================
//  Verbindungen
// =====================================================================
g_e0 = max(sc(20), 0.4);                     // Fuge zwischen zwei Elementen
// T-Lock
tl_wh = min(top_w * 0.62, top_w - 2 * min_wand - 2 * spiel); tl_wn = tl_wh * 0.58; tl_d = max(sc(90), 1.2);
tlock_ok = tl_wn >= 1.2;
// Gelenk
gj_rd = max(sc(110), 1.6);
gj_wn = max(sc(60), 1.2);
gj_t  = max(sc(60), 1.2);
gj_a  = gj_rd + max(sc(70), 1.0);            // Scheibenmitte ab Stirnfläche
gelenk_ok = 2 * (gj_rd + spiel) + 2 * min_wand <= 2 * hw0;
VB = verbindung == "auto" ? (tlock_ok ? "tlock" : "gelenk") :
     verbindung == "tlock" && !tlock_ok ? "gelenk" : verbindung;
g_e = VB == "tlock" ? 0 : g_e0;              // T-Lock: Stirnflächen liegen an
gw  = VB == "gelenk" ? gelenk_winkel : 0;

module tl_2d(sp) polygon([[-1, -tl_wn / 2 - sp], [0, -tl_wn / 2 - sp], [tl_d + sp, -tl_wh / 2 - sp], [tl_d + sp, tl_wh / 2 + sp], [0, tl_wn / 2 + sp], [-1, tl_wn / 2 + sp]]);
module tl_male() linear_extrude(H) intersection() { tl_2d(0); translate([0, -50]) square([100, 100]); }    // zeigt nach +x
module tl_female() translate([0, 0, -1]) linear_extrude(H + 2) tl_2d(spiel);                              // ab Stirnfläche nach +x
module gelenk_tasche() {   // ab Stirnfläche nach +x, von unten
    translate([0, 0, -e]) linear_extrude(gj_t + spiel + e) {
        translate([gj_a, 0]) circle(r = gj_rd + spiel);
        hull() {
            translate([gj_a, 0]) circle(d = gj_wn + 2 * spiel);
            for (sg = [-1, 1]) translate([-1, sg * (gj_wn / 2 + spiel + (gj_a + 1) * tan(gw))]) circle(d = 0.01);
        }
    }
    translate([0, 0, -e]) linear_extrude(0.3 + e) offset(delta = 0.3) translate([gj_a, 0]) circle(r = gj_rd + spiel);   // Elefantenfuß
}
module gelenk_verbinder() {
    linear_extrude(gj_t) {
        for (sx = [-1, 1]) translate([sx * (gj_a + g_e / 2), 0]) circle(r = gj_rd);
        translate([-(gj_a + g_e / 2), -gj_wn / 2]) square([2 * (gj_a + g_e / 2), gj_wn]);
    }
}
module clip_2d() polygon([[-cL / 2, -cw1 / 2], [0, -cw0 / 2], [cL / 2, -cw1 / 2], [cL / 2, cw1 / 2], [0, cw0 / 2], [-cL / 2, cw1 / 2]]);
module clip() linear_extrude(ch) clip_2d();
module clip_tasche() {     // halber Schwalbenschwanz ab Stirnfläche nach +x
    w0 = cw0 / 2 + spiel; w1 = cw1 / 2 + spiel; l = cL / 2 + spiel;
    pts = [[-1, -w0], [0, -w0], [l, -w1], [l, w1], [0, w0], [-1, w0]];
    translate([0, 0, -e]) linear_extrude(ch + spiel + e) polygon(pts);
    translate([0, 0, -e]) linear_extrude(0.3 + e) offset(delta = 0.3) polygon(pts);
}
clip_ok = cw1 + 2 * (spiel + min_wand) <= 2 * hw0 && ch + spiel + 0.8 < H;

// Taschen/Zapfen an einem Ende (at(sv) zeigt mit +x ins Element bei Anfang, rotiert bei Ende)
module ende_minus(sv, anfang) {
    at(sv) rotate([0, 0, anfang ? 0 : 180]) {
        if (VB == "gelenk") gelenk_tasche();
        if (VB == "clip")   clip_tasche();
        if (VB == "tlock" && anfang) tl_female();
        // Knickfreiheit (Gelenk): Stirnfläche nach außen keilförmig zurücksetzen
        if (gw > 0) for (sg = [-1, 1]) translate([0, 0, -1]) linear_extrude(H + 2)
            polygon([[-1, 0], [0, 0], [(hw0 + 2) * tan(gw / 2 + 1), sg * (hw0 + 2)], [-1, sg * (hw0 + 2)]]);
        // Kantenfase
        fs = max(sc(20), 0.3);
        for (sg = [-1, 1]) translate([0, 0, -1]) linear_extrude(H + 2) polygon([[-1, sg * (hw0 + 1)], [fs + 1, sg * (hw0 + 1)], [-1, sg * (hw0 - fs - 1)]]);
    }
}
module ende_plus(sv, anfang) { if (VB == "tlock" && !anfang) at(sv) tl_male(); }

// =====================================================================
//  Element
// =====================================================================
sl_w = max(sc(600), 2.5); sl_h = max(sc(100), 0.8);       // Staplertaschen
an_l = max(sc(250), 1.2); an_w = min(top_w * 0.45, max(sc(90), 0.8)); an_d = max(sc(40), 0.4);
rf_w = max(sc(100), 0.8); rf_h = max(sc(60), 0.6); rf_t = max(sc(10), 0.3);

module streifen_body(Ls, g) {
    if (farbmuster == "streifen") {
        n = 2 * max(1, round(Ls / (2 * sc(streifen_m * 1000, 4))));
        st = Ls / n;
        for (i = [0 : n - 1]) if ((g == "A" && i % 2 == 0) || (g == "B" && i % 2 == 1)) path_extrude(i * st, (i + 1) * st) profil_2d();
    } else if (g == "A") path_extrude(0, Ls) profil_2d();
}
module reflektoren_body(Ls) {
    a = PH[len(PH) - 2]; b = PH[len(PH) - 1];
    zc = a[1] + 0.6 * (b[1] - a[1]); uc = hw_at(zc);
    tilt = atan2(a[0] - b[0], b[1] - a[1]);
    for (q = [0.25, 0.75], sg = [-1, 1]) at(q * Ls, sg * uc) rotate([sg * tilt, 0, 0])
        translate([-rf_w / 2, sg > 0 ? -e : -rf_t, -rf_h / 2]) cube([rf_w, rf_t + e, rf_h]);
}
// rampe: 0 = keine, 1 = fällt zum Ende ab, -1 = steigt vom Anfang an
module element_roh(Ls, fp, rampe = 0, con0 = true, con1 = true) {
    difference() {
        union() {
            if (inc(fp, "A")) streifen_body(Ls, "A");
            if (inc(fp, "B")) streifen_body(Ls, "B");
            if (inc(fp, "B") && reflektoren && rampe == 0) reflektoren_body(Ls);
            if (inc(fp, "A")) { if (con0) ende_plus(0, true); if (con1) ende_plus(Ls, false); }
        }
        if (con0) ende_minus(0, true);
        if (con1) ende_minus(Ls, false);
        if (staplertaschen && Ls > 3 * sl_w) for (q = [0.25, 0.75]) at(q * Ls) rotate([90, 0, 0])
            linear_extrude(2 * hw0 + 4, center = true)
                polygon([[-sl_w / 2, -1], [sl_w / 2, -1], [sl_w / 2, sl_h], [0, sl_h + sl_w / 2], [-sl_w / 2, sl_h]]);
        if (hebeanker && rampe == 0) for (q = [0.25, 0.75]) at(q * Ls) translate([-an_l / 2, -an_w / 2, H - an_d]) cube([an_l, an_w, an_d + 1]);
        // Rampe der Endstücke (stützfrei: Oberseite fällt schräg ab)
        if (rampe != 0) {
            hmin = max(H * 0.25, 1.5);
            translate([0, 0, 0]) rotate([90, 0, 0]) linear_extrude(4 * hw0 + 10, center = true)
                polygon(rampe > 0 ? [[Ls * 0.2, H + 1], [Ls + 2, hmin], [Ls + 2, H + 5], [Ls * 0.2, H + 5]]
                                  : [[-2, hmin], [Ls * 0.8, H + 1], [Ls * 0.8, H + 5], [-2, H + 5]]);
        }
    }
}

// ---------------------------------------------------------------------
//  Teilung zu langer Elemente (gerade: Länge; Bogen: Sehne/Pfeil)
// ---------------------------------------------------------------------
function fits(Ls) = $kurve
    ? let(a = adeg(Ls), Ri = $R - hw0, Ro = $R + hw0) a <= 180 && 2 * Ro * sin(a / 2) <= usable && Ro - Ri * cos(a / 2) <= usable
    : Ls + 2 * tl_d <= usable && 2 * hw0 <= usable;
function seg_n(n = 1) = (fits(L / n) || n > 40) ? n : seg_n(n + 1);
NS = seg_n();
LSEG = L / NS;
// Teilstück k (0..NS-1) des Elements, mit Clip-Taschen an inneren Nähten
module element_teil(k, fp, rampe = 0) {
    s0 = k * LSEG; s1 = (k + 1) * LSEG;
    difference() {
        intersection() {
            element_roh(L, fp, rampe);
            path_extrude(k == 0 ? -50 : s0 + gap, k == NS - 1 ? L + 50 : s1 - gap) translate([-500, -1]) square([$kurve ? min(1000, 500 + $R - 0.1) : 1000, 1000]);
        }
        if (k > 0)      at(s0) clip_tasche();
        if (k < NS - 1) at(s1) rotate([0, 0, 180]) clip_tasche();
    }
}
// Druckausrichtung eines Teilstücks
module druck_pose(k) {
    s0 = k * LSEG;
    if ($kurve) {
        a0 = adeg(s0); a = adeg(LSEG);
        mirror([0, $sgn < 0 ? 1 : 0, 0]) rotate([0, 0, 90 - a / 2 - a0]) translate([0, -$R, 0])
            mirror([0, $sgn < 0 ? 1 : 0, 0]) children();
    } else translate([-s0 + (k == 0 && VB == "tlock" ? 0 : 0), 0, 0]) children();
}

// =====================================================================
//  Kette (Vorschau)
// =====================================================================
C_BETON = "#cfcac0"; C_B = "#c0392b";
module elem_farbig(rampe = 0, con0 = true, con1 = true) {
    color(C_BETON) element_roh(L, "A", rampe, con0, con1);
    if (farbmuster == "streifen") color(C_B) element_roh(L, "B", rampe, con0, con1);
    else if (reflektoren && rampe == 0) color("#f1c40f") reflektoren_body(L);
}
module verbinder_welt() {
    if (VB == "gelenk") color("#555") gelenk_verbinder();
    if (VB == "clip") color("#555") clip();
}
// Fuge ab Stirnfläche: children(0) = Verbinder (Mitte der Fuge), children(1) = nächstes Element.
// Gelenk: echte Kinematik mit zwei Drehpunkten (Scheibenmitten), je k/2.
module fuge(k) {
    if (VB == "gelenk") translate([-gj_a, 0, 0]) rotate([0, 0, k / 2]) {
        translate([gj_a + g_e / 2, 0, 0]) children(0);
        translate([2 * gj_a + g_e, 0, 0]) rotate([0, 0, k / 2]) translate([-gj_a, 0, 0]) children(1);
    } else {
        translate([g_e / 2, 0, 0]) children(0);
        translate([g_e, 0, 0]) children(1);
    }
}
// Glied i: Element bzw. Endstück, danach Fuge + Knick
module kette(i, n) {
    typ = vorschau_endstuecke && i == 0 ? "anfang" : vorschau_endstuecke && i == n - 1 ? "ende" : "elem";
    k = VB == "gelenk" ? vorschau_knick : 0;
    if (typ == "anfang") elem_farbig(-1, false, true, $kurve = false);
    else if (typ == "ende") elem_farbig(1, true, false, $kurve = false);
    else elem_farbig(0);
    if (i < n - 1) {
        P = typ == "elem" ? end_pose(L) : [L, 0, 0];
        translate([P[0], P[1], 0]) rotate([0, 0, P[2]]) fuge(k) {
            verbinder_welt();
            kette(i + 1, n);
        }
    }
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
echo(str("Jersey Barrier 1:", den, " | Profil ", profil, " | L × B × H = ", r2(L), " × ", r2(2 * hw0), " × ", r2(H), " mm, Krone ", r2(top_w), " mm"));
echo(str("Verbindung: ", VB, verbindung == "tlock" && VB != "tlock" ? " (T-Lock in diesem Maßstab zu schmal – Gelenk gewählt)" : "",
         VB == "gelenk" ? str(" | Knick bis ±", gelenk_winkel, "° je Fuge") : "",
         $kurve ? str(" | Bogen ", bogen_winkel, "° je Element, Radius ", r2($R), " mm") : ""));
if (NS > 1) echo(str("Element wird in ", NS, " Stücke geteilt (", NS - 1, " Clips je Element)"));
if (VB == "gelenk" && !gelenk_ok) echo("WARNUNG: Gelenk-Verbinder passt kaum in die Wand – Maßstab prüfen.");
if (VB == "clip" && !clip_ok) echo("WARNUNG: Clip passt kaum in die Wand – Maßstab prüfen.");

if (teil == "kette") {
    n = vorschau_anzahl + (vorschau_endstuecke ? 2 : 0);
    kette(0, n);
}
else if (teil == "element") {
    for (k = [0 : NS - 1]) if (stueck == 0 || stueck == k + 1)
        translate(stueck == 0 ? [0, k * (2 * hw0 + 5), 0] : [0, 0, 0]) druck_pose(k) element_teil(k, farbteil);
}
else if (teil == "endstueck_anfang") element_roh(L, farbteil, -1, false, true, $kurve = false);
else if (teil == "endstueck_ende")   element_roh(L, farbteil, 1, true, false, $kurve = false);
else if (teil == "verbinder") {
    nv = 6;
    if (VB == "gelenk") for (i = [0 : nv - 1]) translate([0, i * (2 * gj_rd + 3), 0]) gelenk_verbinder();
    else for (i = [0 : nv + 2 * (NS - 1) - 1]) translate([(i % 4) * (cL + 3), floor(i / 4) * (cw1 + 3), 0]) clip();
}
