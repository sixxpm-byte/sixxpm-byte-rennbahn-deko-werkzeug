// =====================================================================
//  BABYFLUG  –  Kinder-Flugkarussell als zerlegbarer Deko-Bausatz
//  Stil der Rennbahn-Deko-Reihe (Turntables, Containerbrücke):
//  FDM-optimiert (stützfrei), Teile über dem Druckbett werden geteilt
//  (Clips), Stecksystem kompatibel zu rennbahn_deko.scad, Farben je
//  Bauteil (Vorschau, Dateinamen, 3MF über farb_export.py)
//  Maßstäbe 1:43 und 1:87  ·  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    podest          Podest-Ring: Laufsteg + Stufe (16 Seiten, LED-Inlays)
//    boden           Kunstrasen-Boden in der Mitte (Laschen unter dem Ring)
//    saeule          Mittelsäule mit Achse (steht fest)
//    kopf_unten      Drehkopf unten (8 Gabeln, Stiftlager unten)
//    kopf_oben       Drehkopf oben (Stiftlager oben, Hals, Schlüssel)
//    krone           Pavillon mit Spitzbogenfenstern
//    dach            Achteck-Dach mit Strahlenrippen
//    ufo_unten / ufo_oben   UFO auf der Dachspitze (2 Hälften, Stift)
//    arm             Fachwerk-Arm, heb- und senkbar                 8x
//    jet             Jet-Gondel (Farbe über jet_nr)                  8x
//    mast            Ringelmast mit Leuchte (3-farbige Spirale)     16x
//    gelaender       Geländer zwischen den Masten                   15x
//    leuchtmast / leuchtmast_fuss   senkrechtes Leuchtschild
//    kasse_*         Kassenwagen (Fahrgestell, 4 Wände, Dach, Schild, Treppe)
//    verbinder       Clips für den geteilten Podest-Ring
//
//  BEWEGLICH
//    * Der ganze Oberbau (Drehkopf, Arme, Jets, Pavillon, Dach, UFO) dreht
//      sich auf der Achse der Mittelsäule.
//    * Jeder Arm schwenkt auf einem Filament-Stift (1,75 mm). Der Stift
//      liegt fest zwischen den Lagerhälften von kopf_unten / kopf_oben,
//      der Arm dreht stramm darauf und hält so jede Stellung.
//    * Das UFO dreht sich frei auf seinem Stiel.
//
//  MONTAGE
//    1. Podest-Ring: Teile umgedreht hinlegen, Clips eindrücken.
//    2. Kunstrasen-Boden auf den Tisch, Ring von oben darübersetzen
//       (die Laschen des Bodens greifen unter den Ring).
//    3. Säule auf den Zapfen in der Bodenmitte stecken, kopf_unten auf die
//       Achse. Je einen Stift durch jeden Arm schieben (beidseitig gleich
//       weit überstehend), Arme in die unteren Lagerschalen legen,
//       kopf_oben aufsetzen (Achse + Stifte richten ihn aus).
//    4. Jets auf die Zapfen der Arme, Pavillon auf den Schlüssel, Dach auf
//       den Pavillon, UFO-Hälften mit Stift verbinden und in die Spitze.
//    5. Masten in die Löcher, Geländer in die Schlitze. Kasse und
//       Leuchtschild frei daneben (Rennbahn-Taschen an Podest und Fuß).
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, podest:Podest-Ring, boden:Kunstrasen-Boden, saeule:Mittelsäule, kopf_unten:Drehkopf unten, kopf_oben:Drehkopf oben, krone:Pavillon, dach:Dach, ufo_unten:UFO unten, ufo_oben:UFO oben, arm:Arm, jet:Jet-Gondel, mast:Ringelmast, gelaender:Geländer, leuchtmast:Leuchtschild-Mast, leuchtmast_fuss:Leuchtschild-Fuß, kasse_boden:Kassenwagen Fahrgestell, kasse_wand_vorne:Kassenwagen Wand vorne, kasse_wand_hinten:Kassenwagen Wand hinten, kasse_wand_links:Kassenwagen Wand links, kasse_wand_rechts:Kassenwagen Wand rechts, kasse_dach:Kassenwagen Dach, kasse_schild:Kassenwagen Schild, kasse_treppe:Kassenwagen Treppe, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Mehrfarbige Teile: alle oder einzelne Farbe (A = Grundkörper)
farbteil = "alle"; // [alle, A, B, C, D]
// Grundfarbe der Jet-Gondel bei teil = jet
jet_nr = 1; // [1:4]

/* [Vorschau] */
drehung = 15;      // [0:360]
// Armwinkel in der Vorschau (Grad, + = oben)
arm_winkel = 12;   // [-20:25]
kasse_zeigen = true;
leuchtmast_zeigen = true;

/* [Babyflug (Vorbild in Metern)] */
innenboden_radius_m = 4.0;
laufsteg_breite_m   = 0.8;
stufe_breite_m      = 0.35;
laufsteg_hoehe_m    = 0.55;
pavillon_radius_m   = 1.0;
pavillon_hoehe_m    = 0.85;
dach_hoehe_m        = 0.65;
ufo_radius_m        = 0.65;
jet_laenge_m        = 2.2;
jet_spannweite_m    = 1.5;
// Armbereich in Grad: unten = Ruhestellung, oben = maximale Flughöhe
arm_min = -20; // [-30:0]
arm_max = 25;  // [5:35]
// Seite ohne Geländer (Eingang), 0 = rechts, 12 = vorne
eingang_seite = 14; // [0:15]
leuchtschild_text = "BABYFLUG";
schild_schrift = "Liberation Sans:style=Bold";

/* [Kassenwagen (Vorbild in Metern)] */
kasse_breite_m = 3.8;
kasse_tiefe_m  = 2.1;
kasse_hoehe_m  = 2.4;
kasse_bodenhoehe_m = 0.65;
kasse_schild_text = "TICKETS";
kasse_text = "KASSE";

/* [Farben] */
farbe_podest     = "silber";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_licht      = "cyan";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_rasen      = "gruen";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_saeule     = "silber";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kopf       = "silber";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_krone      = "orange";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gold       = "gold";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_dach       = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_ufo        = "silber";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_ufo_licht  = "neongruen"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kuppel     = "cyan";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_arm        = "gelb";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_jet_1      = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_jet_2      = "blau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_jet_3      = "neongruen"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_jet_4      = "pink";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_chrom      = "silber";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_jet_akzent = "gelb";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mast_1     = "gelb";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mast_2     = "pink";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mast_3     = "blau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mastlicht  = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gelaender  = "silber";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_leuchtmast = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_birnen     = "gelb";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schrift    = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_boden = "grau";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_wand = "orange";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_rahmen = "gold";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_dekor = "violett";  // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_dach = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild_A   = "violett";   // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild_B   = "gelb";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_clips      = "grau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

/* [Druck & Passung] */
rennbahn_taschen = true;
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
stift_d = 1.75;
stift_spiel = 0.2;
// Armbohrung: 0 = sehr stramm, 0.05 = hält jede Stellung, 0.15 = leichtgängig
arm_bohrung_spiel = 0.05;
// Stiftlager im Drehkopf: 0 = klemmt den Stift fest
lager_spiel = 0.0;
verbinder_anzahl = 0;

include <../../lib/deko_grundlagen.scad>
GF = [farbe_jet_1, farbe_jet_2, farbe_jet_3, farbe_jet_4];

// =====================================================================
//  Lokale Hilfen (nur Babyflug)
// =====================================================================
// D-Profil mit fester Facettenzahl (Zapfen Boden/Säule)
module dprof32(d, c) intersection() { circle(d = d, $fn = 32); translate([-d - 1, -d - 1]) square([d + 1 + c, 2 * d + 2]); }
module stern(r, n = 5) polygon([for (i = [0 : 2 * n - 1]) pol(i % 2 == 0 ? r : r * 0.45, 90 + i * 180 / n)]);
// Spitzbogen (Fuß bei y = 0, Mitte x = 0): Lanzettbogen, im Scheitel 45° steil,
// dadurch stützfrei druckbar
module spitzbogen(w, h) {
    c = 1.21 * w; R = c + w / 2; ha = sqrt(R * R - c * c);
    h0 = max(0.01, h - ha);
    translate([-w / 2, 0]) square([w, h0 + e]);
    translate([0, h0]) intersection() {
        translate([c, 0]) circle(r = R, $fn = 96);
        translate([-c, 0]) circle(r = R, $fn = 96);
        translate([-w / 2, 0]) square([w, ha + 1]);
    }
}
module oct(ap) rotate(22.5) circle(r = ap / cos(22.5), $fn = 8);   // Achteck, Flächen bei 0°, 45°, ...

