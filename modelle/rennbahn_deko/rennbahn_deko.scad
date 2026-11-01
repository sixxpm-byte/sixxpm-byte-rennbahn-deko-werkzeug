// =====================================================================
//  RENNBAHN-DEKO  –  parametrische Bibliothek für den 3D-Druck
//  Maßstäbe 1:10 bis 1:87, einheitliches Stecksystem, Auto-Teilung
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  STECKSYSTEM
//    Alle Streckenteile haben an beiden Enden dieselbe Tasche auf der
//    Unterseite (Mittellinie des Sockels). Verbunden wird mit einem
//    separaten Schwalbenschwanz-Clip ("Verbinder"). Das System ist
//    geschlechtsneutral: jedes Ende passt an jedes Ende, Kurven an
//    Geraden, Leitplanke an Reifenstapel an Betonwand.
//    Die Clipgröße hängt nur vom Maßstab ab -> innerhalb eines Maßstabs
//    passt alles zusammen.
//
//  AUTO-TEILUNG
//    Ist ein Teil länger als das Druckbett, wird es automatisch in
//    gleich lange Segmente geteilt. Exportiert wird EIN Segment, die
//    Konsole sagt, wie oft es zu drucken ist.
//
//  MEHRFARBDRUCK
//    farbteil = A / B / sockel exportiert die Farbbereiche einzeln
//    (gleiche Koordinaten) – im Slicer als ein Objekt mit mehreren
//    Teilen laden (AMS/MMU). "alle" = einfarbiges Teil.
//
//  DRUCK
//    Alle Teile werden so exportiert, wie sie gedruckt werden
//    (Sockel unten). Clips flach drucken. Magnete optional (Kleber).
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
// nur bei "eigener Maßstab"
eigener_massstab = 50;

/* [Produkt] */
produkt = "leitplanke"; // [leitplanke:Leitplanke, reifenstapel:Reifenstapel, betonwand:Betonleitwand, curb:Curb, pylone:Pylonen, verbinder:Verbinder-Clips, schaufenster:Schaufenster-Szene]
form = "gerade"; // [gerade:Gerade, kurve:Kurve]
// Gesamtlänge Gerade in Modell-mm (0 = 12 m Vorbild)
laenge_mm = 0;
// Kurvenradius der Mittellinie in Modell-mm (0 = 10 m Vorbild)
radius_mm = 0;
// Kurvenwinkel
winkel = 90; // [5:180]
// Fahrbahnseite (links = Kurveninnenseite)
zur_strecke = "links"; // [links, rechts]
ansicht = "druck"; // [druck:Druckteil (1 Segment), aufbau:Aufbau gesamt]
farbteil = "alle"; // [alle:Alles einfarbig, A:Farbe A, B:Farbe B, sockel:Sockel]

/* [Leitplanke] */
// Anzahl übereinander liegender Planken
planken = 2; // [1:3]
// Pfostenabstand Vorbild (m)
pfostenabstand_m = 2.0;

/* [Reifenstapel] */
reifen_hoch = 4;  // [1:8]
reifen_reihen = 1; // [1:3]
// Farbmuster (A/B)
reifen_muster = "ringe"; // [einfarbig, ringe:abwechselnd je Lage, stapel:abwechselnd je Stapel]
// Förderband-Verkleidung zur Fahrbahn
foerderband = false;

/* [Betonleitwand] */
// Elementlänge Vorbild (m)
element_m = 3.0;
beton_muster = "abwechselnd"; // [einfarbig, abwechselnd:rot-weiß je Element]
details = true;

/* [Curb] */
curb_breite_m = 1.0;
curb_streifen_m = 1.0;
// mit Verbinder-Tasche (sonst flach, zum Aufkleben)
curb_verbinder = true;

/* [Pylonen & Clips] */
pylonen_anzahl = 12;
verbinder_anzahl = 10;

/* [Druck & Passung] */
// Druckbett-Kante (mm)
druckbett = 200;
// Randabstand auf dem Bett (mm)
rand = 5;
min_wand = 1.2;
// Spiel der Verbinder (mm), bei strammem Sitz erhöhen
spiel = 0.15;
magnete = false;
magnet_d = 6;
magnet_h = 2;

