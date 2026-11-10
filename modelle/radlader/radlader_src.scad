// =====================================================================
//  RADLADER  –  knickgelenkter Radlader der 30-t-Klasse mit Z-Kinematik
//  Vorbild: Cat 980 (Radstand 3,8 m, Reifen Ø 1,87 m, Schaufel 3,45 m breit)
//  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei), Farben je Bauteil,
//  Maßstab 1:43 / 1:87.  Knicklenkung, drehbare Räder, Hubgerüst mit zwei Hubzylindern,
//  Schaufel mit Z-Kinematik (Kipphebel, Koppel, Kippzylinder) – die teleskopischen
//  Hydraulikzylinder fahren mit und halten jede Stellung.
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    hinterwagen     Rahmen des Hinterwagens mit Gegengewicht und Steckzapfen          1x
//    aufbau          Plattform mit Kotflügeln, Motorhaube, Auspuff und Gelenkbock      1x
//    kuehlergrill    Kühlergrill, von hinten in die Motorhaube gesteckt                1x
//    kabine          Fahrerkabine (unten offen) + Glaskern von unten                   1x
//    vorderwagen     Vorderrahmen mit Hubgerüst-Turm und Gelenksäule                   1x
//    knickbolzen     Bolzen des Knickgelenks mit Senkkopf (von unten gesteckt)         1x
//    achse           Vierkant-Achse, durch den Rahmen gesteckt                         2x
//    rad             Reifen (A) + Felge (B)                                            4x
//    hubarm          Hubarm (flach)                                                    2x
//    querrohr        Distanzrohr auf dem Bolzen des Kipphebels                         2x
//    kipphebel       Kipphebel der Z-Kinematik (flach)                                 2x
//    koppel          Koppelstange vom Kipphebel zur Schaufel (flach)                   1x
//    zylinder_hub    Hubzylinder: Rohr (A) + Kolbenstange (B)                          2x
//    zylinder_kipp   Kippzylinder: Rohr (A) + Kolbenstange (B)                         1x
//    schaufel        Schaufel mit Zähnen und Lageraugen (Boden auf dem Bett)           1x
//    leiter          Aufstiegsleiter (flach), von unten in die Plattform               2x
//    handlauf        Handlauf (flach), in Schlitze der Plattform                       2x
//    spiegel         Außenspiegel (flach), in Schlitze im Kabinendach                  2x
//    kotfluegel      Kotflügel vorne (flach), Zunge in das Fenster im Turm             2x
//    leuchte         Arbeitsscheinwerfer (flach), auf Kotflügel und Kabinendach        4x
//
//  BOLZEN
//    Filament-Stücke Ø stift_d (Längen siehe Echo).
//  BEWEGLICH
//    * Knicklenkung: Vorderwagen schwenkt um den Knickbolzen.
//    * Räder drehen auf den Vierkant-Achsen.
//    * Hubgerüst und Schaufel schwenken an Bolzen; die Kolbenstangen gleiten in den
//      Rohren und halten die Stellung durch Reibung (zylinder_spiel).
//  DRUCK
//    Alle Teile stützfrei: Rahmen, Aufbau und Schaufel aufrecht, Kabine kopfüber,
//    Hubarme, Hebel, Koppel, Leitern, Handläufe und Spiegel flach, Zylinder und Achsen liegend.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, hinterwagen:Hinterwagen, oberbau:Aufbau mit Motorhaube, kuehlergrill:Kühlergrill, kabine:Kabine mit Glaskern, vorderwagen:Vorderwagen, knickbolzen:Knickbolzen, achse:Achse (2x), rad:Rad (4x), hubarm:Hubarm (2x), querrohr:Distanzrohr (2x), kipphebel:Kipphebel (2x), koppel:Koppelstange, zylinder_hub:Hubzylinder (2x), zylinder_kipp:Kippzylinder, schaufel:Schaufel, leiter:Leiter (2x), handlauf:Handlauf (2x), spiegel:Außenspiegel (2x), kotfluegel:Kotflügel vorne (2x), leuchte:Arbeitsscheinwerfer (4x)]
stueck = 0;
farbteil = "alle"; // [alle, A, B]

/* [Vorschau] */
// Knickwinkel der Lenkung
knick = 0; // [-35:5:35]
// Hubgerüst: 0 = Schaufel am Boden, 100 = ganz oben
hub = 8; // [0:1:100]
// Schaufel: 0 = waagerecht, positiv = eingekippt, negativ = ausgekippt
schaufel_winkel = 12; // [-42:1:40]

/* [Radlader (Vorbild in Metern)] */
radstand_m = 3.8;
spur_m = 2.44;
rad_d_m = 1.87;
rad_b_m = 0.75;
felge_d_m = 0.95;
breite_m = 3.2;
kabine_hoehe_m = 3.75;
schaufel_breite_m = 3.45;
// Länge der Hubarme (Lager am Turm bis Schaufelbolzen)
hubarm_m = 3.1;

/* [Farben] */
farbe_gelb      = "catgelb";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_rahmen    = "catgelb";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_reifen    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_felge     = "catgelb";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_achse     = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_kabine    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_glas      = "puderblau"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_schaufel  = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_zylinder  = "catgelb";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_stange    = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_grill     = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_leuchte   = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_anbau     = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]

/* [Druck & Passung] */
rennbahn_taschen = true;   // (keine Bodenplatte – bleibt für die Bibliothek stehen)
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;
stift_d = 1.75;
// Luft je Seite zwischen Kolbenstange und Rohr (klein = Stellung hält besser)
zylinder_spiel = 0.1;
// Luft je Seite für eingepresste Teile (Zapfen, Achsen, Glaskern, Grill; 0 = sehr stramm)
einsatz_spiel = 0.05;

include <../../lib/deko_grundlagen.scad>

// =====================================================================
//  Maße (Welt: x = 0 Knickgelenk, +x nach vorne, +y links, z = 0 Boden; mm)
// =====================================================================
function K(m) = m * 1000 / den;
function KP(p) = [K(p[0]), K(p[1])];
function rot2(p, a) = [p[0] * cos(a) - p[1] * sin(a), p[0] * sin(a) + p[1] * cos(a)];
es    = einsatz_spiel;
zyl_r_s_min = 1.0;                          // schlanke Zylinder, damit Turm, Hubzylinder und Hubarme zwischen die Räder passen
zyl_wand_min = 0.9;
include <../../lib/deko_hydraulik.scad>
d_p   = max(M(0.16), 2.0);                  // Steckzapfen (Raute)

