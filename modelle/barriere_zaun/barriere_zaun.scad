// =====================================================================
//  BARRIERE MIT FANGZAUN  –  Betonschutzwand + Doppelpfosten + Zaunfelder
//  parametrisch, alle gängigen Maßstäbe, zerlegbar, FDM-optimiert
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    barriere     Betonelement mit Schlitzen für die Pfostenfüße
//    pfosten      Doppelpfosten mit Gabelkopf – steht auf der Fuge,
//                 seine Fußzapfen greifen in BEIDE Nachbarelemente und
//                 verbinden so die Barriere
//    endpfosten   Pfosten für Anfang/Ende einer Reihe (ein Fußzapfen)
//    zwischenpfosten  Pfosten mitten auf einem Element (wenn
//                 pfosten_pro_element > 1)
//    zaunfeld     Feld mit Rautengeflecht und Spannseilen; wird mit
//                 Stiften auf der Fahrbahnseite in die Pfosten gesteckt
//    reihe        Vorschau einer kompletten Reihe
//
//  MONTAGE
//    1. Barrieren in einer Reihe aufstellen.
//    2. Pfosten mit den Fußzapfen in die Schlitze stecken – je ein Zapfen
//       links und rechts der Fuge.
//    3. Zaunfelder von der Fahrbahnseite mit den Stiften in die Löcher
//       der Pfosten drücken.
//
//  DRUCK
//    Barriere aufrecht, Pfosten und Zaunfelder flach (Fahrbahnseite nach
//    unten, Stifte zeigen nach oben). Keine Stützen. Felder, die höher
//    sind als das Druckbett, werden in übereinander gesteckte Teilfelder
//    zerlegt; zu lange Teile werden mit Clips geteilt.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "reihe"; // [reihe:Vorschau Reihe, barriere:Barriere, pfosten:Pfosten (Fuge), endpfosten:Endpfosten, zwischenpfosten:Zwischenpfosten, zaunfeld:Zaunfeld, verbinder:Clips]
// Geteilte Teile / Teilfelder: 0 = alle, 1..n = einzelnes Stück
stueck = 0;

/* [Barriere (Vorbild)] */
profil = "rennstrecke"; // [rennstrecke:Rennstrecke (senkrecht zur Fahrbahn), new_jersey:New Jersey, single_slope:Single Slope]
hoehe_mm = 900;
breite_mm = 650;
laenge_m = 4.0;
staplertaschen = true;
// Clip-Taschen unten an den Enden (Rennbahn-System)
rennbahn_clips = false;

/* [Zaun (Vorbild)] */
zaun_hoehe_m = 2.6;
// Pfosten je Element (1 = nur auf den Fugen)
pfosten_pro_element = 1; // [1:4]
seile = 3; // [0:6]
masche = "raute"; // [raute:Rautengeflecht, quadrat:Quadratgitter, keine:nur Seile]
// Maschenweite Vorbild in mm (größer = besser druckbar)
masche_mm = 150;
gabelkopf = true;

/* [Vorschau] */
anzahl = 4; // [1:12]

/* [Druck & Passung] */
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
// Düsendurchmesser (dünnste Drahtbreite = 1,1 x Düse)
duese = 0.4;

// =====================================================================
//  Grundlagen
// =====================================================================
$fa = 3; $fs = 0.3;
e   = 0.01;
den = massstab == 0 ? eigener_massstab : massstab;
s   = 1 / den;
function sc(mm, mn = 0) = max(mm * s, mn);
function r2(x) = round(x * 100) / 100;
usable = druckbett - 2 * rand;
gap = 0.1;

function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] : d <= 20 ? [16, 6, 10, 3.2] : d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] : d <= 50 ? [10, 4, 7, 2] : [8, 3.2, 5.6, 1.6];
CT = conn_tab(den);
cL = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];
clipd = ch + spiel + 0.8;
mw    = cw1 / 2 + spiel + min_wand;
spw   = cL + 3;