// =====================================================================
//  Grundlagen
// =====================================================================
$fa = 2; $fs = 0.3;
e   = 0.01;
den = massstab == 0 ? eigener_massstab : massstab;
s   = 1 / den;
function sc(mm, mn = 0) = max(mm * s, mn);
function r2(x) = round(x * 100) / 100;
usable = druckbett - 2 * rand;
gap = 0.1;                       // Luft je Stoßfläche

// Verbinder-Klassen: [Länge, Taille, Breite, Höhe]
function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] :
    d <= 20 ? [16, 6, 10, 3.2] :
    d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] :
    d <= 50 ? [10, 4, 7, 2] :
              [8, 3.2, 5.6, 1.6];
CT  = conn_tab(den);
cL  = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];
deck = 0.8;                      // Material über der Tasche
base_h = max(ch + spiel + deck, magnete ? magnet_h + 0.2 + deck : 0);
sockel_min = cw1 + 2 * (spiel + min_wand);

// Pfad-Kontext (dynamisch, damit die Szene Gerade und Kurve mischen kann)
$kurve = form == "kurve";
$R  = radius_mm > 0 ? radius_mm : sc(10000);
$sd = zur_strecke == "links" ? 1 : -1;

function adeg(sv) = sv / $R * 180 / PI;
function inc(fp, g) = fp == "alle" || fp == g;
function units(Ls, U) = max(1, round(Ls / U));

// Platzieren an Bogenlänge sv, seitlich u (lokal: x = Fahrtrichtung, y = links)
module at(sv, u = 0) {
    if ($kurve) rotate([0, 0, adeg(sv)]) translate([$R - u, 0, 0]) rotate([0, 0, 90]) children();
    else translate([sv, u, 0]) children();
}
// 2D-Profil (u, z) entlang des Pfades von s0 bis s1 extrudieren
module path_extrude(s0, s1) {
    if (s1 > s0) {
        if ($kurve)
            rotate([0, 0, adeg(s0)]) rotate_extrude(angle = adeg(s1 - s0))
                translate([$R, 0]) mirror([1, 0]) children();
        else
            translate([s0, 0, 0]) rotate([90, 0, 90]) linear_extrude(s1 - s0) children();
    }
}
module side2() { if ($sd < 0) mirror([1, 0]) children(); else children(); }
module side3() { if ($sd < 0) mirror([0, 1, 0]) children(); else children(); }
module place_seg(s0) {
    if ($kurve) rotate([0, 0, adeg(s0)]) children(); else translate([s0, 0, 0]) children();
}

// Passt ein Segment der Länge Ls (Halbbreite hw) aufs Bett?
function fits(Ls, hw) = $kurve
    ? let(a = adeg(Ls), Ri = $R - hw, Ro = $R + hw)
      a <= 180 && 2 * Ro * sin(a / 2) <= usable && Ro - Ri * cos(a / 2) <= usable
    : Ls <= usable && 2 * hw <= usable;
function seg_n(L, hw, n = 1) = (fits(L / n, hw) || n > 60) ? n : seg_n(L, hw, n + 1);

// =====================================================================
//  Stecksystem
// =====================================================================
module slot_2d() {
    w0 = cw0 / 2 + spiel; w1 = cw1 / 2 + spiel; l = cL / 2 + spiel;
    polygon([[-1, -w0], [0, -w0], [l, -w1], [l, w1], [0, w0], [-1, w0]]);
}
module slot() {
    translate([0, 0, -e]) linear_extrude(ch + spiel + e) slot_2d();
    translate([0, 0, -e]) linear_extrude(0.3 + e) offset(delta = 0.3) slot_2d(); // Elefantenfuß
}
module clip() {
    linear_extrude(ch) polygon([[-cL / 2, -cw1 / 2], [0, -cw0 / 2], [cL / 2, -cw1 / 2],
                                [cL / 2, cw1 / 2], [0, cw0 / 2], [-cL / 2, cw1 / 2]]);
}
module conn_pockets(Ls, u = 0) { at(0, u) slot(); at(Ls, u) rotate([0, 0, 180]) slot(); }
module magnet_pockets(Ls, u = 0) {
    if (magnete) {
        k = max(1, floor(Ls / 60));
        keep = cL / 2 + spiel + 0.8 + magnet_d / 2;
        for (i = [0 : k - 1]) {
            sm = (i + 0.5) * Ls / k;
            if (sm >= keep && Ls - sm >= keep)
                at(sm, u) translate([0, 0, -e]) cylinder(d = magnet_d + 0.2, h = magnet_h + 0.2 + e, $fn = 32);
        }
    }
}
module sockel_2d(w) {
    f = min(0.4, base_h / 4);
    polygon([[-w / 2, 0], [w / 2, 0], [w / 2, base_h - f], [w / 2 - f, base_h],
             [-w / 2 + f, base_h], [-w / 2, base_h - f]]);
}
module seg_volume(Ls) {
    umax = $kurve ? min(500, $R - 0.05) : 500;
    path_extrude(gap, Ls - gap) translate([-500, -1]) square([500 + umax, 1000]);
}
// Segment beschneiden, Taschen und Magnetlöcher einbringen
module seg_wrap(Ls, uc = 0, conn = true) {
    difference() {
        intersection() { children(); seg_volume(Ls); }
        if (conn) { conn_pockets(Ls, uc); magnet_pockets(Ls, uc); }
    }
}

