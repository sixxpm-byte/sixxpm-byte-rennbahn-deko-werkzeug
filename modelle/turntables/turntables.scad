// =====================================================================
//  TURNTABLES (DJ / VINYL EDITION)  –  zerlegbarer Deko-Bausatz
//  Neuaufbau im Stil der Rennbahn-Deko-Reihe: alle gängigen Maßstäbe,
//  FDM-optimiert (stützfrei), Teile über dem Druckbett werden automatisch
//  geteilt (Clips), Stecksystem kompatibel zu rennbahn_deko.scad,
//  Farben je Bauteil (Vorschau, Dateinamen, 3MF über farb_export.py)
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    deck            Mischpult-Podest (Ring um die Plattenteller-Wanne)
//    blende_aussen   Podestblende außen (16 Seiten, LED-Punkte)
//    blende_innen    Wannenwand innen (16 Seiten, LED-Band)
//    stufe           beleuchtete Treppe (Vorderseite)            je Seite
//    bodenkreuz      Bodenkreuz mit geneigtem Lagerbock + Achse
//    scheibe         Vinyl-Plattenteller (Rillen, Label, Stroboskop-Rand)
//    turm_kegel / turm_kragen / turm_kugel / turm_ring  Kugelturm
//    turmstifte      Steckstifte für den Turm
//    kopfhoerer      DJ-Kopfhörer, Halbschale                     2x
//    kreuz           Gondelkreuz (Vinyl-Single), dreht sich       4x
//    gondel          Gondel im DJ-Monitor-Design, dreht sich     16x
//    tonarm_saeule / tonarm  schwenkbarer Tonarm (Stift = Filament)
//    rueckwand_1..7  Equalizer-Rückwand (7 Paneele)
//    wandstuetze     Stahlstütze hinter der Rückwand              7x
//    markise         Markise                                      7x
//    vinylschild     großes "TURNTABLES"-Schild
//    lichtmast       Traversenmast mit Mini-Platte                4x
//    zaun            Vinyl-Zaun                                   2x
//    mischpult       Fader-Panel (ins Podest eingelegt)           3x
//    haus_*          Kasse im Flightcase-Look
//    verbinder       Clips für alle geteilten Teile
//
//  BEWEGLICH
//    * Der Plattenteller dreht sich auf der schrägen Achse des Lagerbocks
//      (Neigung einstellbar), der Kugelturm sitzt fest oben auf der Achse.
//    * Jedes Gondelkreuz dreht sich auf seinem Zapfen im Teller,
//      jede Gondel dreht sich frei auf ihrem Zapfen im Kreuz.
//    * Der Tonarm schwenkt (Stift) aus der Ruhestellung über die Platte.
//
//  MONTAGE
//    1. Bodenkreuz zusammenclipsen, Innen- und Außenblenden in die Nuten
//       der Deck-Segmente stecken, Deck auf das Bodenkreuz setzen (die
//       Kreuzarme liegen an den Innenblenden an = zentriert).
//    2. Plattenteller (geclipst) auf die Achse, Kreuze auf die Zapfen,
//       Gondeln auf die Kreuzzapfen. Turm mit Stiften stecken/kleben und
//       auf das Achsende drücken (D-Fläche = Kopfhörer schauen nach vorn).
//    3. Rückwand in die Nuten, Stützen hinten einstecken, Markisen in die
//       Schlitze, Schild auf die Zapfen. Masten, Zäune, Mischpulte, Tonarm.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 87; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, deck:Podest-Deck, blende_aussen:Blende außen, blende_innen:Wannenwand innen, stufe:Treppe, bodenkreuz:Bodenkreuz mit Lagerbock, scheibe:Plattenteller, turm_kegel:Turm Kegel, turm_kragen:Turm Kragen, turm_kugel:Turm Kugel, turm_ring:Turm Ring, turmstifte:Turm-Steckstifte, kopfhoerer:Kopfhörer-Halbschale, kreuz:Gondelkreuz, gondel:Gondel, tonarm_saeule:Tonarm-Säule, tonarm:Tonarm, rueckwand_1:Rückwand 1, rueckwand_2:Rückwand 2, rueckwand_3:Rückwand 3, rueckwand_4:Rückwand 4, rueckwand_5:Rückwand 5, rueckwand_6:Rückwand 6 (Schild), rueckwand_7:Rückwand 7, wandstuetze:Wandstütze, markise:Markise, vinylschild:Vinyl-Schild, lichtmast:Lichtmast, zaun:Zaun, mischpult:Mischpult-Panel, haus_boden:Kasse Boden, haus_wand_vorne:Kasse Wand vorne, haus_wand_hinten:Kasse Wand hinten, haus_wand_links:Kasse Wand links, haus_wand_rechts:Kasse Wand rechts, haus_dach:Kasse Dach, haus_schild:Kasse Schild, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Mehrfarbige Teile: alle oder einzelne Farbe (A = Grundkörper)
farbteil = "alle"; // [alle, A, B, C, D, E]

/* [Vorschau] */
drehung = 20;        // [0:360]
kreuz_drehung = 30;  // [0:360]
gondel_drehung = 0;  // [0:360]
// 0 = Ruhestellung neben der Platte
tonarm_winkel = 0;   // [0:60]
kassenhaus_zeigen = true;

/* [Turntables (Vorbild in Metern)] */
podest_radius_m  = 8.5;
podest_hoehe_m   = 1.1;
scheibe_radius_m = 6.9;
// Neigung des Plattentellers (Grad)
neigung = 7.5; // [0:0.5:10]
kugel_radius_m   = 0.86;
rueckwand_hoehe_m = 6.8;
schild_zeile_1 = "TURN";
schild_zeile_2 = "TABLES";
schild_schrift = "Liberation Sans:style=Bold Italic";

/* [Kasse (Vorbild in Metern)] */
// Flightcase-Look (Alu-Kanten, Kugelecken) oder Holzbude
haus_stil = "flightcase"; // [flightcase, holz]
haus_breite_m = 2.4;
haus_tiefe_m  = 1.8;
haus_hoehe_m  = 2.3;
tuer = "links"; // [links, rechts]
schild_text = "TICKETS";
kasse_text  = "KASSE";
schild_font = "Liberation Sans:style=Bold";

/* [Farben] */
farbe_deck       = "anthrazit"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_blende     = "anthrazit"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_licht      = "cyan";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_boden      = "grau";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_vinyl      = "schwarz";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_label_1    = "rot";       // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_label_2    = "gelb";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_chrom      = "silber";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_turmringe  = "blau";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kugel_1    = "gruen";     // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kugel_2    = "rot";       // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kugel_3    = "gold";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gold       = "gold";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gondel_1   = "neongruen"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gondel_2   = "cyan";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gondel_3   = "rot";       // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gondel_4   = "violett";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_eq_1       = "neongruen"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_eq_2       = "gelb";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_eq_3       = "rot";       // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_wandrahmen = "blau";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_stahl      = "grau";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_markise    = "gelb";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mastlabel  = "pink";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_zaun       = "gelb";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haus_boden = "grau";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haus_wand  = "schwarz";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haus_kanten = "silber";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haus_dach  = "schwarz";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild_A   = "schwarz";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild_B   = "cyan";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_clips      = "grau";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

/* [Druck & Passung] */
rennbahn_taschen = true;
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
stift_d = 1.75;
stift_spiel = 0.2;
verbinder_anzahl = 0;

// =====================================================================
//  Grundlagen
// =====================================================================
$fa = 3; $fs = 0.3;
e   = 0.01;
den = massstab == 0 ? eigener_massstab : massstab;
s   = 1 / den;
function sc(mm, mn = 0) = max(mm * s, mn);
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

