// =====================================================================
//  AUTOSCOOTER  –  kompakter Jahrmarkt-Autoscooter als zerlegbarer Bausatz
//  Stil der Rennbahn-Deko-Reihe (Turntables, Raupenbahn, Babyflug):
//  FDM-optimiert (stützfrei), große Teile werden automatisch geteilt
//  (Clips), Stecksystem kompatibel, Farben je Bauteil (Vorschau, Dateinamen,
//  3MF über farb_export.py)  ·  Maßstäbe 1:43 und 1:87  ·  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    podest          Podest mit Fahrfläche und Holz-Umgang (geteilt, Clips)
//    treppe          Treppe vor dem Umgang                             2x
//    bande_seite / bande_hinten / bande_vorne_aussen / bande_vorne_mitte
//                    Rammschutz-Bande um die Fahrfläche  (2x / 2x / 2x / 1x)
//    saeule          Säule mit Zapfen oben und unten                  10x
//    dach            Flachdach mit Lichterkante und Stromnetz (geteilt)
//    prunkfront      Schmuckfassade mit Schriftzug (geteilt, Clips)
//    wagen           Autoscooter-Wagen (Farbe über wagen_nr)          12x
//    kasse_*         Kassenhäuschen (Boden, 4 Wände, Dach, Schild)
//    greifer_unten / greifer_haube   Greifautomat
//    boxer           Box-Automat
//    wohnwagen / deichsel            Schausteller-Wohnwagen
//    packwagen       LKW mit Kofferaufbau (zieht den Wohnwagen)
//    verbinder       Clips für alle geteilten Teile
//
//  BEWEGLICH
//    * Die Wagen stehen lose auf der Fahrfläche und lassen sich beliebig
//      verteilen. Die Stromstange ist ein Stück Filament (1,75 mm).
//    * Die Deichsel des Wohnwagens greift mit einem Zapfen in die
//      Kupplung des Packwagens – das Gespann lässt sich koppeln.
//
//  MONTAGE
//    1. Podest umgedreht verclipsen, umdrehen, Treppen vorne ansetzen.
//    2. Banden mit den Zapfen in die Schlitze um die Fahrfläche stecken.
//    3. Säulen in die Vierkantlöcher stecken. Dach umgedreht verclipsen und
//       mit den Löchern der Unterseite auf die 10 Säulenzapfen setzen.
//    4. Prunkfront verclipsen und mit den Zapfen in die Schlitze vorne im
//       Dach stecken.
//    5. Filament-Stangen in die Wagen stecken, Wagen auf die Fahrfläche.
//    6. Kasse, Automaten, Wohnwagen und Packwagen aufstellen.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, podest:Podest, treppe:Treppe, bande_seite:Bande Seite, bande_hinten:Bande hinten, bande_vorne_aussen:Bande vorne außen, bande_vorne_mitte:Bande vorne Mitte, saeule:Säule, dach:Dach, prunkfront:Prunkfront, wagen:Wagen, kasse_boden:Kasse Boden, kasse_wand_vorne:Kasse Wand vorne, kasse_wand_hinten:Kasse Wand hinten, kasse_wand_links:Kasse Wand links, kasse_wand_rechts:Kasse Wand rechts, kasse_dach:Kasse Dach, kasse_schild:Kasse Schild, greifer_unten:Greifautomat Unterschrank, greifer_haube:Greifautomat Haube, boxer:Box-Automat, wohnwagen:Wohnwagen, deichsel:Deichsel, packwagen:Packwagen, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Mehrfarbige Teile: alle oder einzelne Farbe (A = Grundkörper)
farbteil = "alle"; // [alle, A, B, C, D]
// Grundfarbe des Wagens bei teil = wagen (1..4)
wagen_nr = 1; // [1:4]

/* [Vorschau] */
fahrzeuge_zeigen = true;

/* [Autoscooter (Vorbild in Metern)] */
breite_m = 18.0;          // Front
tiefe_m  = 10.0;
podest_hoehe_m = 0.45;
lichte_hoehe_m = 4.2;     // Podest bis Dachunterkante
umgang_tiefe_m = 1.8;     // Holz-Umgang vorne
wagen_anzahl = 12;        // [6:20]
front_text = "AUTOSCOOTER";
kasse_schild_text = "CHIPS";
packwagen_text = "AUTOSCOOTER";
schrift = "Liberation Sans:style=Bold";

/* [Farben] */
farbe_podest   = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_umgang   = "holz";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_bande_1  = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_bande_2  = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_saeule   = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_licht    = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_dach     = "blau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_dachrand = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_front_A  = "violett";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_front_B  = "gold";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_front_C  = "weiss";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_front_D  = "cyan";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_wagen_1  = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_wagen_2  = "blau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_wagen_3  = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_wagen_4  = "neongruen"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gummi    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_sitz     = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_boden = "grau";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_wand = "rot";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_rahmen = "gold";  // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_dekor = "weiss";  // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kasse_dach = "blau";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild_A = "blau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild_B = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_automat  = "pink";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_automat_2 = "gelb";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_glas     = "weiss";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_preise   = "cyan";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_boxer    = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_wohnwagen = "creme";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_fenster  = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_zierstreifen = "violett"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_packwagen = "weiss";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_fahrgestell = "schwarz"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_clips    = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

/* [Druck & Passung] */
rennbahn_taschen = true;
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
stift_d = 1.75;
verbinder_anzahl = 0;


include <../../lib/deko_grundlagen.scad>
WF = [farbe_wagen_1, farbe_wagen_2, farbe_wagen_3, farbe_wagen_4];
include <../../lib/deko_hilfen.scad>

// =====================================================================
//  Zusatz-Hilfen (Autoscooter)
// =====================================================================
module stern(r, n = 5) polygon([for (i = [0 : 2 * n - 1]) pol(i % 2 == 0 ? r : r * 0.45, 90 + i * 180 / n)]);
module blitz(h) scale(h / 10) polygon([[1.5, 10], [5.5, 10], [3.6, 6.2], [6.4, 6.2], [0.8, 0], [2.4, 4.6], [-0.2, 4.6]]);
module rrect(x, y, r) offset(r = r) offset(delta = -r) square([x, y], center = true);
dmr   = max(sc(20), 0.4);    // Gravur
d_inl = max(sc(30), 0.6);    // Inlay-Tiefe
dm    = max(sc(20), 0.4);    // Relief

// =====================================================================
//  Maße  (Welt: x = Front, y = Tiefe, vorne y = 0, z = 0 Boden)
// =====================================================================
W   = sc(breite_m * 1000, 120);
D   = sc(tiefe_m * 1000, 70);
H_p = max(sc(podest_hoehe_m * 1000), 4, clipd + 1.2);
h_cl = sc(lichte_hoehe_m * 1000, 40);
u_f = sc(umgang_tiefe_m * 1000, 16);       // Umgang vorne
u_s = sc(400, 4.5);                         // Rand seitlich/hinten
t_bd = max(sc(300), clipd + 0.6);           // Bande
h_bd = sc(500, 5);
ga_w = sc(2000, 18);                        // Durchlass in der Bande
GX  = [W * 0.25, W * 0.75];                 // Durchlässe / Treppen
st_w = sc(3000, 26); st_d = sc(800, 7);     // Treppe
h_ph = min(H_p - 1.2, max(sc(300), 3));     // Lochtiefe
h_pg = h_ph - 0.3;                          // Zapfenlänge
tw_b = max(sc(300), 3);                     // Bandenzapfen

// Fahrfläche (innerhalb der Bande)
FX0 = u_s + t_bd; FX1 = W - u_s - t_bd; FY0 = u_f + t_bd; FY1 = D - u_s - t_bd;

// Säulen
c_s = max(sc(250), 3.5);
p_c = c_s - 1.0;                            // Vierkantzapfen
SAEULEN = concat(
    [for (x = [u_s / 2, W * 0.39, W * 0.61, W - u_s / 2]) [x, u_s / 2]],
    [for (x = [u_s / 2, W / 3, 2 * W / 3, W - u_s / 2]) [x, D - u_s / 2]],
    [[u_s / 2, D * 0.55], [W - u_s / 2, D * 0.55]]);

// Dach
ov_r = sc(100, 1);
RW = W + 2 * ov_r; RD = D + 2 * ov_r;
t_d = max(sc(250), clipd + 1.5);
h_phr = min(t_d - 1.0, h_ph);              // Lochtiefe im Dach
h_pgt = h_phr - 0.3;
z_rb = H_p + h_cl;
w_rr = max(sc(200), 2); h_rr = max(sc(120), 1.2);   // Lichterkante
d_bulb = max(sc(100), 1.0);

// Prunkfront (lokal: x = Breite, y = Höhe, z = Dicke, Schauseite oben)
h_pf = sc(2200, 18);
h_cr = sc(3400, 28);                        // Scheitel in der Mitte
t_pf = max(sc(250), clipd + 0.8);
pw_pf = max(sc(400), 4); pl_pf = min(t_d - 1.0, max(sc(300), 3));
n_pf = max(1, ceil(RW / usable));
PEGS_PF = [for (i = [0 : n_pf - 1], f = [0.25, 0.75]) (i + f) * RW / n_pf];
y_pf = t_pf / 2 + max(sc(60), 0.8);         // Mitte der Front über dem Dach (y lokal Dach)

