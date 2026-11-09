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

// =====================================================================
//  deko_grundlagen.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Maßstab -> sc()/M(), Druckbett, Clip-Maße (cL, cw0, cw1, ch, clipd, mw, mi, spw),
//  Farbpalette FARBEN + fhex().  Erwartet VOR dem include im Modell:
//    massstab, eigener_massstab, druckbett, rand, min_wand, spiel
// =====================================================================
// =====================================================================
//  Grundlagen
// =====================================================================
$fa = 3; $fs = 0.3;
e   = 0.01;
den = massstab == 0 ? eigener_massstab : massstab;
s   = 1 / den;
function sc(mm, mn = 0) = max(mm * s, mn);
function M(m, mn = 0) = sc(m * 1000, mn);
function r2(x) = round(x * 100) / 100;
function inc(fp, g) = fp == "alle" || fp == g;
function deg(x) = x * 180 / PI;
usable = druckbett - 2 * rand;
gap = 0.1;
cl  = 0.3;

function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] : d <= 20 ? [16, 6, 10, 3.2] : d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] : d <= 50 ? [10, 4, 7, 2] : [8, 3.2, 5.6, 1.6];
CT = conn_tab(den);
cL = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];
deck  = 0.8;
clipd = ch + spiel + deck;
mw  = cw1 / 2 + spiel + min_wand;
mi  = cL / 2 + 1.5;
spw = cL + 3;
b_cl = clipd + 0.4;                              // Mindestdicke für eine Clip-Tasche
r_cb = sqrt(cL * cL / 4 + cw1 * cw1 / 4) + spiel + 1.0;   // Clip-Boss-Radius

