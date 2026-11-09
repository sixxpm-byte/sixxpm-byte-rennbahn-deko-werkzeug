// =====================================================================
//  BOXENMAUER MIT KOMMANDOSTAND  –  Mauer zwischen Boxengasse und Strecke
//  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei), Farben je Bauteil,
//  Maßstab 1:43 / 1:87.  Mauerelemente beliebig verlängerbar (Clips wie im Rennbahn-Deko-Set).
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    mauer           Mauerelement mit Werbefläche, Clip-Taschen an beiden Enden  je Element 1x
//    zaunfeld        Fangzaun mit Pfosten, Rautengeflecht und zur Strecke abgeknicktem
//                    Oberteil (liegend gedruckt, Knickteil steigt 50° auf)      je Element 1x
//    podest          Podest des Kommandostands (kopfüber, hohl mit Rippen)      1x
//    treppe          Treppe zum Podest (flach gedruckt)                         1x
//    pult            Pult mit Tischplatte (liegt auf der Frontplatte)            1x
//    monitore        Monitorleiste: Rahmen (A) + Bildschirme (B)                 1x
//    hocker          Hockerreihe auf einer Schiene (in die Nut im Podest)        1x
//    seitenwand      Seitenwand mit Fenster, trägt das Dach (flach): Wand (A) +
//                    Glasscheibe (B, in den Falz gedrückt)                      2x
//    gelaender       Geländer hinten (flach)                                    1x
//    dach            Dach mit Blende (kopfüber)                                 1x
//    banner          Teamschild auf dem Dach: Tafel (A) + Schrift (B)           1x
//    verbinder       Clips für die Mauerelemente
//
//  STECKSYSTEM
//    Mauerelemente: an beiden Enden dieselbe Schwalbenschwanz-Tasche unten, Clip von unten
//    – passt auch zu den Clips des Rennbahn-Deko-Sets.  Zaun, Pult, Rahmen, Geländer,
//    Treppe, Banner: Zungen in Schlitze; Hocker: Schiene in Nut.  Kein Kleber.
//  FARBTEILE
//    Alle Farbbauteile werden gesteckt.  Farbzonen (AMS/MMU, einfarbig weglassen):
//    Werbefläche der Mauer, Bildschirme, Schrift auf dem Banner.  Die Glasscheiben
//    der Seitenwände sind Steckteile.
//  DRUCK
//    Alles stützfrei: Mauer aufrecht, Podest und Dach kopfüber, Zaun, Seitenwände,
//    Geländer, Treppe, Pult, Monitore und Banner flach liegend, Hockerreihe stehend.
//  MONTAGE (Kurzfassung)
//    1. Mauerelemente mit Clips verbinden, Zaunfelder in die Mauerkrone stecken.
//    2. Podest mit 2 Clips an den Mauerfuß stecken; Pult, Hockerreihe, Seitenwände, Geländer und
//       Treppe einstecken, Monitore aufs Pult.
//    3. Dach auf die Rahmen, Banner aufs Dach.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, mauer:Mauerelement, zaunfeld:Fangzaun, podest:Podest, treppe:Treppe, pult:Pult, monitore:Monitorleiste, hocker:Hockerreihe, seitenwand:Seitenwand mit Glas (2x), gelaender:Geländer hinten, dach:Dach, banner:Teamschild, verbinder:Verbinder-Clips]
stueck = 0;
farbteil = "alle"; // [alle, A, B]

/* [Vorschau] */
// Mauerelemente in Vorschau und Farbliste
elemente = 3; // [1:1:8]

/* [Boxenmauer (Vorbild in Metern)] */
element_m = 6.0;
mauer_hoehe_m = 1.2;
mauer_fuss_m = 0.85;
mauer_krone_m = 0.4;
zaun_hoehe_m = 3.0;
// abgeknicktes Oberteil des Zauns (Länge, Winkel aus der Senkrechten; >= 45 für den Druck)
zaun_krone_m = 1.0;
zaun_knick = 50; // [45:5:60]
// Kommandostand
podest_hoehe_m = 1.0;
stand_tiefe_m = 2.3;
dach_hoehe_m = 3.4;
plaetze = 6; // [2:1:8]
banner_text = "Windgebohrener";
banner_font = "Liberation Sans:style=Bold";

/* [Farben] */
farbe_mauer    = "weiss";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_werbung  = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_zaun     = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_podest   = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_pult     = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_bildschirm = "puderblau"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_hocker   = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_rahmen   = "silber";
farbe_seitenwand = "weiss";  // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_glas     = "puderblau"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_dach     = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_banner   = "weiss";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_schrift  = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]