// =====================================================================
//  LEITPLANKE (Schutzplanke, A-Profil)
// =====================================================================
gr_H     = sc(310, 2.4);
gr_D     = sc(83, 0.8);
gr_t     = sc(4, 0.8);
gr_z0    = base_h + sc(450, 1.5);
gr_pitch = gr_H * 0.96;
gr_top   = gr_z0 + gr_pitch * (planken - 1) + gr_H;
post_s   = sc(80, 1.2);
post_u   = sc(110, 1.4);
gr_ub    = post_u / 2 + sc(150, 0.6);
gr_front = gr_ub + gr_D + gr_t / 2;
gr_sw    = sockel_min;
gr_hw    = max(gr_sw / 2, gr_front);
gr_bh    = sc(200, 1.5);

W_PTS = [[0.25, 0], [0.45, 0], [1, 0.17], [1, 0.33], [0.08, 0.47], [0.08, 0.53],
         [1, 0.67], [1, 0.83], [0.45, 1], [0.25, 1]];

module w_profile(z0) {
    p = [for (q = W_PTS) [gr_ub + q[0] * gr_D, z0 + q[1] * gr_H]];
    for (i = [0 : len(p) - 2])
        hull() { translate(p[i]) circle(d = gr_t, $fn = 10); translate(p[i + 1]) circle(d = gr_t, $fn = 10); }
}

module leitplanke_body(Ls) {
    n = units(Ls, sc(pfostenabstand_m * 1000));
    sp = Ls / n;
    bo_end = gr_ub + 0.08 * gr_D;
    bo_len = bo_end - post_u / 2;
    for (i = [0 : n - 1]) at((i + 0.5) * sp) {
        translate([-post_s / 2, -post_u / 2, base_h - e])
            cube([post_s, post_u, gr_top - sc(40) - base_h + e]);
        side3() for (k = [0 : planken - 1]) {
            zc = gr_z0 + k * gr_pitch + gr_H / 2;
            // Distanzstück mit 45°-Unterseite (stützfrei druckbar)
            hull() {
                translate([-post_s / 2, post_u / 2 - e, zc - gr_bh / 2]) cube([post_s, bo_len + e, gr_bh]);
                translate([-post_s / 2, post_u / 2 - e, zc - gr_bh / 2 - bo_len]) cube([post_s, e, gr_bh]);
            }
        }
    }
    path_extrude(0, Ls) side2() for (k = [0 : planken - 1]) w_profile(gr_z0 + k * gr_pitch);
}

module leitplanke_seg(Ls, fp) {
    seg_wrap(Ls) union() {
        if (inc(fp, "sockel")) path_extrude(0, Ls) sockel_2d(gr_sw);
        if (inc(fp, "A")) leitplanke_body(Ls);
    }
}

// =====================================================================
//  REIFENSTAPEL
// =====================================================================
t_OD   = sc(620, 4);
t_W    = sc(200, 1.0);
t_ID   = min(sc(380), t_OD - 2 * min_wand);
t_ru   = t_OD * 0.97;                         // Reihenabstand
t_span = (reifen_reihen - 1) * t_ru + t_OD;
t_band = sc(15, 0.8);
t_sw   = max(sockel_min, t_span);
t_hw   = t_span / 2 + (foerderband ? t_band + 0.2 : 0) + t_OD * 0.02;