FARBEN = [["rot", "#c62828"], ["gelb", "#f9c80e"], ["blau", "#1e5bb8"], ["gruen", "#2e9d4f"], ["weiss", "#f4f4f4"],
          ["schwarz", "#222222"], ["grau", "#8a8f94"], ["silber", "#c0c4c8"], ["gold", "#d4a017"], ["orange", "#ef7d1a"],
          ["lila", "#7b3fa0"], ["rosa", "#f27fb2"], ["tuerkis", "#1fb5b0"], ["braun", "#7a4b2a"], ["holz", "#c19a6b"], ["creme", "#f3e3c3"],
          ["anthrazit", "#3a3f45"], ["cyan", "#12b5e8"], ["pink", "#e43d8f"], ["violett", "#8e3fc2"], ["neongruen", "#2ad957"],
          ["hellblau", "#5aa2dc"], ["dunkelgruen", "#1f6b3a"], ["puderblau", "#8cc8ea"], ["catgelb", "#eeb111"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

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

// =====================================================================
//  deko_hilfen.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Geometrie-Hilfen, Rechteck-Teilung (split_out, seams_at, pads, clips_*),
//  Polar-Teilung runder Teile (polar_pieces, pp_druck, pp_clips), Strichzüge.
//  Erwartet: deko_grundlagen.scad; für poly()/sidec()/vtx(): N_d, ad, tc im Modell.
// =====================================================================
// =====================================================================
//  Hilfen
// =====================================================================
function pol(r, a) = [r * cos(a), r * sin(a)];
function adiff(a, b) = abs(((a - b) % 360 + 540) % 360 - 180);
function rotp(p, r) = [p[0] * cos(r) - p[1] * sin(r), p[0] * sin(r) + p[1] * cos(r)];
function bb(P) = [min([for (p = P) p[0]]), min([for (p = P) p[1]]), max([for (p = P) p[0]]), max([for (p = P) p[1]])];
module bar(p, q, w) hull() { translate(p) circle(d = w, $fn = 12); translate(q) circle(d = w, $fn = 12); }
module sbar(p, q, w) hull() { translate(p) square(w, center = true); translate(q) square(w, center = true); }
module rect2(r) translate([r[0], r[1]]) square([r[2] - r[0], r[3] - r[1]]);
module ring2(r, w) difference() { circle(r = r + w / 2, $fa = 1); circle(r = r - w / 2, $fa = 1); }
module teardrop(r) { hull() { circle(r = r); translate([r * sqrt(2) - 0.01, 0]) square(0.02, center = true); } }
// D-Profil: Abflachung bei u = +c (wird beim liegenden Druck nach unten gedreht)
module dprof(d, c) intersection() { circle(d = d); translate([-d - 1, -d - 1]) square([d + 1 + c, 2 * d + 2]); }
module bowtie_2d() polygon([[-cL / 2, -cw1 / 2], [0, -cw0 / 2], [cL / 2, -cw1 / 2], [cL / 2, cw1 / 2], [0, cw0 / 2], [-cL / 2, cw1 / 2]]);
module clip() linear_extrude(ch) bowtie_2d();
module clip_cut(rot, top, zt2) {
    rotate([0, 0, rot]) {
        if (top) translate([0, 0, zt2 - ch - spiel]) linear_extrude(ch + spiel + 1) offset(delta = spiel) bowtie_2d();
        else {
            translate([0, 0, -1]) linear_extrude(ch + spiel + 1) offset(delta = spiel) bowtie_2d();
            translate([0, 0, -1]) linear_extrude(1.3) offset(delta = spiel + 0.3) bowtie_2d();
        }
    }
}
module rb_slot() {
    w0 = cw0 / 2 + spiel; w1 = cw1 / 2 + spiel; l = cL / 2 + spiel;
    pts = [[-1, -w0], [0, -w0], [l, -w1], [l, w1], [0, w0], [-1, w0]];
    translate([0, 0, -e]) linear_extrude(ch + spiel + e) polygon(pts);
    translate([0, 0, -e]) linear_extrude(0.3 + e) offset(delta = 0.3) polygon(pts);
}
// Fachwerkträger von P nach Q (2D)
module girder(P, Q, w, c, d) {
    L = norm(Q - P); a = atan2(Q[1] - P[1], Q[0] - P[0]);
    translate(P) rotate(a) {
        if (w - 2 * c < 2.5) translate([0, -w / 2]) square([L, w]);
        else {
            translate([0, -w / 2]) square([L, c]);
            translate([0, w / 2 - c]) square([L, c]);
            n = max(2, round(L / (w - c)));
            for (k = [0 : n - 1]) let(x0 = k * L / n, x1 = (k + 1) * L / n)
                bar([x0, (k % 2 == 0 ? -1 : 1) * (w / 2 - c / 2)], [x1, (k % 2 == 0 ? 1 : -1) * (w / 2 - c / 2)], d);
            translate([0, -w / 2]) square([c * 1.5, w]);
        }
    }
}

// ---------------------------------------------------------------------
//  Rechteck-Teilung (wie hafenkran / containerbruecke)
//  info = [SX, SY, Nähte x, Nähte y, keep, von oben?, Oberkante, solids]
// ---------------------------------------------------------------------
function band_a(l, i) = i == 0 ? 0 : l[i - 1];
function band_b(l, i, S) = i >= len(l) ? S : l[i];
function rect_hit(r, k) = !(r[2] <= k[0] || r[0] >= k[2] || r[3] <= k[1] || r[1] >= k[3]);
function free(r, kp) = len([for (k = kp) if (rect_hit(r, k)) 1]) == 0;
function inside(r, S) = len(S) == 0 || len([for (q = S) if (r[0] >= q[0] - 0.01 && r[1] >= q[1] - 0.01 && r[2] <= q[2] + 0.01 && r[3] <= q[3] + 0.01) 1]) > 0;
function okc(r, kp, S) = free(r, kp) && inside(r, S);
function pick(l, sep, last = -1e9, i = 0) = i >= len(l) ? [] :
    l[i] - last >= sep ? concat([l[i]], pick(l, sep, l[i], i + 1)) : pick(l, sep, last, i + 1);
function qsort(l) = len(l) <= 1 ? l : let(p = l[floor(len(l) / 2)])
    concat(qsort([for (x = l) if (x < p) x]), [for (x = l) if (x == p) x], qsort([for (x = l) if (x > p) x]));
function cand(a, b, tot, S, ax, at) = let(ma = a <= 0 ? mw : mi, mb = b >= tot ? mw : mi)
    qsort(concat([for (v = [a + ma : 0.5 : b - mb]) v],
    [for (q = S) if (q[ax] <= at && q[ax + 2] >= at) let(c = (q[1 - ax] + q[3 - ax]) / 2) if (c >= a + ma && c <= b - mb) c]));
function clips_v(sx, a, b, kp, S, tot, sep = 16) = let(
    ok = [for (y = cand(a, b, tot, S, 0, sx)) if (okc([sx - cL / 2 - 1, y - mw, sx + cL / 2 + 1, y + mw], kp, S)) y])
    pick(ok, max(sep, 2 * mw + 2));
function clips_h(sy, a, b, kp, S, tot, sep = 16) = let(
    ok = [for (x = cand(a, b, tot, S, 1, sy)) if (okc([x - mw, sy - cL / 2 - 1, x + mw, sy + cL / 2 + 1], kp, S)) x])
    pick(ok, max(sep, 2 * mw + 2));
function SEP(info) = len(info) > 9 ? info[9] : 16;
function lsum(l, i = 0) = i >= len(l) ? 0 : l[i] + lsum(l, i + 1);
// belegte Zellen (info[8] = Belegungs-Rechtecke; fehlt es, gelten alle Zellen als belegt)
function cells(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], O = len(info) > 8 ? info[8] : [])
    [for (iy = [0 : len(ys)], ix = [0 : len(xs)])
        let(r = [ix == 0 ? -1e9 : band_a(xs, ix) + gap, iy == 0 ? -1e9 : band_a(ys, iy) + gap,
                 ix == len(xs) ? 1e9 : band_b(xs, ix, SX) - gap, iy == len(ys) ? 1e9 : band_b(ys, iy, SY) - gap])
        if (len(O) == 0 || len([for (o = O) if (rect_hit(r, o)) 1]) > 0) [ix, iy]];
function n_pieces(info) = len(cells(info));
function occ(M, ox, oy) = [for (m = M) let(L = norm(m[1] - m[0]), n = max(1, ceil(L / 3)))
    for (k = [0 : n]) let(p = m[0] + k / n * (m[1] - m[0])) [p[0] - m[2] / 2 + ox, p[1] - m[2] / 2 + oy, p[0] + m[2] / 2 + ox, p[1] + m[2] / 2 + oy]];
function clip_count(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7])
    lsum([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp, S, SY, SEP(info)))]) +
    lsum([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp, S, SX, SEP(info)))]);