// Räder und Achsen
R_w   = K(rad_d_m / 2);  z_ax = R_w;
B_w   = K(rad_b_m);
R_fe  = K(felge_d_m / 2);
y_ri  = K(spur_m / 2) - B_w / 2;            // Innenseite der Reifen
X_va  = K(radstand_m / 2);
d_rz  = max(M(0.3), 3);                     // Achse: Vierkant, in der Welt als Raute (Diagonale d_rz)
a_az  = d_rz / sqrt(2);
t_nb  = B_w - max(M(0.08), 0.8);            // Nabenloch-Tiefe
l_ax  = 2 * (y_ri + t_nb - 0.4);

// Höhen
Z_b   = K(0.55);                            // Unterkante der Rahmen
Z_pl  = K(1.95);                            // Unterkante Plattform = Oberkante Hinterwagen
t_pl  = max(M(0.13), 1.8);
Z_pt  = Z_pl + t_pl;
Z_hd  = K(2.95);                            // Motorhaube vorne
Z_hh  = K(2.6);                             // Motorhaube am Heck

// Breiten-Staffelung: Turm – Hubzylinder – Hubarm
w_z   = hz + r_o;                           // Breite eines liegenden Zylinderrohrs (Achse hz über der flachen Seite)
t_sl  = w_z + 2 * spiel;                    // Schlitz für den Kippzylinder
t_ch  = max(M(0.12), 1.6);                  // Wangen des Turms
t_a   = max(M(0.12), 1.5);                  // Hubarm
Y_t   = max(t_sl / 2 + t_ch, K(0.775) - t_a - 2 * spiel - w_z);
Y_hz  = Y_t + spiel + hz;                   // Achse des linken Hubzylinders
function y_hz(s) = s > 0 ? Y_hz : -(Y_t + spiel + r_o);   // rechts liegt die flache Seite außen
y_zk  = -(r_o - hz) / 2;                    // Kippzylinder: Rohr mittig im Schlitz
Y_a0  = Y_t + w_z + 2 * spiel;
Y_a1  = Y_a0 + t_a;
t_gs  = max(M(0.08), 1.4);                  // Kipphebel
t_mi  = max(2 * hs, 1.2);                   // Koppel (zwischen den Hebeln)
Y_hb  = t_mi / 2 + spiel + (r_o - hz) / 2;                   // Innenseite Kipphebel / Schaufelaugen
t_ohr = max(M(0.1), 1.6);

// Kinematik (Schwenkebene x-z, Vorbild-Meter)
A_m   = [1.0, 2.3];                         // Hubarm-Lager am Turm
F_m   = [1.0, 1.65];                        // Hubzylinder-Fuß am Turm
KF_m  = [0.925, 2.725];                     // Kippzylinder-Fuß im Turm
P_m   = [1.95, 0.35];                       // Hubzylinder am Hubarm (lokal Arm)
Kn_m  = [2.0, 0.6];                         // Knie des Hubarms
Lp_m  = [2.23, 0.83];                       // Lager des Kipphebels (lokal Arm)
r1_m  = 0.915;                              // Kipphebel unten (zur Koppel)
r2_m  = 0.65;                               // Kipphebel oben (zum Kippzylinder)
bend  = -22.6;                              // Knick des Kipphebels
l_kp_m = 0.604;                             // Koppel
// Schaufel (lokal = Druck: Schneide im Ursprung, Boden auf z = 0, Rückwand bei -x)
BL_m  = [-1.418, 0.288];                    // Schaufelbolzen
QL_m  = BL_m + [-0.02, 0.424];              // Koppel-Auge
A_p = KP(A_m); F_p = KP(F_m); KF_p = KP(KF_m); P_p = KP(P_m); Kn_p = KP(Kn_m); Lp_p = KP(Lp_m);
B_a = [K(hubarm_m), 0]; BL_p = KP(BL_m); QL_p = KP(QL_m); Qo_p = QL_p - BL_p;
r1 = K(r1_m); r2 = K(r2_m); l_kp = K(l_kp_m);
// Schwenkbereiche: Hubarm t (Winkel der Linie Lager–Schaufelbolzen), Schaufel b (0 = waagerecht)
t_min = -asin((A_m[1] - BL_m[1]) / hubarm_m);
t_max = 36;
function bmin(t) = t < -24 ? 0 : -42;
g_max = 64;                                 // größter Winkel Schaufel zu Hubarm (Rückwand vor dem Kipphebel-Lager)
function bmax(t) = min(40 - max(0, t) * 0.75, g_max + t);
// Gelenke im Arm-Rahmen für den Winkel g = b - t der Schaufel zum Arm
function Q_a(g) = B_a + rot2(Qo_p, g);
function Lb_a(g) = let(Q = Q_a(g), d = norm(Q - Lp_p), e = (Q - Lp_p) / d, a = (r1 * r1 - l_kp * l_kp + d * d) / (2 * d), h = sqrt(max(r1 * r1 - a * a, 0)))
    Lp_p + a * e + h * [e[1], -e[0]];
function Lt_a(g) = Lp_p + rot2(-(Lb_a(g) - Lp_p) * r2 / r1, bend);
function Lt_w(t, b) = A_p + rot2(Lt_a(b - t), t);
function P_w(t) = A_p + rot2(P_p, t);
function L_hub(t) = norm(P_w(t) - F_p);
function L_kipp(t, b) = norm(Lt_w(t, b) - KF_p);
TT = [for (i = [0 : 24]) t_min + i * (t_max - t_min) / 24];
LH = [for (t = TT) L_hub(t)];
LK = [for (t = TT, j = [0 : 12]) L_kipp(t, bmin(t) + j * (bmax(t) - bmin(t)) / 12)];
ZH = [min(LH), max(LH)];
ZK = [min(LK), max(LK)];

