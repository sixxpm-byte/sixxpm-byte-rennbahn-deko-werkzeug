// =====================================================================
//  UMSCHLAGBAGGER  –  Mobil-Umschlagbagger der 24-t-Klasse mit Mehrschalengreifer
//  Vorbild: Cat MH3024 (Radstand 2,75 m, Zwillingsbereifung, 4 Pratzen,
//  hydraulisch hebbare Kabine, gerader Ausleger 6,2 m, gekröpfter Stiel 4,2 m)
//  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei), Farben je Bauteil,
//  Maßstab 1:43 / 1:87.  Oberwagen dreht, Kabine rastet in 4 Höhen, Ausleger und
//  Stiel schwenken an Bolzen, die teleskopischen Zylinder halten jede Stellung,
//  der Greifer pendelt am Stiel.
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    fahrgestell     Fahrgestell mit Achsgehäusen, Pratzenträgern, Drehkranz und Königszapfen  1x
//    stuetze         Abstützpratze: Fußplatte, Säule, Rautenzapfen nach oben                   4x
//    achse           Vierkant-Achse, durch das Fahrgestell gesteckt                            2x
//    rad             Zwillingsrad: Reifen (A) + durchgehende Steck-Felge (B)                   4x
//    oberwagen       Plattform, Motorhaus, Gegengewicht, Tankkasten, Hubwerksturm,
//                    Auslegerlager und Zylinderbock                                          1x
//    kabine          Fahrerkabine (unten offen) + Glaskern von unten                           1x
//    traeger         Kabinenträger: Bodenplatte mit Lagerwangen (kopfüber gedruckt)            1x
//    hubarm          Hubarm des Kabinen-Parallelogramms (flach, mit Rastloch)                  4x
//    ausleger_links / ausleger_rechts   Auslegerhälften (flach, Außenseite unten)           je 1x
//    stiel_links / stiel_rechts         Stielhälften mit Kröpfung (flach, Außenseite unten) je 1x
//    duebel          Vierkant-Dübel zwischen den Hälften                                       4x
//    zylinder_ausleger  Hubzylinder: Rohr (A) + Kolbenstange (B)                               2x
//    zylinder_stiel     Stielzylinder: Rohr (A) + Kolbenstange (B)                             1x
//    greiferkopf     Greiferkopf mit Pendelöse, Rotator und 5 Steckschlitzen                   1x
//    schale          Greiferschale (flach), Zunge von unten in den Kopf                        5x
//    handlauf        Handlauf (flach), in Schlitze auf Motorhaus und Tankkasten                2x
//
//  BOLZEN
//    Filament-Stücke Ø stift_d (Längen siehe Echo): Auslegerfuß, Hubzylinder unten/oben,
//    Stielzylinder am Ausleger und am Stiel, Stielgelenk, Greifer, Hubarme unten (2),
//    Rastbolzen, Hubarme am Träger (2).
//  BEWEGLICH
//    * Oberwagen dreht auf dem Königszapfen, Räder drehen auf den Achsen.
//    * Kabine: Parallelogramm aus 4 Hubarmen, Rastbolzen in 4 Höhen (0/25/50/75°).
//    * Ausleger und Stiel schwenken; Kolbenstangen halten durch Reibung (zylinder_spiel).
//    * Greifer pendelt am Stiel, Schalen fest geöffnet.
//  DRUCK
//    Alle Teile stützfrei: Fahrgestell und Oberwagen aufrecht, Pratzen auf der Fußplatte,
//    Räder auf der Innenseite, Kabine und Träger kopfüber, Hubarme, Hälften und Schalen
//    flach, Zylinder und Achsen liegend, Greiferkopf aufrecht (Schlitze unten).
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, fahrgestell:Fahrgestell, stuetze:Abstützpratze (4x), achse:Achse (2x), rad:Zwillingsrad (4x), oberwagen:Oberwagen, kabine:Kabine mit Glaskern, traeger:Kabinenträger, hubarm:Hubarm (4x), ausleger_links:Ausleger links, ausleger_rechts:Ausleger rechts, stiel_links:Stiel links, stiel_rechts:Stiel rechts, duebel:Dübel (4x), zylinder_ausleger:Hubzylinder (2x), zylinder_stiel:Stielzylinder, greiferkopf:Greiferkopf, schale:Greiferschale (5x), handlauf:Handlauf (2x)]
stueck = 0;
farbteil = "alle"; // [alle, A, B]

/* [Vorschau] */
// Drehung des Oberwagens
drehung = 0; // [-180:5:180]
// Ausleger: Winkel über der Waagerechten
ausleger_winkel = 45; // [25:1:70]
// Stiel: Winkel zum Ausleger (-60 = gestreckt, -130 = angezogen)
stiel_winkel = -75; // [-130:1:-60]
// Kabine: Raststufe (0 = unten, 3 = ganz oben)
kabine_stufe = 2; // [0:1:3]
// Drehung des Greifers
greifer_drehung = 0; // [0:1:72]

/* [Umschlagbagger (Vorbild in Metern)] */
radstand_m = 2.75;
breite_m = 2.55;
rad_d_m = 1.05;
rad_b_m = 0.28;
felge_d_m = 0.52;
zwilling_luft_m = 0.06;
oberwagen_breite_m = 2.55;
heck_m = 2.5;
kabine_breite_m = 1.0;
kabine_laenge_m = 1.6;
kabine_hoehe_m = 1.7;
hubarm_m = 1.8;
ausleger_m = 6.2;
// Ausleger sitzt rechts der Drehachse (Platz für Kabine und Hubwerk links)
ausleger_versatz_m = 0.25;
stiel_m = 3.6;

/* [Farben] */
farbe_gelb       = "catgelb";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_fahrgestell = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_reifen     = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_felge      = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_kabine     = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_glas       = "puderblau"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_hubwerk    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_zylinder   = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_stange     = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_greifer    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_anbau      = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]

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
// Luft je Seite für eingepresste Teile (Zapfen, Achsen, Dübel, Glaskern, Felgen; 0 = sehr stramm)
einsatz_spiel = 0.05;

include <../../lib/deko_grundlagen.scad>