function crosses(S, ax, at, a, b) = len(S) == 0 || len([for (q = S) if (q[ax] < at && q[ax + 2] > at && q[3 - ax] > a && q[1 - ax] < b) 1]) > 0;
function zero_seams(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7])
    len([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) let(a = band_a(ys, iy), b = band_b(ys, iy, SY))
         if (crosses(S, 0, xs[k], a, b) && len(clips_v(xs[k], a, b, kp, S, SY, SEP(info))) == 0) 1]) +
    len([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) let(a = band_a(xs, ix), b = band_b(xs, ix, SX))
         if (crosses(S, 1, ys[k], a, b) && len(clips_h(ys[k], a, b, kp, S, SX, SEP(info))) == 0) 1]);
function bad_at(v, bads) = len([for (b = bads) if (v > b[0] && v < b[1]) 1]) > 0;
function seam_pick(t, bads, lo, hi, k = 0) =
    k > 4000 ? t :
    let(d = (k % 2 == 0 ? 1 : -1) * floor((k + 1) / 2) * 0.5, v = t + d)
    (v > lo && v < hi && !bad_at(v, bads)) ? v : seam_pick(t, bads, lo, hi, k + 1);
function seams_n(S, bads, margin, n) = [for (k = [1 : 1 : n - 1]) seam_pick(k * S / n, bads, margin, S - margin)];
function max_gap(l, S) = max([for (i = [0 : len(l)]) band_b(l, i, S) - band_a(l, i)]);
// so viele Nähte, dass jedes Stück trotz verschobener Nahtlage aufs Bett passt
function seams_at(S, bads, margin, n = 0) = let(n0 = max(1, ceil(S / usable)), nn = n == 0 ? n0 : n, l = seams_n(S, bads, margin, nn))
    (max_gap(l, S) <= usable || nn > n0 + 8) ? l : seams_at(S, bads, margin, nn + 1);