FARBEN = [["rot", "#c62828"], ["gelb", "#f9c80e"], ["blau", "#1e5bb8"], ["gruen", "#2e9d4f"], ["weiss", "#f4f4f4"],
          ["schwarz", "#222222"], ["grau", "#8a8f94"], ["silber", "#c0c4c8"], ["gold", "#d4a017"], ["orange", "#ef7d1a"],
          ["lila", "#7b3fa0"], ["rosa", "#f27fb2"], ["tuerkis", "#1fb5b0"], ["braun", "#7a4b2a"], ["holz", "#c19a6b"], ["creme", "#f3e3c3"],
          ["anthrazit", "#3a3f45"], ["cyan", "#12b5e8"], ["pink", "#e43d8f"], ["violett", "#8e3fc2"], ["neongruen", "#2ad957"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;
GF = [farbe_gondel_1, farbe_gondel_2, farbe_gondel_3, farbe_gondel_4];
KF = [farbe_kugel_1, farbe_kugel_2, farbe_kugel_3];

// =====================================================================
//  Maße
// =====================================================================
N_d  = 16; ad = 360 / N_d; tc = cos(ad / 2);
R_di = sc(podest_radius_m * 1000, 60);           // Deck außen (Inkreis)
R_s  = sc(scheibe_radius_m * 1000, 45);          // Plattenteller
R_w  = R_s + max(sc(250), 3);                    // Wanne (Inkreis)
H_p  = sc(podest_hoehe_m * 1000, 6);
beta = neigung;
H_rw = sc(rueckwand_hoehe_m * 1000, 30);
dmr  = max(sc(20), 0.4);                         // Relief

// ---- Podest ----
deck_split = 2 * R_di / tc > usable;
t_d  = max(sc(150), 2.4, deck_split ? clipd + 0.8 : 0);
t_bl = max(sc(60), 1.4); i_bl = max(sc(30), 0.6);
g_bl = min(t_d - 0.8, max(sc(60), 1.2));
h_sk = H_p - t_d + g_bl - 0.2;
d_st = sc(500, 3);                               // Stufentiefe

// ---- Bodenkreuz, Lagerbock, Achse ----
w_ba = max(sc(600), 2 * mw + 2);
h_ba = max(sc(150), 2.4, clipd + 0.6);
clr_g = h_ba + max(sc(150), 1.5);
z_cb = clr_g + R_s * sin(beta);                  // Unterseite Tellermitte
d_j  = max(sc(400), 5);
c_j  = 0.35 * d_j;
r_lb = max(sc(1000), d_j / 2 + 4);
r_hb = r_lb + max(sc(200), 2);
L_ba = R_w + i_bl - 0.4;                         // Arme bis an die Innenblenden

// ---- Plattenteller ----
disc_split = 2 * R_s > usable;
t_s  = max(sc(200), 3, disc_split ? clipd + 1.0 : 0);
h_l  = max(sc(30), 0.6);
h_rim = max(sc(40), 0.6);
d_gr = max(sc(15), 0.4); w_gr = max(sc(30), 0.4);
z_tb = t_s + h_l + 0.4;                          // Turmunterkante (Teller-Rahmen)

// ---- Kreuze & Gondeln ----
arm_r = 0.22 * R_s; r_x = 0.6 * R_s;
r_hx = 0.36 * arm_r; w_xa = 0.3 * arm_r; r_e = 0.35 * arm_r;
cross_split = 2 * (arm_r + r_e) > usable;
t_x  = max(sc(250), 3, cross_split ? clipd + 0.6 : 0);
h_ed = max(sc(50), 0.8);
d_cj = max(sc(300), 4);
r_sh = max(d_cj / 2 + 2, r_hx * 0.8);
h_sh = h_l + max(sc(40), 0.8);
d_gj = max(sc(200), 3);
h_gj = max(sc(150), 2.5);
g_l = 0.2 * R_s; g_w = 0.15 * R_s; g_hh = 0.1 * R_s;
t_gw = max(sc(60), 1.2); t_gf = h_gj + max(sc(40), 1.0);

// ---- Turm ----
r_k  = sc(kugel_radius_m * 1000, 6);
r1c  = 0.2 * R_s; r2c = 0.12 * R_s; h_c = sc(1870, 8);
h_kr = 0.25 * h_c;
hb_k = 1.407 * r_k; h_rg = 0.42 * r_k; r_rg = 0.92 * r_k;
p_t  = max(sc(150), 2.0);
d_so = min(max(sc(200), 3), 0.45 * r_k);
l_ts = min(h_c * 0.5, max(sc(400), 5));
b_r  = max(sc(110), 1.4);
cup_r = 0.58 * r_k; cup_h = 0.38 * r_k;
x_in = r_k + 0.6; pad_t = cup_h * 0.45;
hp_r = x_in + pad_t + cup_h * 0.4;
ZB  = [for (i = [0 : 2]) h_c + h_kr + i * (hb_k + h_rg)];   // Kugel-Unterkanten
zc3 = ZB[2] + 0.707 * r_k; zt3 = ZB[2] + hb_k;
d_hb = 2 * b_r;
L_hs = (zc3 + hp_r - 1.5 * b_r + d_hb) - (zt3 - d_so) - 0.3;
H_turm = zc3 + hp_r + 1.5 * b_r;

// ---- Rückwand, Schild, Masten, Zäune, Mischpult, Tonarm ----
WK   = [for (k = [1 : 7]) k];                                  // Seiten mit Rückwand
t_rp = max(sc(200), 2.4, H_rw + 2 > usable ? clipd + 0.8 : 0);
d_br = max(sc(700), 6);
r_rw = R_di - d_br - t_rp;                       // Vorderseite Paneel (Inkreis)
g_rw = min(t_d - 0.8, max(sc(80), 1.5));
L_rw = 2 * r_rw * tan(ad / 2) - 0.6;
function rw_h(k) = H_rw * (0.86 + 0.1 * sin(k * 77));
t_br = max(sc(150), 2.0); tl_br = max(sc(500), 4);
t_aw = max(sc(80), 1.2); d_aw = sc(800, 6);
r_vs = min(H_rw * 0.5, usable / 2 - 3);
t_vs = max(sc(250), 2.4);
K_SCHILD = 6;
MK = [0, 8, 10, 14];                             // Lichtmasten
ZK = [9, 15];                                    // Zäune
FK = [11, 12];                                   // Mischpulte
TK = 13;                                         // Tonarm
mast_h = 0.62 * H_rw;
w_ms = max(sc(500), 5); t_ms = max(sc(150), 2.0);
r_ms = R_di - max(sc(350), 3.5) - t_ms / 2;
h_z  = 0.16 * H_rw; t_z = max(sc(140), 1.6); st_z = max(sc(140), 1.6);
r_z  = R_di - max(sc(200), 2.5) - t_z / 2;
L_z  = min(2 * (r_z - t_z) * tan(ad / 2) - 4, sc(2600));
r_mx = (R_w + r_ms - t_ms) / 2; D_mx = (r_ms - t_ms - R_w) * 0.7; W_mx = 2 * (r_mx - D_mx / 2) * tan(ad / 2) * 0.8;
t_mx = max(sc(80), 1.2); p_mx = min(0.8, t_d - clipd);
r_pl = max(sc(300), 3.5);
r_ta = R_w + r_pl + max(sc(150), 1.5);
h_pl = max(sc(900), 8);
L_arm = 0.38 * R_s;
t_arm = max(sc(200), 2.0);

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
//  PODEST-DECK  (Ring zwischen Wanne und Außenkante, Teilung nach Seiten)
// =====================================================================
function deck_fits(m) = let(a0 = vtx(-1), a1 = vtx(m - 1),
    P = concat([for (j = [-1 : m - 1]) pol(R_di / tc, vtx(j))], [for (j = [-1 : m - 1]) pol(R_w / tc, vtx(j))],
               [for (j = [0 : m - 1]) pol(R_di, sidec(j))]))
    fit_pts(P, a0, a1) != undef;
M_DECK = !deck_split ? N_d : len([for (m = [8, 4, 2, 1]) if (deck_fits(m)) m]) > 0 ? [for (m = [8, 4, 2, 1]) if (deck_fits(m)) m][0] : 1;
q_deck = (M_DECK == 1 && !deck_fits(1)) ? 3 : 1;   // Seite zusätzlich dritteln (nur sehr große Maßstäbe)
dq     = atan(tan(ad / 2) / 3);
SEAMS_D = q_deck == 1 ? [for (j = [0 : M_DECK : N_d - 1]) vtx(j - 1)]
                      : [for (k = [0 : N_d - 1], a = [vtx(k - 1), sidec(k) - dq, sidec(k) + dq]) a];
DP = deck_split ? [for (i = [0 : len(SEAMS_D) - 1]) [SEAMS_D[i], i == len(SEAMS_D) - 1 ? SEAMS_D[0] + 360 : SEAMS_D[i + 1]]] : [[0, 360]];
// Clips entlang der Nähte (zwischen den Nuten)
function dclip_r(a) = let(c = cos(adiff(a, round(a / ad) * ad)),
    r0 = (R_w + i_bl + t_bl + spiel + 0.5) / c + mw, r1 = min((R_di - i_bl - t_bl - spiel - 0.5) / c, (r_rw - 1) / c) - mw,
    n = r1 < r0 ? 0 : max(1, min(3, floor((r1 - r0) / 30) + 1)))
    n == 0 ? [] : n == 1 ? [(r0 + r1) / 2] : [for (i = [0 : n - 1]) r0 + i * (r1 - r0) / (n - 1)];
DCLIPS = deck_split ? [for (a = SEAMS_D, r = dclip_r(a)) concat(pol(r, a), [a + 90])] : [];

module deck_welt() {   // Welt-Koordinaten
    translate([0, 0, H_p - t_d]) difference() {
        linear_extrude(t_d) difference() { poly(R_di); poly(R_w); }
        // Nuten für Blenden außen / innen
        translate([0, 0, -e]) linear_extrude(g_bl + e) difference() { poly(R_di - i_bl + spiel); poly(R_di - i_bl - t_bl - spiel); }
        translate([0, 0, -e]) linear_extrude(g_bl + e) difference() { poly(R_w + i_bl + t_bl + spiel); poly(R_w + i_bl - spiel); }
        // Rückwand-Nuten und Stützenschlitze
        for (k = WK) side_frame(k, r_rw) {
            translate([-spiel, -L_rw / 2 - spiel, t_d - g_rw]) cube([t_rp + 2 * spiel, L_rw + 2 * spiel, g_rw + 1]);
            translate([t_rp + d_br * 0.55 - tl_br / 2 - spiel, -t_br / 2 - spiel, -1]) cube([tl_br + 2 * spiel, t_br + 2 * spiel, t_d + 2]);
        }
        // Masten, Zäune, Mischpulte, Tonarm
        for (k = MK) side_frame(k, r_ms) translate([-t_ms / 2 - spiel, -w_ms * 0.4 - spiel, -1]) cube([t_ms + 2 * spiel, w_ms * 0.8 + 2 * spiel, t_d + 2]);
        for (k = ZK, sg = [-1, 1]) side_frame(k, r_z) translate([-t_z / 2 - spiel, sg * (L_z / 2 - st_z / 2) - st_z * 0.4 - spiel, -1]) cube([t_z + 2 * spiel, st_z * 0.8 + 2 * spiel, t_d + 2]);
        for (k = FK) side_frame(k, r_mx) translate([-D_mx / 2 - spiel, -W_mx / 2 - spiel, t_d - p_mx]) cube([D_mx + 2 * spiel, W_mx + 2 * spiel, p_mx + 1]);
        side_frame(TK, r_ta) translate([0, 0, 0.8]) cylinder(r = r_pl + spiel, h = t_d, $fn = 32);
        // Kanal-Linien (Mischpult-Optik)
        for (k = [0 : N_d - 1]) rotate(vtx(k)) translate([R_w / tc + 1, -max(sc(15), 0.2), t_d - dmr]) cube([(R_di - R_w) / tc - 2, 2 * max(sc(15), 0.2), dmr + 1]);
        translate([0, 0, t_d - dmr]) linear_extrude(dmr + 1) difference() { poly(R_w + max(sc(150), 1.5) + 0.4); poly(R_w + max(sc(150), 1.5)); }
        for (c = DCLIPS) translate([c[0], c[1], 0]) clip_cut(c[2], false, 0);
    }
}
function dp_pts(i) = let(a0 = DP[i][0], a1 = DP[i][1]) concat(spts(R_w, R_di / tc, a0, a1));
DRHO = [for (i = [0 : len(DP) - 1]) let(r = fit_pts(dp_pts(i), DP[i][0], DP[i][1])) r == undef ? 90 - (DP[i][0] + DP[i][1]) / 2 : r];
module deck_stueck(i) intersection() { deck_welt(); translate([0, 0, -1]) linear_extrude(H_p + 2) wedge_mask(DP[i][0], DP[i][1], R_di); }
module deck_druck(stk) {
    if (!deck_split) translate([R_di / tc, R_di / tc, -(H_p - t_d)]) deck_welt();
    else for (i = [0 : len(DP) - 1]) if (stk == 0 || stk == i + 1) let(b = bb([for (p = dp_pts(i)) rotp(p, DRHO[i])]))
        translate([(stk == 0 ? (i % 4) * (usable + 10) : 0) - b[0], (stk == 0 ? floor(i / 4) * (usable + 10) : 0) - b[1], -(H_p - t_d)])
        rotate([0, 0, DRHO[i]]) deck_stueck(i);
}

// =====================================================================
//  BLENDEN (außen / innen) und TREPPE
// =====================================================================
L_bo = 2 * (R_di - i_bl) * tan(ad / 2) - 2 * t_bl * tan(ad / 2) - 0.4;
L_bi = 2 * (R_w + i_bl) * tan(ad / 2) - 0.4;
n_bo = max(1, ceil(L_bo / usable)); n_bi = max(1, ceil(L_bi / usable));
module blende_lokal(L, innen, fp) {   // x = Länge, y = Höhe, z = Dicke (Schauseite oben)
    led = max(sc(120), 1.2); hf = H_p - t_d;
    if (inc(fp, "A")) {
        cube([L, h_sk, t_bl]);
        translate([0, 0, t_bl - e]) difference() {   // Rahmen
            translate([max(sc(60), 0.8), max(sc(60), 0.8)]) cube([L - 2 * max(sc(60), 0.8), hf - 2 * max(sc(60), 0.8), dmr + e]);
            translate([2 * max(sc(60), 0.8), 2 * max(sc(60), 0.8), -1]) cube([L - 4 * max(sc(60), 0.8), hf - 4 * max(sc(60), 0.8), dmr + 3]);
        }
    }
    if (inc(fp, "B")) translate([0, 0, t_bl - e]) {
        if (innen) translate([L * 0.04, hf * 0.55, 0]) cube([L * 0.92, max(sc(100), 1.0), dmr * 2 + e]);   // LED-Band
        else for (x = [L * 0.1 : max(sc(600), 5) : L * 0.9]) translate([x, hf * 0.5, 0]) cylinder(d = led, h = dmr * 2 + e, $fn = 10);
    }
}
module blenden_welt(fp = "alle") {
    for (k = [0 : N_d - 1], j = [0 : n_bo - 1]) rotate(sidec(k))
        translate([R_di - i_bl, -L_bo / 2 + j * L_bo / n_bo, 0]) rotate([90, 0, 90]) translate([0, 0, -t_bl]) blende_lokal(L_bo / n_bo - (n_bo > 1 ? 0.2 : 0), false, fp);
    for (k = [0 : N_d - 1], j = [0 : n_bi - 1]) rotate(sidec(k))
        translate([R_w + i_bl, L_bi / 2 - j * L_bi / n_bi, 0]) rotate([90, 0, -90]) translate([0, 0, -t_bl]) blende_lokal(L_bi / n_bi - (n_bi > 1 ? 0.2 : 0), true, fp);
}
STK = [for (k = [9 : 15]) k];
module stufe_lokal(fp) {   // Welt-Ausrichtung für Seite 0 (x = radial)
    r0 = R_di - i_bl + dmr * 2 + 0.3; bb_ = max(sc(30), 0.6);
    TOPS = [for (i = [1 : 3]) H_p * (4 - i) / 4];
    module koerper() intersection() {
        union() for (i = [1 : 3]) linear_extrude(TOPS[i - 1]) difference() { poly(r0 + i * d_st); poly(r0); }
        translate([0, 0, -1]) linear_extrude(H_p + 2) wedge_mask(-ad / 2, ad / 2, R_di + 4 * d_st);
    }
    module licht() intersection() {
        union() for (i = [1 : 3]) translate([0, 0, TOPS[i - 1] * 0.55]) linear_extrude(TOPS[i - 1] * 0.35) difference() { poly(r0 + i * d_st + e); poly(r0 + i * d_st - bb_); }
        translate([0, 0, -1]) linear_extrude(H_p + 2) wedge_mask(-ad / 2, ad / 2, R_di + 4 * d_st);
    }
    if (inc(fp, "A")) difference() { koerper(); licht(); }
    if (inc(fp, "B")) licht();
}
module stufe_druck(fp) translate([-(R_di - i_bl + dmr * 2), (R_di + 3 * d_st) * tan(ad / 2), 0]) stufe_lokal(fp);

// =====================================================================
//  BODENKREUZ mit geneigtem LAGERBOCK und ACHSE
// =====================================================================
module achse_rahmen() translate([0, 0, z_cb]) rotate([beta, 0, 0]) children();   // Teller-Rahmen
module achse_d(h, o = 0) linear_extrude(h) intersection() { circle(d = d_j + 2 * o, $fn = 32); translate([-d_j, -c_j - o]) square([2 * d_j, 2 * d_j]); }
module bodenkreuz_welt() {
    difference() {
        union() {
            linear_extrude(h_ba) {
                circle(r = r_hb, $fn = 48);
                for (a = [0 : 90 : 270]) rotate(a) translate([0, -w_ba / 2]) square([L_ba, w_ba]);
            }
            // Lagerbock bis zur schrägen Tellerebene
            intersection() {
                cylinder(r = r_lb, h = z_cb + r_lb, $fn = 48);
                achse_rahmen() translate([-50 * r_lb, -50 * r_lb, -100 * r_lb]) cube([100 * r_lb, 100 * r_lb, 100 * r_lb]);
            }
            achse_rahmen() translate([0, 0, -1]) achse_d(z_tb + l_ts - 0.3 + 1);
        }
        // Rillen auf den Armen
        for (a = [0 : 90 : 270]) rotate(a) for (x = [r_hb + 3 : max(sc(400), 4) : L_ba - 2]) translate([x, -w_ba, h_ba - dmr]) cube([max(sc(30), 0.4), 2 * w_ba, dmr + 1]);
    }
}
bk_a  = r_hb + spw / 2 + 1;
bk_n  = max(1, ceil((L_ba - bk_a) / (usable - 10)));
function arm_seams(c) = concat([for (j = [bk_n - 1 : -1 : 1]) c - bk_a - j * (L_ba - bk_a) / bk_n], [c - bk_a, c + bk_a],
                               [for (j = [1 : 1 : bk_n - 1]) c + bk_a + j * (L_ba - bk_a) / bk_n]);
function info_bodenkreuz() = let(c = L_ba, SX = 2 * L_ba, xs = 2 * L_ba > usable ? arm_seams(c) : [],
    S = [[0, c - w_ba / 2, SX, c + w_ba / 2], [c - w_ba / 2, 0, c + w_ba / 2, SX], [c - r_hb * 0.7, c - r_hb * 0.7, c + r_hb * 0.7, c + r_hb * 0.7]])
    [SX, SX, xs, xs, [], false, 0, S, S];
module bodenkreuz_druck() translate([L_ba, L_ba, 0]) bodenkreuz_welt();

// =====================================================================
//  PLATTENTELLER  (Teller-Rahmen: z = 0 Unterseite, Neigung über achse_rahmen)
// =====================================================================
XA = [for (k = [0 : 3]) 45 + k * 90];            // Kreuz-Winkel
function d_forbid(a, r0, r1) = (r0 < r_x + r_sh + 1 && r1 > r_x - r_sh - 1) && min([for (t = XA) adiff(a, t)]) < deg((r_sh + spw / 2 + 1) / r_x);
function d_nudge(t, r0, r1, k = 0) = k > 1000 ? t : let(v = t + (k % 2 == 0 ? 1 : -1) * floor((k + 1) / 2) * 0.25) !d_forbid(v, r0, r1) ? v : d_nudge(t, r0, r1, k + 1);
R_cd = min(usable / 2 - spw / 2 - 1, r_x - r_sh - spw / 2 - 2);
n_db = disc_split ? max(1, ceil((R_s - R_cd) / (usable * 0.8))) : 0;
function db_edge(i) = let(t = R_cd + i * (R_s - R_cd) / n_db) (abs(t - r_x) < r_sh + spw / 2 + 2) ? r_x + r_sh + spw / 2 + 2 : t;
DB = [for (i = [0 : 1 : n_db - 1]) [db_edge(i), i == n_db - 1 ? R_s + 0.5 : db_edge(i + 1)]];
function d_seams(b, n) = let(base = (n % 8 == 4) ? 0 : 180 / n) qsort([for (j = [0 : n - 1]) d_nudge(base + j * 360 / n, b[0], b[1])]);
function d_pieces(b, ss) = let(n = len(ss)) [for (j = [0 : n - 1]) [b[0], b[1], ss[j], j == n - 1 ? ss[0] + 360 : ss[j + 1]]];
function d_ok(b, ss) = len([for (p = d_pieces(b, ss)) if (fit_pts(spts(p[0], p[1], p[2], p[3]), p[2], p[3]) == undef) 1]) == 0;
function d_n(b, L, i = 0) = i >= len(L) ? L[len(L) - 1] : d_ok(b, d_seams(b, L[i])) ? L[i] : d_n(b, L, i + 1);
DNP = [for (b = DB) 2 * b[1] <= usable ? 1 : d_n(b, [4, 8, 12, 16, 24, 32, 48])];
DSE = [for (i = [0 : 1 : len(DB) - 1]) DNP[i] > 1 ? d_seams(DB[i], DNP[i]) : []];
FPD = disc_split ? concat([[0, R_cd, 0, 360, -1]],
        [for (i = [0 : 1 : len(DB) - 1]) each (DNP[i] == 1 ? [[DB[i][0], DB[i][1], 0, 360, i]] : [for (p = d_pieces(DB[i], DSE[i])) concat(p, [i])])])
      : [[0, R_s + 1, 0, 360, 0]];
DCL = disc_split ? concat(
    [for (b = DB) let(n = max(4, round(2 * PI * b[0] / 40))) for (j = [0 : n - 1]) let(a = (j + 0.5) * 360 / n)
        if (!d_forbid(a, b[0] - mw, b[0] + mw) && min(concat([999], [for (S = DSE, x = S) adiff(a, x)])) * PI / 180 * b[0] > spw) concat(pol(b[0], a), [a])],
    [for (i = [0 : 1 : len(DB) - 1], a = DSE[i]) let(r0 = DB[i][0] + mi, r1 = min(DB[i][1], R_s * 0.9) - mw, n = max(1, floor((r1 - r0) / 35) + 1))
        for (j = [0 : n - 1]) concat(pol(n == 1 ? (r0 + r1) / 2 : r0 + j * (r1 - r0) / (n - 1), a), [a + 90])]) : [];
function in_piece(p, P, m) = let(r = norm(p), a = atan2(p[1], p[0]), da = deg(m / max(r, 1)),
                                  x = ((a - P[2] + da) % 360 + 360) % 360)
    r >= P[0] - m && r <= P[1] + m && (P[3] - P[2] >= 359.9 || x <= P[3] - P[2] + 2 * da);
module disc_mask(p) {
    is_top = !disc_split || p[4] == len(DB) - 1;
    difference() {
        intersection() {
            circle(r = is_top ? p[1] + 3 : p[1] - gap, $fa = 1);
            if (p[3] - p[2] < 359.9) polygon(concat([[0, 0]], [for (i = [0 : 36]) pol(2 * p[1] + 10, p[2] + i * (p[3] - p[2]) / 36)]));
        }
        if (p[0] > 0) circle(r = p[0] + gap, $fa = 1);
        if (p[3] - p[2] < 359.9) for (a = [p[2], p[3]]) rotate(a) translate([0, -gap]) square([2 * p[1] + 20, 2 * gap]);
    }
}
module scheibe(fp, P) {   // P = Stück; Teller-Rahmen
    hd = max(sc(30), 0.4);
    module m2() disc_mask(P);
    if (inc(fp, "A")) {
        difference() {
            union() {
                linear_extrude(t_s) intersection() { circle(r = R_s, $fa = 1); m2(); }
                translate([0, 0, t_s - e]) linear_extrude(h_rim * 0.6 + e) intersection() { difference() { circle(r = 0.965 * R_s, $fa = 1); circle(r = 0.915 * R_s, $fa = 1); } m2(); }
                for (a = XA) if (in_piece(pol(r_x, a), P, -r_sh)) translate(concat(pol(r_x, a), [t_s - e])) {
                    cylinder(r = r_sh, h = h_sh + e, $fn = 32);
                    cylinder(d = d_cj, h = h_sh + t_x - 0.3, $fn = 24);
                    translate([0, 0, h_sh + t_x - 0.3 - e]) cylinder(d1 = d_cj, d2 = d_cj - 0.8, h = 0.4, $fn = 24);
                }
            }
            // Tonrillen
            for (r = [0.40 * R_s : 0.065 * R_s : 0.88 * R_s]) translate([0, 0, t_s - d_gr]) linear_extrude(d_gr + 1) difference() { circle(r = r + w_gr / 2, $fa = 1); circle(r = r - w_gr / 2, $fa = 1); }
            translate([0, 0, -1]) cylinder(d = d_j + 2 * cl, h = t_s + 5, $fn = 32);
            for (c = DCL) if (in_piece([c[0], c[1]], P, cL)) translate([c[0], c[1], 0]) clip_cut(c[2], false, 0);
        }
    }
    if (inc(fp, "B")) translate([0, 0, t_s - e]) linear_extrude(h_l + e) intersection() { difference() { circle(r = 0.36 * R_s); circle(r = 0.28 * R_s); } m2(); }
    if (inc(fp, "C")) translate([0, 0, t_s - e]) difference() {
        linear_extrude(h_l + e) intersection() { difference() { circle(r = 0.28 * R_s); circle(d = d_j + 2 * cl, $fn = 32); } m2(); }
        // "33 1/3" eingraviert
        translate([0, -0.15 * R_s, h_l - hd + e]) linear_extrude(hd + 1) text("33 1/3", size = 0.05 * R_s, font = schild_font, halign = "center", valign = "center");
    }
    if (inc(fp, "D")) {
        translate([0, 0, t_s - e]) linear_extrude(h_rim + e) intersection() { difference() { circle(r = R_s, $fa = 1); circle(r = 0.965 * R_s, $fa = 1); } m2(); }
        for (a = [0 : 7.5 : 352.5]) if (in_piece(pol(0.94 * R_s, a), P, -0.6)) translate(concat(pol(0.94 * R_s, a), [t_s + h_rim * 0.6 - e])) cylinder(d = max(sc(140), 1.0), h = hd + e, $fn = 10);
    }
}
function dp_bb(i) = let(p = FPD[i]) (p[3] - p[2] >= 359.9) ? [-p[1], -p[1], p[1], p[1]] : bb([for (q = spts(p[0], p[1], p[2], p[3])) rotp(q, DR[i])]);
DR = [for (p = FPD) let(r = (p[3] - p[2] >= 359.9) ? 0 : fit_pts(spts(p[0], p[1], p[2], p[3]), p[2], p[3])) r == undef ? 90 - (p[2] + p[3]) / 2 : r];
module scheibe_druck(stk, fp) {
    for (i = [0 : len(FPD) - 1]) if (stk == 0 || stk == i + 1) let(b = dp_bb(i))
        translate([(stk == 0 ? (i % 4) * (usable + 10) : 0) - b[0], (stk == 0 ? floor(i / 4) * (usable + 10) : 0) - b[1], 0]) rotate([0, 0, DR[i]]) scheibe(fp, FPD[i]);
}

// =====================================================================
//  KUGELTURM (Einzelteile, gesteckt) und KOPFHÖRER
// =====================================================================
module sq_sock(z, d) translate([-p_t / 2 - spiel, -p_t / 2 - spiel, z]) cube([p_t + 2 * spiel, p_t + 2 * spiel, d]);
module turm_kegel() difference() {
    cylinder(r1 = r1c, r2 = r2c, h = h_c, $fn = 48);
    translate([0, 0, -e]) achse_d(l_ts + e, spiel);
    sq_sock(h_c - d_so, d_so + 1);
    // Zierrillen (Spindel-Optik)
    for (z = [h_c * 0.2 : h_c * 0.2 : h_c * 0.81]) translate([0, 0, z]) difference() {
        cylinder(r = r1c + 1, h = max(sc(30), 0.4), $fn = 48); translate([0, 0, -1]) cylinder(r = r1c - (r1c - r2c) * z / h_c - max(sc(20), 0.3), h = 2, $fn = 48);
    }
}
module turm_kragen() difference() {
    cylinder(r1 = r2c * 1.05, r2 = r2c * 0.85, h = h_kr, $fn = 32);
    sq_sock(-1, h_kr + 2);
}
module turm_kugel() difference() {
    intersection() { translate([0, 0, 0.707 * r_k]) sphere(r = r_k, $fn = 16); translate([-r_k, -r_k, 0]) cube([2 * r_k, 2 * r_k, hb_k]); }
    sq_sock(-1, d_so + 1); sq_sock(hb_k - d_so, d_so + 1);
}
module turm_ring() difference() {
    rb = 0.714 * r_k;
    hull() { cylinder(r = rb, h = e, $fn = 32); translate([0, 0, r_rg - rb]) cylinder(r = r_rg, h = h_rg - (r_rg - rb), $fn = 32); }
    sq_sock(-1, h_rg + 2);
    for (i = [0 : 11]) rotate(i * 30) translate([r_rg - dmr, -max(sc(40), 0.4), h_rg * 0.55]) cube([dmr + 1, 2 * max(sc(40), 0.4), h_rg * 0.3]);   // EQ-Kerben
}
PINS = [d_so * 2 + h_kr - 0.6, d_so * 2 + h_rg - 0.6, d_so * 2 + h_rg - 0.6, L_hs];
module turmstifte() for (i = [0 : len(PINS) - 1]) translate([0, i * (p_t + 3), 0]) cube([PINS[i], p_t, p_t]);
module kopfhoerer_voll(fp) {   // Ursprung = Mitte der oberen Kugel
    module buegel() rotate([90, 0, 0]) rotate_extrude(angle = 180, $fn = 48) translate([hp_r, 0]) scale([1, 1.5]) circle(r = b_r, $fn = 16);
    module polster() rotate([0, -60, 0]) rotate([90, 0, 0]) rotate_extrude(angle = 60, $fn = 24) translate([hp_r, 0]) scale([1.25, 1.75]) circle(r = b_r, $fn = 16);
    module schalen() for (sg = [-1, 1]) translate([sg * (x_in + pad_t), 0, 0]) rotate([0, sg * 90, 0]) cylinder(r1 = cup_r, r2 = cup_r * 0.72, h = cup_h * 0.75 - 0.6, $fn = 32);
    module zier() for (sg = [-1, 1]) translate([sg * (x_in + pad_t + cup_h * 0.75 - 0.6 - e), 0, 0]) rotate([0, sg * 90, 0]) cylinder(r = cup_r * 0.45, h = 0.6, $fn = 24);
    module gelenke() for (sg = [-1, 1]) translate([sg * (hp_r - b_r * 0.2), 0, cup_r * 0.85]) rotate([90, 0, 0]) cylinder(r = b_r * 1.3, h = 2 * b_r * 1.3, center = true, $fn = 16);
    module stiel() translate([-p_t / 2 - spiel, -p_t / 2 - spiel, hp_r - 1.5 * b_r - 1]) cube([p_t + 2 * spiel, p_t + 2 * spiel, d_hb + 1]);
    if (inc(fp, "A")) {
        difference() { buegel(); schalen(); polster(); gelenke(); stiel(); for (sg = [-1, 1]) translate([sg * x_in, 0, 0]) rotate([0, sg * 90, 0]) cylinder(r = cup_r, h = pad_t, $fn = 32); }
        for (sg = [-1, 1]) translate([sg * x_in, 0, 0]) rotate([0, sg * 90, 0]) cylinder(r = cup_r, h = pad_t, $fn = 32);
    }
    if (inc(fp, "B")) difference() { schalen(); zier(); gelenke(); }
    if (inc(fp, "C")) { zier(); difference() { polster(); stiel(); } }
    if (inc(fp, "D")) gelenke();
}
module kopfhoerer_halb(fp) difference() {
    intersection() { kopfhoerer_voll(fp); translate([-5 * hp_r, 0, -5 * hp_r]) cube([10 * hp_r, 5 * hp_r, 10 * hp_r]); }
    for (sg = [-1, 1]) translate([sg * (x_in + pad_t * 0.5), -1, -cup_r * 0.5]) rotate([-90, 0, 0]) cylinder(d = stift_d + 0.2, h = 3 + 1, $fn = 12);
}
module kopfhoerer_druck(fp) translate([x_in + pad_t + cup_h * 0.75 + 1, hp_r + 2 * b_r + 1, 0]) rotate([90, 0, 0]) kopfhoerer_halb(fp);
module turm_welt(ex = 0) {   // Teller-Rahmen
    translate([0, 0, z_tb]) {
        color(fhex(farbe_chrom)) turm_kegel();
        color(fhex(farbe_turmringe)) translate([0, 0, h_c + ex]) turm_kragen();
        for (i = [0 : 2]) color(fhex(KF[i])) translate([0, 0, ZB[i] + ex * (2 + 2 * i)]) turm_kugel();
        for (i = [0 : 1]) color(fhex(farbe_turmringe)) translate([0, 0, ZB[i] + hb_k + ex * (3 + 2 * i)]) turm_ring();
        translate([0, 0, zc3 + 7 * ex]) {
            color(fhex(farbe_vinyl)) kopfhoerer_voll("A"); color(fhex(farbe_label_1)) kopfhoerer_voll("B");
            color(fhex(farbe_gold)) kopfhoerer_voll("C"); color(fhex(farbe_chrom)) kopfhoerer_voll("D");
        }
    }
}

// =====================================================================
//  GONDELKREUZ und GONDEL
// =====================================================================
module kreuz(fp) {
    if (inc(fp, "A")) difference() {
        union() {
            cylinder(r = r_hx, h = t_x * 1.4, $fn = 32);
            for (a = [0 : 90 : 270]) rotate(a) {
                hull() { cylinder(r = 0.18 * arm_r, h = t_x, $fn = 24); translate([arm_r, 0, 0]) cylinder(r = 0.15 * arm_r, h = t_x, $fn = 24); }
                translate([arm_r, 0, 0]) {
                    cylinder(r = r_e, h = t_x + h_ed, $fn = 32);
                    cylinder(d = d_gj, h = t_x + h_ed + h_gj - 0.3, $fn = 20);
                    translate([0, 0, t_x + h_ed + h_gj - 0.3 - e]) cylinder(d1 = d_gj, d2 = d_gj - 0.8, h = 0.4, $fn = 20);
                }
            }
        }
        translate([0, 0, -1]) cylinder(d = d_cj + 2 * cl, h = t_x * 2, $fn = 32);
        for (a = [0 : 90 : 270]) rotate(a) translate([arm_r, 0, t_x + h_ed - dmr]) for (r = [r_e * 0.45 : r_e * 0.18 : r_e * 0.95])
            linear_extrude(dmr + 1) difference() { circle(r = r + w_gr / 2, $fn = 32); circle(r = r - w_gr / 2, $fn = 32); }
    }
    if (inc(fp, "B")) translate([0, 0, t_x * 1.4 - e]) difference() { cylinder(r = 0.24 * arm_r, h = max(sc(40), 0.6) + e, $fn = 32); translate([0, 0, -1]) cylinder(d = d_cj + 2 * cl, h = 5, $fn = 32); }
}
function info_kreuz() = let(c = arm_r + r_e, SX = 2 * c, a = r_hx + spw / 2 + 1,
    S = [[0, c - 0.15 * arm_r, SX, c + 0.15 * arm_r], [c - 0.15 * arm_r, 0, c + 0.15 * arm_r, SX], [c - r_hx * 0.7, c - r_hx * 0.7, c + r_hx * 0.7, c + r_hx * 0.7]])
    [SX, SX, cross_split ? [c - a, c + a] : [], cross_split ? [c - a, c + a] : [], [], false, 0, S, S];
module kreuz_druck(fp) translate([arm_r + r_e, arm_r + r_e, 0]) kreuz(fp);
module g_fuss(o = 0) offset(r = 0.3 * g_w - o) square([g_l - 0.6 * g_w, g_w - 0.6 * g_w], center = true);
module gondel(fp) {
    h_tub = 0.72 * g_hh; xs = -g_l / 2 + 0.26 * g_l; xb = -g_l / 2 + 0.55 * g_l;
    module lautsprecher() for (sg = [-1, 1]) translate([g_l / 2 * 1.02 - 0.5, sg * g_w * 0.2, h_tub * 0.48]) rotate([0, 90, 0]) {
        difference() { cylinder(r = g_w * 0.15, h = 1.0, $fn = 24); translate([0, 0, 0.6]) cylinder(r = g_w * 0.11, h = 1, $fn = 24); }
        cylinder(r = g_w * 0.04, h = 1.0, $fn = 12);
    }
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(h_tub, scale = 1.04) g_fuss();
            intersection() { linear_extrude(g_hh, scale = 1.06) g_fuss(); translate([-g_l, -g_w, 0]) cube([g_l / 2 + 0.26 * g_l, 2 * g_w, g_hh]); }   // Lehne
        }
        // Fußraum und Sitz
        intersection() { translate([0, 0, t_gf]) linear_extrude(g_hh) g_fuss(t_gw); translate([xs + t_gw, -g_w, t_gf + 0.35 * h_tub]) cube([g_l, 2 * g_w, g_hh]); }
        intersection() { translate([0, 0, t_gf]) linear_extrude(g_hh) g_fuss(t_gw); translate([xb, -g_w, t_gf]) cube([g_l, 2 * g_w, g_hh]); }
        translate([0, 0, -e]) cylinder(d = d_gj + 2 * cl, h = h_gj + 0.3, $fn = 24);
        lautsprecher();
    }
    if (inc(fp, "B")) lautsprecher();
}
// =====================================================================
//  TONARM
// =====================================================================
module tonarm_saeule() {   // steht in der Podest-Tasche
    difference() {
        union() {
            cylinder(r = r_pl, h = h_pl + t_d - 0.8, $fn = 32);
            translate([0, 0, t_d - 0.8 + h_pl * 0.55]) hull() { cylinder(r = r_pl, h = e, $fn = 32); translate([0, 0, r_pl * 0.4]) cylinder(r = r_pl * 1.4, h = h_pl * 0.12, $fn = 32); }
        }
        translate([0, 0, t_d - 0.8 + h_pl - 6]) cylinder(d = stift_d + 0.1, h = 10, $fn = 12);
    }
}
module tonarm_2d(teilb) {
    r_cw = max(sc(450), 3.5); w_t = max(sc(220), 1.8);
    if (!teilb) difference() {
        union() {
            circle(r = max(sc(350), 3), $fn = 24);
            translate([-r_cw * 2.2, -w_t / 2]) square([L_arm + r_cw * 2.2, w_t]);
            translate([-r_cw * 2.2, 0]) circle(r = r_cw, $fn = 32);
        }
        circle(d = stift_d + 2 * stift_spiel, $fn = 12);
    }
    else translate([L_arm, 0]) rotate(22) translate([-0.02 * R_s, -0.045 * R_s / 2]) square([0.09 * R_s, 0.045 * R_s]);
}
module tonarm(fp) {
    if (inc(fp, "A")) difference() { linear_extrude(t_arm) tonarm_2d(false); linear_extrude(t_arm * 3, center = true) tonarm_2d(true); }
    if (inc(fp, "B")) linear_extrude(t_arm) tonarm_2d(true);
}
module tonarm_welt() side_frame(TK, r_ta) {
    translate([0, 0, H_p - t_d + 0.8]) tonarm_saeule();
    translate([0, 0, H_p + h_pl + 0.2]) rotate([0, 0, -90 - tonarm_winkel]) { color(fhex(farbe_chrom)) tonarm("A"); color(fhex(farbe_label_1)) tonarm("B"); }
}