// =====================================================================
//  Maße
// =====================================================================
// ---- Podest (16-Eck, Flächen bei k * 22,5°) ----
N_d = 16; ad = 360 / N_d; tc = cos(ad / 2);
R_i  = sc(innenboden_radius_m * 1000, 40);       // Innenboden (Inkreis)
R_wo = R_i + sc(laufsteg_breite_m * 1000, 8);    // Laufsteg außen
R_t  = R_wo + sc(stufe_breite_m * 1000, 3);      // Stufe außen
H_w  = sc(laufsteg_hoehe_m * 1000, 6);
H_s  = H_w * 0.5;
t_ins = max(sc(80), 2.4);                        // Kunstrasen-Boden
z_fl = t_ins;                                    // Bodenoberkante
dmr  = max(sc(20), 0.4);                         // Relief / Gravur
d_inl = max(sc(30), 0.6);                        // Inlay-Tiefe
w_led = max(sc(70), 0.8);
z_led = max(H_w * 0.45, z_fl + 0.4);
d_dot = max(sc(100), 1.0);
w_tab = max(sc(400), 5); l_tab = max(sc(150), 2.5); t_tab = max(sc(50), 1.0);
TABK = [for (k = [1 : 2 : N_d - 1]) k];          // Laschen des Bodens
ring_split = 2 * R_t / tc > usable;

// ---- Masten & Geländer ----
d_p    = max(sc(140), 2.4);
h_pole = sc(1500, 12);
d_bulb = max(sc(220), d_p + 0.8);
r_g    = R_wo - max(sc(180), d_p / 2 + 1.0);     // Mast-/Geländerlinie (Inkreis)
h_ph   = min(H_w - 1.2, max(sc(250), 3));        // Lochtiefe
h_pg   = h_ph - 0.3;                             // Zapfenlänge
L_g    = 2 * r_g * tan(ad / 2) - d_p - 1.0;
h_g    = sc(1000, 10);
t_g    = max(sc(60), 1.2);
w_r    = max(sc(50), 1.0);
tw_g   = max(sc(150), 2.5);
GK     = [for (k = [0 : N_d - 1]) if (k != eingang_seite) k];

// ---- Drehkopf, Arme ----
N_a  = 8; aa = 360 / N_a;
w_arm = max(sc(220), 4.5);                       // Armbreite (tangential)
t_ch  = max(sc(80), 1.6);                        // Gabelwange
ga    = 0.2;                                     // Spiel Arm/Wange je Seite
gap_f = w_arm + 2 * ga;
w_f   = gap_f + 2 * t_ch;
L_pin = w_f;
r_boss = max(sc(180), stift_d / 2 + 1.6);
r_ck   = stift_d / 2 + 1.6;
r_piv  = max(sc(600), r_boss + (w_f / 2) / sin(aa / 2));
r_hk   = r_piv - r_boss - 0.5;                   // Kopf (Inkreis)
h0 = max(sc(380), 2 * r_boss);                   // Armhöhe innen
h1 = max(sc(220), 3.2);                          // Armhöhe außen
c_arm = max(sc(70), 1.2); d_arm = max(sc(50), 1.0);
p_w = max(sc(150), 2.5); p_h = max(sc(150), 2.5);
p_l = max(sc(350), p_w + 2.4);
pad_h = max(sc(80), 1.2);
y_m = h1 / 2 + pad_h;                            // Gondelauflage über Armachse
th_n = (arm_min + arm_max) / 2;                  // Jet waagerecht bei diesem Winkel
Sp  = sc(jet_spannweite_m * 1000, 12);
clr = max(sc(150), 1.0);
phi_min = arm_min - th_n;
L_arm = min(sc(2700), (R_i - clr - Sp / 2 * cos(phi_min) - r_piv + y_m * sin(arm_min)) / cos(arm_min));
function mz(th) = L_arm * sin(th) + y_m * cos(th);   // Gondelauflage relativ zur Achse
function mr(th) = r_piv + L_arm * cos(th) - y_m * sin(th);
// Achshöhe: in Ruhestellung berührt die äußere Flügelspitze fast den Boden
z_piv0 = z_fl + 0.5 + Sp / 2 * sin(abs(phi_min)) - mz(arm_min);
// ---- Säule ----
d_ax = max(sc(220), 4);
r_col = max(sc(300), d_ax / 2 + 2.0);
d_cp = max(sc(320), 4.5); h_cp = max(sc(200), 2.5);
r_cf = max(sc(550), r_col + 2); h_cf = max(sc(100), 1.6);
dz_lo = (r_piv - r_hk) + 1.5 * r_ck + 1;         // Kopf unterhalb der Achse (45°-Wangen)
h_col_min = h_cp + 2.0;
z_piv = max(z_piv0, z_fl + h_col_min + dz_lo);
z_sh  = z_piv - dz_lo;                           // Säulen-Schulter = Kopf-Unterkante
h_col = z_sh - z_fl;
z_bt  = z_piv + r_ck + max(sc(60), 1);           // Kopf-Oberkante
l_ax  = z_bt - 1.0 - z_sh;                       // Achslänge über der Schulter
r_nk  = max(sc(250), 3);
p_k   = r_nk * 1.2;                              // Schlüssel (Vierkant)

// ---- Pavillon, Dach, UFO ----
r_kr = max(sc(pavillon_radius_m * 1000), r_piv + r_ck + 1.5);
r_kc = r_kr / cos(22.5);
h_kr = sc(pavillon_hoehe_m * 1000, 8);
t_kf = max(sc(100), 1.6);
t_kw = max(sc(80), 1.2);
z_kb = max(z_bt + max(sc(150), 1.5),
           z_piv + max(r_boss, (r_kc - r_piv) * tan(arm_max) + (h0 / 2) / cos(arm_max)) + 0.8);
z_kt = z_kb + t_kf + h_kr;
g_d  = max(sc(60), 1.2);                         // Nut im Dach
r_d  = r_kr + max(sc(250), 2);
t_de = max(sc(100), 1.6);
w_rim = max(sc(120), 1.6);
h_d  = sc(dach_hoehe_m * 1000, 6);
d_stem = max(sc(120), 2.5);
r_ap = max(sc(120), d_stem / 2 + spiel + 1.2);
sock_u = min(h_d * 0.6, max(sc(300), 4));
z_db = z_kt - g_d;
z_da = z_db + t_de + h_d;
r_u  = sc(ufo_radius_m * 1000, 7);
h_ub = max(r_u * 0.09, 0.8); h_uc = r_u * 0.2; h_ul = r_u * 0.24;
g_u  = sc(300, 3);
L_stem = g_u + sock_u - 0.3;
z_ur = z_da + g_u + h_ul;                        // UFO-Randebene
d_up = min(3, h_ub + h_uc - 0.8, h_ul - 0.6);    // Stifttiefe je Hälfte

// ---- Jet ----
chord_min = 2 * mr(arm_max) * sin(aa / 2);
Lj = min(sc(jet_laenge_m * 1000, 18), chord_min - 2);
Wj = max(sc(750), w_arm + 2 * spiel + 2.4);
Hj = max(sc(560), p_h + 0.4 + 0.8 + 2.0);
z_cf = max(Hj * 0.4, p_h + 0.4 + 0.8);           // Cockpitboden
t_w  = max(sc(70), 1.0);
t_fin = max(sc(70), 1.2);
h_fin = sc(450, 4);

// ---- Leuchtschild ----
w_lp = max(sc(160), 2.4);
w_lb = sc(700, 8);
h_lb = sc(2800, 30);
h_lm = sc(4600, 45);
t_lm = max(sc(150), 2.4);
w_fs = max(sc(50), 1.0);
h_lf = max(sc(300), 4);
f_w  = sc(900, 12);
h_tab = h_lf - 1.0;
y_b0 = h_lm - h_lb;
dm   = max(sc(20), 0.4);