// =====================================================================
//  Maße (Welt: x = 0 Drehachse, +x nach vorne, +y links, z = 0 Boden; mm)
// =====================================================================
function K(m) = m * 1000 / den;
function KP(p) = [K(p[0]), K(p[1])];
function rot2(p, a) = [p[0] * cos(a) - p[1] * sin(a), p[0] * sin(a) + p[1] * cos(a)];
es    = einsatz_spiel;
sp    = spiel;
zyl_r_s_m = 0.05;  zyl_r_o_m = 0.10;      // schlanke Zylinder (Kabine sitzt dicht neben dem Ausleger)
zyl_r_s_min = 1.0; zyl_wand_min = 0.8;
include <../../lib/deko_hydraulik.scad>
d_p   = max(M(0.16), 2.0);                  // Steckzapfen (Raute)
r_l   = r_e + max(M(0.03), 0.3);            // Laschenradius (Hubarme, Greiferöse)

// Räder und Achsen
R_w   = K(rad_d_m / 2);  z_ax = R_w;
B_w   = K(rad_b_m);
R_fe  = K(felge_d_m / 2);
g_zw  = max(M(zwilling_luft_m), 0.8);
B_zw  = 2 * B_w + g_zw;
y_ri  = K(breite_m / 2) - B_zw;             // Innenseite der Zwillingsräder
X_ax  = K(radstand_m / 2);
d_rz  = max(M(0.22), 2.4);                  // Achse: Vierkant, in der Welt als Raute (Diagonale)
a_az  = d_rz / sqrt(2);
t_nb  = B_zw - max(M(0.1), 1.0);
l_ax  = 2 * (y_ri + t_nb - 0.4);

// Fahrgestell
Z_u0  = K(0.3);  Z_u1 = K(1.15);  Z_dk = K(1.3);
X_u   = K(2.1);  Y_u = K(0.6);
X_ag  = K(0.33); Y_ag = y_ri - max(M(0.02), 0.3);  Z_ag = Z_u0 + K(0.5);   // Achsgehäuse
X_mb  = K(0.7);  Y_mb = K(0.95);            // Mittelblock unter dem Drehkranz
X_st  = K(2.3);  Y_st = K(1.0);             // Pratzen
X_tb  = K(0.25); Y_tb = K(1.15); Z_tb = Z_u0 + K(0.55);   // Pratzenträger (Querbalken)
X_pb  = K(0.5) / 2; Y_pb = K(0.4) / 2; Z_pb = Z_u0 + K(0.75);   // Pratzenkasten
a_st  = max(M(0.3), 2.6);                   // Säule der Pratze (Quadrat)
P_st  = [K(0.55), K(0.45)];  t_pad = max(M(0.1), 1.0);
h_zp  = max(M(0.3), 2.4);                   // Zapfen der Pratze
r_dk  = K(0.85);
r_kp  = max(M(0.25), 2.5);  h_kp = K(0.4);

// Oberwagen
Z_o0  = K(1.35);  Z_o1 = K(1.5);
Y_o   = K(oberwagen_breite_m / 2);
X_h   = -K(heck_m);  X_vo = K(1.9);
Z_mh  = K(2.75);  Z_tk = K(2.3);
X_er  = K(0.5);                             // Tankkasten rechts bis hierher

// Arbeitsausrüstung (2D in der Schwenkebene, Vorbild-Meter)
T_s   = max(M(0.42), 2 * r_o + 2 * sp + 1.8);   // Stiel-Dicke
G_s   = 2 * r_o + 2 * sp;                   // Gabel im Stiel (Zylinderauge, Greiferöse)
G_b   = T_s + 2 * sp;                       // Gabel im Ausleger
T_b   = G_b + 2 * max(M(0.08), 1.1);        // Ausleger-Dicke
F_m   = [0.6, 2.1];                         // Auslegerfuß (Welt)
CF_m  = [1.65, 1.75];                       // Hubzylinder-Fuß (Welt)
A_m   = [2.4, 0.45];                        // Hubzylinder am Ausleger (lokal)
K_m   = [2.6, 0.55];                        // Knick
S1_m  = [3.5, 1.15];                        // Stielzylinder am Ausleger
T_m   = [ausleger_m, 0];                    // Stielgelenk
R_m   = [-0.7, 0.55];                       // Stielzylinder am Stiel (lokal Stiel)
P1_m  = [2.3, -0.05];  P2_m = [3.2, -0.7];  // Stiel: gerader Teil, Kröpfung
G_m   = [stiel_m, -1.5];                    // Greifer-Aufhängung (lokal Stiel)
F_p = KP(F_m); CF_p = KP(CF_m); A_p = KP(A_m); K_p = KP(K_m); S1_p = KP(S1_m); T_p = KP(T_m);
R_p = KP(R_m); P1_p = KP(P1_m); P2_p = KP(P2_m); G_p = KP(G_m);
t_lg  = max(M(0.1), 1.2);                   // Lagerwangen (Oberwagen, Kabinenträger)
Y_lg  = T_b / 2 + sp;
y_b   = -K(ausleger_versatz_m);             // Schwenkebene des Auslegers
BW = [25, 70]; SW = [-130, -60];
function L_hub(t) = norm(F_p + rot2(A_p, t) - CF_p);
function L_sti(p) = norm(S1_p - (T_p + rot2(R_p, p)));
ZH = [min([for (a = [BW[0] : 1 : BW[1]]) L_hub(a)]), max([for (a = [BW[0] : 1 : BW[1]]) L_hub(a)])];
ZS = [min([for (a = [SW[0] : 1 : SW[1]]) L_sti(a)]), max([for (a = [SW[0] : 1 : SW[1]]) L_sti(a)])];
Y_hz  = T_b / 2 + max(M(0.03), 0.3) + hz;   // Mitte der Hubzylinder
y_zb  = Y_hz + hz + max(M(0.05), 0.4);      // Zylinderzone um y_b (frei halten)
// Dübel
a_dw  = max(M(0.15), 1.8);
function d_dp(T) = min(T / 2 - 0.8, max(M(0.2), 2));
DB = [[1.2, 0.2], [4.8, 0.3]];
DS = [[1.0, 0.05], [2.4, -0.1]];