/* [Druck & Passung] */
rennbahn_taschen = true;   // Clip-Taschen an den Mauerenden
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;
// Luft je Seite für Steckzungen und Einsätze (0 = sehr stramm)
einsatz_spiel = 0.05;

include <../../lib/deko_grundlagen.scad>

// =====================================================================
//  Maße (Welt: x entlang der Mauer, +y zur Strecke, z = 0 Boden; mm)
// =====================================================================
es    = einsatz_spiel;
L     = M(element_m);
// Mauer
H_w   = M(mauer_hoehe_m);
W_b   = max(M(mauer_fuss_m), cw1 + 2 * spiel + 2 * min_wand);
W_k   = max(M(mauer_krone_m), 3.0);
h_fs  = M(0.15);                            // Fußstufe
c_w   = max(M(0.04), 0.4);                  // Fase an der Krone
d_w   = (W_b - W_k) / 2;
Y_mc  = W_b / 2;                            // Mitte
dmr   = max(sc(20), 0.3);
d_wb  = max(M(0.03), 0.6);                  // Tiefe der Werbefläche
WB    = [M(0.3), M(0.2), M(0.95)];          // Rand x, z0, z1
// Zaun
H_f   = M(zaun_hoehe_m);
t_f   = max(M(0.05), 1.2);
b_p   = max(M(0.08), 1.2);
b_r   = max(M(0.05), 1.0);
w_m   = max(M(0.03), 0.45);
p_m   = max(M(0.3), 2.5);
l_tb  = max(M(0.15), 1.8);                  // Zungenlänge
H_k   = M(zaun_krone_m);
phi_k = max(zaun_knick, 45);
// Kommandostand
H_p   = M(podest_hoehe_m);
D_st  = M(stand_tiefe_m);
Y_s1  = -0.1;                               // Vorderkante Podest (am Mauerfuß, mit Clips verbunden)
CLX   = [L / 4, 3 * L / 4];                  // Clips Mauer - Podest
Y_s0  = Y_s1 - D_st;
t_dp  = max(M(0.12), 1.6);
t_sk  = max(M(0.1), 1.6);
H_r   = M(dach_hoehe_m);
t_ro  = max(M(0.12), 1.6);
h_bl  = max(M(0.3), 3.0);                   // Dachblende (auch Höhe der Endrippen)
H_bb  = H_r + t_ro - h_bl;                  // Unterkante Blende/Rippen = Oberkante Rahmen
l_rt  = l_tb * 0.8;
Y_r1  = max(M(0.1), 1.0);                   // Dach-Vorderkante (vor der Mauer-Hinterseite, hinter dem Zaun)
X_ro  = M(0.15);                            // Dachüberstand seitlich
// Pult
h_pu  = M(0.78);
t_pl  = max(M(0.05), 1.2);
d_tt  = M(0.6);
y_pf  = Y_s1 - M(0.15) - t_pl;              // Frontplatte (Rückseite)
X_pu  = [M(0.3), L - M(0.3)];
// Monitore
n_pl  = plaetze;
w_mo  = M(0.55);  h_mo = M(0.36);  h_ms = M(0.12);
t_mo  = max(M(0.05), 1.2);
d_sc  = max(M(0.02), 0.4);
y_mo  = y_pf + t_pl - M(0.22);              // Ebene Monitore (Vorderseite = Schauseite nach -y)
function x_pl(i) = X_pu[0] + (X_pu[1] - X_pu[0]) * (i + 0.5) / n_pl;
// Hocker
y_hk  = y_pf - M(0.95);
w_hr  = max(M(0.12), 1.6);  h_hr = max(M(0.1), 1.2);
r_hs  = max(M(0.2), 1.8);  d_hp = max(M(0.08), 1.2);
h_hs  = M(0.72);  t_hs = max(M(0.05), 0.8);
// Rahmen, Geländer, Treppe
H_g   = M(1.0);
b_g   = max(M(0.05), 0.8);
y_rv  = y_pf - M(0.1);                      // vorderer Rahmenpfosten
y_rh  = Y_s0 + t_f + M(0.05);               // hinterer Rahmenpfosten
t_sw  = max(M(0.08), 1.6);                  // Seitenwand
t_lp  = max(0.5, t_sw * 0.35);  w_lp = max(M(0.04), 0.6);   // Falz: Lippe oben
WF    = [y_rh + b_p / 2 + M(0.08), y_rv - b_p / 2 - M(0.08), H_p + M(0.95), 0];   // Fenster [y0, y1, z0, z1]
w_st  = M(0.9);  n_st = 5;
r_st  = H_p / n_st;  a_st = M(0.27);
X_st  = [L - M(0.35) - w_st, L - M(0.35)];
t_ha  = max(M(0.04), 1.2);                  // Auflage der Treppe auf dem Podest
// Banner
h_bn  = M(0.65);  t_bn = max(M(0.05), 1.2);
X_bn  = [M(0.6), L - M(0.6)];
y_bn  = Y_r1 - M(0.15) - t_bn;
d_tx  = max(M(0.02), 0.4);