// =====================================================================
//  Maße
// =====================================================================
// ---- Pfosten / Stifte ----
pd     = max(sc(40), 1.0);                   // Stift-Ø der Zaunfelder
hole_d = pd + 2 * spiel;
t_p    = max(sc(100), 2.0, clipd);           // Pfostendicke (quer zum Zaun)
W_u    = max(sc(70), hole_d + 2 * min_wand); // Breite eines Pfostenrohrs
g_u    = max(sc(40), 1.0);                   // Spalt zwischen den Rohren
u_o    = (g_u + W_u) / 2;                    // Rohrmitte ab Pfostenmitte
W_p    = 2 * W_u + g_u;
tf     = max(sc(30), 1.2);                   // Fußplatte
w_pin  = max(sc(80), 1.6);                   // Fußzapfen (Breite)
g_el   = max(sc(20), 0.4);                   // Fuge zwischen Elementen
a_pin  = max(sc(250), g_el / 2 + w_pin / 2 + spiel + min_wand, W_p / 2 + w_pin / 2 + 0.5);
Hz     = sc(zaun_hoehe_m * 1000, 15);
rung_h = max(sc(40), 0.8);

// ---- Barriere-Profil (Vorbild-mm, y > 0 = Fahrbahnseite) ----
HV = hoehe_mm; BV = breite_mm;
function prof_v(p) =
    p == "rennstrecke" ?
        let(yt = BV / 2 - HV * tan(3), tw = BV * 0.45, yb = yt - tw)
        [[-BV / 2, 0], [BV / 2, 0], [yt, HV], [yb, HV], [yb, HV * 0.82], [-BV / 2, HV * 0.3]] :
    p == "new_jersey" ?
        let(w1 = BV / 2 - 255 / tan(55) * BV / 610, w2 = w1 - (HV - 330) / tan(84) * BV / 610)
        [[-BV / 2, 0], [BV / 2, 0], [BV / 2, 75], [w1, 330], [w2, HV], [-w2, HV], [-w1, 330], [-BV / 2, 75]] :
        let(w2 = BV / 2 - (HV - 50) * tan(10.8))
        [[-BV / 2, 0], [BV / 2, 0], [BV / 2, 50], [w2, HV], [-w2, HV], [-BV / 2, 50]];
H  = sc(HV, 6);
fz = H / HV;
fy = max(sc(BV, 4), 0) / BV;
PV = prof_v(profil);
P0 = [for (p = PV) [p[0] * fy, p[1] * fz]];
// Krone breit genug für den Pfostenfuß?
top_pts = [for (p = P0) if (abs(p[1] - H) < 0.001) p[0]];
top_w0  = max(top_pts) - min(top_pts);
top_need = t_p + 2 * (spiel + min_wand);
widen   = max(0, (top_need - top_w0) / 2);
PROF = [for (p = P0) abs(p[1] - H) < 0.001 ? [p[0] + (p[0] >= (max(top_pts) + min(top_pts)) / 2 ? widen : -widen), p[1]] : p];
y_tt = max([for (p = PROF) if (abs(p[1] - H) < 0.001) p[0]]);   // Krone fahrbahnseitig
y_tb = min([for (p = PROF) if (abs(p[1] - H) < 0.001) p[0]]);
B  = max([for (p = PROF) p[0]]) - min([for (p = PROF) p[0]]);
y_p = profil == "rennstrecke" ? y_tt - spiel - min_wand - t_p / 2 : (y_tt + y_tb) / 2;   // Pfostenebene
module profil_2d() polygon(PROF);

// ---- Raster ----
L   = sc(laenge_m * 1000, 15);
PE  = L + g_el;                              // Elementraster
// Feldlänge: Pfostenabstand so wählen, dass ein Feld aufs Bett passt
function feld_n(m) = (PE / m - 2 * u_o + W_u) <= usable || m > 20 ? m : feld_n(m + 1);
m_pe = feld_n(max(1, pfosten_pro_element));
PP  = PE / m_pe;                             // Pfostenabstand
dp  = min(max(sc(150), 2), H * 0.45);        // Zapfentiefe