module tire(D) {
    w = (D - t_ID) / 2;
    r = min(t_W, w) * 0.35;
    rotate_extrude($fn = 36) translate([t_ID / 2 + r, r])
        offset(r = r, $fn = 12) square([w - 2 * r, t_W - 2 * r]);
}

module reifen_body(Ls, g) {
    n = units(Ls, t_OD);
    p = Ls / n;
    D = max(t_OD, p) * 1.03;
    for (i = [0 : n - 1], j = [0 : reifen_reihen - 1], k = [0 : reifen_hoch - 1]) {
        c = reifen_muster == "ringe" ? k % 2 : reifen_muster == "stapel" ? (i + j) % 2 : 0;
        if ((g == "A" && c == 0) || (g == "B" && c == 1))
            at((i + 0.5) * p, (j - (reifen_reihen - 1) / 2) * t_ru)
                translate([0, 0, base_h - e + k * t_W * 0.96]) tire(D);
    }
    if (foerderband && g == "A") {
        u0 = (reifen_reihen - 1) / 2 * t_ru + D / 2 - 0.15;
        path_extrude(0, Ls) side2() translate([u0, base_h - e])
            square([t_band, (reifen_hoch - 1) * t_W * 0.96 + t_W]);
    }
}

module reifen_seg(Ls, fp) {
    seg_wrap(Ls) union() {
        if (inc(fp, "sockel")) path_extrude(0, Ls) sockel_2d(t_sw);
        if (inc(fp, "A")) reifen_body(Ls, "A");
        if (inc(fp, "B")) reifen_body(Ls, "B");
    }
}

// =====================================================================
//  BETONLEITWAND (New-Jersey-Profil)
// =====================================================================
j_hb = sc(305, 2.0); j_z1 = sc(75, 0.3);
j_h2 = sc(126, 1.2); j_z2 = sc(330, 1.5);
j_h3 = sc(75, 0.8);  j_z3 = sc(813, 5.0);
j_sw = max(sockel_min, 2 * j_hb + 2 * sc(40, 0.4));
j_hw = j_sw / 2;

module jersey_2d() {
    polygon([[-j_hb, 0], [j_hb, 0], [j_hb, j_z1], [j_h2, j_z2], [j_h3, j_z3],
             [-j_h3, j_z3], [-j_h2, j_z2], [-j_hb, j_z1]]);
}

module beton_body(Ls, g) {
    n  = units(Ls, sc(element_m * 1000));
    el = Ls / n;
    gw = sc(25, 0.4); gd = sc(25, 0.3);
    difference() {
        union() for (i = [0 : n - 1]) {
            c = beton_muster == "abwechselnd" ? i % 2 : 0;
            if ((g == "A" && c == 0) || (g == "B" && c == 1))
                path_extrude(i * el, (i + 1) * el) translate([0, base_h - e]) jersey_2d();
        }
        // Fugen zwischen den Elementen (an den Segmentenden halbe Fuge)
        for (i = [0 : n])
            path_extrude(i * el - gw / 2, i * el + gw / 2) translate([0, base_h]) difference() {
                offset(delta = 0.01) jersey_2d();
                offset(delta = -gd) jersey_2d();
                translate([-j_hb, -1]) square([2 * j_hb, gd + 1.01]);
            }
        // Ablauf-/Staplerschlitz unten
        if (details)
            for (i = [0 : n - 1]) at((i + 0.5) * el)
                translate([-sc(300, 1.2) / 2, -j_hb - 1, base_h - e])
                    cube([sc(300, 1.2), 2 * j_hb + 2, sc(100, 0.6) + e]);
    }
}

module beton_seg(Ls, fp) {
    seg_wrap(Ls) union() {
        if (inc(fp, "sockel")) path_extrude(0, Ls) sockel_2d(j_sw);
        if (inc(fp, "A")) beton_body(Ls, "A");
        if (inc(fp, "B")) beton_body(Ls, "B");
    }
}

// =====================================================================
//  CURB (Randstein, rot-weiß)
// =====================================================================
cb_h  = curb_verbinder ? base_h : sc(80, 1.0);
cb_W  = max(sc(curb_breite_m * 1000), curb_verbinder ? sockel_min / 0.55 : 4);
cb_uc = -0.2 * cb_W;                          // Taschenposition (flacher Teil)