include <../../lib/deko_hilfen.scad>

// =====================================================================
//  Hilfen
// =====================================================================
module yz(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0, convexity = 6) children();   // 2D (y,z) entlang x
module xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 6) children();    // 2D (x,z) entlang y
module yz_druck(x1) multmatrix([[0, 1, 0, 0], [0, 0, -1, 0], [-1, 0, 0, x1], [0, 0, 0, 1]]) children();          // Seite x = x1 aufs Bett
module xz_druck(y1) multmatrix([[1, 0, 0, 0], [0, 0, 1, 0], [0, -1, 0, y1], [0, 0, 0, 1]]) children();           // Seite y = y1 aufs Bett
module xz_druck0(y0) multmatrix([[1, 0, 0, 0], [0, 0, -1, 0], [0, 1, 0, -y0], [0, 0, 0, 1]]) children();         // Seite y = y0 aufs Bett
module bunt(f) color(fhex(f)) render(convexity = 6) children();
module schlitz(x0, x1, y0, y1, z1, t) translate([x0 - es, y0 - es, z1 - t]) cube([x1 - x0 + 2 * es, y1 - y0 + 2 * es, t + 1]);
// Geländer-/Rahmenfeld 2D: u entlang, v Höhe ab Boden (0), Pfosten mit Zungen nach unten
function posten(Lg, p = 1.1, w = b_g) = let(n = max(1, round(Lg / M(p)))) [for (i = [0 : n]) w / 2 + i * (Lg - w) / n];
module gelaender_2d(Lg) {
    for (v = [0, H_g / 2 - b_g / 2, H_g - b_g]) translate([0, v]) square([Lg, b_g]);
    for (u = posten(Lg)) translate([u - b_g / 2, -l_tb]) square([b_g, H_g + l_tb]);
}

// =====================================================================
//  Mauer (Welt, Element ab x = 0)
// =====================================================================
module mauer_2d() polygon([[0, 0], [W_b, 0], [W_b, h_fs], [W_b - d_w, H_w - c_w], [W_b - d_w - c_w, H_w], [d_w + c_w, H_w], [d_w, H_w - c_w], [0, h_fs]]);
function ysf(z) = W_b - d_w * (z - h_fs) / (H_w - c_w - h_fs);            // Streckenseite oberhalb der Fußstufe
module werbung_2d() polygon([[ysf(WB[1]) - d_wb, WB[1]], [ysf(WB[1]) + 0.01, WB[1]], [ysf(WB[2]) + 0.01, WB[2]], [ysf(WB[2]) - d_wb, WB[2]]]);
module mauer_welt(fp = "alle") {
    if (inc(fp, "A")) difference() {
        yz(0, L) mauer_2d();
        yz(WB[0], L - WB[0]) werbung_2d();
        // Schlitze für die Zaunpfosten
        for (u = posten(L, 3, b_p)) schlitz(u - b_p / 2, u + b_p / 2, Y_mc - t_f / 2, Y_mc + t_f / 2, H_w, l_tb + 0.3);
        // Clip-Taschen an beiden Enden (unten)
        if (rennbahn_taschen) { translate([0, Y_mc, 0]) rb_slot(); translate([L, Y_mc, 0]) rotate(180) rb_slot(); }
        for (x = CLX) translate([x, 0, 0]) rotate(90) rb_slot();   // Clips zum Kommandostand
    }
    if (inc(fp, "B")) yz(WB[0] + 0.02, L - WB[0] - 0.02) werbung_2d();
}
module mauer_druck(fp) mauer_welt(fp);