// ---- Zaunfeld ----
zb   = tf + max(sc(40), 0.5);                // Unterkante Feld über Krone
zt   = Hz - max(sc(100), 1);                 // Oberkante
t_fr = max(sc(30), 1.0);                     // Rahmen/Seile (Druckhöhe)
t_ms = max(sc(12), 0.6);                     // Geflecht (Druckhöhe)
w_top = max(sc(60), 1.4);                    // Oberrohr
w_sei = max(sc(20), duese * 1.5);            // Seil
w_dr  = max(sc(5), duese * 1.1);             // Draht
pm    = max(sc(masche_mm), 2.5 + w_dr);      // Maschenweite
n_v   = max(1, ceil((zt - zb) / (usable - 2)));   // Teilfelder übereinander
h_v   = (zt - zb) / n_v;
function tf_z0(k) = zb + k * h_v;
function tf_z1(k) = zb + (k + 1) * h_v - (k < n_v - 1 ? spiel * 2 : 0);
// Stifthöhen eines Teilfelds: unten, Seile, oben
function seil_z() = [for (i = [1 : 1 : seile]) zb + (zt - zb) * i / (seile + 1)];
function pin_z(k) = let(z0 = tf_z0(k), z1 = tf_z1(k), m = max(w_top, hole_d) / 2 + 0.3)
    concat([z0 + m], [for (z = seil_z()) if (z > z0 + m + hole_d + 1 && z < z1 - m - hole_d - 1) z], [z1 - m]);
ALL_PZ = [for (k = [0 : n_v - 1]) each pin_z(k)];

// =====================================================================
//  Hilfen & Teilung (wie in den anderen Dateien)
// =====================================================================
module box3(x0, y0, z0, x1, y1, z1) translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);
module bar(p, q, w) hull() { translate(p) circle(d = w, $fn = 12); translate(q) circle(d = w, $fn = 12); }
module bowtie_2d() polygon([[-cL / 2, -cw1 / 2], [0, -cw0 / 2], [cL / 2, -cw1 / 2], [cL / 2, cw1 / 2], [0, cw0 / 2], [-cL / 2, cw1 / 2]]);
module clip() linear_extrude(ch) bowtie_2d();
module clip_cut(rot) rotate([0, 0, rot]) {
    translate([0, 0, -1]) linear_extrude(ch + spiel + 1) offset(delta = spiel) bowtie_2d();
    translate([0, 0, -1]) linear_extrude(1.3) offset(delta = spiel + 0.3) bowtie_2d();
}
module rb_slot() {
    w0 = cw0 / 2 + spiel; w1 = cw1 / 2 + spiel; l = cL / 2 + spiel;
    pts = [[-1, -w0], [0, -w0], [l, -w1], [l, w1], [0, w0], [-1, w0]];
    translate([0, 0, -e]) linear_extrude(ch + spiel + e) polygon(pts);
    translate([0, 0, -e]) linear_extrude(0.3 + e) offset(delta = 0.3) polygon(pts);
}
function bad_at(v, bads) = len([for (b = bads) if (v > b[0] && v < b[1]) 1]) > 0;
function seam_pick(t, bads, lo, hi, k = 0) = k > 4000 ? t :
    let(d = (k % 2 == 0 ? 1 : -1) * floor((k + 1) / 2) * 0.5, v = t + d)
    (v > lo && v < hi && !bad_at(v, bads)) ? v : seam_pick(t, bads, lo, hi, k + 1);
function seams_at(S, bads, margin) = let(n = max(1, ceil(S / usable))) [for (k = [1 : 1 : n - 1]) seam_pick(k * S / n, bads, margin, S - margin)];