// Vorderwagen
X_f0  = K(0.45);                            // Rückseite
r_kb  = max(M(0.11), 1.3);                  // Knickbolzen
h_kk  = max(M(0.1), 1.2);                   // Senkkopf
r_gp  = max(K(0.3), r_kb + h_kk + 1.0);     // Gelenksäule
Z_gp  = Z_pl - max(M(0.04), 0.4);
Z_bk  = Z_pt + K(0.42);                     // Gelenkbock auf der Plattform
// Hinterwagen
X_c1  = -r_gp - max(M(0.1), 0.9);           // Vorderkante
X_g0  = -K(4.35);                           // Heck
X_g1  = -K(radstand_m / 2) - R_w - max(M(0.12), 1.2);   // Gegengewicht hinter den Reifen
Y_ch  = y_ri - max(M(0.06), 0.5);
Y_g   = K(1.45);
Y_pl  = K(breite_m / 2);
X_hd0 = -K(4.3);  X_hd1 = -K(1.82);  Y_hd = K(1.0);
h_pg  = t_pl;                               // Steckzapfen Hinterwagen -> Aufbau
PG    = [[-K(3.6), K(0.5)], [-K(3.6), -K(0.5)], [-K(1.0), K(0.42)], [-K(1.0), -K(0.42)]];
d_e   = max(M(0.08), 1.0);                  // Tiefe der Grill-Tasche
GZ    = [K(2.12), K(2.46)];  GY = K(0.8);
// Kabine
K_X   = [X_c1 - max(M(0.03), 0.3) - K(1.36), X_c1 - max(M(0.03), 0.3)];
K_Y   = [-K(0.8), K(0.8)];
K_Z   = [Z_pt, K(kabine_hoehe_m)];
t_k   = max(M(0.08), 1.2);
t_kr  = max(M(0.1), 1.2);
p_k   = max(M(0.22), d_p + 1.6);
c_kd  = M(0.12);
// Schaufel
W_s   = K(schaufel_breite_m);
t_bk  = max(M(0.07), 1.2);
// Anbauteile
b_hl = max(M(0.05), 0.9);  t_hl = max(M(0.05), 1.2);  l_tb = t_pl;
L_hl = K(1.25);  H_hl = K(1.0);
HL = [[-K(1.7), K(1.5)], [-K(1.7), -K(1.5)]];                 // Handläufe [x0, y]
X_le = -K(0.68);  Y_le = [K(0.92), K(1.42)];  Z_le0 = K(0.45);   // Leitern
// Kotflügel vorne (flach, Zunge in ein Fenster im Turm) und Arbeitsscheinwerfer
t_kf = t_pl;  Z_kf = K(2.0);
KT_X = [K(0.56), K(0.74)];                  // Zunge / Fenster im Turm
X_kf1 = K(1.75);  Y_kf = [y_ri, K(1.55)];
t_le = max(M(0.12), 1.2);                   // Scheinwerfer
LE = [[K(1.5), K(1.1), Z_kf + t_kf], [K(1.5), -K(1.1), Z_kf + t_kf], [K_X[0] + p_k / 2, K_Y[1] - p_k / 2, K_Z[1]], [K_X[0] + p_k / 2, K_Y[0] + p_k / 2, K_Z[1]]];
r_qr = max(M(0.11), stift_d / 2 + 0.9);
l_qr = Y_a0 - Y_hb - t_gs - 0.3;

include <../../lib/deko_hilfen.scad>
include <../../lib/deko_rad.scad>

// =====================================================================
//  Hilfen
// =====================================================================
module raute2(d) rotate(45) square(d / sqrt(2), center = true);
module xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 8) children();    // 2D (x,z) entlang y
module yz(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0, convexity = 8) children();   // 2D (y,z) entlang x
module hole_y(p, r, y0, y1) xz(y0, y1) translate(p) rotate(90) teardrop(r);
module bunt(f) color(fhex(f)) render(convexity = 8) children();
module rstift(d, h) let(c = min(0.4, d * 0.2)) { linear_extrude(h - c + 0.01) raute2(d); translate([0, 0, h - c]) linear_extrude(c, scale = (d - 2 * c) / d) raute2(d); }
module ci(p, r) translate(p) circle(r = r, $fn = 40);
module kasten(x0, x1, y, z0, z1, c) hull() {   // Kasten mit gefaster Oberkante
    translate([x0, -y, z0]) cube([x1 - x0, 2 * y, z1 - z0 - c]);
    translate([x0 + c, -y + c, z0]) cube([x1 - x0 - 2 * c, 2 * (y - c), z1 - z0]);
}
// flaches Teil (2D, Dicke t) zwischen zwei Punkten der Schwenkebene; y0 = Seite zur Mitte
module flach_zw(P, Q, y0, t) let(d = (Q - P) / norm(Q - P))
    multmatrix([[d[0], -d[1], 0, P[0]], [0, 0, -1, y0 + t], [d[1], d[0], 0, P[1]], [0, 0, 0, 1]]) linear_extrude(t, convexity = 6) children();

// =====================================================================
//  Hinterwagen (Welt; gedruckt aufrecht)
// =====================================================================
module hinterwagen_welt() difference() {
    union() {
        translate([X_g0 + K(0.1), -Y_ch, Z_b]) cube([X_c1 - X_g0 - K(0.1), 2 * Y_ch, Z_pl - Z_b]);
        // Gegengewicht hinter den Reifen (Unterseite 45°)
        hull() {
            translate([X_g0 + K(0.1), -Y_ch, Z_b]) cube([X_g1 - X_g0 - K(0.1), 2 * Y_ch, Z_pl - Z_b]);
            for (s = [-1, 1]) translate([X_g0 + K(0.3), s * (Y_g - K(0.3)), Z_b + Y_g - Y_ch]) cylinder(r = K(0.3), h = Z_pl - Z_b - (Y_g - Y_ch), $fn = 32);
            translate([X_g1 - 1, -Y_g, Z_b + Y_g - Y_ch]) cube([1, 2 * Y_g, Z_pl - Z_b - (Y_g - Y_ch)]);
        }
        for (p = PG) translate([p[0], p[1], Z_pl - 0.01]) rstift(d_p, h_pg + 0.01);
    }
    xz(-Y_ch - 1, Y_ch + 1) translate([-X_va, z_ax]) raute2(d_rz + 2 * es);
    // Fugen des Gegengewichts
    let(dg = max(M(0.03), 0.4)) for (s = [-1, 1]) translate([X_g1 - K(0.45), s > 0 ? Y_g - dg : -Y_g - 1, Z_b]) cube([max(M(0.03), 0.5), dg + 1, Z_pl]);
}
module hinterwagen_druck() translate([0, 0, -Z_b]) hinterwagen_welt();

