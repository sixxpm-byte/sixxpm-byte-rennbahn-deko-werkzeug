// =====================================================================
//  RAUPENBAHN (50er-Jahre Rock'n'Roll-Edition)  –  zerlegbarer Deko-Bausatz
//  Klassisches Kirmes-Fahrgeschäft: Wagen an Auslegern fahren im Kreis
//  über eine Wellenbahn, das grüne Verdeck macht daraus die "Raupe".
//  Reihe Rennbahn-Deko: alle gängigen Maßstäbe, FDM-optimiert
//  (stützfrei), zu große Teile werden automatisch geteilt (Clips),
//  Stecksystem kompatibel zu rennbahn_deko.scad, Farben je Bauteil
//  (Vorschau, Dateinamen, 3MF über farb_export.py)
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    podest            Podest, 16-eckig, hohl mit Rippen, kopfüber gedruckt
//    umgang            welliger Holzsteg (Raupenwelle, starr) mit rotem Rand
//    treppe            Treppe (3 Stufen, folgt der Welle) an der Front   3x
//    zaun              Geländer, folgt der Welle (jede Seite eigene Form) 13x
//    koenigszapfen     Mittelzapfen, auf dem der Rotor dreht
//    rotor             Drehkranz mit Lagermulden für die Ausleger
//    ausleger          Ausleger mit Querachse und Wagenzapfen    je Wagen
//    schiene           Wellenbahn (Laufschiene + Außenwand), Kreissegmente
//    wagen             Wagen mit Kronen-Wappen und Zierrädern
//    sitz              Sitzbank mit hoher Lehne                  je Wagen
//    verdeck           Verdeck-Segment der "Raupe" (abnehmbar)
//    verdeck_kopf      Verdeck mit Raupengesicht
//    mittelbau_boden / mittelbau_wand / mittelbau_deckel / kuppel   Baldachin:
//                      12 offene Arkaden (Rundbögen), Deckel und Kuppel als Dach
//    saeule            Säule im Zuckerstangen-Look (rot/weiß/blau)     16x
//    dach              Ringdach (Torus-Wulst mit Punkten), Segmente
//    blende            Frontblende mit Sonnenmotiv                     16x
//    notenschluessel   Notenschlüssel an den Säulen                    16x
//    schild            Schild "RAUPENBAHN" mit Saxophonen und Noten
//    pflanze           Pflanzkübel                                      2x
//    haus_*            Kassenhäuschen
//    verbinder         Clips für alle geteilten Teile
//
//  BEWEGLICH
//    * Der Rotor dreht sich auf dem Königszapfen, der Mittelbau dreht mit.
//    * Jeder Ausleger liegt mit seiner Querachse lose in einer Mulde des
//      Rotors und gleitet über die Wellenschiene: beim Drehen heben und
//      senken sich die Wagen wie beim Vorbild.
//    * Die Verdecke sind abnehmbar (offen wie auf dem Foto oder als Raupe).
//
//  MONTAGE (Kurzfassung)
//    1. Podest-Stücke umdrehen, Clips einsetzen, umdrehen. Wellenbahn in die
//       Spurrille legen und verclipsen, welligen Umgang außen auflegen
//       (verclipst). Königszapfen in die Mitte stecken.
//    2. Rotor auf den Zapfen, Ausleger in die Mulden legen, Wagen auf die
//       Zapfen stecken, Sitzbänke einlegen.
//    3. Mittelbau: Boden auf die Säulen des Rotors, 12 Wände, Deckel, Kuppel.
//    4. 16 Säulen in das Podest, Dach (verclipst) aufsetzen, Frontblenden und
//       Notenschlüssel in die Nut, Schild in die Löcher stecken.
//    5. Treppen, Geländer, Pflanzen, Kasse aufstellen.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, podest:Podest, umgang:Welliger Umgang, treppe:Treppe, zaun:Geländer, koenigszapfen:Königszapfen, rotor:Rotor (Drehkranz), ausleger:Ausleger, schiene:Wellenbahn, wagen:Wagen, sitz:Sitzbank, verdeck:Verdeck (Raupe), verdeck_kopf:Raupenkopf, mittelbau_boden:Mittelbau Boden, mittelbau_wand:Baldachin-Arkade, mittelbau_deckel:Mittelbau Deckel, kuppel:Kuppel, saeule:Säule, dach:Dach, blende:Frontblende, notenschluessel:Notenschlüssel, schild:Schild RAUPENBAHN, pflanze:Pflanzkübel, haus_boden:Kasse Boden, haus_wand_vorne:Kasse Wand vorne, haus_wand_hinten:Kasse Wand hinten, haus_wand_links:Kasse Wand links, haus_wand_rechts:Kasse Wand rechts, haus_dach:Kasse Dach, haus_schild:Kasse Schild, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück (bei Wagen mit Nummern: Wagennummer)
stueck = 0;
// Mehrfarbige Teile: alle oder einzelne Farbe (A = Grundkörper)
farbteil = "alle"; // [alle, A, B, C, D]

/* [Vorschau] */
// Drehung des Rotors (Grad)
drehung = 0;          // [0:360]
// Verdecke geschlossen zeigen (Raupe)
verdeck_zeigen = false;
kassenhaus_zeigen = true;

/* [Raupenbahn (Vorbild in Metern)] */
wagen_anzahl = 20;    // [12:1:24]
// Anzahl der Wellenberge
wellen = 3;           // [2:1:4]
wellen_hoehe_m = 0.5;
podest_hoehe_m = 0.5;
// Dachunterkante über dem Podest
dach_hoehe_m = 3.3;
// fortlaufende Nummern auf den Wappen (jeder Wagen eine eigene Datei)
wagen_nummern = false;
// ein Verdeck mit Raupengesicht
raupenkopf = true;
schild_oben = "RAUPENBAHN";
schild_schrift = "Liberation Sans:style=Bold";

/* [Kasse (Vorbild in Metern)] */
// Holzbude oder Flightcase-Look
haus_stil = "holz"; // [flightcase, holz]
haus_breite_m = 2.4;
haus_tiefe_m  = 1.8;
haus_hoehe_m  = 2.3;
tuer = "links"; // [links, rechts]
schild_text = "RAUPENBAHN";
kasse_text  = "KASSE";
schild_font = "Liberation Sans:style=Bold";

/* [Farben] */
farbe_podest      = "braun";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_podest_rand = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_treppe      = "braun";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_zaun        = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_technik     = "grau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_bahn        = "anthrazit"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schiene     = "silber";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_wagen       = "hellblau";  // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_wagen_zier  = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_krone       = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_sitz        = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_verdeck     = "dunkelgruen"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_verdeck_ring = "gelb";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_augen       = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_pupillen    = "schwarz";   // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mittelbau   = "blau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mittelbau_rahmen = "gold"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mittelbau_motiv  = "weiss"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mittelbau_platte = "rot";  // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kuppel      = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gold        = "gold";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_saeule_1    = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_saeule_2    = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_saeule_3    = "blau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_dach        = "blau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_punkte_1    = "gelb";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_punkte_2    = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_blende      = "creme";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_blende_rahmen = "blau";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_sonne       = "orange";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_licht       = "gelb";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_notenschluessel = "silber"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild      = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schrift     = "blau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_noten       = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kuebel      = "anthrazit"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_pflanze     = "gruen";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haus_boden  = "grau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haus_wand   = "gelb";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haus_kanten = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haus_dach   = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild_A    = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild_B    = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_clips       = "grau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

/* [Druck & Passung] */
rennbahn_taschen = true;
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;

include <../../lib/deko_grundlagen.scad>

// =====================================================================
//  Maße  (Vorbild in Metern, über M() skaliert)
// =====================================================================
N_d = 16; ad = 360 / N_d; tc = cos(ad / 2);      // Podest/Dach: 16-Eck
FRONT = 12;                                      // Seite zum Betrachter (-y)
N_w = wagen_anzahl; pw = 360 / N_w;
dmr = max(sc(20), 0.3);                          // Relief

// ---- radiale Anordnung ----
r_piv = M(2.4);                                  // Gelenk der Ausleger
r_R   = M(6.6);                                  // Laufschiene
r_c   = M(7.75);                                 // Wagenmitte
B_w   = M(1.45); L_w = M(1.9);                   // Wagenbreite / -länge
u_c   = r_c - r_piv; u_R = r_R - r_piv;
R_p   = M(10.6);                                 // Podest (Inkreis)
R_pc  = R_p / tc;

// ---- Höhen und Wellen ----
H_p   = M(podest_hoehe_m, 5); z_f = H_p;         // Oberkante Podest
h0    = M(0.4, 3.2);                             // Schienenhöhe im Wellental
A_w   = M(wellen_hoehe_m);

// ---- Ausleger ----
u_pg  = u_c - M(0.3);                            // Wagenzapfen
u_tip = u_pg + M(0.15);
L_x   = min(M(0.55), 2 * PI * r_piv / N_w - M(0.2));   // Querachse
b_ab  = min(M(0.32), L_x - M(0.16));             // Breite am Gelenk
b_at  = max(M(0.2), 2.4);                        // Breite außen
arm_len0 = u_tip + max(sc(160), 2.4) / 2 + 1;
arm_rot  = arm_len0 + 2 <= usable ? 0 : (arm_len0 + L_x) * 0.7072 + 2 <= usable ? 45 : -1;
arm_split = arm_rot < 0;
t_arm = max(sc(120), 1.6, arm_split ? b_cl : 0);
d_x   = max(sc(160), t_arm + 0.6, 2.4);
c_x   = t_arm / 2;
a_pg  = max(sc(110), 1.8); l_pg = max(sc(100), 2);
z_piv = z_f + h0 + A_w / 2 + t_arm / 2;
function hz(th) = z_f + h0 + A_w * (1 - cos(wellen * (th - 270))) / 2;   // Schienenoberkante (Wellental vorn)
function phi(th) = let(z = hz(th) - z_piv, p0 = asin((z + t_arm / 2) / u_R)) asin((z + t_arm / 2 * cos(p0)) / u_R);
// Linie der Armunterseite (w = -t_arm/2) bzw. Wagenunterseite (w = +t_arm/2) bei Radius r
function z_line(r, th, w) = let(p = phi(th)) z_piv + (r - r_piv) * tan(p) + w / cos(p);
s_max = (A_w / 2 + t_arm) / u_R + 0.02;          // größte Armneigung (tan)
module arm_frame(th) rotate([0, 0, th]) translate([r_piv, 0, z_piv]) rotate([0, -phi(th), 0]) children();
module car_frame(th) arm_frame(th) translate([u_c, 0, t_arm / 2]) children();

// ---- Rotor & Königszapfen ----
w_lip = max(sc(80), 1.2);
r_rw0 = r_piv - d_x / 2 - spiel - w_lip; r_rw1 = r_piv + d_x / 2 + spiel + w_lip;
R_rot = r_rw1 + max(sc(40), 0.6);
rot_split = 2 * R_rot > usable;
t_rot = max(sc(150), 2.0, rot_split ? b_cl : 0);
h_kz  = max(sc(150), 2);
z_r0  = z_f + h_kz;                              // Rotor-Unterseite
zl_piv = z_piv - z_r0;
zl_tb = zl_piv - d_x / 2 - spiel;                // Muldenboden
zl_wt = zl_piv + d_x * 0.3;                      // Oberkante Ringwand
d_kz  = max(sc(250), 3.5);
d_kc  = d_kz + 2 * max(sc(150), 2);              // Bund
R_mb  = M(1.45);                                 // Turm (Baldachin), Inkreis
N_col = 6; a_col = max(sc(160), 2.6); r_col = min(r_rw0 - a_col * 0.8, R_mb * 0.55);
a_cp  = max(a_col * 0.55, 1.6); l_cp = max(sc(120), 2);
function col_a(j) = j * 360 / N_col + pw / 2;