// =====================================================================
//  BARRIERE  (lokal: x = 0..L, y quer, z hoch)
// =====================================================================
// Pfostenpositionen relativ zum Elementanfang (inkl. der Fugenpfosten)
POST_X = [for (j = [0 : m_pe]) j * PP - g_el / 2];
SLOT_X = [for (px = POST_X, sg = [-1, 1]) let(c = px + sg * a_pin) if (c - w_pin / 2 > 0 && c + w_pin / 2 < L) c];
sl_w = max(sc(600), 2.5); sl_h = max(sc(100), 0.8);
SL_X = staplertaschen && L > 4 * sl_w ? [for (q = [0.25, 0.75]) let(x0 = q * L) seam_pick(x0, [for (c = SLOT_X) [c - sl_w, c + sl_w]], sl_w, L - sl_w)] : [];
module barriere_roh() {
    difference() {
        rotate([90, 0, 90]) linear_extrude(L) profil_2d();
        for (c = SLOT_X) box3(c - w_pin / 2 - spiel, y_p - t_p / 2 - spiel, H - dp - 0.2, c + w_pin / 2 + spiel, y_p + t_p / 2 + spiel, H + 1);
        for (x = SL_X) translate([x, 0, 0]) rotate([90, 0, 0]) linear_extrude(B + 4, center = true)
            polygon([[-sl_w / 2, -1], [sl_w / 2, -1], [sl_w / 2, sl_h], [0, sl_h + sl_w / 2], [-sl_w / 2, sl_h]]);
        if (rennbahn_clips) { rb_slot(); translate([L, 0, 0]) rotate([0, 0, 180]) rb_slot(); }
        // Kantenfasen an den Stirnseiten
        fs = max(sc(25), 0.3);
        for (x = [0, L]) translate([x, 0, H]) rotate([0, 45, 0]) cube([fs * 1.41, B + 4, fs * 1.41], center = true);
    }
}
// Teilung zu langer Elemente (Clips von unten, nicht unter Taschen/Schlitzen)
BAR_XS = L > usable ? seams_at(L, concat([for (x = SL_X) [x - sl_w, x + sl_w]], [for (c = SLOT_X) [c - w_pin - spw, c + w_pin + spw]]), spw) : [];
module barriere_teile(stk) {
    n = len(BAR_XS) + 1;
    for (k = [0 : n - 1]) if (stk == 0 || stk == k + 1) {
        x0 = k == 0 ? -10 : BAR_XS[k - 1] + gap; x1 = k == n - 1 ? L + 10 : BAR_XS[k] - gap;
        translate(stk == 0 ? [k * 8, 0, 0] : [-(k == 0 ? 0 : BAR_XS[k - 1]), 0, 0]) difference() {
            intersection() { barriere_roh(); box3(x0, -100, -1, x1, 100, H + 10); }
            if (k > 0)     translate([BAR_XS[k - 1], (y_tt + min([for (p = PROF) p[0]])) / 2, 0]) clip_cut(0);
            if (k < n - 1) translate([BAR_XS[k], (y_tt + min([for (p = PROF) p[0]])) / 2, 0]) clip_cut(0);
        }
    }
}