// Stoßbleche, wo eine Naht einen Stab [p, q, w] kreuzt
function pads(M, xs, ys) = concat(
    [for (m = M, x = xs) let(p = m[0], q = m[1]) if ((p[0] - x) * (q[0] - x) < 0)
        let(t = (x - p[0]) / (q[0] - p[0]), c = p + t * (q - p), h = max(m[2] / 2 / max(0.2, abs(cos(atan2(q[1] - p[1], q[0] - p[0])))), mw + 0.5))
        [x - spw / 2, c[1] - h, x + spw / 2, c[1] + h]],
    [for (m = M, y = ys) let(p = m[0], q = m[1]) if ((p[1] - y) * (q[1] - y) < 0)
        let(t = (y - p[1]) / (q[1] - p[1]), c = p + t * (q - p), h = max(m[2] / 2 / max(0.2, abs(sin(atan2(q[1] - p[1], q[0] - p[0])))), mw + 0.5))
        [c[0] - h, y - spw / 2, c[0] + h, y + spw / 2]]);
function shift_r(rs, ox, oy) = [for (r = rs) [r[0] + ox, r[1] + oy, r[2] + ox, r[3] + oy]];

module split_out(info, stk) {
    SX = info[0]; SY = info[1]; xs = info[2]; ys = info[3]; kp = info[4]; top = info[5]; zt2 = info[6]; S = info[7];
    nx = len(xs) + 1; ny = len(ys) + 1;
    C = cells(info);
    if (nx * ny == 1) children();
    else for (ci = [0 : len(C) - 1]) {
        ix = C[ci][0]; iy = C[ci][1]; idx = ci + 1;
        xa = band_a(xs, ix); xb = band_b(xs, ix, SX);
        ya = band_a(ys, iy); yb = band_b(ys, iy, SY);
        bx0 = ix == 0 ? -500 : xa + gap;  bx1 = ix == nx - 1 ? SX + 500 : xb - gap;
        by0 = iy == 0 ? -500 : ya + gap;  by1 = iy == ny - 1 ? SY + 500 : yb - gap;
        if (stk == 0 || stk == idx)
            translate(stk == 0 ? [ix * 8, iy * 8, 0] : [-xa, -ya, 0])
            difference() {
                intersection() { children(); translate([bx0, by0, -500]) cube([bx1 - bx0, by1 - by0, 1000]); }
                if (ix > 0)      for (y = clips_v(xa, ya, yb, kp, S, SY, SEP(info))) translate([xa, y, 0]) clip_cut(0, top, zt2);
                if (ix < nx - 1) for (y = clips_v(xb, ya, yb, kp, S, SY, SEP(info))) translate([xb, y, 0]) clip_cut(0, top, zt2);
                if (iy > 0)      for (x = clips_h(ya, xa, xb, kp, S, SX, SEP(info))) translate([x, ya, 0]) clip_cut(90, top, zt2);
                if (iy < ny - 1) for (x = clips_h(yb, xa, xb, kp, S, SX, SEP(info))) translate([x, yb, 0]) clip_cut(90, top, zt2);
            }
    }
}



function starts(sx, p) = len(sx) >= len(p) && len([for (i = [0 : len(p) - 1]) if (sx[i] != p[i]) 1]) == 0;
module poly(ap) rotate(ad / 2) circle(r = ap / tc, $fn = N_d);
function sidec(k) = k * ad;                     // Seitenmitte
function vtx(j) = (j + 0.5) * ad;               // Ecke
function spts(bl, bh, a0, a1) = let(N = 24) concat([for (i = [0 : N]) pol(bh, a0 + i * (a1 - a0) / N)],
                                                  bl > 0.01 ? [for (i = [0 : N]) pol(bl, a0 + i * (a1 - a0) / N)] : [[0, 0]]);
function fit_pts(P, a0, a1) = let(r0 = 90 - (a0 + a1) / 2,
        ok = [for (d = [0, 10, -10, 20, -20, 30, -30, 45, -45, 60, -60, 90]) let(b = bb([for (p = P) rotp(p, r0 + d)]))
              if (b[2] - b[0] <= usable && b[3] - b[1] <= usable) r0 + d])
    len(ok) > 0 ? ok[0] : undef;
module wedge_mask(a0, a1, R) difference() {
    polygon(concat([[0, 0]], [for (i = [0 : 36]) pol(2 * R + 10, a0 + i * (a1 - a0) / 36)]));
    for (a = [a0, a1]) rotate(a) translate([0, -gap]) square([2 * R + 20, 2 * gap]);
}
module side_frame(k, ap) rotate(sidec(k)) translate([ap, 0, 0]) children();   // x = radial, y = tangential