// ---- Wellenbahn ----
t_rl  = max(sc(120), 1.4);
t_ow  = max(sc(100), 1.2);
r_ow  = r_c + B_w / 2 + M(0.12) + t_ow / 2;
g_tr  = max(sc(25), 0.5);
h_ti  = max(M(0.2), b_cl);
w_ti  = max(sc(150), 1.6);
clr_o = M(0.06);
// Querneigung der Welle: Schiene etwas tiefer, damit die Armkante nicht aufsetzt
clr_r = A_w / 2 * wellen / r_R * b_ab / 2 * 1.25 + 0.05;
z_tb  = z_f - g_tr;                              // Unterkante Bahn
r_jc  = (r_R + r_ow) / 2;
l_jb  = cL + 5;
tr_r0 = r_R - t_rl / 2; tr_r1 = r_ow + t_ow / 2;

// ---- Wagen ----
z_rim = M(0.55); t_wa = max(sc(60), 1.2);
t_fl  = max(sc(100), l_pg + 1.1);
rr_w  = M(0.22);
al_c  = deg(L_w / 2 / r_c);
Y_fd  = L_w / 2 - M(0.5);                        // Beginn Vorderdeck
Y_sf  = -M(0.12);                                // Vorderkante Sitz
r_wh  = M(0.15); t_wh = M(0.05); h_bd = max(M(0.04), 0.5);
Y_wh  = M(0.48); z_wc = r_wh + t_wh + h_bd + M(0.01);
H_arch = M(1.0); t_hd = max(sc(70), 1.2); t_sk = max(sc(50), 0.8); d_tg = M(0.06);
be_h  = pw / 2 - deg(M(0.05) / r_c);             // halber Verdeckwinkel
a_o   = B_w / 2 + spiel + t_sk; a_i = B_w / 2 - t_wa;
hood_h = (r_c + a_o) * sin(2 * be_h) + 1;        // Druckhöhe eines Verdecks
n_hs  = max(1, ceil(hood_h / (usable - 5)));

// ---- Mittelbau ----
N_m = 12; am = 30; tcm = cos(am / 2);
mb_split = 2 * (R_mb + M(0.15)) / tcm > usable;
t_mb = max(sc(120), 2.0, mb_split ? b_cl : 0);
z_mb = max(z_r0 + zl_wt + 1.0, z_piv + t_arm / 2 + (R_mb / tcm - r_piv) * s_max + 1.0, z_f + M(0.9));
zl_mb = z_mb - z_r0;
H_mw = M(2.3);
g_m  = max(sc(60), 1.0);
R_mp = R_mb - M(0.05);                           // Außenseite Wände
L_mp0 = 2 * R_mp * tan(am / 2);
t_mp = max(sc(80), 1.6, L_mp0 > usable ? b_cl : 0);
L_mp = 2 * (R_mp - t_mp) * tan(am / 2) - 0.3;
H_mp = H_mw + 2 * g_m - 0.2;
t_md = max(sc(120), g_m + 1.0, mb_split ? b_cl : 0);
R_md = R_mb + M(0.15);
z_md = z_mb + t_mb + H_mw;
R_k  = R_mb * 0.82; H_k = M(1.3); t_kw = max(sc(70), 1.2); h_kr = max(sc(100), 1.5);
z_k0 = z_md + t_md;

// ---- Säulen, Dach, Blenden ----
z_u  = z_f + M(dach_hoehe_m);                    // Dachunterkante
r_po = max(sc(110), 1.4);
a_ps = max(sc(120), 1.8); l_ps = max(sc(200), 2.5);
P_st = M(1.4);                                   // Steigung der Streifen
R_f  = M(9.9);                                   // Mittelebene der Blenden (Inkreis)
t_cf = max(sc(80), 1.2);                         // Notenschlüssel-Front
w_ct = max(sc(260), 4);                          // Notenschlüssel-Steg
L_fp = 2 * R_f * tan(ad / 2) - 2 * (w_ct / 2 + 0.3) / tc - 2 * max(sc(100), 1.6) * tan(ad / 2);   // Blendenlänge
t_f  = max(sc(100), 1.6, L_fp > usable ? b_cl : 0);
rho_cl = (R_f + t_f / 2) / tc + spiel;           // Rückseite der Notenschlüssel-Front
lip  = max(sc(120), 1.2);
R_ro = (rho_cl + t_cf + spiel + lip) * tc;       // Dachrand (Inkreis)
rho_po = min((R_f - t_f / 2 - r_po - M(0.03)) / tc, rho_cl - t_f - spiel - r_po - M(0.03));
R_b1 = (rho_po - r_po) * tc - max(M(0.15), 1.5); // Ende der Wulst
R_ri = M(4.6);                                   // Innenrand
w_ib = M(0.35);
g_f  = max(sc(150), 1.5);
d_rs = max(sc(200), 2.5);
H_b  = M(1.05);                                  // Wulsthöhe
t_sh = max(sc(50), min_wand);
h_f  = M(1.1);                                   // Blendenhöhe über dem Dachrand
PP_DACH_FIT = 2 * R_ro / tc > usable;
t_bd = max(M(0.3), g_f + 0.8, d_rs + 0.8, PP_DACH_FIT ? b_cl : 0);
H_po = z_u - z_f;                                // Säulenhöhe
n_ps = max(1, ceil((H_po + l_ps + d_rs) / (usable - 5)));
function top(r) = r <= R_ri ? z_u + t_bd : r >= R_b1 ? z_u + t_bd :
    z_u + t_bd + H_b * pow(sin(180 * (r - R_ri) / (R_b1 - R_ri)), 0.7);
r_cr = (R_ri + R_b1) / 2;
// Schild steht auf der äußeren Flanke, Unterkante etwas unter der Blendenoberkante
SG_R = [for (k = [0 : 60]) let(r = r_cr + k * (R_b1 - r_cr) / 60) if (top(r) <= z_u + t_bd + 0.72 * h_f) r];
r_sg = len(SG_R) > 0 ? SG_R[0] : R_b1 - M(0.3);
W_sb = M(5.4); H_sb = M(1.5); H_sa = M(0.35);
H_sx = M(2.6);                                   // Saxophonhöhe
w_lg = max(sc(220), 3); d_lh = max(sc(250), 3);
x_lg = W_sb * 0.3;
z_sb = top(r_sg) + M(0.15);
l_lg = M(0.15) + d_lh;
SX_sg = W_sb + 2 * (M(0.05) + 0.58 * H_sx);
t_sg = max(sc(80), 1.6, SX_sg > usable ? b_cl : 0);

// ---- Geländer, Treppe, Pflanzen ----
ZK  = [for (j = [0 : 12]) (14 + j) % N_d];          // Geländer: gegen den Uhrzeigersinn ab rechts der Treppe
STK = [11, 12, 13];
t_z = max(sc(60), 1.2);
R_z = R_p - M(0.12) - t_z / 2;
L_z = 2 * (R_z - t_z) * tan(ad / 2) - M(0.25);
t_z2 = max(t_z, L_z > usable ? b_cl : 0);
h_zg = M(1.0);
w_zp = max(sc(150), 2);
X_ZP = [-L_z * 0.36, L_z * 0.36];
d_st = M(0.35, 3);
r_pt = M(0.33); h_pt = M(0.6); r_bu = M(0.55); h_bu = M(0.9);

include <../../lib/deko_kasse.scad>

include <../../lib/deko_hilfen.scad>
include <../../lib/deko_ornamente.scad>

// =====================================================================
//  WELLENBAHN  (Laufschiene innen = Gleitbahn der Ausleger, Außenwand)
// =====================================================================
PS = pp_band(tr_r0, tr_r1, ad / 4, false, false);      // Kreissegmente
PS_SE = pp_seams(PS);
n_ti = max(len(PS_SE) * 2, round(2 * PI * r_jc / M(1.6)));
TIES = [for (j = [0 : n_ti - 1]) let(a = ad / 4 + (j + 0.5) * 360 / n_ti)
        if (min(concat([999], [for (sa = PS_SE) adiff(a, sa) * PI / 180 * r_jc])) > (l_jb + w_ti) / 2 + 2) a];
CL_BAHN = [for (a = PS_SE) concat(pol(r_jc, a), [a + 90])];
// Ring-Polyeder mit welliger Oberkante:
//   mode 0: Arm-/Wagenlinie (a = w) minus b     mode 1: Umgang-Oberkante minus a
//   mode 2: a * Umgang-Oberkante (Treppenstufen)
function wtop(r, t, mode, a, b) = mode == 0 ? z_line(r, t, a) - b : mode == 1 ? z_wk(t) - a : z_wk(t) * a;
module wave_ring(r0, r1, zb, mode, a = 0, b = 0, n = 240) {
    pts = [for (i = [0 : n - 1]) let(t = i * 360 / n) each [
        [r0 * cos(t), r0 * sin(t), zb], [r1 * cos(t), r1 * sin(t), zb],
        [r1 * cos(t), r1 * sin(t), wtop(r1, t, mode, a, b)], [r0 * cos(t), r0 * sin(t), wtop(r0, t, mode, a, b)]]];
    fcs = [for (i = [0 : n - 1]) let(j = (i + 1) % n, a = 4 * i, b = 4 * j) each [
        [a + 1, a + 2, b + 2], [a + 1, b + 2, b + 1], [b + 0, b + 3, a + 3], [b + 0, a + 3, a + 0],
        [b + 3, b + 2, a + 2], [b + 3, a + 2, a + 3], [a + 0, a + 1, b + 1], [a + 0, b + 1, b + 0]]];   // Dreiecke (Oberseite ist nicht eben)
    polyhedron(pts, fcs, convexity = 6);
}
module bahn_fuss_2d(o = 0) {
    ring2(r_R, t_rl + 2 * o); ring2(r_ow, t_ow + 2 * o);
    for (a = TIES) rotate(a) translate([r_R, -w_ti / 2 - o]) square([r_ow - r_R, w_ti + 2 * o]);
    for (a = PS_SE) rotate(a) translate([r_R, -l_jb / 2 - o]) square([r_ow - r_R, l_jb + 2 * o]);
}
h_jb = max(h_ti + g_tr, ch + spiel + 1.2);
module bahn_welt(fp = "alle") {
    if (inc(fp, "B")) wave_ring(r_R - t_rl / 2, r_R + t_rl / 2, z_tb, 0, -t_arm / 2, clr_r);
    if (inc(fp, "A")) difference() {
        union() {
            wave_ring(r_ow - t_ow / 2, r_ow + t_ow / 2, z_tb, 0, t_arm / 2, clr_o);
            for (a = TIES) rotate(a) translate([r_R + t_rl / 2, -w_ti / 2, z_tb]) cube([r_ow - t_ow / 2 - r_R - t_rl / 2 + e, w_ti, h_ti + g_tr]);
            for (a = PS_SE) rotate(a) translate([r_R + t_rl / 2, -l_jb / 2, z_tb]) cube([r_ow - t_ow / 2 - r_R - t_rl / 2 + e, l_jb, h_jb]);
        }
        for (c = CL_BAHN) translate([c[0], c[1], z_tb]) clip_cut(c[2], false, 0);
    }
}
z_bt = z_piv + (r_ow + t_ow - r_piv) * s_max + t_arm + 2;   // obere Schranke Bahn
// Oberkante des welligen Umgangs = Oberkante der Bahn-Außenwand (radial waagrecht)
function z_wk(t) = z_line(r_ow + t_ow / 2, t, t_arm / 2) - clr_o;
WK_MIN = min([for (a = [0 : 2 : 358]) z_wk(a)]) - z_f;      // niedrigste Umganghöhe über dem Podest
l_zp = max(1.5, min(WK_MIN - 1.0, max(sc(250), 2.5)));       // Geländerzapfen im Umgang
module bahn_druck(stk, fp) pp_druck(PS, stk, tr_r1 + 2, z_tb, z_bt) bahn_welt(fp);