// =====================================================================
//  Aufbau: Plattform, Kotflügel, Motorhaube, Gelenkbock (Welt; gedruckt aufrecht)
// =====================================================================
function kab_pins() = [for (x = [K_X[0] + p_k / 2, K_X[1] - p_k / 2], y = [K_Y[0] + p_k / 2, K_Y[1] - p_k / 2]) [x, y]];
module plattform_2d() let(r = K(0.35), c = K(0.25)) hull() {
    for (s = [-1, 1]) ci([X_g0 + r, s * (Y_pl - r)], r);
    translate([X_c1 - c - 0.01, -Y_pl]) square([0.01, 2 * Y_pl]);
    translate([X_c1 - 0.01, -Y_pl + c]) square([0.01, 2 * (Y_pl - c)]);
}
module schlitz_pl(x, y, lx, ly) translate([x - lx / 2 - es, y - ly / 2 - es, Z_pl - 1]) cube([lx + 2 * es, ly + 2 * es, t_pl + 2]);
module gr_tasche_2d(o) polygon([[X_hd0 - 1, GZ[0] - o], [X_hd0 + d_e + o, GZ[0] - o], [X_hd0 + d_e + o, GZ[1] - d_e + o], [X_hd0, GZ[1] + o + 0.01], [X_hd0 - 1, GZ[1] + o + 0.01]]);
module gr_einsatz_2d() polygon([[X_hd0 + es, GZ[0] + es], [X_hd0 + d_e - es, GZ[0] + es], [X_hd0 + d_e - es, GZ[1] - d_e - es * 0.4], [X_hd0 + es, GZ[1] - es * 2.4]]);
module aufbau_welt() difference() {
    c = M(0.12);
    union() {
        translate([0, 0, Z_pl]) linear_extrude(t_pl, convexity = 6) plattform_2d();
        // Motorhaube: Oberseite fällt als ebene Fläche nach hinten ab, Kanten gefast
        hull() {
            translate([X_hd0, -Y_hd, Z_pt - 0.01]) cube([X_hd1 - X_hd0, 2 * Y_hd, Z_hh - c - Z_pt]);
            translate([X_hd1 - 0.01, -Y_hd, Z_pt]) cube([0.01, 2 * Y_hd, Z_hd - c - Z_pt]);
            translate([X_hd1 - 0.01, -Y_hd + c, Z_pt]) cube([0.01, 2 * (Y_hd - c), Z_hd - Z_pt]);
            translate([X_hd0 + c, -Y_hd + c, Z_pt]) cube([0.01, 2 * (Y_hd - c), Z_hh - Z_pt]);
        }
        // Auspuff und Vorabscheider
        translate([-K(2.5), K(0.4), K(2.8)]) cylinder(r = max(M(0.09), 1.0), h = K(0.75), $fn = 20);
        translate([-K(2.15), -K(0.45), K(2.85)]) { cylinder(r = max(M(0.07), 0.9), h = K(0.35), $fn = 20); translate([0, 0, K(0.3)]) cylinder(r1 = max(M(0.07), 0.9), r2 = max(M(0.15), 1.5), h = max(M(0.15), 1.5) - max(M(0.07), 0.9) + 0.01, $fn = 24); translate([0, 0, K(0.3) + max(M(0.15), 1.5) - max(M(0.07), 0.9)]) cylinder(r = max(M(0.15), 1.5), h = K(0.14), $fn = 24); }
        // Gelenkbock über dem Knickgelenk
        hull() { translate([0, 0, Z_pl]) cylinder(r = r_gp, h = Z_bk - Z_pl, $fn = 48); translate([X_c1, -r_gp, Z_pl]) cube([1, 2 * r_gp, Z_bk - Z_pl]); }
    }
    // Knickbolzen (stramm)
    translate([0, 0, Z_pl - 1]) cylinder(r = r_kb + es, h = Z_bk, $fn = 40);
    // Zapfen des Hinterwagens: unter der Kabine durchgehend, unter der Haube mit Spitzdach
    for (p = PG) translate([p[0], p[1], Z_pl - 1]) { linear_extrude(h_pg + 1.2) raute2(d_p + 2 * es); if (p[0] < X_hd1) translate([0, 0, h_pg + 1.19]) linear_extrude((d_p + 2 * es) / 2, scale = 0.01) raute2(d_p + 2 * es); }
    for (p = kab_pins()) translate([p[0], p[1], Z_pl - 1]) linear_extrude(t_pl + 2) raute2(d_p + 2 * es);
    // Schlitze: Handläufe, Leitern
    for (h = HL) for (u = [0, (L_hl - b_hl) / 2, L_hl - b_hl]) schlitz_pl(h[0] + u + b_hl / 2, h[1], b_hl, t_hl);
    for (s = [-1, 1], y = [Y_le[0] + b_hl / 2, Y_le[1] - b_hl / 2]) schlitz_pl(X_le, s * y, t_hl, b_hl);
    // Grill-Tasche im Heck
    xz(-GY, GY) gr_tasche_2d(0);
    // Lüftungsschlitze und Türfugen an der Haube
    let(n = 8, w = max(M(0.05), 0.6), dg = max(M(0.03), 0.4)) for (s = [-1, 1], i = [0 : n - 1])
        translate([X_hd0 + K(0.5) + i * K(0.15), s > 0 ? Y_hd - dg : -Y_hd - 1, Z_pt + K(0.12)]) cube([w, dg + 1, K(0.3)]);
    let(dg = max(M(0.03), 0.4)) for (s = [-1, 1], x = [X_hd0 + K(1.75), X_hd1 - K(0.12)]) translate([x, s > 0 ? Y_hd - dg : -Y_hd - 1, Z_pt + K(0.08)]) cube([max(M(0.03), 0.5), dg + 1, K(0.5)]);
}
module aufbau_druck() translate([0, 0, -Z_pl]) aufbau_welt();
module grill_welt() difference() {
    xz(-GY + es, GY - es) gr_einsatz_2d();
    let(n = 13, w = max(M(0.05), 0.6)) for (i = [0 : n - 1]) translate([X_hd0 - 1, -GY + K(0.1) + i * (2 * GY - K(0.2) - w) / (n - 1), GZ[0] + K(0.06)]) cube([1 + d_e * 0.5, w, GZ[1] - GZ[0] - d_e - K(0.12)]);
}
module grill_druck() multmatrix([[0, 1, 0, 0], [0, 0, -1, GZ[1]], [-1, 0, 0, X_hd0 + d_e - es], [0, 0, 0, 1]]) grill_welt();