// Kabinen-Hubwerk (Parallelogramm, Schwenkebene bei y = y_c)
t_gs  = max(M(0.08), 1.2);                  // Hubarm-Dicke
w_t   = K(0.5);                             // Turm zwischen den Hubarmen
L_a   = K(hubarm_m);
r_lk  = K(0.58);  r_box = K(0.75);          // Rastlochkreis, Turmrundung
STUFEN = [0, 25, 50, 75];
y_ki  = y_b + y_zb;                         // Kabine innen (neben der Zylinderzone)
Kw    = max(K(kabine_breite_m), w_t + 2 * (2 * sp + t_gs + t_lg) + 0.6);
y_c   = y_ki + Kw / 2;
X_t   = -K(0.9);
A1 = [X_t, Z_o1 + r_l + max(M(0.05), 0.5)];
OFF = [-K(0.45), max(K(0.42), 2 * r_l + 0.6)];   // Versatz der Hubarme (Abstand > Armbreite)
A2 = A1 + OFF;
function LK(k) = A1 + r_lk * [cos(STUFEN[k]), sin(STUFEN[k])];
BX = [A2[0] - max(K(0.15), r_h + 1.2), A1[0] + r_box];   // Turm x
BZ1 = A1[1] + r_box;
X_eh = A2[0] - r_l - K(0.1);                // Motorhaus hinten bis hierher
r_hk = min(K(0.6), (X_eh - X_h) / 2 - 1);   // Heckrundung (Hülle darf nicht vor X_eh wölben)
function C1(th) = A1 + L_a * [cos(th), sin(th)];
y_a0  = w_t / 2 + sp;                       // Hubarme innen
y_e0  = y_a0 + t_gs + sp;                   // Trägerwangen innen
// Träger und Kabine (lokal: Ursprung C1, y relativ y_c)
z_pb  = OFF[1] + r_l + sp + max(M(0.03), 0.3);
t_pl  = max(M(0.14), 2.2);
KX = [-K(1.1), -K(1.1) + K(kabine_laenge_m)];
KY = [-Kw / 2, Kw / 2];
KZ = [z_pb + t_pl, z_pb + t_pl + K(kabine_hoehe_m)];
t_k   = max(M(0.08), 1.2);  t_kr = max(M(0.1), 1.2);
p_k   = max(M(0.22), d_p + 1.6);
c_kd  = M(0.1);
l_pin = t_pl - 0.6;

// Greifer (lokal: Ursprung Aufhängung, z nach unten negativ)
t_gl  = G_s - 2 * sp;                       // Pendelöse
L_oe  = K(0.6);
r_rot = K(0.3);  h_rot = K(0.12);
r_hd  = K(0.45); h_hd = K(0.42);
z_hb  = -(L_oe + h_rot + h_hd);             // Unterkante Kopf
t_sch = max(M(0.09), 1.2);
d_sl  = K(0.3);                             // Schlitztiefe
u_sl  = K(0.16);                            // Schlitz innen
SCH = [[0.32, 0], [0.52, -0.32], [0.74, -0.72], [0.78, -1.1], [0.62, -1.42], [0.4, -1.62]];
SCR = [0.09, 0.09, 0.085, 0.08, 0.065, 0.045];

include <../../lib/deko_hilfen.scad>
include <../../lib/deko_rad.scad>

// =====================================================================
//  Hilfen
// =====================================================================
module raute2(d) rotate(45) square(d / sqrt(2), center = true);
module xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 8) children();
module yz(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0, convexity = 8) children();
module hole_y(p, r, y0, y1, up = 1) xz(y0, y1) translate(p) rotate(up > 0 ? 90 : -90) teardrop(r);
module bunt(f) color(fhex(f)) render(convexity = 8) children();
module rstift(d, h) let(c = min(0.4, d * 0.2)) { linear_extrude(h - c + 0.01) raute2(d); translate([0, 0, h - c]) linear_extrude(c, scale = (d - 2 * c) / d) raute2(d); }
module ci(p, r) translate(p) circle(r = r, $fn = 40);
module fase_box(x0, x1, y0, y1, z0, z1, c) hull() {
    translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0 - c]);
    translate([x0 + c, y0 + c, z0]) cube([x1 - x0 - 2 * c, y1 - y0 - 2 * c, z1 - z0]);
}

// =====================================================================
//  Fahrgestell, Pratzen, Achsen, Räder
// =====================================================================
module fahrgestell_welt() difference() {
    union() {
        fase_box(-X_u, X_u, -Y_u, Y_u, Z_u0, Z_u1, M(0.08));
        fase_box(-X_mb, X_mb, -Y_mb, Y_mb, Z_u0, Z_u1, M(0.08));
        for (s = [-1, 1]) {
            fase_box(s * X_ax - X_ag, s * X_ax + X_ag, -Y_ag, Y_ag, Z_u0, Z_ag, M(0.06));
            fase_box(s * X_st - X_tb, s * X_st + X_tb, -Y_tb, Y_tb, Z_u0, Z_tb, M(0.06));
            for (q = [-1, 1]) fase_box(s * X_st - X_pb, s * X_st + X_pb, q * Y_st - Y_pb, q * Y_st + Y_pb, Z_u0, Z_pb, M(0.06));
        }
        translate([0, 0, Z_u1 - 0.01]) cylinder(r = r_dk, h = Z_dk - Z_u1 + 0.01, $fn = 64);
        translate([0, 0, Z_dk - 0.01]) { cylinder(r = r_kp, h = h_kp - 0.4, $fn = 40); translate([0, 0, h_kp - 0.4 - 0.01]) cylinder(r1 = r_kp, r2 = r_kp - 0.4, h = 0.4, $fn = 40); }
    }
    for (s = [-1, 1]) xz(-Y_ag - 1, Y_ag + 1) translate([s * X_ax, z_ax]) raute2(d_rz + 2 * es);
    for (s = [-1, 1], q = [-1, 1]) translate([s * X_st, q * Y_st, Z_u0 - 1]) linear_extrude(h_zp + es + 1) raute2(d_p + 2 * es);
    // Rillen der Pratzenkästen (Zierfuge)
    let(dg = max(M(0.03), 0.4)) for (s = [-1, 1], q = [-1, 1]) translate([s * X_st - X_pb - 1, q * Y_st - dg / 2, Z_tb + K(0.05)]) cube([2 * X_pb + 2, dg, max(M(0.03), 0.5)]);
}
module fahrgestell_druck() translate([0, 0, -Z_u0]) fahrgestell_welt();