// =====================================================================
//  PODEST  (hohl, Rippen, Deckplatte; kopfüber gedruckt)
// =====================================================================
t_pp = max(sc(60), 1.2);
t_pw = max(sc(80), 1.2);
b_cp = b_cl + dmr;
PP_POD = polar_pieces(0, R_pc, vtx(-1));
PO = [for (j = [0 : N_d - 1]) pol(rho_po, vtx(j))];                      // Säulen
ZP = [for (k = ZK, x = X_ZP) rotp([R_z, x], sidec(k))];        // Geländerzapfen
CL_POD = [for (c = pp_clips(PP_POD, d_kz + 2 * t_pw + 2, R_p - t_pw - 1))
          if (!near(c, PO, a_ps + mw + 3) && norm([c[0], c[1]]) > d_kz + mw + 4
              && (norm([c[0], c[1]]) < tr_r0 - mw - 2 || norm([c[0], c[1]]) > tr_r1 + mw + 2)) c];
RB_K = [0, 4, 8];
module podest_welt(fp = "alle") {
    lb = cL / 2 + 2; wb = cw1 + 4; hb = ch + spiel + 1.2;
    difference() {
        union() {
            if (inc(fp, "A")) {
                translate([0, 0, H_p - t_pp]) linear_extrude(t_pp) poly(R_p - t_pw + e);
                intersection() {
                    linear_extrude(H_p) poly(R_p - t_pw + e);
                    union() {
                        for (j = [0 : N_d - 1]) rotate(vtx(j)) translate([0, -t_pw / 2, 0]) cube([R_pc, t_pw, H_p]);
                        for (r = [M(1.2), (M(1.2) + tr_r0) / 2, r_R, r_ow]) linear_extrude(H_p) ring2(r, t_pw);
                        translate([0, 0, H_p - t_pp - g_tr]) linear_extrude(g_tr + e) difference() { circle(r = tr_r1 + M(0.1), $fa = 1); circle(r = tr_r0 - M(0.1), $fa = 1); }
                        cylinder(r = d_kz * 0.75 + t_pw + spiel, h = H_p);
                        for (p = PO) translate(p) cylinder(r = a_ps * 0.75 + t_pw, h = H_p, $fn = 16);
                        for (c = CL_POD) translate([c[0], c[1], H_p - b_cp]) cylinder(r = r_cb, h = b_cp, $fn = 20);
                        for (k = RB_K) side_frame(k, R_p - t_pw - lb) translate([0, -wb / 2, 0]) cube([lb + e, wb, hb]);
                    }
                }
            }
            if (inc(fp, "B")) linear_extrude(H_p) difference() { poly(R_p); poly(R_p - t_pw); }
        }
        // Säulen, Königszapfen
        for (j = [0 : N_d - 1]) translate(concat(PO[j], [-1])) rotate(vtx(j)) translate([-a_ps / 2 - spiel, -a_ps / 2 - spiel, 0]) cube([a_ps + 2 * spiel, a_ps + 2 * spiel, H_p + 2]);
        translate([-d_kz / 2 - spiel, -d_kz / 2 - spiel, -1]) cube([d_kz + 2 * spiel, d_kz + 2 * spiel, H_p + 2]);
        // Spurrille der Wellenbahn
        translate([0, 0, H_p - g_tr]) linear_extrude(g_tr + 1) bahn_fuss_2d(spiel);
        for (c = CL_POD) translate([c[0], c[1], H_p - b_cp]) clip_cut(c[2], false, 0);
        if (rennbahn_taschen) for (k = RB_K) rotate(sidec(k) + 180) translate([-R_p, 0, 0]) rb_slot();
    }
}
module podest_druck(stk, fp) pp_druck(PP_POD, stk, R_pc + 2, 0, H_p, true) podest_welt(fp);

// =====================================================================
//  UMGANG  (welliger Holzsteg auf dem Podest, starr; folgt der Raupenwelle)
// =====================================================================
r_w0 = r_ow + t_ow / 2 + spiel;                  // innen: an der Bahn-Außenwand
t_wd = max(sc(60), 1.2);                         // Deck
PW = pp_band(r_w0, R_pc, vtx(-1), false, false);
CL_WEG = [for (c = pp_clips(PW, r_w0 + t_pw, R_p - t_pw - 1, 30)) if (!near(c, PO, r_po + mw + 3)) c];
n_wr = max(0, ceil((R_p - t_pw - r_w0 - t_pw) / 15) - 1);   // Ringrippen: Brücken <= 15 mm
WRIB = [for (j = [1 : 1 : n_wr]) r_w0 + t_pw + j * (R_p - t_pw - r_w0 - t_pw) / (n_wr + 1)];
n_pl = round(2 * PI * R_p / M(0.45, 3));          // Dielenfugen (radial)
w_pl = max(sc(25), 0.4);
module weg_voll() intersection() { wave_ring(r_w0, R_pc + 1, z_f, 1, 0); translate([0, 0, z_f - 1]) linear_extrude(z_bt, convexity = 6) poly(R_p); }
module weg_welt(fp = "alle") {
    if (inc(fp, "A")) difference() {
        intersection() { wave_ring(r_w0, R_pc + 1, z_f, 1, 0); translate([0, 0, z_f - 1]) linear_extrude(z_bt, convexity = 6) poly(R_p - t_pw); }   // Rand = Farbe B
        if (!$preview) difference() {   // Hohlraum, unten offen (in der Vorschau weggelassen: CSG-Baum)
            intersection() { wave_ring(r_w0 + t_pw, R_pc, z_f - 1, 1, t_wd); translate([0, 0, z_f - 2]) linear_extrude(z_bt, convexity = 6) poly(R_p - t_pw); }
            for (r = WRIB) translate([0, 0, z_f - 2]) linear_extrude(z_bt, convexity = 6) ring2(r, min_wand);
            for (p = PO) translate(concat(p, [z_f - 2])) cylinder(r = r_po + 2 * spiel + t_pw, h = z_bt, $fn = 24);
            for (p = ZP) translate(concat(p, [z_f - 2])) cylinder(r = w_zp * 0.75 + t_pw + 0.5, h = z_bt, $fn = 16);
            for (c = CL_WEG) translate([c[0], c[1], z_f - 2]) cylinder(r = r_cb, h = z_bt, $fn = 20);
        }
        // Säulen gehen durch den Umgang ins Podest
        for (p = PO) translate(concat(p, [z_f - 1])) cylinder(r = r_po + 2 * spiel, h = z_bt, $fn = 24);
        // Geländerzapfen
        for (k = ZK, x = X_ZP) let(a = sidec(k) + atan2(x, R_z)) side_frame(k, R_z) translate([-t_z2 / 2 - spiel, x - w_zp / 2 - spiel, z_wk(a) - l_zp - 0.4]) cube([t_z2 + 2 * spiel, w_zp + 2 * spiel, z_bt]);
        // Dielenfugen
        for (j = [0 : n_pl - 1]) let(a = j * 360 / n_pl) rotate(a) translate([r_w0 + t_pw, -w_pl / 2, z_wk(a) - dmr]) cube([R_p - t_pw - r_w0 - t_pw, w_pl, z_bt]);
        if (!$preview) for (c = CL_WEG) translate([c[0], c[1], z_f]) clip_cut(c[2], false, 0);
    }
    if (inc(fp, "B")) difference() {
        intersection() { wave_ring(R_p - t_pw - 1, R_pc + 1, z_f, 1, 0); translate([0, 0, z_f - 1]) linear_extrude(z_bt, convexity = 6) difference() { poly(R_p); poly(R_p - t_pw); } }
        for (c = CL_WEG) translate([c[0], c[1], z_f]) clip_cut(c[2], false, 0);
    }
}
module weg_druck(stk, fp) pp_druck(PW, stk, R_pc + 2, z_f, z_bt) weg_welt(fp);

// ---- Treppe (Seite FRONT ± 1): Stufen folgen der Welle des Umgangs ----
module treppe_welt(k) {
    r0 = R_p + spiel;
    intersection() {
        union() for (i = [1 : 3]) intersection() {
            wave_ring(r0 - 1, (r0 + i * d_st) / tc + 1, 0, 2, (4 - i) / 4);
            translate([0, 0, -1]) linear_extrude(z_bt + 2, convexity = 6) difference() { poly(r0 + i * d_st); poly(r0); }
        }
        translate([0, 0, -1]) linear_extrude(z_bt + 2, convexity = 6) wedge_mask(sidec(k) - ad / 2, sidec(k) + ad / 2, R_p + 4 * d_st);
    }
}
module treppe_druck(stk) for (q = [0 : len(STK) - 1]) if (stk == 0 || stk == q + 1)
    translate([(stk == 0 ? q * (3 * d_st + 5) : 0) - (R_p + spiel), (R_p + 3 * d_st) * tan(ad / 2) + 1, 0]) rotate(-sidec(STK[q])) treppe_welt(STK[q]);

// ---- Geländer: Unterkante folgt der Welle (jede Seite eigene Form) ----
function zg_a(k, x) = sidec(k) + atan2(x, R_z);
function zg_b(k) = min([for (i = [0 : 20]) z_wk(zg_a(k, -L_z / 2 + i * L_z / 20))]);   // tiefster Punkt der Seite
function zg_y(k, x) = z_wk(zg_a(k, x)) - zg_b(k);
w_zr = max(sc(60), 1.2);
ZG_N = 16;
function zg_rail(k, dy) = [for (i = [0 : ZG_N]) let(x = -L_z / 2 + i * L_z / ZG_N) [x, zg_y(k, x) + dy]];
function zg_hmax(k) = max([for (i = [0 : 20]) zg_y(k, -L_z / 2 + i * L_z / 20)]) + h_zg;
module zaun_lokal(k) {   // x Länge zentriert, y Höhe (0 = tiefster Punkt der Unterkante), z Dicke
    w = w_zr; n = max(2, round(L_z / M(0.9)));
    linear_extrude(t_z2) {
        for (dy = [h_zg - w / 2, h_zg * 0.5, M(0.12)]) let(P = zg_rail(k, dy)) for (i = [0 : ZG_N - 1]) sbar(P[i], P[i + 1], w);
        for (j = [0 : n]) let(x = -L_z / 2 + w / 2 + j * (L_z - w) / n, y0 = max(zg_y(k, x - w / 2), zg_y(k, x + w / 2))) translate([x - w / 2, y0]) square([w, h_zg + zg_y(k, x) - y0]);
        for (j = [0 : n - 1]) let(x0 = -L_z / 2 + w + j * (L_z - w) / n, x1 = x0 + (L_z - w) / n - w)
            for (q = [[[x0, zg_y(k, x0) + M(0.12)], [x1, zg_y(k, x1) + h_zg * 0.5]], [[x0, zg_y(k, x0) + h_zg * 0.5], [x1, zg_y(k, x1) + M(0.12)]]]) bar(q[0], q[1], max(sc(40), 0.9));
        for (x = X_ZP) translate([x - w_zp / 2, zg_y(k, x) - l_zp]) square([w_zp, l_zp + e]);
    }
}
module zaun_welt(k) side_frame(k, R_z - t_z2 / 2) translate([0, 0, zg_b(k) + 0.2]) cyc() zaun_lokal(k);   // 0,2 mm Luft über dem Deck
function zm_of(k) = concat([for (dy = [M(0.12), h_zg - w_zr / 2]) let(P = zg_rail(k, dy)) for (i = [0 : ZG_N - 1]) [P[i] + [L_z / 2, l_zp], P[i + 1] + [L_z / 2, l_zp], w_zr]]);
z_xs = L_z > usable ? seams_at(L_z, [for (x = X_ZP) [x + L_z / 2 - w_zp - spw, x + L_z / 2 + w_zp + spw]], mw) : [];
function info_zaun(k) = let(SY = zg_hmax(k) + l_zp)
    [L_z, SY, z_xs, [], [], false, 0, [for (r = pads(zm_of(k), z_xs, [])) [r[0], max(r[1], 0), r[2], min(r[3], SY)]], occ(zm_of(k), 0, 0)];