// Wagen (lokal: x = Länge, Front +x)
L_c = sc(2000, 15); W_c = sc(1300, 10);
h_b = sc(300, 2.5); o_b = max(sc(80), 0.8);
h_body = sc(800, 6.5);
d_tw = max(sc(160), stift_d + 1.8);         // Stangenhalter
h_tw = h_body + sc(300, 2.5);
d_ph = min(h_tw - 1.0, max(sc(450), 4));    // Lochtiefe Stange
L_stange = z_rb - (H_p + h_tw) - 0.6 + d_ph;

// Kassenhäuschen (lokal: x = Breite, y = Tiefe, vorne y = 0)
W_k = sc(1800, 15); D_k = sc(1300, 11); H_k = sc(2300, 18);
g_k = max(sc(60), 1.2); t_wk = max(sc(60), 1.6);
m_k = max(sc(80), 1.0);
t_fk = max(sc(100), g_k + 1.0);
LS_k = D_k - 2 * t_wk;
fwid = max(sc(60), 0.8); fw2 = max(sc(80), 1.0);
ww_k = W_k * 0.62; wx0 = (W_k - ww_k) / 2; wx1 = wx0 + ww_k;
v_s = sc(950, 7); v_t = min(sc(1850), H_k - sc(350, 3));
c_out = max(sc(200), 2);
dw_k = min(sc(750), W_k * 0.45); dh_k = min(sc(2000), H_k - sc(200, 2)); du0 = (W_k - dw_k) / 2;
fw_k = LS_k * 0.5; fh_k = min(sc(600), H_k * 0.28); fv0 = min(sc(1150), H_k - fh_k - sc(300)); fu0 = (LS_k - fw_k) / 2;
ov_k = max(sc(150), 1.6);
t_rk = max(sc(120), g_k + 1.2);
h_rf = max(sc(350), 2.5);
RXk = W_k + 2 * ov_k; RYk = D_k + 2 * ov_k;
sw_k = W_k * 0.95; sh_k = sc(500, 5); st_k = max(sc(60), 1.6);
pw_k = max(sc(120), 1.8);
pl_k = min(t_rk + h_rf * 0.5 - 0.6, max(sc(150), 2));
spx_k = [0.2 * sw_k, 0.8 * sw_k];
s_bd = max(sc(40), 0.8); s_te = max(sc(15), 0.4);
KX = W / 2 - W_k / 2; KY = (u_f - D_k) / 2;

// Greifautomat
g_w = sc(900, 8); g_d = sc(850, 7.5); g_h1 = sc(950, 8);
g_h2 = sc(800, 7); g_h3 = sc(250, 2.5);
t_gl = max(sc(30), 0.8); w_gp = max(sc(60), 1.2);
h_lip = max(sc(60), 1.0);
GRX = u_s + sc(500, 4); GRY = (u_f - g_d) / 2;
g_y0 = g_d * 0.3; g_dh = g_d - g_y0;            // Haube sitzt hinter dem schrägen Bedienpult
// Box-Automat (lokal: x = Breite, y = Tiefe (Front y = 0), z hoch)
b_w = sc(700, 6); b_d = sc(600, 5.5); b_h1 = sc(1150, 10);
b_w2 = sc(950, 8.5); b_t2 = max(sc(180), 1.8); b_h2 = sc(950, 8.5);
b_arm = max(sc(120), 1.6); b_ball = sc(330, 3.5);
BXX = W - u_s - sc(500, 4) - b_w2; BXY = (u_f - b_d) / 2 + sc(150);

// Wohnwagen (lokal: x = Länge, Front +x, y = Breite 0..ww, z hoch)
L_ww = sc(8000, 60); B_ww = sc(2500, 20); H_ww = sc(3400, 26);
r_wh = sc(420, 3.5); t_wh = max(sc(300), 2.4);
z_sk = r_wh;                                 // Schürze bis Achsmitte
z_db = sc(600, 5);                           // Deichsel-Unterkante
t_db = max(sc(100), 1.6);
L_db = sc(1700, 12);
w_db = sc(1000, 8);
d_slot = sc(450, 4);
ch_w = max(sc(100), 0.8);                    // Fasen
// Packwagen (LKW)
L_lk = sc(7000, 52); B_lk = sc(2500, 20);
r_lk = sc(500, 4);
z_lks = r_lk;                                 // Schürze bis Achsmitte
H_box = sc(3600, 28); H_cab = sc(3100, 24);
x_box = sc(4700, 35); x_cab0 = sc(4850, 36);
d_pin = max(sc(150), 2.0);
h_pin = max(sc(150), 2.0);

// =====================================================================
//  PODEST
// =====================================================================
BANDEN = [   // [Name, x0, y0, Länge, Richtung (0 = x, 90 = y)]
    ["bande_seite", u_s, u_f, D - u_s - u_f, 90],
    ["bande_seite", W - u_s - t_bd, u_f, D - u_s - u_f, 90],
    ["bande_hinten", u_s + t_bd, D - u_s - t_bd, (W - 2 * u_s - 2 * t_bd) / 2, 0],
    ["bande_hinten", W / 2, D - u_s - t_bd, (W - 2 * u_s - 2 * t_bd) / 2, 0],
    ["bande_vorne_aussen", u_s + t_bd, u_f, GX[0] - ga_w / 2 - u_s - t_bd, 0],
    ["bande_vorne_aussen", GX[1] + ga_w / 2, u_f, W - u_s - t_bd - GX[1] - ga_w / 2, 0],
    ["bande_vorne_mitte", GX[0] + ga_w / 2, u_f, GX[1] - GX[0] - ga_w, 0]];
function bande_len(n) = [for (b = BANDEN) if (b[0] == n) b[3]][0];
function bande_tabs(L) = L > sc(5000, 60) ? [L * 0.15, L * 0.5, L * 0.85] : [L * 0.25, L * 0.75];
// Schlitz-Rechtecke der Bandenzapfen (Welt)
BSLOTS = [for (b = BANDEN, t = bande_tabs(b[3])) b[4] == 0
    ? [b[1] + t - tw_b / 2 - spiel, b[2] - spiel, b[1] + t + tw_b / 2 + spiel, b[2] + t_bd + spiel]
    : [b[1] - spiel, b[2] + t - tw_b / 2 - spiel, b[1] + t_bd + spiel, b[2] + t + tw_b / 2 + spiel]];
SOCK = [for (c = SAEULEN) [c[0] - p_c / 2 - spiel, c[1] - p_c / 2 - spiel, c[0] + p_c / 2 + spiel, c[1] + p_c / 2 + spiel]];
RBP = [[0, D / 2], [W, D / 2]];

module podest_welt(fp = "alle") {
    wl = max(sc(20), 0.4);
    d_hz = max(d_inl, dmr + 0.6);   // Holz-Inlay: unter den Fugen bleiben 0,6 mm, die Bohlen hängen zusammen
    module holz(x = 0) translate([0, 0, H_p - d_hz]) linear_extrude(d_hz + x) square([W, u_f]);   // x > 0 nur zum Ausschneiden
    if (inc(fp, "A")) difference() {
        cube([W, D, H_p]);
        holz(1);
        // Stahlplatten der Fahrfläche
        for (x = [FX0 + sc(1000) : sc(1000, 8) : FX1 - 1]) translate([x - wl / 2, FY0, H_p - dmr]) cube([wl, FY1 - FY0, dmr + 1]);
        for (y = [FY0 + sc(1000) : sc(1000, 8) : FY1 - 1]) translate([FX0, y - wl / 2, H_p - dmr]) cube([FX1 - FX0, wl, dmr + 1]);
        // Säulen- und Bandenlöcher
        for (r = concat(SOCK, BSLOTS)) translate([r[0], r[1], H_p - h_ph]) cube([r[2] - r[0], r[3] - r[1], h_ph + 1]);
        if (rennbahn_taschen) { translate([0, D / 2, 0]) rb_slot(); translate([W, D / 2, 0]) rotate(180) rb_slot(); }
    }
    if (inc(fp, "B")) difference() {   // Holz-Umgang (bündiges Inlay)
        holz();
        for (y = [sc(250, 2) : sc(250, 2) : u_f - 0.5]) translate([-1, y - wl / 2, H_p - dmr]) cube([W + 2, wl, dmr + 1]);
        for (r = concat(SOCK, BSLOTS)) translate([r[0], r[1], H_p - h_ph]) cube([r[2] - r[0], r[3] - r[1], h_ph + 1]);
    }
}
function info_podest() = let(
    kp = concat([for (r = concat(SOCK, BSLOTS)) [r[0] - 1.5, r[1] - 1.5, r[2] + 1.5, r[3] + 1.5]],
                [[-1, D / 2 - cw1, cL + 1, D / 2 + cw1], [W - cL - 1, D / 2 - cw1, W + 1, D / 2 + cw1]]),
    xb = [for (c = SAEULEN) [c[0] - c_s - spw / 2, c[0] + c_s + spw / 2]],
    yb = [for (c = SAEULEN) [c[1] - c_s - spw / 2, c[1] + c_s + spw / 2]])
    [W, D, W > usable ? seams_at(W, xb, mw) : [], D > usable ? seams_at(D, yb, mw) : [], kp, false, 0, [], [], 30];