// Kabine (Welt; gedruckt kopfüber, Glaskern von unten)
module kab_aussen() hull() {
    translate([K_X[0], K_Y[0], K_Z[0]]) cube([K_X[1] - K_X[0], K_Y[1] - K_Y[0], K_Z[1] - K_Z[0] - c_kd]);
    translate([K_X[0] + c_kd, K_Y[0] + c_kd, K_Z[0]]) cube([K_X[1] - K_X[0] - 2 * c_kd, K_Y[1] - K_Y[0] - 2 * c_kd, K_Z[1] - K_Z[0]]);
}
module kab_raum(o) difference() {
    translate([K_X[0] + t_k - o, K_Y[0] + t_k - o, K_Z[0] - 1]) cube([K_X[1] - K_X[0] - 2 * t_k + 2 * o, K_Y[1] - K_Y[0] - 2 * t_k + 2 * o, K_Z[1] - K_Z[0] - t_kr + 1 + min(o, 0)]);
    for (p = kab_pins()) translate([p[0] - p_k / 2 - o, p[1] - p_k / 2 - o, K_Z[0] - 2]) cube([p_k + 2 * o, p_k + 2 * o, K_Z[1]]);
}
module kab_fenster() {
    xm = (K_X[0] + K_X[1]) / 2; w2 = max(M(0.08), 1.0); z1 = K_Z[1] - M(0.2);
    // vorne eine hohe Scheibe, hinten kurz, seitlich Tür- und Seitenscheibe
    translate([K_X[1] - t_k - 1, K_Y[0] + p_k, K_Z[0] + M(0.3)]) cube([t_k + 2, K_Y[1] - K_Y[0] - 2 * p_k, z1 - K_Z[0] - M(0.3)]);
    translate([K_X[0] - 1, K_Y[0] + p_k, K_Z[0] + M(0.95)]) cube([t_k + 2, K_Y[1] - K_Y[0] - 2 * p_k, z1 - K_Z[0] - M(0.95)]);
    for (y = [K_Y[0] - 1, K_Y[1] - t_k - 1]) for (xx = [[K_X[0] + p_k, xm - w2 / 2], [xm + w2 / 2, K_X[1] - p_k]])
        translate([xx[0], y, K_Z[0] + M(0.6)]) cube([xx[1] - xx[0], t_k + 2, z1 - K_Z[0] - M(0.6)]);
}
SP = [[K_X[1] - p_k / 2, K_Y[1] - p_k / 2, 1], [K_X[1] - p_k / 2, K_Y[0] + p_k / 2, -1]];   // Spiegel [x, y, Seite]
module schlitz_kab(x, y, lx = t_hl) translate([x - lx / 2 - es, y - b_hl / 2 - es, K_Z[1] - l_tb - 0.3]) cube([lx + 2 * es, b_hl + 2 * es, l_tb + 1.3]);
module kabine_welt(fp) {
    if (inc(fp, "A")) {
        difference() { kab_aussen(); kab_raum(0); kab_fenster(); for (q = SP) schlitz_kab(q[0], q[1]); for (i = [2, 3]) schlitz_kab(LE[i][0], LE[i][1], t_le); }
        for (p = kab_pins()) translate([p[0], p[1], K_Z[0] + 0.01]) rotate([180, 0, 0]) rstift(d_p, t_pl + 0.01);
    }
    if (inc(fp, "B")) intersection() { kab_raum(-es); translate([-K(5), -K(5), K_Z[0]]) cube([K(10), K(10), K_Z[1] - K_Z[0] - t_kr - es]); }
}
module kabine_druck(fp) translate([0, 0, K_Z[1]]) rotate([180, 0, 0]) kabine_welt(fp);

// =====================================================================
//  Vorderwagen: Rahmen mit Turm und Gelenksäule (Welt; gedruckt aufrecht)
// =====================================================================
VW = [[0.45, 0.55], [2.05, 0.55], [2.12, 0.62], [2.12, 1.2], [2.0, 1.32], [1.5, 1.35], [1.3, 1.7], [1.3, 2.5], [1.1, 2.95], [0.6, 2.95], [0.45, 2.8]];
z_sf = A_p[1] + r_h + max(M(0.06), 0.8);    // Boden des Schlitzes (über dem Bolzen der Hubarme)
x_sf = A_p[0] + r_h + max(M(0.06), 0.8);
module vw_2d() polygon([for (p = VW) KP(p)]);
module vw_schlitz_2d() polygon([[K(0.2), z_sf], [x_sf, z_sf], [x_sf + K(0.6), z_sf - K(0.6)], [K(1.8), z_sf - K(0.6)], [K(1.8), K(3.3)], [K(0.2), K(3.3)]]);
module vorderwagen_welt() difference() {
    w_n = 2 * min(Y_t, r_gp * 0.85);
    union() {
        xz(-Y_t, Y_t) vw_2d();
        hull() { translate([0, 0, Z_b]) cylinder(r = r_gp, h = Z_gp - Z_b, $fn = 48); translate([X_f0 - 0.01, -w_n / 2, Z_b]) cube([1, w_n, Z_gp - Z_b]); }
    }
    xz(-t_sl / 2, t_sl / 2) vw_schlitz_2d();
    hole_y(A_p, r_h, -Y_t - 1, Y_t + 1);
    hole_y(F_p, r_pr, -Y_t - 1, Y_t + 1);
    hole_y(KF_p, r_pr, -Y_t - 1, Y_t + 1);
    xz(-Y_t - 1, Y_t + 1) translate([X_va, z_ax]) raute2(d_rz + 2 * es);
    // Fenster für die Zungen der Kotflügel (Decke = kurze Brücke)
    translate([KT_X[0] - es, -Y_t - 1, Z_kf - es]) cube([KT_X[1] - KT_X[0] + 2 * es, 2 * Y_t + 2, t_kf + 2 * es]);
    // Knickbolzen mit Senkkopf von unten
    translate([0, 0, Z_b - 1]) cylinder(r = r_kb + spiel, h = Z_gp, $fn = 40);
    translate([0, 0, Z_b - 0.01]) cylinder(r1 = r_kb + spiel + h_kk, r2 = r_kb + spiel, h = h_kk, $fn = 40);
}
module vorderwagen_druck() translate([0, 0, -Z_b]) vorderwagen_welt();
l_kb = Z_bk - Z_b - 0.3;
module knickbolzen() { cylinder(r1 = r_kb + h_kk - 0.1, r2 = r_kb, h = h_kk - 0.1, $fn = 40); cylinder(r = r_kb, h = l_kb, $fn = 40); }

// Achsen und Räder
module achse_welt(x) translate([x, -l_ax / 2, z_ax]) rotate([-90, 0, 0]) linear_extrude(l_ax) raute2(d_rz);
module achse_druck() let(c = min(0.5, a_az * 0.2)) hull() { cube([l_ax, a_az, a_az - c]); translate([c, 0, 0]) cube([l_ax - 2 * c, a_az, a_az]); }
module rad(fp) reifen_rad(fp, R_w, B_w, R_fe, d_rz, t_nb);
module rad_welt(x, sy, fp, ex = 0) translate([x, sy * (y_ri + ex), z_ax]) rotate([sy > 0 ? -90 : 90, 0, 0]) rad(fp);