NP_Z = n_pieces(info_zaun(ZK[0]));
module zaun_druck(stk) for (q = [0 : len(ZK) - 1]) let(k = ZK[q]) for (g = [1 : NP_Z]) if (stk == 0 ? q == 0 : stk == q * NP_Z + g)
    split_out(info_zaun(k), NP_Z == 1 ? 0 : g) { translate([L_z / 2, l_zp, 0]) zaun_lokal(k); linear_extrude(t_z2) for (r = info_zaun(k)[7]) rect2(r); }

PFL = [rotp([R_pc + r_bu + M(0.3), 0], vtx(10) - 3), rotp([R_pc + r_bu + M(0.3), 0], vtx(13) + 3)];
module pflanze(fp = "alle") {
    if (inc(fp, "A")) difference() {
        cylinder(r1 = r_pt * 0.75, r2 = r_pt, h = h_pt, $fn = 24);
        translate([0, 0, h_pt - M(0.05, 0.6)]) cylinder(r = r_pt - max(sc(50), 1.0), h = 1, $fn = 24);
    }
    if (inc(fp, "B")) translate([0, 0, h_pt - M(0.05, 0.6)]) rotate_extrude($fn = 28)
        polygon([[0, 0], [r_pt - max(sc(50), 1.0) - spiel, 0], [r_bu, r_bu - r_pt + max(sc(50), 1.0) + spiel], [r_bu, h_bu * 0.55],
                 [r_bu * 0.8, h_bu * 0.82], [r_bu * 0.45, h_bu * 0.97], [0, h_bu]]);
}

// =====================================================================
//  KÖNIGSZAPFEN, ROTOR, AUSLEGER
// =====================================================================
module koenigszapfen() {   // z = 0 Podestoberkante
    l_sh = H_p - 1;
    translate([-d_kz / 2, -d_kz / 2, -l_sh]) cube([d_kz, d_kz, l_sh + e]);
    cylinder(r1 = d_kz * 0.72, r2 = d_kc / 2, h = max(0.1, d_kc / 2 - d_kz * 0.72), $fn = 32);
    translate([0, 0, max(0.1, d_kc / 2 - d_kz * 0.72) - e]) cylinder(d = d_kc, h = max(0.4, h_kz - max(0.1, d_kc / 2 - d_kz * 0.72)) + e, $fn = 32);
    translate([0, 0, h_kz - e]) cylinder(d = d_kz, h = t_rot + M(0.2) + e, $fn = 32);
    translate([0, 0, h_kz + t_rot + M(0.2)]) cylinder(d1 = d_kz, d2 = d_kz - 0.8, h = 0.4, $fn = 32);
}
module rotor() {   // Rotor-Koordinaten: z = 0 Unterseite, Ausleger i bei i * pw
    zc = zl_tb - 0.8 - (d_x / 2 + spiel);
    difference() {
        union() {
            cylinder(r = R_rot, h = t_rot, $fa = 2);
            rotate_extrude($fa = 2) difference() {
                translate([r_rw0, 0]) square([r_rw1 - r_rw0, zl_wt]);
                if (zc > t_rot + 0.5) polygon([[r_rw0 + w_lip, t_rot], [r_rw1 - w_lip, t_rot], [r_rw1 - w_lip, zc], [r_piv, zc + d_x / 2 + spiel], [r_rw0 + w_lip, zc]]);
            }
            for (j = [0 : N_col - 1]) rotate(col_a(j)) translate([r_col, 0, 0]) {
                translate([-a_col / 2, -a_col / 2, 0]) cube([a_col, a_col, zl_mb]);
                hull() { translate([-a_cp / 2, -a_cp / 2, zl_mb - e]) cube([a_cp, a_cp, l_cp - 0.3]); translate([-a_cp / 2 + 0.3, -a_cp / 2 + 0.3, zl_mb]) cube([a_cp - 0.6, a_cp - 0.6, l_cp]); }
            }
            cylinder(d = d_kz + 2 * cl + 2 * max(sc(150), 2), h = t_rot + M(0.15), $fn = 32);
        }
        translate([0, 0, -1]) cylinder(d = d_kz + 2 * cl, h = zl_mb + 5, $fn = 32);
        for (i = [0 : N_w - 1]) rotate(i * pw) {
            translate([r_piv - d_x / 2 - spiel, -L_x / 2 - spiel, zl_tb]) cube([d_x + 2 * spiel, L_x + 2 * spiel, zl_wt]);
            translate([r_piv, -b_ab / 2 - spiel, zl_tb]) cube([r_rw1, b_ab + 2 * spiel, zl_wt]);
        }
        // Zierrillen
        for (r = [r_col + a_col, (r_col + a_col + r_rw0) / 2]) translate([0, 0, t_rot - dmr]) linear_extrude(1) ring2(r, max(sc(30), 0.4));
    }
}
function info_rotor() = let(c = R_rot, q = R_rot * 0.68,
    kp = concat([[c - d_kz - 3, c - d_kz - 3, c + d_kz + 3, c + d_kz + 3]], [for (j = [0 : N_col - 1]) let(p = pol(r_col, col_a(j)) + [c, c]) [p[0] - a_col - 1, p[1] - a_col - 1, p[0] + a_col + 1, p[1] + a_col + 1]]))
    [2 * c, 2 * c, seams_at(2 * c, [[c - d_kz - spw / 2, c + d_kz + spw / 2]], mw), seams_at(2 * c, [[c - d_kz - spw / 2, c + d_kz + spw / 2]], mw), kp, false, 0,
     [[c - q, c - q, c + q, c + q]], [[c - R_rot * 0.95, c - R_rot * 0.95, c + R_rot * 0.95, c + R_rot * 0.95]]];
module rotor_druck() translate([R_rot, R_rot, 0]) rotor();

module arm_2d() polygon([[0, -b_ab / 2], [u_tip, -b_at / 2], [u_tip, b_at / 2], [0, b_ab / 2]]);
module ausleger_3d() {   // Arm-Rahmen (x radial ab Gelenk, z = 0 Gelenkachse)
    sl = max(min(b_ab, b_at) * 0.35, 0);
    difference() {
        union() {
            translate([0, 0, -t_arm / 2]) linear_extrude(t_arm) arm_2d();
            translate([0, L_x / 2, 0]) rotate([90, 0, 0]) linear_extrude(L_x) intersection() { circle(d = d_x, $fn = 24); translate([-d_x, -c_x]) square([2 * d_x, 2 * d_x]); }
            translate([u_pg, 0, t_arm / 2 - e]) hull() { translate([-a_pg / 2, -a_pg / 2, 0]) cube([a_pg, a_pg, l_pg - 0.3]); translate([-a_pg / 2 + 0.3, -a_pg / 2 + 0.3, 0]) cube([a_pg - 0.6, a_pg - 0.6, l_pg]); }
        }
        // Erleichterungsschlitze (nicht im Gleitbereich über der Schiene)
        if (sl >= 1.2) for (x = [d_x + M(0.5) : M(0.9) : u_R - M(0.9)]) translate([x, 0, -t_arm]) hull() { cylinder(d = sl, h = 2 * t_arm, $fn = 12); translate([M(0.5), 0, 0]) cylinder(d = sl, h = 2 * t_arm, $fn = 12); }
    }
}
arm_ox = d_x / 2 + 0.5; arm_oy = L_x / 2 + 0.5;
ARM_M = [[[arm_ox, arm_oy], [arm_ox + u_tip, arm_oy], b_at]];
function arm_xs() = arm_split ? seams_at(arm_ox + u_tip + 0.5, [[0, arm_ox + d_x / 2 + spw], [arm_ox + u_pg - a_pg - spw, 1e9]], mw) : [];
function info_arm() = [arm_ox + u_tip + 0.5, 2 * arm_oy, arm_xs(), [], [], false, 0, pads(ARM_M, arm_xs(), []), occ(ARM_M, 0, 0)];
module ausleger_druck() {
    if (arm_rot == 45) translate([(d_x / 2 + L_x / 2) * 0.7072 + 1, (d_x / 2 + L_x / 2) * 0.7072 + 1, t_arm / 2]) rotate(45) ausleger_3d();
    else {
        translate([arm_ox, arm_oy, t_arm / 2]) ausleger_3d();
        if (arm_split) linear_extrude(t_arm) for (r = info_arm()[7]) rect2(r);
    }
}

// =====================================================================
//  WAGEN, SITZBANK, VERDECK  (Wagen-Rahmen: x radial, y vorwärts, z = 0 Wagenboden)
// =====================================================================
function car_pts(ri, ro, a) = concat([for (i = [0 : 12]) let(t = -a + 2 * a * i / 12) [ro * cos(t) - r_c, ro * sin(t)]],
                                     [for (i = [12 : -1 : 0]) let(t = -a + 2 * a * i / 12) [ri * cos(t) - r_c, ri * sin(t)]]);