// Zaunfeld 2D: u = x, v ab Mauerkrone; Pfosten an den Enden und in der Mitte
// Zaunfeld 2D der Höhe hh: Pfosten, Holme, Rautengeflecht; zg = Zungen unten
module zaun_2d(hh, zg, holme = true, ph = 0) let(P = posten(L, 3, b_p)) {
    for (u = P) translate([u - b_p / 2, zg ? -l_tb : 0]) square([b_p, hh + (zg ? l_tb : 0)]);
    if (holme) for (v = [0, (hh - b_r) / 2, hh - b_r]) translate([0, v]) square([L, b_r]);
    intersection() {
        square([L, hh]);
        for (k = [-ceil(hh / p_m) - 1 : ceil(L / p_m) + 1]) for (sgn = [-1, 1])
            translate([k * p_m + ph + (sgn > 0 ? 0 : hh), 0]) rotate(sgn > 0 ? 45 : 135) translate([0, -w_m / 2]) square([hh * 1.5, w_m]);
    }
}
y_fp = Y_mc - t_f / 2;   // Boxenseite des Zauns (beim Druck unten)
module zaunfeld_welt() {
    translate([0, 0, H_w]) xz(y_fp, y_fp + t_f) zaun_2d(H_f, true);
    // Knickteil: um die streckenseitige Kante oben zur Strecke geneigt
    // Knickteil ohne waagerechte Holme (beim schrägen Druck kein Überhang), oben enden die Rauten in Spitzen
    knick() translate([0, 0, H_w + H_f]) xz(y_fp, y_fp + t_f) zaun_2d(H_k, false, false, (den == 87 ? 0.23 : 0.37) * p_m);   // Phase: vermeidet entartete Kanten im STL
    // Keil am Knick: verbindet oberen Holm und unteren Holm des Knickteils flächig
    // (unten bis unter die Unterkante des Knickteils auf dem Bett, damit beim Druck nichts flacher als 45° überhängt)
    hull() { translate([0, y_fp, H_w + H_f - b_r]) cube([L, t_f, b_r]); knick() translate([0, y_fp, H_w + H_f]) cube([L, t_f, b_r]);
             translate([0, y_fp, H_w + H_f - b_r]) cube([L, 0.01, b_r + t_f * sin(phi_k) + 0.05]); }
}
module knick() translate([0, y_fp + t_f, H_w + H_f]) rotate([-phi_k, 0, 0]) translate([0, -(y_fp + t_f), -(H_w + H_f)]) children();
module zaunfeld_druck() xz_druck0(y_fp) zaunfeld_welt();

// =====================================================================
//  Kommandostand
// =====================================================================
// Podest (Welt) – gedruckt kopfüber, unten offen mit Rippen
module podest_welt() difference() {
    union() {
        translate([0, Y_s0, H_p - t_dp]) cube([L, D_st, t_dp]);
        difference() { translate([0, Y_s0, 0]) cube([L, D_st, H_p]);
                       translate([t_sk, Y_s0 + t_sk, -1]) cube([L - 2 * t_sk, D_st - 2 * t_sk, H_p + 1 - t_dp + 0.01]); }
        // Querrippen und Längsrippe unter der Hocker-Nut
        let(n = max(2, round(L / M(1.2)))) for (i = [1 : n - 1]) translate([i * L / n - t_sk / 2, Y_s0, H_p * 0.35]) cube([t_sk, D_st, H_p * 0.65]);
        translate([0, y_hk - w_hr / 2 - t_sk, H_p * 0.35]) cube([L, w_hr + 2 * t_sk, H_p * 0.65]);
        // Bosse für die Clips zur Mauer (volle Höhe, beim Kopfüber-Druck vom Bett aus)
        for (x = CLX) translate([x - cw1 / 2 - spiel - min_wand, Y_s1 - cL / 2 - spiel - min_wand, 0]) cube([cw1 + 2 * spiel + 2 * min_wand, cL / 2 + spiel + min_wand, H_p]);
        // Sockelleiste (Fuß) als Optik
        difference() { translate([-0.01, Y_s0 - 0.01, 0]) cube([L + 0.02, D_st + 0.02, M(0.12)]); translate([t_sk, Y_s0 + t_sk, -1]) cube([L - 2 * t_sk, D_st - 2 * t_sk, M(0.3)]); }
    }
    // Schlitze: Pult, Rahmen, Geländer, Treppe; Nut für die Hockerschiene
    for (z = [0]) {
        for (u = posten(X_pu[1] - X_pu[0], 1.5)) schlitz(X_pu[0] + u - b_g / 2, X_pu[0] + u + b_g / 2, y_pf, y_pf + t_pl, H_p, l_tb + 0.3);
        for (x0 = [0, L - t_sw], y = [y_rv, y_rh]) schlitz(x0, x0 + t_sw, y - b_p / 2, y + b_p / 2, H_p, l_tb + 0.3);
        for (x = CLX) translate([x, Y_s1, 0]) rotate(-90) rb_slot();
        for (u = posten(X_st[0] - M(0.1) - M(0.25))) schlitz(M(0.25) + u - b_g / 2, M(0.25) + u + b_g / 2, Y_s0, Y_s0 + t_f, H_p, l_tb + 0.3);
        schlitz(X_st[0], X_st[1], Y_s0 + M(0.08), Y_s0 + M(0.08) + t_f, H_p, l_tb + 0.3);
        schlitz(M(0.2), L - M(0.2), y_hk - w_hr / 2, y_hk + w_hr / 2, H_p, h_hr + 0.2);
    }
}
module podest_druck() translate([0, 0, H_p]) rotate([180, 0, 0]) podest_welt();