// =====================================================================
//  RÜCKWAND, STÜTZE, MARKISE, VINYL-SCHILD
// =====================================================================
v_peg = min(rw_h(K_SCHILD) - 3 * max(sc(150), 2), H_rw - r_vs * 0.62);
function vs_peg(k) = [[-r_vs * 0.35, v_peg], [r_vs * 0.35, v_peg]];
pgv = max(sc(250), 2.5);
vs_off = (r_vs - L_rw / 2) * tan(ad) + 2 * dmr + 0.6;   // Abstand Schild - Wand (Nachbarpaneele knicken nach innen)
module rueckwand_lokal(k, fp) {   // x = Länge (zentriert), y = Höhe, z = Dicke (Front oben)
    h = rw_h(k); fr = max(sc(120), 1.2);
    EQ = [for (b = [0 : 2], lvl = [0 : 3 + (k + b) % 4]) [b, lvl]];
    module eq(c) for (q = EQ) let(b = q[0], lvl = q[1], cc = lvl < 3 ? 1 : lvl < 5 ? 2 : 3) if (cc == c)
        translate([-L_rw / 2 + (b + 0.5) * L_rw / 3 - L_rw / 3 * 0.28, h * (0.12 + lvl * 0.085), t_rp - e]) cube([L_rw / 3 * 0.56, h * 0.06, dmr * 2 + e]);
    if (inc(fp, "A")) difference() {
        union() {
            translate([-L_rw / 2, 0, 0]) cube([L_rw, h, t_rp]);
            translate([-L_rw / 2, -(g_rw - spiel), 0]) cube([L_rw, g_rw - spiel + e, t_rp]);
            if (k == K_SCHILD) for (p = vs_peg(k)) translate([p[0] - pgv / 2, p[1] - pgv / 2, t_rp - e]) cube([pgv, pgv, vs_off + max(sc(150), 1.5) + e]);
        }
        // Markisen-Schlitz (Front) und Stützentasche (Rückseite)
        translate([-L_rw * 0.4, h * 0.42, t_rp * 0.5]) cube([L_rw * 0.8, t_aw + 2 * spiel, t_rp]);
        translate([-t_br / 2 - spiel, H_rw * 0.18, -e]) cube([t_br + 2 * spiel, tl_br + 2 * spiel, min(t_rp - 1, clipd + 0.4)]);
    }
    if (inc(fp, "B")) eq(1);
    if (inc(fp, "C")) eq(2);
    if (inc(fp, "D")) eq(3);
    if (inc(fp, "E")) translate([0, 0, t_rp - e]) linear_extrude(dmr + e) difference() {
        translate([-L_rw / 2, 0]) square([L_rw, h]); translate([-L_rw / 2 + fr, fr]) square([L_rw - 2 * fr, h - 2 * fr]);
    }
}
module rueckwand_welt(k, fp = "alle") side_frame(k, r_rw) translate([0, 0, H_p]) rotate([90, 0, -90]) translate([0, 0, -t_rp]) rueckwand_lokal(k, fp);
function info_rw(k) = let(SX = L_rw, SY = rw_h(k) + g_rw, ox = L_rw / 2, oy = g_rw,
    kp = [[ox - t_br / 2 - 1.5, oy + H_rw * 0.18 - 1, ox + t_br / 2 + 1.5, oy + H_rw * 0.18 + tl_br + 1], [-1, -1, SX + 1, g_rw + 1.5]])
    [SX, SY, seams_at(SX, [], mw), seams_at(SY, [[oy + rw_h(k) * 0.42 - spw, oy + rw_h(k) * 0.42 + t_aw + spw]], mw), kp, false, 0, []];