// =====================================================================
//  Hubgerüst (lokal Arm: u entlang Lager–Schaufelbolzen, v nach oben)
// =====================================================================
r_au = r_e + max(M(0.03), 0.4);
module hubarm_2d() difference() {
    union() {
        hull() { ci([0, 0], K(0.25)); ci(Kn_p, K(0.27)); }
        hull() { ci(Kn_p, K(0.27)); ci(B_a, K(0.2)); }
        hull() { ci(P_p, r_au); ci(Kn_p, K(0.2)); ci(Kn_p - [K(0.6), K(0.15)], K(0.15)); }
        hull() { ci(Lp_p, r_au + max(M(0.03), 0.3)); ci(Kn_p, K(0.2)); ci(Kn_p + [K(0.45), -K(0.2)], K(0.15)); }
    }
    ci([0, 0], r_pr); ci(P_p, r_pr); ci(Lp_p, r_pr); ci(B_a, r_h);
}
module hubarm_lokal(sy) xz(sy > 0 ? Y_a0 : -Y_a1, sy > 0 ? Y_a1 : -Y_a0) hubarm_2d();
Lt_l = rot2([-r2, 0], bend);                 // Kipphebel lokal: Lager im Ursprung, Koppel-Auge bei (r1, 0)
module kipphebel_2d() difference() {
    union() { hull() { ci([0, 0], K(0.26)); ci([r1, 0], r_au); } hull() { ci([0, 0], K(0.26)); ci(Lt_l, r_au); } }
    ci([0, 0], r_h); ci([r1, 0], r_pr); ci(Lt_l, r_pr);
}
module koppel_2d() difference() { hull() { ci([0, 0], r_au); ci([l_kp, 0], r_au); } ci([0, 0], r_h); ci([l_kp, 0], r_h); }
module querrohr() difference() { cylinder(r = r_qr, h = l_qr, $fn = 32); translate([0, 0, -1]) cylinder(r = r_h, h = l_qr + 2, $fn = 24); }
// Gestänge im Arm-Rahmen für den Winkel g der Schaufel zum Arm
module gestaenge(g, ex = 0) {
    for (s = [-1, 1]) translate([0, s * ex * 0.7, 0]) bunt(farbe_gelb) flach_zw(Lp_p, Lb_a(g), s > 0 ? Y_hb : -Y_hb - t_gs, t_gs) kipphebel_2d();
    bunt(farbe_gelb) flach_zw(Lb_a(g), Q_a(g), -t_mi / 2, t_mi) koppel_2d();
    for (s = [-1, 1]) translate([Lp_p[0], s * (Y_hb + t_gs + 0.15 + ex * 1.1), Lp_p[1]]) rotate([s > 0 ? -90 : 90, 0, 0]) bunt(farbe_gelb) querrohr();
}

// =====================================================================
//  Schaufel (lokal = Druck: Schneide im Ursprung, Boden auf dem Bett, Breite entlang y)
// =====================================================================
SH = [-1.235, 0.083];  ST = [-0.78, 1.27];   // Ferse und Oberkante der Rückwand
k_rw = (ST[0] - SH[0]) / (ST[1] - SH[1]);
function x_rw(z) = K(SH[0]) + (z - K(SH[1])) * k_rw;   // Außenseite der Rückwand
module schaufel_seite_2d() polygon([[0, 0], KP([-1.17, 0]), KP(SH), KP(ST), KP([ST[0], 1.38]), KP([ST[0] + 0.13, 1.38]), KP([ST[0] + 0.19, 1.2]), KP([-0.22, 0.28])]);
module schaufel_schale_2d() difference() {
    polygon([[0, 0], KP([-1.17, 0]), KP(SH), KP(ST), KP([ST[0], 1.38]), [K(ST[0]) + K(0.19) + t_bk, K(1.38)], [K(0.01), t_bk * 0.45]]);
    polygon([[K(0.2), t_bk], [x_rw(t_bk) + t_bk, t_bk], [x_rw(K(1.27)) + t_bk, K(1.27)], [x_rw(K(1.27)) + t_bk, K(1.6)], [K(0.2), K(1.6)]]);
}
module schaufel_auge_arm_2d() hull() { ci(BL_p, r_au); polygon([[x_rw(0) - K(0.02), 0], [BL_p[0] - K(0.08), 0], [x_rw(K(0.75)) + 0.5, K(0.75)], [x_rw(0) + 0.5, 0]]); }
module schaufel_auge_mitte_2d() hull() { ci(QL_p, r_au); polygon([[x_rw(0) + 0.5, 0], [QL_p[0] + K(0.06), 0], [x_rw(K(1.0)) + 0.5, K(1.0)]]); }   // bis aufs Bett: stützfrei
module schaufel_lokal() difference() {
    union() {
        xz(-W_s / 2, W_s / 2) schaufel_schale_2d();
        for (s = [-1, 1]) xz(s > 0 ? W_s / 2 - t_bk : -W_s / 2, s > 0 ? W_s / 2 : -W_s / 2 + t_bk) schaufel_seite_2d();
        // Zähne (liegen auf dem Bett)
        let(n = 8, w = max(M(0.12), 1.2)) for (i = [0 : n - 1]) translate([0, -W_s / 2 + K(0.12) + i * (W_s - K(0.24) - w) / (n - 1), 0])
            xz(0, w) polygon([[-K(0.3), 0], [K(0.24), 0], [K(0.24), max(M(0.02), 0.4)], [-K(0.3), t_bk + max(M(0.05), 0.5)]]);
        // Lageraugen: je Hubarm eine Gabel, in der Mitte zwei Augen für die Koppel
        for (s = [-1, 1], y = [Y_a0 - spiel - t_ohr, Y_a1 + spiel]) xz(s > 0 ? y : -y - t_ohr, s > 0 ? y + t_ohr : -y) schaufel_auge_arm_2d();
        for (s = [-1, 1]) xz(s > 0 ? Y_hb : -Y_hb - t_ohr, s > 0 ? Y_hb + t_ohr : -Y_hb) schaufel_auge_mitte_2d();
    }
    for (s = [-1, 1]) hole_y(BL_p, r_pr, s > 0 ? Y_a0 - spiel - t_ohr - 1 : -Y_a1 - spiel - t_ohr - 1, s > 0 ? Y_a1 + spiel + t_ohr + 1 : -Y_a0 + spiel + t_ohr + 1);
    hole_y(QL_p, r_pr, -Y_hb - t_ohr - 1, Y_hb + t_ohr + 1);
    // Ausschnitt in der Oberkante der Rückwand: Platz für den Kipphebel bei eingekippter Schaufel
    let(w = Y_hb + t_gs + max(M(0.05), 0.6)) translate([x_rw(K(1.05)) - 1, -w, K(1.05)]) cube([K(0.45) + t_bk + 2, 2 * w, K(0.5)]);
}