// Treppe (Ebene y-z, Breite entlang x; Auflage oben mit Zunge ins Podest)
module treppe_2d() {
    ye = Y_s0 - es;                         // Treppe endet mit Luft vor dem Podest
    yb = ye - (n_st - 1) * a_st;            // Fuß der Treppe
    polygon(concat([[yb - 0.01, 0]], [for (k = [1 : n_st - 1]) each [[yb + (k - 1) * a_st, k * r_st], [yb + k * a_st, k * r_st]]],
                   [[ye, (n_st - 1) * r_st - M(0.3)], [yb + M(0.3), 0]]));
    translate([ye - M(0.12), H_p + 0.02]) square([M(0.25) + M(0.12) + es, t_ha]);   // Auflage auf dem Deck
    translate([ye - M(0.12), (n_st - 1) * r_st - 0.01]) square([M(0.12), H_p - (n_st - 1) * r_st + 0.06]);   // letzte Stufe bis zur Auflage
    translate([Y_s0 + M(0.08), H_p - l_tb]) square([t_f, l_tb + 0.05]);  // Zunge
}
module treppe_gel_2d() let(yb = Y_s0 - es - (n_st - 1) * a_st, P0 = [yb + b_g / 2, r_st], P1 = [Y_s0 - b_g / 2, H_p]) {
    for (p = [P0, P1]) translate([p[0] - b_g / 2, p[1] - 0.01]) square([b_g, H_g]);
    for (v = [H_g / 2, H_g - b_g / 2]) sbar(P0 + [0, v], P1 + [0, v], b_g);
}
module treppe_welt() {
    yz(X_st[0] + es, X_st[1] - es) treppe_2d();
    yz(X_st[1] - es - t_ha, X_st[1] - es) treppe_gel_2d();
}
module treppe_druck() yz_druck(X_st[1] - es) treppe_welt();

// Pult (Welt): Frontplatte + Tischplatte; gedruckt auf der Frontplatte
module pult_welt() difference() {
    union() {
        xz(y_pf, y_pf + t_pl) {
            translate([X_pu[0], H_p + 0.02]) square([X_pu[1] - X_pu[0], h_pu - 0.02]);
            for (u = posten(X_pu[1] - X_pu[0], 1.5)) translate([X_pu[0] + u - b_g / 2, H_p - l_tb]) square([b_g, l_tb + 0.05]);
        }
        translate([X_pu[0], y_pf + t_pl - d_tt, H_p + h_pu - t_pl]) cube([X_pu[1] - X_pu[0], d_tt, t_pl]);
        // Seitenwangen (Dreiecke unter der Tischplatte, 45°)
        for (x = [X_pu[0], X_pu[1] - t_pl]) translate([x, 0, 0]) yz(0, t_pl) polygon([[y_pf + t_pl, H_p + h_pu - t_pl - d_tt + t_pl], [y_pf + t_pl, H_p + h_pu - t_pl + 0.01], [y_pf + t_pl - d_tt, H_p + h_pu - t_pl + 0.01]]);
    }
    for (i = [0 : n_pl - 1]) schlitz(x_pl(i) - b_g / 2, x_pl(i) + b_g / 2, y_mo, y_mo + t_mo, H_p + h_pu, t_pl + 1);
}
module pult_druck() xz_druck(y_pf + t_pl) pult_welt();