module treppe_2d() let(h = H_p / 2, d = st_d / 2) polygon([[0, 0], [2 * d, 0], [2 * d, 2 * h], [d, 2 * h], [d, h], [0, h]]);
module treppe() linear_extrude(st_w) treppe_2d();
module treppe_welt(i) translate([GX[i] - st_w / 2, -st_d, 0]) rotate([90, 0, 90]) linear_extrude(st_w) treppe_2d();

// =====================================================================
//  BANDE (lokal: x = Länge, y = Höhe, z = Dicke)
// =====================================================================
module bande(L, fp = "alle") {
    p = sc(500, 4.5); n = max(2, round(L / p)); pp = L / n;
    module koerper() union() {
        hull() { square([L, h_bd * 0.75]); translate([t_bd * 0.2, 0]) square([L - t_bd * 0.4, h_bd]); }
    }
    // verdeckte Leisten im Inneren: gelb (A) unten durch die schwarzen Felder, schwarz (B) oben durch die gelben
    lA = n % 2 == 0 ? n - 2 : n - 1; lB = n % 2 == 0 ? n - 1 : n - 2;
    module leiste(x0, x1, y) if (x1 > x0) translate([x0, y - b_ls / 2, t_bd / 2 - b_ls / 2]) cube([x1 - x0, b_ls, b_ls]);
    module leiste_A() {
        leiste(pp / 2, (lA + 0.5) * pp, h_bd * 0.3);
        for (t = bande_tabs(L)) translate([t - b_ls / 2, -e, t_bd / 2 - b_ls / 2]) cube([b_ls, h_bd * 0.3 + e, b_ls]);   // Zapfen hängen an der Leiste
    }
    module leiste_B() leiste(1.5 * pp, (lB + 0.5) * pp, h_bd * 0.62);
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(t_bd) {
                intersection() { koerper(); for (i = [0 : 2 : n - 1]) translate([i * pp, -1]) square([pp, h_bd + 2]); }
                for (t = bande_tabs(L)) translate([t - tw_b / 2, -h_pg]) square([tw_b, h_pg + e]);
            }
            leiste_A();
        }
        leiste_B();
    }
    if (inc(fp, "B")) difference() {
        union() { linear_extrude(t_bd) intersection() { koerper(); for (i = [1 : 2 : n - 1]) translate([i * pp, -1]) square([pp, h_bd + 2]); } leiste_B(); }
        leiste_A();
    }
}
b_ls = max(0.8, min(1.2, t_bd * 0.3));       // Querschnitt der verdeckten Leisten
module bande_welt(b, fp = "alle") {
    if (b[4] == 0) translate([b[1], b[2] + t_bd, H_p]) rotate([90, 0, 0]) bande(b[3], fp);
    else translate([b[1], b[2], H_p]) rotate([0, 0, 90]) rotate([90, 0, 0]) bande(b[3], fp);
}

// =====================================================================
//  SÄULE (z = 0 Zapfenunterseite)
// =====================================================================
module saeule(fp = "alle") {
    fl = max(0.4, min(max(sc(80), 1.0), u_s / 2 - c_s / 2 - 0.2)); hb = max(sc(250), 2);   // Fuß bleibt 0,2 mm vor der Bande
    lh = max(sc(100), 0.8); lw = max(sc(50), 0.8); dc = max(d_inl, 1.0);   // Leitung: Breite, Tiefe
    LZ = [for (z = [h_pg + hb + sc(300, 3) : sc(450, 4) : h_pg + h_cl - hb - 1]) z];
    module licht() {
        for (z = LZ, sg = [-1, 1])
            translate([-c_s / 2 + 0.6, sg * (c_s / 2) - (sg > 0 ? d_inl : -e) - (sg > 0 ? 0 : e), z]) cube([c_s - 1.2, d_inl + e, lh]);
        // Leitung je Seite (verbindet die Lichtstreifen) und ein verdeckter Steg quer durch die Säule
        for (sg = [-1, 1]) translate([-lw / 2, sg > 0 ? c_s / 2 - dc : -c_s / 2 - e, LZ[0]]) cube([lw, dc + e, LZ[len(LZ) - 1] + lh - LZ[0]]);
        translate([-lw / 2, -c_s / 2, LZ[0]]) cube([lw, c_s, lh]);
    }
    if (inc(fp, "A")) difference() {
        union() {
            translate([-p_c / 2, -p_c / 2, 0]) cube([p_c, p_c, h_pg + e]);
            hc = (c_s + 2 * fl - p_c) / 2 * 1.2;   // Fase steiler als 45° (sicher stützfrei)
            zf = h_pg + max(hc + e, hb * 0.6);
            hull() {   // Fuß, unten angefast (stützfrei über dem Zapfen)
                translate([-p_c / 2, -p_c / 2, h_pg]) cube([p_c, p_c, e]);
                translate([-c_s / 2 - fl, -c_s / 2 - fl, h_pg + hc]) cube([c_s + 2 * fl, c_s + 2 * fl, zf - h_pg - hc]);
            }
            translate([0, 0, zf - e]) linear_extrude(fl + e, scale = c_s / (c_s + 2 * fl)) square(c_s + 2 * fl, center = true);
            translate([-c_s / 2, -c_s / 2, zf - e]) cube([c_s, c_s, h_pg + h_cl - hb - zf + e]);   // Schaft erst über dem Fuß (keine flache Stufe über dem Zapfen)
            // Kapitell 45°
            translate([0, 0, h_pg + h_cl - hb - fl * 1.2]) linear_extrude(fl * 1.2, scale = (c_s + 2 * fl) / c_s) square(c_s, center = true);   // steiler als 45°
            translate([-c_s / 2 - fl, -c_s / 2 - fl, h_pg + h_cl - hb]) cube([c_s + 2 * fl, c_s + 2 * fl, hb]);
            translate([-p_c / 2, -p_c / 2, h_pg + h_cl - e]) cube([p_c, p_c, h_pgt + e]);
        }
        licht();
    }
    if (inc(fp, "B")) licht();
}

// =====================================================================
//  DACH (lokal: x 0..RW, y 0..RD; Welt = lokal - ov_r, z ab z_rb)
// =====================================================================
DSOCK = [for (c = SAEULEN) [c[0] + ov_r - p_c / 2 - spiel, c[1] + ov_r - p_c / 2 - spiel, c[0] + ov_r + p_c / 2 + spiel, c[1] + ov_r + p_c / 2 + spiel]];
DSLOT = [for (x = PEGS_PF) [x - pw_pf / 2 - spiel, y_pf - t_pf / 2 - spiel, x + pw_pf / 2 + spiel, y_pf + t_pf / 2 + spiel]];
module dach_lokal(fp = "alle") {
    wl = max(sc(20), 0.4);
    module rand() translate([0, 0, t_d - e]) linear_extrude(h_rr + e) difference() {
        square([RW, RD]); translate([w_rr, w_rr]) square([RW - 2 * w_rr, RD - 2 * w_rr]);
        translate([-1, -1]) square([RW + 2, y_pf + t_pf / 2 + 1.4]);   // vorne: Platz für die Prunkfront
    }
    module birnen() for (x = [w_rr : sc(450, 4) : RW - w_rr], y = [RD - w_rr / 2]) translate([x, y, t_d + h_rr - e]) cylinder(d = d_bulb, h = dm * 2 + e, $fn = 12);
    module birnen_s() for (y = [y_pf + t_pf + sc(300) : sc(450, 4) : RD - w_rr], x = [w_rr / 2, RW - w_rr / 2]) translate([x, y, t_d + h_rr - e]) cylinder(d = d_bulb, h = dm * 2 + e, $fn = 12);
    if (inc(fp, "A")) difference() {
        cube([RW, RD, t_d]);
        // Stromnetz unter der Fahrfläche
        for (x = [FX0 + ov_r : sc(600, 5) : FX1 + ov_r]) translate([x - wl / 2, FY0 + ov_r, -1]) cube([wl, FY1 - FY0, dmr + 1]);
        for (y = [FY0 + ov_r : sc(600, 5) : FY1 + ov_r]) translate([FX0 + ov_r, y - wl / 2, -1]) cube([FX1 - FX0, wl, dmr + 1]);
        for (r = DSOCK) translate([r[0], r[1], -1]) cube([r[2] - r[0], r[3] - r[1], h_phr + 1]);
        for (r = DSLOT) translate([r[0], r[1], t_d - pl_pf - 0.3]) cube([r[2] - r[0], r[3] - r[1], pl_pf + 1]);
        // Dachbahnen oben
        for (x = [sc(1500, 12) : sc(1500, 12) : RW - 1]) translate([x - wl / 2, w_rr + 1, t_d - dmr]) cube([wl, RD - 2 * w_rr - 2, dmr + 1]);
    }
    if (inc(fp, "B")) rand();
    module leitung() let(ys = y_pf + t_pf + sc(300), yb = RD - w_rr / 2, P = [[w_rr / 2, ys], [w_rr / 2, yb], [RW - w_rr / 2, yb], [RW - w_rr / 2, ys]])
        translate([0, 0, t_d + h_rr - e]) linear_extrude(dm + e) for (i = [0 : 2]) bar(P[i], P[i + 1], max(d_bulb * 0.35, 0.5));
    if (inc(fp, "C")) { birnen(); birnen_s(); leitung(); }
}
function info_dach() = let(
    kp = concat([for (r = DSOCK) [r[0] - 1.5, r[1] - 1.5, r[2] + 1.5, r[3] + 1.5]]),
    xb = concat([for (c = SAEULEN) [c[0] + ov_r - c_s - spw / 2, c[0] + ov_r + c_s + spw / 2]], [for (x = PEGS_PF) [x - pw_pf - spw / 2, x + pw_pf + spw / 2]]),
    yb = [for (c = SAEULEN) [c[1] + ov_r - c_s - spw / 2, c[1] + ov_r + c_s + spw / 2]])
    [RW, RD, RW > usable ? seams_at(RW, xb, mw) : [], RD > usable ? seams_at(RD, yb, mw) : [], kp, false, 0, [], [], 30];