// =====================================================================
//  PFOSTEN  (2D in x, z; z = 0 auf der Krone; Dicke t_p quer)
//  art: "fuge" (zwei Zapfen über der Fuge), "ende" (ein Zapfen, +x),
//       "mitte" (zwei Zapfen, beide im selben Element)
// =====================================================================
lg = max(sc(350), 3);                        // Gabelzinken
function pfo_pins(art) = art == "ende" ? [a_pin] : [-a_pin, a_pin];
P_RUNGS = [for (z = [tf + sc(600, 6) : sc(600, 6) : Hz - sc(300, 3)]) if (min([for (pz = ALL_PZ) abs(pz - z)]) > hole_d + rung_h) z];
module pfosten_2d(art, pads = []) {
    pins = pfo_pins(art);
    fx0 = art == "ende" ? -W_p / 2 - 0.5 : -a_pin - w_pin / 2;
    fx1 = a_pin + w_pin / 2;
    difference() {
        union() {
            translate([fx0, 0]) square([fx1 - fx0, tf]);                                       // Fußplatte
            for (c = pins) translate([c - w_pin / 2, -dp]) square([w_pin, dp + e]);              // Zapfen
            for (sg = [-1, 1]) translate([sg * u_o - W_u / 2, 0]) square([W_u, Hz]);              // Rohre
            for (z = P_RUNGS) translate([-u_o, z - rung_h / 2]) square([2 * u_o, rung_h]);        // Querbleche
            for (sg = [-1, 1]) if ((sg < 0 ? fx0 : fx1) * sg > W_p / 2 + 0.5)                      // Knotenbleche
                polygon([[sg * (W_p / 2 - e), tf - e], [sg * min(abs(sg < 0 ? fx0 : fx1), W_p / 2 + sc(200, 2)), tf - e], [sg * (W_p / 2 - e), tf + sc(250, 2.5)]]);
            if (gabelkopf) for (sg = [-1, 1]) bar([sg * u_o, Hz - W_u / 2], [sg * (u_o + lg * sin(18)), Hz + lg * cos(18)], W_u * 0.8);
            for (r = pads) translate([r[0], r[1]]) square([r[2] - r[0], r[3] - r[1]]);
        }
        for (sg = [-1, 1], z = ALL_PZ) translate([sg * u_o, z]) circle(d = hole_d);
    }
}
p_zmin = -dp; p_zmax = Hz + (gabelkopf ? lg * cos(18) + W_u : 0);
P_YS = p_zmax - p_zmin > usable ? seams_at(p_zmax - p_zmin, [for (z = ALL_PZ) [z - hole_d - spw - p_zmin, z + hole_d + spw - p_zmin]], spw - p_zmin + tf) : [];
P_PADS = [for (v = P_YS) [-W_p / 2, v + p_zmin - spw / 2, W_p / 2, v + p_zmin + spw / 2]];
module pfosten_druck(art, stk) {
    xo = a_pin + w_pin / 2 + 1;
    n = len(P_YS) + 1;
    for (k = [0 : n - 1]) if (stk == 0 || stk == k + 1) {
        y0 = k == 0 ? -500 : P_YS[k - 1] + gap; y1 = k == n - 1 ? 1000 : P_YS[k] - gap;
        translate(stk == 0 ? [0, k * 8, 0] : [0, -(k == 0 ? 0 : P_YS[k - 1]), 0]) difference() {
            intersection() {
                linear_extrude(t_p) translate([xo, -p_zmin]) pfosten_2d(art, P_PADS);
                translate([-10, y0, -1]) cube([1000, y1 - y0, 100]);
            }
            if (k > 0)     translate([xo, P_YS[k - 1], 0]) clip_cut(90);
            if (k < n - 1) translate([xo, P_YS[k], 0]) clip_cut(90);
        }
    }
}
module pfosten_welt(art, x0) translate([x0, y_p + t_p / 2, H]) rotate([90, 0, 0]) linear_extrude(t_p) pfosten_2d(art, P_PADS);

// =====================================================================
//  ZAUNFELD  (lokal: x von Pfostenmitte 0 bis PP, y = Höhe; z = Dicke,
//            z = 0 Fahrbahnseite, Stifte zeigen nach +z)
// =====================================================================
fx_a = u_o - W_u / 2; fx_b = PP - u_o + W_u / 2;   // Feldbreite (über beide Rohre)
module geflecht_2d(x0, x1, y0, y1) {
    intersection() {
        translate([x0, y0]) square([x1 - x0, y1 - y0]);
        if (masche == "raute") {
            th = 60;                                     // Rautenwinkel (hochkant)
            dx = pm / sin(th);
            n = ceil((x1 - x0 + (y1 - y0) / tan(th)) / dx) + 2;
            for (sg = [-1, 1], i = [-n : n]) translate([(x0 + x1) / 2 + i * dx, (y0 + y1) / 2]) rotate(sg * th) square([w_dr, 4 * (y1 - y0 + x1 - x0)], center = true);
        } else if (masche == "quadrat") {
            for (x = [x0 : pm : x1]) translate([x - w_dr / 2, y0]) square([w_dr, y1 - y0]);
            for (y = [y0 : pm : y1]) translate([x0, y - w_dr / 2]) square([x1 - x0, w_dr]);
        }
    }
}
module zaunfeld_teil(k) {
    z0 = tf_z0(k); z1 = tf_z1(k);
    pins = pin_z(k);
    // Rahmen: Pfostenleisten, unten, oben, Seile
    linear_extrude(t_fr) {
        for (x = [fx_a, fx_b - W_u]) translate([x, z0]) square([W_u, z1 - z0]);
        translate([fx_a, z0]) square([fx_b - fx_a, k == 0 ? w_sei * 1.5 : w_sei]);
        translate([fx_a, z1 - (k == n_v - 1 ? w_top : w_sei)]) square([fx_b - fx_a, k == n_v - 1 ? w_top : w_sei]);
        for (z = seil_z()) if (z > z0 + w_sei && z < z1 - w_sei) translate([fx_a, z - w_sei / 2]) square([fx_b - fx_a, w_sei]);
    }
    linear_extrude(t_ms) geflecht_2d(fx_a + W_u - e, fx_b - W_u + e, z0, z1);
    // Steckstifte in die Pfosten
    for (x = [u_o, PP - u_o], z = pins) translate([x, z, t_fr - e]) cylinder(d = pd, h = t_p - 0.3 + e, $fn = 16);
}
module zaunfeld_druck(stk) {
    for (k = [0 : n_v - 1]) if (stk == 0 || stk == k + 1)
        translate(stk == 0 ? [0, k * 5, 0] : [0, -tf_z0(k), 0]) translate([-fx_a, 0, 0]) zaunfeld_teil(k);
}
// Welt: Feld zwischen Pfosten bei x0 und x0 + PP, vor dem Pfosten (Fahrbahnseite)
module zaunfeld_welt(x0) translate([x0, y_p + t_p / 2 + t_fr, H]) rotate([90, 0, 0]) for (k = [0 : n_v - 1]) zaunfeld_teil(k);