module rueckwand_druck(k, fp) translate([L_rw / 2, g_rw, 0]) rueckwand_lokal(k, fp);
module stuetze_2d() {   // x = radial nach außen ab Paneel-Rückseite, y = hoch
    z1 = H_rw * 0.78; w = max(sc(220), 2.2);
    translate([0, 0]) square([w, z1]);
    translate([0, 0]) square([d_br - 1, w]);
    hull() { translate([w / 2, z1 * 0.85]) circle(d = w * 0.8); translate([d_br - 1.5, w / 2]) circle(d = w * 0.8); }
    translate([-min(t_rp - 1, clipd + 0.4) + 0.2, H_rw * 0.18 + spiel]) square([min(t_rp - 1, clipd + 0.4) - 0.2 + e, tl_br]);   // Zapfen ins Paneel
    translate([d_br * 0.55 - tl_br / 2, -(t_d - 0.6)]) square([tl_br, t_d - 0.6 + e]);                                          // Zapfen ins Deck
}
module stuetze_welt(k) side_frame(k, r_rw + t_rp) translate([0, t_br / 2, H_p]) rotate([90, 0, 0]) linear_extrude(t_br) stuetze_2d();
module markise_2d() {
    sr = max(sc(150), 1.2); nb = max(3, round(L_rw * 0.9 / (3 * sr)));
    translate([-L_rw * 0.45, 0]) square([L_rw * 0.9, d_aw - sr]);
    for (i = [0 : nb - 1]) translate([-L_rw * 0.45 + (i + 0.5) * L_rw * 0.9 / nb, d_aw - sr]) scale([L_rw * 0.9 / nb / (2 * sr), 1]) circle(r = sr, $fn = 20);
    translate([-L_rw * 0.4 + spiel, -t_rp * 0.5 + 0.2]) square([L_rw * 0.8 - 2 * spiel, t_rp * 0.5 - 0.2 + e]);   // Lasche
}
module markise_welt(k) side_frame(k, r_rw) translate([0, 0, H_p + rw_h(k) * 0.42 + spiel]) rotate([0, 0, 90]) linear_extrude(t_aw) markise_2d();
module vinylschild(fp) {   // z = 0 Rückseite, Mitte = Ursprung
    lr = r_vs * 0.44; hl = max(sc(80), 0.8); htx = max(sc(100), 0.8);
    if (inc(fp, "A")) difference() {
        cylinder(r = r_vs, h = t_vs, $fa = 2);
        for (r = [lr * 1.18 : r_vs * 0.07 : r_vs * 0.95]) translate([0, 0, t_vs - d_gr]) linear_extrude(d_gr + 1) difference() { circle(r = r + w_gr / 2, $fa = 2); circle(r = r - w_gr / 2, $fa = 2); }
        translate([0, 0, -1]) cylinder(r = r_vs * 0.05, h = t_vs + 5, $fn = 24);
        for (p = [[-r_vs * 0.35, 0], [r_vs * 0.35, 0]]) translate([p[0] - pgv / 2 - spiel, v_peg - H_rw - pgv / 2 - spiel, -e]) cube([pgv + 2 * spiel, pgv + 2 * spiel, max(sc(150), 1.5) + 0.3]);
    }
    if (inc(fp, "B")) translate([0, 0, t_vs - e]) difference() { cylinder(r = lr, h = hl + e, $fn = 48); translate([0, 0, -1]) cylinder(r = lr * 0.78, h = 5, $fn = 48); }
    if (inc(fp, "C")) translate([0, 0, t_vs - e]) difference() { cylinder(r = lr * 0.78, h = hl + e, $fn = 48); translate([0, 0, -1]) cylinder(r = r_vs * 0.05, h = 5, $fn = 24); }
    if (inc(fp, "D")) translate([0, 0, t_vs + hl - e]) linear_extrude(htx + e) intersection() {
        union() {
            translate([0, lr * 0.12]) resize([lr * 1.6, 0]) text(schild_zeile_1, size = lr * 0.4, font = schild_schrift, halign = "center", valign = "bottom");
            translate([0, -lr * 0.12]) resize([lr * 1.6, 0]) text(schild_zeile_2, size = lr * 0.34, font = schild_schrift, halign = "center", valign = "top");
        }
        difference() { circle(r = lr * 0.98, $fn = 48); circle(r = r_vs * 0.05 + 0.4, $fn = 24); }
    }
}
module vinylschild_welt() side_frame(K_SCHILD, r_rw) translate([-vs_off, 0, H_p + H_rw]) rotate([0, -90, 0]) rotate([0, 0, -90])
    { color(fhex(farbe_vinyl)) vinylschild("A"); color(fhex(farbe_label_1)) vinylschild("B"); color(fhex(farbe_label_2)) vinylschild("C"); color(fhex(farbe_chrom)) vinylschild("D"); }