// ---- Kassenwagen (lokal: x = Breite, y = Tiefe, vorne y = 0) ----
W_k = sc(kasse_breite_m * 1000, 15);
D_k = sc(kasse_tiefe_m * 1000, 12);
H_k = sc(kasse_hoehe_m * 1000, 15);
h_fl_k = sc(kasse_bodenhoehe_m * 1000, 5);       // Oberkante Wagenboden
g_k  = max(sc(60), 1.2);
t_wk = max(sc(60), 1.6);
m_k  = max(sc(80), 1.0);
t_fk = max(sc(120), g_k + 1.0);
l_s  = max(sc(140), 2.4);
LS_k = D_k - 2 * t_wk;
fwid = max(sc(60), 0.8);
fw2  = max(sc(80), 1.0);
ww_k = min(sc(1600), W_k - 2 * sc(500, 4));
wx0 = (W_k - ww_k) / 2; wx1 = wx0 + ww_k;
v_s = sc(900, 4);
v_t = min(sc(1800), H_k - sc(500, 4));
c_out = max(sc(250), 2.5);
dw_k = min(sc(800), LS_k * 0.55); dh_k = min(sc(2000), H_k - sc(250, 2));
du0 = (LS_k - dw_k) / 2;
fw_k = min(sc(700), LS_k * 0.45); fh_k = min(sc(700), H_k * 0.3);
fv0 = min(sc(1100), H_k - fh_k - sc(300)); fu0 = (LS_k - fw_k) / 2;
h_val = max(sc(200), 1.5);
ov_k = max(sc(200), 2);
t_rk = max(sc(150), g_k + 1.2);
h_rr = max(sc(120), 0.8);
RXk = W_k + 2 * ov_k; RYk = D_k + 2 * ov_k;
sw_k = min(W_k * 0.7, sc(2400));
sh_k = sc(600, 6);
st_k = max(sc(60), 1.6);
pw_k = max(sc(150), 2.0);
pl_k = min(t_rk - 0.6, max(sc(150), 2));
spx_k = [0.2 * sw_k, 0.8 * sw_k];
ys_k = t_wk + spiel + 0.8 + st_k / 2;            // Schild-Mitte (y)
s_bd = max(sc(40), 0.8);
s_te = max(sc(15), 0.4);
d_tr = sc(280, 3); w_tr = sc(900, 10);

// Platzierung (Vorschau)
A_KASSE = -22; A_LM = 228;

include <../../lib/deko_hilfen.scad>

// =====================================================================
//  Podest-Ring
// =====================================================================
function ring_fits(m) = fit_pts(spts(R_i, R_t / tc, 0, m * ad), 0, m * ad) != undef;
M_LIST = [for (m = [8, 4, 2]) if (ring_fits(m)) m];
M_R = !ring_split ? N_d : len(M_LIST) > 0 ? M_LIST[0] : 2;
SR  = ring_split ? [for (j = [0 : M_R : N_d - 1]) sidec(j)] : [];
SEAM_K = ring_split ? [for (j = [0 : M_R : N_d - 1]) j] : [];
RP  = ring_split ? [for (i = [0 : len(SR) - 1]) [SR[i], i == len(SR) - 1 ? SR[0] + 360 : SR[i + 1]]] : [[0, 360]];
RBK = [for (k = [6, 10]) if (len([for (q = SEAM_K) if (q == k) 1]) == 0) k];
function rclip_r() = let(r0 = R_i + mw + 0.5, r1 = R_t - mw - 0.5) r1 - r0 >= 2 * mw + 2 ? [r0, r1] : [(r0 + r1) / 2];
RCLIPS = ring_split ? [for (a = SR, r = rclip_r()) concat(pol(r, a), [a + 90])] : [];
L_wo = 2 * R_wo * tan(ad / 2);

module ring_licht() {   // Farbe B: bündige Inlays
    translate([0, 0, z_led]) linear_extrude(w_led) difference() { poly(R_i + d_inl); poly(R_i - e); }
    for (k = [0 : N_d - 1], t = [-1, 0, 1]) side_frame(k, R_wo) translate([-d_inl, t * L_wo / 3, (H_s + H_w) / 2])
        rotate([0, 90, 0]) cylinder(d = d_dot, h = d_inl + e, $fn = 12);
}
module podest_welt(fp = "alle") {
    wl = max(sc(25), 0.4);
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(H_w) difference() { poly(R_wo); poly(R_i); }
            linear_extrude(H_s) difference() { poly(R_t); poly(R_wo - 1); }
        }
        ring_licht();
        // Mastlöcher an den Ecken
        for (j = [0 : N_d - 1]) rotate(vtx(j)) translate([r_g / tc, 0, H_w - h_ph]) cylinder(d = d_p + 2 * spiel, h = h_ph + 1, $fn = 24);
        // Geländerschlitze
        for (k = GK, sg = [-1, 1]) side_frame(k, r_g) translate([-t_g / 2 - spiel, sg * L_g * 0.3 - tw_g / 2 - spiel, H_w - h_ph])
            cube([t_g + 2 * spiel, tw_g + 2 * spiel, h_ph + 1]);
        // Blechstöße auf dem Laufsteg und Kante der Stufe
        for (k = [0 : N_d - 1], sg = [-1, 1]) rotate(sidec(k) + sg * ad / 4)
            translate([R_i / cos(ad / 4) + 0.6, -wl / 2, H_w - dmr]) cube([(R_wo - R_i) / cos(ad / 4) - 1.2, wl, dmr + 1]);
        translate([0, 0, H_s - dmr]) linear_extrude(dmr + 1) difference() { poly(R_wo + 0.6 + wl); poly(R_wo + 0.6); }
        // Taschen für die Laschen des Bodens
        for (k = TABK) side_frame(k, R_i) translate([-e, -w_tab / 2 - spiel, -e]) cube([l_tab + spiel + e, w_tab + 2 * spiel, t_tab + spiel + e]);
        if (rennbahn_taschen) for (k = RBK) side_frame(k, R_t) rotate(180) rb_slot();
        for (c = RCLIPS) translate([c[0], c[1], 0]) clip_cut(c[2]);
    }
    if (inc(fp, "B")) intersection() {
        ring_licht();
        linear_extrude(H_w) difference() { poly(R_wo); poly(R_i); }
    }
}
function rp_pts(i) = spts(R_i, R_t / tc, RP[i][0], RP[i][1]);
RRHO = [for (i = [0 : len(RP) - 1]) let(r = fit_pts(rp_pts(i), RP[i][0], RP[i][1])) r == undef ? 90 - (RP[i][0] + RP[i][1]) / 2 : r];
module podest_stueck(i, fp) intersection() { podest_welt(fp); translate([0, 0, -1]) linear_extrude(H_w + 2) wedge_mask(RP[i][0], RP[i][1], R_t / tc + 2); }
module podest_druck(stk, fp) {
    if (!ring_split) translate([R_t / tc, R_t / tc, 0]) podest_welt(fp);
    else for (i = [0 : len(RP) - 1]) if (stk == 0 || stk == i + 1) let(b = bb([for (p = rp_pts(i)) rotp(p, RRHO[i])]))
        translate([(stk == 0 ? (i % 2) * (usable + 10) : 0) - b[0], (stk == 0 ? floor(i / 2) * (usable + 10) : 0) - b[1], 0])
        rotate([0, 0, RRHO[i]]) podest_stueck(i, fp);
}

// =====================================================================
//  KUNSTRASEN-BODEN (mit Laschen unter dem Ring und Zapfen für die Säule)
// =====================================================================
module boden_welt() {
    difference() {
        union() {
            linear_extrude(t_ins) poly(R_i - spiel);
            for (k = TABK) side_frame(k, R_i - spiel - 1) translate([0, -w_tab / 2, 0]) cube([l_tab + spiel + 1 - spiel, w_tab, t_tab]);
        }
        // Landekreis-Markierung (Gravur)
        translate([0, 0, t_ins - dmr]) linear_extrude(dmr + 1) difference() { circle(r = r_cf + max(sc(250), 2) + max(sc(40), 0.6)); circle(r = r_cf + max(sc(250), 2)); }
    }
    translate([0, 0, t_ins - e]) linear_extrude(h_cp + e) dprof32(d_cp, 0.35 * d_cp);
}

// =====================================================================
//  MITTELSÄULE (z = 0 auf dem Boden)
// =====================================================================
module saeule() {
    tp = min(r_cf - r_col, max(0, h_col - h_cf - 1));
    difference() {
        union() {
            cylinder(r = r_cf, h = h_cf, $fn = 48);
            translate([0, 0, h_cf - e]) cylinder(r1 = r_cf, r2 = r_cf - tp, h = tp + e, $fn = 48);
            cylinder(r = r_col, h = h_col, $fn = 48);
            translate([0, 0, h_col - e]) cylinder(d = d_ax, h = l_ax - 0.4 + e, $fn = 32);
            translate([0, 0, h_col + l_ax - 0.4]) cylinder(d1 = d_ax, d2 = d_ax - 0.8, h = 0.4, $fn = 32);
        }
        translate([0, 0, -e]) linear_extrude(h_cp + 0.3 + e) offset(delta = spiel) dprof32(d_cp, 0.35 * d_cp);
        // Zierrillen
        for (z = [h_cf + tp + 1.5 : max(sc(250), 2.5) : h_col - 1]) translate([0, 0, z]) difference() {
            cylinder(r = r_col + 1, h = max(sc(30), 0.4), $fn = 48); translate([0, 0, -1]) cylinder(r = r_col - dmr, h = 3, $fn = 48);
        }
    }
}