// Monitorleiste (Welt): Bildschirme auf Füßen, Füße mit Zungen in die Tischplatte
module monitore_2d() let(z0 = H_p + h_pu) {
    for (i = [0 : n_pl - 1]) {
        translate([x_pl(i) - w_mo / 2, z0 + h_ms]) square([w_mo, h_mo]);
        translate([x_pl(i) - b_g / 2, z0 - t_pl]) square([b_g, h_ms + t_pl + 0.01]);
        translate([x_pl(i) - w_mo * 0.3, z0]) square([w_mo * 0.6, b_g]);
    }
    translate([x_pl(0), z0 + h_ms + h_mo * 0.3]) square([x_pl(n_pl - 1) - x_pl(0), b_g]);   // Verbindungsholm
}
module monitore_welt(fp) {
    if (inc(fp, "A")) difference() { xz(y_mo, y_mo + t_mo) monitore_2d(); translate([0, y_mo - 1, 0]) monitore_b(1, 0); }
    if (inc(fp, "B")) translate([0, y_mo, 0]) monitore_b(0, 0.02);
}
// Bildschirmflächen (Inlay auf der Schauseite), über einen schmalen Streifen auf dem Holm verbunden
module monitore_b(ex, o) let(z0 = H_p + h_pu + h_ms, zs = z0 + h_mo * 0.3 + b_g * 0.2) {
    for (i = [0 : n_pl - 1]) translate([x_pl(i) - w_mo / 2 + b_g + o, 0, z0 + b_g + o]) cube([w_mo - 2 * b_g - 2 * o, d_sc + ex, h_mo - 2 * b_g - 2 * o]);
    translate([x_pl(0), 0, zs + o]) cube([x_pl(n_pl - 1) - x_pl(0), d_sc + ex, b_g * 0.6 - 2 * o]);
}
module monitore_druck(fp) xz_druck0(y_mo) monitore_welt(fp);

// Hockerreihe (Welt): Schiene in der Nut, Hocker darauf
module hocker_welt() {
    translate([M(0.2) + es, y_hk - w_hr / 2 + es, H_p - h_hr]) cube([L - M(0.4) - 2 * es, w_hr - 2 * es, h_hr]);
    for (i = [0 : n_pl - 1]) translate([x_pl(i), y_hk, H_p]) {
        translate([0, 0, -0.01]) cylinder(d = d_hp, h = h_hs + 0.01, $fn = 16);
        translate([0, 0, h_hs - t_hs - (r_hs - d_hp / 2)]) cylinder(r1 = d_hp / 2, r2 = r_hs, h = r_hs - d_hp / 2 + 0.01, $fn = 24);
        translate([0, 0, h_hs - t_hs]) cylinder(r = r_hs, h = t_hs, $fn = 24);
    }
}
module hocker_druck() translate([0, 0, h_hr - H_p]) hocker_welt();

// Seitenwand 2D (u = y, v = z ab Boden): Wand zwischen den Pfosten, Zungen unten (Podest) und oben (Dach)
function wf() = [WF[0], WF[1], WF[2], H_bb - M(0.25)];
module seitenwand_2d() {
    translate([y_rh - b_p / 2, H_p + 0.02]) square([y_rv - y_rh + b_p, H_bb - H_p - 0.04]);
    for (y = [y_rv, y_rh]) translate([y - b_p / 2, H_p - l_tb]) square([b_p, H_bb - H_p + l_tb + l_rt]);
}
module fenster_2d(o) let(f = wf()) translate([f[0] - o, f[2] - o]) square([f[1] - f[0] + 2 * o, f[3] - f[2] + 2 * o]);
// lokal: Ebene u-v, Dicke z (z = 0 Bettseite); Scheibe von unten, Lippe oben
module seitenwand_lokal(fp) {
    if (inc(fp, "A")) difference() {
        linear_extrude(t_sw) seitenwand_2d();
        translate([0, 0, -1]) linear_extrude(t_sw - t_lp + 1) fenster_2d(es);
        translate([0, 0, -1]) linear_extrude(t_sw + 2) fenster_2d(-w_lp);
    }
    if (inc(fp, "B")) {
        linear_extrude(t_sw - t_lp) fenster_2d(-es * 0);
        linear_extrude(t_sw) fenster_2d(-w_lp - es);
    }
}
y_wc = (y_rv + y_rh) / 2;
module seitenwand_welt(i, fp) let(T = [[0, 0, 1, 0], [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 1]])   // lokal (u, v, z) -> Welt (z, u, v)
    if (i == 0) multmatrix(T) seitenwand_lokal(fp);
    else translate([L / 2, y_wc, 0]) rotate(180) translate([-L / 2, -y_wc, 0]) multmatrix(T) seitenwand_lokal(fp);
module seitenwand_druck(fp) translate([-y_rh + b_p, -H_p + l_tb, 0]) seitenwand_lokal(fp);

module gelaender_welt() translate([M(0.25), 0, H_p]) xz(Y_s0, Y_s0 + t_f) gelaender_2d(X_st[0] - M(0.1) - M(0.25));
module gelaender_druck() translate([0, l_tb, 0]) linear_extrude(t_f) gelaender_2d(X_st[0] - M(0.1) - M(0.25));