// =====================================================================
//  LICHTMAST, ZAUN, MISCHPULT
// =====================================================================
module lichtmast(fp) {   // x quer, y hoch, z Dicke (Front oben)
    c = max(sc(80), 1.2); dw = max(sc(60), 1.0); hm = mast_h * 0.82; rv = mast_h * 0.18; zv = mast_h * 0.52;
    n_tr = max(2, round(hm / (w_ms * 0.9)));
    module truss() {
        intersection() {
            union() {
                for (sg = [-1, 1]) translate([sg * (w_ms / 2 - c / 2) - c / 2, 0]) square([c, hm]);
                for (i = [0 : n_tr - 1]) hull() { translate([(i % 2 == 0 ? -1 : 1) * (w_ms / 2 - c / 2), i * hm / n_tr]) circle(d = dw, $fn = 8); translate([(i % 2 == 0 ? 1 : -1) * (w_ms / 2 - c / 2), (i + 1) * hm / n_tr]) circle(d = dw, $fn = 8); }
            }
            translate([-w_ms, 0]) square([2 * w_ms, mast_h]);
        }
        translate([-w_ms * 0.4, -(t_d - 0.6)]) square([w_ms * 0.8, t_d - 0.6 + e]);
    }
    module schwarz() { translate([0, zv]) difference() { circle(r = rv, $fn = 48); circle(r = rv * 0.12, $fn = 16); } translate([-mast_h * 0.14, hm]) square([mast_h * 0.28, mast_h * 0.18]); }
    if (inc(fp, "A")) linear_extrude(t_ms) difference() { truss(); schwarz(); }
    if (inc(fp, "B")) {
        linear_extrude(t_ms) schwarz();
        for (sg = [-1, 1]) translate([sg * mast_h * 0.07, hm + mast_h * 0.09, t_ms - e]) cylinder(r = mast_h * 0.055, h = dmr * 2 + e, $fn = 24);   // Strahler
    }
    if (inc(fp, "C")) translate([0, zv, t_ms - e]) linear_extrude(dmr * 2 + e) difference() { circle(r = rv * 0.45, $fn = 32); circle(r = rv * 0.12, $fn = 16); }
}
module lichtmast_welt(k) side_frame(k, r_ms) translate([t_ms / 2, 0, H_p]) rotate([90, 0, -90]) {
    color(fhex(farbe_stahl)) lichtmast("A"); color(fhex(farbe_vinyl)) lichtmast("B"); color(fhex(farbe_mastlabel)) lichtmast("C");
}
module zaun(fp) {   // x Länge zentriert, y hoch, z Dicke
    nd = 4; rd = min(h_z * 0.32, L_z / nd * 0.42); pitch = (L_z - 2 * st_z) / nd;
    module rahmen() {
        translate([-L_z / 2, 0]) square([L_z, st_z]); translate([-L_z / 2, h_z - st_z]) square([L_z, st_z]);
        for (sg = [-1, 1]) translate([sg * (L_z / 2 - st_z / 2) - st_z / 2, 0]) square([st_z, h_z]);
        for (i = [0 : nd - 1]) translate([-L_z / 2 + st_z + (i + 0.5) * pitch - st_z * 0.3, 0]) square([st_z * 0.6, h_z]);
        for (sg = [-1, 1]) translate([sg * (L_z / 2 - st_z / 2) - st_z * 0.4, -(t_d - 0.6)]) square([st_z * 0.8, t_d - 0.6 + e]);
    }
    module scheiben() for (i = [0 : nd - 1]) translate([-L_z / 2 + st_z + (i + 0.5) * pitch, h_z / 2]) difference() { circle(r = rd, $fn = 32); circle(r = rd * 0.22, $fn = 16); }
    if (inc(fp, "A")) linear_extrude(t_z) difference() { rahmen(); scheiben(); }
    if (inc(fp, "B")) linear_extrude(t_z) scheiben();
    if (inc(fp, "C")) for (i = [0 : nd - 1]) translate([-L_z / 2 + st_z + (i + 0.5) * pitch, h_z / 2, t_z - e]) difference() { cylinder(r = rd * 0.45, h = dmr * 2 + e, $fn = 24); translate([0, 0, -1]) cylinder(r = rd * 0.22, h = 5, $fn = 16); }
}
module zaun_welt(k) side_frame(k, r_z) translate([t_z / 2, 0, H_p]) rotate([90, 0, -90]) {
    color(fhex(farbe_zaun)) zaun("A"); color(fhex(farbe_vinyl)) zaun("B"); color(fhex(farbe_label_1)) zaun("C");
}
module mischpult(fp) {   // x = radial (Tiefe), y = quer; liegt in der Podesttasche
    nch = max(3, round(W_mx / max(sc(500), 4.5))); pc = W_mx / nch; sl = max(sc(40), 0.5);
    if (inc(fp, "A")) difference() {
        translate([-D_mx / 2, -W_mx / 2, 0]) cube([D_mx, W_mx, t_mx]);
        for (i = [0 : nch - 1]) translate([-D_mx * 0.35, -W_mx / 2 + (i + 0.5) * pc - sl / 2, t_mx - dmr]) cube([D_mx * 0.55, sl, dmr + 1]);
    }
    if (inc(fp, "B")) for (i = [0 : nch - 1]) translate([-D_mx * 0.35 + D_mx * 0.55 * ((i * 37) % 10) / 12, -W_mx / 2 + (i + 0.5) * pc - pc * 0.3, t_mx - e]) cube([D_mx * 0.1, pc * 0.6, max(sc(120), 1.2) + e]);
    if (inc(fp, "C")) for (i = [0 : nch - 1], j = [0 : 2]) translate([D_mx * 0.3 + j * D_mx * 0.06, -W_mx / 2 + (i + 0.5) * pc, t_mx - e]) cylinder(d = min(pc * 0.25, D_mx * 0.05), h = dmr * 2 + e, $fn = 10);
}
module mischpult_welt(k) side_frame(k, r_mx) translate([0, 0, H_p - p_mx]) {
    color(fhex(farbe_vinyl)) mischpult("A"); color(fhex(farbe_chrom)) mischpult("B"); color(fhex(farbe_label_1)) mischpult("C");
}

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
function info_schild() = [sw_h, sh_h + pl_h, seams_at(sw_h, [for (x = spx) [x - pw_h - spw, x + pw_h + spw]], mw), [], [[-1, -1, sw_h + 1, pl_h + 1.5]], false, 0, []];module kassenhaus(ex = 0) {
    color(fhex(farbe_haus_boden)) haus_boden();
    for (k = ["vorne", "hinten", "links", "rechts"]) translate([0, 0, ex]) { color(fhex(farbe_haus_wand)) wand_welt(k, "A"); color(fhex(farbe_haus_kanten)) wand_welt(k, "B"); }
    translate([0, 0, 2 * ex]) { color(fhex(farbe_haus_dach)) haus_dach("A"); color(fhex(farbe_haus_kanten)) haus_dach("B"); }
    translate([0, 0, 3 * ex]) { if (inc(farbteil, "A")) color(fhex(farbe_schild_A)) schild_welt("A"); if (inc(farbteil, "B")) color(fhex(farbe_schild_B)) schild_welt("B"); }
}