// =====================================================================
//  DREHKOPF (zweiteilig, Teilung in der Stiftebene)   Welt-z
// =====================================================================
module wange_2d(oben) intersection() {
    hull() { translate([0, z_sh]) square([r_hk, z_bt - z_sh]); translate([r_piv, z_piv]) circle(r = r_ck, $fn = 40); }
    if (oben) translate([-1, z_piv]) square([2 * r_piv + 10, z_bt]);
    else      translate([-1, z_sh - 1]) square([2 * r_piv + 10, z_piv - z_sh + 1]);
}
module wangen(oben) for (k = [0 : N_a - 1]) rotate(k * aa) for (sg = [-1, 1])
    translate([0, sg * (gap_f / 2 + t_ch / 2), 0]) rotate([90, 0, 0]) linear_extrude(t_ch, center = true) wange_2d(oben);
module stiftlager() for (k = [0 : N_a - 1]) rotate(k * aa) translate([r_piv, 0, z_piv]) rotate([90, 0, 0])
    cylinder(d = stift_d + lager_spiel, h = w_f + 2, center = true, $fn = 24);
module kopf_unten() difference() {
    union() {
        translate([0, 0, z_sh]) linear_extrude(z_piv - z_sh) oct(r_hk);
        wangen(false);
    }
    translate([0, 0, z_sh - 1]) cylinder(d = d_ax + 2 * cl, h = z_piv - z_sh + 2, $fn = 32);
    stiftlager();
}
module kopf_oben() difference() {
    union() {
        translate([0, 0, z_piv]) linear_extrude(z_bt - z_piv) oct(r_hk);
        wangen(true);
        translate([0, 0, z_bt - e]) cylinder(r = r_nk, h = z_kb - z_bt + e, $fn = 32);
        translate([0, 0, z_kb - e]) linear_extrude(t_kf - 0.2 + e) square(p_k, center = true);
    }
    translate([0, 0, z_piv - 1]) cylinder(d = d_ax + 2 * cl, h = l_ax - (z_piv - z_sh) + 0.4 + 1, $fn = 32);
    stiftlager();
    // Zierrille am Kopf
    translate([0, 0, z_bt - max(sc(60), 0.8)]) linear_extrude(max(sc(25), 0.4)) difference() { oct(r_hk + 1); oct(r_hk - dmr); }
}

// =====================================================================
//  ARM (2D-Profil: x entlang Arm, y senkrecht; Achse im Ursprung)
// =====================================================================
function hh(x) = h0 + (h1 - h0) * x / L_arm;
module arm_2d() difference() {
    union() {
        circle(r = r_boss, $fn = 40);
        if (min(h0, h1) - 2 * c_arm < 2.2)
            hull() { translate([0, -h0 / 2]) square([e, h0]); translate([L_arm - e, -h1 / 2]) square([e, h1]); }
        else {
            hull() { translate([0, h0 / 2 - c_arm]) square([e, c_arm]); translate([L_arm - e, h1 / 2 - c_arm]) square([e, c_arm]); }
            hull() { translate([0, -h0 / 2]) square([e, c_arm]); translate([L_arm - e, -h1 / 2]) square([e, c_arm]); }
            n = max(2, round(L_arm / ((h0 + h1) / 2)));
            for (k = [0 : n - 1]) let(x0 = k * L_arm / n, x1 = (k + 1) * L_arm / n, y0 = hh(x0) / 2 - c_arm / 2, y1 = hh(x1) / 2 - c_arm / 2)
                bar([x0, (k % 2 == 0 ? -1 : 1) * y0], [x1, (k % 2 == 0 ? 1 : -1) * y1], d_arm);
        }
        translate([L_arm - p_l / 2, -h1 / 2]) square([p_l / 2, h1]);
        translate([L_arm, y_m]) rotate(-th_n) {
            translate([-p_l / 2, -(pad_h + h1 * 0.6)]) square([p_l, pad_h + h1 * 0.6]);
            translate([-p_w / 2, -e]) square([p_w, p_h + e]);
        }
    }
    circle(d = stift_d + arm_bohrung_spiel, $fn = 24);
}
module arm() linear_extrude(w_arm) arm_2d();

// =====================================================================
//  JET-GONDEL  (x = Länge/Nase, y = Flügel, z = hoch; Auflage im Ursprung)
// =====================================================================
module jet_rumpf() intersection() {
    hull() {
        translate([Lj * 0.06, 0, 0]) scale([Lj * 0.41, Wj / 2, Hj]) sphere(1, $fn = 40);
        translate([-Lj * 0.36, 0, 0]) scale([Lj * 0.14, Wj * 0.26, Hj * 0.62]) sphere(1, $fn = 32);
    }
    translate([-Lj, -Wj, 0]) cube([2 * Lj, 2 * Wj, 2 * Hj]);
}
module jet_fluegel_2d() offset(r = t_w) offset(delta = -t_w) polygon([
    [Lj * 0.14, 0], [-Lj * 0.10, Sp / 2], [-Lj * 0.22, Sp / 2], [-Lj * 0.18, 0], [-Lj * 0.22, -Sp / 2], [-Lj * 0.10, -Sp / 2]]);
module jet_leitwerk_2d() polygon([
    [-Lj * 0.33, 0], [-Lj * 0.43, Sp * 0.22], [-Lj * 0.49, Sp * 0.22], [-Lj * 0.47, 0], [-Lj * 0.49, -Sp * 0.22], [-Lj * 0.43, -Sp * 0.22]]);
module jet_finne(oben) intersection() {
    rotate([90, 0, 0]) linear_extrude(t_fin, center = true)
        polygon([[-Lj * 0.20, Hj * 0.55], [-Lj * 0.40, Hj + h_fin], [-Lj * 0.49, Hj + h_fin], [-Lj * 0.47, Hj * 0.3]]);
    if (oben) translate([-Lj, -Lj, Hj + h_fin * 0.7]) cube([2 * Lj, 2 * Lj, Lj]);
    else      translate([-Lj, -Lj, -1]) cube([2 * Lj, 2 * Lj, Hj + h_fin * 0.7 + 1]);
}
module jet_nase() translate([Lj * 0.40, -Lj, -1]) cube([Lj, 2 * Lj, 2 * Hj]);
module jet_cockpit() {
    translate([-Lj * 0.02, 0, z_cf]) linear_extrude(2 * Hj) offset(r = Wj * 0.12) square([Lj * 0.30 - Wj * 0.24, Wj * 0.56 - Wj * 0.24], center = true);
}
module jet_scheibe() difference() {   // Windschutzscheibe (B)
    intersection() {
        scale([1, 1, 1.12]) jet_rumpf();
        translate([Lj * 0.13, -Wj, Hj * 0.5]) cube([Lj * 0.06, 2 * Wj, Hj]);
    }
    jet_rumpf();
}
module jet_duese() difference() {     // Düse (B)
    intersection() {
        translate([-Lj * 0.53, 0, 0]) rotate([0, 90, 0]) cylinder(r = Hj * 0.42, h = Lj * 0.1, $fn = 32);
        translate([-Lj, -Wj, 0]) cube([2 * Lj, 2 * Wj, Hj]);
    }
    jet_rumpf();
}
module jet_streifen() intersection() {   // Flügelstreifen (C)
    translate([0, 0, t_w - e]) linear_extrude(dmr * 2 + e) jet_fluegel_2d();
    for (sg = [-1, 1]) translate([-Lj, sg > 0 ? Sp * 0.30 : -Sp * 0.40, -1]) cube([2 * Lj, Sp * 0.10, 10 * Hj]);
}
module jet(fp) {
    if (inc(fp, "A")) difference() {
        union() {
            jet_rumpf();
            linear_extrude(t_w) jet_fluegel_2d();
            linear_extrude(t_w) jet_leitwerk_2d();
            jet_finne(false);
        }
        jet_cockpit();
        jet_nase();
        translate([-(w_arm / 2 + spiel), -(p_w / 2 + spiel), -e]) cube([w_arm + 2 * spiel, p_w + 2 * spiel, p_h + 0.4 + e]);
    }
    if (inc(fp, "A")) intersection() {   // Rückenlehne zwischen den Sitzen
        jet_cockpit();
        translate([-Lj * 0.02 - max(sc(60), 1.0) / 2, -Wj, z_cf - e]) cube([max(sc(60), 1.0), 2 * Wj, (Hj - z_cf) * 0.55 + e]);
    }
    if (inc(fp, "B")) { jet_scheibe(); jet_duese(); }
    if (inc(fp, "C")) {
        intersection() { jet_rumpf(); jet_nase(); }
        jet_finne(true);
        jet_streifen();
    }
}