module curb_2d() {
    f  = min(0.3, cb_h / 4);
    lo = min(0.4, cb_h / 3);
    polygon([[-cb_W / 2, 0], [cb_W / 2, 0], [cb_W / 2, lo], [cb_W / 2 - 0.4 * cb_W, cb_h],
             [-cb_W / 2 + f, cb_h], [-cb_W / 2, cb_h - f]]);
}

module curb_body(Ls, g) {
    n  = 2 * units(Ls, 2 * sc(curb_streifen_m * 1000));
    st = Ls / n;
    for (i = [0 : n - 1])
        if ((g == "A" && i % 2 == 0) || (g == "B" && i % 2 == 1))
            path_extrude(i * st, (i + 1) * st) side2() curb_2d();
}

module curb_seg(Ls, fp) {
    seg_wrap(Ls, cb_uc * $sd, curb_verbinder) union() {
        if (inc(fp, "A")) curb_body(Ls, "A");
        if (inc(fp, "B")) curb_body(Ls, "B");
    }
}

// =====================================================================
//  PYLONE (Leitkegel 500 mm)
// =====================================================================
p_H  = sc(500, 6);
p_ba = sc(380, 4);
p_bt = sc(30, 0.6);
p_rb = sc(140, 1.5);
p_rt = sc(20, 0.4);
p_mag = magnete && magnet_d + 1.2 <= 2 * p_rb;

module pylone_body() {
    linear_extrude(p_bt) offset(r = p_ba * 0.12) square(p_ba * 0.76, center = true);
    cylinder(h = p_H - p_rt, r1 = p_rb, r2 = p_rt);
    translate([0, 0, p_H - p_rt]) sphere(r = p_rt);
}
module pylone_baender() {
    for (b = [[0.30, 0.42], [0.55, 0.65]])
        translate([0, 0, b[0] * p_H]) cylinder(h = (b[1] - b[0]) * p_H, r = p_ba);
}
module pylone(fp) {
    difference() {
        union() {
            if (fp == "alle") pylone_body();
            if (fp == "A") difference() { pylone_body(); pylone_baender(); }
            if (fp == "B") intersection() { pylone_body(); pylone_baender(); }
        }
        if (p_mag) translate([0, 0, -e]) cylinder(d = magnet_d + 0.2, h = magnet_h + 0.2 + e, $fn = 32);
    }
}
module pylone_vorschau() {
    color(col("pylone", "A")) pylone_body();
    color(col("pylone", "B")) intersection() { scale([1.03, 1.03, 1]) pylone_body(); pylone_baender(); }
}
module pylonen_platte(fp) {
    nx = ceil(sqrt(pylonen_anzahl));
    d  = p_ba + 3;
    for (i = [0 : pylonen_anzahl - 1])
        translate([(i % nx) * d, floor(i / nx) * d, 0]) pylone(fp);
}

module verbinder_platte() {
    nx = ceil(sqrt(verbinder_anzahl));
    for (i = [0 : verbinder_anzahl - 1])
        translate([(i % nx) * (cL + 3), floor(i / nx) * (cw1 + 3), 0]) clip();
}

// =====================================================================
//  Dispatcher, Farben, Ansichten
// =====================================================================
function hw_of(p) = p == "leitplanke" ? gr_hw : p == "reifenstapel" ? t_hw :
                    p == "betonwand" ? j_hw : p == "curb" ? cb_W / 2 : 10;
function col(p, fp) =
    fp == "sockel" ? "#5f6368" :
    p == "leitplanke"   ? "#c9ced3" :
    p == "reifenstapel" ? (fp == "A" ? "#262626" : "#e9e9e9") :
    p == "betonwand"    ? (fp == "A" ? "#ebe8e1" : "#c0392b") :
    p == "curb"         ? (fp == "A" ? "#c0392b" : "#f2f2f2") :
    p == "pylone"       ? (fp == "A" ? "#ff6a13" : "#f5f5f5") : "#8a8a8a";