// =====================================================================
//  Zusatz-Hilfen
// =====================================================================
function cr(p0, p1, p2, p3, t) = 0.5 * ((2 * p1) + (-p0 + p2) * t + (2 * p0 - 5 * p1 + 4 * p2 - p3) * t * t + (-p0 + 3 * p1 - 3 * p2 + p3) * t * t * t);
function smooth(P, k = 5) = let(n = len(P)) concat([for (i = [0 : n - 2], j = [0 : k - 1])
    cr(P[max(i - 1, 0)], P[i], P[i + 1], P[min(i + 2, n - 1)], j / k)], [P[n - 1]]);
// Strichzug: Punkte [x, y, Breite], Maßstab f, Mindeststrich wmin
module stroke(P, f = 1, wmin = 0) for (i = [0 : len(P) - 2]) hull() {
    translate([P[i][0] * f, P[i][1] * f]) circle(d = max(P[i][2] * f, wmin), $fn = 16);
    translate([P[i + 1][0] * f, P[i + 1][1] * f]) circle(d = max(P[i + 1][2] * f, wmin), $fn = 16);
}
// Kanäle mit 45°-Giebel (Hohlräume, unten offen): Breite x0..x1, Höhe h, Stegbreite w
module gables_2d(x0, x1, h, w) {
    W = x1 - x0; n = max(1, ceil(W / (2 * max(h, 0.5))));
    hw = W / n / 2 - w / 2;
    if (hw > 0.6) for (j = [0 : n - 1]) let(c = x0 + (j + 0.5) * W / n)
        polygon([[c - hw, -1], [c + hw, -1], [c + hw, 0], [c, hw], [c - hw, 0]]);
}
module cyc() multmatrix([[0, 0, 1, 0], [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 1]]) children();   // (x,y,z) -> (z,x,y)
module poly12(ap) rotate(am / 2) circle(r = ap / tcm, $fn = N_m);

// ---------------------------------------------------------------------
//  Polar-Teilung runder Teile: Stück = [r0, r1, a0, a1, innen?, außen?]
// ---------------------------------------------------------------------
NLIST = [1, 2, 4, 8, 16, 32, 48, 64, 96, 128];
function pp_fit(p) = (p[3] - p[2] >= 359.9) ? (2 * p[1] <= usable ? 0 : undef) : fit_pts(spts(p[0], p[1], p[2], p[3]), p[2], p[3]);
function pp_ring(r0, r1, ab, ci, co, n) = n == 1 ? [[r0, r1, ab, ab + 360, ci, co]]
    : [for (j = [0 : n - 1]) [r0, r1, ab + j * 360 / n, ab + (j + 1) * 360 / n, ci, co]];
function pp_ok(P) = len([for (p = P) if (pp_fit(p) == undef) 1]) == 0;
function pp_band(r0, r1, ab, ci, co, i = 0) = let(P = pp_ring(r0, r1, ab, ci, co, NLIST[i]))
    (pp_ok(P) || i >= len(NLIST) - 1) ? P : pp_band(r0, r1, ab, ci, co, i + 1);
function polar_pieces(Ri, Ro, ab) =
    let(wedges = Ri < 0.01 ? [for (n = [1, 2, 4]) let(P = pp_ring(0, Ro, ab, false, false, n)) if (pp_ok(P)) P] : [])
    len(wedges) > 0 ? wedges[0] :
    let(Rc = Ri < 0.01 ? min(usable / 2 - 2, Ro) : Ri,
        nb = max(1, ceil((Ro - Rc) / (usable * 0.75))),
        B = [for (b = [0 : nb - 1]) [Rc + b * (Ro - Rc) / nb, Rc + (b + 1) * (Ro - Rc) / nb]])
    concat(Ri < 0.01 ? [[0, Rc, 0, 360, false, true]] : [],
           [for (b = [0 : nb - 1]) each pp_band(B[b][0], B[b][1], ab, Ri < 0.01 || b > 0, b < nb - 1)]);