// =====================================================================
//  PAVILLON (Krone), DACH, UFO   (z = 0 jeweils Unterkante)
// =====================================================================
module krone_zier() {   // Farbe B
    w_pl = max(sc(80), 1.2); d_c = max(sc(40), 0.6); h_c = max(sc(60), 1.0, d_c * 1.6);
    zt = t_kf + h_kr;
    for (k = [0 : 7]) rotate(22.5 + k * 45) translate([r_kc - w_pl * 0.5, -w_pl / 2, 0]) cube([w_pl, w_pl, zt - g_d - 0.3]);
    translate([0, 0, zt - g_d - 0.3 - h_c]) difference() {   // Gesims, unten 45° angefast
        hull() { linear_extrude(e) oct(r_kr); translate([0, 0, d_c * 1.05]) linear_extrude(h_c - d_c * 1.05) oct(r_kr + d_c); }
        translate([0, 0, -1]) linear_extrude(h_c + 2) oct(r_kr - e);
    }
    linear_extrude(t_kf) difference() { oct(r_kr + d_c); oct(r_kr - e); }
}
module krone(fp) {
    side = 2 * r_kr * tan(22.5);
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(t_kf) oct(r_kr);
            linear_extrude(t_kf + h_kr) difference() { oct(r_kr); oct(r_kr - t_kw); }
        }
        translate([0, 0, -1]) linear_extrude(t_kf + 2) offset(delta = spiel) square(p_k, center = true);
        for (k = [0 : 7]) rotate(k * 45) translate([r_kr - t_kw - 1, 0, t_kf + h_kr * 0.16]) rotate([90, 0, 90])
            linear_extrude(t_kw + 2) spitzbogen(side * 0.42, h_kr * 0.62);
        krone_zier();
    }
    if (inc(fp, "B")) krone_zier();
}
module dach_koerper() union() {
    linear_extrude(t_de) oct(r_d);
    hull() {
        translate([0, 0, t_de - e]) linear_extrude(e) oct(r_d - w_rim);
        translate([0, 0, t_de + h_d - e]) linear_extrude(e) oct(r_ap);
    }
}
module dach_rippen() {
    w = max(sc(60), 1.0);
    for (k = [0 : 15]) let(a = k * 22.5, f = k % 2 == 1 ? 1 / cos(22.5) : 1)
        hull() {
            translate(concat(pol((r_d - w_rim) * f, a), [t_de])) cube(w, center = true);
            translate(concat(pol(r_ap * f, a), [t_de + h_d])) cube(w, center = true);
        }
    for (k = [0 : 7], t = [-1, 0, 1]) rotate(k * 45) translate([r_d - w_rim / 2, t * (r_d - w_rim / 2) * tan(22.5) * 0.6, t_de - e])
        cylinder(d = max(sc(100), 1.0), h = dmr * 2 + e, $fn = 12);
}
module dach(fp) {
    if (inc(fp, "A")) difference() {
        dach_koerper();
        translate([0, 0, -e]) linear_extrude(g_d + e) difference() { oct(r_kr + spiel); oct(r_kr - t_kw - spiel); }
        translate([0, 0, t_de + h_d - sock_u]) cylinder(d = d_stem + 2 * spiel, h = sock_u + 1, $fn = 24);
    }
    if (inc(fp, "B")) difference() { dach_rippen(); dach_koerper(); }
}
module ufo_oben_koerper() {
    cylinder(r = r_u, h = h_ub, $fn = 64);
    translate([0, 0, h_ub - e]) cylinder(r1 = r_u, r2 = r_u * 0.48, h = h_uc + e, $fn = 64);
}
module ufo_oben(fp) {   // z = 0 Randebene, nach oben gedruckt
    if (inc(fp, "A")) difference() { ufo_oben_koerper(); translate([0, 0, -e]) cylinder(d = stift_d + 0.1, h = d_up + e, $fn = 16); }
    if (inc(fp, "B")) difference() {
        for (i = [0 : 11]) let(r = r_u * 0.72, z = h_ub + h_uc * (r_u - r) / (r_u * 0.52)) rotate(i * 30) translate([r, 0, z - 0.3])
            cylinder(d = r_u * 0.12, h = 0.3 + max(dmr * 1.5, 0.6), $fn = 12);
        ufo_oben_koerper();
    }
    if (inc(fp, "C")) intersection() {
        translate([0, 0, h_ub + h_uc - e]) sphere(r = r_u * 0.42, $fn = 48);
        translate([-r_u, -r_u, h_ub + h_uc - e]) cube([2 * r_u, 2 * r_u, r_u]);
    }
}
module ufo_unten_koerper() {
    translate([0, 0, -h_ul]) cylinder(r1 = r_u * 0.42, r2 = r_u, h = h_ul, $fn = 64);
    translate([0, 0, -h_ul - L_stem]) cylinder(d = d_stem, h = L_stem + e, $fn = 24);
}
module ufo_unten(fp) {   // z = 0 Randebene, Körper nach unten (umgedreht drucken)
    if (inc(fp, "A")) difference() { ufo_unten_koerper(); translate([0, 0, -d_up]) cylinder(d = stift_d + 0.1, h = d_up + 1, $fn = 16); }
    if (inc(fp, "B")) difference() {
        for (i = [0 : 7]) let(r = r_u * 0.7, z = -h_ul * (r_u - r) / (r_u * 0.58)) rotate(i * 45 + 22.5) translate([r, 0, z - max(dmr * 1.5, 0.6)])
            cylinder(d = r_u * 0.12, h = max(dmr * 1.5, 0.6) + 0.3, $fn = 12);
        ufo_unten_koerper();
    }
}

// =====================================================================
//  MAST, GELÄNDER
// =====================================================================
module mast(fp) {   // z = 0 Zapfenunterseite
    pitch = max(d_p * 4, 6);
    tw_ = -360 * h_pole / pitch;
    sl = max(8, ceil(h_pole / 0.4));
    module sekt(i) intersection() { circle(d = d_p, $fn = 24); polygon([[0, 0], pol(d_p, i * 120), pol(d_p, i * 120 + 60), pol(d_p, i * 120 + 120)]); }
    if (inc(fp, "A")) {
        cylinder(d = d_p, h = h_pg + e, $fn = 24);
        translate([0, 0, h_pg]) linear_extrude(h_pole, twist = tw_, slices = sl) union() { circle(d = d_p * 0.6, $fn = 24); sekt(0); }
    }
    if (inc(fp, "B")) translate([0, 0, h_pg]) linear_extrude(h_pole, twist = tw_, slices = sl) difference() { sekt(1); circle(d = d_p * 0.6, $fn = 24); }
    if (inc(fp, "C")) translate([0, 0, h_pg]) linear_extrude(h_pole, twist = tw_, slices = sl) difference() { sekt(2); circle(d = d_p * 0.6, $fn = 24); }
    if (inc(fp, "D")) translate([0, 0, h_pg + h_pole - e]) {
        cylinder(d1 = d_p, d2 = d_bulb, h = (d_bulb - d_p) / 2 + e, $fn = 24);
        translate([0, 0, (d_bulb - d_p) / 2]) { cylinder(d = d_bulb, h = d_bulb * 0.3, $fn = 24); translate([0, 0, d_bulb * 0.3]) intersection() { sphere(d = d_bulb, $fn = 24); translate([-d_bulb, -d_bulb, 0]) cube(2 * d_bulb); } }
    }
}
module gelaender_2d() {
    L = L_g; H = h_g;
    translate([-L / 2, H - w_r]) square([L, w_r]);
    translate([-L / 2, H * 0.5]) square([L, w_r * 0.8]);
    translate([-L / 2, 0]) square([L, w_r]);
    for (sg = [-1, 1]) translate([sg * (L / 2 - w_r / 2) - w_r / 2, 0]) square([w_r, H]);
    n = max(2, round(L / sc(300, 3)));
    for (i = [1 : n - 1]) translate([-L / 2 + i * L / n - w_r * 0.35, 0]) square([w_r * 0.7, H]);
    for (sg = [-1, 1]) translate([sg * L * 0.3 - tw_g / 2, -h_pg]) square([tw_g, h_pg + e]);
}
module gelaender() linear_extrude(t_g) gelaender_2d();