module dach_welt(fp = "alle") translate([-ov_r, -ov_r, z_rb]) dach_lokal(fp);

// =====================================================================
//  PRUNKFRONT (lokal: x = Breite, y = Höhe, z = Dicke; Schauseite oben)
// =====================================================================
cr_w = RW * 0.48;
module pf_umriss() {
    square([RW, h_pf]);
    // Scheitel: Bogen in der Mitte
    translate([RW / 2, 0]) intersection() {
        scale([cr_w / 2, h_cr]) circle(r = 1, $fn = 96);
        translate([-cr_w / 2, 0]) square([cr_w, h_cr]);
    }
    // Ecktürmchen
    for (x = [0, RW - sc(900, 7)]) translate([x, 0]) { square([sc(900, 7), h_pf + sc(350, 3)]); translate([sc(450, 3.5), h_pf + sc(350, 3)]) circle(r = sc(450, 3.5), $fn = 40); }
}
module pf_rahmen_2d() {   // Farbe B: Rahmen + Birnen-Rand
    rb = max(sc(80), 1.0);
    difference() { pf_umriss(); offset(delta = -rb) pf_umriss(); }
    difference() { offset(delta = -rb * 3) pf_umriss(); offset(delta = -rb * 4) pf_umriss(); }
}
rb_pf = max(sc(80), 1.0);
a0_pf = asin(min(1, (h_pf - 2 * rb_pf) / (h_cr - 2 * rb_pf))) + 4;   // Bogen-Birnen nur dort, wo der Rahmen verläuft
PF_X = let(n = floor(RW / sc(450, 4))) [for (i = [1 : n - 1]) let(x = i * RW / n) if (abs(x - RW / 2) > cr_w / 2 + 1 && x > sc(900, 7) + 1 && x < RW - sc(900, 7) - 1) x];
PF_A = [for (a = [8 : 8 : 172]) if (a >= a0_pf && a <= 180 - a0_pf) a];
PF_XB = let(n = floor(RW / sc(450, 4))) [for (i = [1 : n - 1]) let(x = i * RW / n) if (x > sc(900, 7) + 1 && x < RW - sc(900, 7) - 1) x];   // untere Lichterreihe
function pf_arc(a, k) = [RW / 2 + cos(a) * (cr_w / 2 - k * rb_pf), sin(a) * (h_cr - k * rb_pf)];
module pf_birnen() {
    for (x = PF_X) translate([x, h_pf - rb_pf * 2]) circle(d = d_bulb, $fn = 12);
    for (a = PF_A) translate(pf_arc(a, 2)) circle(d = d_bulb, $fn = 12);
    for (x = PF_XB) translate([x, rb_pf * 2]) circle(d = d_bulb, $fn = 12);
    // Stege vom äußeren zum inneren Rahmen
    for (x = PF_X) bar([x, h_pf - 0.5 * rb_pf], [x, h_pf - 3.5 * rb_pf], max(d_bulb * 0.35, 0.5));
    for (a = PF_A) bar(pf_arc(a, 0.5), pf_arc(a, 3.5), max(d_bulb * 0.35, 0.5));
    for (x = PF_XB) bar([x, 0.5 * rb_pf], [x, 3.5 * rb_pf], max(d_bulb * 0.35, 0.5));
}
module pf_dekor_2d() {    // Farbe C: Schrift, Sterne
    ts = min(h_cr * 0.3, cr_w * 0.85 / max(1, len(front_text) * 0.72));
    translate([RW / 2, h_pf * 0.62]) resize([min(cr_w * 0.70, len(front_text) * ts * 0.75), 0])
        text(front_text, size = ts, font = schrift, halign = "center", valign = "center");
    for (x = [RW * 0.11, RW * 0.89]) translate([x, h_pf * 0.5]) stern(h_pf * 0.22);
}
module pf_blitze_2d() {   // Farbe D: Blitze
    for (x = [RW * 0.19, RW * 0.255]) translate([x, h_pf * 0.18]) blitz(h_pf * 0.62);
    for (x = [RW * 0.81, RW * 0.745]) translate([x, h_pf * 0.18]) mirror([1, 0]) blitz(h_pf * 0.62);
}
module prunkfront(fp = "alle") {
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(t_pf) pf_umriss();
            for (x = PEGS_PF) translate([x - pw_pf / 2, -pl_pf, 0]) cube([pw_pf, pl_pf + e, t_pf]);
        }
    }
    if (inc(fp, "B")) translate([0, 0, t_pf - e]) linear_extrude(dm + e) { pf_rahmen_2d(); pf_birnen(); }
    if (inc(fp, "C")) translate([0, 0, t_pf - e]) linear_extrude(dm * 1.5 + e) difference() { pf_dekor_2d(); pf_rahmen_2d(); pf_birnen(); }
    if (inc(fp, "D")) translate([0, 0, t_pf - e]) linear_extrude(dm + e) difference() { pf_blitze_2d(); pf_rahmen_2d(); pf_birnen(); pf_dekor_2d(); }
}
function info_pf() = [RW, h_cr + pl_pf, RW > usable ? seams_at(RW, [for (x = PEGS_PF) [x - pw_pf - spw / 2, x + pw_pf + spw / 2]], mw) : [], [],
                      [[-1, -1, RW + 1, pl_pf + 1.5]], false, 0, [[0, pl_pf, RW, pl_pf + h_pf]], [], 30];
module prunkfront_druck(fp) translate([0, pl_pf, 0]) prunkfront(fp);
module prunkfront_welt(fp = "alle") translate([-ov_r, -ov_r + y_pf - t_pf / 2, z_rb + t_d]) rotate([90, 0, 0]) translate([0, 0, -t_pf]) prunkfront(fp);

// =====================================================================
//  WAGEN (lokal: x = Länge, Front +x, Ursprung Mitte unten)
// =====================================================================
module wagen_koerper() {
    r = W_c * 0.3;
    hull() {
        translate([0, 0, h_b * 0.5]) linear_extrude(e) rrect(L_c - 2 * o_b, W_c - 2 * o_b, r);
        translate([0, 0, h_body - e]) linear_extrude(e) rrect((L_c - 2 * o_b) * 0.92, (W_c - 2 * o_b) * 0.86, r * 0.8);
    }
    linear_extrude(h_b * 0.5 + e) rrect(L_c - 2 * o_b, W_c - 2 * o_b, r);
    // Frontverkleidung
    hull() {
        translate([L_c * 0.18, 0, h_body - e]) linear_extrude(e) rrect(L_c * 0.3, (W_c - 2 * o_b) * 0.8, r * 0.6);
        translate([L_c * 0.24, 0, h_body + sc(150, 1.2)]) linear_extrude(e) rrect(L_c * 0.12, (W_c - 2 * o_b) * 0.7, r * 0.3);
    }
    // Stangenhalter hinten
    translate([-L_c * 0.36, 0, 0]) cylinder(d = d_tw, h = h_tw, $fn = 24);
}
module wagen_cockpit() translate([-L_c * 0.06, 0, h_b + max(sc(150), 1.2)]) linear_extrude(h_body * 2) rrect(L_c * 0.42, W_c * 0.62, W_c * 0.15);
module wagen(fp = "alle") {
    r = W_c * 0.3;
    if (inc(fp, "A")) difference() {
        wagen_koerper();
        wagen_cockpit();
        translate([-L_c * 0.36, 0, h_tw - d_ph]) cylinder(d = stift_d + 0.1, h = d_ph + 1, $fn = 16);
        // Scheinwerfer-Mulde
        translate([L_c * 0.30, 0, h_body * 0.75]) rotate([0, 90, 0]) linear_extrude(L_c) rotate(180) teardrop(h_body * 0.125);   // Spitze nach oben
    }
    if (inc(fp, "B")) difference() {   // Gummi-Rammschutz
        linear_extrude(h_b) rrect(L_c, W_c, r + o_b);
        translate([0, 0, -1]) linear_extrude(h_b + 2) rrect(L_c - 2 * o_b + 0.01, W_c - 2 * o_b + 0.01, r);
    }
    if (inc(fp, "C")) {   // Sitz + Lenkrad
        intersection() {
            wagen_cockpit();
            translate([-L_c * 0.27, -W_c, h_b]) cube([L_c * 0.12, 2 * W_c, h_body * 0.75 - h_b + sc(150)]);
        }
        intersection() { wagen_cockpit(); translate([-L_c * 0.27, -W_c, h_b]) cube([L_c * 0.42, 2 * W_c, sc(150, 1.2) + max(sc(150), 1.2) + 0.01]); }   // Boden bis unter das Lenkrad
        translate([L_c * 0.1, 0, h_b + max(sc(150), 1.2) - e]) {
            cylinder(d = max(sc(60), 1.0), h = h_body * 0.55, $fn = 12);
            translate([0, 0, h_body * 0.55 - e]) cylinder(d1 = max(sc(60), 1.0), d2 = max(sc(320), 3), h = (max(sc(320), 3) - max(sc(60), 1.0)) / 2, $fn = 24);
        }
    }
}