// =====================================================================
//  ZUSAMMENBAU
// =====================================================================
module teller_baugruppe(ex = 0) achse_rahmen() rotate([0, 0, drehung]) {
    color(fhex(farbe_vinyl)) scheibe("A", [0, R_s + 5, 0, 360, 0]);
    color(fhex(farbe_label_1)) scheibe("B", [0, R_s + 5, 0, 360, 0]);
    color(fhex(farbe_label_2)) scheibe("C", [0, R_s + 5, 0, 360, 0]);
    color(fhex(farbe_chrom)) scheibe("D", [0, R_s + 5, 0, 360, 0]);
    for (k = [0 : 3]) translate(concat(pol(r_x, XA[k]), [t_s + h_sh + ex])) rotate([0, 0, kreuz_drehung + k * 17]) {
        color(fhex(farbe_vinyl)) kreuz("A"); color(fhex(farbe_gold)) kreuz("B");
        for (j = [0 : 3]) translate([arm_r * cos(j * 90), arm_r * sin(j * 90), t_x + h_ed + 0.05 + ex]) rotate([0, 0, gondel_drehung + j * 90 + 55]) {
            color(fhex(GF[(k + j) % 4])) gondel("A"); color(fhex(farbe_chrom)) gondel("B");
        }
    }
}
module turntables(ex = 0) {
    color(fhex(farbe_boden)) translate([0, 0, -ex]) bodenkreuz_welt();
    color(fhex(farbe_deck)) translate([0, 0, ex * 0.5]) deck_welt();
    color(fhex(farbe_blende)) blenden_welt("A"); color(fhex(farbe_licht)) blenden_welt("B");
    for (k = STK) rotate(sidec(k)) translate([ex * 0.5, 0, 0]) { color(fhex(farbe_blende)) stufe_lokal("A"); color(fhex(farbe_licht)) stufe_lokal("B"); }
    translate([0, 0, 2 * ex]) teller_baugruppe(ex);
    translate([0, 0, 2 * ex]) achse_rahmen() turm_welt(ex * 0.6);
    translate([0, 0, ex]) {
        for (k = WK) {
            color(fhex(farbe_vinyl)) rueckwand_welt(k, "A"); color(fhex(farbe_eq_1)) rueckwand_welt(k, "B");
            color(fhex(farbe_eq_2)) rueckwand_welt(k, "C"); color(fhex(farbe_eq_3)) rueckwand_welt(k, "D"); color(fhex(farbe_wandrahmen)) rueckwand_welt(k, "E");
            color(fhex(farbe_stahl)) stuetze_welt(k);
            color(fhex(farbe_markise)) markise_welt(k);
        }
        translate([0, 0, ex]) vinylschild_welt();
        for (k = MK) lichtmast_welt(k);
        for (k = ZK) zaun_welt(k);
        for (k = FK) mischpult_welt(k);
        color(fhex(farbe_chrom)) tonarm_welt();
    }
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFOS = concat([["bodenkreuz", info_bodenkreuz(), 1], ["kreuz", info_kreuz(), 4]],
               [for (k = WK) [str("rueckwand_", k), info_rw(k), 1]],
               [["haus_boden", info_haus_boden(), 1], ["haus_wand_vorne", info_wand("vorne"), 1], ["haus_wand_hinten", info_wand("hinten"), 1],
                ["haus_wand_links", info_wand("links"), 1], ["haus_wand_rechts", info_wand("rechts"), 1],
                ["haus_dach", info_haus_dach(), 1], ["haus_schild", info_schild(), 1]]);
CLIPS = len(DCLIPS) + len(DCL) + lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
cpp = floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3));
function np_of(n) = [for (i = INFOS) if (i[0] == n) n_pieces(i[1])][0];
reach_g = sqrt(pow(g_l / 2, 2) + pow(g_w / 2, 2)) * 1.06;