// =====================================================================
//  LEUCHTSCHILD-MAST (flach gedruckt) und FUSS
// =====================================================================
module lm_umriss() {
    translate([-w_lp / 2, -h_tab]) square([w_lp, h_lm + h_tab]);
    translate([0, y_b0]) polygon([[-w_lb / 2, 0], [w_lb / 2, 0], [w_lb / 2, h_lb], [0, h_lb + w_lb * 0.4], [-w_lb / 2, h_lb]]);
    translate([-w_fs / 2, y_b0 + h_lb]) square([w_fs, w_lb * 0.4 + sc(600, 6)]);
    translate([w_fs / 2 - e, y_b0 + h_lb + w_lb * 0.4 + sc(600, 6) - sc(350, 3.5)]) polygon([[0, 0], [sc(550, 5.5), sc(175, 1.75)], [0, sc(350, 3.5)]]);
}
module leuchtmast(fp) {
    bd = max(sc(90), 1.2); db = max(sc(80), 0.9);
    if (inc(fp, "A")) linear_extrude(t_lm) lm_umriss();
    if (inc(fp, "B")) translate([0, 0, t_lm - e]) {
        nb = max(4, floor(h_lb / max(sc(220), 2.5)));
        for (sg = [-1, 1], i = [0 : nb]) translate([sg * (w_lb / 2 - bd), y_b0 + bd + i * (h_lb - 2 * bd) / nb]) cylinder(d = db, h = dm * 2 + e, $fn = 12);
        for (t = [0.25, 0.5, 0.75]) translate([-w_lb / 2 * (1 - t) + 0, y_b0 + h_lb + w_lb * 0.4 * t - bd * 0.6]) cylinder(d = db, h = dm * 2 + e, $fn = 12);
        for (t = [0.25, 0.75]) translate([w_lb / 2 * (1 - t), y_b0 + h_lb + w_lb * 0.4 * t - bd * 0.6]) cylinder(d = db, h = dm * 2 + e, $fn = 12);
        linear_extrude(dm + e) difference() {   // Rahmenlinie
            translate([-w_lb / 2 + bd * 2, y_b0 + bd * 2]) square([w_lb - bd * 4, h_lb - bd * 4]);
            translate([-w_lb / 2 + bd * 2 + max(sc(30), 0.5), y_b0 + bd * 2 + max(sc(30), 0.5)]) square([w_lb - bd * 4 - 2 * max(sc(30), 0.5), h_lb - bd * 4 - 2 * max(sc(30), 0.5)]);
        }
    }
    if (inc(fp, "C")) translate([0, y_b0 + h_lb / 2, t_lm - e]) linear_extrude(dm * 2 + e)
        rotate(90) resize([h_lb * 0.78, w_lb * 0.48]) text(leuchtschild_text, size = w_lb * 0.5, font = schild_schrift, halign = "center", valign = "center");
}
module leuchtmast_fuss() difference() {
    translate([-f_w / 2, -f_w / 2, 0]) cube([f_w, f_w, h_lf]);
    translate([-w_lp / 2 - spiel, -t_lm / 2 - spiel, 0.8]) cube([w_lp + 2 * spiel, t_lm + 2 * spiel, h_lf]);
    // Fase oben
    for (a = [0 : 90 : 270]) rotate(a) translate([f_w / 2, -f_w, h_lf]) rotate([0, 45, 0]) cube([1, 2 * f_w, 1], center = true);
    if (rennbahn_taschen) translate([-f_w / 2, 0, 0]) rb_slot();
}

// =====================================================================
//  KASSENWAGEN
// =====================================================================
module ring_2d() difference() {
    offset(delta = spiel) square([W_k, D_k]);
    translate([t_wk, t_wk]) offset(delta = -spiel) square([W_k - 2 * t_wk, D_k - 2 * t_wk]);
}
module kasse_boden() {   // Welt: Beine auf dem Boden, Oberkante bei h_fl_k
    z0 = h_fl_k - t_fk; h_bm = max(sc(150), 1.6); pad = l_s * 0.35;
    difference() {
        translate([-m_k, -m_k, z0]) cube([W_k + 2 * m_k, D_k + 2 * m_k, t_fk]);
        translate([0, 0, h_fl_k - g_k]) linear_extrude(g_k + 1) ring_2d();
        // Bodenbretter
        for (x = [max(sc(300), 3) : max(sc(300), 3) : W_k - 1]) translate([x - max(sc(15), 0.3), t_wk + 0.5, h_fl_k - dmr]) cube([max(sc(30), 0.6), D_k - 2 * t_wk - 1, dmr + 1]);
    }
    for (x = [l_s / 2 + pad, W_k - l_s / 2 - pad], y = [l_s / 2 + pad, D_k - l_s / 2 - pad]) translate([x, y, 0]) {
        translate([-l_s / 2, -l_s / 2, pad]) cube([l_s, l_s, z0 - pad + e]);
        hull() { translate([-l_s / 2 - pad, -l_s / 2 - pad, 0]) cube([l_s + 2 * pad, l_s + 2 * pad, e]); translate([-l_s / 2, -l_s / 2, pad]) cube([l_s, l_s, e]); }
    }
    for (y = [D_k * 0.25 - l_s / 2, D_k * 0.75 - l_s / 2]) translate([l_s, y, z0 - h_bm]) cube([W_k - 2 * l_s, l_s, h_bm + e]);
}
module kasse_boden_druck() translate([m_k, D_k + m_k, h_fl_k]) rotate([180, 0, 0]) kasse_boden();

function wlen(k) = (k == "vorne" || k == "hinten") ? W_k : LS_k;
function openings(k) = k == "vorne" ? [[wx0, v_s, wx1, v_t]] : k == "rechts" ? [[fu0, fv0, fu0 + fw_k, fv0 + fh_k]] : [];
module raised(u0, v0, u1, v1, h = dm) translate([u0, v0, t_wk - e]) cube([u1 - u0, v1 - v0, h + e]);
module zickzack(u0, u1, v_top, h) let(n = max(3, round((u1 - u0) / (h * 1.4))), w = (u1 - u0) / n)
    polygon(concat([[u0, v_top], [u1, v_top]],
                   [for (i = [n : -1 : 1]) each [[u0 + i * w, v_top - h * 0.45], [u0 + (i - 0.5) * w, v_top - h]]],
                   [[u0, v_top - h * 0.45]]));
function dekor(k) = let(L = wlen(k), pnl = wx0 - fwid - fw2 * 1.3)
    k == "vorne"  ? [for (u = [fw2 * 1.3 + pnl / 2, W_k - fw2 * 1.3 - pnl / 2], v = [H_k * 0.32, H_k * 0.58]) [u, v, min(sc(280), pnl * 0.32), 0]] :
    k == "hinten" ? concat([[L / 2, H_k * 0.45, min(sc(600), L * 0.15), 0]],
                           [for (u = [L * 0.18, L * 0.82], v = [H_k * 0.3, H_k * 0.62]) [u, v, min(sc(220), L * 0.06), 1]]) :
    k == "links"  ? [for (u = [du0 / 2, L - du0 / 2], v = [H_k * 0.35, H_k * 0.62]) [u, v, min(sc(200), du0 * 0.3), (v > H_k * 0.5) ? 0 : 1]] :
                    [for (u = [L * 0.22, L * 0.5, L * 0.78]) [u, fv0 * 0.5, min(sc(200), L * 0.08), u == L * 0.5 ? 0 : 1]];