// =====================================================================
//  KASSENHÄUSCHEN (Wandsystem wie Babyflug-Kassenwagen, Tür hinten)
// =====================================================================
module ring_2d() difference() {
    offset(delta = spiel) square([W_k, D_k]);
    translate([t_wk, t_wk]) offset(delta = -spiel) square([W_k - 2 * t_wk, D_k - 2 * t_wk]);
}
module kasse_boden() difference() {
    translate([-m_k, -m_k, 0]) cube([W_k + 2 * m_k, D_k + 2 * m_k, t_fk]);
    translate([0, 0, t_fk - g_k]) linear_extrude(g_k + 1) ring_2d();
}
function wlen(k) = (k == "vorne" || k == "hinten") ? W_k : LS_k;
function openings(k) = k == "vorne" ? [[wx0, v_s, wx1, v_t]] : (k == "links" || k == "rechts") ? [[fu0, fv0, fu0 + fw_k, fv0 + fh_k]] : [];
module raised(u0, v0, u1, v1, h = dm) translate([u0, v0, t_wk - e]) cube([u1 - u0, v1 - v0, h + e]);
module wand_local(k, fp = "alle") {
    L = wlen(k);
    if (inc(fp, "A")) difference() {
        union() {
            cube([L, H_k, t_wk]);
            translate([0, -(g_k - spiel), 0]) cube([L, g_k - spiel + e, t_wk]);
            translate([0, H_k - e, 0]) cube([L, g_k - spiel + e, t_wk]);
        }
        for (o = openings(k)) translate([o[0], o[1], -1]) cube([o[2] - o[0], o[3] - o[1], t_wk + 2]);
        if (k == "hinten") {
            fg = max(sc(25), 0.4); fd = max(min(0.6, t_wk * 0.35), 0.3);
            translate([0, 0, t_wk - fd]) difference() {
                translate([du0 - fg, -1, 0]) cube([dw_k + 2 * fg, dh_k + fg + 1, fd + 1]);
                translate([du0, -2, -1]) cube([dw_k, dh_k + 2, fd + 3]);
            }
        }
    }
    if (inc(fp, "B")) {
        raised(0, 0, L, fw2); raised(0, H_k - fw2, L, H_k);
        if (k == "vorne" || k == "hinten") { raised(0, 0, fw2 * 1.3, H_k); raised(L - fw2 * 1.3, 0, L, H_k); }
        for (o = openings(k)) {
            raised(o[0] - fwid, o[1] - fwid, o[0], o[3] + fwid); raised(o[2], o[1] - fwid, o[2] + fwid, o[3] + fwid);
            raised(o[0], o[3], o[2], o[3] + fwid);
            if (k == "vorne") translate([o[0] - fwid, o[1] - max(sc(60), 1.2), t_wk - e]) cube([o[2] - o[0] + 2 * fwid, max(sc(60), 1.2), c_out + e]);
            else raised(o[0], o[1] - fwid, o[2], o[1]);
        }
        if (k == "hinten") raised(du0 + dw_k - sc(150, 1.0), sc(1050), du0 + dw_k - sc(150, 1.0) + sc(40, 0.6), sc(1050) + sc(160, 1.4), dm * 2.5);
    }
    if (inc(fp, "C")) translate([0, 0, t_wk - e]) linear_extrude(dm + e) {
        if (k == "vorne") let(av = H_k - fw2 - (v_t + fwid), ts = av * 0.6) if (ts >= 1.5)
            translate([W_k / 2, v_t + fwid + av / 2]) resize([min(ww_k, 5 * ts * 0.75), 0]) text("KASSE", size = ts, font = schrift, halign = "center", valign = "center");
        if (k == "links" || k == "rechts") translate([L / 2, fv0 * 0.5]) stern(min(fv0 * 0.25, L * 0.2));
        if (k == "vorne") for (u = [wx0 / 2, W_k - wx0 / 2]) translate([u, H_k * 0.45]) stern(min(wx0 * 0.32, sc(220)));
    }
}
module wand_welt(k, fp = "alle") {
    if (k == "vorne")       translate([0, t_wk, t_fk]) rotate([90, 0, 0]) wand_local(k, fp);
    else if (k == "hinten") translate([W_k, D_k - t_wk, t_fk]) rotate([90, 0, 180]) wand_local(k, fp);
    else if (k == "links")  translate([t_wk, D_k - t_wk, t_fk]) rotate([90, 0, -90]) wand_local(k, fp);
    else                    translate([W_k - t_wk, t_wk, t_fk]) rotate([90, 0, 90]) wand_local(k, fp);
}
module wand_druck(k, fp) translate([0, g_k, 0]) wand_local(k, fp);
z_rk = t_fk + H_k;
ys_k = t_wk + spiel + 0.8 + st_k / 2;
module kasse_dach() difference() {
    union() {
        translate([-ov_k, -ov_k, z_rk]) cube([RXk, RYk, t_rk]);
        hull() {
            translate([-ov_k, -ov_k, z_rk + t_rk - e]) cube([RXk, RYk, e]);
            translate([W_k / 2 - RXk * 0.15, D_k / 2 - RYk * 0.15, z_rk + t_rk + h_rf - e]) cube([RXk * 0.3, RYk * 0.3, e]);
        }
    }
    translate([0, 0, z_rk - e]) linear_extrude(g_k + e) ring_2d();
    // Das Schild steht vorne in einem Schlitz durch die Dachschräge (sonst steckt seine Unterkante in der Schräge)
    translate([W_k / 2 - sw_k / 2 - spiel, ys_k - st_k / 2 - s_te - spiel, z_rk + t_rk - e]) cube([sw_k + 2 * spiel, st_k + s_te + 2 * spiel, h_rf + 1]);   // inkl. Relief vorne
    for (x = spx_k) translate([W_k / 2 - sw_k / 2 + x - pw_k / 2 - spiel, ys_k - st_k / 2 - spiel, z_rk + t_rk - pl_k])
        cube([pw_k + 2 * spiel, st_k + 2 * spiel, pl_k + h_rf + 1]);
}
module kasse_dach_druck() translate([ov_k, ov_k, -z_rk]) kasse_dach();
module schild_local(fp) {
    s_ts = min(sh_k * 0.55, (sw_k - 4 * s_bd) / max(1, len(kasse_schild_text) * 0.8));
    if (inc(fp, "A")) {
        cube([sw_k, sh_k, st_k]);
        for (x = spx_k) translate([x - pw_k / 2, -pl_k, 0]) cube([pw_k, pl_k + e, st_k]);
    }
    if (inc(fp, "B")) translate([0, 0, st_k - e]) {
        linear_extrude(s_te + e) difference() { square([sw_k, sh_k]); translate([s_bd, s_bd]) square([sw_k - 2 * s_bd, sh_k - 2 * s_bd]); }
        linear_extrude(s_te + e) translate([sw_k / 2, sh_k / 2]) resize([min(sw_k - 4 * s_bd, len(kasse_schild_text) * s_ts * 0.72), 0])
            text(kasse_schild_text, size = s_ts, font = schrift, halign = "center", valign = "center");
    }
}
// Schild steht auf der vorderen Dachkante; die Zapfen reichen in die Schlitze
module schild_welt(fp) translate([W_k / 2 - sw_k / 2, ys_k + st_k / 2, z_rk + t_rk + pl_k - pl_k]) rotate([90, 0, 0]) schild_local(fp);
module kasse(ex = 0) {
    color(fhex(farbe_kasse_boden)) kasse_boden();
    for (k = ["vorne", "hinten", "links", "rechts"]) translate([0, 0, ex]) {
        color(fhex(farbe_kasse_wand)) render() wand_welt(k, "A"); color(fhex(farbe_kasse_rahmen)) render() wand_welt(k, "B"); color(fhex(farbe_kasse_dekor)) render() wand_welt(k, "C");
    }
    translate([0, 0, 2 * ex]) color(fhex(farbe_kasse_dach)) kasse_dach();
    translate([0, 0, 3 * ex]) { color(fhex(farbe_schild_A)) schild_welt("A"); color(fhex(farbe_schild_B)) schild_welt("B"); }
}

