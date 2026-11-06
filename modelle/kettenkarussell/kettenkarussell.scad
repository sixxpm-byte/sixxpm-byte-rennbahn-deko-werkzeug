// =====================================================================
//  KETTENKARUSSELL mit VERKAUFSHÄUSCHEN  –  zerlegbarer Deko-Bausatz
//  parametrisch, alle gängigen Maßstäbe, FDM-optimiert (stützfrei),
//  Teile über dem Druckbett werden automatisch geteilt (Clips),
//  Stecksystem kompatibel zu rennbahn_deko.scad
//  Farben je Bauteil einstellbar (Vorschau, Dateinamen, 3MF-Export)
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    podest        Podestplatte (Vieleck) mit Dielen und Mastmanschette   1x
//    blende        Podestblende (steht in der Nut unter der Platte)      je Seite
//    mastfuss      Mastfuß unter dem Podest                              1x
//    mast          Mittelmast mit Lagerzapfen (bei Übergröße in Stücken) 1x
//    stern         Ausleger-Stern (dreht sich), Stiftlager an den Spitzen 1x
//    dach          Dachsegment (Pyramidenfläche) – Farbstreifen          1x je Sitz
//    volant        Volant (Behang) unter der Dachkante                   1x je Sitz
//    laterne       Laterne mit Spitze und Wimpel (2-farbig: farbteil A/B) 1x
//    sitz          Sitz (auf der Seite liegend gedruckt)                 1x je Sitz
//    kettenstange  Kette als Stange mit Lagerauge und Zapfen             2x je Sitz
//    treppe        Podesttreppe                                          je Treppe
//    haus_*        Verkaufshäuschen wie beim Riesenrad
//    verbinder     Clips für alle geteilten Teile
//
//  FARBTEILE
//    Der Wimpel jeder Laterne steckt mit einer Hülse auf dem Fahnenmast (einzeln
//    druckbar). Schild-Schrift ist ein Inlay: mit AMS/MMU oder die 3MF einfarbig.
//  BEWEGLICH
//    * Stern + Dach + Laterne drehen sich auf dem Lagerzapfen des Masts.
//    * Jeder Sitz pendelt an einem Stift (Filament) in der Auslegerspitze –
//      dreht man das Karussell schnell, fliegen die Sitze nach außen.
//
//  MONTAGE
//    1. Mastfuß hinstellen, Blenden in die Nut der Podestplatte stecken,
//       Platte (mit Clips zusammengesteckt) über den Mast auf Fuß + Blenden.
//    2. Mast durch die Manschette in den Fuß stecken.
//    3. Stern auf den Lagerzapfen setzen. Dachsegmente auf die Zapfen der
//       Ausleger setzen und untereinander verclipsen, Volants von unten in
//       die Nut der Dachkante drücken, Laterne aufsetzen.
//    4. Je Sitz zwei Kettenstangen mit dem Zapfen in den Sitz stecken,
//       Augen links und rechts an die Auslegerspitze halten und den Stift
//       (Filament Ø stift_d) quer durchschieben.
//
//  FARBEN: jede Gruppe hat einen Farbparameter. Die Konsole gibt pro Teil
//    eine Zeile "DRUCK|teil|stücke|farbteil|farbe|menge" aus – das Skript
//    farb_export.py erzeugt daraus STLs mit Farbnamen, eine Farbliste und
//    eine farbige 3MF (Bambu Studio / Orca übernehmen die Farben).
//    Farbeinstellungen bleiben als Parametersatz im Customizer gespeichert.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, podest:Podestplatte, blende:Podestblende, mastfuss:Mastfuß, mast:Mast, stern:Ausleger-Stern, dach:Dachsegment, volant:Volant, laterne:Laterne, sitz:Sitz, kettenstange:Kettenstange, treppe:Treppe, haus_boden:Kassenhaus Boden, haus_wand_vorne:Kassenhaus Wand vorne, haus_wand_hinten:Kassenhaus Wand hinten, haus_wand_links:Kassenhaus Wand links, haus_wand_rechts:Kassenhaus Wand rechts, haus_dach:Kassenhaus Dach, haus_schild:Kassenhaus Schild, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Mehrfarbige Teile (Laterne, Schild): A = Grundkörper, B = Wimpel/Schrift
farbteil = "alle"; // [alle, A, B]

/* [Vorschau] */
drehung = 10; // [0:360]
// Ausschwenken der Sitze (Fliehkraft)
schwenk = 0; // [0:50]
kassenhaus_zeigen = true;

/* [Kettenkarussell (Vorbild in Metern)] */
sitze = 16; // [8:1:32]
// Radius der Kettenaufhängung
ausleger_radius_m = 5.2;
ketten_laenge_m = 3.0;
// Sitzunterkante über dem Podest (in Ruhe)
sitz_hoehe_m = 0.6;
sitz_breite_m = 0.55;
mast_durchmesser_m = 0.9;
dach_hoehe_m = 2.4;
volant_hoehe_m = 0.6;
laterne_hoehe_m = 1.3;
podest_radius_m = 6.4;
podest_hoehe_m = 0.5;
treppen = 2; // [0:4]
// Kette: gedruckte Stange oder echte Kette (Stift durch den Sitz)
kette = "auto"; // [auto:automatisch, gedruckt:gedruckte Stange, echt:echte Kette]
lampen = true;

/* [Kassenhäuschen (Vorbild in Metern)] */
haus_breite_m = 2.2;
haus_tiefe_m  = 1.6;
haus_hoehe_m  = 2.3;
tuer = "links"; // [links, rechts]
schild_text = "KARUSSELL";
kasse_text  = "KASSE";
schild_font = "Liberation Sans:style=Bold";

/* [Farben] */
farbe_podest   = "holz";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_blende   = "rot";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_mastfuss = "grau";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_mast     = "weiss";  // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_stern    = "gold";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
// Dachstreifen abwechselnd
farbe_dach_1   = "rot";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_dach_2   = "weiss";  // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_volant_1 = "gelb";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_volant_2 = "blau";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_laterne  = "gold";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_wimpel   = "rot";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
// Sitze abwechselnd
farbe_sitz_1   = "blau";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_sitz_2   = "gelb";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_kette    = "silber"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_treppe   = "holz";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_haus_boden = "grau"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_haus_wand  = "creme";// [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_haus_dach  = "rot";  // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_schild_A   = "gelb"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_schild_B   = "rot";  // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]
farbe_clips      = "grau"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme]

/* [Druck & Passung] */
rennbahn_taschen = true;
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
// Luft je Seite für eingepresste Farbteile (Wimpel-Hülse; 0 = sehr stramm)
einsatz_spiel = 0.05;
// Stift für die Sitzlager (1.75 = Filament, ab 1:24 besser 3 mm Draht)
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

