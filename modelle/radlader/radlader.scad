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
          ["hellblau", "#5aa2dc"], ["dunkelgruen", "#1f6b3a"], ["puderblau", "#8cc8ea"], ["catgelb", "#eeb111"], ["olivgrau", "#5f6b55"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

// =====================================================================
//  Maße (Welt: x = 0 Knickgelenk, +x nach vorne, +y links, z = 0 Boden; mm)
// =====================================================================
function K(m) = m * 1000 / den;
function KP(p) = [K(p[0]), K(p[1])];
function rot2(p, a) = [p[0] * cos(a) - p[1] * sin(a), p[0] * sin(a) + p[1] * cos(a)];
es    = einsatz_spiel;
zyl_r_s_min = 1.0;                          // schlanke Zylinder, damit Turm, Hubzylinder und Hubarme zwischen die Räder passen
zyl_wand_min = 0.9;
// =====================================================================
//  deko_hydraulik.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Teleskopische Hydraulikzylinder (Rohr + Kolbenstange), liegend stützfrei gedruckt,
//  und Bolzen-Maße.  Erwartet im Modell: stift_d, zylinder_spiel, einsatz_spiel und
//  (nach deko_grundlagen) M().  Optional vorab: zyl_r_s_m, zyl_r_o_m (Vorbild-Radien in m),
//  zyl_r_s_min (kleinster Stangenradius, mm) und zyl_wand_min (kleinste Rohrwand, mm).
//  Ein Zylinder wird durch Z = [L_min, L_max] (Augenabstand eingefahren/ausgefahren)
//  beschrieben; ov(Z) ist die Überdeckung der Stange im Rohr bei L_max (>= ov_min halten).
// =====================================================================
r_h   = (stift_d + 0.25) / 2;               // Bolzenloch lose
r_pr  = stift_d / 2 + einsatz_spiel;        // Bolzenloch stramm
r_e   = max(M(0.17), r_h + 1.0);            // Augenradius
r_s   = max(M(is_undef(zyl_r_s_m) ? 0.065 : zyl_r_s_m), is_undef(zyl_r_s_min) ? 1.2 : zyl_r_s_min);   // Kolbenstange
hs    = 0.62 * r_s;                         // Stange: oben und unten abgeflacht
r_b   = r_s + zylinder_spiel;
r_o   = max(M(is_undef(zyl_r_o_m) ? 0.14 : zyl_r_o_m), r_b + (is_undef(zyl_wand_min) ? 1.0 : zyl_wand_min));   // Rohr
hz    = 0.9 * r_o;                          // Rohrachse über dem Bett
x_b0  = r_e + max(M(0.05), 0.8);            // Boden der Bohrung
g_tz  = max(M(0.06), 0.8);
ov_min = max(5 * r_s, M(0.3));
function ov(Z) = (Z[0] - r_e - g_tz) - (x_b0 + Z[1] - Z[0]);
module rohr_2d() intersection() { hull() { translate([0, hz]) circle(r = r_o, $fn = 40); translate([-0.56 * r_o, 0]) square([1.12 * r_o, 0.01]); } translate([-r_o - 1, 0]) square([2 * r_o + 2, 2 * r_o + 2]); }
module stange_2d(o) intersection() { translate([0, hs]) circle(r = r_s + o, $fn = 32); translate([-r_s - o - 1, -o]) square([2 * (r_s + o) + 2, 2 * hs + 2 * o]); }
// lokal = Druck: Achse x ab dem Rohr-Auge, Augen flach auf dem Bett (Auge des Rohrs 2*hz dick, der Stange 2*hs)
module zyl_rohr(Z, press) let(L_tb = Z[0] - r_e - g_tz) difference() {
    union() {
        cylinder(r = r_e, h = 2 * hz, $fn = 32);
        translate([r_e - 0.4, 0, 0]) rotate([90, 0, 90]) linear_extrude(L_tb - r_e + 0.4) rohr_2d();
    }
    translate([0, 0, -1]) cylinder(r = press ? r_pr : r_h, h = 2 * hz + 2, $fn = 24);
    // Bohrung: Stangenprofil mit Luft, Decke als 45°-Giebel (stützfrei)
    translate([x_b0, 0, hz - hs]) rotate([90, 0, 90]) linear_extrude(L_tb) let(o = zylinder_spiel, wt = sqrt(pow(r_s + o, 2) - pow(hs + o, 2)))
        hull() { stange_2d(o); translate([-0.01, 2 * hs + o + wt * 1.1]) square(0.02); }
}
module zyl_stange(Z, L, press) difference() {
    union() {
        translate([L, 0, 0]) cylinder(r = r_e, h = 2 * hs, $fn = 32);
        translate([x_b0 + L - Z[0], 0, 0]) rotate([90, 0, 90]) linear_extrude(Z[0] - x_b0 - r_e + 0.4) stange_2d(0);
    }
    translate([L, 0, -1]) cylinder(r = press ? r_pr : r_h, h = 2 * hs + 2, $fn = 24);
}
module zylinder_druck(fp, Z, pa, pb) {
    if (inc(fp, "A")) zyl_rohr(Z, pa);
    if (inc(fp, "B")) translate([0, 2 * r_e + 3, 0]) zyl_stange(Z, Z[0], pb);
}
// zwischen zwei Punkten einer x-z-Schwenkebene (P = Rohr-Auge, Q = Stangen-Auge), Mitte bei y = yc
module zyl_zw(P, Q, yc, fp, Z, pa, pb) let(L = norm(Q - P), d = (Q - P) / L) {
    if (inc(fp, "A")) multmatrix([[d[0], d[1], 0, P[0]], [0, 0, 1, yc - hz], [d[1], -d[0], 0, P[1]], [0, 0, 0, 1]]) zyl_rohr(Z, pa);
    if (inc(fp, "B")) multmatrix([[d[0], d[1], 0, P[0]], [0, 0, 1, yc - hs], [d[1], -d[0], 0, P[1]], [0, 0, 0, 1]]) zyl_stange(Z, L, pb);
}
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
//  deko_rad.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Einzelrad für Baumaschinen: Reifen mit Pfeilprofil (A) und Steck-Felge (B).
//  Gedruckt mit senkrechter Achse, Innenseite auf dem Bett, stützfrei.
//  Erwartet im Modell: spiel, einsatz_spiel und (nach deko_grundlagen) M(), inc().
//    R_w Reifenradius, B_w Breite, R_fe Felgenradius, d_rz Radzapfen (Raute, Diagonale),
//    t_nb Tiefe des Nabenlochs (von der Innenseite)
// =====================================================================
module reifen_rad(fp, R_w, B_w, R_fe, d_rz, t_nb) {
    lip_h = max(M(0.03), 0.4); lip_w = max(M(0.08), 0.8); lip_t = lip_h + lip_w;   // Innenrand: senkrecht, dann 45°-Konus
    c_t = M(0.28); n_p = 18; g_d = max(M(0.11), 0.8);
    prof = [[R_fe - lip_w, 0], [R_w - 0.7 * c_t, 0], [R_w, c_t], [R_w, B_w - c_t], [R_w - c_t, B_w], [R_fe, B_w], [R_fe, lip_t], [R_fe - lip_w, lip_h]];
    if (inc(fp, "A")) difference() {
        rotate_extrude($fn = 96, convexity = 6) polygon(prof);
        // Stollen: je Reifenhälfte schräge Rillen, in der Mitte zum V verbunden (keine Überhänge)
        for (hf = [0, 1]) translate([0, 0, hf * B_w / 2 - (hf == 0 ? 0.01 : 0)])
            linear_extrude(B_w / 2 + 0.01, twist = hf == 0 ? 9 : -9, slices = 6, convexity = 6)
            rotate(hf == 0 ? 0 : -9) for (k = [0 : n_p - 1]) rotate(k * 360 / n_p)
                translate([R_w - g_d, -R_w * PI / n_p * 0.42]) square([g_d + 2, R_w * 2 * PI / n_p * 0.42]);
    }
    if (inc(fp, "B")) let(r_f = R_fe - einsatz_spiel, w_fl = max(M(0.08), 0.8), r_hb = max(M(0.32), d_rz / 2 + 1.2), rec = M(0.14)) difference() {
        union() {
            rotate_extrude($fn = 96, convexity = 4) polygon([[0, 0], [R_fe - lip_w - einsatz_spiel, 0], [R_fe - lip_w - einsatz_spiel, lip_h], [r_f, lip_t], [r_f, B_w - rec], [0, B_w - rec]]);
            difference() { translate([0, 0, lip_t]) cylinder(r = r_f, h = B_w - M(0.03) - lip_t, $fn = 96); translate([0, 0, -1]) cylinder(r = r_f - w_fl, h = B_w + 2, $fn = 96); }
            cylinder(r = r_hb, h = B_w - M(0.05), $fn = 48);
            cylinder(r = r_hb * 0.55, h = B_w - M(0.01), $fn = 32);
            for (k = [0 : 11]) rotate(k * 30) translate([(r_hb + r_f - w_fl) / 2, 0, 0]) cylinder(r = max(M(0.04), 0.5), h = B_w - rec + max(M(0.04), 0.4), $fn = 10);
        }
        translate([0, 0, -1]) cylinder(d = d_rz + spiel, h = t_nb + 1, $fn = 32);
    }
}

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