// =====================================================================
//  GREIFAUTOMAT (Welt-lokal: x Breite, y Tiefe, Front y = 0)
// =====================================================================
module greifer_unten(fp = "alle") {
    sl = g_h1 * 0.2;   // schräges Bedienpult
    module koerper() hull() {
        cube([g_w, g_d, g_h1 - sl]);
        translate([0, g_d * 0.3, 0]) cube([g_w, g_d * 0.7, g_h1]);
    }
    module joy() translate([g_w * 0.35, g_d * 0.15, g_h1 - sl * 0.5 - 0.2]) {
        cylinder(d = max(sc(40), 0.8), h = sc(150, 1.6), $fn = 10);
        let(r = max(sc(80), 1.4) / 2) hull() { translate([0, 0, sc(150, 1.6)]) sphere(r = r, $fn = 12); translate([0, 0, sc(150, 1.6) - r * 1.41]) cylinder(d = max(sc(40), 0.8), h = e, $fn = 10); }
    }
    module knopf() translate([g_w * 0.65, g_d * 0.15, g_h1 - sl * 0.5 - 0.2]) cylinder(d = max(sc(80), 1.4), h = sc(60, 0.7), $fn = 12);
    module preise() intersection() {
        for (i = [0 : 11]) let(x = g_w * (0.2 + 0.6 * ((i * 37) % 11) / 10), y = g_d * (0.45 + 0.4 * ((i * 53) % 7) / 6))
            translate([x, y, g_h1]) sphere(r = g_w * (0.09 + 0.04 * (i % 3)), $fn = 16);
        translate([w_gp + spiel + 1.0, g_y0 + w_gp + spiel + 1.0, g_h1]) cube([g_w - 2 * (w_gp + spiel + 1.0), g_dh - 2 * (w_gp + spiel + 1.0), g_h2]);
    }
    if (inc(fp, "A")) difference() {
        union() {
            koerper();
            // Lippe für die Haube
            translate([w_gp + spiel, g_y0 + w_gp + spiel, g_h1 - e]) difference() {
                cube([g_w - 2 * (w_gp + spiel), g_dh - 2 * (w_gp + spiel), h_lip]);
                translate([0.8, 0.8, -1]) cube([g_w - 2 * (w_gp + spiel) - 1.6, g_dh - 2 * (w_gp + spiel) - 1.6, h_lip + 2]);
            }
        }
        // Ausgabeschacht
        translate([g_w * 0.3, -e, g_h1 * 0.15]) cube([g_w * 0.4, max(sc(120), 1.0), g_h1 * 0.22]);
        translate([g_w * 0.8, -e, g_h1 * 0.5]) cube([max(sc(25), 0.4), max(sc(30), 0.5), g_h1 * 0.08]);
    }
    if (inc(fp, "B")) { joy(); knopf(); }
    if (inc(fp, "C")) preise();
}
module greifer_haube(fp = "alle") {   // Welt: z = 0 auf dem Unterschrank; gedruckt kopfüber
    module rahmen() {
        for (x = [0, g_w - w_gp], y = [0, g_dh - w_gp]) translate([x, y, 0]) cube([w_gp, w_gp, g_h2]);
        translate([0, 0, g_h2 - e]) cube([g_w, g_dh, g_h3 + e]);
        difference() { cube([g_w, g_dh, max(sc(60), 1.0)]); translate([w_gp, w_gp, -1]) cube([g_w - 2 * w_gp, g_dh - 2 * w_gp, 5]); }
    }
    module glas() difference() {
        cube([g_w, g_dh, g_h2]);
        translate([t_gl, t_gl, -1]) cube([g_w - 2 * t_gl, g_dh - 2 * t_gl, g_h2 + 2]);
    }
    if (inc(fp, "A")) rahmen();
    if (inc(fp, "B")) difference() { glas(); rahmen(); }
    if (inc(fp, "C")) translate([g_w * 0.55, g_dh * 0.55, g_h2 * 0.45]) {   // Greifer
        cylinder(d = max(sc(30), 0.8), h = g_h2 * 0.55 + e, $fn = 10);
        translate([0, 0, -g_w * 0.12]) cylinder(d1 = g_w * 0.24, d2 = max(sc(30), 0.8), h = g_w * 0.12 + e, $fn = 16);   // Greifer öffnet nach unten
    }
}

// =====================================================================
//  BOX-AUTOMAT (Welt-lokal: Front y = 0; gedruckt auf dem Rücken)
// =====================================================================
module boxer(fp = "alle") {
    zb = b_h1 * 0.78;
    module koerper() {
        translate([(b_w2 - b_w) / 2, 0, 0]) cube([b_w, b_d, b_h1]);
        translate([(b_w2 - b_w) / 2 - sc(60, 0.6), b_d * 0.2, 0]) cube([b_w + sc(120, 1.2), b_d * 0.8, sc(150, 1.5)]);   // Sockel
        translate([0, b_d - b_t2, b_h1 - e]) hull() {
            cube([b_w2, b_t2, b_h2 * 0.7]);
            translate([b_w2 / 2, 0, b_h2 * 0.55]) rotate([-90, 0, 0]) cylinder(r = b_w2 / 2, h = b_t2, $fn = 48);
        }
        // Arm
        translate([b_w2 / 2 - b_arm / 2, -sc(450, 4), zb - b_arm / 2]) cube([b_arm, sc(450, 4) + e, b_arm]);
    }
    module anzeige() translate([b_w2 / 2, b_d - b_t2 + e, b_h1 + b_h2 * 0.55]) rotate([90, 0, 0]) linear_extrude(dm * 1.5 + e) {
        difference() { circle(r = b_w2 * 0.36, $fn = 48); circle(r = b_w2 * 0.30, $fn = 48); }
        rotate(40) translate([-0.3, 0]) square([0.6, b_w2 * 0.33]);   // Zeiger reicht bis in den Ring
    }
    module lichter() translate([0, b_d - b_t2 + e, b_h1]) rotate([90, 0, 0]) linear_extrude(dm * 1.5 + e)
        translate([b_w2 / 2, b_h2 * 0.55]) {
            for (a = [10 : 20 : 170]) translate(pol(b_w2 * 0.45, a)) circle(d = d_bulb, $fn = 10);
            for (a = [10 : 5 : 165]) bar(pol(b_w2 * 0.45, a), pol(b_w2 * 0.45, a + 5), max(d_bulb * 0.35, 0.5));   // Leitung
            for (a = [10, 170]) bar(pol(b_w2 * 0.33, a), pol(b_w2 * 0.45, a), max(d_bulb * 0.35, 0.5));          // Speichen zur Anzeige
        }
    module ball() translate([b_w2 / 2, -sc(450, 4), zb]) {
        hull() { rotate([90, 0, 0]) cylinder(d = b_arm, h = e, $fn = 12); translate([0, -b_ball, 0]) sphere(d = b_ball, $fn = 24); }
    }
    if (inc(fp, "A")) difference() { koerper(); translate([b_w2 / 2 - b_w * 0.2, -e, b_h1 * 0.35]) cube([b_w * 0.4, max(sc(30), 0.5), max(sc(25), 0.4)]); }
    if (inc(fp, "B")) { anzeige(); lichter(); }
    if (inc(fp, "C")) ball();
}
module boxer_druck(fp) translate([0, 0, b_d]) rotate([-90, 0, 0]) boxer(fp);

// =====================================================================
//  WOHNWAGEN (lokal: x Länge, Front +x, y = 0..B_ww, z hoch; gedruckt auf der Seite)
// =====================================================================
module ww_profil() polygon([[0, z_sk], [L_ww, z_sk], [L_ww, H_ww - sc(400, 3)], [L_ww - sc(400, 3), H_ww], [sc(150, 1), H_ww], [0, H_ww - sc(150, 1)]]);
module fase_box(L, B, z0, z1) hull() {   // Querschnitt mit Fasen an den Längskanten
    translate([0, ch_w, z0]) cube([L, B - 2 * ch_w, z1 - z0]);
    translate([0, 0, z0 + ch_w]) cube([L, B, z1 - z0 - 2 * ch_w]);
}
module raeder(xs, r, B, zmax) for (x = xs) intersection() {
    translate([x, 0, r]) rotate([-90, 0, 0]) cylinder(r = r, h = B, $fn = 40);
    translate([x - r - 1, -1, -1]) cube([2 * r + 2, B + 2, zmax + 1]);
}
module trommel(xs, r, B, zmax) for (x = xs) intersection() {   // Füllung zwischen den Rädern (stützfrei)
    translate([x, t_wh - e, r]) rotate([-90, 0, 0]) cylinder(r = r - min(sc(80), 1.0), h = B - 2 * t_wh + 2 * e, $fn = 40);
    translate([x - r - 1, -1, -1]) cube([2 * r + 2, B + 2, zmax + 1]);
}
WW_FENSTER = [[sc(800), sc(1500), sc(1600), sc(2600)], [sc(3800), sc(1500), sc(5000), sc(2600)], [sc(5800), sc(1500), sc(6900), sc(2600)]];
WW_TUER = [sc(2300), z_sk + sc(150), sc(3100), sc(2900)];
module ww_fenster_2d() for (f = WW_FENSTER) translate([f[0], f[1]]) square([f[2] - f[0], f[3] - f[1]]);
module wohnwagen(fp = "alle") {
    xs = [L_ww * 0.45, L_ww * 0.45 + 2.1 * r_wh];
    module inlay(d) { for (side = [0, 1]) translate([0, side == 0 ? -e : B_ww - d, 0]) rotate([90, 0, 0]) mirror([0, 0, 1]) linear_extrude(d + e) children(); }
    module koerper() {
        intersection() { rotate([90, 0, 0]) mirror([0, 0, 1]) linear_extrude(B_ww) ww_profil(); fase_box(L_ww, B_ww, z_sk - 1, H_ww + 1); }
        raeder(xs, r_wh, B_ww, z_sk + e); trommel(xs, r_wh, B_ww, z_sk + e);
    }
    if (inc(fp, "A")) difference() {
        koerper();
        inlay(d_inl) { ww_fenster_2d(); translate([0, sc(1150)]) square([L_ww, max(sc(120), 1.0)]); }
        // Tür (Gravur, eine Seite) + Fenster in der Tür
        translate([0, -e, 0]) rotate([90, 0, 0]) mirror([0, 0, 1]) linear_extrude(dmr + e) difference() {
            translate([WW_TUER[0] - max(sc(25), 0.4), WW_TUER[1]]) square([WW_TUER[2] - WW_TUER[0] + 2 * max(sc(25), 0.4), WW_TUER[3] - WW_TUER[1] + max(sc(25), 0.4)]);
            translate([WW_TUER[0], WW_TUER[1] - 1]) square([WW_TUER[2] - WW_TUER[0], WW_TUER[3] - WW_TUER[1] + 1]);
        }
        // Deichsel-Schlitz vorne
        translate([L_ww - d_slot, B_ww / 2 - w_db * 0.4 - spiel, z_db - spiel]) cube([d_slot + 1, w_db * 0.8 + 2 * spiel, t_db + 2 * spiel]);
        // Fenster vorne
        translate([L_ww - d_inl, B_ww * 0.2, sc(1600)]) cube([d_inl + 1, B_ww * 0.6, sc(800)]);
        for (x = xs) translate([x - r_wh - 1, -1, -1]) cube([2 * r_wh + 2, B_ww + 2, z_sk + e]);
    }
    if (inc(fp, "B")) {
        intersection() { koerper(); inlay(d_inl) ww_fenster_2d(); }
        intersection() { koerper(); translate([L_ww - d_inl, B_ww * 0.2, sc(1600)]) cube([d_inl + 1, B_ww * 0.6, sc(800)]); }
    }
    if (inc(fp, "C")) intersection() { koerper(); inlay(d_inl) translate([0, sc(1150)]) square([L_ww, max(sc(120), 1.0)]); }
    if (inc(fp, "D")) intersection() { koerper(); for (x = xs) translate([x - r_wh - 1, -1, -1]) cube([2 * r_wh + 2, B_ww + 2, z_sk + e]); }
}
module wohnwagen_druck(fp) translate([0, H_ww, 0]) rotate([90, 0, 0]) wohnwagen(fp);