// Dach (Welt) – gedruckt kopfüber
module dach_welt() difference() {
    union() {
        translate([-X_ro, Y_s0 - X_ro, H_r]) cube([L + 2 * X_ro, Y_r1 - Y_s0 + X_ro, t_ro]);
        difference() { translate([-X_ro, Y_s0 - X_ro, H_r + t_ro - h_bl]) cube([L + 2 * X_ro, Y_r1 - Y_s0 + X_ro, h_bl]);
                       translate([-X_ro + t_sk, Y_s0 - X_ro + t_sk, H_r + t_ro - h_bl - 1]) cube([L + 2 * X_ro - 2 * t_sk, Y_r1 - Y_s0 + X_ro - 2 * t_sk, h_bl + 1 - t_ro + 0.01]); }
        // Längsrippe und Endrippen über den Seitenrahmen
        translate([-X_ro, (Y_s0 + Y_r1) / 2 - t_sk / 2, H_bb]) cube([L + 2 * X_ro, t_sk, h_bl]);
        for (x = [-X_ro, L - t_sw - M(0.1)]) translate([x, Y_s0 - X_ro, H_bb]) cube([t_sw + M(0.1) + X_ro, Y_r1 - Y_s0 + X_ro, h_bl]);
    }
    for (x0 = [0, L - t_sw], y = [y_rv, y_rh]) translate([x0 - es, y - b_p / 2 - es, H_bb - 1]) cube([t_sw + 2 * es, b_p + 2 * es, l_rt + 1.3]);
    for (u = posten(X_bn[1] - X_bn[0], 1.5)) translate([X_bn[0] + u - b_g / 2 - es, y_bn - es, H_r + t_ro - t_ro * 0.7 - 0.3]) cube([b_g + 2 * es, t_bn + 2 * es, t_ro + 1]);
}
module dach_druck() translate([0, 0, H_r + t_ro]) rotate([180, 0, 0]) dach_welt();

// Banner (Welt): Tafel auf dem Dach, Schrift zur Strecke (+y)
module banner_2d() let(z0 = H_r + t_ro) {
    translate([X_bn[0], z0]) square([X_bn[1] - X_bn[0], h_bn]);
    for (u = posten(X_bn[1] - X_bn[0], 1.5)) translate([X_bn[0] + u - b_g / 2, z0 - t_ro * 0.7]) square([b_g, t_ro * 0.7 + 0.01]);
}
module banner_text_2d() let(z0 = H_r + t_ro, w = X_bn[1] - X_bn[0]) translate([(X_bn[0] + X_bn[1]) / 2, z0 + h_bn / 2])
    resize([min(w * 0.9, len(banner_text) * h_bn * 0.6 * 0.7), 0], auto = [false, true]) text(banner_text, size = h_bn * 0.55, font = banner_font, halign = "center", valign = "center");
module banner_welt(fp) {
    // Schauseite y = y_bn + t_bn; gespiegelte Schrift, weil von +y gelesen
    if (inc(fp, "A")) difference() { xz(y_bn, y_bn + t_bn) banner_2d();
        translate([0, y_bn + t_bn - d_tx, 0]) xz(0, d_tx + 1) mirror([1, 0]) translate([-(X_bn[0] + X_bn[1]), 0]) banner_text_2d(); }
    if (inc(fp, "B")) translate([0, y_bn + t_bn - d_tx, 0]) xz(0, d_tx) mirror([1, 0]) translate([-(X_bn[0] + X_bn[1]), 0]) banner_text_2d();
}
module banner_druck(fp) xz_druck(y_bn + t_bn) banner_welt(fp);