module stuetze_lokal() {   // Ursprung: Säulenachse, z = 0 Boden
    c = min(0.4, t_pad * 0.4);
    hull() { translate([-P_st[0] / 2, -P_st[1] / 2, 0]) cube([P_st[0], P_st[1], t_pad - c]); translate([-P_st[0] / 2 + c, -P_st[1] / 2 + c, 0]) cube([P_st[0] - 2 * c, P_st[1] - 2 * c, t_pad]); }
    translate([-a_st / 2, -a_st / 2, t_pad - 0.01]) cube([a_st, a_st, Z_u0 - 0.1 - t_pad + 0.01]);
    translate([0, 0, Z_u0 - 0.1 - 0.01]) rstift(d_p, h_zp + 0.1);
}
module stuetze_welt(s, q) translate([s * X_st, q * Y_st, 0]) stuetze_lokal();

module achse_welt(x) translate([x, -l_ax / 2, z_ax]) rotate([-90, 0, 0]) linear_extrude(l_ax) raute2(d_rz);
module achse_druck() let(c = min(0.5, a_az * 0.2)) hull() { cube([l_ax, a_az, a_az - c]); translate([c, 0, 0]) cube([l_ax - 2 * c, a_az, a_az]); }
module rad(fp) reifen_rad(fp, R_w, B_w, R_fe, d_rz, t_nb, g_zw);
module rad_welt(i, fp, ex = 0) let(x = (i < 2 ? 1 : -1) * X_ax, sy = i % 2 == 0 ? 1 : -1)
    translate([x, sy * (y_ri + ex), z_ax]) rotate([sy > 0 ? -90 : 90, 0, 0]) rad(fp);

// =====================================================================
//  Oberwagen
// =====================================================================
module plattform_2d() hull() { for (s = [-1, 1]) ci([X_h + r_hk, s * (Y_o - r_hk)], r_hk); translate([X_vo - 1, -Y_o]) square([1, 2 * Y_o]); }
module turm_2d() {   // (x, z) Hubwerksturm mit gerundeter Stirn
    translate([BX[0], Z_o1 - 0.01]) square([A1[0] - BX[0], BZ1 - Z_o1 + 0.01]);
    translate([BX[0], Z_o1 - 0.01]) square([BX[1] - BX[0], A1[1] - Z_o1 + 0.01]);
    intersection() { ci(A1, r_box); translate([A1[0] - 0.01, A1[1] - 0.01]) square([r_box + 1, r_box + 1]); }
}
module oberwagen_welt() {
    c = M(0.08);
    difference() {
        union() {
            translate([0, 0, Z_o0]) linear_extrude(Z_o1 - Z_o0, convexity = 6) plattform_2d();
            // Motorhaus hinten (volle Breite, runde Heckecken = Gegengewicht)
            hull() {
                for (s = [-1, 1]) translate([X_h + r_hk, s * (Y_o - r_hk), Z_o1 - 0.01]) cylinder(r = r_hk, h = Z_mh - Z_o1 - c, $fn = 40);
                for (s = [-1, 1]) translate([X_h + r_hk, s * (Y_o - r_hk), Z_o1 - 0.01]) cylinder(r = r_hk - c, h = Z_mh - Z_o1, $fn = 40);
                translate([X_eh - 1, -Y_o, Z_o1 - 0.01]) cube([1, 2 * Y_o, Z_mh - Z_o1 - c]);
                translate([X_eh - 1, -Y_o + c, Z_o1 - 0.01]) cube([1, 2 * (Y_o - c), Z_mh - Z_o1]);
            }
            // Tankkasten rechts neben der Zylinderzone
            fase_box(X_eh - 1, X_er, -Y_o, y_b - y_zb, Z_o1 - 0.01, Z_tk, c);
            // Hubwerksturm links
            translate([0, y_c + w_t / 2, 0]) rotate([90, 0, 0]) linear_extrude(w_t, convexity = 6) turm_2d();
            // Auspuff und Luftfilterhaube auf dem Motorhaus
            translate([X_h + K(0.5), K(0.7), Z_mh - 0.01]) cylinder(r = max(M(0.09), 1.0), h = K(0.5), $fn = 20);
            fase_box(X_h + K(0.25), X_eh - K(0.15), -K(0.75), K(0.25), Z_mh - 0.01, Z_mh + K(0.3), c);
            // Auslegerlager: zwei Wangen
            translate([0, y_b, 0]) for (s = [-1, 1]) xz(s > 0 ? Y_lg : -Y_lg - t_lg, s > 0 ? Y_lg + t_lg : -Y_lg) hull() { ci(F_p, K(0.34)); translate([F_p[0] - K(0.7), Z_o1 - 0.01]) square([K(1.4), 0.02]); }
            // Bock für die Hubzylinder (so breit wie der Ausleger)
            translate([0, y_b, 0]) xz(-T_b / 2, T_b / 2) hull() { ci(CF_p, r_e); translate([CF_p[0] - r_e, Z_o1 - 0.01]) square([2 * r_e, 0.02]); }
            // Drehdurchführung (Königszapfen ragt über die Plattform)
            translate([0, 0, Z_o1 - 0.01]) cylinder(r = r_kp + max(M(0.1), 1.2), h = Z_dk + h_kp + 0.6 - Z_o1, $fn = 40);
        }
        translate([0, 0, Z_o0 - 1]) cylinder(r = r_kp + sp, h = Z_dk + h_kp + 2 - Z_o0, $fn = 40);   // durchgehend (keine Decke)
        translate([0, y_b, 0]) { hole_y(F_p, r_pr, -Y_lg - t_lg - 1, Y_lg + t_lg + 1); hole_y(CF_p, r_h, -T_b / 2 - 1, T_b / 2 + 1); }
        // Hubwerk: Lager und Rastlöcher
        for (p = [A1, A2]) hole_y(p, r_h, y_c - w_t / 2 - 1, y_c + w_t / 2 + 1);
        for (k = [0 : len(STUFEN) - 1]) hole_y(LK(k), r_h, y_c - w_t / 2 - 1, y_c + w_t / 2 + 1);
        // Schlitze der Handläufe
        for (h = HL) for (u = [0, (L_hl - b_hl) / 2, L_hl - b_hl]) schlitz(h[0] + u + b_hl / 2, h[1], h[2], b_hl, t_hl);
        // Lüftungsgitter rechts und hinten, Türfugen
        let(n = 8, w = max(M(0.05), 0.6), dg = max(M(0.03), 0.4)) {
            for (i = [0 : n - 1]) translate([X_eh - K(0.1) - i * K(0.14), -Y_o - 1, Z_o1 + K(0.4)]) cube([w, dg + 1, K(0.8)]);
            for (i = [0 : n - 1]) translate([X_h - 1, -K(0.6) + i * K(0.14), Z_o1 + K(0.5)]) cube([dg + 1 + r_hk * 0, w, K(0.7)]);
            for (x = [X_eh + K(0.3), X_eh + K(1.1)]) translate([x, -Y_o - 1, Z_o1 + K(0.1)]) cube([max(M(0.03), 0.5), dg + 1, Z_tk - Z_o1 - K(0.25)]);
            translate([X_h + r_hk, Y_o - dg, Z_o1 + K(0.1)]) cube([max(M(0.03), 0.5), dg + 1, Z_mh - Z_o1 - K(0.3)]);
        }
    }
}
module oberwagen_druck() translate([0, 0, -Z_o0]) oberwagen_welt();