// =====================================================================
//  Leiter, Handlauf, Spiegel (flach gedruckt)
// =====================================================================
module leiter_2d() let(w = Y_le[1] - Y_le[0], h = Z_pl - Z_le0, n = max(2, round(h / M(0.3)))) {
    for (u = [0, w - b_hl]) translate([u, 0]) square([b_hl, h + l_tb]);
    for (i = [0 : n - 1]) translate([0, i * (h - b_hl - M(0.1)) / (n - 1)]) square([w, b_hl]);
}
module leiter_welt(sy) mirror([0, sy > 0 ? 0 : 1, 0]) yz(X_le - t_hl / 2, X_le + t_hl / 2) translate([Y_le[0], Z_le0]) leiter_2d();
module handlauf_2d() {
    translate([0, H_hl - b_hl]) square([L_hl, b_hl]);
    translate([0, H_hl / 2 - b_hl / 2]) square([L_hl, b_hl]);
    for (u = [0, (L_hl - b_hl) / 2, L_hl - b_hl]) translate([u, -l_tb]) square([b_hl, H_hl + l_tb]);
}
module handlauf_welt(i) translate([HL[i][0], 0, Z_pt]) xz(HL[i][1] - t_hl / 2, HL[i][1] + t_hl / 2) handlauf_2d();
module spiegel_2d() {
    translate([-b_hl / 2, -l_tb]) square([b_hl, l_tb + M(0.2) + b_hl]);
    translate([-b_hl / 2, M(0.2)]) square([M(0.75), b_hl]);
    translate([M(0.62), -M(0.3)]) square([max(M(0.16), 1.6), M(0.5) + b_hl]);
}
// Kotflügel vorne: 2D (x, y) der linken Seite; rechts dasselbe Teil gewendet
module kotfluegel_2d() difference() {
    union() {
        translate([KT_X[0], 0.2]) square([KT_X[1] - KT_X[0], Y_kf[0] - 0.2 + 0.01]);
        polygon([[KT_X[0], Y_kf[0]], [X_kf1, Y_kf[0]], [X_kf1, Y_kf[1] - K(0.2)], [X_kf1 - K(0.2), Y_kf[1]], [KT_X[0] + K(0.45), Y_kf[1]], [KT_X[0], Y_kf[1] - K(0.45)]]);
    }
    translate([LE[0][0], LE[0][1]]) square([t_le + 2 * es, b_hl + 2 * es], center = true);
}
module kotfluegel_welt(sy) mirror([0, sy > 0 ? 0 : 1, 0]) translate([0, 0, Z_kf]) linear_extrude(t_kf, convexity = 4) kotfluegel_2d();
module leuchte_2d() let(w = max(M(0.15), 1.0)) {
    translate([-b_hl / 2, -l_tb]) square([b_hl, l_tb + M(0.1)]);
    translate([-w, M(0.08)]) square([2 * w, max(M(0.24), 1.6)]);
}
module leuchte_welt(i) translate(LE[i]) translate([-t_le / 2, 0, 0]) rotate([90, 0, 90]) linear_extrude(t_le) leuchte_2d();
module spiegel_welt(i) translate([SP[i][0], SP[i][1], K_Z[1]]) rotate(SP[i][2] > 0 ? 0 : 180) translate([-t_hl / 2, 0, 0]) rotate([90, 0, 90]) linear_extrude(t_hl) spiegel_2d();

// =====================================================================
//  Zusammenbau
// =====================================================================
t_v = t_min + hub / 100 * (t_max - t_min);
b_v = min(max(schaufel_winkel, bmin(t_v)), bmax(t_v));
module in_arm(t) translate([A_p[0], 0, A_p[1]]) rotate([0, -t, 0]) children();
module in_schaufel(g) translate([B_a[0], 0, B_a[1]]) rotate([0, -g, 0]) translate([-BL_p[0], 0, -BL_p[1]]) children();
module hinten(ex = 0) {
    bunt(farbe_rahmen) hinterwagen_welt();
    translate([0, 0, 0]) bunt(farbe_achse) achse_welt(-X_va);
    for (s = [-1, 1]) { bunt(farbe_reifen) rad_welt(-X_va, s, "A", ex); bunt(farbe_felge) rad_welt(-X_va, s, "B", ex * 1.5); }
    translate([0, 0, ex]) {
        bunt(farbe_gelb) aufbau_welt();
        translate([-ex * 0.6, 0, 0]) bunt(farbe_grill) grill_welt();
        for (s = [-1, 1]) translate([0, 0, -ex * 0.6]) bunt(farbe_anbau) leiter_welt(s);
        for (i = [0, 1]) translate([0, 0, ex * 0.5]) bunt(farbe_anbau) handlauf_welt(i);
        translate([0, 0, ex * 0.9]) { bunt(farbe_kabine) kabine_welt("A"); translate([0, 0, -ex * 0.45]) bunt(farbe_glas) kabine_welt("B"); for (i = [0, 1]) translate([0, 0, ex * 0.4]) bunt(farbe_anbau) spiegel_welt(i); for (i = [2, 3]) translate([0, 0, ex * 0.4]) bunt(farbe_leuchte) leuchte_welt(i); }
    }
}
module vorne(t, b, ex = 0) {
    bunt(farbe_rahmen) vorderwagen_welt();
    translate([0, 0, -ex * 1.2]) bunt(farbe_achse) translate([0, 0, Z_b]) knickbolzen();
    for (s = [-1, 1]) translate([0, s * ex * 1.3, 0]) bunt(farbe_gelb) kotfluegel_welt(s);
    for (i = [0, 1]) translate([0, (i == 0 ? 1 : -1) * ex * 1.3, ex * 0.5]) bunt(farbe_leuchte) leuchte_welt(i);
    bunt(farbe_achse) achse_welt(X_va);
    for (s = [-1, 1]) { bunt(farbe_reifen) rad_welt(X_va, s, "A", ex); bunt(farbe_felge) rad_welt(X_va, s, "B", ex * 1.5); }
    translate([ex * 0.5, 0, ex * 0.5]) {
        in_arm(t) {
            for (s = [-1, 1]) translate([0, s * ex * 1.6, 0]) bunt(farbe_gelb) hubarm_lokal(s);
            gestaenge(b - t, ex);
            translate([ex * 1.2, 0, 0]) in_schaufel(b - t) bunt(farbe_schaufel) schaufel_lokal();
        }
        for (s = [-1, 1]) translate([0, s * ex * 0.8, 0]) {
            bunt(farbe_zylinder) zyl_zw(F_p, P_w(t), y_hz(s), "A", ZH, false, false);
            bunt(farbe_stange) zyl_zw(F_p, P_w(t), y_hz(s), "B", ZH, false, false);
        }
        translate([0, 0, ex * 0.6]) { bunt(farbe_zylinder) zyl_zw(KF_p, Lt_w(t, b), y_zk, "A", ZK, false, false); bunt(farbe_stange) zyl_zw(KF_p, Lt_w(t, b), y_zk, "B", ZK, false, false); }
    }
}
module radlader(ex = 0) {
    translate([-ex * 0.5, 0, 0]) hinten(ex);
    rotate(ex > 0 ? 0 : knick) translate([ex * 0.8, 0, 0]) vorne(ex > 0 ? t_min + 0.25 * (t_max - t_min) : t_v, ex > 0 ? 10 : b_v, ex);
}