// =====================================================================
//  Zusammenbau
// =====================================================================
X_k = floor((elemente - 1) / 2) * L;        // Kommandostand am mittleren Element
module kommandostand(ex = 0) translate([X_k, -ex, 0]) {
    if (ex > 0) for (x = CLX) translate([x, Y_s1 / 2 + ex * 0.5, -ex * 0.4]) rotate(90) translate([0, 0, 0]) bunt(farbe_mauer) clip();
    bunt(farbe_podest) podest_welt();
    translate([0, -ex * 0.6, 0]) bunt(farbe_podest) treppe_welt();
    translate([0, 0, ex * 0.6]) {
        bunt(farbe_pult) pult_welt();
        translate([0, 0, ex * 0.5]) { bunt(farbe_pult) monitore_welt("A"); bunt(farbe_bildschirm) monitore_welt("B"); }
        bunt(farbe_hocker) hocker_welt();
        for (i = [0, 1]) translate([(i == 0 ? -1 : 1) * ex * 0.5, 0, 0]) { bunt(farbe_seitenwand) seitenwand_welt(i, "A"); bunt(farbe_glas) seitenwand_welt(i, "B"); }
        bunt(farbe_rahmen) gelaender_welt();
        translate([0, 0, ex * 1.4]) { bunt(farbe_dach) dach_welt();
            translate([0, 0, ex * 0.6]) { bunt(farbe_banner) banner_welt("A"); bunt(farbe_schrift) banner_welt("B"); } }
    }
}
module boxenmauer(ex = 0) {
    for (k = [0 : elemente - 1]) translate([k * (L + ex * 0.4), ex * 0.5, 0]) {
        bunt(farbe_mauer) mauer_welt("A"); bunt(farbe_werbung) mauer_welt("B");
        translate([0, 0, ex]) bunt(farbe_zaun) zaunfeld_welt();
    }
    kommandostand(ex);
}

// =====================================================================
//  Info und Ausgabe
// =====================================================================
CLIPS = (rennbahn_taschen ? max(elemente - 1, 0) : 0) + len(CLX);
echo(str("Boxenmauer 1:", den, " | Element ", r2(L), " mm lang, Mauer ", r2(H_w), " mm hoch, Fuß ", r2(W_b), " mm | Zaun ", r2(H_f), " mm | Reihe aus ", elemente, " Elementen ", r2(elemente * L / 10), " cm"));
echo(str("Kommandostand: ", r2(L), " x ", r2(D_st + (n_st - 1) * a_st), " mm, Podest ", r2(H_p), " mm, Dach ", r2(H_r + t_ro), " mm, Banner bis ", r2(H_r + t_ro + h_bn), " mm | ", n_pl, " Plätze"));
echo(str("Mindestmaße: Zaundraht ", r2(w_m), " | Pfosten ", r2(b_p), " | Geländer ", r2(b_g), " | Hockerbein ", r2(d_hp), " | Zunge ", r2(l_tb), " mm | Clip ", cL, " x ", cw1, " (Mauerfuß ", r2(W_b), ")"));
if (max(L, H_f + l_tb) > usable) echo("WARNUNG: Mauerelement/Zaunfeld größer als das Druckbett");
if (D_st + 2 * X_ro > usable) echo("WARNUNG: Dach zu tief für das Druckbett");
if (W_b < cw1 + 2 * spiel + 2 * min_wand - 0.01) echo("WARNUNG: Mauerfuß zu schmal für die Clip-Tasche");
mass_echo(elemente * L, Y_r1 - Y_s0 + (n_st - 1) * a_st, H_r + t_ro + h_bn);

druck("mauer", 1, "A", farbe_mauer, elemente); druck("mauer", 1, "B", farbe_werbung, elemente);
druck("zaunfeld", 1, "alle", farbe_zaun, elemente);
druck("podest", 1, "alle", farbe_podest, 1);
druck("treppe", 1, "alle", farbe_podest, 1);
druck("pult", 1, "alle", farbe_pult, 1);
druck("monitore", 1, "A", farbe_pult, 1); druck("monitore", 1, "B", farbe_bildschirm, 1);
druck("hocker", 1, "alle", farbe_hocker, 1);
druck("seitenwand", 1, "A", farbe_seitenwand, 2); druck("seitenwand", 1, "B", farbe_glas, 2);
druck("gelaender", 1, "alle", farbe_rahmen, 1);
druck("dach", 1, "alle", farbe_dach, 1);
druck("banner", 1, "A", farbe_banner, 1); druck("banner", 1, "B", farbe_schrift, 1);
druck("verbinder", 1, "alle", farbe_mauer, 1);
farben_echo();

if (teil == "aufbau") boxenmauer();
else if (teil == "explosion") boxenmauer(max(M(1.5), 12));
else if (teil == "mauer") mauer_druck(farbteil);
else if (teil == "zaunfeld") zaunfeld_druck();
else if (teil == "podest") podest_druck();
else if (teil == "treppe") treppe_druck();
else if (teil == "pult") pult_druck();
else if (teil == "monitore") monitore_druck(farbteil);
else if (teil == "hocker") hocker_druck();
else if (teil == "seitenwand") seitenwand_druck(farbteil);
else if (teil == "gelaender") gelaender_druck();
else if (teil == "dach") dach_druck();
else if (teil == "banner") banner_druck(farbteil);
else if (teil == "verbinder") verbinder_platten(max(CLIPS, 4), stueck);