// =====================================================================
//  Kabinen-Hubwerk: Hubarme, Träger, Kabine
// =====================================================================
module hubarm_2d() difference() { hull() { ci([0, 0], r_l); ci([L_a, 0], r_l); } ci([0, 0], r_pr); ci([r_lk, 0], r_pr); ci([L_a, 0], r_h); }
// Lasche in der x-z-Ebene von P in Richtung th, y von y0 bis y0+t
module lasche_an(P, th, y0, t) multmatrix([[cos(th), -sin(th), 0, P[0]], [0, 0, -1, y0 + t], [sin(th), cos(th), 0, P[1]], [0, 0, 0, 1]]) linear_extrude(t) children();
module hubarm_welt(k, th, s) lasche_an(k == 0 ? A1 : A2, th, y_c + (s > 0 ? y_a0 : -y_a0 - t_gs), t_gs) hubarm_2d();
module in_traeger(th) translate([C1(th)[0], y_c, C1(th)[1]]) children();

function kab_pins() = [for (x = [KX[0] + p_k / 2, KX[1] - p_k / 2], y = [KY[0] + p_k / 2, KY[1] - p_k / 2]) [x, y]];
module wange_2d() { hull() { ci([0, 0], r_l + max(M(0.02), 0.3)); ci(OFF, r_l + max(M(0.02), 0.3)); translate([OFF[0] - r_l, z_pb - 0.01]) square([r_l * 2 - OFF[0], 0.02]); } }
module traeger_lokal() difference() {
    union() {
        translate([KX[0], KY[0], z_pb]) cube([KX[1] - KX[0], KY[1] - KY[0], t_pl]);
        for (s = [-1, 1]) xz(s > 0 ? y_e0 : -y_e0 - t_lg, s > 0 ? y_e0 + t_lg : -y_e0) wange_2d();
        // Steg zwischen den Wangen, oberhalb der Hubarm-Augen
        translate([OFF[0] - r_l, -y_a0 + sp, OFF[1] + r_l + sp]) cube([r_l * 2 - OFF[0], 2 * (y_a0 - sp), z_pb - OFF[1] - r_l - sp + 0.01]);
    }
    for (q = [[0, 0], OFF]) hole_y(q, r_pr, -y_e0 - t_lg - 1, y_e0 + t_lg + 1, -1);
    for (p = kab_pins()) translate([p[0], p[1], z_pb + t_pl - l_pin]) linear_extrude(l_pin + 1) raute2(d_p + 2 * es);
}
module traeger_druck() translate([0, 0, z_pb + t_pl]) rotate([180, 0, 0]) traeger_lokal();

module kab_aussen() hull() {
    translate([KX[0], KY[0], KZ[0]]) cube([KX[1] - KX[0], KY[1] - KY[0], KZ[1] - KZ[0] - c_kd]);
    translate([KX[0] + c_kd, KY[0] + c_kd, KZ[0]]) cube([KX[1] - KX[0] - 2 * c_kd, KY[1] - KY[0] - 2 * c_kd, KZ[1] - KZ[0]]);
}
module kab_raum(o) difference() {
    translate([KX[0] + t_k - o, KY[0] + t_k - o, KZ[0] - 1]) cube([KX[1] - KX[0] - 2 * t_k + 2 * o, KY[1] - KY[0] - 2 * t_k + 2 * o, KZ[1] - KZ[0] - t_kr + 1 + min(o, 0)]);
    for (p = kab_pins()) translate([p[0] - p_k / 2 - o, p[1] - p_k / 2 - o, KZ[0] - 2]) cube([p_k + 2 * o, p_k + 2 * o, KZ[1]]);
}
module kab_fenster() {
    xm = (KX[0] + KX[1]) / 2; w2 = max(M(0.08), 1.0); z1 = KZ[1] - M(0.18);
    // vorne große Scheibe bis fast zum Boden, hinten kurz, seitlich zwei Scheiben
    translate([KX[1] - t_k - 1, KY[0] + p_k, KZ[0] + M(0.3)]) cube([t_k + 2, KY[1] - KY[0] - 2 * p_k, z1 - KZ[0] - M(0.3)]);
    translate([KX[0] - 1, KY[0] + p_k, KZ[0] + M(0.95)]) cube([t_k + 2, KY[1] - KY[0] - 2 * p_k, z1 - KZ[0] - M(0.95)]);
    for (y = [KY[0] - 1, KY[1] - t_k - 1]) for (xx = [[KX[0] + p_k, xm - w2 / 2], [xm + w2 / 2, KX[1] - p_k]])
        translate([xx[0], y, KZ[0] + M(0.75)]) cube([xx[1] - xx[0], t_k + 2, z1 - KZ[0] - M(0.75)]);
}
module kabine_lokal(fp) {
    if (inc(fp, "A")) {
        difference() { kab_aussen(); kab_raum(0); kab_fenster(); }
        for (p = kab_pins()) translate([p[0], p[1], KZ[0] + 0.01]) rotate([180, 0, 0]) rstift(d_p, l_pin + 0.01);
    }
    if (inc(fp, "B")) intersection() { kab_raum(-es); translate([-K(5), -K(5), KZ[0]]) cube([K(10), K(10), KZ[1] - KZ[0] - t_kr - es]); }
}
module kabine_druck(fp) translate([0, 0, KZ[1]]) rotate([180, 0, 0]) kabine_lokal(fp);

