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
          ["hellblau", "#5aa2dc"], ["dunkelgruen", "#1f6b3a"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

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

// =====================================================================
//  deko_kasse.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Kassenhäuschen (Maße + Module + info_*). Erwartet im Modell die Parameter
//  haus_stil, haus_breite_m, haus_tiefe_m, haus_hoehe_m, tuer, schild_text, kasse_text,
//  schild_font, rennbahn_taschen und die Farben farbe_haus_*, farbe_schild_A/B, farbteil.
//  INFOS/DRUCK/Dispatch: siehe doku/KONVENTIONEN.md (Abschnitt Kasse).
// =====================================================================
// ---- Kassenhäuschen ----
W_h  = sc(haus_breite_m * 1000, 15);
D_h  = sc(haus_tiefe_m * 1000, 12);
H_h  = sc(haus_hoehe_m * 1000, 15);
g_h  = max(sc(60), 1.2);                         // Nuttiefe
m_h  = max(sc(300), 3);
m_hf = max(sc(700), 5);
HBX  = W_h + 2 * m_h; HBY = D_h + m_hf + m_h;
hs_split = HBX > usable || HBY > usable || H_h + 2 * g_h > usable;
t_h  = max(sc(60), 1.6, hs_split ? clipd + 0.3 : 0);
hb_h = max(sc(150), g_h + 0.8, hs_split ? clipd + 0.4 : 0);
dm   = max(sc(15), 0.3);                         // Relief
fwid = max(sc(60), 0.8);
f_pitch = max(sc(140), 1.5); f_gw = max(sc(15), 0.4);
gdp  = max(min(sc(12), 0.6), 0.3);
ww_h = min(sc(1200), W_h - 2 * max(sc(400), 4));
wx0  = (W_h - ww_h) / 2; wx1 = wx0 + ww_h;
v_s  = sc(1000, 4);
v_t  = min(sc(1900), H_h - sc(350, 3));
c_out = max(sc(250), 2.5);
LS_h = D_h - 2 * t_h;
dw_h = min(sc(800), LS_h * 0.5); dh_h = min(sc(2000), H_h - sc(200, 2));
du0  = LS_h * 0.5 - dw_h / 2;
fw_h = min(sc(700), LS_h * 0.45); fh_h = min(sc(700), H_h * 0.3);
fv0  = min(sc(1100), H_h - fh_h - sc(300)); fu0 = LS_h / 2 - fw_h / 2;
tuer_wand = tuer; fenster_wand = tuer == "links" ? "rechts" : "links";
ov_h = max(sc(250), 2);
RXh  = W_h + 2 * ov_h; RYh = D_h + 2 * ov_h;
rt_h = max(sc(120), g_h + 0.8, hs_split ? clipd : 0);
h_rf = haus_stil == "flightcase" ? sc(250, 2) : sc(700, 4);
sw_h = min(W_h * 1.1, sc(2600));
sh_h = sc(600, 6);
st_h = max(sc(60), 1.6, sw_h > usable ? clipd : 0);
pw_h = max(sc(150), 2.0);                        // Schildzapfen
pl_h = min(rt_h + h_rf * 0.6, max(sc(150), 2));
PXh  = max(RXh * 0.3, sw_h * 0.5);
PYh  = max(st_h + 2 * (spiel + min_wand) + 1, sc(300));
spx  = [0.2 * sw_h, 0.8 * sw_h];
s_bd = max(sc(40), 0.8);
s_te = max(sc(15), 0.4);
s_ts = min(sh_h * 0.55, (sw_h - 4 * s_bd) / max(1, len(schild_text) * 0.8));

// =====================================================================
//  KASSENHÄUSCHEN  (lokal: x = Breite, y = Tiefe, vorne y = 0)
// =====================================================================
module ring_2d() difference() {
    offset(delta = spiel) square([W_h, D_h]);
    translate([t_h, t_h]) offset(delta = -spiel) square([W_h - 2 * t_h, D_h - 2 * t_h]);
}
module haus_boden() {
    pd = max(sc(10), 0.3); pwd2 = max(sc(15), 0.35); pp = max(sc(500), 4);
    difference() {
        translate([-m_h, -m_hf, 0]) cube([HBX, HBY, hb_h]);
        translate([0, 0, hb_h - g_h]) linear_extrude(g_h + 1) ring_2d();
        translate([-m_h, -m_hf, hb_h - pd]) {
            for (k = [1 : 1 : floor(HBX / pp)]) translate([k * pp - pwd2 / 2, -1, 0]) cube([pwd2, m_hf - 0.5, pd + 1]);
            for (k = [1 : 1 : floor(m_hf / pp)]) translate([-1, k * pp - pwd2 / 2, 0]) cube([HBX + 2, pwd2, pd + 1]);
        }
        if (rennbahn_taschen) {
            translate([-m_h, D_h / 2, 0]) rb_slot();
            translate([W_h + m_h, D_h / 2, 0]) rotate([0, 0, 180]) rb_slot();
        }
    }
}
module haus_boden_druck() translate([m_h, m_hf, 0]) haus_boden();
function info_haus_boden() = let(ox = m_h, oy = m_hf,
    kp = concat([[ox - 1.5, oy - 1.5, ox + W_h + 1.5, oy + t_h + 1.5], [ox - 1.5, oy + D_h - t_h - 1.5, ox + W_h + 1.5, oy + D_h + 1.5],
                 [ox - 1.5, oy - 1.5, ox + t_h + 1.5, oy + D_h + 1.5], [ox + W_h - t_h - 1.5, oy - 1.5, ox + W_h + 1.5, oy + D_h + 1.5]],
                rennbahn_taschen ? [[-1, oy + D_h / 2 - cw1, cL + 1, oy + D_h / 2 + cw1], [HBX - cL - 1, oy + D_h / 2 - cw1, HBX + 1, oy + D_h / 2 + cw1]] : []))
    [HBX, HBY, seams_at(HBX, [], mw), seams_at(HBY, [], mw), kp, false, 0, []];

function wlen(k) = (k == "vorne" || k == "hinten") ? W_h : LS_h;
function openings(k) = k == "vorne" ? [[wx0, v_s, wx1, v_t]] : k == fenster_wand ? [[fu0, fv0, fu0 + fw_h, fv0 + fh_h]] : [];
module raised(u0, v0, u1, v1, h = dm) translate([u0, v0, t_h - e]) cube([u1 - u0, v1 - v0, h + e]);
module wand_local(k, fp = "alle") {
    L = wlen(k);
    if (inc(fp, "A")) difference() {
        union() {
            cube([L, H_h, t_h]);
            translate([0, -(g_h - spiel), 0]) cube([L, g_h - spiel + e, t_h]);
            translate([0, H_h - e, 0]) cube([L, g_h - spiel + e, t_h]);
        }
        trim = (k == "vorne" || k == "hinten") ? fwid * 1.3 + f_gw : 0;
        if (haus_stil != "flightcase") for (j = [1 : 1 : floor(L / f_pitch - 0.01)]) if (j * f_pitch > trim && j * f_pitch < L - trim)
            translate([j * f_pitch - f_gw / 2, 0, t_h - gdp]) cube([f_gw, H_h, gdp + 1]);
        for (o = openings(k)) translate([o[0], o[1], -1]) cube([o[2] - o[0], o[3] - o[1], t_h + 2]);
        if (k == tuer_wand) {
            fg = max(sc(25), 0.4); fd = max(min(gdp + 0.2, t_h * 0.35), 0.3);
            translate([0, 0, t_h - fd]) difference() {
                translate([du0 - fg, -1, 0]) cube([dw_h + 2 * fg, dh_h + fg + 1, fd + 1]);
                translate([du0, -2, -1]) cube([dw_h, dh_h + 2, fd + 3]);
            }
        }
    }
    if (inc(fp, "B")) {
    // Details (Außenseite = oben beim Druck)
    if (k == "vorne" || k == "hinten") { raised(0, 0, fwid * 1.3, H_h); raised(L - fwid * 1.3, 0, L, H_h); }
    if (k == "vorne") {
        raised(wx0 - fwid, v_s, wx0, v_t + fwid); raised(wx1, v_s, wx1 + fwid, v_t + fwid);
        raised(wx0 - fwid, v_t, wx1 + fwid, v_t + fwid);
        // Zahlbrett (steht vor)
        translate([wx0 - fwid, v_s - max(sc(60), 1.2), t_h - e]) cube([ww_h + 2 * fwid, max(sc(60), 1.2), c_out + e]);
        // Sprechgitter in der Fenstermitte
        // Schriftzug über dem Fenster
        ts = (H_h - v_t - fwid) * 0.6;
        translate([W_h / 2, v_t + fwid + (H_h - v_t - fwid) / 2, t_h - e]) linear_extrude(dm * 2 + e)
            resize([min(ww_h, len(kasse_text) * ts * 0.72), 0]) text(kasse_text, size = ts, font = schild_font, halign = "center", valign = "center");
        // Preistafel neben dem Fenster
        avail = wx0 - fwid - fwid * 1.3;
        bw = min(sc(350), avail * 0.75); bh = min(sc(500), bw * 1.5);
        if (bw > 2) for (uc = [fwid * 1.3 + avail / 2]) {
            vc = v_s + (v_t - v_s) * 0.5;
            raised(uc - bw / 2, vc - bh / 2, uc + bw / 2, vc + bh / 2, dm * 1.5);
            for (j = [1 : 4]) raised(uc - bw * 0.35, vc + bh / 2 - j * bh / 5 - dm / 2, uc + bw * 0.35, vc + bh / 2 - j * bh / 5 + dm / 2, dm * 2.5);
        }
    }
    if (k == fenster_wand) {
        raised(fu0 - fwid, fv0 - fwid, fu0 + fw_h + fwid, fv0 + fh_h + fwid);
        raised(fu0 - fwid * 1.5, fv0 - fwid * 1.6, fu0 + fw_h + fwid * 1.5, fv0 - fwid * 0.6, dm * 3);
    }
    if (k == tuer_wand) raised(du0 + dw_h - sc(150, 1.0), sc(1050), du0 + dw_h - sc(150, 1.0) + sc(40, 0.6), sc(1050) + sc(160, 1.4), dm * 2.5);
    if (haus_stil == "flightcase") {   // Alu-Kanten, Eckschoner, Verschlüsse
        fw2 = max(sc(80), 1.0); ec = max(sc(250), 2.5); vh = sc(120, 1.2);
        raised(0, 0, L, fw2, dm * 2); raised(0, H_h - fw2, L, H_h, dm * 2);
        raised(0, 0, fw2, H_h, dm * 2); raised(L - fw2, 0, L, H_h, dm * 2);
        for (u = [0, L - ec], v = [0, H_h - ec]) raised(u, v, u + ec, v + ec, dm * 3.5);
        if (k == "links" || k == "rechts" || k == "hinten") for (u = [L * 0.25, L * 0.75 - sc(250, 2.5)]) if (k != tuer_wand || u + sc(250, 2.5) < du0 || u > du0 + dw_h)
            raised(u, H_h * 0.62, u + sc(250, 2.5), H_h * 0.62 + vh, dm * 3);
    }
    }
}
module wand_welt(k, fp = "alle") {
    if (k == "vorne")       translate([0, t_h, hb_h]) rotate([90, 0, 0]) wand_local(k, fp);
    else if (k == "hinten") translate([W_h, D_h - t_h, hb_h]) rotate([90, 0, 180]) wand_local(k, fp);
    else if (k == "links")  translate([t_h, D_h - t_h, hb_h]) rotate([90, 0, -90]) wand_local(k, fp);
    else                    translate([W_h - t_h, t_h, hb_h]) rotate([90, 0, 90]) wand_local(k, fp);
}
module wand_druck(k, fp = "alle") translate([0, g_h, 0]) wand_local(k, fp);
function info_wand(k) = let(L = wlen(k), SY = H_h + 2 * g_h,
    kp = concat([for (o = openings(k)) [o[0] - 1, o[1] + g_h - 1, o[2] + 1, o[3] + g_h + 1]],
                [[-1, -1, L + 1, g_h + 1.5], [-1, H_h + g_h - 1.5, L + 1, SY + 1]]))
    [L, SY, seams_at(L, [], mw), seams_at(SY, [], mw), kp, false, 0, []];

z_rh = hb_h + H_h;                                // Dachunterseite
rk_e = max(sc(200), 2);
module kugelecken() for (x = [-ov_h + rk_e * 1.2, W_h + ov_h - rk_e * 1.2], y = [-ov_h + rk_e * 1.2, D_h + ov_h - rk_e * 1.2]) translate([x, y, z_rh + rt_h]) sphere(r = rk_e, $fn = 20);
module haus_dach(fp = "alle") {   // aufrecht gedruckt (Unterseite auf dem Bett)
    if (inc(fp, "B") && haus_stil == "flightcase") intersection() { kugelecken(); translate([-ov_h - 1, -ov_h - 1, z_rh + 0.6]) cube([RXh + 2, RYh + 2, rt_h + h_rf + 5]); }
    if (inc(fp, "A")) difference() {
        union() {
            translate([-ov_h, -ov_h, z_rh]) cube([RXh, RYh, rt_h]);
            hull() {
                translate([-ov_h, -ov_h, z_rh + rt_h - e]) cube([RXh, RYh, e]);
                translate([W_h / 2 - PXh / 2, D_h / 2 - PYh / 2, z_rh + rt_h + h_rf - e]) cube([PXh, PYh, e]);
            }
        }
        translate([0, 0, z_rh - e]) linear_extrude(g_h + e) ring_2d();
        if (haus_stil == "flightcase") intersection() { kugelecken(); translate([-ov_h - 1, -ov_h - 1, z_rh + 0.6]) cube([RXh + 2, RYh + 2, rt_h + h_rf + 5]); }
        for (x = spx) translate([W_h / 2 - sw_h / 2 + x - pw_h / 2 - spiel, D_h / 2 - st_h / 2 - spiel, z_rh + rt_h + h_rf - pl_h - 0.2])
            cube([pw_h + 2 * spiel, st_h + 2 * spiel, pl_h + 1]);
        // Traufkante
        tk = max(sc(40), 0.4);
        translate([-ov_h - 1, -ov_h - 1, z_rh + rt_h * 0.5]) difference() {
            cube([RXh + 2, RYh + 2, tk]);
            translate([1 + tk, 1 + tk, -1]) cube([RXh - 2 * tk, RYh - 2 * tk, tk + 2]);
        }
    }
}
module haus_dach_druck(fp = "alle") translate([ov_h, ov_h, -z_rh]) haus_dach(fp);
function info_haus_dach() = let(ox = ov_h, oy = ov_h,
    kp = [[ox - 1.5, oy - 1.5, ox + W_h + 1.5, oy + t_h + 1.5], [ox - 1.5, oy + D_h - t_h - 1.5, ox + W_h + 1.5, oy + D_h + 1.5],
          [ox - 1.5, oy - 1.5, ox + t_h + 1.5, oy + D_h + 1.5], [ox + W_h - t_h - 1.5, oy - 1.5, ox + W_h + 1.5, oy + D_h + 1.5]])
    [RXh, RYh, seams_at(RXh, [for (x = spx) [ox + W_h / 2 - sw_h / 2 + x - pw_h - spw, ox + W_h / 2 - sw_h / 2 + x + pw_h + spw]], mw), seams_at(RYh, [], mw), kp, false, 0, []];

module schild_local(fp) {   // x = Breite, y = Höhe (Zapfen unten), z = Dicke
    difference() {
        union() {
            if (inc(fp, "A")) {
                cube([sw_h, sh_h, st_h]);
                for (x = spx) translate([x - pw_h / 2, -pl_h, 0]) cube([pw_h, pl_h + e, st_h]);
            }
            if (inc(fp, "B")) translate([0, 0, st_h - e]) {
                linear_extrude(s_te + e) difference() { square([sw_h, sh_h]); translate([s_bd, s_bd]) square([sw_h - 2 * s_bd, sh_h - 2 * s_bd]); }
                linear_extrude(s_te + e) translate([sw_h / 2, sh_h / 2]) resize([min(sw_h - 4 * s_bd, len(schild_text) * sh_h * 0.55 * 0.72), 0]) text(schild_text, size = sh_h * 0.55, font = schild_font, halign = "center", valign = "center");
                // Glühbirnen am Rand
                nb = max(2, floor(sw_h / max(sc(250), 3)));
                for (i = [0 : nb]) for (y = [s_bd / 2, sh_h - s_bd / 2]) translate([s_bd / 2 + i * (sw_h - s_bd) / nb, y, 0]) cylinder(d = s_bd * 0.8, h = s_te * 2, $fn = 10);
            }
        }
    }
}
module schild_welt(fp) translate([W_h / 2 - sw_h / 2, D_h / 2 + st_h / 2, z_rh + rt_h + h_rf]) rotate([90, 0, 0]) schild_local(fp);
module schild_druck(fp) translate([0, pl_h, 0]) schild_local(fp);
function info_schild() = [sw_h, sh_h + pl_h, seams_at(sw_h, [for (x = spx) [x - pw_h - spw, x + pw_h + spw]], mw), [], [[-1, -1, sw_h + 1, pl_h + 1.5]], false, 0, []];
module kassenhaus(ex = 0) {
    color(fhex(farbe_haus_boden)) haus_boden();
    for (k = ["vorne", "hinten", "links", "rechts"]) translate([0, 0, ex]) { color(fhex(farbe_haus_wand)) wand_welt(k, "A"); color(fhex(farbe_haus_kanten)) wand_welt(k, "B"); }
    translate([0, 0, 2 * ex]) { color(fhex(farbe_haus_dach)) haus_dach("A"); color(fhex(farbe_haus_kanten)) haus_dach("B"); }
    translate([0, 0, 3 * ex]) { if (inc(farbteil, "A")) color(fhex(farbe_schild_A)) schild_welt("A"); if (inc(farbteil, "B")) color(fhex(farbe_schild_B)) schild_welt("B"); }
}

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
//  deko_ornamente.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  2D-Ornamente als Strichzüge: Notenschlüssel, Saxophon, Noten, Stern, Krone.
//  Erwartet: deko_hilfen.scad (smooth, stroke).
// =====================================================================
// =====================================================================
//  ORNAMENTE (2D, Einheitshöhe 1)
// =====================================================================
CLEF = [[0.03, 0.33, 0.03], [-0.025, 0.37, 0.035], [0.00, 0.43, 0.045], [0.075, 0.445, 0.055], [0.135, 0.395, 0.06], [0.15, 0.30, 0.065],
        [0.10, 0.21, 0.065], [0.00, 0.175, 0.06], [-0.10, 0.205, 0.055], [-0.165, 0.30, 0.05], [-0.15, 0.43, 0.05], [-0.07, 0.535, 0.05],
        [0.035, 0.625, 0.045], [0.105, 0.715, 0.04], [0.125, 0.81, 0.035], [0.105, 0.905, 0.03], [0.06, 0.975, 0.028], [0.018, 0.945, 0.03],
        [-0.008, 0.86, 0.032], [-0.005, 0.72, 0.034], [0.012, 0.55, 0.036], [0.03, 0.35, 0.038], [0.045, 0.16, 0.04], [0.048, 0.05, 0.04],
        [0.02, -0.025, 0.038], [-0.04, -0.045, 0.035], [-0.085, -0.02, 0.035]];
CLEF_S = smooth(CLEF);
module clef_2d(H, wmin) { stroke(CLEF_S, H, wmin); translate([-0.072 * H, 0]) circle(d = max(0.09 * H, wmin * 1.6), $fn = 20); }
SAX = smooth([[-0.20, 0.97, 0.03], [-0.15, 0.93, 0.035], [-0.08, 0.90, 0.045], [-0.025, 0.85, 0.06], [0.0, 0.76, 0.075], [0.0, 0.55, 0.095],
       [0.0, 0.35, 0.11], [0.02, 0.18, 0.125], [0.08, 0.08, 0.14], [0.17, 0.06, 0.15], [0.25, 0.11, 0.15], [0.29, 0.22, 0.15], [0.30, 0.38, 0.16], [0.31, 0.52, 0.18]], 3);
module sax_2d(H, wmin) {
    stroke(SAX, H, wmin);
    hull() { translate([0.31 * H, 0.52 * H]) circle(d = 0.18 * H); translate([0.17 * H, 0.70 * H]) circle(d = max(0.06 * H, wmin)); translate([0.47 * H, 0.67 * H]) circle(d = max(0.06 * H, wmin)); }
    translate([-0.215 * H, 0.975 * H]) circle(d = max(0.04 * H, wmin));
}
module sax_keys_2d(H) for (p = [[0, 0.68], [0, 0.6], [0.005, 0.5], [0.01, 0.4], [0.02, 0.3], [0.3, 0.3], [0.3, 0.42]]) translate(p * H) circle(d = 0.05 * H, $fn = 12);
module note_2d(H, wmin, flag = true) {   // Kopf bei (0,0), H = Halslänge
    rotate(-22) scale([1.35, 1]) circle(d = 0.32 * H, $fn = 20);
    translate([0.17 * H, 0]) square([max(0.055 * H, wmin), H]);
    if (flag) hull() { translate([0.17 * H, H]) square([max(0.055 * H, wmin), 0.01]); translate([0.42 * H, 0.58 * H]) circle(d = max(0.05 * H, wmin), $fn = 12); }
}
module notes2_2d(H, wmin) {
    note_2d(H, wmin, false); translate([0.72 * H, 0.16 * H]) note_2d(H, wmin, false);
    hull() { translate([0.17 * H, 0.9 * H]) square([max(0.055 * H, wmin), 0.11 * H]); translate([0.89 * H, 1.06 * H]) square([max(0.055 * H, wmin), 0.11 * H]); }
}
module star_2d(r) polygon([for (i = [0 : 9]) pol(i % 2 == 0 ? r : r * 0.45, 90 + i * 36)]);
module crown_2d(w) {   // Krone, Breite w, Unterkante y = 0
    polygon([[-0.5, 0], [0.5, 0], [0.5, 0.22], [0.6, 0.78], [0.3, 0.45], [0.15, 0.88], [0, 0.5], [-0.15, 0.88], [-0.3, 0.45], [-0.6, 0.78], [-0.5, 0.22]] * w);
    for (p = [[0.6, 0.78], [0.15, 0.88], [-0.15, 0.88], [-0.6, 0.78]]) translate(p * w) circle(d = 0.16 * w, $fn = 12);
}

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