module car_plan(o = 0) offset(r = rr_w + o) offset(delta = -rr_w) polygon(car_pts(r_c - B_w / 2, r_c + B_w / 2, al_c));
module car_cav() intersection() { car_plan(-t_wa); translate([-B_w, -L_w]) square([2 * B_w, L_w + Y_fd]); }
// Lage auf der Außenwand: lokales x tangential, y hoch, z nach außen
module on_side(yy, zz) let(a = deg(yy / (r_c + B_w / 2))) translate([-r_c, 0, 0]) rotate(a) translate([r_c + B_w / 2 - 0.3, 0, zz]) rotate([90, 0, 90]) children();
em_w = M(0.46); em_h = M(0.3); z_em = M(0.25);
module wagen(fp = "alle", nr = 0) {
    h_rb = max(sc(40), 0.6);
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(z_rim - h_rb) car_plan();
            translate([0, 0, z_rim - h_rb - e]) linear_extrude(h_rb + e) difference() { car_plan(-t_wa + e); car_cav(); }
            for (yy = [-Y_wh, Y_wh]) on_side(yy, z_wc) hull() { cylinder(r = r_wh + t_wh, h = 0.3 + e, $fn = 28); translate([0, 0, 0.3]) cylinder(r = r_wh, h = t_wh, $fn = 28); }
        }
        translate([0, 0, t_fl]) linear_extrude(z_rim) car_cav();
        translate([u_pg - u_c - a_pg / 2 - spiel, -a_pg / 2 - spiel, -1]) cube([a_pg + 2 * spiel, a_pg + 2 * spiel, l_pg + 1.3]);
    }
    if (inc(fp, "B")) {
        translate([0, 0, z_rim - h_rb]) linear_extrude(h_rb) difference() { car_plan(); car_plan(-t_wa); }
        linear_extrude(h_bd) difference() { car_plan(dmr); car_plan(-e); }
        on_side(0, z_em) linear_extrude(0.3 + 2 * dmr) scale([em_w / 2, em_h / 2]) circle(1, $fn = 32);
        for (yy = [-Y_wh, Y_wh]) on_side(yy, z_wc) translate([0, 0, 0.3 + t_wh - e]) linear_extrude(dmr + e)
            for (rr = [[0.42, 0.62], [0.8, 0.98]]) difference() { circle(r = r_wh * rr[1], $fn = 28); circle(r = r_wh * rr[0], $fn = 28); }
    }
    if (inc(fp, "C")) {
        on_side(0, z_em) translate([0, 0, 0.3 + 2 * dmr - e]) linear_extrude(dmr * 1.5 + e) {
            translate([0, nr > 0 ? 0.0 : -em_h * 0.28]) crown_2d(em_h * (nr > 0 ? 0.42 : 0.62));
            if (nr > 0) translate([0, -em_h * 0.08]) text(str(nr), size = em_h * 0.3, font = schild_schrift, halign = "center", valign = "top");
        }
        for (yy = [-Y_wh, Y_wh]) on_side(yy, z_wc) translate([0, 0, 0.3 + t_wh - e]) cylinder(r = r_wh * 0.3, h = dmr * 1.5 + e, $fn = 16);
    }
}
z_cu = M(0.42); z_bk = M(1.05); d_bk = M(0.18); z_wg = M(0.66); w_wg = M(0.13);
module sitz() {   // Wagen-Rahmen
    hw = B_w / 2 - t_wa - spiel; yb = -L_w / 2; yf = Y_sf;
    module fp2() intersection() { car_plan(-t_wa - spiel); translate([-B_w, yb - 1]) square([2 * B_w, yf - yb + 1]); }
    difference() {
        intersection() {
            translate([0, 0, t_fl]) linear_extrude(z_bk) fp2();
            union() {
                translate([-B_w, yb - 1, 0]) cube([2 * B_w, yf - yb + 1, z_cu]);
                translate([0, yb + t_wa + spiel + d_bk, 0]) rotate([90, 0, 0]) linear_extrude(d_bk + t_wa + spiel + 1)
                    hull() { translate([-hw, 0]) square([2 * hw, 0.01]); translate([0, z_bk - M(0.25)]) scale([hw, M(0.25)]) circle(1, $fn = 32); }
                for (sx = [-1, 1]) translate([sx > 0 ? hw - w_wg : -B_w, yb - 1, 0]) cube([w_wg + B_w - hw, yf - yb + 1 - M(0.08), z_wg]);
            }
        }
        // Hohlräume unter dem Polster
        translate([0, yb + t_wa + spiel + d_bk + 0.8, t_fl]) rotate([90, 0, 0]) mirror([0, 0, 1])
            linear_extrude(max(0, yf - yb - t_wa - spiel - d_bk - 1.6)) gables_2d(-hw + w_wg + 0.8, hw - w_wg - 0.8, z_cu - t_fl - 1.0, 1.0);
    }
}
// Verdeck-Querschnitt (x radial ab Wagenmitte, y = Höhe im Wagen-Rahmen)
module hood_outer_2d() {
    translate([0, z_rim]) intersection() { scale([a_o, H_arch]) circle(1, $fn = 64); translate([-a_o - 1, 0]) square([2 * a_o + 2, H_arch + 1]); }
    for (sx = [-1, 1]) translate([sx > 0 ? B_w / 2 + spiel : -a_o, z_rim - d_tg]) square([a_o - B_w / 2 - spiel, d_tg + e]);
}
module hood_inner_2d() translate([0, z_rim - 1]) scale([a_i, H_arch - t_hd + 1]) circle(1, $fn = 64);
module hood_prof() difference() { hood_outer_2d(); hood_inner_2d(); translate([-B_w / 2 - spiel, z_rim - d_tg - 1]) square([B_w + 2 * spiel, d_tg + 1]); }
module hood_band() intersection() { difference() { offset(delta = dmr) hood_outer_2d(); hood_outer_2d(); } translate([-a_o - 2, z_rim]) square([2 * a_o + 4, H_arch + 2]); }
module eye_regions(k) {   // 0 = Augenweiß, 1 = Pupillen + Mund
    ey = z_rim + H_arch * 0.52; er = H_arch * 0.17;
    if (k == 0) for (sx = [-1, 1]) difference() { translate([sx * a_o * 0.42, ey]) circle(r = er, $fn = 24); translate([sx * a_o * 0.36, ey + er * 0.15]) circle(r = er * 0.5, $fn = 16); }
    if (k == 1) {
        for (sx = [-1, 1]) translate([sx * a_o * 0.36, ey + er * 0.15]) circle(r = er * 0.5, $fn = 16);
        translate([0, z_rim + H_arch * 0.38]) intersection() { difference() { circle(r = a_o * 0.3, $fn = 32); circle(r = a_o * 0.3 - max(M(0.06), 0.8), $fn = 32); } translate([-a_o, -a_o]) square([2 * a_o, a_o * 0.85]); }
    }
}
// Verdeck im eigenen Rahmen: Achse = z, Querschnitt bei Winkel 0, gefegt bis 2*be_h
module verdeck_body(fp, kopf, seg = 0) {
    a0 = seg * 2 * be_h / n_hs; a1 = (seg + 1) * 2 * be_h / n_hs;
    ang_t = deg(t_hd / r_c);
    module sw(b0, b1) if (b1 > b0) rotate(b0) rotate_extrude(angle = b1 - b0, $fa = 1) translate([r_c, 0]) children();
    if (inc(fp, "A")) {
        sw(a0, a1) hood_prof();
        if (kopf && seg == 0) sw(0, ang_t) difference() { hood_outer_2d(); eye_regions(0); eye_regions(1); }
    }
    if (inc(fp, "B")) for (f = [0.3, 0.7]) let(c = 2 * be_h * f, w = deg(M(0.12) / r_c)) sw(max(a0, c - w / 2), min(a1, c + w / 2)) hood_band();
    if (kopf && seg == 0) {
        if (inc(fp, "C")) sw(0, ang_t) eye_regions(0);
        if (inc(fp, "D")) sw(0, ang_t) eye_regions(1);
    }
}
module verdeck_welt(fp, kopf) translate([-r_c, 0, 0]) {
    if (kopf) mirror([0, 1, 0]) rotate(-be_h) for (g = [0 : n_hs - 1]) verdeck_body(fp, true, g);
    else rotate(-be_h) for (g = [0 : n_hs - 1]) verdeck_body(fp, false, g);
}
module verdeck_druck(stk, fp, kopf) for (g = [0 : n_hs - 1]) if (stk == 0 || stk == g + 1) {
    a0 = g * 2 * be_h / n_hs;
    translate([stk == 0 ? g * (2 * a_o + 6) : 0, 0, 0])
        translate([-(r_c - a_o) * cos(2 * be_h / n_hs) + 1, z_rim + H_arch + 1, 0]) rotate([90, 0, 0]) rotate(-a0) verdeck_body(fp, kopf, g);
}

// =====================================================================
//  MITTELBAU  (dreht mit dem Rotor; Welt-z, Rotor-Winkel)
// =====================================================================
module mb_boden() {
    difference() {
        translate([0, 0, z_mb]) linear_extrude(t_mb) poly12(R_mb);
        translate([0, 0, z_mb + t_mb - g_m]) linear_extrude(g_m + 1) difference() { poly12(R_mp + spiel); poly12(R_mp - t_mp - spiel); }
        for (j = [0 : N_col - 1]) rotate(col_a(j)) translate([r_col - a_cp / 2 - spiel, -a_cp / 2 - spiel, z_mb - 1]) cube([a_cp + 2 * spiel, a_cp + 2 * spiel, l_cp + 1.3]);
        translate([0, 0, z_mb + t_mb - dmr]) linear_extrude(1) ring2(R_mp - t_mp - M(0.3), max(sc(30), 0.4));
    }
}
function info_mb(R, t) = let(c = R / tcm) [2 * c, 2 * c, seams_at(2 * c, [], mw), seams_at(2 * c, [], mw),
    [for (j = [0 : N_col - 1]) let(p = pol(r_col, col_a(j)) + [c, c]) [p[0] - a_cp - 2, p[1] - a_cp - 2, p[0] + a_cp + 2, p[1] + a_cp + 2]], false, 0,
    [[c - (R_mp - t_mp) * 0.8, c - (R_mp - t_mp) * 0.8, c + (R_mp - t_mp) * 0.8, c + (R_mp - t_mp) * 0.8]],
    [[c - R * 0.95, c - R * 0.95, c + R * 0.95, c + R * 0.95]]];
// Arkade des Baldachins: Pfosten, Rundbogen (offen, man sieht hindurch), Fries
mb_pw = max(L_mp * 0.13, 2.0, H_mp > usable ? 2 * mw + 1 : 0);   // Pfostenbreite (geteilt: Platz für Clips)
mb_rb = max(H_mw * 0.07, 1.6);                   // Sockelleiste
mb_r  = (L_mp - 2 * mb_pw) / 2;                  // Bogenradius
mb_ys = min(g_m + H_mw * 0.6, g_m + H_mw - max(H_mw * 0.1, 2.5) - mb_r);   // Kämpferhöhe
module mb_bogen_2d() { translate([mb_pw, g_m + mb_rb]) square([2 * mb_r, mb_ys - g_m - mb_rb + e]); translate([L_mp / 2, mb_ys]) circle(r = mb_r, $fn = 48); }
module mb_wand_lokal(fp = "alle") {   // x Länge, y Höhe (0 = Nutgrund), z Dicke (vorn oben)
    fw = max(sc(60), 0.8); v0 = g_m; v1 = g_m + H_mw;
    if (inc(fp, "A")) difference() { cube([L_mp, H_mp, t_mp]); translate([0, 0, -1]) linear_extrude(t_mp + 2) mb_bogen_2d(); }
    translate([0, 0, t_mp - e]) {
        if (inc(fp, "B")) linear_extrude(dmr * 2 + e) difference() { intersection() {
            translate([0, v0]) square([L_mp, H_mw]);
            union() {
                difference() { offset(delta = fw) mb_bogen_2d(); mb_bogen_2d(); }           // Bogenrahmen
                for (x = [0, L_mp - fw]) translate([x, v0]) square([fw, H_mw]);            // Pfostenkanten
                translate([0, v1 - fw]) square([L_mp, fw]);                                  // Gesims
                for (x = [mb_pw - fw * 2.2, L_mp - mb_pw + fw * 0.2]) translate([x, mb_ys - fw]) square([fw * 2, fw * 1.5]);   // Kämpfer
            }
        } mb_bogen_2d(); }
        if (inc(fp, "C")) linear_extrude(dmr * 2.5 + e) for (sx = [-1, 1]) let(a45 = [L_mp / 2 + sx * (mb_r + fw) * 0.707, mb_ys + (mb_r + fw) * 0.707],
                cor = [L_mp / 2 + sx * (L_mp / 2 - fw), v1 - fw], c = (a45 + cor) / 2, rs = min(norm(cor - a45) * 0.3, mb_pw * 0.45))
            if (rs > 0.8) translate(c) star_2d(rs);                                           // Sterne in den Zwickeln
    }
}
module mb_waende(fp = "alle") for (j = [0 : N_m - 1]) rotate(j * am) translate([R_mp - t_mp, 0, z_mb + t_mb - g_m]) cyc() translate([-L_mp / 2, 0, 0]) mb_wand_lokal(fp);
function info_mbw() = [L_mp, H_mp, seams_at(L_mp, [[mb_pw - 1, L_mp - mb_pw + 1]], mw), seams_at(H_mp, [], mw), [[-1, -1, L_mp + 1, g_m + 1.5], [-1, H_mp - g_m - 1.5, L_mp + 1, H_mp + 1]], false, 0,
    [[0, 0, mb_pw, H_mp], [L_mp - mb_pw, 0, L_mp, H_mp], [0, 0, L_mp, g_m + mb_rb], [0, mb_ys + mb_r, L_mp, H_mp]],
    [[0, 0, mb_pw, H_mp], [L_mp - mb_pw, 0, L_mp, H_mp], [0, 0, L_mp, g_m + mb_rb], [0, mb_ys + mb_r, L_mp, H_mp]]];