// =====================================================================
//  Ausleger und Stiel (zwei Hälften, flach gedruckt mit der Außenseite unten)
// =====================================================================
module ausleger_kern_2d() { hull() { ci([0, 0], K(0.36)); ci(K_p, K(0.5)); } hull() { ci(K_p, K(0.5)); ci(T_p, K(0.28)); } }
module ausleger_lasche_2d() hull() { ci(S1_p, r_l); ci(K_p + [-K(0.3), K(0.1)], K(0.3)); ci(K_p + [K(0.7), 0], K(0.3)); }
module ausleger_2d() { ausleger_kern_2d(); ausleger_lasche_2d(); }
module ausleger_gabel_2d() { ci(T_p, K(1.0)); difference() { offset(delta = 1) ausleger_lasche_2d(); ausleger_kern_2d(); } }
module ausleger_loecher_2d() { ci([0, 0], r_h); ci(A_p, r_h); ci(S1_p, r_pr); ci(T_p, r_pr); }
module stiel_kern_2d() { hull() { ci([0, 0], K(0.3)); ci(P1_p, K(0.26)); } hull() { ci(P1_p, K(0.26)); ci(P2_p, K(0.22)); } hull() { ci(P2_p, K(0.22)); ci(G_p, K(0.24)); } }
module stiel_lasche_2d() hull() { ci(R_p, r_l); ci([-K(0.05), K(0.1)], K(0.26)); ci([K(0.5), K(0.1)], K(0.22)); }
module stiel_2d() { stiel_kern_2d(); stiel_lasche_2d(); }
module stiel_gabel_2d() { ci(G_p, K(0.5)); difference() { offset(delta = 1) stiel_lasche_2d(); stiel_kern_2d(); } }
module stiel_loecher_2d() { ci([0, 0], r_h); ci(R_p, r_pr); ci(G_p, r_pr); }
module haelfte(n) let(T = n == 0 ? T_b : T_s, G = n == 0 ? G_b : G_s, D = n == 0 ? DB : DS) difference() {
    union() {
        linear_extrude((T - G) / 2, convexity = 6) if (n == 0) ausleger_2d(); else stiel_2d();
        translate([0, 0, (T - G) / 2 - 0.01]) linear_extrude(G / 2 + 0.01, convexity = 6) difference() { if (n == 0) ausleger_2d(); else stiel_2d(); if (n == 0) ausleger_gabel_2d(); else stiel_gabel_2d(); }
    }
    translate([0, 0, -1]) linear_extrude(T) if (n == 0) ausleger_loecher_2d(); else stiel_loecher_2d();
    for (p = D) translate([K(p[0]), K(p[1]), T / 2 - d_dp(T)]) linear_extrude(d_dp(T) + 1) square(a_dw + 2 * es, center = true);
}
module haelfte_lokal(n, sy) let(T = n == 0 ? T_b : T_s)
    if (sy > 0) multmatrix([[1, 0, 0, 0], [0, 0, -1, T / 2], [0, 1, 0, 0], [0, 0, 0, 1]]) haelfte(n);
    else mirror([0, 1, 0]) multmatrix([[1, 0, 0, 0], [0, 0, -1, T / 2], [0, 1, 0, 0], [0, 0, 0, 1]]) haelfte(n);
module haelfte_druck(n, sy) if (sy > 0) haelfte(n); else mirror([0, 1, 0]) haelfte(n);
module duebel_lokal(n, i) let(T = n == 0 ? T_b : T_s, D = n == 0 ? DB : DS) translate([K(D[i][0]), 0, K(D[i][1])]) cube([a_dw, 2 * d_dp(T) - 0.4, a_dw], center = true);
function l_dw(n) = 2 * d_dp(n == 0 ? T_b : T_s) - 0.4;
module duebel_druck() for (n = [0, 1], i = [0, 1]) translate([(2 * n + i) * (a_dw + 3), 0, 0]) cube([a_dw, l_dw(n), a_dw]);

// =====================================================================
//  Greifer (lokal: Aufhängung im Ursprung, hängt nach -z)
// =====================================================================
module oese_2d() hull() { ci([0, 0], r_l); translate([-0.8 * r_l, -L_oe - 0.01]) square([1.6 * r_l, 0.02]); }
module greiferkopf_lokal() difference() {
    union() {
        translate([0, t_gl / 2, 0]) rotate([90, 0, 0]) linear_extrude(t_gl, convexity = 4) oese_2d();
        translate([0, 0, -L_oe - h_rot]) cylinder(r = r_rot, h = h_rot + 0.01, $fn = 48);
        translate([0, 0, z_hb]) cylinder(r = r_hd, h = h_hd + 0.01, $fn = 60);
        translate([0, 0, z_hb + h_hd - 0.01]) cylinder(r1 = r_hd, r2 = r_rot, h = min(h_rot * 0.5, r_hd - r_rot), $fn = 60);
    }
    hole_y([0, 0], r_h, -t_gl - 1, t_gl + 1);
    // 5 radiale Steckschlitze von unten, Decke als 45°-Dach
    let(w = t_sch + 2 * es) for (k = [0 : 4]) rotate(k * 72) translate([u_sl, 0, 0]) rotate([90, 0, 90]) linear_extrude(r_hd - u_sl + 1)
        polygon([[-w / 2, z_hb - 1], [w / 2, z_hb - 1], [w / 2, z_hb + d_sl], [0, z_hb + d_sl + w / 2], [-w / 2, z_hb + d_sl]]);
}
module greiferkopf_druck() translate([0, 0, -z_hb]) greiferkopf_lokal();
module schale_2d() {   // (u radial, z nach unten negativ), Oberkante bei z = 0, Zunge nach oben
    for (i = [0 : len(SCH) - 2]) hull() { ci(KP(SCH[i]), K(SCR[i])); ci(KP(SCH[i + 1]), K(SCR[i + 1])); }
    translate([u_sl + max(M(0.03), 0.3), -0.01]) square([K(0.26), d_sl - 0.3 + 0.01]);
    translate([K(0.2), -K(0.1)]) square([K(0.26), K(0.1)]);
}
module schale_lokal(k) rotate(k * 72) translate([0, t_sch / 2, z_hb]) rotate([90, 0, 0]) linear_extrude(t_sch, convexity = 4) schale_2d();
module schale_druck() translate([0, d_sl, 0]) linear_extrude(t_sch) schale_2d();
module greifer_lokal(ex = 0) {
    bunt(farbe_greifer) greiferkopf_lokal();
    for (k = [0 : 4]) translate([0, 0, -ex]) bunt(farbe_greifer) schale_lokal(k);
}