echo(str("Turntables 1:", den, " | Podest Ø ", r2(2 * (R_di + 3 * d_st) / tc), " mm | Teller Ø ", r2(2 * R_s), " mm, Neigung ", beta,
         "° | Turmhöhe ", r2(z_cb + z_tb + H_turm), " mm | Rückwand ", r2(H_rw), " mm"));
echo(str("Deck: ", len(DP), " Stück(e) | Teller: ", len(FPD), " Stück(e)", disc_split ? str(" (Mitte + ", len(DB), " Ring(e): ", DNP, ")") : ""));
echo(str("Stifte Ø ", stift_d, ": 1x Tonarm (", r2(t_arm + 6), " mm), 4x Kopfhörer-Ausrichtung (6 mm)"));
if (r_x - arm_r - reach_g < r1c + 1) echo("WARNUNG: Gondeln streifen den Turmsockel.");
if (2 * (arm_r + reach_g) > r_x * sqrt(2)) echo("WARNUNG: Gondeln benachbarter Kreuze kommen sich zu nahe.");
if (2 * r1c > usable || 2 * (hp_r + cup_r) > usable) echo("WARNUNG: Turmteile größer als das Druckbett – kleineren Maßstab wählen.");
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
echo(str("Verbinder-Clips gesamt: ", CLIPS, CLIPS > cpp ? str(" -> ", ceil(CLIPS / cpp), " Clip-Platten") : ""));