module pp_mask(p, R) difference() {
    intersection() {
        circle(r = p[5] ? p[1] - gap : R + 50, $fa = 1);
        if (p[3] - p[2] < 359.9) polygon(concat([[0, 0]], [for (i = [0 : 36]) pol(2 * R + 100, p[2] + i * (p[3] - p[2]) / 36)]));
    }
    if (p[4]) circle(r = p[0] + gap, $fa = 1);
    if (p[3] - p[2] < 359.9) for (a = [p[2], p[3]]) rotate(a) translate([0, -gap]) square([2 * R + 100, 2 * gap]);
}
function pp_seams(P) = [for (p = P) if (p[3] - p[2] < 359.9) p[2]];
// Clip-Lagen [x, y, Drehung] entlang der radialen und der Kreis-Nähte
function pp_clips(P, rmin, rmax, sp = 40) = let(SE = pp_seams(P)) concat(
    [for (p = P) if (p[3] - p[2] < 359.9) let(r0 = max(p[0], rmin) + mi, r1 = min(p[1], rmax) - mw, n = r1 < r0 ? 0 : floor((r1 - r0) / sp) + 1)
        for (k = [0 : 1 : n - 1]) concat(pol(n == 1 ? (r0 + r1) / 2 : r0 + k * (r1 - r0) / (n - 1), p[2]), [p[2] + 90])],
    [for (p = P) if (p[4] && p[0] > rmin + mw && p[0] < rmax - mw) let(L = (p[3] - p[2]) * PI / 180 * p[0], n = max(1, round(L / sp)))
        for (k = [0 : n - 1]) let(a = p[2] + (k + 0.5) * (p[3] - p[2]) / n)
        if (min(concat([999], [for (sa = SE) adiff(a, sa) * PI / 180 * p[0]])) > spw + 1) concat(pol(p[0], a), [a])]);
function pp_rot(p) = let(r = pp_fit(p)) r == undef ? 90 - (p[2] + p[3]) / 2 : r;
function pp_bb(p, rot, flip) = (p[3] - p[2] >= 359.9) ? [-p[1], -p[1], p[1], p[1]] :
    bb([for (q = spts(p[0], p[1], p[2], p[3])) let(v = rotp(q, rot)) flip ? [v[0], -v[1]] : v]);
// Druck eines polar geteilten Teils: children() = Weltgeometrie zwischen zb und zt
module pp_druck(P, stk, R, zb, zt, flip = false) {
    for (i = [0 : len(P) - 1]) if (stk == 0 || stk == i + 1) {
        p = P[i]; r = pp_rot(p); b = pp_bb(p, r, flip);
        translate([(stk == 0 ? (i % 4) * (usable + 10) : 0) - b[0], (stk == 0 ? floor(i / 4) * (usable + 10) : 0) - b[1], flip ? zt : -zb])
            rotate([flip ? 180 : 0, 0, 0]) rotate([0, 0, r])
            intersection() { children(); translate([0, 0, zb - 1]) linear_extrude(zt - zb + 2) pp_mask(p, R); }
    }
}
function near(p, L, d) = len([for (q = L) if (norm([p[0] - q[0], p[1] - q[1]]) < d) 1]) > 0;

// ---- Ausgabe-Hilfen ----
module druck(t, n, fp, f, m) if (m > 0) echo(str("DRUCK|", t, "|", n, "|", fp, "|", f, "|", m));
module farben_echo() for (f = FARBEN) echo(str("FARBE|", f[0], "|", f[1]));
module mass_echo(x, y, z) echo(str("MASS|", r2(x), "|", r2(y), "|", r2(z)));
// Vorschau: Farbe aus FARBEN, render() damit OpenCSG mehrfarbige Teile richtig zeigt
module vorschau_farbe(f) color(fhex(f)) render(convexity = 6) children();
// Clip-Platten: n Clips, stk = 0 alle Platten, sonst Platte stk
module verbinder_platten(n, stk) {
    px = floor((usable + 3) / (cL + 3)); py = floor((usable + 3) / (cw1 + 3));
    npl = ceil(n / (px * py));
    for (pl = [0 : npl - 1]) if (stk == 0 || stk == pl + 1)
        translate(stk == 0 ? [pl * (usable + 10), 0, 0] : [0, 0, 0])
        for (i = [pl * px * py : min(n, (pl + 1) * px * py) - 1]) let(j = i - pl * px * py)
            translate([(j % px) * (cL + 3), floor(j / px) * (cw1 + 3), 0]) clip();
}

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