module mb_deckel(fp = "alle") {
    if (inc(fp, "A")) difference() {
        translate([0, 0, z_md]) linear_extrude(t_md) poly12(R_md);
        translate([0, 0, z_md - 1]) linear_extrude(g_m + 1) difference() { poly12(R_mp + spiel); poly12(R_mp - t_mp - spiel); }
    }
    if (inc(fp, "A")) translate([0, 0, z_k0 - e]) linear_extrude(min(h_kr, max(0.6, H_kc - 0.3))) difference() { circle(r = K_C0 - spiel, $fn = 32); circle(r = K_C0 - spiel - max(sc(60), 1.2), $fn = 32); }
    if (inc(fp, "B")) for (j = [0 : N_m - 1]) rotate(j * am + am / 2) translate([(R_md - M(0.12)) / tcm, 0, z_k0 - e]) cylinder(d = M(0.14, 1.2), h = M(0.1, 0.8), $fn = 12);
}
// Kuppel: Profil (r, z) über z_k0, 12-eckig
KP = [[R_k, 0], [R_k, 0.12 * H_k], [0.97 * R_k, 0.3 * H_k], [0.86 * R_k, 0.5 * H_k], [0.64 * R_k, 0.7 * H_k], [0.37 * R_k, 0.86 * H_k], [0.14 * R_k, 0.95 * H_k], [0.07 * R_k, H_k]];
r_fi = max(0.08 * R_k, 1.2);
KF = [[0.07 * R_k, H_k], [r_fi, H_k + r_fi * 0.8], [r_fi * 0.8, H_k + r_fi * 1.6], [0, H_k + r_fi * 2.6]];
// Höhe des Kuppelprofils bei Eckradius x (KP fällt in x)
function pint(P, x, i = 0) = i >= len(P) - 1 ? P[len(P) - 1][1] :
    (P[i][0] > P[i + 1][0] && x <= P[i][0] / tcm && x >= P[i + 1][0] / tcm) ? P[i][1] + (P[i + 1][1] - P[i][1]) * (x - P[i][0] / tcm) / ((P[i + 1][0] - P[i][0]) / tcm) : pint(P, x, i + 1);
K_C0 = max(M(0.4), 3);                           // Zentrierring (Eckradius außen)
k_x1 = R_k / tcm - 1.5 * t_kw;
function kslope(x) = pint(KP, x + 0.5) - pint(KP, x - 0.5);
H_kc = pint(KP, K_C0) - 2 * t_kw;
n_krib = max(N_m, ceil(2 * PI * k_x1 / 18 / N_m) * N_m);
module kuppel(fp = "alle") {   // 2D-Profile, damit die Vorschau sauber bleibt
    band = [0.12 * H_k, 0.19 * H_k];
    module prof() polygon(concat([[0, 0]], [for (p = KP) [p[0] / tcm, p[1]]], [[0, H_k]]));
    module hohl() polygon(concat([[0, -1], [k_x1, -1]], [for (i = [0 : 40]) let(x = k_x1 - i * k_x1 / 40) [x, max(0, pint(KP, x) - 1.5 * t_kw * sqrt(1 + kslope(x) * kslope(x)) - 0.2)]]));
    module bnd() translate([0, band[0]]) square([2 * R_k, band[1] - band[0]]);
    translate([0, 0, z_k0]) rotate(am / 2) {
        if (inc(fp, "A")) difference() {
            rotate_extrude($fn = N_m, convexity = 4) difference() { prof(); bnd(); }
            difference() {
                rotate_extrude($fn = N_m, convexity = 4) hohl();
                if (!$preview) for (k = [0 : n_krib - 1]) rotate(k * 360 / n_krib + 180 / n_krib) translate([K_C0 + 0.6, -min_wand / 2, -2]) cube([R_k * 2, min_wand, H_k + 4]);
            }
        }
        if (inc(fp, "B")) {
            difference() {
                rotate_extrude($fn = N_m, convexity = 4) intersection() { prof(); bnd(); }
                difference() {
                    rotate_extrude($fn = N_m, convexity = 4) hohl();
                    if (!$preview) for (k = [0 : n_krib - 1]) rotate(k * 360 / n_krib + 180 / n_krib) translate([K_C0 + 0.6, -min_wand / 2, -2]) cube([R_k * 2, min_wand, H_k + 4]);
                }
            }
            translate([0, 0, -e]) rotate_extrude($fn = 24) polygon(concat([[0, H_k]], KF));
        }
    }
}
PP_KUP = polar_pieces(0, R_k / tcm, 0);
module kuppel_druck(stk, fp) pp_druck(PP_KUP, stk, R_k / tcm + 2, z_k0, z_k0 + H_k + 4 * r_fi) kuppel(fp);

// =====================================================================
//  SÄULEN (Zuckerstange)  – lokal z = 0 Podestoberkante
// =====================================================================
h_cb = max(0.2, r_po - a_ps * 0.72);
l_j  = max(sc(200), 3);
ZS = [for (k = [0 : n_ps]) k * H_po / n_ps];
module saeule_voll(fp) {
    tw = -360 * (H_po - h_cb) / P_st;
    if (inc(fp, "A")) {
        translate([-a_ps / 2, -a_ps / 2, -l_ps]) cube([a_ps, a_ps, l_ps + e]);
        cylinder(r1 = a_ps * 0.72, r2 = r_po, h = h_cb + e, $fn = 24);
        cylinder(r = r_po * 0.55, h = H_po, $fn = 20);
        translate([-a_ps / 2, -a_ps / 2, H_po - e]) cube([a_ps, a_ps, d_rs - 0.3]);
    }
    for (q = [0 : 3]) let(f = q == 1 ? "B" : q == 3 ? "C" : "A") if (inc(fp, f))
        translate([0, 0, h_cb]) linear_extrude(H_po - h_cb, twist = tw, slices = max(8, round(abs(tw) / 10)), convexity = 4)
            rotate(q * 90) intersection() { difference() { circle(r = r_po, $fn = 24); circle(r = r_po * 0.55, $fn = 20); } polygon([[0, 0], pol(3 * r_po, 0), pol(3 * r_po, 45), pol(3 * r_po, 90)]); }
}
module saeule_seg(k, fp) {
    z0 = ZS[k]; z1 = ZS[k + 1];
    difference() {
        union() {
            intersection() { saeule_voll(fp); translate([-5 * r_po, -5 * r_po, k == 0 ? -l_ps - 1 : z0]) cube([10 * r_po, 10 * r_po, (k == n_ps - 1 ? H_po + d_rs + 1 : z1) - (k == 0 ? -l_ps - 1 : z0)]); }
            if (k < n_ps - 1 && inc(fp, "A")) translate([-a_ps / 2, -a_ps / 2, z1 - e]) cube([a_ps, a_ps, l_j]);
        }
        if (k > 0) translate([-a_ps / 2 - spiel, -a_ps / 2 - spiel, z0 - 1]) cube([a_ps + 2 * spiel, a_ps + 2 * spiel, l_j + 1.3]);
    }
}
module saeule_druck(stk, fp) for (k = [0 : n_ps - 1]) if (stk == 0 || stk == k + 1)
    translate([(stk == 0 ? k * (2 * r_po + 4) : 0) + r_po, r_po, k == 0 ? l_ps : -ZS[k]]) saeule_seg(k, fp);
module saeulen_welt(fp = "alle") for (j = [0 : N_d - 1]) translate(concat(PO[j], [z_f])) rotate(vtx(j)) saeule_voll(fp);

// =====================================================================
//  DACH  (Ringdach mit Torus-Wulst, unten offene 45°-Kanäle)
// =====================================================================
PP_DACH = polar_pieces(R_ri, R_ro / tc, vtx(-1));
SGL = [for (sx = [-1, 1]) rotp([r_sg, sx * x_lg], sidec(FRONT))];            // Schildbeine
CL_DACH = [for (c = pp_clips(PP_DACH, R_ri + 0.5, R_f - t_f / 2 - spiel - 1))
           if (!near(c, PO, a_ps + mw + 2) && !near(c, SGL, w_lg + mw + 2)) c];
DACH_BOSSE = concat([for (p = PO) [p[0], p[1], a_ps * 0.75 + t_sh]], [for (c = CL_DACH) [c[0], c[1], r_cb]], [for (p = SGL) [p[0], p[1], max(w_lg, t_sg) * 0.75 + t_sh]]);
module dach_prof() polygon(concat([[R_ri / tc, z_u]], [for (i = [0 : 48]) let(r = R_ri + i * (R_b1 - R_ri) / 48) [r / tc, top(r)]],
                                  [[R_ro / tc, z_u + t_bd], [R_ro / tc, z_u]]));
cav0 = R_ri + w_ib; cav1 = R_f - t_f / 2 - spiel - t_sh;
function ha(r) = (r < R_b1 ? top(r) : z_u + t_bd) - t_sh - z_u;
// Hohlraum: Decke parallel zur Wulst (Wand senkrecht zur Fläche gemessen), unten offen;
// radiale Rippen alle ~14 mm -> die Decke wird zwischen zwei Rippen kurz überbrückt
function slope(r) = (top(r + 0.5) - top(r - 0.5));
function ceil_z(r) = (r < R_b1 ? top(r) : z_u + t_bd) - t_sh * sqrt(1 + slope(r) * slope(r)) - 0.2;
n_rib = max(N_d, ceil(2 * PI * cav1 / 20 / N_d) * N_d);    // Brücken <= 20 mm
module dach_cav() polygon(concat([[cav0 / tc, z_u - 1], [cav1 / tc, z_u - 1]],
    [for (i = [0 : 60]) let(r = cav1 - i * (cav1 - cav0) / 60) [r / tc, max(z_u - 0.5, ceil_z(r))]]));
module dach_rippen() for (k = [0 : n_rib - 1]) rotate(k * 360 / n_rib) translate([cav0 - 2, -min_wand / 2, z_u - 2]) cube([R_ro / tc - cav0 + 4, min_wand, H_b + t_bd + 4]);
DOTS = concat([for (k = [0 : N_d - 1]) [pol(r_cr, sidec(k)), k % 2]], [for (k = [0 : N_d - 1]) [pol(r_cr / tc, vtx(k)), (k + 1) % 2]]);
d_dot = M(0.36, 1.6);
module dots(k) for (d = DOTS) if (d[1] == k) translate(concat(d[0], [top(r_cr) - dmr])) cylinder(d = d_dot, h = 3 * dmr, $fn = 20);
module dach_welt(fp = "alle") {
    if (inc(fp, "A")) difference() {
        rotate(ad / 2) rotate_extrude($fn = N_d) dach_prof();
        difference() {
            rotate(ad / 2) rotate_extrude($fn = N_d) dach_cav();
            if (!$preview) dach_rippen();   // Vorschau: Rippen weglassen (CSG-Baum)
            for (b = DACH_BOSSE) translate([b[0], b[1], z_u - 2]) cylinder(r = b[2], h = H_b + t_bd + 4, $fn = 20);
        }
        // Blendennut, Taschen der Notenschlüssel
        translate([0, 0, z_u + t_bd - g_f]) linear_extrude(g_f + 1) difference() { poly(R_f + t_f / 2 + spiel); poly(R_f - t_f / 2 - spiel); }
        for (j = [0 : N_d - 1]) rotate(vtx(j)) translate([rho_cl - t_f - spiel, -(w_ct / 2 + spiel), z_u + t_bd - g_f]) cube([t_f + t_cf + 2 * spiel, w_ct + 2 * spiel, g_f + 1]);
        // Säulenzapfen
        for (j = [0 : N_d - 1]) translate(concat(PO[j], [z_u - 1])) rotate(vtx(j)) translate([-a_ps / 2 - spiel, -a_ps / 2 - spiel, 0]) cube([a_ps + 2 * spiel, a_ps + 2 * spiel, d_rs + 1]);
        // Schildbeine
        for (p = SGL) translate(concat(p, [top(r_sg) - d_lh - 0.3])) rotate(sidec(FRONT)) translate([-t_sg / 2 - spiel, -w_lg / 2 - spiel, 0]) cube([t_sg + 2 * spiel, w_lg + 2 * spiel, H_b + 5]);
        for (c = CL_DACH) translate([c[0], c[1], z_u]) clip_cut(c[2], false, 0);
        dots(0); dots(1);
    }
    if (inc(fp, "B")) dots(0);
    if (inc(fp, "C")) dots(1);
}
module dach_druck(stk, fp) pp_druck(PP_DACH, stk, R_ro / tc + 2, z_u, z_u + t_bd + H_b + 3 * dmr) dach_welt(fp);