// Farbpalette (eigene Farben: "#rrggbb" direkt eintragen)
FARBEN = [["rot", "#c62828"], ["gelb", "#f9c80e"], ["blau", "#1e5bb8"], ["gruen", "#2e9d4f"], ["weiss", "#f4f4f4"],
          ["schwarz", "#222222"], ["grau", "#8a8f94"], ["silber", "#c0c4c8"], ["gold", "#d4a017"], ["orange", "#ef7d1a"],
          ["lila", "#7b3fa0"], ["rosa", "#f27fb2"], ["tuerkis", "#1fb5b0"], ["braun", "#7a4b2a"], ["holz", "#c19a6b"], ["creme", "#f3e3c3"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;
function alt(k, a, b) = k % 2 == 0 ? a : b;

// =====================================================================
//  Maße
// =====================================================================
n_s  = sitze;
al   = 360 / n_s;
PH   = [for (k = [0 : n_s - 1]) k * al];         // Ausleger-Winkel
R_p  = sc(ausleger_radius_m * 1000, 40);

// ---- Stift / Kettenstange / Sitz ----
pin_p  = stift_d + 0.15;                         // im Ausleger (Tropfenloch, stramm)
pin_e  = stift_d + 2 * stift_spiel;              // im Auge (lose)
hr_w   = max(sc(80), 2.0);                       // Stangenbreite
hr_t   = max(sc(60), 1.4);                       // Stangendicke
r_he   = pin_e / 2 + max(sc(60), 1.0);           // Auge
L_k    = sc(ketten_laenge_m * 1000, 12);
kette_echt = kette == "echt" || (kette == "auto" && L_k + 2 * r_he + 4 > usable);
W_st   = max(sc(sitz_breite_m * 1000), 5);
d_st   = max(sc(500), 4);                        // Sitztiefe (radial)
h_bk   = max(sc(650), 4);                        // Lehne über dem Sitzpunkt
t_sb   = max(sc(80), 1.2);
p_g    = max(sc(50), 1.2);                       // Zapfen der Stange
t_sp   = max(sc(110), p_g + 2 * spiel + 1.6, kette_echt ? pin_p + 1.6 : 0);   // Sitzfläche
p_d    = min(max(sc(80), 1.5), W_st / 2 - 0.8);  // Zapfentiefe
v_fr   = max(sc(420), 3);                        // Fußraste unter dem Sitzpunkt
l_fr   = max(sc(200), 1.5);
cl_r   = max(sc(20), 0.3);
w_tip  = W_st - 2 * cl_r;                        // Auslegerspitze zwischen den Stangen
l_tip  = max(pin_p + 2 * max(sc(50), 1.2), 2 * r_he - 1);

// ---- Podest ----
N_d   = n_s;
R_di  = max(sc(podest_radius_m * 1000), R_p + d_st / 2 + l_fr + 3);
R_dc  = R_di / cos(180 / N_d);
h_p   = sc(podest_hoehe_m * 1000, 5);
deck_split = 2 * R_dc > usable;
t_d   = max(sc(120), 2.4, deck_split ? clipd + 0.8 : 0);
h_f   = h_p - t_d;                               // Mastfuß-Höhe
t_bl  = max(sc(60), 1.4);                        // Blendendicke
i_bl  = max(sc(30), 0.6);                        // Einzug der Blende
g_bl  = min(t_d - 0.8, max(sc(60), 1.2));        // Nut unter der Platte
clr_s = sc(sitz_hoehe_m * 1000, 2);

// ---- Mast ----
d_m   = max(sc(mast_durchmesser_m * 1000), 8);   // Schlüsselweite Achteck
r_m8  = d_m / 2 / cos(22.5);
d_mb  = max(sc(120), 2.5);                       // Kabelkanal
d_j   = max(min(sc(350), d_m - 3), d_mb + 2.4);  // Lagerzapfen
w_col = max(sc(150), 2);
h_col = sc(400, 3);
z_m0  = 1.0;                                     // Mastunterkante im Fuß

// ---- Stern ----
t_a   = max(sc(250), 2 * (pin_p / 2 * sqrt(2) + 1.2));
z_piv = h_p + clr_s + v_fr + L_k;                // Drehpunkt der Sitze
z_a   = z_piv - t_a / 2;                         // Unterkante Stern = Mastschulter
w_a   = max(sc(220), 2.4);
w_rs  = max(sc(200), 2.0);
pgs   = max(sc(100), 1.6);                       // Steckzapfen (Dach, Laterne)

// ---- Dach ----
R_ri  = R_p - max(sc(400), r_he + 2.5);          // Dachkante (Inkreis)
R_rc  = R_ri / cos(al / 2);                      // Dachecken (Grate)
h_r   = sc(dach_hoehe_m * 1000, 8);
t_v   = max(sc(50), 1.2);                        // Volant
i_v   = max(sc(60), 1.0);
g_v   = max(sc(60), 1.2);
t_rb  = max(sc(100), 2.0, clipd + 0.4, g_v + 0.8);
z_rb  = z_a + t_a;                               // Dachunterseite
r_top = max(sc(650), d_j / 2 + 3 * pgs + 2);
r_hs  = r_top + max(sc(100), 2);                 // Sternnabe
R_k   = R_ri - i_v - t_v - w_rs / 2 - 1.5;       // äußerer Sternring
h_v   = max(sc(volant_hoehe_m * 1000), t_a + cl + 3);
L_v   = 2 * (R_ri - i_v) * tan(al / 2) - 2 * (t_v * tan(al / 2) + 0.4);
sr_v  = max(sc(120), 1.2);                       // Bogenradius am Volant
function th_roof(x) = t_rb + h_r * (1 - x / R_ri);

// ---- Laterne ----
r_lt  = r_top - cl;
h_lt  = sc(laterne_hoehe_m * 1000, 6);
H_in  = th_roof(r_top) + 0.5;
d_fp  = max(sc(80), 1.6);
h_pen = max(sc(500), 4);
t_pen = max(sc(40), 1.0);
d_fs  = d_fp + 2 * einsatz_spiel + 2 * max(sc(25), 0.6);   // Fahnenmast unten = Außenmaß der Wimpel-Hülse
h_pole = max(sc(900), 8);

// ---- Mastfuß, Treppen ----
r_fh  = r_m8 + max(sc(200), 3);
r_f   = min(0.45 * R_di, usable / 2 - 2);
w_f   = max(sc(500), 5);
n_tr  = max(2, round(h_p / max(sc(180), 1.5)));
td_tr = max(sc(280), 2);
w_tr  = max(sc(1200), 10);
TR_ANG = [for (i = [0 : 1 : treppen - 1]) round(i * n_s / max(1, treppen)) * al];

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
h_rf = sc(700, 4);
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


// =====================================================================
//  AUSLEGER-STERN – polare Teilung (Nabe + Ringsegmente)
//  Kreisnähte kreuzen nur Ausleger, radiale Nähte liegen zwischen den
//  Auslegern und kreuzen nur einen Ring – dort Stoßbleche + Clips
// =====================================================================
pws  = max(w_a, 2 * mw + 0.5);
pr_s = max(w_rs, 2 * mw + 0.5);
R_tip  = R_p + l_tip / 2;
Rmax_s = sqrt(pow(R_tip, 2) + pow(w_tip / 2, 2));
st_split = 2 * Rmax_s + 1 > usable;
R_cs   = min(usable / 2 - spw / 2 - 1, R_k - pr_s / 2 - spw / 2 - 1);
b_top_s = max(R_cs, min(R_k - pr_s / 2 - spw / 2 - 1, Rmax_s - usable * 0.8));
n_mid_s = (st_split && b_top_s > R_cs + 1) ? ceil((b_top_s - R_cs) / (usable * 0.75)) : 0;
dmid_s  = n_mid_s > 0 ? (b_top_s - R_cs) / n_mid_s : 0;
// Band = [innen, außen, Ringradius, äußerstes Band?]
SB = st_split ? concat([for (i = [0 : 1 : n_mid_s - 1]) [R_cs + i * dmid_s, R_cs + (i + 1) * dmid_s, R_cs + (i + 0.5) * dmid_s, 0]],
                       [[b_top_s, Rmax_s + 0.5, R_k, 1]]) : [];
ZRS = concat([R_k], [for (b = SB) if (b[3] == 0) b[2]],
             st_split ? ((R_cs - r_hs) / 2 > spw / 2 + w_rs + 1 && R_cs - r_hs > 8 * w_rs ? [(r_hs + R_cs) / 2] : [])
                      : (R_k - r_hs > 8 * w_rs ? [(r_hs + R_k) / 2] : []));

function near_arm(a, d) = min([for (t = PH) adiff(a, t)]) < d;
function nudge(t, d, k = 0) = k > 2000 ? t :
    let(v = t + (k % 2 == 0 ? 1 : -1) * floor((k + 1) / 2) * 0.25)
    !near_arm(v, d) ? v : nudge(t, d, k + 1);
function dlt(b) = max(deg((spw / 2 + w_a / 2 + 1) / b[0]), b[3] == 1 ? deg((w_tip / 2 + 1) / R_p) : 0);
function reg(n) = n_s % n == 0 || n % n_s == 0;
function seam_list(b, bi, n) = let(
    base  = n >= n_s ? 180 / n : al / 2,
    shift = reg(n) ? (n < n_s ? (bi % 2) * floor(n_s / n / 2) * al : 0) : (bi % 2) * 180 / n)
    qsort([for (j = [0 : n - 1]) nudge(base + shift + j * 360 / n, dlt(b))]);
function pieces_of(b, ss) = let(n = len(ss)) [for (j = [0 : n - 1]) [b[0], b[1], ss[j], j == n - 1 ? ss[0] + 360 : ss[j + 1]]];
function spts(bl, bh, a0, a1) = let(N = 24) concat([for (i = [0 : N]) pol(bh, a0 + i * (a1 - a0) / N)],
                                                  bl > 0.01 ? [for (i = [0 : N]) pol(bl, a0 + i * (a1 - a0) / N)] : [[0, 0]]);
function fit_rho(bl, bh, a0, a1) = (a1 - a0 >= 359.9) ? (2 * bh <= usable ? 0 : undef) :
    let(r0 = 90 - (a0 + a1) / 2, P = spts(bl, bh, a0, a1),
        ok = [for (d = [0, 10, -10, 20, -20, 30, -30, 45, -45, 60, -60, 90]) let(b = bb([for (p = P) rotp(p, r0 + d)]))
              if (b[2] - b[0] <= usable && b[3] - b[1] <= usable) r0 + d])
    len(ok) > 0 ? ok[0] : undef;
function band_ok(b, ss) = len([for (p = pieces_of(b, ss)) if (fit_rho(p[0], p[1], p[2], p[3]) == undef) 1]) == 0;
function nmax_band(b) = max(2, floor(360 / (2 * dlt(b) + 1)));
function band_g(b, bi, n = 2) = n > nmax_band(b) ? -1 : band_ok(b, seam_list(b, bi, n)) ? n : band_g(b, bi, n + 1);
function first_fit(b, bi, L, i = 0) = i >= len(L) ? -1 : band_ok(b, seam_list(b, bi, L[i])) ? L[i] : first_fit(b, bi, L, i + 1);
function band_n(b, bi) = let(G = band_g(b, bi), R = first_fit(b, bi, [for (n = [2 : nmax_band(b)]) if (reg(n)) n]))
    (R > 0 && (G < 0 || R <= G * 2)) ? R : G;
NP  = [for (i = [0 : 1 : len(SB) - 1]) 2 * SB[i][1] <= usable ? 1 : band_n(SB[i], i)];
NPE = [for (i = [0 : 1 : len(SB) - 1]) NP[i] > 0 ? NP[i] : nmax_band(SB[i])];
SEAMS = [for (i = [0 : 1 : len(SB) - 1]) NPE[i] > 1 ? seam_list(SB[i], i, NPE[i]) : []];
FP = st_split ? concat([[0, R_cs, 0, 360, -1]],
        [for (i = [0 : 1 : len(SB) - 1]) each (NPE[i] == 1 ? [[SB[i][0], SB[i][1], 0, 360, i]]
                                               : [for (p = pieces_of(SB[i], SEAMS[i])) concat(p, [i])])])
     : [[0, Rmax_s + 0.5, 0, 360, 0]];
RHO = [for (p = FP) let(r = fit_rho(p[0], p[1], p[2], p[3])) r == undef ? 90 - (p[2] + p[3]) / 2 : r];
FIT = [for (p = FP) fit_rho(p[0], p[1], p[2], p[3]) != undef];
CSEAMS = st_split ? [for (b = SB) b[0]] : [];
// Stoßblech am äußeren Ring nur nach innen (Platz für den Volant)
function padc(b) = b[3] == 1 ? R_k + w_rs / 2 - pr_s / 2 : b[2];
SCLIPS = concat([for (b = CSEAMS, t = PH) concat(pol(b, t), [t])],
                [for (i = [0 : 1 : len(SB) - 1]) if (NPE[i] > 1) for (a = SEAMS[i]) concat(pol(padc(SB[i]), a), [a + 90])]);

// Dach: Bänder entlang der Flächenmitte, falls ein Segment zu lang ist
n_rr = max(1, ceil((R_ri - r_top * cos(al / 2)) / (usable - 6)));
XB   = [for (j = [1 : 1 : n_rr - 1]) r_top + j * (R_ri - r_top) / n_rr];
function r_ok(r) = len([for (b = concat(CSEAMS, XB)) if (abs(r - b) < spw / 2 + pgs + 1) 1]) == 0 &&
                   len([for (z = ZRS) if (abs(r - z) < w_rs / 2 + pgs) 1]) == 0;
function r_pick(t, k = 0) = k > 400 ? t : let(v = t + (k % 2 == 0 ? 1 : -1) * floor((k + 1) / 2) * 0.5) r_ok(v) ? v : r_pick(t, k + 1);
r_peg = r_pick(0.55 * R_ri);

rb0 = st_split ? max(R_k * 0.72, b_top_s + spw / 2 + 2) : R_k * 0.72;   // Zierstreben-Anfang
module stern_pads() {
    for (b = CSEAMS, t = PH) rotate(t) translate([b - spw / 2, -pws / 2]) square([spw, pws]);
    for (i = [0 : 1 : len(SB) - 1]) if (NPE[i] > 1) for (a = SEAMS[i]) rotate(a) translate([padc(SB[i]) - pr_s / 2, -spw / 2]) square([pr_s, spw]);
}
module stern_2d() {
    difference() {
        union() {
            circle(r = r_hs);
            for (t = PH) rotate(t) {
                translate([r_hs - 0.5, -w_a / 2]) square([R_p - r_hs + 0.5, w_a]);
                translate([R_p - l_tip / 2, -w_tip / 2]) square([l_tip, w_tip]);
                // Zierstreben zum äußeren Ring
                if (rb0 < R_k - 3) for (sg = [-1, 1]) bar(pol(rb0, 0), pol(R_k, sg * al * 0.42), w_a * 0.6);
            }
            for (r = ZRS) ring2(r, w_rs);
            if (st_split) stern_pads();
        }
        circle(d = d_j + 2 * cl, $fn = 48);
    }
}
function in_piece(p, P, m) = let(r = norm(p), a = atan2(p[1], p[0]), da = deg(m / max(r, 1)),
                                  x = ((a - P[2] + da) % 360 + 360) % 360)
    r >= P[0] - m && r <= P[1] + m && (P[3] - P[2] >= 359.9 || x <= P[3] - P[2] + 2 * da);
module face_mask(p) {
    bl = p[0]; bh = p[1]; a0 = p[2]; a1 = p[3];
    is_top = !st_split || p[4] == len(SB) - 1;
    difference() {
        intersection() {
            circle(r = is_top ? bh + 3 : bh - gap, $fa = 1);
            if (a1 - a0 < 359.9) polygon(concat([[0, 0]], [for (i = [0 : 36]) pol(2 * bh + 10, a0 + i * (a1 - a0) / 36)]));
        }
        if (bl > 0) circle(r = bl + gap, $fa = 1);
        if (a1 - a0 < 359.9) for (a = [a0, a1]) rotate(a) translate([0, -gap]) square([2 * bh + 20, 2 * gap]);
    }
}
LPEG = [for (k = [0 : 2]) pol(r_top * 0.55, 90 + k * 120)];
module pin_hole(t) translate(concat(pol(R_p, t), [t_a / 2])) rotate([0, 0, t]) rotate([90, 0, 0])
    linear_extrude(w_tip + 4, center = true) rotate(90) teardrop(pin_p / 2);
module stern_stueck(P) {   // z = 0 Unterseite
    difference() {
        linear_extrude(t_a) intersection() { stern_2d(); face_mask(P); }
        for (c = SCLIPS) if (in_piece([c[0], c[1]], P, cL)) translate([c[0], c[1], 0]) clip_cut(c[2], false, 0);
        for (t = PH) if (in_piece(pol(R_p, t), P, 0)) pin_hole(t);
    }
    for (t = PH) if (in_piece(pol(r_peg, t), P, -pgs)) translate(concat(pol(r_peg, t), [t_a - e])) rotate([0, 0, t]) translate([-pgs / 2, -pgs / 2, 0]) cube([pgs, pgs, min(t_rb * 0.6, max(sc(100), 1.5)) + e]);
    if (P[0] == 0) for (p = LPEG) translate([p[0] - pgs / 2, p[1] - pgs / 2, t_a - e]) cube([pgs, pgs, min(H_in * 0.5, max(sc(100), 1.5)) + e]);
}
module stern_welt() translate([0, 0, z_a]) stern_stueck([0, Rmax_s + 50, 0, 360, 0]);
function piece_bb(i) = let(p = FP[i]) (p[3] - p[2] >= 359.9) ? [-p[1], -p[1], p[1], p[1]]
                                      : bb([for (q = spts(p[0], p[1], p[2], p[3])) rotp(q, RHO[i])]);
module stern_druck(stk) {
    if (!st_split) translate([Rmax_s, Rmax_s, 0]) stern_stueck(FP[0]);
    else if (stk > 0) let(i = min(stk, len(FP)) - 1, b = piece_bb(i)) translate([-b[0], -b[1], 0]) rotate([0, 0, RHO[i]]) stern_stueck(FP[i]);
    else for (i = [0 : len(FP) - 1]) let(b = piece_bb(i))
        translate([(i % 4) * (usable + 10) - b[0], floor(i / 4) * (usable + 10) - b[1], 0]) rotate([0, 0, RHO[i]]) stern_stueck(FP[i]);
}

// =====================================================================
//  MAST (Achteck, aufrecht gedruckt) und MASTFUSS
// =====================================================================
module oct(af) rotate(22.5) circle(r = af / 2 / cos(22.5), $fn = 8);
L_mast = z_a - z_m0;
n_ms   = max(1, ceil((L_mast + t_a) / (usable - 4)));
a_pg   = max(d_m * 0.5, d_mb + 2.4);
l_pg   = max(sc(300), 5);
ZJ     = [for (j = [1 : 1 : n_ms - 1]) z_m0 + j * L_mast / n_ms];
module mast_peg(o) {   // Achteck-Zapfen mit 45°-Spitze (Muffe ohne Brücke)
    c = (a_pg + 2 * o) * 0.25;
    linear_extrude(l_pg - c + o) oct(a_pg + 2 * o);
    translate([0, 0, l_pg - c + o - e]) linear_extrude(c + e, scale = 0.5) oct(a_pg + 2 * o);
}
module mast_voll() {
    pw = d_m * tan(22.5) * 0.62; dmr = max(sc(20), 0.4);
    z1 = h_p + h_col + max(sc(300), 3); z2 = z_a - max(sc(400), 4);
    difference() {
        union() {
            translate([0, 0, z_m0]) linear_extrude(L_mast) oct(d_m);
            translate([0, 0, z_a - e]) cylinder(d = d_j, h = t_a - 0.4 + e);
            // Zierfelder und Lampenringe
            if (z2 - z1 > 6) for (i = [0 : 7]) rotate(i * 45) {
                translate([d_m / 2 - e, -pw / 2, z1]) cube([dmr + e, pw, (z2 - z1) * 0.45]);
                translate([d_m / 2 - e, -pw / 2, z1 + (z2 - z1) * 0.55]) cube([dmr + e, pw, (z2 - z1) * 0.45]);
                if (lampen) for (z = [z1 + (z2 - z1) * 0.5, z2 + max(sc(150), 1.5)])
                    translate([d_m / 2 - 0.3, 0, z]) rotate([0, 90, 0]) cylinder(d = max(sc(100), 1.2), h = 0.3 + max(sc(40), 0.5), $fn = 10);
            }
        }
        translate([0, 0, -1]) cylinder(d = d_mb, h = z_a + t_a + 2, $fn = 24);
    }
}
module mast_seg(j) {   // Welt-Koordinaten
    za = j == 0 ? -1 : ZJ[j - 1]; zb = j == n_ms - 1 ? z_a + t_a + 1 : ZJ[j];
    difference() {
        union() {
            intersection() { mast_voll(); translate([-d_m, -d_m, za]) cube([2 * d_m, 2 * d_m, zb - za]); }
            if (j < n_ms - 1) translate([0, 0, zb - e]) difference() { mast_peg(0); translate([0, 0, -1]) cylinder(d = d_mb, h = 2 * l_pg, $fn = 24); }
        }
        if (j > 0) translate([0, 0, za - e]) mast_peg(spiel);
    }
}
module mast_druck(stk) {
    if (stk > 0) let(j = min(stk, n_ms) - 1) translate([0, 0, -(j == 0 ? z_m0 : ZJ[j - 1])]) mast_seg(j);
    else for (j = [0 : n_ms - 1]) translate([j * (d_m + 10), 0, -(j == 0 ? z_m0 : ZJ[j - 1])]) mast_seg(j);
}
module mastfuss() {
    difference() {
        union() {
            linear_extrude(h_f) oct(2 * r_fh);
            for (i = [0 : 3]) rotate(i * 90 + al / 2) translate([0, -w_f / 2, 0]) cube([r_f, w_f, h_f]);
        }
        translate([0, 0, z_m0]) linear_extrude(h_f) oct(d_m + 2 * spiel);
        translate([0, 0, -1]) cylinder(d = d_mb, h = h_f + 2, $fn = 24);
    }
}

// =====================================================================
//  PODEST (Platte, Blende, Treppen)
// =====================================================================
module poly(ap) rotate(al / 2) circle(r = ap / cos(180 / N_d), $fn = N_d);
module podest() {   // Welt-Koordinaten
    dl = max(sc(15), 0.3); wl = max(sc(25), 0.4); pitch = max(sc(350), 3);
    translate([0, 0, h_f]) difference() {
        union() {
            linear_extrude(t_d) poly(R_di);
            translate([0, 0, t_d - e]) linear_extrude(h_col + e) difference() { oct(d_m + 2 * spiel + 2 * w_col); oct(d_m + 2 * spiel); }
        }
        translate([0, 0, -1]) linear_extrude(t_d + h_col + 2) oct(d_m + 2 * spiel);
        translate([0, 0, -e]) linear_extrude(g_bl + e) difference() { poly(R_di - i_bl + spiel); poly(R_di - i_bl - t_bl - spiel); }
        // Dielenfugen (konzentrisch) und Gratfugen
        for (r = [r_m8 + w_col + pitch : pitch : R_di - pitch * 0.6]) translate([0, 0, t_d - dl]) linear_extrude(dl + 1) difference() { poly(r + wl / 2); poly(r - wl / 2); }
    }
}
module podest_druck() translate([R_dc, R_dc, -h_f]) podest();
R_sol = R_di - i_bl - t_bl - spiel - 1.5;
function strips(R, ox, oy, h = 4, st = 0) = [for (y = [-R : (st > 0 ? st : h) : R - h]) let(yy = max(abs(y), abs(y + h)), x = sqrt(max(0, R * R - yy * yy))) if (x > 1) [ox - x, oy + y, ox + x, oy + y + h]];
function info_podest() = let(ox = R_dc, oy = R_dc, SX = 2 * R_dc, c = r_m8 + w_col + 2,
    kp = [[ox - c, oy - c, ox + c, oy + c]])
    [SX, SX, seams_at(SX, [[ox - c - spw, ox + c + spw]], mw), seams_at(SX, [[oy - c - spw, oy + c + spw]], mw), kp, false, 0,
     strips(R_sol, ox, oy, max(2 * mw, cL + 2) + 2, 2), strips(R_dc, ox, oy), 35];

L_bo  = 2 * (R_di - i_bl) * tan(180 / N_d) - 2 * t_bl * tan(180 / N_d) - 0.4;   // Blende je Seite
n_bp  = max(1, ceil(L_bo / usable));
L_bp  = L_bo / n_bp - (n_bp > 1 ? 0.2 : 0);
h_sk  = h_f + g_bl - 0.2;
module blende_lokal() {   // x = Länge, y = Höhe, z = Dicke (außen oben)
    dmr = max(sc(20), 0.4); fr = max(sc(60), 0.8);
    cube([L_bp, h_sk, t_bl]);
    translate([0, 0, t_bl - e]) {
        // Rahmen und Zierfeld
        difference() { translate([fr, fr]) cube([L_bp - 2 * fr, h_f - 2 * fr, dmr + e]); translate([2 * fr, 2 * fr, -1]) cube([L_bp - 4 * fr, h_f - 4 * fr, dmr + 3]); }
        if (h_f > 6 * fr) translate([L_bp / 2, h_f / 2, 0]) scale([min(L_bp * 0.3, h_f * 0.9) / (h_f * 0.5), 1, 1]) cylinder(d = h_f * 0.5, h = dmr + e, $fn = 4);
        if (lampen) for (x = [L_bp * 0.15, L_bp * 0.85]) translate([x, h_f / 2, 0]) cylinder(d = max(sc(120), 1.2), h = dmr * 2 + e, $fn = 10);
    }
}
module blende_welt() for (k = [0 : N_d - 1], j = [0 : n_bp - 1]) rotate(k * al)
    translate([R_di - i_bl, -L_bo / 2 + j * (L_bp + (n_bp > 1 ? 0.2 : 0)), 0]) rotate([90, 0, 90]) translate([0, 0, -t_bl]) blende_lokal();
module treppe() {   // x = radial nach außen ab Blende, y = quer
    for (i = [1 : n_tr]) translate([0, -w_tr / 2, 0]) cube([(n_tr + 1 - i) * td_tr, w_tr, h_p * i / (n_tr + 1)]);
    for (sg = [-1, 1]) translate([0, sg > 0 ? w_tr / 2 : -w_tr / 2 - max(sc(80), 1.2), 0])
        hull() { cube([n_tr * td_tr, max(sc(80), 1.2), h_p * 0.25]); cube([e, max(sc(80), 1.2), h_p * n_tr / (n_tr + 1)]); }
}
module treppe_welt() for (a = TR_ANG) rotate(a) translate([R_di + max(sc(60), 1.5), 0, 0]) treppe();

// =====================================================================
//  DACH, VOLANT, LATERNE
// =====================================================================
function ridge_clips() = let(L = R_rc - r_top / cos(al / 2), n = max(1, min(4, floor((L - 2 * mi) / max(16, 2 * mw + 2)) + 1)))
    [for (sg = [-1, 1], k = [0 : n - 1]) let(r = r_top / cos(al / 2) + mi + (n == 1 ? (L - 2 * mi) / 2 : k * (L - 2 * mi) / (n - 1)))
        concat(pol(r, sg * al / 2), [sg * al / 2 + 90])];
module dach_maske(j) {   // Segment j-tes Band, Spalt an Graten und Bandgrenzen
    difference() {
        polygon([[0, 0], pol(R_rc * 2, -al / 2), pol(R_rc * 2, al / 2)]);
        for (sg = [-1, 1]) rotate(sg * al / 2) translate([0, -gap]) square([R_rc * 3, 2 * gap]);
        if (j > 0) translate([-1, -R_rc * 2]) square([XB[j - 1] + gap + 1, R_rc * 4]);
        if (j < n_rr - 1) translate([XB[j] - gap, -R_rc * 2]) square([R_rc * 4, R_rc * 4]);
        circle(r = r_top, $fn = 64);
    }
}
module dach_lokal(j) {   // Fläche entlang +x, z = 0 Unterseite
    d_lr = max(sc(120), 1.2);
    difference() {
        intersection() {
            hull() {
                linear_extrude(t_rb) polygon([[0, 0], pol(R_rc, -al / 2), pol(R_rc, al / 2)]);
                translate([0, 0, t_rb + h_r - 0.01]) cylinder(r = 0.01, h = 0.01, $fn = 4);
            }
            translate([0, 0, -1]) linear_extrude(t_rb + h_r + 2) dach_maske(j);
        }
        // Zapfenloch, Volant-Nut, Clips an Graten und Bandgrenzen
        translate([r_peg - pgs / 2 - spiel, -pgs / 2 - spiel, -e]) cube([pgs + 2 * spiel, pgs + 2 * spiel, min(t_rb * 0.6, max(sc(100), 1.5)) + 0.3]);
        translate([R_ri - i_v - t_v - spiel, -L_v / 2 - spiel, -e]) cube([t_v + 2 * spiel, L_v + 2 * spiel, g_v]);
        for (c = ridge_clips()) translate([c[0], c[1], 0]) clip_cut(c[2], false, 0);
        for (x = XB) translate([x, 0, 0]) clip_cut(0, false, 0);
    }
    if (lampen) intersection() {
        for (x = [r_top + max(sc(600), 4) : max(sc(1100), 7) : R_ri - i_v - 2]) translate([x, 0, th_roof(x)]) sphere(d = d_lr, $fn = 12);
        translate([0, 0, -1]) linear_extrude(t_rb + h_r + 5) dach_maske(j);
    }
}
module dach_welt(k, j = -1) rotate(PH[k]) translate([0, 0, z_rb]) {
    if (j >= 0) dach_lokal(j); else for (jj = [0 : n_rr - 1]) dach_lokal(jj);
}
module dach_druck(stk) {
    j = stk > 0 ? min(stk, n_rr) - 1 : -1;
    for (jj = [0 : n_rr - 1]) if (j < 0 || j == jj) {
        x0 = jj == 0 ? r_top * cos(al / 2) : XB[jj - 1];
        translate([-x0 + (j < 0 ? jj * 10 : 0), R_rc * sin(al / 2), 0]) dach_lokal(jj);
    }
}
module volant_2d() {
    nb = max(2, round(L_v / (2 * sr_v * 1.25)));
    pb = L_v / nb;
    difference() {
        union() {
            translate([-L_v / 2, -h_v + sr_v]) square([L_v, h_v - sr_v]);
            for (i = [0 : nb - 1]) translate([-L_v / 2 + (i + 0.5) * pb, -h_v + sr_v]) scale([pb / (2 * sr_v), 1]) circle(r = sr_v);
            translate([-L_v / 2 + 1, -e]) square([L_v - 2, g_v - 0.2 + e]);
        }
        translate([-(w_a / 2 + cl), -(t_a + cl)]) square([w_a + 2 * cl, t_a + cl + g_v + 1]);
        // Zierlöcher
        for (i = [0 : nb - 1]) if (abs(-L_v / 2 + (i + 0.5) * pb) > w_a / 2 + cl + sr_v) translate([-L_v / 2 + (i + 0.5) * pb, -h_v + sr_v * 1.2]) circle(r = sr_v * 0.35, $fn = 12);
    }
}
module volant_welt(k) rotate(PH[k]) translate([R_ri - i_v - t_v, 0, z_rb]) rotate([90, 0, 90]) linear_extrude(t_v) volant_2d();
module volant_druck() translate([L_v / 2, h_v, 0]) linear_extrude(t_v) volant_2d();

module laterne(fp) {   // z = 0 auf der Sternnabe
    Hb = H_in + h_lt; hc = max(r_lt * 0.9, 3); wdep = max(sc(25), 0.5);
    if (inc(fp, "A")) {
        difference() {
            union() {
                linear_extrude(Hb) oct(2 * r_lt * cos(22.5));
                translate([0, 0, Hb - e]) linear_extrude(hc, scale = 0.08) oct(2 * r_lt * cos(22.5) * 1.12);
                translate([0, 0, Hb + hc - 1]) { cylinder(d1 = d_fp * 2.2, d2 = d_fp * 2.2, h = d_fp * 0.6); translate([0, 0, d_fp * 0.6 - e]) cylinder(d1 = d_fp * 2.2, d2 = d_fp, h = d_fp * 0.6 + e); }
                cylinder(d = d_fs, h = Hb + hc + h_pole - h_pen + e);                // Fahnenmast unten (Schulter für die Wimpel-Hülse)
                cylinder(d = d_fp, h = Hb + hc + h_pole);
            }
            // Spitzbogenfenster (Relief)
            for (i = [0 : 7]) rotate(i * 45 + 22.5) translate([r_lt * cos(22.5) - wdep, 0, H_in + h_lt * 0.2]) rotate([90, 0, 90])
                linear_extrude(wdep + 1) let(w = r_lt * 0.45, h = h_lt * 0.55) polygon([[-w / 2, 0], [w / 2, 0], [w / 2, h - w / 2], [0, h], [-w / 2, h - w / 2]]);
            for (p = LPEG) translate([p[0] - pgs / 2 - spiel, p[1] - pgs / 2 - spiel, -e]) cube([pgs + 2 * spiel, pgs + 2 * spiel, min(H_in * 0.5, max(sc(100), 1.5)) + 0.3]);
        }
    }
    // Wimpel (45°-Unterkante, stützfrei)
    // Wimpel mit Hülse: von oben über den dünnen Mast geschoben, sitzt auf der Schulter
    if (inc(fp, "B")) translate([0, 0, Hb + hc + h_pole - h_pen]) {
        difference() { cylinder(d = d_fs, h = h_pen, $fn = 16); translate([0, 0, -1]) cylinder(d = d_fp + 2 * einsatz_spiel, h = h_pen + 2, $fn = 12); }
        translate([d_fs / 2 - 0.2, -t_pen / 2, 0]) rotate([90, 0, 0]) translate([0, 0, -t_pen]) linear_extrude(t_pen) polygon([[0, 0], [h_pen * 0.95, h_pen], [0, h_pen]]);
    }
}
module laterne_welt(fp = "alle") translate([0, 0, z_rb]) laterne(fp);

// =====================================================================
//  SITZ UND KETTENSTANGE  (lokal: u = radial, v = hoch, Sitzpunkt = 0)
// =====================================================================
module sitz_2d() {
    hull() { translate([-d_st / 2, -t_sp / 2]) square([d_st, t_sp]); translate([-d_st / 2, -t_sp / 2]) square([t_sb, t_sp + h_bk * 0.3]); }
    hull() { translate([-d_st / 2, 0]) square([t_sb, e]); translate([-d_st / 2 + t_sb * 0.5, h_bk - t_sb]) circle(d = t_sb * 1.6); }   // Lehne
    translate([d_st / 2 - t_sb, -v_fr]) square([t_sb, v_fr]);                                                                  // Bein
    translate([d_st / 2 - t_sb, -v_fr]) square([t_sb + l_fr, t_sb]);                                                            // Fußraste
    hull() { translate([-d_st / 2, -t_sp / 2]) square([t_sb, e]); translate([-d_st / 4, -t_sp / 2 - t_sb]) square([d_st / 4, t_sb]); }   // Schale
}
module sitz_3d() {   // z = Breite (tangential), auf der Seite liegend
    difference() {
        linear_extrude(W_st) sitz_2d();
        if (kette_echt) translate([0, 0, -1]) cylinder(d = pin_p, h = W_st + 2, $fn = 16);
        else for (z = [-e, W_st - p_d - 0.2]) translate([-p_g / 2 - spiel, -p_g / 2 - spiel, z]) cube([p_g + 2 * spiel, p_g + 2 * spiel, p_d + 0.2 + e]);
    }
}
sitz_u0 = -d_st / 2; sitz_v0 = -v_fr;
module sitz_druck() translate([-sitz_u0, -sitz_v0, 0]) sitz_3d();
L_st = L_k + p_g / 2 + max(sc(60), 1.2);
module stange_2d() {
    difference() {
        union() {
            translate([-hr_w / 2, -L_st]) square([hr_w, L_st]);
            circle(r = r_he, $fn = 24);
        }
        circle(d = pin_e, $fn = 16);
        // Kettenglieder als Langlöcher
        if (hr_w >= 2.6) let(pk = hr_w * 2.2) for (v = [-r_he - pk * 0.8 : -pk : -L_k + p_g + pk * 0.6])
            hull() { translate([0, v]) circle(d = hr_w - 1.6, $fn = 10); translate([0, v - pk * 0.55]) circle(d = hr_w - 1.6, $fn = 10); }
    }
}
module stange_druck() {   // Zapfen zeigt nach oben (zum Sitz)
    linear_extrude(hr_t) stange_2d();
    translate([-p_g / 2, -L_k - p_g / 2, hr_t - e]) cube([p_g, p_g, p_d + e]);
}
module schaukel(k, sw, ex = 0) {   // Sitz + 2 Stangen am Drehpunkt k, sw = Ausschwenkwinkel
    translate(concat(pol(R_p, PH[k]), [z_piv])) rotate([0, 0, PH[k]]) rotate([0, -sw, 0]) {
        color(fhex(alt(k, farbe_sitz_1, farbe_sitz_2))) translate([0, W_st / 2, -L_k - ex]) rotate([90, 0, 0]) sitz_3d();
        if (!kette_echt) color(fhex(farbe_kette)) for (sg = [-1, 1]) rotate([0, 0, sg > 0 ? 0 : 180]) translate([0, W_st / 2 + hr_t, 0]) rotate([90, 0, 0]) stange_druck();
        else color(fhex(farbe_kette)) for (sg = [-1, 1]) translate([0, sg * (W_st / 2 + 0.6), -L_k]) cylinder(d = 0.8, h = L_k);
    }
}
module stange_welt_druck() translate([r_he, L_st, 0]) stange_druck();

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
module wand_local(k) {
    L = wlen(k);
    difference() {
        union() {
            cube([L, H_h, t_h]);
            translate([0, -(g_h - spiel), 0]) cube([L, g_h - spiel + e, t_h]);
            translate([0, H_h - e, 0]) cube([L, g_h - spiel + e, t_h]);
        }
        trim = (k == "vorne" || k == "hinten") ? fwid * 1.3 + f_gw : 0;
        for (j = [1 : 1 : floor(L / f_pitch - 0.01)]) if (j * f_pitch > trim && j * f_pitch < L - trim)
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
}
module wand_welt(k) {
    if (k == "vorne")       translate([0, t_h, hb_h]) rotate([90, 0, 0]) wand_local(k);
    else if (k == "hinten") translate([W_h, D_h - t_h, hb_h]) rotate([90, 0, 180]) wand_local(k);
    else if (k == "links")  translate([t_h, D_h - t_h, hb_h]) rotate([90, 0, -90]) wand_local(k);
    else                    translate([W_h - t_h, t_h, hb_h]) rotate([90, 0, 90]) wand_local(k);
}
module wand_druck(k) translate([0, g_h, 0]) wand_local(k);
function info_wand(k) = let(L = wlen(k), SY = H_h + 2 * g_h,
    kp = concat([for (o = openings(k)) [o[0] - 1, o[1] + g_h - 1, o[2] + 1, o[3] + g_h + 1]],
                [[-1, -1, L + 1, g_h + 1.5], [-1, H_h + g_h - 1.5, L + 1, SY + 1]]))
    [L, SY, seams_at(L, [], mw), seams_at(SY, [], mw), kp, false, 0, []];

z_rh = hb_h + H_h;                                // Dachunterseite
module haus_dach() {   // aufrecht gedruckt (Unterseite auf dem Bett)
    difference() {
        union() {
            translate([-ov_h, -ov_h, z_rh]) cube([RXh, RYh, rt_h]);
            hull() {
                translate([-ov_h, -ov_h, z_rh + rt_h - e]) cube([RXh, RYh, e]);
                translate([W_h / 2 - PXh / 2, D_h / 2 - PYh / 2, z_rh + rt_h + h_rf - e]) cube([PXh, PYh, e]);
            }
        }
        translate([0, 0, z_rh - e]) linear_extrude(g_h + e) ring_2d();
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
module haus_dach_druck() translate([ov_h, ov_h, -z_rh]) haus_dach();
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
    color(fhex(farbe_haus_wand)) for (k = ["vorne", "hinten", "links", "rechts"]) translate([0, 0, ex]) wand_welt(k);
    color(fhex(farbe_haus_dach)) translate([0, 0, 2 * ex]) haus_dach();
    translate([0, 0, 3 * ex]) { if (inc(farbteil, "A")) color(fhex(farbe_schild_A)) schild_welt("A"); if (inc(farbteil, "B")) color(fhex(farbe_schild_B)) schild_welt("B"); }
}

// =====================================================================
//  ZUSAMMENBAU
// =====================================================================
module karussell(rot, sw, ex = 0) {
    color(fhex(farbe_mastfuss)) translate([0, 0, -ex]) mastfuss();
    color(fhex(farbe_podest)) podest();
    color(fhex(farbe_blende)) translate([0, 0, -ex]) blende_welt();
    color(fhex(farbe_treppe)) treppe_welt();
    color(fhex(farbe_mast)) translate([0, 0, ex]) mast_voll();
    rotate([0, 0, rot]) translate([0, 0, 2 * ex]) {
        color(fhex(farbe_stern)) stern_welt();
        for (k = [0 : n_s - 1]) {
            color(fhex(alt(k, farbe_dach_1, farbe_dach_2))) translate([0, 0, ex]) dach_welt(k);
            color(fhex(alt(k, farbe_volant_1, farbe_volant_2))) translate([0, 0, ex * 0.5]) volant_welt(k);
            schaukel(k, sw, ex);
        }
        translate([0, 0, 2 * ex]) { color(fhex(farbe_laterne)) laterne_welt("A"); color(fhex(farbe_wimpel)) laterne_welt("B"); }
    }
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFOS = [["podest", info_podest(), 1],
         ["haus_boden", info_haus_boden(), 1], ["haus_wand_vorne", info_wand("vorne"), 1], ["haus_wand_hinten", info_wand("hinten"), 1],
         ["haus_wand_links", info_wand("links"), 1], ["haus_wand_rechts", info_wand("rechts"), 1],
         ["haus_dach", info_haus_dach(), 1], ["haus_schild", info_schild(), 1]];
CLIPS = len(SCLIPS) + n_s * (len(ridge_clips()) / 2 + len(XB)) + lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
H_ges = z_rb + H_in + h_lt + max(r_lt * 0.9, 3) + h_pole;
gap_t = 2 * PI * R_p / n_s - (W_st + 2 * hr_t);

echo(str("Kettenkarussell 1:", den, " | ", n_s, " Sitze | Podest Ø ", r2(2 * R_dc), " mm | Aufhängung Ø ", r2(2 * R_p),
         " mm | Gesamthöhe ", r2(H_ges), " mm | Kette ", r2(L_k), " mm", kette_echt ? " (echte Kette)" : " (gedruckte Stange)"));
echo(str("Ausleger-Stern: ", len(FP), " Stück(e)", st_split ? str(" (Nabe + ", len(SB), " Ring(e): ", NPE, " Segmente)") : "",
         " | Dach: ", n_s, " Segmente", n_rr > 1 ? str(" à ", n_rr, " Stücke") : "", " | Mast: ", n_ms, " Stück(e)"));
echo(str("Stifte Ø ", stift_d, ": ", n_s, " Stück à ", r2(w_tip + 2 * hr_t + 2), " mm (Auslegerspitze)",
         kette_echt ? str(" + ", n_s, " Stück à ", r2(W_st + 6), " mm durch die Sitze, Kette ", r2(L_k), " mm je Seite") : ""));
if (st_split && len([for (f = FIT) if (!f) 1]) > 0) echo("WARNUNG: Ein Sternsegment passt nicht aufs Druckbett.");
if (den <= 24 && stift_d < 2.5) echo("TIPP: Ab 1:24 tragen 3-mm-Stifte (Messing/Stahldraht) besser: stift_d = 3 setzen.");
if (gap_t < 2) echo("WARNUNG: Sitze zu breit für die Anzahl – weniger Sitze oder größeren Radius wählen.");
if (2 * R_rc * sin(al / 2) > usable) echo("WARNUNG: Dachsegment zu breit – mehr Sitze wählen.");
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
cpp = floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3));
echo(str("Verbinder-Clips gesamt: ", CLIPS, CLIPS > cpp ? str(" -> ", ceil(CLIPS / cpp), " Clip-Platten") : ""));

// Maschinenlesbare Druckliste: DRUCK|teil|stücke|farbteil|farbe|menge
function np_of(n) = [for (i = INFOS) if (i[0] == n) n_pieces(i[1])][0];
module druck(t, n, fp, f, m) if (m > 0) echo(str("DRUCK|", t, "|", n, "|", fp, "|", f, "|", m));
druck("podest", np_of("podest"), "alle", farbe_podest, 1);
druck("blende", 1, "alle", farbe_blende, N_d * n_bp);
druck("mastfuss", 1, "alle", farbe_mastfuss, 1);
druck("mast", n_ms, "alle", farbe_mast, 1);
druck("stern", len(FP), "alle", farbe_stern, 1);
druck("dach", n_rr, "alle", farbe_dach_1, ceil(n_s / 2));
druck("dach", n_rr, "alle", farbe_dach_2, floor(n_s / 2));
druck("volant", 1, "alle", farbe_volant_1, ceil(n_s / 2));
druck("volant", 1, "alle", farbe_volant_2, floor(n_s / 2));
druck("laterne", 1, "A", farbe_laterne, 1);
druck("laterne", 1, "B", farbe_wimpel, 1);
druck("sitz", 1, "alle", farbe_sitz_1, ceil(n_s / 2));
druck("sitz", 1, "alle", farbe_sitz_2, floor(n_s / 2));
if (!kette_echt) druck("kettenstange", 1, "alle", farbe_kette, 2 * n_s);
druck("treppe", 1, "alle", farbe_treppe, treppen);
druck("haus_boden", np_of("haus_boden"), "alle", farbe_haus_boden, 1);
for (w = ["vorne", "hinten", "links", "rechts"]) druck(str("haus_wand_", w), np_of(str("haus_wand_", w)), "alle", farbe_haus_wand, 1);
druck("haus_dach", np_of("haus_dach"), "alle", farbe_haus_dach, 1);
druck("haus_schild", np_of("haus_schild"), "A", farbe_schild_A, 1);
druck("haus_schild", np_of("haus_schild"), "B", farbe_schild_B, 1);
druck("verbinder", ceil(max(CLIPS, 4) / cpp), "alle", farbe_clips, 1);
for (f = FARBEN) echo(str("FARBE|", f[0], "|", f[1]));

if (teil == "aufbau") {
    karussell(drehung, schwenk);
    if (kassenhaus_zeigen) translate([R_dc + 3 * m_h, -R_dc - HBY * 0.2, 0]) kassenhaus();
}
else if (teil == "explosion") {
    karussell(drehung, schwenk, max(sc(1200), 10));
    if (kassenhaus_zeigen) translate([R_dc + 3 * m_h, -R_dc - HBY * 0.2, 0]) kassenhaus(max(sc(800), 8));
}
else if (teil == "podest") split_out(info_podest(), stueck) podest_druck();
else if (teil == "blende") blende_lokal();
else if (teil == "mastfuss") translate([r_f, r_f, 0]) mastfuss();
else if (teil == "mast") mast_druck(stueck);
else if (teil == "stern") stern_druck(stueck);
else if (teil == "dach") dach_druck(stueck);
else if (teil == "volant") volant_druck();
else if (teil == "laterne") translate([r_lt, r_lt, 0]) laterne(farbteil);
else if (teil == "sitz") sitz_druck();
else if (teil == "kettenstange") { if (!kette_echt) stange_welt_druck(); }
else if (teil == "treppe") translate([0, w_tr / 2 + max(sc(80), 1.2), 0]) treppe();
else if (teil == "haus_boden") split_out(info_haus_boden(), stueck) haus_boden_druck();
else if (teil == "haus_wand_vorne") split_out(info_wand("vorne"), stueck) wand_druck("vorne");
else if (teil == "haus_wand_hinten") split_out(info_wand("hinten"), stueck) wand_druck("hinten");
else if (teil == "haus_wand_links") split_out(info_wand("links"), stueck) wand_druck("links");
else if (teil == "haus_wand_rechts") split_out(info_wand("rechts"), stueck) wand_druck("rechts");
else if (teil == "haus_dach") split_out(info_haus_dach(), stueck) haus_dach_druck();
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