// =====================================================================
//  Info und Ausgabe
// =====================================================================
X_lip = A_p[0] + K(hubarm_m) * cos(t_min) - BL_p[0];
Z_top = A_p[1] + K(hubarm_m) * sin(t_max);
BOLZ = [["Hubarm-Lager am Turm", 2 * Y_a1], ["Hubzylinder-Fuß", 2 * (Y_a0 - spiel)], ["Kippzylinder-Fuß", 2 * Y_t], ["Hubzylinder am Hubarm (2x)", Y_a1 - (Y_hz - hs)],
        ["Kipphebel-Lager mit Distanzrohren", 2 * Y_a1], ["Kipphebel oben", 2 * (Y_hb + t_gs)], ["Kipphebel unten", 2 * (Y_hb + t_gs)], ["Koppel an der Schaufel", 2 * (Y_hb + t_ohr)], ["Schaufelbolzen (2x)", t_a + 2 * spiel + 2 * t_ohr]];
echo(str("Radlader 1:", den, " | Länge mit Schaufel ", r2(X_lip - X_g0), " mm, Breite ", r2(2 * Y_pl), " (Schaufel ", r2(W_s), ") mm, Höhe Kabine ", r2(K_Z[1]), " mm | Radstand ", r2(2 * X_va), ", Rad Ø ", r2(2 * R_w), " x ", r2(B_w), " mm"));
echo(str("Hubgerüst: Arm ", r2(B_a[0]), " mm, Winkel ", r2(t_min), "° bis ", t_max, "°, Schaufelbolzen bis ", r2(Z_top), " mm hoch | Turm ±", r2(Y_t), ", Hubzylinder ±", r2(Y_hz), ", Hubarm ", r2(Y_a0), "–", r2(Y_a1), ", Reifen innen ", r2(y_ri), " mm"));
echo(str("Zylinder: Rohr Ø ", r2(2 * r_o), ", Stange Ø ", r2(2 * r_s), ", Auge Ø ", r2(2 * r_e), " mm | Hubzylinder ", r2(ZH[0]), "–", r2(ZH[1]), " mm (Überdeckung ", r2(ov(ZH)), ") | Kippzylinder ", r2(ZK[0]), "–", r2(ZK[1]), " (", r2(ov(ZK)), ") | min ", r2(ov_min)));
echo(str("Knickbolzen Ø ", r2(2 * r_kb), " x ", r2(l_kb), " mm | Achse ◇ ", r2(d_rz), " x ", r2(l_ax), " mm | Filament-Bolzen Ø ", stift_d, ": ", [for (b = BOLZ) str(b[0], " ", r2(b[1]), " mm")]));
if (min(ov(ZH), ov(ZK)) < ov_min) echo("WARNUNG: Kolbenstange zu kurz für den Schwenkbereich");
if (Y_a1 > y_ri - 0.4) echo("WARNUNG: Hubarme streifen die Reifen");
if (Y_t - t_sl / 2 < 1.2) echo("WARNUNG: Wangen des Turms zu dünn");
if (Z_pl < 2 * R_w + 0.5) echo("WARNUNG: Plattform streift die Hinterräder");
if (X_c1 - X_g0 > usable || W_s > usable) echo("WARNUNG: Hinterwagen/Schaufel größer als das Druckbett");
mass_echo(X_lip - X_g0, max(W_s, 2 * Y_pl), K_Z[1]);

druck("hinterwagen", 1, "alle", farbe_rahmen, 1);
druck("oberbau", 1, "alle", farbe_gelb, 1);
druck("kuehlergrill", 1, "alle", farbe_grill, 1);
druck("kabine", 1, "A", farbe_kabine, 1); druck("kabine", 1, "B", farbe_glas, 1);
druck("vorderwagen", 1, "alle", farbe_rahmen, 1);
druck("knickbolzen", 1, "alle", farbe_achse, 1);
druck("achse", 1, "alle", farbe_achse, 2);
druck("rad", 1, "A", farbe_reifen, 4); druck("rad", 1, "B", farbe_felge, 4);
druck("hubarm", 1, "alle", farbe_gelb, 2);
druck("querrohr", 1, "alle", farbe_gelb, 2);
druck("kipphebel", 1, "alle", farbe_gelb, 2);
druck("koppel", 1, "alle", farbe_gelb, 1);
druck("zylinder_hub", 1, "A", farbe_zylinder, 2); druck("zylinder_hub", 1, "B", farbe_stange, 2);
druck("zylinder_kipp", 1, "A", farbe_zylinder, 1); druck("zylinder_kipp", 1, "B", farbe_stange, 1);
druck("schaufel", 1, "alle", farbe_schaufel, 1);
druck("leiter", 1, "alle", farbe_anbau, 2);
druck("handlauf", 1, "alle", farbe_anbau, 2);
druck("spiegel", 1, "alle", farbe_anbau, 2);
druck("kotfluegel", 1, "alle", farbe_gelb, 2);
druck("leuchte", 1, "alle", farbe_leuchte, 4);
farben_echo();

if (teil == "aufbau") radlader();
else if (teil == "explosion") radlader(max(M(1.4), 10));
else if (teil == "hinterwagen") hinterwagen_druck();
else if (teil == "oberbau") aufbau_druck();
else if (teil == "kuehlergrill") grill_druck();
else if (teil == "kabine") kabine_druck(farbteil);
else if (teil == "vorderwagen") vorderwagen_druck();
else if (teil == "knickbolzen") knickbolzen();
else if (teil == "achse") achse_druck();
else if (teil == "rad") rad(farbteil);
else if (teil == "hubarm") linear_extrude(t_a, convexity = 6) hubarm_2d();
else if (teil == "querrohr") querrohr();
else if (teil == "kipphebel") linear_extrude(t_gs, convexity = 6) kipphebel_2d();
else if (teil == "koppel") linear_extrude(t_mi, convexity = 6) koppel_2d();
else if (teil == "zylinder_hub") zylinder_druck(farbteil, ZH, false, false);
else if (teil == "zylinder_kipp") zylinder_druck(farbteil, ZK, false, false);
else if (teil == "schaufel") schaufel_lokal();
else if (teil == "leiter") linear_extrude(t_hl) leiter_2d();
else if (teil == "handlauf") translate([0, l_tb, 0]) linear_extrude(t_hl) handlauf_2d();
else if (teil == "spiegel") translate([b_hl, l_tb + M(0.3), 0]) linear_extrude(t_hl) spiegel_2d();
else if (teil == "kotfluegel") translate([-KT_X[0], 0, 0]) linear_extrude(t_kf, convexity = 4) kotfluegel_2d();
else if (teil == "leuchte") translate([0, l_tb, 0]) linear_extrude(t_le) leuchte_2d();