module wand_local(k, fp = "alle") {   // x = Länge, y = Höhe, z = Dicke (außen oben)
    L = wlen(k);
    if (inc(fp, "A")) difference() {
        union() {
            cube([L, H_k, t_wk]);
            translate([0, -(g_k - spiel), 0]) cube([L, g_k - spiel + e, t_wk]);
            translate([0, H_k - e, 0]) cube([L, g_k - spiel + e, t_wk]);
        }
        for (o = openings(k)) translate([o[0], o[1], -1]) cube([o[2] - o[0], o[3] - o[1], t_wk + 2]);
        if (k == "links") {   // Türfuge
            fg = max(sc(25), 0.4); fd = max(min(0.6, t_wk * 0.35), 0.3);
            translate([0, 0, t_wk - fd]) difference() {
                translate([du0 - fg, -1, 0]) cube([dw_k + 2 * fg, dh_k + fg + 1, fd + 1]);
                translate([du0, -2, -1]) cube([dw_k, dh_k + 2, fd + 3]);
            }
        }
    }
    if (inc(fp, "B")) {   // Rahmen, Kanten, Zahlbrett, Türgriff
        raised(0, 0, L, fw2); raised(0, H_k - fw2, L, H_k);
        if (k == "vorne" || k == "hinten") { raised(0, 0, fw2 * 1.3, H_k); raised(L - fw2 * 1.3, 0, L, H_k); }
        if (k == "vorne") {
            raised(wx0 - fwid, v_s, wx0, v_t + fwid); raised(wx1, v_s, wx1 + fwid, v_t + fwid);
            raised(wx0 - fwid, v_t, wx1 + fwid, v_t + fwid);
            translate([wx0 - fwid, v_s - max(sc(60), 1.2), t_wk - e]) cube([ww_k + 2 * fwid, max(sc(60), 1.2), c_out + e]);
        }
        if (k == "rechts") {
            raised(fu0 - fwid, fv0 - fwid, fu0, fv0 + fh_k + fwid); raised(fu0 + fw_k, fv0 - fwid, fu0 + fw_k + fwid, fv0 + fh_k + fwid);
            raised(fu0, fv0 + fh_k, fu0 + fw_k, fv0 + fh_k + fwid); raised(fu0, fv0 - fwid, fu0 + fw_k, fv0);
            raised(fu0 - fwid * 1.5, fv0 - fwid * 1.6, fu0 + fw_k + fwid * 1.5, fv0 - fwid * 0.6, dm * 3);
        }
        if (k == "links") raised(du0 + dw_k - sc(150, 1.0), sc(1050), du0 + dw_k - sc(150, 1.0) + sc(40, 0.6), sc(1050) + sc(160, 1.4), dm * 2.5);
    }
    if (inc(fp, "C")) translate([0, 0, t_wk - e]) linear_extrude(dm + e) {   // Dekor
        u0 = (k == "vorne" || k == "hinten") ? fw2 * 1.3 : 0;
        zickzack(u0, L - u0, H_k - fw2, h_val);
        for (d = dekor(k)) translate([d[0], d[1]]) if (d[3] == 0) stern(d[2]); else difference() { circle(r = d[2], $fn = 32); circle(r = d[2] * 0.55, $fn = 32); }
        if (k == "vorne") let(avail = H_k - fw2 - h_val - (v_t + fwid), ts = avail * 0.62) if (ts >= 1.5)
            translate([W_k / 2, v_t + fwid + avail * 0.5]) resize([min(ww_k, len(kasse_text) * ts * 0.75), 0]) text(kasse_text, size = ts, font = schild_schrift, halign = "center", valign = "center");
    }
}
module wand_welt(k, fp = "alle") {
    if (k == "vorne")       translate([0, t_wk, h_fl_k]) rotate([90, 0, 0]) wand_local(k, fp);
    else if (k == "hinten") translate([W_k, D_k - t_wk, h_fl_k]) rotate([90, 0, 180]) wand_local(k, fp);
    else if (k == "links")  translate([t_wk, D_k - t_wk, h_fl_k]) rotate([90, 0, -90]) wand_local(k, fp);
    else                    translate([W_k - t_wk, t_wk, h_fl_k]) rotate([90, 0, 90]) wand_local(k, fp);
}
module wand_druck(k, fp) translate([0, g_k, 0]) wand_local(k, fp);
z_rk = h_fl_k + H_k;
module kasse_dach() {   // aufrecht gedruckt
    difference() {
        union() {
            translate([-ov_k, -ov_k, z_rk]) cube([RXk, RYk, t_rk]);
            hull() {
                translate([-ov_k, -ov_k, z_rk + t_rk - e]) cube([RXk, RYk, e]);
                translate([-ov_k + 2 * ov_k, -ov_k + 2 * ov_k, z_rk + t_rk + h_rr - e]) cube([RXk - 4 * ov_k, RYk - 4 * ov_k, e]);
            }
        }
        translate([0, 0, z_rk - e]) linear_extrude(g_k + e) ring_2d();
        for (x = spx_k) translate([W_k / 2 - sw_k / 2 + x - pw_k / 2 - spiel, ys_k - st_k / 2 - spiel, z_rk + t_rk - pl_k])
            cube([pw_k + 2 * spiel, st_k + 2 * spiel, pl_k + h_rr + 1]);
    }
}
module kasse_dach_druck() translate([ov_k, ov_k, -z_rk]) kasse_dach();
module schild_local(fp) {   // x = Breite, y = Höhe (Zapfen unten), z = Dicke
    s_ts = min(sh_k * 0.55, (sw_k - 4 * s_bd) / max(1, len(kasse_schild_text) * 0.8));
    if (inc(fp, "A")) {
        cube([sw_k, sh_k, st_k]);
        for (x = spx_k) translate([x - pw_k / 2, -pl_k, 0]) cube([pw_k, pl_k + e, st_k]);
    }
    if (inc(fp, "B")) translate([0, 0, st_k - e]) {
        linear_extrude(s_te + e) difference() { square([sw_k, sh_k]); translate([s_bd, s_bd]) square([sw_k - 2 * s_bd, sh_k - 2 * s_bd]); }
        linear_extrude(s_te + e) translate([sw_k / 2, sh_k / 2]) resize([min(sw_k - 4 * s_bd, len(kasse_schild_text) * s_ts * 0.72), 0])
            text(kasse_schild_text, size = s_ts, font = schild_schrift, halign = "center", valign = "center");
        nb = max(2, floor(sw_k / max(sc(250), 3)));
        for (i = [0 : nb], y = [s_bd / 2, sh_k - s_bd / 2]) translate([s_bd / 2 + i * (sw_k - s_bd) / nb, y, 0]) cylinder(d = s_bd * 0.8, h = s_te * 2, $fn = 10);
    }
}
module schild_welt(fp) translate([W_k / 2 - sw_k / 2, ys_k + st_k / 2, z_rk + t_rk]) rotate([90, 0, 0]) schild_local(fp);
module treppe_2d() let(h = h_fl_k / 3, d = d_tr)
    polygon([[0, 0], [3 * d, 0], [3 * d, 3 * h], [2 * d, 3 * h], [2 * d, 2 * h], [d, 2 * h], [d, h], [0, h]]);
module kasse_treppe() linear_extrude(w_tr) treppe_2d();
module treppe_welt() translate([-m_k - 3 * d_tr, D_k / 2 + w_tr / 2, 0]) rotate([90, 0, 0]) kasse_treppe();
module kassenwagen(ex = 0) {
    color(fhex(farbe_kasse_boden)) kasse_boden();
    color(fhex(farbe_kasse_boden)) translate([-ex, 0, 0]) treppe_welt();
    for (k = ["vorne", "hinten", "links", "rechts"]) translate([0, 0, ex]) {
        color(fhex(farbe_kasse_wand)) render() wand_welt(k, "A"); color(fhex(farbe_kasse_rahmen)) render() wand_welt(k, "B"); color(fhex(farbe_kasse_dekor)) render() wand_welt(k, "C");
    }
    translate([0, 0, 2 * ex]) color(fhex(farbe_kasse_dach)) kasse_dach();
    translate([0, 0, 3 * ex]) { color(fhex(farbe_schild_A)) schild_welt("A"); color(fhex(farbe_schild_B)) schild_welt("B"); }
}