module seg(p, Ls, fp) {
    if      (p == "leitplanke")   leitplanke_seg(Ls, fp);
    else if (p == "reifenstapel") reifen_seg(Ls, fp);
    else if (p == "betonwand")    beton_seg(Ls, fp);
    else if (p == "curb")         curb_seg(Ls, fp);
}
module seg_color(p, Ls) {
    for (fp = ["sockel", "A", "B"]) color(col(p, fp)) seg(p, Ls, fp);
}
// Komplette Strecke aus n Segmenten
module strecke(p, L, n = 0) {
    N  = n > 0 ? n : seg_n(L, hw_of(p));
    Ls = L / N;
    for (i = [0 : N - 1]) place_seg(i * Ls) seg_color(p, Ls);
}
module print_pose(Ls, hw) {
    if ($kurve) {
        a = adeg(Ls);
        translate([0, -($R - hw) * cos(a / 2), 0]) rotate([0, 0, 90 - a / 2]) children();
    } else children();
}

// ---------------------------------------------------------------------
//  Schaufenster: alle Produkte zusammen (für Produktbilder)
// ---------------------------------------------------------------------
module schaufenster() {
    L  = sc(12000);
    Rk = sc(9000);
    Lt = sc(4400);
    // Reifenwand  ->  Leitplanke gerade  ->  Leitplanke Kurve (per Clip verbunden)
    translate([-Lt, 0, 0]) strecke("reifenstapel", Lt, 1, $kurve = false, $sd = 1);
    strecke("leitplanke", L, 1, $kurve = false, $sd = 1);
    translate([L, Rk, 0]) rotate([0, 0, -90])
        strecke("leitplanke", Rk * PI / 2, 2, $kurve = true, $R = Rk, $sd = 1);
    // Curb an der Fahrbahnkante
    translate([0, sc(1800), 0]) strecke("curb", L, 1, $kurve = false, $sd = 1);
    // Pylonen-Slalom auf der Fahrbahn
    for (i = [0 : 4]) translate([sc(1500) + i * sc(2200), sc(4800) + (i % 2) * sc(1400), 0])
        pylone_vorschau();
    // Betonwand gegenüber
    translate([0, sc(9500), 0]) strecke("betonwand", L, 1, $kurve = false, $sd = -1);
    // Clips als Beigabe
    translate([-Lt, sc(5000), 0]) for (i = [0 : 2]) translate([i * (cL + 3), 0, 0]) color("#444") clip();
}

// =====================================================================
//  Ausgabe
// =====================================================================
is_strecke = produkt == "leitplanke" || produkt == "reifenstapel" ||
             produkt == "betonwand" || produkt == "curb";
TOTAL = $kurve ? $R * winkel * PI / 180 : (laenge_mm > 0 ? laenge_mm : sc(12000));
HW = hw_of(produkt);
N  = seg_n(TOTAL, HW);
LS = TOTAL / N;

echo(str("Maßstab 1:", den, " | Sockelhöhe ", r2(base_h), " mm | Verbinder L×B×H ",
         cL, "×", cw1, "×", ch, " mm"));
if (is_strecke) {
    echo(str(produkt, " ", form, ": ", N, " Segment(e) à ", r2(LS), " mm",
             $kurve ? str(" / ", r2(adeg(LS)), "°") : "", "  ->  ", N, "x drucken, ",
             max(0, N - 1), " Verbinder für die Stöße"));
    if ($kurve && $R <= HW + 1) echo("FEHLER: Radius zu klein für dieses Produkt!");
    if (!fits(LS, HW)) echo("WARNUNG: Segment passt nicht aufs Druckbett – Radius/Bett prüfen.");
}
if (produkt == "pylone" && magnete && !p_mag)
    echo("Hinweis: Pylone in diesem Maßstab zu schmal für den Magneten – ohne Magnet erzeugt.");

if (produkt == "schaufenster") schaufenster();
else if (produkt == "verbinder") verbinder_platte();
else if (produkt == "pylone") {
    if (ansicht == "aufbau") {
        nx = ceil(sqrt(pylonen_anzahl));
        for (i = [0 : pylonen_anzahl - 1])
            translate([(i % nx) * (p_ba + 3), floor(i / nx) * (p_ba + 3), 0]) pylone_vorschau();
    }
    else pylonen_platte(farbteil);
}
else if (is_strecke) {
    if (ansicht == "aufbau") strecke(produkt, TOTAL, N);
    else print_pose(LS, HW) seg(produkt, LS, farbteil);
}