// Deichsel (Welt: Unterkante z_db; gedruckt kopfüber, Zapfen nach oben)
module deichsel_2d() {
    tab = d_slot - 0.5;
    translate([-tab, -w_db * 0.4]) square([tab + e, w_db * 0.8]);
    hull() { translate([0, -w_db / 2]) square([e, w_db]); translate([L_db - sc(150, 1.5), 0]) circle(d = max(sc(300), 3), $fn = 24); }
}
module deichsel_rohr_2d() difference() { deichsel_2d(); offset(delta = -max(sc(100), 1.2)) hull() { translate([sc(100), -w_db / 2]) square([e, w_db]); translate([L_db - sc(400, 3), 0]) circle(d = e); } }
module deichsel() {
    linear_extrude(t_db) union() { deichsel_rohr_2d(); translate([-d_slot + 0.5, -w_db * 0.4]) square([d_slot, w_db * 0.8]); }
    translate([L_db - sc(150, 1.5), 0, -h_pin]) cylinder(d = d_pin, h = h_pin + e, $fn = 16);
}
module deichsel_druck() translate([d_slot, w_db / 2, t_db]) rotate([180, 0, 0]) deichsel();

// =====================================================================
//  PACKWAGEN (LKW mit Kofferaufbau; lokal wie Wohnwagen, Front +x)
// =====================================================================
x_cpl = -max(sc(400), max(sc(300), 3) + 1.2);    // Kupplung hinten
module lk_profil() union() {
    translate([0, z_lks]) square([L_lk, sc(1000, 8) - z_lks]);                     // Fahrgestell-Schürze
    translate([0, sc(1000, 8) - e]) square([x_box, H_box - sc(1000, 8)]);            // Koffer
    translate([x_cab0, 0]) polygon([[0, sc(900, 7)], [L_lk - x_cab0, sc(900, 7)], [L_lk - x_cab0, H_cab - sc(250, 2)], [L_lk - x_cab0 - sc(250, 2), H_cab], [0, H_cab]]);
    translate([x_cpl, z_lks]) square([-x_cpl + e, z_db - z_lks]);                   // Kupplungsträger
}
module packwagen(fp = "alle") {
    xs = [sc(1400, 11), L_lk - sc(1000, 8)];
    module koerper() {
        intersection() { rotate([90, 0, 0]) mirror([0, 0, 1]) linear_extrude(B_lk) lk_profil(); translate([x_cpl - 1, 0, 0]) fase_box(L_lk - x_cpl + 2, B_lk, z_lks - 1, H_box + 1); }
        raeder(xs, r_lk, B_lk, z_lks + e); trommel(xs, r_lk, B_lk, z_lks + e);
    }
    module inlay(d) { for (side = [0, 1]) translate([0, side == 0 ? -e : B_lk - d, 0]) rotate([90, 0, 0]) mirror([0, 0, 1]) linear_extrude(d + e) children(); }
    module fenster_s() translate([L_lk - sc(1500, 11), sc(2000, 15)]) square([sc(1100, 8), H_cab - sc(2000, 15) - sc(250, 2)]);
    module schrift_s() let(ts = (H_box - sc(1000, 8)) * 0.22)
        translate([x_box / 2, sc(1000) + (H_box - sc(1000)) * 0.55]) resize([x_box * 0.85, 0]) text(packwagen_text, size = ts, font = schrift, halign = "center", valign = "center");
    module schrift_beide() {   // Seite y = B gespiegelt, damit lesbar
        translate([0, -e, 0]) rotate([90, 0, 0]) mirror([0, 0, 1]) linear_extrude(dmr + e) schrift_s();
        translate([0, B_lk - dmr, 0]) rotate([90, 0, 0]) mirror([0, 0, 1]) linear_extrude(dmr + e) translate([x_box, 0]) mirror([1, 0]) schrift_s();
    }
    module streifen_s() translate([0, sc(1000) + (H_box - sc(1000)) * 0.2]) square([x_box, max(sc(150), 1.0)]);
    module front_glas() translate([L_lk - d_inl, B_lk * 0.08, sc(2000, 15)]) cube([d_inl + 1, B_lk * 0.84, H_cab - sc(2000, 15) - sc(350, 2.8)]);
    module lampen() for (y = [B_lk * 0.15, B_lk * 0.85 - sc(350, 2.5)]) translate([L_lk - d_inl, y, sc(1100, 8)]) cube([d_inl + 1, sc(350, 2.5), sc(200, 1.6)]);
    if (inc(fp, "A")) difference() {
        koerper();
        inlay(d_inl) { fenster_s(); streifen_s(); }
        schrift_beide();
        front_glas(); lampen();
        // Kühlergrill
        for (z = [sc(1300, 10) : sc(150, 1.2) : sc(1800, 14)]) translate([L_lk - dmr, B_lk * 0.3, z]) cube([dmr + 1, B_lk * 0.4, max(sc(40), 0.4)]);
        // Kupplungsloch
        translate([x_cpl / 2, B_lk / 2, z_db - h_pin - 0.5]) linear_extrude(h_pin + 1) rotate(90) teardrop(d_pin / 2 + spiel);   // Spitze zeigt im Druck nach oben
        // Kofferfugen
        for (x = [x_box / 4 : x_box / 4 : x_box - 1]) for (side = [0, 1]) translate([x, side == 0 ? -e : B_lk - dmr, sc(1000)]) cube([max(sc(25), 0.4), dmr + e, H_box - sc(1000) - 1]);
        for (x = xs) translate([x - r_lk - 1, -1, -1]) cube([2 * r_lk + 2, B_lk + 2, z_lks + e]);
    }
    if (inc(fp, "B")) intersection() { koerper(); union() { inlay(d_inl) fenster_s(); front_glas(); } }
    if (inc(fp, "C")) intersection() { koerper(); union() { inlay(d_inl) streifen_s(); schrift_beide(); lampen(); } }
    if (inc(fp, "D")) intersection() { koerper(); for (x = xs) translate([x - r_lk - 1, -1, -1]) cube([2 * r_lk + 2, B_lk + 2, z_lks + e]); }
}
module packwagen_druck(fp) translate([-x_cpl, H_box, 0]) rotate([90, 0, 0]) packwagen(fp);

// =====================================================================
//  ZUSAMMENBAU
// =====================================================================
function wagen_pos(i) = let(n = wagen_anzahl, cols = ceil(n / 3), ix = i % cols, iy = floor(i / cols),
    fx = FX0 + (FX1 - FX0) * (ix + 0.5) / cols, fy = FY0 + (FY1 - FY0) * (iy + 0.5) / 3)
    [fx + ((i * 37) % 7 - 3) * L_c * 0.06, fy + ((i * 53) % 5 - 2) * W_c * 0.06, [15, 165, 200, 340, 30, 190, 350, 150, 10, 205, 335, 170][i % 12]];