// =====================================================================
//  ZUSAMMENBAU
// =====================================================================
module arm_welt(k, th, ex = 0) rotate(k * aa) translate([r_piv, 0, z_piv]) rotate([0, -th, 0]) {
    color(fhex(farbe_arm)) rotate([90, 0, 0]) translate([0, 0, -w_arm / 2]) arm();
    translate([L_arm, 0, y_m]) rotate([0, th_n, 0]) translate([0, 0, ex]) rotate([0, 0, 90]) {
        color(fhex(GF[k % 4])) render() jet("A"); color(fhex(farbe_chrom)) render() jet("B"); color(fhex(farbe_jet_akzent)) render() jet("C");
    }
}
module oberbau(ex = 0) rotate(drehung) {
    color(fhex(farbe_kopf)) translate([0, 0, 1.5 * ex]) kopf_unten();
    translate([0, 0, 2 * ex]) for (k = [0 : N_a - 1]) arm_welt(k, arm_winkel, ex * 0.5);
    color(fhex(farbe_kopf)) translate([0, 0, 3 * ex]) kopf_oben();
    translate([0, 0, z_kb + 4 * ex]) { color(fhex(farbe_krone)) render() krone("A"); color(fhex(farbe_gold)) render() krone("B"); }
    translate([0, 0, z_db + 5 * ex]) { color(fhex(farbe_dach)) render() dach("A"); color(fhex(farbe_gold)) render() dach("B"); }
    translate([0, 0, z_ur + 6 * ex]) rotate(-2 * drehung) {
        color(fhex(farbe_ufo)) ufo_unten("A"); color(fhex(farbe_ufo_licht)) ufo_unten("B");
        translate([0, 0, ex * 0.6]) { color(fhex(farbe_ufo)) ufo_oben("A"); color(fhex(farbe_ufo_licht)) ufo_oben("B"); color(fhex(farbe_kuppel)) ufo_oben("C"); }
    }
}
module leuchtmast_welt(ex = 0) rotate(A_LM) translate([R_t + f_w / 2 + sc(500, 4), 0, 0]) rotate(90) {
    color(fhex(farbe_kasse_boden)) leuchtmast_fuss();
    translate([0, t_lm / 2, h_lf + ex]) rotate([90, 0, 0]) {
        color(fhex(farbe_leuchtmast)) leuchtmast("A"); color(fhex(farbe_birnen)) leuchtmast("B"); color(fhex(farbe_schrift)) leuchtmast("C");
    }
}
module babyflug(ex = 0) {
    color(fhex(farbe_podest)) render() podest_welt("A");
    color(fhex(farbe_licht)) render() podest_welt("B");
    color(fhex(farbe_rasen)) translate([0, 0, -ex]) boden_welt();
    color(fhex(farbe_saeule)) translate([0, 0, z_fl + ex]) saeule();
    oberbau(ex);
    for (j = [0 : N_d - 1]) rotate(vtx(j)) translate([r_g / tc, 0, H_w - h_pg + ex]) {
        color(fhex(farbe_mast_1)) mast("A"); color(fhex(farbe_mast_2)) mast("B"); color(fhex(farbe_mast_3)) mast("C"); color(fhex(farbe_mastlicht)) mast("D");
    }
    for (k = GK) color(fhex(farbe_gelaender)) side_frame(k, r_g) translate([0, 0, H_w + ex]) rotate([90, 0, 90]) translate([0, 0, -t_g / 2]) gelaender();
    if (leuchtmast_zeigen) leuchtmast_welt(ex);
    if (kasse_zeigen) rotate(A_KASSE) translate([R_t + sc(400, 3) + D_k + m_k + ex, -W_k / 2, 0]) rotate(90) kassenwagen(ex * 0.6);
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
CLIPS = len(RCLIPS);
cpp = floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3));
H_ges = z_ur + h_ub + h_uc + r_u * 0.42;

echo(str("Babyflug 1:", den, " | Podest Ø ", r2(2 * R_t / tc), " mm | Gesamthöhe ", r2(H_ges), " mm | Achse ", r2(z_piv - z_fl),
         " mm über Boden | Arm ", r2(L_arm), " mm | Jet ", r2(Lj), " x ", r2(Sp), " mm"));
echo(str("Podest: ", len(RP), " Stück(e) | Kunstrasen-Boden Ø ", r2(2 * R_i / tc), " mm (1 Stück)"));
echo(str("Stifte Ø ", stift_d, ": 8x Armlager (", r2(L_pin), " mm)", d_up >= 2 ? str(", 1x UFO (", r2(2 * d_up - 0.4), " mm)") : " | UFO-Hälften kleben (zu flach für einen Stift)"));
echo(str("Jet waagerecht bei ", th_n, "°, Neigung ±", r2((arm_max - arm_min) / 2), "° | Ruhestellung: Flügelspitze ",
         r2(z_piv + mz(arm_min) - Sp / 2 * sin(abs(phi_min)) - z_fl), " mm über Boden"));
// Kollisionsprüfungen
if (2 * R_i / tc > usable) echo("WARNUNG: Kunstrasen-Boden größer als das Druckbett.");
if (chord_min - Lj < 1.5) echo("WARNUNG: Jets benachbarter Arme kommen sich in Flughöhe zu nahe.");
for (th = [arm_min : 2.5 : arm_max]) let(ph = th - th_n, rt = mr(th) + Sp / 2 * cos(ph), zt = z_piv + mz(th) - Sp / 2 * abs(sin(ph)))
    if ((rt > R_i - 0.3 && zt < H_w + 0.5) || (rt > r_g - d_p && zt < H_w + h_pole + d_bulb))
        echo(str("WARNUNG: Flügel streift bei ", th, "° den Laufsteg, einen Mast oder das Geländer."));
if (z_piv > z_piv0 + 0.5) echo(str("Hinweis: Achse wegen Mindesthöhe der Säule ", r2(z_piv - z_piv0), " mm höher; Arme lassen sich bis zum Boden absenken."));

druck("podest", len(RP), "A", farbe_podest, 1); druck("podest", len(RP), "B", farbe_licht, 1);
druck("boden", 1, "alle", farbe_rasen, 1);
druck("saeule", 1, "alle", farbe_saeule, 1);
druck("kopf_unten", 1, "alle", farbe_kopf, 1);
druck("kopf_oben", 1, "alle", farbe_kopf, 1);
druck("krone", 1, "A", farbe_krone, 1); druck("krone", 1, "B", farbe_gold, 1);
druck("dach", 1, "A", farbe_dach, 1); druck("dach", 1, "B", farbe_gold, 1);
druck("ufo_unten", 1, "A", farbe_ufo, 1); druck("ufo_unten", 1, "B", farbe_ufo_licht, 1);
druck("ufo_oben", 1, "A", farbe_ufo, 1); druck("ufo_oben", 1, "B", farbe_ufo_licht, 1); druck("ufo_oben", 1, "C", farbe_kuppel, 1);
druck("arm", 1, "alle", farbe_arm, N_a);
for (i = [0 : 3]) druck("jet", 1, "A", GF[i], len([for (k = [0 : N_a - 1]) if (k % 4 == i) 1]));
druck("jet", 1, "B", farbe_chrom, N_a); druck("jet", 1, "C", farbe_jet_akzent, N_a);
for (fp = [["A", farbe_mast_1], ["B", farbe_mast_2], ["C", farbe_mast_3], ["D", farbe_mastlicht]]) druck("mast", 1, fp[0], fp[1], N_d);
druck("gelaender", 1, "alle", farbe_gelaender, len(GK));
for (fp = [["A", farbe_leuchtmast], ["B", farbe_birnen], ["C", farbe_schrift]]) druck("leuchtmast", 1, fp[0], fp[1], 1);
druck("leuchtmast_fuss", 1, "alle", farbe_kasse_boden, 1);
druck("kasse_boden", 1, "alle", farbe_kasse_boden, 1);
for (w = ["vorne", "hinten", "links", "rechts"], fp = [["A", farbe_kasse_wand], ["B", farbe_kasse_rahmen], ["C", farbe_kasse_dekor]])
    druck(str("kasse_wand_", w), 1, fp[0], fp[1], 1);
druck("kasse_dach", 1, "alle", farbe_kasse_dach, 1);
druck("kasse_schild", 1, "A", farbe_schild_A, 1); druck("kasse_schild", 1, "B", farbe_schild_B, 1);
druck("kasse_treppe", 1, "alle", farbe_kasse_boden, 1);
if (CLIPS > 0) druck("verbinder", ceil(CLIPS / cpp), "alle", farbe_clips, 1);
farben_echo();

if (teil == "aufbau") babyflug();
else if (teil == "explosion") babyflug(max(sc(1200), 10));
else if (teil == "podest") podest_druck(stueck, farbteil);
else if (teil == "boden") translate([R_i / tc, R_i / tc, 0]) boden_welt();
else if (teil == "saeule") saeule();
else if (teil == "kopf_unten") translate([0, 0, -z_sh]) kopf_unten();
else if (teil == "kopf_oben") translate([0, 0, -z_piv]) kopf_oben();
else if (teil == "krone") krone(farbteil);
else if (teil == "dach") dach(farbteil);
else if (teil == "ufo_unten") rotate([180, 0, 0]) ufo_unten(farbteil);
else if (teil == "ufo_oben") ufo_oben(farbteil);
else if (teil == "arm") arm();
else if (teil == "jet") jet(farbteil);
else if (teil == "mast") mast(farbteil);
else if (teil == "gelaender") translate([L_g / 2, h_pg, 0]) gelaender();
else if (teil == "leuchtmast") translate([w_lb / 2, h_tab, 0]) leuchtmast(farbteil);
else if (teil == "leuchtmast_fuss") leuchtmast_fuss();
else if (teil == "kasse_boden") kasse_boden_druck();
else if (teil == "kasse_wand_vorne") wand_druck("vorne", farbteil);
else if (teil == "kasse_wand_hinten") wand_druck("hinten", farbteil);
else if (teil == "kasse_wand_links") wand_druck("links", farbteil);
else if (teil == "kasse_wand_rechts") wand_druck("rechts", farbteil);
else if (teil == "kasse_dach") kasse_dach_druck();
else if (teil == "kasse_schild") translate([0, pl_k, 0]) schild_local(farbteil);
else if (teil == "kasse_treppe") kasse_treppe();
else if (teil == "verbinder") verbinder_platten(verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4), stueck);