// =====================================================================
//  Reihe (Vorschau)
// =====================================================================
C_BETON = "#cfcac0"; C_STAHL = "#a9b0b6"; C_DRAHT = "#c9ced3";
module reihe(n) {
    for (i = [0 : n - 1]) translate([i * PE, 0, 0]) {
        color(C_BETON) barriere_roh();
        for (j = [0 : m_pe]) {
            px = j * PP - g_el / 2;
            art = j == 0 ? (i == 0 ? "ende_l" : "fuge") : j == m_pe ? (i == n - 1 ? "ende_r" : "none") : "mitte";
            if (art == "fuge" || art == "mitte") color(C_STAHL) pfosten_welt(art, px);
            if (art == "ende_l") color(C_STAHL) pfosten_welt("ende", px + 0);
            if (art == "ende_r") color(C_STAHL) translate([px, 0, 0]) mirror([1, 0, 0]) translate([-px, 0, 0]) pfosten_welt("ende", px);
            if (j < m_pe) color(C_DRAHT) zaunfeld_welt(px);
        }
    }
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
echo(str("Barriere 1:", den, " | ", profil, " L × B × H = ", r2(L), " × ", r2(B), " × ", r2(H), " mm",
         widen > 0 ? str(" (Krone auf ", r2(top_need), " mm verbreitert)") : ""));
echo(str("Zaun: Höhe ", r2(Hz), " mm über Krone, Pfostenabstand ", r2(PP), " mm (", m_pe, " Feld(er) je Element), Felder ", n_v > 1 ? str(n_v, " Teilfelder übereinander") : "einteilig",
         ", Masche ", r2(pm), " mm, Draht ", r2(w_dr), " mm"));
echo(str("Je Element: 1 Pfosten auf jeder Fuge", m_pe > 1 ? str(" + ", m_pe - 1, " Zwischenpfosten") : "", ", ", m_pe, " Zaunfeld(er) | Reihenenden: Endpfosten"));
if (len(BAR_XS) > 0) echo(str("Barriere wird in ", len(BAR_XS) + 1, " Stücke geteilt (", len(BAR_XS), " Clips)"));
if (len(P_YS) > 0) echo(str("Pfosten wird in ", len(P_YS) + 1, " Stücke geteilt (", len(P_YS), " Clips)"));
if (pm < 3 * w_dr) echo("WARNUNG: Geflecht sehr dicht – masche_mm erhöhen.");

if (teil == "reihe") reihe(anzahl);
else if (teil == "barriere") barriere_teile(stueck);
else if (teil == "pfosten") pfosten_druck("fuge", stueck);
else if (teil == "endpfosten") pfosten_druck("ende", stueck);
else if (teil == "zwischenpfosten") pfosten_druck("mitte", stueck);
else if (teil == "zaunfeld") zaunfeld_druck(stueck);
else if (teil == "verbinder") for (i = [0 : 5]) translate([(i % 3) * (cL + 3), floor(i / 3) * (cw1 + 3), 0]) clip();