// ---- Frontblenden ----
H_fp = g_f + h_f - spiel;
module blende_lokal(fp = "alle") {   // x Länge, y Höhe (0 = Nutgrund), z Dicke (vorn oben)
    L = L_fp; v0 = g_f; vh = h_f - spiel; fb = max(sc(70), 0.8);
    cx = L / 2; cy = v0 + vh * 0.22; rs = vh * 0.58;
    if (inc(fp, "A")) cube([L, H_fp, t_f]);
    translate([0, 0, t_f - e]) {
        if (inc(fp, "B")) linear_extrude(dmr * 2 + e) {
            difference() { translate([0, v0]) square([L, vh]); translate([fb, v0 + fb]) square([L - 2 * fb, vh - 2 * fb]); }
            translate([cx, cy]) difference() { circle(r = rs + fb * 1.4, $fn = 48); circle(r = rs + fb * 0.4, $fn = 48); translate([-rs * 2, -rs * 2]) square([rs * 4, rs * 2]); }
        }
        if (inc(fp, "C")) linear_extrude(dmr * 2 + e) translate([cx, cy]) for (k = [0 : 8]) let(a = 10 + k * 20)
            polygon([pol(rs * 0.42, a - 5.5), pol(rs, a - 3), pol(rs, a + 3), pol(rs * 0.42, a + 5.5)]);
        if (inc(fp, "D")) linear_extrude(dmr * 2.5 + e) {
            translate([cx, cy]) intersection() { circle(r = rs * 0.36, $fn = 32); translate([-rs, 0]) square([2 * rs, rs]); }
            for (sx = [0.15, 0.85]) translate([L * sx, v0 + vh * 0.55]) star_2d(min(vh * 0.2, L * 0.08));
            nb = max(2, floor(L / M(0.35, 3)));
            for (i = [0 : nb]) translate([fb * 2 + i * (L - 4 * fb) / nb, v0 + fb + max(M(0.06), 0.6)]) circle(d = max(M(0.08), 0.8), $fn = 10);
        }
    }
}
module blenden_welt(fp = "alle") for (k = [0 : N_d - 1]) side_frame(k, R_f - t_f / 2) translate([0, 0, z_u + t_bd - g_f + spiel]) cyc() translate([-L_fp / 2, 0, 0]) blende_lokal(fp);
function info_blende() = [L_fp, H_fp, seams_at(L_fp, [], mw), seams_at(H_fp, [], mw), [[-1, -1, L_fp + 1, g_f + 1.5]], false, 0, []];

// ---- Notenschlüssel (mit der Schauseite nach unten gedruckt) ----
H_cl = M(1.45); wm_cl = max(1.0, sc(30));
module ns_2d(front) {
    translate([-w_ct / 2, -g_f + spiel]) square([w_ct, g_f - spiel + h_f * 0.9]);
    if (front) mirror([1, 0]) translate([0, 0.05 * H_cl]) clef_2d(H_cl, wm_cl);
}
module notenschluessel() { linear_extrude(t_cf) ns_2d(true); translate([0, 0, t_cf - e]) linear_extrude(t_f - spiel + e) ns_2d(false); }
module ns_welt() for (j = [0 : N_d - 1]) rotate(vtx(j)) translate([rho_cl + t_cf, 0, z_u + t_bd]) multmatrix([[0, 0, -1, 0], [-1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 1]]) notenschluessel();
module ns_druck() translate([0.2 * H_cl + 1, g_f + 1, 0]) notenschluessel();

// ---- Schild RAUPENBAHN mit Saxophonen ----
SXP = [-(W_sb / 2 + M(0.05)), -M(0.1)];          // Fußpunkt linkes Saxophon (gespiegelt)
module sax_place(sx) translate([sx * (W_sb / 2 + M(0.05)), -M(0.1)]) rotate(-sx * 10) mirror([sx < 0 ? 1 : 0, 0]) translate([-0.05 * H_sx, 0]) children();
module board_2d() polygon(concat([[-W_sb / 2, 0], [W_sb / 2, 0]], [for (i = [0 : 24]) let(x = W_sb / 2 - i * W_sb / 24) [x, H_sb + H_sa * (1 - pow(2 * x / W_sb, 2))]]));
module rs_lokal(fp = "alle") {   // x Breite (Mitte 0), y Höhe (0 = Brettunterkante), z Dicke (vorn oben)
    fb = max(M(0.08), 1.0); wm = max(0.8, sc(30));
    yb = H_sb * 0.52;                            // Unterkante Notenband
    module saxes() for (sx = [-1, 1]) sax_place(sx) sax_2d(H_sx, wm);
    module notes() {
        sl = (H_sb + H_sa - yb - 2 * fb) / 6;
        for (q = [[-0.36, 1.0, 0], [-0.17, 2.0, 1], [0.06, 0.5, 0], [0.24, 1.5, 1]]) translate([q[0] * W_sb, yb + fb + sl * (0.5 + q[1])])
            if (q[2] == 0) note_2d(sl * 2.6, wm); else notes2_2d(sl * 2.4, wm);
    }
    module staff() { sl = (H_sb + H_sa - yb - 2 * fb) / 6; for (j = [1 : 5]) translate([-W_sb / 2, yb + fb + j * sl - max(sc(20), 0.45) / 2]) square([W_sb, max(sc(20), 0.45)]); }
    if (inc(fp, "A")) difference() {
        linear_extrude(t_sg) { board_2d(); for (sx = [-1, 1]) translate([sx * x_lg - w_lg / 2, -l_lg]) square([w_lg, l_lg + e]); }
        translate([0, 0, -1]) linear_extrude(t_sg + 2) saxes();
    }
    translate([0, 0, t_sg - e]) {
        if (inc(fp, "B")) linear_extrude(dmr * 2 + e) difference() { union() {
            difference() { board_2d(); offset(delta = -fb) board_2d(); }
            difference() { intersection() { board_2d(); translate([-W_sb, yb]) square([2 * W_sb, H_sb]); } staff(); offset(delta = 0.4) notes(); offset(delta = 0.4) saxes(); }
            translate([0, H_sb * 0.27]) resize([min(W_sb - 4 * fb, len(schild_oben) * H_sb * 0.33 * 0.78), H_sb * 0.33]) text(schild_oben, size = H_sb * 0.33, font = schild_schrift, halign = "center", valign = "center");
        } offset(delta = 0.4) saxes(); }
        if (inc(fp, "C")) linear_extrude(dmr * 2.5 + e) difference() { intersection() { notes(); board_2d(); } saxes(); }
    }
    if (inc(fp, "D")) {
        linear_extrude(t_sg + dmr * 2) saxes();
        translate([0, 0, t_sg + dmr * 2 - e]) linear_extrude(dmr * 1.5 + e) for (sx = [-1, 1]) sax_place(sx) sax_keys_2d(H_sx);
    }
}
module rs_welt(fp = "alle") side_frame(FRONT, r_sg - t_sg / 2) translate([0, 0, z_sb]) cyc() rs_lokal(fp);
sg_x0 = -SX_sg / 2; sg_y0 = -l_lg; SY_sg = l_lg + max(H_sb + H_sa, H_sx) + M(0.1);
function info_schild_rb() = let(ox = -sg_x0, oy = -sg_y0)
    [SX_sg, SY_sg, seams_at(SX_sg, concat([for (sx = [-1, 1]) [sx * x_lg + ox - w_lg - spw, sx * x_lg + ox + w_lg + spw]],
                                          [for (sx = [-1, 1]) [sx * W_sb / 2 + ox - 2 * spw, sx * W_sb / 2 + ox + 2 * spw]]), mw),
     seams_at(SY_sg, [[0, oy + spw]], mw), [], false, 0,
     [[ox - W_sb / 2 + 2, oy + 2, ox + W_sb / 2 - 2, oy + H_sb - 2]], [[ox - W_sb / 2, oy, ox + W_sb / 2, oy + H_sb]]];
module rs_druck(fp) translate([-sg_x0, -sg_y0, 0]) rs_lokal(fp);