function wfarbe(i) = (i + floor(i / ceil(wagen_anzahl / 3))) % 4;
module wagen_welt(i, ex = 0) let(p = wagen_pos(i)) translate([p[0], p[1], H_p + ex]) rotate(p[2]) {
    color(fhex(WF[wfarbe(i)])) render() wagen("A"); color(fhex(farbe_gummi)) render() wagen("B"); color(fhex(farbe_sitz)) render() wagen("C");
    color("#e8e2d0") translate([-L_c * 0.36, 0, h_tw - d_ph]) cylinder(d = stift_d, h = L_stange, $fn = 12);
}
module autoscooter(ex = 0) {
    color(fhex(farbe_podest)) render() podest_welt("A"); color(fhex(farbe_umgang)) render() podest_welt("B");
    for (i = [0, 1]) color(fhex(farbe_umgang)) translate([0, -ex * 0.6, 0]) treppe_welt(i);
    for (b = BANDEN) translate([0, 0, ex * 0.4]) { color(fhex(farbe_bande_1)) bande_welt(b, "A"); color(fhex(farbe_bande_2)) bande_welt(b, "B"); }
    for (c = SAEULEN) translate([c[0], c[1], H_p - h_pg + ex]) { color(fhex(farbe_saeule)) render() saeule("A"); color(fhex(farbe_licht)) saeule("B"); }
    translate([0, 0, 2 * ex]) { color(fhex(farbe_dach)) render() dach_welt("A"); color(fhex(farbe_dachrand)) dach_welt("B"); color(fhex(farbe_licht)) dach_welt("C"); }
    translate([0, 0, 3 * ex]) { color(fhex(farbe_front_A)) render() prunkfront_welt("A"); color(fhex(farbe_front_B)) prunkfront_welt("B");
        color(fhex(farbe_front_C)) prunkfront_welt("C"); color(fhex(farbe_front_D)) prunkfront_welt("D"); }
    for (i = [0 : wagen_anzahl - 1]) wagen_welt(i, ex * 0.5);
    translate([KX, KY, H_p + ex * 0.3]) kasse(ex * 0.4);
    translate([GRX, GRY, H_p + ex * 0.3]) {
        color(fhex(farbe_automat)) greifer_unten("A"); color(fhex(farbe_automat_2)) greifer_unten("B"); color(fhex(farbe_preise)) greifer_unten("C");
        translate([0, g_y0, g_h1 + ex * 0.3]) { color(fhex(farbe_automat)) greifer_haube("A"); color(fhex(farbe_glas), 0.55) greifer_haube("B"); color(fhex(farbe_saeule)) greifer_haube("C"); }
    }
    translate([BXX, BXY, H_p + ex * 0.3]) { color(fhex(farbe_boxer)) boxer("A"); color(fhex(farbe_licht)) boxer("B"); color(fhex(farbe_automat_2)) boxer("C"); }
}
module gespann(ex = 0) {
    color(fhex(farbe_wohnwagen)) render() wohnwagen("A"); color(fhex(farbe_fenster)) render() wohnwagen("B");
    color(fhex(farbe_zierstreifen)) render() wohnwagen("C"); color(fhex(farbe_fahrgestell)) render() wohnwagen("D");
    color(fhex(farbe_fahrgestell)) translate([L_ww, B_ww / 2, z_db + ex]) deichsel();
    translate([L_ww + L_db - sc(150, 1.5) - x_cpl / 2 + ex * 2, B_ww / 2 - B_lk / 2, 0]) {
        color(fhex(farbe_packwagen)) render() packwagen("A"); color(fhex(farbe_fenster)) render() packwagen("B");
        color(fhex(farbe_zierstreifen)) render() packwagen("C"); color(fhex(farbe_fahrgestell)) render() packwagen("D");
    }
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFOS = [["podest", info_podest(), 1], ["dach", info_dach(), 1], ["prunkfront", info_pf(), 1]];
CLIPS = lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
cpp = floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3));
function np_of(n) = [for (i = INFOS) if (i[0] == n) n_pieces(i[1])][0];

echo(str("Autoscooter 1:", den, " | Podest ", r2(W), " x ", r2(D), " mm | Höhe bis Dach ", r2(z_rb + t_d), " mm, mit Prunkfront ", r2(z_rb + t_d + h_cr),
         " mm | Wagen ", r2(L_c), " x ", r2(W_c), " mm"));
echo(str("Filament-Stangen Ø ", stift_d, ": ", wagen_anzahl, " Stück à ", r2(L_stange), " mm (Stange endet 0,6 mm unter dem Dach)"));
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
echo(str("Verbinder-Clips gesamt: ", CLIPS));
for (b = BANDEN) if (b[3] > usable) echo(str("WARNUNG: ", b[0], " länger als das Druckbett"));
if (L_ww > usable || L_lk - x_cpl > usable) echo("WARNUNG: Fahrzeug länger als das Druckbett");

druck("podest", np_of("podest"), "A", farbe_podest, 1); druck("podest", np_of("podest"), "B", farbe_umgang, 1);
druck("treppe", 1, "alle", farbe_umgang, 2);
for (n = ["bande_seite", "bande_hinten", "bande_vorne_aussen", "bande_vorne_mitte"])
    for (fp = [["A", farbe_bande_1], ["B", farbe_bande_2]]) druck(n, 1, fp[0], fp[1], len([for (b = BANDEN) if (b[0] == n) 1]));
druck("saeule", 1, "A", farbe_saeule, len(SAEULEN)); druck("saeule", 1, "B", farbe_licht, len(SAEULEN));
for (fp = [["A", farbe_dach], ["B", farbe_dachrand], ["C", farbe_licht]]) druck("dach", np_of("dach"), fp[0], fp[1], 1);
for (fp = [["A", farbe_front_A], ["B", farbe_front_B], ["C", farbe_front_C], ["D", farbe_front_D]]) druck("prunkfront", np_of("prunkfront"), fp[0], fp[1], 1);
for (i = [0 : 3]) druck("wagen", 1, "A", WF[i], len([for (k = [0 : wagen_anzahl - 1]) if (wfarbe(k) == i) 1]));
druck("wagen", 1, "B", farbe_gummi, wagen_anzahl); druck("wagen", 1, "C", farbe_sitz, wagen_anzahl);
druck("kasse_boden", 1, "alle", farbe_kasse_boden, 1);
for (w = ["vorne", "hinten", "links", "rechts"], fp = [["A", farbe_kasse_wand], ["B", farbe_kasse_rahmen], ["C", farbe_kasse_dekor]]) druck(str("kasse_wand_", w), 1, fp[0], fp[1], 1);
druck("kasse_dach", 1, "alle", farbe_kasse_dach, 1);
druck("kasse_schild", 1, "A", farbe_schild_A, 1); druck("kasse_schild", 1, "B", farbe_schild_B, 1);
for (fp = [["A", farbe_automat], ["B", farbe_automat_2], ["C", farbe_preise]]) druck("greifer_unten", 1, fp[0], fp[1], 1);
for (fp = [["A", farbe_automat], ["B", farbe_glas], ["C", farbe_saeule]]) druck("greifer_haube", 1, fp[0], fp[1], 1);
for (fp = [["A", farbe_boxer], ["B", farbe_licht], ["C", farbe_automat_2]]) druck("boxer", 1, fp[0], fp[1], 1);
for (fp = [["A", farbe_wohnwagen], ["B", farbe_fenster], ["C", farbe_zierstreifen], ["D", farbe_fahrgestell]]) druck("wohnwagen", 1, fp[0], fp[1], 1);
druck("deichsel", 1, "alle", farbe_fahrgestell, 1);
for (fp = [["A", farbe_packwagen], ["B", farbe_fenster], ["C", farbe_zierstreifen], ["D", farbe_fahrgestell]]) druck("packwagen", 1, fp[0], fp[1], 1);
if (CLIPS > 0) druck("verbinder", ceil(CLIPS / cpp), "alle", farbe_clips, 1);
farben_echo();

if (teil == "aufbau") { autoscooter(); if (fahrzeuge_zeigen) translate([W * 0.08, D + sc(2500, 25), 0]) gespann(); }
else if (teil == "explosion") { autoscooter(max(sc(1500), 14)); if (fahrzeuge_zeigen) translate([W * 0.08, D + sc(3500, 35), 0]) gespann(max(sc(800), 8)); }
else if (teil == "podest") split_out(info_podest(), stueck) podest_welt(farbteil);
else if (teil == "treppe") treppe();
else if (teil == "bande_seite" || teil == "bande_hinten" || teil == "bande_vorne_aussen" || teil == "bande_vorne_mitte") translate([0, h_pg, 0]) bande(bande_len(teil), farbteil);
else if (teil == "saeule") saeule(farbteil);
else if (teil == "dach") split_out(info_dach(), stueck) dach_lokal(farbteil);
else if (teil == "prunkfront") split_out(info_pf(), stueck) prunkfront_druck(farbteil);
else if (teil == "wagen") wagen(farbteil);
else if (teil == "kasse_boden") translate([m_k, m_k, 0]) kasse_boden();
else if (teil == "kasse_wand_vorne") wand_druck("vorne", farbteil);
else if (teil == "kasse_wand_hinten") wand_druck("hinten", farbteil);
else if (teil == "kasse_wand_links") wand_druck("links", farbteil);
else if (teil == "kasse_wand_rechts") wand_druck("rechts", farbteil);
else if (teil == "kasse_dach") kasse_dach_druck();
else if (teil == "kasse_schild") translate([0, pl_k, 0]) schild_local(farbteil);
else if (teil == "greifer_unten") greifer_unten(farbteil);
else if (teil == "greifer_haube") translate([0, g_dh, g_h2 + g_h3]) rotate([180, 0, 0]) greifer_haube(farbteil);
else if (teil == "boxer") boxer_druck(farbteil);
else if (teil == "wohnwagen") wohnwagen_druck(farbteil);
else if (teil == "deichsel") deichsel_druck();
else if (teil == "packwagen") packwagen_druck(farbteil);
else if (teil == "verbinder") verbinder_platten(verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4), stueck);