// =====================================================================
//  Handläufe (flach gedruckt, Zungen in Schlitze)
// =====================================================================
L_hl = K(0.5);  H_hl = M(0.5);  b_hl = max(M(0.05), 0.9);  t_hl = max(M(0.05), 1.2);  l_tb = max(M(0.15), 1.8);
HL = [[X_h + K(0.3), Y_o - K(0.22), Z_mh], [X_eh + K(0.25), -Y_o + K(0.16), Z_tk]];   // [x0, y, z]
module handlauf_2d() {
    translate([0, H_hl - b_hl]) square([L_hl, b_hl]);
    for (u = [0, (L_hl - b_hl) / 2, L_hl - b_hl]) translate([u, -l_tb]) square([b_hl, H_hl + l_tb]);
}
module handlauf_welt(i) translate([HL[i][0], 0, HL[i][2]]) xz(HL[i][1] - t_hl / 2, HL[i][1] + t_hl / 2) handlauf_2d();
module schlitz(x, y, z, lx, ly) translate([x - lx / 2 - es, y - ly / 2 - es, z - l_tb - 0.3]) cube([lx + 2 * es, ly + 2 * es, l_tb + 1.3]);

// =====================================================================
//  Zusammenbau
// =====================================================================
module in_ausleger(t) translate([F_p[0], y_b, F_p[1]]) rotate([0, -t, 0]) children();
module in_stiel(p) translate([T_p[0], 0, T_p[1]]) rotate([0, -p, 0]) children();
// Greifer hängt senkrecht: Welt-Punkt der Aufhängung
function G_welt(t, p) = let(q = T_p + rot2(G_p, p)) F_p + rot2(q, t);
module in_greifer(t, p, g) translate([G_welt(t, p)[0], y_b, G_welt(t, p)[1]]) rotate(g) children();
module ausruestung(t, p, g, ex = 0) {
    in_ausleger(t) {
        for (s = [-1, 1]) translate([0, s * ex * 0.5, 0]) bunt(farbe_gelb) haelfte_lokal(0, s);
        if (ex > 0) for (i = [0, 1]) bunt(farbe_gelb) duebel_lokal(0, i);
        translate([0, 0, ex * 0.5]) { bunt(farbe_zylinder) zyl_zw(S1_p, T_p + rot2(R_p, p), 0, "A", ZS, false, false);
                                      bunt(farbe_stange) zyl_zw(S1_p, T_p + rot2(R_p, p), 0, "B", ZS, false, false); }
        translate([ex * 0.8, 0, 0]) in_stiel(p) {
            for (s = [-1, 1]) translate([0, s * ex * 0.5, 0]) bunt(farbe_gelb) haelfte_lokal(1, s);
            if (ex > 0) for (i = [0, 1]) bunt(farbe_gelb) duebel_lokal(1, i);
        }
    }
    translate([ex * 0.8, 0, -ex * 0.8]) in_greifer(t, p, g) greifer_lokal(ex);
    for (s = [-1, 1]) translate([0, s * ex * 1.2, 0]) {
        bunt(farbe_zylinder) zyl_zw(CF_p, F_p + rot2(A_p, t), y_b + s * Y_hz, "A", ZH, true, true);
        bunt(farbe_stange) zyl_zw(CF_p, F_p + rot2(A_p, t), y_b + s * Y_hz, "B", ZH, true, true);
    }
}
module hubwerk(th, ex = 0) {
    for (k = [0, 1], s = [-1, 1]) translate([0, s * ex * 0.6, 0]) bunt(farbe_hubwerk) hubarm_welt(k, th, s);
    translate([0, 0, ex * 0.8]) in_traeger(th) {
        bunt(farbe_hubwerk) traeger_lokal();
        translate([0, 0, ex * 0.8]) { bunt(farbe_kabine) kabine_lokal("A"); translate([0, 0, -ex * 0.4]) bunt(farbe_glas) kabine_lokal("B"); }
    }
}
module umschlagbagger(ex = 0) {
    bunt(farbe_fahrgestell) fahrgestell_welt();
    for (s = [-1, 1], q = [-1, 1]) translate([0, 0, -ex * 0.6]) bunt(farbe_fahrgestell) stuetze_welt(s, q);
    for (s = [-1, 1]) bunt(farbe_fahrgestell) achse_welt(s * X_ax);
    for (i = [0 : 3]) { bunt(farbe_reifen) rad_welt(i, "A", ex); bunt(farbe_felge) rad_welt(i, "B", ex * 1.6); }
    translate([0, 0, ex]) rotate(ex > 0 ? 0 : drehung) {
        bunt(farbe_gelb) oberwagen_welt();
        for (i = [0, 1]) translate([0, 0, ex * 0.7]) bunt(farbe_anbau) handlauf_welt(i);
        hubwerk(STUFEN[ex > 0 ? 2 : kabine_stufe], ex);
        translate([ex * 0.8, 0, ex * 0.6]) ausruestung(ex > 0 ? 45 : ausleger_winkel, ex > 0 ? -75 : stiel_winkel, ex > 0 ? 0 : greifer_drehung, ex);
    }
}