module druck(t, n, fp, f, m) if (m > 0) echo(str("DRUCK|", t, "|", n, "|", fp, "|", f, "|", m));
druck("deck", len(DP), "alle", farbe_deck, 1);
druck("blende_aussen", 1, "A", farbe_blende, N_d * n_bo); druck("blende_aussen", 1, "B", farbe_licht, N_d * n_bo);
druck("blende_innen", 1, "A", farbe_blende, N_d * n_bi);  druck("blende_innen", 1, "B", farbe_licht, N_d * n_bi);
druck("stufe", 1, "A", farbe_blende, len(STK)); druck("stufe", 1, "B", farbe_licht, len(STK));
druck("bodenkreuz", np_of("bodenkreuz"), "alle", farbe_boden, 1);
for (fp = [["A", farbe_vinyl], ["B", farbe_label_1], ["C", farbe_label_2], ["D", farbe_chrom]]) druck("scheibe", len(FPD), fp[0], fp[1], 1);
druck("turm_kegel", 1, "alle", farbe_chrom, 1);
druck("turm_kragen", 1, "alle", farbe_turmringe, 1);
for (i = [0 : 2]) druck("turm_kugel", 1, "alle", KF[i], 1);
druck("turm_ring", 1, "alle", farbe_turmringe, 2);
druck("turmstifte", 1, "alle", farbe_stahl, 1);
for (fp = [["A", farbe_vinyl], ["B", farbe_label_1], ["C", farbe_gold], ["D", farbe_chrom]]) druck("kopfhoerer", 1, fp[0], fp[1], 2);
druck("kreuz", np_of("kreuz"), "A", farbe_vinyl, 4); druck("kreuz", np_of("kreuz"), "B", farbe_gold, 4);
for (i = [0 : 3]) druck("gondel", 1, "A", GF[i], 4);
druck("gondel", 1, "B", farbe_chrom, 16);
druck("tonarm_saeule", 1, "alle", farbe_chrom, 1);
druck("tonarm", 1, "A", farbe_chrom, 1); druck("tonarm", 1, "B", farbe_label_1, 1);
for (k = WK, fp = [["A", farbe_vinyl], ["B", farbe_eq_1], ["C", farbe_eq_2], ["D", farbe_eq_3], ["E", farbe_wandrahmen]])
    druck(str("rueckwand_", k), np_of(str("rueckwand_", k)), fp[0], fp[1], 1);
druck("wandstuetze", 1, "alle", farbe_stahl, len([for (k = WK) 1]));
druck("markise", 1, "alle", farbe_markise, len([for (k = WK) 1]));
for (fp = [["A", farbe_vinyl], ["B", farbe_label_1], ["C", farbe_label_2], ["D", farbe_chrom]]) druck("vinylschild", 1, fp[0], fp[1], 1);
for (fp = [["A", farbe_stahl], ["B", farbe_vinyl], ["C", farbe_mastlabel]]) druck("lichtmast", 1, fp[0], fp[1], len(MK));
for (fp = [["A", farbe_zaun], ["B", farbe_vinyl], ["C", farbe_label_1]]) druck("zaun", 1, fp[0], fp[1], len(ZK));
for (fp = [["A", farbe_vinyl], ["B", farbe_chrom], ["C", farbe_label_1]]) druck("mischpult", 1, fp[0], fp[1], len(FK));
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
for (f = FARBEN) echo(str("FARBE|", f[0], "|", f[1]));

HX = -(R_di + 3 * d_st) - m_h - W_h; HY = -(R_di + 3 * d_st) * 0.75;
if (teil == "aufbau") { turntables(); if (kassenhaus_zeigen) translate([HX, HY, 0]) kassenhaus(); }
else if (teil == "explosion") { turntables(max(sc(1500), 12)); if (kassenhaus_zeigen) translate([HX - 20, HY, 0]) kassenhaus(max(sc(800), 8)); }
else if (teil == "deck") deck_druck(stueck);
else if (teil == "blende_aussen") blende_lokal(L_bo / n_bo - (n_bo > 1 ? 0.2 : 0), false, farbteil);
else if (teil == "blende_innen") blende_lokal(L_bi / n_bi - (n_bi > 1 ? 0.2 : 0), true, farbteil);
else if (teil == "stufe") stufe_druck(farbteil);
else if (teil == "bodenkreuz") split_out(info_bodenkreuz(), stueck) bodenkreuz_druck();
else if (teil == "scheibe") scheibe_druck(stueck, farbteil);
else if (teil == "turm_kegel") turm_kegel();
else if (teil == "turm_kragen") turm_kragen();
else if (teil == "turm_kugel") turm_kugel();
else if (teil == "turm_ring") turm_ring();
else if (teil == "turmstifte") turmstifte();
else if (teil == "kopfhoerer") kopfhoerer_druck(farbteil);
else if (teil == "kreuz") split_out(info_kreuz(), stueck) kreuz_druck(farbteil);
else if (teil == "gondel") gondel(farbteil);
else if (teil == "tonarm_saeule") tonarm_saeule();
else if (teil == "tonarm") tonarm(farbteil);
else if (starts(teil, "rueckwand_")) let(k = ord(teil[10]) - 48) split_out(info_rw(k), stueck) rueckwand_druck(k, farbteil);
else if (teil == "wandstuetze") translate([min(t_rp - 1, clipd + 0.4), t_d, 0]) linear_extrude(t_br) stuetze_2d();
else if (teil == "markise") translate([L_rw / 2, t_rp * 0.5, 0]) linear_extrude(t_aw) markise_2d();
else if (teil == "vinylschild") translate([r_vs, r_vs, 0]) vinylschild(farbteil);
else if (teil == "lichtmast") translate([mast_h * 0.2, t_d, 0]) lichtmast(farbteil);
else if (teil == "zaun") translate([L_z / 2, t_d, 0]) zaun(farbteil);
else if (teil == "mischpult") translate([D_mx / 2, W_mx / 2, 0]) mischpult(farbteil);
else if (teil == "haus_boden") split_out(info_haus_boden(), stueck) haus_boden_druck();
else if (teil == "haus_wand_vorne") split_out(info_wand("vorne"), stueck) wand_druck("vorne", farbteil);
else if (teil == "haus_wand_hinten") split_out(info_wand("hinten"), stueck) wand_druck("hinten", farbteil);
else if (teil == "haus_wand_links") split_out(info_wand("links"), stueck) wand_druck("links", farbteil);
else if (teil == "haus_wand_rechts") split_out(info_wand("rechts"), stueck) wand_druck("rechts", farbteil);
else if (teil == "haus_dach") split_out(info_haus_dach(), stueck) haus_dach_druck(farbteil);
else if (teil == "haus_schild") split_out(info_schild(), stueck) schild_druck(farbteil);
else if (teil == "verbinder") {
    n = verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4);
    px = floor((usable + 3) / (cL + 3)); py = floor((usable + 3) / (cw1 + 3));
    npl = ceil(n / (px * py));
    for (pl = [0 : npl - 1]) if (stueck == 0 || stueck == pl + 1)
        translate(stueck == 0 ? [pl * (usable + 10), 0, 0] : [0, 0, 0])
        for (i = [pl * px * py : min(n, (pl + 1) * px * py) - 1]) let(j = i - pl * px * py)
            translate([(j % px) * (cL + 3), floor(j / px) * (cw1 + 3), 0]) clip();
}
