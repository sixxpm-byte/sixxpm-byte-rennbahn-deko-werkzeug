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
//  Maße (Welt: x = 0 Drehachse, +x nach vorne, +y links, z = 0 Boden; mm)
// =====================================================================
function K(m) = m * 1000 / den;
function KP(p) = [K(p[0]), K(p[1])];
function rot2(p, a) = [p[0] * cos(a) - p[1] * sin(a), p[0] * sin(a) + p[1] * cos(a)];
es    = einsatz_spiel;
sp    = spiel;
zyl_r_s_m = 0.05;  zyl_r_o_m = 0.10;      // schlanke Zylinder (Kabine sitzt dicht neben dem Ausleger)
zyl_r_s_min = 1.0; zyl_wand_min = 0.8;
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
//    g_zw > 0: Zwillingsrad – zwei Reifen mit V-Rille (Luft g_zw) auf einer durchgehenden
//    Felge, Gesamtbreite 2*B_w + g_zw (Innenreifen auf dem Bett)
// =====================================================================
module reifen_rad(fp, R_w, B_w, R_fe, d_rz, t_nb, g_zw = 0) {
    lip_h = max(M(0.03), 0.4); lip_w = max(M(0.08), 0.8); lip_t = lip_h + lip_w;   // Innenrand: senkrecht, dann 45°-Konus
    c_t = min(M(0.28), 0.4 * B_w); n_p = 18; g_d = max(M(0.11), 0.8);   // Schulterfase, bei schmalen Reifen begrenzt
    zw = g_zw > 0; c_v = min(M(0.12), 0.45 * B_w); H2 = zw ? 2 * B_w + g_zw : B_w;
    prof = zw ? [[R_fe - lip_w, 0], [R_w - 0.7 * c_t, 0], [R_w, c_t], [R_w, B_w - c_v], [R_w - c_v, B_w], [R_w - c_v, B_w + g_zw],
                 [R_w, B_w + g_zw + c_v], [R_w, H2 - c_t], [R_w - c_t, H2], [R_fe, H2], [R_fe, lip_t], [R_fe - lip_w, lip_h]]
              : [[R_fe - lip_w, 0], [R_w - 0.7 * c_t, 0], [R_w, c_t], [R_w, B_w - c_t], [R_w - c_t, B_w], [R_fe, B_w], [R_fe, lip_t], [R_fe - lip_w, lip_h]];
    if (inc(fp, "A")) difference() {
        rotate_extrude($fn = 96, convexity = 6) polygon(prof);
        // Stollen: je Reifenhälfte schräge Rillen, in der Mitte zum V verbunden (keine Überhänge)
        for (t0 = zw ? [0, B_w + g_zw] : [0], hf = [0, 1]) translate([0, 0, t0 + hf * B_w / 2 - (hf == 0 ? 0.01 : 0)])
            linear_extrude(B_w / 2 + 0.01, twist = hf == 0 ? 9 : -9, slices = 6, convexity = 6)
            rotate(hf == 0 ? 0 : -9) for (k = [0 : n_p - 1]) rotate(k * 360 / n_p)
                translate([R_w - g_d, -R_w * PI / n_p * 0.42]) square([g_d + 2, R_w * 2 * PI / n_p * 0.42]);
    }
    if (inc(fp, "B")) let(r_f = R_fe - einsatz_spiel, w_fl = max(M(0.08), 0.8), r_hb = max(M(0.32), d_rz / 2 + 1.2), rec = M(0.14)) difference() {
        union() {
            rotate_extrude($fn = 96, convexity = 4) polygon([[0, 0], [R_fe - lip_w - einsatz_spiel, 0], [R_fe - lip_w - einsatz_spiel, lip_h], [r_f, lip_t], [r_f, H2 - rec], [0, H2 - rec]]);
            difference() { translate([0, 0, lip_t]) cylinder(r = r_f, h = H2 - M(0.03) - lip_t, $fn = 96); translate([0, 0, -1]) cylinder(r = r_f - w_fl, h = H2 + 2, $fn = 96); }
            cylinder(r = r_hb, h = H2 - M(0.05), $fn = 48);
            cylinder(r = r_hb * 0.55, h = H2 - M(0.01), $fn = 32);
            for (k = [0 : 11]) rotate(k * 30) translate([(r_hb + r_f - w_fl) / 2, 0, 0]) cylinder(r = max(M(0.04), 0.5), h = H2 - rec + max(M(0.04), 0.4), $fn = 10);
        }
        translate([0, 0, -1]) cylinder(d = d_rz + spiel, h = t_nb + 1, $fn = 32);
    }
}

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