// =====================================================================
//  Info und Ausgabe
// =====================================================================
L_ausl = T_p[0] + K(0.36) + K(0.28);
L_stl  = norm(G_p) + K(0.3) + K(0.24);
BOLZ = [["Auslegerfuß", 2 * (Y_lg + t_lg)], ["Hubzylinder unten", 2 * (Y_hz + hz)], ["Hubzylinder oben", 2 * (Y_hz + hs)],
        ["Stielzylinder am Ausleger", T_b], ["Stielgelenk", T_b], ["Stielzylinder am Stiel", T_s], ["Greifer am Stiel", T_s],
        ["Hubarme am Turm", 2 * (y_a0 + t_gs)], ["Rastbolzen", 2 * (y_a0 + t_gs)], ["Hubarme am Träger", 2 * (y_e0 + t_lg)]];
echo(str("Umschlagbagger 1:", den, " | Fahrgestell ", r2(2 * X_st + K(0.55)), " x ", r2(2 * (y_ri + B_zw)), " mm, Rad Ø ", r2(2 * R_w), " x ", r2(B_zw), " mm | Oberwagen ", r2(X_vo - X_h), " x ", r2(2 * Y_o), " mm, Kabine ", r2(Kw), " breit, Dach unten/oben ", r2(C1(0)[1] + KZ[1]), "/", r2(C1(75)[1] + KZ[1]), " mm | Ausleger ", r2(L_ausl), ", Stiel ", r2(L_stl), " mm"));
echo(str("Ausleger ", r2(T_b), " mm dick (Gabel ", r2(G_b), "), Stiel ", r2(T_s), " (Gabel ", r2(G_s), ") | Zylinder: Rohr Ø ", r2(2 * r_o), ", Stange Ø ", r2(2 * r_s), ", Auge Ø ", r2(2 * r_e), " | Kabine außen y ", r2(y_c + Kw / 2), " (Oberwagen ", r2(Y_o), ")"));
echo(str("Hubzylinder ", r2(ZH[0]), "–", r2(ZH[1]), " mm (Überdeckung ", r2(ov(ZH)), ") | Stielzylinder ", r2(ZS[0]), "–", r2(ZS[1]), " (", r2(ov(ZS)), ") | min ", r2(ov_min), " | Greifer ", r2(-z_hb + K(1.62) + K(0.045)), " mm hoch"));
echo(str("Filament-Bolzen Ø ", stift_d, ": ", [for (b = BOLZ) str(b[0], " ", r2(b[1]), " mm")]));
if (min(ov(ZH), ov(ZS)) < ov_min) echo("WARNUNG: Kolbenstange zu kurz für den Schwenkbereich");
if ((T_s - G_s) / 2 < 0.8) echo("WARNUNG: Gabelwangen im Stiel zu dünn");
if (2 * r_lk * sin(12.5) - 2 * r_h < 0.8) echo("WARNUNG: Rastlöcher zu dicht");
if (r_box - r_lk - r_h < 0.8) echo("WARNUNG: Rastlöcher zu nah an der Turmkante");
if (y_c - w_t / 2 < y_b + y_zb) echo("WARNUNG: Hubwerksturm in der Zylinderzone");
if (-Y_o > y_b - y_zb - K(0.25)) echo("WARNUNG: Tankkasten zu schmal");
if (max(L_ausl, L_stl, X_vo - X_h, 2 * X_st + K(0.55)) > usable) echo("WARNUNG: Teil größer als das Druckbett");
mass_echo(2 * X_st + K(0.55), 2 * (y_ri + B_zw), C1(75)[1] + KZ[1]);

druck("fahrgestell", 1, "alle", farbe_fahrgestell, 1);
druck("stuetze", 1, "alle", farbe_fahrgestell, 4);
druck("achse", 1, "alle", farbe_fahrgestell, 2);
druck("rad", 1, "A", farbe_reifen, 4); druck("rad", 1, "B", farbe_felge, 4);
druck("oberwagen", 1, "alle", farbe_gelb, 1);
druck("kabine", 1, "A", farbe_kabine, 1); druck("kabine", 1, "B", farbe_glas, 1);
druck("traeger", 1, "alle", farbe_hubwerk, 1);
druck("hubarm", 1, "alle", farbe_hubwerk, 4);
for (t = ["ausleger_links", "ausleger_rechts", "stiel_links", "stiel_rechts"]) druck(t, 1, "alle", farbe_gelb, 1);
druck("duebel", 1, "alle", farbe_gelb, 1);
druck("zylinder_ausleger", 1, "A", farbe_zylinder, 2); druck("zylinder_ausleger", 1, "B", farbe_stange, 2);
druck("zylinder_stiel", 1, "A", farbe_zylinder, 1); druck("zylinder_stiel", 1, "B", farbe_stange, 1);
druck("greiferkopf", 1, "alle", farbe_greifer, 1);
druck("schale", 1, "alle", farbe_greifer, 5);
druck("handlauf", 1, "alle", farbe_anbau, 2);
farben_echo();

if (teil == "aufbau") umschlagbagger();
else if (teil == "explosion") umschlagbagger(max(M(1.6), 12));
else if (teil == "fahrgestell") fahrgestell_druck();
else if (teil == "stuetze") stuetze_lokal();
else if (teil == "achse") achse_druck();
else if (teil == "rad") rad(farbteil);
else if (teil == "oberwagen") oberwagen_druck();
else if (teil == "kabine") kabine_druck(farbteil);
else if (teil == "traeger") traeger_druck();
else if (teil == "hubarm") linear_extrude(t_gs) hubarm_2d();
else if (teil == "ausleger_links") haelfte_druck(0, 1);
else if (teil == "ausleger_rechts") haelfte_druck(0, -1);
else if (teil == "stiel_links") translate([-R_p[0] + r_l + 1, 0, 0]) haelfte_druck(1, 1);
else if (teil == "stiel_rechts") translate([-R_p[0] + r_l + 1, 0, 0]) haelfte_druck(1, -1);
else if (teil == "duebel") duebel_druck();
else if (teil == "zylinder_ausleger") zylinder_druck(farbteil, ZH, true, true);
else if (teil == "zylinder_stiel") zylinder_druck(farbteil, ZS, false, false);
else if (teil == "greiferkopf") greiferkopf_druck();
else if (teil == "schale") schale_druck();
else if (teil == "handlauf") translate([0, l_tb, 0]) linear_extrude(t_hl) handlauf_2d();