// =====================================================================
//  ZUSAMMENBAU
// =====================================================================
module wagen_gruppe(th, i, ex = 0, ev = 0) car_frame(th) {
    translate([0, 0, ex]) {
        color(fhex(farbe_wagen)) wagen("A"); color(fhex(farbe_wagen_zier)) wagen("B"); color(fhex(farbe_krone)) wagen("C", wagen_nummern ? i + 1 : 0);
        translate([0, 0, ex * 0.6]) color(fhex(farbe_sitz)) sitz();
        if (verdeck_zeigen || ev > 0) translate([0, 0, ex * 0.6 + ev]) {
            kopf = raupenkopf && i == 0;
            color(fhex(farbe_verdeck)) verdeck_welt("A", kopf); color(fhex(farbe_verdeck_ring)) verdeck_welt("B", kopf);
            if (kopf) { color(fhex(farbe_augen)) verdeck_welt("C", true); color(fhex(farbe_pupillen)) verdeck_welt("D", true); }
        }
    }
}
module raupenbahn(ex = 0) {
    color(fhex(farbe_podest)) podest_welt("A"); color(fhex(farbe_podest_rand)) podest_welt("B");
    for (k = STK) color(fhex(farbe_treppe)) translate(ex * 0.4 * concat(pol(1, sidec(k)), [0])) treppe_welt(k);
    translate([0, 0, ex * 0.45]) { color(fhex(farbe_podest)) weg_welt("A"); color(fhex(farbe_podest_rand)) weg_welt("B"); }
    translate([0, 0, ex * 0.3]) { color(fhex(farbe_bahn)) bahn_welt("A"); color(fhex(farbe_schiene)) bahn_welt("B"); }
    translate([0, 0, ex * 0.5]) color(fhex(farbe_technik)) translate([0, 0, z_f]) koenigszapfen();
    translate([0, 0, ex * 0.8]) {
        color(fhex(farbe_technik)) translate([0, 0, z_r0]) rotate(drehung) rotor();
        for (i = [0 : N_w - 1]) let(th = drehung + i * pw) {
            translate([0, 0, ex * 0.4]) color(fhex(farbe_technik)) arm_frame(th) ausleger_3d();
            translate([0, 0, ex * 0.4]) wagen_gruppe(th, i, ex * 0.5, 0);
        }
        rotate(drehung) translate([0, 0, ex * 1.2]) {
            color(fhex(farbe_mittelbau_platte)) mb_boden();
            translate([0, 0, ex * 0.4]) { color(fhex(farbe_mittelbau)) mb_waende("A"); color(fhex(farbe_mittelbau_rahmen)) mb_waende("B"); color(fhex(farbe_mittelbau_motiv)) mb_waende("C"); }
            translate([0, 0, ex * 0.8]) { color(fhex(farbe_mittelbau_platte)) mb_deckel("A"); color(fhex(farbe_licht)) mb_deckel("B"); }
            translate([0, 0, ex * 1.2]) { color(fhex(farbe_kuppel)) kuppel("A"); color(fhex(farbe_gold)) kuppel("B"); }
        }
    }
    translate([0, 0, ex * 1.6]) { color(fhex(farbe_saeule_1)) saeulen_welt("A"); color(fhex(farbe_saeule_2)) saeulen_welt("B"); color(fhex(farbe_saeule_3)) saeulen_welt("C"); }
    translate([0, 0, ex * 3.0]) {
        color(fhex(farbe_dach)) dach_welt("A"); color(fhex(farbe_punkte_1)) dach_welt("B"); color(fhex(farbe_punkte_2)) dach_welt("C");
        translate(ex * 0.3 * [0, 0, 1]) {
            color(fhex(farbe_blende)) blenden_welt("A"); color(fhex(farbe_blende_rahmen)) blenden_welt("B");
            color(fhex(farbe_sonne)) blenden_welt("C"); color(fhex(farbe_licht)) blenden_welt("D");
            color(fhex(farbe_notenschluessel)) ns_welt();
        }
        translate([0, 0, ex * 0.6]) { color(fhex(farbe_schild)) rs_welt("A"); color(fhex(farbe_schrift)) rs_welt("B"); color(fhex(farbe_noten)) rs_welt("C"); color(fhex(farbe_gold)) rs_welt("D"); }
    }
    for (k = ZK) translate([0, 0, ex * 0.9]) color(fhex(farbe_zaun)) zaun_welt(k);
    for (p = PFL) translate(concat(p, [0])) { color(fhex(farbe_kuebel)) pflanze("A"); color(fhex(farbe_pflanze)) pflanze("B"); }
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFOS = concat(
    [["rotor", info_rotor(), 1], ["ausleger", info_arm(), N_w], ["mittelbau_boden", info_mb(R_mb, t_mb), 1], ["mittelbau_deckel", info_mb(R_md, t_md), 1],
     ["mittelbau_wand", info_mbw(), N_m], ["blende", info_blende(), N_d], ["schild", info_schild_rb(), 1]], [for (k = ZK) [str("zaun_", k), info_zaun(k), 1]],
    [["haus_boden", info_haus_boden(), 1], ["haus_wand_vorne", info_wand("vorne"), 1], ["haus_wand_hinten", info_wand("hinten"), 1],
     ["haus_wand_links", info_wand("links"), 1], ["haus_wand_rechts", info_wand("rechts"), 1],
     ["haus_dach", info_haus_dach(), 1], ["haus_schild", info_schild(), 1]]);
CLIPS = len(CL_POD) + len(CL_DACH) + len(CL_BAHN) + len(CL_WEG) + lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
cpp = floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3));
function np_of(n) = [for (i = INFOS) if (i[0] == n) n_pieces(i[1])][0];
N_vd = raupenkopf ? N_w - 1 : N_w;

echo(str("Raupenbahn 1:", den, " | Podest Ø ", r2(2 * R_pc), " mm (mit Treppe ", r2(2 * R_pc + 3 * d_st), ") | Höhe bis Schild ", r2(z_sb + H_sx), " mm | ",
         N_w, " Wagen, ", wellen, " Wellen à ", r2(A_w), " mm"));
echo(str("Teilung: Podest ", len(PP_POD), " | Umgang ", len(PW), " | Dach ", len(PP_DACH), " | Wellenbahn ", len(PS), " | Säule ", n_ps, " | Verdeck ", n_hs, " | Kuppel ", len(PP_KUP),
         " | Ausleger ", arm_split ? str(np_of("ausleger"), " Stücke") : arm_rot == 45 ? "diagonal" : "1"));
if (z_k0 + H_k > z_u + t_bd + H_b + M(1.5)) echo("HINWEIS: Kuppel ragt weit über das Dach.");
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
echo(str("Verbinder-Clips gesamt: ", CLIPS, CLIPS > cpp ? str(" -> ", ceil(CLIPS / cpp), " Clip-Platten") : ""));

druck("podest", len(PP_POD), "A", farbe_podest, 1); druck("podest", len(PP_POD), "B", farbe_podest_rand, 1);
druck("umgang", len(PW), "A", farbe_podest, 1); druck("umgang", len(PW), "B", farbe_podest_rand, 1);
druck("treppe", len(STK), "alle", farbe_treppe, 1);
druck("zaun", len(ZK) * NP_Z, "alle", farbe_zaun, 1);
druck("koenigszapfen", 1, "alle", farbe_technik, 1);
druck("rotor", np_of("rotor"), "alle", farbe_technik, 1);
druck("ausleger", np_of("ausleger"), "alle", farbe_technik, N_w);
druck("schiene", len(PS), "A", farbe_bahn, 1); druck("schiene", len(PS), "B", farbe_schiene, 1);
for (fp = [["A", farbe_wagen], ["B", farbe_wagen_zier], ["C", farbe_krone]]) druck("wagen", wagen_nummern ? N_w : 1, fp[0], fp[1], wagen_nummern ? 1 : N_w);
druck("sitz", 1, "alle", farbe_sitz, N_w);
druck("verdeck", n_hs, "A", farbe_verdeck, N_vd); druck("verdeck", n_hs, "B", farbe_verdeck_ring, N_vd);
if (raupenkopf) for (fp = [["A", farbe_verdeck], ["B", farbe_verdeck_ring], ["C", farbe_augen], ["D", farbe_pupillen]]) druck("verdeck_kopf", n_hs, fp[0], fp[1], 1);
druck("mittelbau_boden", np_of("mittelbau_boden"), "alle", farbe_mittelbau_platte, 1);
for (fp = [["A", farbe_mittelbau], ["B", farbe_mittelbau_rahmen], ["C", farbe_mittelbau_motiv]]) druck("mittelbau_wand", np_of("mittelbau_wand"), fp[0], fp[1], N_m);
druck("mittelbau_deckel", np_of("mittelbau_deckel"), "A", farbe_mittelbau_platte, 1); druck("mittelbau_deckel", np_of("mittelbau_deckel"), "B", farbe_licht, 1);
druck("kuppel", len(PP_KUP), "A", farbe_kuppel, 1); druck("kuppel", len(PP_KUP), "B", farbe_gold, 1);
for (fp = [["A", farbe_saeule_1], ["B", farbe_saeule_2], ["C", farbe_saeule_3]]) druck("saeule", n_ps, fp[0], fp[1], N_d);
for (fp = [["A", farbe_dach], ["B", farbe_punkte_1], ["C", farbe_punkte_2]]) druck("dach", len(PP_DACH), fp[0], fp[1], 1);
for (fp = [["A", farbe_blende], ["B", farbe_blende_rahmen], ["C", farbe_sonne], ["D", farbe_licht]]) druck("blende", np_of("blende"), fp[0], fp[1], N_d);
druck("notenschluessel", 1, "alle", farbe_notenschluessel, N_d);
for (fp = [["A", farbe_schild], ["B", farbe_schrift], ["C", farbe_noten], ["D", farbe_gold]]) druck("schild", np_of("schild"), fp[0], fp[1], 1);
druck("pflanze", 1, "A", farbe_kuebel, len(PFL)); druck("pflanze", 1, "B", farbe_pflanze, len(PFL));
druck("haus_boden", np_of("haus_boden"), "alle", farbe_haus_boden, 1);
for (w = ["vorne", "hinten", "links", "rechts"]) {
    druck(str("haus_wand_", w), np_of(str("haus_wand_", w)), "A", farbe_haus_wand, 1);
    druck(str("haus_wand_", w), np_of(str("haus_wand_", w)), "B", farbe_haus_kanten, 1);
}
druck("haus_dach", np_of("haus_dach"), "A", farbe_haus_dach, 1);
if (haus_stil == "flightcase") druck("haus_dach", np_of("haus_dach"), "B", farbe_haus_kanten, 1);
druck("haus_schild", np_of("haus_schild"), "A", farbe_schild_A, 1);
druck("haus_schild", np_of("haus_schild"), "B", farbe_schild_B, 1);
druck("verbinder", ceil(max(CLIPS, 4) / cpp), "alle", farbe_clips, 1);
farben_echo();

HP = pol(R_pc + M(3.0), sidec(14) + 2);
module kasse_platz() translate([HP[0] - W_h / 2, HP[1] - D_h / 2, 0]) children();
if (teil == "aufbau") { raupenbahn(); if (kassenhaus_zeigen) kasse_platz() kassenhaus(); }
else if (teil == "explosion") { raupenbahn(max(sc(1600), 14)); if (kassenhaus_zeigen) kasse_platz() kassenhaus(max(sc(800), 8)); }
else if (teil == "podest") podest_druck(stueck, farbteil);
else if (teil == "umgang") weg_druck(stueck, farbteil);
else if (teil == "treppe") treppe_druck(stueck);
else if (teil == "zaun") zaun_druck(stueck);
else if (teil == "koenigszapfen") translate([d_kc / 2, d_kc / 2, H_p - 1]) koenigszapfen();
else if (teil == "rotor") split_out(info_rotor(), stueck) rotor_druck();
else if (teil == "ausleger") { if (arm_split) split_out(info_arm(), stueck) ausleger_druck(); else ausleger_druck(); }
else if (teil == "schiene") bahn_druck(stueck, farbteil);
else if (teil == "wagen") translate([B_w / 2 + 1 + r_c * (1 - cos(al_c)), L_w / 2 + 1, 0]) wagen(farbteil, wagen_nummern ? max(1, stueck) : 0);
else if (teil == "sitz") translate([B_w / 2 + 1, L_w / 2 + 1, -t_fl]) sitz();
else if (teil == "verdeck") verdeck_druck(stueck, farbteil, false);
else if (teil == "verdeck_kopf") verdeck_druck(stueck, farbteil, true);
else if (teil == "mittelbau_boden") split_out(info_mb(R_mb, t_mb), stueck) translate([R_mb / tcm, R_mb / tcm, -z_mb]) mb_boden();
else if (teil == "mittelbau_wand") split_out(info_mbw(), stueck) mb_wand_lokal(farbteil);
else if (teil == "mittelbau_deckel") split_out(info_mb(R_md, t_md), stueck) translate([R_md / tcm, R_md / tcm, -z_md]) mb_deckel(farbteil);
else if (teil == "kuppel") kuppel_druck(stueck, farbteil);
else if (teil == "saeule") saeule_druck(stueck, farbteil);
else if (teil == "dach") dach_druck(stueck, farbteil);
else if (teil == "blende") split_out(info_blende(), stueck) blende_lokal(farbteil);
else if (teil == "notenschluessel") ns_druck();
else if (teil == "schild") split_out(info_schild_rb(), stueck) rs_druck(farbteil);
else if (teil == "pflanze") translate([r_bu + 1, r_bu + 1, 0]) pflanze(farbteil);
else if (teil == "haus_boden") split_out(info_haus_boden(), stueck) haus_boden_druck();
else if (teil == "haus_wand_vorne") split_out(info_wand("vorne"), stueck) wand_druck("vorne", farbteil);
else if (teil == "haus_wand_hinten") split_out(info_wand("hinten"), stueck) wand_druck("hinten", farbteil);
else if (teil == "haus_wand_links") split_out(info_wand("links"), stueck) wand_druck("links", farbteil);
else if (teil == "haus_wand_rechts") split_out(info_wand("rechts"), stueck) wand_druck("rechts", farbteil);
else if (teil == "haus_dach") split_out(info_haus_dach(), stueck) haus_dach_druck(farbteil);
else if (teil == "haus_schild") split_out(info_schild(), stueck) schild_druck(farbteil);
else if (teil == "verbinder") verbinder_platten(verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4), stueck);
