// =====================================================================
//  REACH STACKER  –  Container-Greifstapler (Vorbild: 46-t-Klasse, Radstand 6,2 m)
//  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei), Farben je Bauteil,
//  Maßstab 1:43 / 1:87.  Ausleger starr im gewählten Winkel, aber ausziehbar.
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    fahrgestell      Fahrgestell mit Gegengewicht, Ausleger-Lagerböcken,
//                     Zylinderbock, Radzapfen (gelb/schwarz/silber)          1x
//    kabine           Fahrerkabine (Rahmen + Glas)                           1x
//    rad_vorne        Zwillingsrad vorne (zwei Reifen, eine Felge)           2x
//    rad_hinten       Rad hinten mit Profil und Felge                        2x
//    kotfluegel_links / kotfluegel_rechts  geschwungener Kotflügel über dem
//                     Zwillingsrad mit Podest und Aufstiegstreppe        je 1x
//    ausleger_aussen  Ausleger-Grundrohr mit Lager und Zylinderkonsole       1x
//    ausleger_innen   Teleskop-Innenrohr mit Kopf (ausziehbar)               1x
//    zylinder         Hubzylinder, feste Länge für ausleger_winkel           2x
//    haenger          Spreader-Aufhängung (pendelt am Kopfbolzen)            1x
//    spreader_rahmen  Spreader-Hauptrahmen mit Drehzapfen und Warnstreifen   1x
//    spreader_arm     Teleskoparm mit Kopfträger und Twistlocks              2x
//    gelaender        Geländer vorne links/rechts (flach gedruckt)           2x
//    c20_... / c40_...  Container-Bausatz 20 bzw. 40 Fuß:
//      boden          Boden mit Längs-/Querträgern und Eckbeschlägen, Nuten  1x
//      dach           Dach mit Obergurten, Eckbeschlägen (Zapfenlöcher)      1x
//      seite          Seitenwand mit Trapezsicken                            2x
//      stirn          Stirnwand mit Eckpfosten                               1x
//      tuer           Türseite mit Pfosten, Verriegelungsstangen, Scharnieren 1x
//      (40 Fuß bei 1:43: Boden/Dach mit Clips geteilt, Seitenwände zweiteilig)
//    verbinder        Clips für geteilte Container-Teile
//
//  BOLZEN
//    4 Filament-Stücke Ø stift_d (Längen siehe Echo): Ausleger-Lager,
//    Zylinder unten, Zylinder oben, Spreader-Aufhängung.
//  BEWEGLICH
//    * Innenrohr gleitet im Grundrohr (20'-Stellung bis voll ausgefahren).
//    * Aufhängung pendelt am Kopfbolzen: der Spreader hängt immer waagerecht.
//    * Spreader dreht sich auf dem Drehzapfen; beide Teleskoparme ziehen von
//      20 Fuß auf 40 Fuß aus.
//    * Räder drehen sich auf den Rautenzapfen.
//    * Container: vier Zapfen unter den Kopfträgern stecken stramm in den
//      oberen Eckbeschlägen (statt Twistlocks) – der Spreader liegt auf.
//  DRUCK
//    Fahrgestell aufrecht; die Flügel des Gegengewichts über den Hinterrädern
//    mit Stützmaterial drucken (Stützen nur vom Druckbett). Alle anderen
//    Teile sind stützfrei.
//  STARR
//    Der Ausleger-Winkel wird vor dem Druck gewählt (ausleger_winkel); die
//    Hubzylinder und die Aufhängung werden passend dazu berechnet.
//  MONTAGE (Kurzfassung)
//    1. Räder auf die Rautenzapfen schieben, Kotflügel mit Treppe seitlich an
//       die Front stecken, Kabine aufsetzen, Geländer ins Podest stecken.
//    2. Grundrohr mit Bolzen in die Lagerböcke, Innenrohr einschieben.
//    3. Zylinder unten (Bolzen durch den Zylinderbock) und oben (Bolzen durch
//       die Konsole) anbauen.
//    4. Aufhängung mit Bolzen in den Kopf, Spreader auf den Drehzapfen,
//       Teleskoparme in den Rahmen schieben.
//    5. Container: Stirnwand und Türseite in den Boden, Seitenwände in die
//       Nuten, Dach aufsetzen. Spreader aufsetzen – die Zapfen greifen in
//       die oberen Eckbeschläge.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, fahrgestell:Fahrgestell, kabine:Fahrerkabine, rad_vorne:Zwillingsrad vorne (2x), rad_hinten:Rad hinten (2x), kotfluegel_links:Kotflügel mit Treppe links, kotfluegel_rechts:Kotflügel mit Treppe rechts, ausleger_aussen:Ausleger Grundrohr, ausleger_innen:Ausleger Innenrohr, zylinder:Hubzylinder (2x), haenger:Spreader-Aufhängung, spreader_rahmen:Spreader-Rahmen, spreader_arm:Spreader-Teleskoparm (2x), gelaender:Geländer (2x), c20_boden:Container 20' Boden, c20_dach:Container 20' Dach, c20_seite:Container 20' Seitenwand (2x), c20_stirn:Container 20' Stirnwand, c20_tuer:Container 20' Türseite, c40_boden:Container 40' Boden, c40_dach:Container 40' Dach, c40_seite:Container 40' Seitenwand (2x), c40_stirn:Container 40' Stirnwand, c40_tuer:Container 40' Türseite, verbinder:Verbinder-Clips]
stueck = 0;
farbteil = "alle"; // [alle, A, B, C]

/* [Vorschau] */
// Auszug des Innenrohrs (0 = eingefahren, 1 = voll)
auszug = 0.3; // [0:0.05:1]
// Spreader-Breite (0 = 20 Fuß, 1 = 40 Fuß)
spreader_auszug = 0; // [0:0.05:1]
spreader_drehung = 0; // [-90:5:90]
// Container am Spreader (20 Fuß bei eingefahrenen, 40 Fuß bei ausgefahrenen Armen)
container_zeigen = true;

/* [Reach Stacker (Vorbild in Metern)] */
// Ausleger-Winkel (starr, legt Zylinderlänge und Aufhängung fest)
ausleger_winkel = 20; // [0:1:59]
laenge_m = 8.65;
radstand_m = 6.2;
// Breite über die Zwillingsreifen vorne
breite_m = 4.20;
zwilling_luft_m = 0.06;
spur_hinten_m = 3.06;
rad_d_m = 1.61;
rad_b_m = 0.48;
kabine_hoehe_m = 3.815;
ausleger_laenge_m = 8.3;
ausleger_breite_m = 0.95;
ausleger_hoehe_m = 1.25;
// sichtbarer Teil des Innenrohrs (eingefahren)
innen_sichtbar_m = 2.2;
// Teleskop-Hub
ausleger_hub_m = 5.4;
spreader_20_m = 6.1;
spreader_40_m = 12.2;

/* [Container (Vorbild in Metern)] */
container_20_m = 6.058;
container_40_m = 12.192;
container_breite_m = 2.438;
// 2.591 Standard, 2.896 High Cube
container_hoehe_m = 2.591;

/* [Farben] */
farbe_gelb      = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_rahmen    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_auspuff   = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kabine    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_glas      = "puderblau"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_reifen    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_felge     = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_ausleger  = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kopf      = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_zylinder  = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_stange    = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haenger   = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_spreader  = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_streifen  = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_arm       = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gelaender = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_container = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_beschlag  = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_clips     = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

/* [Druck & Passung] */
rennbahn_taschen = true;   // (keine Bodenplatte – bleibt für die Bibliothek stehen)
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;
stift_d = 1.75;
// Luft je Seite in den Teleskopführungen
tele_spiel = 0.2;
// Luft je Seite: Container-Zapfen in den Eckbeschlägen (klein = stramm)
zapfen_spiel = 0.05;

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
          ["hellblau", "#5aa2dc"], ["dunkelgruen", "#1f6b3a"], ["puderblau", "#8cc8ea"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

// =====================================================================
//  Maße (Welt: x = 0 Heck, +x nach vorne, y = 0 Mitte, z = 0 Boden; mm)
// =====================================================================
a_w   = ausleger_winkel;
x_f   = M(laenge_m - 0.835);              // Vorderachse
x_r   = x_f - M(radstand_m);              // Hinterachse
z_ax  = M(rad_d_m / 2);
R_w   = M(rad_d_m / 2);
B_w   = M(rad_b_m);
g_zw  = max(M(zwilling_luft_m), 0.8);
B_zw  = 2 * B_w + g_zw;                  // Zwillingsrad
y_rv  = M(breite_m / 2) - B_zw;           // Innenseite Zwillingsrad vorne
y_rh  = M(spur_hinten_m / 2) - B_w / 2;   // Innenseite Rad hinten
z0    = M(0.55);                          // Unterkante Fahrgestell
L_ch  = M(laenge_m);
w_c   = max(M(0.12), min_wand);           // Wand des hohlen Fahrgestells
p_r   = 12; t_r = 1.2;                    // Rippen im Hohlraum

// Fahrgestell-Abschnitte [x0, x1, y, z1] in Metern
HECK  = [0, 2.75, 1.75, 2.35];
MITTE = [2.5, 5.9, 1.15, 1.75];
FRONT = [5.7, 6.85, 1.45, 1.85];          // Front hinten (Zylinderbock)
FRONT_N = [6.85, laenge_m, breite_m / 2 - 2 * rad_b_m - zwilling_luft_m - 0.08, 1.85];   // schmal zwischen den Rädern
HAUBE = [0.75, 2.2, 1.35, 2.6];
// Heck: Gegengewicht über den Hinterrädern (Rückseite leicht gewölbt, Ecken gerundet),
// darunter schmaler Rahmen – die Hinterräder liegen frei.  Seitenprofil mit Schräge vor dem Rad.
HECK_P = [[0, 0.55], [HECK[1], 0.55], [HECK[1], 1.8], [2.2, HECK[3]], [0, HECK[3]]];
R_bw  = 3.25;                              // Wölbung der Rückseite (Pfeil 0,25 m)
R_hk  = 0.5;                               // Eckradius (senkrechte Kanten)
Z_cw  = z_ax + R_w + M(0.1);               // Unterkante Gegengewicht (mm)
Z_kn  = M(HECK[3] - 0.4);                  // Knick der Rückseite
X_kn  = M(0.35);                           // Rückversatz der Oberkante
y_bog = M(spur_hinten_m / 2 - rad_b_m / 2 - 0.07);   // Innenwand Radkasten hinten

// Radzapfen (Raute)
d_rz  = max(M(0.25), 3);
d_rb  = max(M(0.48), d_rz + 2);
function h_hub(zw) = (zw ? B_zw : B_w) - max(M(0.06), 0.8);   // Nabenloch-Tiefe
l_rz  = h_hub(false) - 0.4;
l_rz2 = h_hub(true) - 0.4;

// Bolzen
r_h   = (stift_d + 0.25) / 2;
r_e   = max(M(0.2), r_h + 1.2);           // Augen / Lager
t_e   = max(M(0.14), 1.6);                // Augen-Dicke

// Kabine
K_X   = [M(2.95), M(4.75)];
K_Y   = M(0.78);
K_Z   = [M(MITTE[3]), M(kabine_hoehe_m)];
t_k   = max(M(0.07), 1.0);
r_g   = max(M(0.03), 0.4);                // Glas zurückgesetzt
d_kz  = max(M(0.2), 2.5);                 // Kabinenzapfen (Raute)
h_kz  = max(M(0.15), 2.0);
KZ_X  = [M(3.4), M(4.3)];

// Ausleger (lokal: u längs, y quer, w senkrecht zum Rohr; Lager im Ursprung)
P_x   = M(1.9);
P_z   = M(kabine_hoehe_m + 0.085 + 0.25);
W_o   = M(ausleger_breite_m);
H_o   = M(ausleger_hoehe_m);
c_o   = M(0.12);
wb_o  = -M(0.25);
u0    = -M(0.4);
L_o   = M(ausleger_laenge_m);
u1    = u0 + L_o;
t_o   = max(M(0.07), min_wand);
u_cv  = M(0.45);                          // Hohlraum ab hier (hinten massiv: Lager)
gap_l = max(M(0.03), 0.35);
t_lb  = max(M(0.2), 2.4);                 // Lagerbock-Dicke
y_lb  = W_o / 2 + gap_l;
yc    = W_o / 2 + M(0.12);                // Zylinder-Augenmitte (quer)
yb    = yc - t_e / 2 - max(M(0.08), 0.6); // Konsolen-/Bock-Halbbreite
u_kb  = M(3.3);                           // Konsole unter dem Rohr
w_kb  = wb_o - M(0.3);

// Innenrohr (lokal v längs ab Hinterkante, w wie Grundrohr)
t_i   = t_o;
W_i   = W_o - 2 * (t_o + tele_spiel);
wb_i  = wb_o + t_o + tele_spiel;
wt_i  = wb_o + H_o - t_o - tele_spiel;
L_ex  = M(innen_sichtbar_m);
HUB   = M(ausleger_hub_m);
L_i   = L_ex + HUB + M(1.0);
v_p   = L_i - M(0.3);                     // Kopfbolzen
w_p   = wb_i + M(0.3);
t_l   = max(M(0.12), 1.6);                // Kopf-Laschen
r_l   = M(0.3);
u_ir  = u1 + L_ex - L_i;                  // Hinterkante Innenrohr (eingefahren)

// Hubzylinder: Bock am Fahrgestell, Konsole am Rohr
Q0    = [x_f - M(1.5), M(2.15)];
function rot_aw(p) = [P_x + p[0] * cos(a_w) - p[1] * sin(a_w), P_z + p[0] * sin(a_w) + p[1] * cos(a_w)];
Q1    = rot_aw([u_kb, w_kb]);
L_c   = norm(Q1 - Q0);
phi_c = atan2(Q1[1] - Q0[1], Q1[0] - Q0[0]);
r_tb  = max(M(0.18), r_e);
r_st  = max(M(0.1), 1.0);
L_tb  = 0.58 * L_c;

// Aufhängung (Welt, Ursprung im Kopfbolzen)
T_t   = W_i - 2 * t_l - 2 * spiel - 0.1;
r_t   = max(M(0.25), r_h + 1.2);
// Stirnwand des Kopfes so weit zurück, dass ihre Unterkante beim Winkel a_w den Hals der Aufhängung frei lässt
v_w   = v_p - t_i - (r_t + max(M(0.03), 0.4) + (w_p - wb_i) * sin(a_w)) / cos(a_w) - 0.01;
bx_h  = M(0.55); by_h = M(0.6); h_bh = M(0.6);
function z_un(a) = let(wr = wb_i - w_p, xb = bx_h + M(0.1),
                       vr = (-xb + wr * sin(a)) / max(cos(a), 0.05))
    min(wr * cos(a) + r_l * sin(a), vr * sin(a) + wr * cos(a));
d_n   = max(-z_un(a_w) + M(0.12), r_t + M(0.3));
r_dz  = max(M(0.15), 1.6);                // Drehzapfen Spreader
h_dz  = max(M(0.3), 3);

// Container (lokal: x längs ab Stirnwand, y quer, z = 0 Unterkante)
L_c20 = M(container_20_m); L_c40 = M(container_40_m);
W_ct  = M(container_breite_m); H_ct = M(container_hoehe_m);
d_tw  = max(M(0.12), 1.8);                // Zapfen unter den Kopfträgern
h_tw  = max(M(0.15), 2.0);
r_zl  = d_tw / 2 + zapfen_spiel;          // Bohrung im Eckbeschlag
in_x  = max(M((container_20_m - 5.853) / 2), r_zl + 1.1);   // Zapfenmitte ab Stirnseite
in_y  = max(M((container_breite_m - 2.259) / 2), r_zl + 1.1);
cx_e  = max(M(0.178), in_x + r_zl + 0.8); // Eckbeschlag / Eckpfosten
cy_e  = max(M(0.162), in_y + r_zl + 0.8);
h_eb  = max(M(0.118), 1.2);
cd    = max(M(0.036), 0.4);               // Sickentiefe
p_sk  = M(0.278);                         // Sickenteilung
t_cw  = min_wand;
rb    = max(M(0.1), 1.2);                 // Rahmen (Längs-/Stirnträger)
h_ur  = max(M(0.16), 1.6);
h_or  = max(M(0.1), 1.0);
dt    = max(M(0.04), 0.6);                // Tür zurückgesetzt

// Spreader (Welt, Ursprung Rahmenmitte Oberkante)
eb_w  = M(0.35);
gap_e = max(M(0.05), 0.5);
L_f   = M(spreader_20_m) - 2 * eb_w - 2 * gap_e;
X_f   = M(0.45);
H_f   = M(0.6);
t_s   = max(M(0.06), min_wand);
r_sd  = M(0.45); h_sd = max(M(0.06), 0.8);
d_in  = max(M(0.03), 0.6);
CH    = [t_s / 2, X_f - t_s, -H_f + t_s, -t_s];                                  // Kanal x>0
ARM   = [CH[0] + tele_spiel, CH[1] - tele_spiel, CH[2] + tele_spiel, CH[3] - tele_spiel];
y_ae  = -(L_f / 2 + gap_e);                // Innenkante Kopfträger
y_ai  = L_f / 2 - M(0.1);                  // inneres Armende
eb_x  = M(1.22); eb_h = H_f - t_s - tele_spiel + M(0.05);   // Kopfträger reicht unter den Rahmen
tw_x  = W_ct / 2 - in_y;
tw_y  = -(L_c20 / 2 - in_x);             // Zapfen (eingefahren, Arm nach -y)
E40   = (L_c40 - L_c20) / 2;

// Geländer
L_g   = M(1.6); H_g = M(1.1);
b_g   = max(M(0.06), 1.0);
t_g   = max(M(0.06), 1.2);
// Kotflügel mit Podest und Treppe (Welt, Seite y > 0; rechts gespiegelt)
ls_k  = max(M(0.04), 1.2);                // Wangen / Lippe
y_kf  = M(breite_m / 2) + ls_k + 0.3;     // Außenseite (Druckbett); Lippe außerhalb der Reifen
t_kf  = max(M(0.08), 1.6);                // Blechdicke
R_kf  = R_w + M(0.1);                     // Innenradius über dem Rad
Z_pl  = z_ax + R_kf + t_kf;               // Podest-Oberkante
x_p0  = M(6.1);                           // Podest hinten
y_fi  = y_rv - M(0.04);                   // Kotflügel innen (über dem Zwillingsrad)
y_si  = M(FRONT[2]) + spiel;              // Podest/Treppe innen (an der Front)
l_kz  = max(M(0.1), 2.0);                 // Zapfen in die Front
n_st  = 4; z_st = M(0.5);                 // Stufen, unterste Trittfläche
r_st2 = (Z_pl - z_st) / n_st; a_st = M(0.22);
KZ2   = [[M(6.22), Z_pl - M(0.18)], [M(6.55), Z_pl - M(0.18)]];
l_gz  = t_kf;                              // Geländer-Zapfen = Blechdicke (durchgesteckt)
X_g   = x_p0 + M(0.05);
Y_g   = y_kf - M(0.1);
Z_dk  = Z_pl;

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
//  Hilfen
// =====================================================================
module wbox(x0, x1, y, z1, zb = 0.55) translate([M(x0), -M(y), M(zb)]) cube([M(x1 - x0), 2 * M(y), M(z1 - zb)]);
module raute2(d) rotate(45) square(d / sqrt(2), center = true);
// Loch quer (y) bei (x, z); Spitze im Druck nach oben (+z) oder unten
module hole_y(x, z, r, L, up = true) translate([x, 0, z]) rotate([90, 0, 0]) linear_extrude(L, center = true) rotate(up ? 90 : -90) teardrop(r);
// Rautenzapfen entlang +y ab y = y0
module raute_y(x, z, y0, l, d) translate([x, y0, z]) rotate([-90, 0, 0]) linear_extrude(l) raute2(d);
// Ausleger-Profil (y, w), Ecken gefast
module bprof(W, H, c, wb) polygon([[-W / 2 + c, wb], [W / 2 - c, wb], [W / 2, wb + c], [W / 2, wb + H - c],
                                   [W / 2 - c, wb + H], [-W / 2 + c, wb + H], [-W / 2, wb + H - c], [-W / 2, wb + c]]);
module prof_o() bprof(W_o, H_o, c_o, wb_o);
// 2D-Umriss quer extrudiert (Ebene x-z, Breite ±hy)
module xz_plate(hy) translate([0, hy, 0]) rotate([90, 0, 0]) linear_extrude(2 * hy) children();
module bunt(f) color(fhex(f)) render(convexity = 6) children();

// =====================================================================
//  Fahrgestell
// =====================================================================
module heck_2d() polygon([for (p = HECK_P) [M(p[0]), M(p[1])]]);
module heck_plan() hull() {
    intersection() { translate([M(R_bw), 0]) circle(r = M(R_bw), $fn = 240); translate([0, -M(HECK[2] - R_hk)]) square([M(1.0), 2 * M(HECK[2] - R_hk)]); }
    for (sy = [-1, 1]) translate([M(0.25 + R_hk), sy * M(HECK[2] - R_hk)]) circle(r = M(R_hk), $fn = 64);
    translate([M(0.25 + R_hk), -M(HECK[2])]) square([M(HECK[1] - 0.25 - R_hk), 2 * M(HECK[2])]);
}
module heck_koerper() {
    intersection() {
        xz_plate(M(HECK[2])) heck_2d();
        union() {
            translate([0, 0, Z_cw]) linear_extrude(Z_kn - Z_cw + 0.01) heck_plan();
            hull() { translate([0, 0, Z_kn]) linear_extrude(0.01) heck_plan(); translate([X_kn, 0, M(HECK[3])]) linear_extrude(1) heck_plan(); }
        }
    }
    xz_plate(y_bog) polygon([[M(0.5), z0], [M(HECK[1]), z0], [M(HECK[1]), Z_cw + 0.01], [M(0.35), Z_cw + 0.01], [M(0.35), z0 + M(0.15)]]);
}
module bogen_hinten() {
    R = R_w + M(0.08); zs = z_ax + R * (sqrt(2) - 1);
    for (sy = [-1, 1]) translate([0, sy > 0 ? y_bog : -y_bog - M(1), 0])
        rotate([90, 0, 0]) translate([0, 0, -M(1)]) linear_extrude(M(1))
        polygon([[x_r - R, -1], [x_r + R, -1], [x_r + R, zs], [x_r, z_ax + R * sqrt(2)], [x_r - R, zs]]);
}
module hohlraeume() difference() {
    union() {
        intersection() {
            xz_plate(y_bog - w_c) union() { offset(delta = -w_c) heck_2d(); translate([M(0.5) + w_c, -1]) square([M(HECK[1]) - M(0.5) - 2 * w_c, z0 + w_c + 1.01]); }
            translate([0, 0, -2]) linear_extrude(M(HECK[3]) + 4) offset(delta = -w_c) heck_plan();
            translate([M(0.5) + w_c, -M(3), -2]) cube([M(HECK[1]), M(6), M(4)]);
        }
        translate([M(HECK[1]) - w_c - 1, -M(MITTE[2]) + w_c, -1]) cube([M(FRONT[0]) - M(HECK[1]) + 2 * w_c + 2, 2 * (M(MITTE[2]) - w_c), M(MITTE[3]) - w_c + 1]);
        translate([M(FRONT[0]) + w_c, -M(FRONT[2]) + w_c, -1]) cube([M(FRONT[1] - FRONT[0]) - 2 * w_c, 2 * (M(FRONT[2]) - w_c), M(FRONT[3]) - w_c + 1]);
        translate([M(FRONT_N[0]), -M(FRONT_N[2]) + w_c, -1]) cube([M(FRONT_N[1] - FRONT_N[0]) - w_c, 2 * (M(FRONT_N[2]) - w_c), M(FRONT_N[3]) - w_c + 1]);
    }
    for (xx = [p_r : p_r : L_ch - p_r / 2]) translate([xx - t_r / 2, -M(3), -2]) cube([t_r, M(6), M(4)]);
}
module fahrgestell_koerper() {
    difference() {
        union() {
            heck_koerper();
            wbox(MITTE[0], MITTE[1], MITTE[2], MITTE[3]);
            wbox(FRONT[0], FRONT[1], FRONT[2], FRONT[3]);
            wbox(FRONT_N[0] - 0.01, FRONT_N[1], FRONT_N[2], FRONT_N[3]);
            wbox(HAUBE[0], HAUBE[1], HAUBE[2], HAUBE[3], HECK[3] - 0.01);
            // Lagerböcke für den Ausleger
            for (sy = [-1, 1]) translate([0, sy > 0 ? y_lb + t_lb : -y_lb, 0]) rotate([90, 0, 0]) linear_extrude(t_lb)
                hull() { translate([P_x - M(0.45), M(HAUBE[3]) - 0.1]) square([M(0.75), M(0.3)]); translate([P_x, P_z]) circle(r = max(M(0.32), r_e)); }
            // Zylinderbock
            xz_plate(yb) hull() { translate([Q0[0] - M(0.35), M(FRONT[3]) - 0.1]) square([M(0.7), M(0.12)]); translate(Q0) circle(r = r_e); }
            // Radnaben-Ansätze + Rautenzapfen
            for (sy = [-1, 1]) mirror([0, sy > 0 ? 0 : 1, 0]) {
                raute_y(x_f, z_ax, M(FRONT_N[2]) - 0.5, y_rv - M(0.02) - M(FRONT_N[2]) + 0.5, d_rb);
                raute_y(x_f, z_ax, y_rv - M(0.02) - 0.01, l_rz2 + 0.01, d_rz);
                raute_y(x_r, z_ax, y_bog - 0.5, y_rh - M(0.02) - y_bog + 0.5, d_rb);
                raute_y(x_r, z_ax, y_rh - M(0.02) - 0.01, l_rz + 0.01, d_rz);
            }
            // Kabinenzapfen
            for (x = KZ_X) translate([x, 0, M(MITTE[3]) - 0.01]) linear_extrude(h_kz + 0.01, scale = 0.6) raute2(d_kz);
        }
        hohlraeume();
        hole_y(P_x, P_z, r_h, 2 * (y_lb + t_lb) + 2, true);
        hole_y(Q0[0], Q0[1], r_h, 2 * yb + 2, true);
        // Kühlergrill hinten
        translate([0, 0, Z_cw + M(0.05)]) linear_extrude(Z_kn - Z_cw - M(0.1))
            intersection() { difference() { offset(delta = 1) heck_plan(); offset(delta = -max(M(0.03), 0.5)) heck_plan(); }
                             for (k = [-3 : 3]) translate([-1, k * M(0.2) - max(M(0.05), 0.6) / 2]) square([M(0.5), max(M(0.05), 0.6)]); }
        // Löcher für die Schutzblech-Zapfen
        for (sy = [-1, 1], q = KZ2) mirror([0, sy > 0 ? 0 : 1, 0]) raute_y(q[0], q[1], M(FRONT[2]) - l_kz - 0.3, l_kz + 1, d_kz + 2 * spiel);
    }
}
module auspuff() translate([M(2.0), -M(1.2), M(HAUBE[3]) - 0.01]) cylinder(d = max(M(0.18), 1.6), h = M(1.0), $fn = 24);
module b_zone() { translate([M(HECK[1]), -M(3), -1]) cube([M(laenge_m), M(6), M(1.05) + 1]); translate([-1, -M(3), -1]) cube([M(HECK[1]) + 1.01, M(6), Z_cw + 1 - 0.3]); }
module fahrgestell_welt(fp) {
    if (inc(fp, "A")) difference() { fahrgestell_koerper(); b_zone(); }
    if (inc(fp, "B")) intersection() { fahrgestell_koerper(); b_zone(); }
    if (inc(fp, "C")) auspuff();
}
module fahrgestell_druck(fp) translate([0, 0, -z0]) fahrgestell_welt(fp);

// =====================================================================
//  Kabine
// =====================================================================
module kab_aussen() hull() {
    translate([K_X[0], -K_Y, K_Z[0]]) cube([K_X[1] - K_X[0], 2 * K_Y, K_Z[1] - K_Z[0] - M(0.06)]);
    translate([K_X[0] + M(0.06), -K_Y + M(0.06), K_Z[0]]) cube([K_X[1] - K_X[0] - M(0.12), 2 * K_Y - M(0.12), K_Z[1] - K_Z[0]]);
}
zw0 = M(2.3); zw1 = M(3.62);
module kab_kern(o) translate([K_X[0] + t_k - o, -K_Y + t_k - o, zw0 - M(0.05) - o]) cube([K_X[1] - K_X[0] - 2 * t_k + 2 * o, 2 * (K_Y - t_k + o), zw1 - zw0 + M(0.1) + 2 * o]);
// Fensterprismen: von der Glasebene (r = Rücksprung) nach innen
module kab_fenster(r, o) {
    pw = max(M(0.1), 1.0);
    // vorne / hinten
    for (s = [0, 1]) let(x = s == 0 ? K_X[1] - r : K_X[0] + r)
        translate([s == 0 ? x - M(0.5) : x, -K_Y + pw - o, zw0 - o]) cube([M(0.5), 2 * (K_Y - pw + o), (s == 0 ? zw1 : zw1 - M(0.3)) - zw0 + 2 * o]);
    // Seiten
    for (sy = [-1, 1]) translate([K_X[0] + pw - o, sy > 0 ? K_Y - r - M(0.5) : -K_Y + r, zw0 - o]) cube([K_X[1] - K_X[0] - 2 * pw + 2 * o, M(0.5), zw1 - zw0 + 2 * o]);
}
module kabine_welt(fp) {
    if (inc(fp, "A")) difference() {
        kab_aussen();
        kab_kern(0.02); kab_fenster(-1, 0.02);
        for (x = KZ_X) translate([x, 0, K_Z[0] - 0.01]) linear_extrude(h_kz + 0.3, scale = 0.6) offset(delta = spiel) raute2(d_kz);
    }
    if (inc(fp, "B")) intersection() { kab_aussen(); union() { kab_kern(0); kab_fenster(r_g, 0); } }
}
module kabine_druck(fp) translate([0, 0, -K_Z[0]]) kabine_welt(fp);

// =====================================================================
//  Rad (gedruckt: Achse senkrecht, Außenseite oben)
// =====================================================================
R_fe = M(0.45);
// Rad (gedruckt: Achse senkrecht, Außenseite oben); zw = Zwillingsrad mit V-Rille zwischen den Reifen
module rad(fp, zw = false) {
    c_t = max(M(0.07), 0.6); n_p = 26; g_d = max(M(0.05), 0.6); c_v = M(0.12);
    H2 = zw ? B_zw : B_w;
    prof = zw ? [[R_fe, 0], [R_w - c_t, 0], [R_w, c_t], [R_w, B_w - c_v], [R_w - c_v, B_w], [R_w - c_v, B_w + g_zw],
                 [R_w, B_w + g_zw + c_v], [R_w, H2 - c_t], [R_w - c_t, H2], [R_fe, H2]]
              : [[R_fe, 0], [R_w - c_t, 0], [R_w, c_t], [R_w, B_w - c_t], [R_w - c_t, B_w], [R_fe, B_w]];
    if (inc(fp, "A")) difference() {
        intersection() {
            rotate_extrude($fn = 96) polygon(prof);
            union() {
                for (t0 = zw ? [0, B_w + g_zw] : [0], hf = [0, 1]) translate([0, 0, t0 + hf * B_w / 2])
                    linear_extrude(B_w / 2 + 0.01, twist = hf == 0 ? 6 : -6, slices = 6)
                    rotate(hf * 180 / n_p) difference() { circle(r = R_w + 1, $fn = 96); for (k = [0 : n_p - 1]) rotate(k * 360 / n_p) translate([R_w - g_d, -R_w * PI / n_p * 0.35]) square([g_d + 2, R_w * 2 * PI / n_p * 0.35]); }
                cylinder(r = R_w - g_d + 0.01, h = H2, $fn = 96);
            }
        }
        translate([0, 0, -1]) cylinder(r = R_fe, h = H2 + 2, $fn = 96);
    }
    if (inc(fp, "B")) difference() {
        union() {
            cylinder(r = R_fe, h = H2 - M(0.1), $fn = 96);
            difference() { cylinder(r = R_fe, h = H2 - M(0.02), $fn = 96); translate([0, 0, -1]) cylinder(r = R_fe - max(M(0.06), 0.8), h = H2 + 2, $fn = 96); }
            cylinder(r = max(M(0.2), d_rz / 2 + 1.2), h = H2 - M(0.03), $fn = 48);
        }
        translate([0, 0, -1]) cylinder(d = d_rz + spiel, h = h_hub(zw) + 1, $fn = 32);
        for (k = [0 : 7]) rotate(k * 45 + 22.5) translate([M(0.3), 0, H2 - M(0.1) - max(M(0.03), 0.4)]) cylinder(r = max(M(0.04), 0.5), h = 2, $fn = 12);
    }
}
// Kotflügel (Welt, linke Seite): Bogen über dem Zwillingsrad, Podest, Treppe nach hinten.
// Gedruckt auf der Außenseite liegend: alles sind Profile in x-z, nach innen extrudiert.
module kf_bogen(r0, r1, a0, a1) polygon(concat([for (i = [0 : 24]) [x_f, z_ax] + pol(r1, a0 + i * (a1 - a0) / 24)],
                                               [for (i = [24 : -1 : 0]) [x_f, z_ax] + pol(r0, a0 + i * (a1 - a0) / 24)]));
module kf_stufen_2d() { for (k = [1 : n_st]) translate([x_p0 - k * a_st, Z_pl - k * r_st2 - t_kf]) square([a_st + 0.01, t_kf]);
    translate([x_p0 - n_st * a_st, Z_pl - n_st * r_st2 - t_kf - M(0.12)]) square([a_st + 0.01, M(0.12) + 0.01]); }
module kf_wange_2d() let(xb = x_p0 - n_st * a_st, zb = Z_pl - n_st * r_st2 - t_kf)
    polygon([[x_p0 + 0.01, Z_pl], [x_p0 + 0.01, Z_pl - M(0.35)], [xb + M(0.12), zb - M(0.12)], [xb, zb - M(0.12)], [xb, zb + t_kf]]);
module kf_y(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0) children();
module kotfluegel_l() difference() {
    union() {
        // Bogen + Podest über dem Rad
        kf_y(y_fi, y_kf) { kf_bogen(R_kf, R_kf + t_kf, 15, 90); translate([max(x_p0, M(FRONT[1]) + spiel), Z_pl - t_kf]) square([x_f - max(x_p0, M(FRONT[1]) + spiel) + 0.01, t_kf]); }
        // Lippe außen
        kf_y(y_kf - ls_k, y_kf) kf_bogen(R_kf - M(0.22), R_kf + t_kf, 12, 90);
        // Podest hinten, Block mit Zapfen, Stufen und Wangen
        kf_y(y_si, y_kf) { translate([x_p0, Z_pl - t_kf]) square([M(FRONT[1]) + spiel - x_p0 + 0.01, t_kf]); translate([x_p0, Z_pl - M(0.35)]) square([M(0.6), M(0.35)]); kf_stufen_2d(); }
        kf_y(y_kf - ls_k, y_kf) kf_wange_2d();   // Wange außen (die Stufen stehen beim Druck darauf)
        for (q = KZ2) raute_y(q[0], q[1], y_si - l_kz, l_kz + 0.01, d_kz);
    }
    for (x = [X_g, X_g + L_g - b_g]) translate([x - spiel, Y_g - t_g / 2 - spiel, Z_pl - t_kf - 1]) hull() {
        cube([b_g + 2 * spiel, t_g + 2 * spiel, t_kf + 2]);
        translate([b_g / 2 + spiel - 0.01, -(b_g / 2 + spiel), 0]) cube([0.02, 0.02, t_kf + 2]);
    }
}
module kotfluegel_welt(sy) if (sy > 0) kotfluegel_l(); else mirror([0, 1, 0]) kotfluegel_l();
// Druck: Außenseite auf dem Bett (Zapfen zeigen nach oben)
module kotfluegel_druck(sy) if (sy > 0) multmatrix([[1, 0, 0, 0], [0, 0, 1, 0], [0, -1, 0, y_kf], [0, 0, 0, 1]]) kotfluegel_welt(1);
    else multmatrix([[-1, 0, 0, 0], [0, 0, 1, 0], [0, 1, 0, y_kf], [0, 0, 0, 1]]) kotfluegel_welt(-1);
// Welt: Rad i (0 vl, 1 vr, 2 hl, 3 hr); Innenseite (Druckbett) zum Fahrzeug
module rad_welt(i, fp, ex = 0) let(x = i < 2 ? x_f : x_r, yi = i < 2 ? y_rv : y_rh, sy = i % 2 == 0 ? 1 : -1)
    translate([x, sy * (yi + ex), z_ax]) rotate([sy > 0 ? -90 : 90, 0, 0]) rad(fp, i < 2);

// =====================================================================
//  Ausleger
// =====================================================================
module aussen_lokal() difference() {
    union() {
        translate([u0, 0, 0]) cyc() linear_extrude(L_o) prof_o();
        xz_plate(yb) hull() { translate([u_kb - M(0.3), wb_o - M(0.1)]) square([M(0.6), M(0.1) + c_o + 0.01]); translate([u_kb, w_kb]) circle(r = r_e); }
    }
    translate([u_cv, 0, 0]) cyc() linear_extrude(L_o) offset(delta = -t_o) prof_o();
    hole_y(0, 0, r_h, W_o + 2, false);
    hole_y(u_kb, w_kb, r_h, 2 * yb + 2, false);
}
lug_pts = [[v_w, wb_i], [v_p, wb_i], [v_p + r_l, wb_i + r_l], [v_p + r_l, wt_i - M(0.2)], [v_p + r_l - M(0.2), wt_i], [v_w, wt_i]];
module innen_koerper() difference() {
    union() {
        cyc() linear_extrude(v_w + t_i) offset(delta = -t_o - tele_spiel) prof_o();
        intersection() {
            cyc() linear_extrude(L_i) offset(delta = -t_o - tele_spiel) prof_o();
            for (sy = [-1, 1]) translate([0, sy > 0 ? W_i / 2 : -W_i / 2 + t_l, 0]) rotate([90, 0, 0]) linear_extrude(t_l) polygon(lug_pts);
        }
    }
    translate([-1, 0, 0]) cyc() linear_extrude(v_w + 1) offset(delta = -t_o - tele_spiel - t_i) prof_o();
    hole_y(v_p, w_p, r_h, W_i + 2, true);
}
module innen_lokal(fp) {
    if (inc(fp, "A")) intersection() { innen_koerper(); translate([-1, -M(2), -M(3)]) cube([v_w + 1, M(4), M(6)]); }
    if (inc(fp, "B")) intersection() { innen_koerper(); translate([v_w, -M(2), -M(3)]) cube([M(2), M(4), M(6)]); }
}
module ausleger_rahmen() translate([P_x, 0, P_z]) rotate([0, -a_w, 0]) children();
module aussen_druck() translate([-u0, 0, wb_o + H_o]) rotate([180, 0, 0]) aussen_lokal();
module innen_druck(fp) translate([0, 0, -wb_i]) innen_lokal(fp);
function kopf_welt(az) = rot_aw([u_ir + az * HUB + v_p, w_p]);

// =====================================================================
//  Hubzylinder (gedruckt liegend: Achse x, Augen unten flach)
// =====================================================================
module zylinder(fp) {
    hz = r_tb * 0.7071; hs = r_st * 0.7071;
    if (inc(fp, "A")) difference() {
        union() {
            cylinder(r = r_e, h = t_e, $fn = 32);
            intersection() {
                translate([r_e - 0.3, 0, hz]) rotate([0, 90, 0]) cylinder(r = r_tb, h = L_tb - r_e + 0.3, $fn = 32);
                translate([0, -r_tb - 1, 0]) cube([L_c, 2 * r_tb + 2, 2 * r_tb + 1]);
            }
        }
        translate([0, 0, -1]) cylinder(r = r_h, h = t_e + 2, $fn = 24);
    }
    if (inc(fp, "B")) difference() {
        union() {
            translate([L_c, 0, 0]) cylinder(r = r_e, h = t_e, $fn = 32);
            intersection() {
                translate([L_tb, 0, hs]) rotate([0, 90, 0]) cylinder(r = r_st, h = L_c - r_e - L_tb + 0.3, $fn = 24);
                translate([0, -r_st - 1, 0]) cube([L_c, 2 * r_st + 2, 2 * r_st + 1]);
            }
        }
        translate([L_c, 0, -1]) cylinder(r = r_h, h = t_e + 2, $fn = 24);
    }
}
module zylinder_welt(sy, fp, ex = 0) {
    d = [cos(phi_c), 0, sin(phi_c)]; n = [-sin(phi_c), 0, cos(phi_c)];
    translate([Q0[0], sy * (yc - t_e / 2 + ex), Q0[1]])
        multmatrix(sy > 0 ? [[d[0], -n[0], 0, 0], [0, 0, 1, 0], [d[2], -n[2], 0, 0], [0, 0, 0, 1]]
                          : [[d[0], n[0], 0, 0], [0, 0, -1, 0], [d[2], n[2], 0, 0], [0, 0, 0, 1]]) zylinder(fp);
}

// =====================================================================
//  Spreader-Aufhängung (Welt: Ursprung im Kopfbolzen)
// =====================================================================
module haenger() difference() {
    union() {
        xz_plate(T_t / 2) hull() { circle(r = r_t); translate([-r_t, -d_n - 0.01]) square([2 * r_t, M(0.1)]); }
        translate([0, 0, -d_n - h_bh]) hull() {
            translate([-bx_h, -by_h, 0]) cube([2 * bx_h, 2 * by_h, h_bh - M(0.12)]);
            translate([-bx_h + M(0.12), -by_h + M(0.12), 0]) cube([2 * (bx_h - M(0.12)), 2 * (by_h - M(0.12)), h_bh]);
        }
    }
    hole_y(0, 0, r_h, T_t + 2, true);
    translate([0, 0, -d_n - h_bh - 1]) cylinder(r = r_dz + spiel, h = h_dz + 1.5, $fn = 32);
}
module haenger_druck() translate([0, 0, d_n + h_bh]) haenger();

// =====================================================================
//  Spreader (Welt: Ursprung Rahmenmitte, Oberkante)
// =====================================================================
module streifen_2d(L) intersection() {
    translate([-L / 2, -H_f]) square([L, H_f]);
    p = M(0.5);
    union() {
        for (k = [-ceil(L / p) - 2 : ceil(L / p) + 2]) translate([k * p, -H_f]) polygon([[0, 0], [p / 2, 0], [p / 2 + H_f, H_f], [H_f, H_f]]);
        translate([-L / 2, -H_f]) square([L, max(M(0.06), 0.8)]);
        for (sy = [-1, 1]) translate([sy > 0 ? L / 2 - max(M(0.06), 0.8) : -L / 2, -H_f]) square([max(M(0.06), 0.8), H_f]);   // Endkanten verbinden angeschnittene Streifen
    }
}
module rahmen_b(o) union() {
    for (sx = [-1, 1]) translate([sx > 0 ? X_f - d_in - o : -X_f - o, 0, 0])
        rotate([90, 0, 90]) linear_extrude(d_in + 2 * o) streifen_2d(L_f + 2 * o);
    translate([-X_f - o, -L_f / 2 - o, -H_f - o]) cube([2 * X_f + 2 * o, L_f + 2 * o, d_in + o]);
}
module rahmen_koerper() difference() {
    union() {
        translate([-X_f, -L_f / 2, -H_f]) cube([2 * X_f, L_f, H_f]);
        translate([0, 0, -0.01]) cylinder(r = r_sd, h = h_sd + 0.01, $fn = 48);
        translate([0, 0, h_sd - 0.01]) cylinder(r = r_dz, h = h_dz - 0.4, $fn = 32);
        translate([0, 0, h_sd + h_dz - 0.41]) cylinder(r1 = r_dz, r2 = r_dz - 0.4, h = 0.4, $fn = 32);
    }
    for (sx = [-1, 1]) translate([sx > 0 ? CH[0] : -CH[1], -L_f / 2 - 1, CH[2]]) cube([CH[1] - CH[0], L_f + 2, CH[3] - CH[2]]);
}
module spreader_rahmen(fp) {
    if (inc(fp, "A")) difference() { rahmen_koerper(); rahmen_b(0.02); }
    if (inc(fp, "B")) difference() { rahmen_b(0); for (sx = [-1, 1]) translate([sx > 0 ? CH[0] : -CH[1], -L_f / 2 - 1, CH[2]]) cube([CH[1] - CH[0], L_f + 2, CH[3] - CH[2]]); }
}
module spreader_arm() {
    translate([ARM[0], y_ae - 0.01, ARM[2]]) cube([ARM[1] - ARM[0], y_ai - y_ae + 0.01, ARM[3] - ARM[2]]);
    translate([-eb_x, y_ae - eb_w, ARM[3] - eb_h]) cube([2 * eb_x, eb_w, eb_h]);
    for (sx = [-1, 1]) translate([sx * tw_x, tw_y, ARM[3] - eb_h - h_tw]) {
        translate([0, 0, h_tw * 0.4]) cylinder(d = d_tw, h = h_tw * 0.6 + 0.01, $fn = 24);
        cylinder(d1 = d_tw * 0.6, d2 = d_tw, h = h_tw * 0.4 + 0.01, $fn = 24);
    }
}
module spreader_druck() translate([0, 0, ARM[3]]) rotate([180, 0, 0]) spreader_arm();
module rahmen_druck(fp) translate([0, 0, H_f]) spreader_rahmen(fp);

// =====================================================================
//  Geländer (gedruckt flach; Welt: Ebene x-z)
// =====================================================================
module gelaender_2d() {
    translate([0, 0]) square([L_g, b_g]);
    translate([0, H_g / 2 - b_g / 2]) square([L_g, b_g]);
    translate([0, H_g - b_g]) square([L_g, b_g]);
    for (x = [0, L_g / 2 - b_g / 2, L_g - b_g]) translate([x, 0]) square([b_g, H_g]);
    for (x = [0, L_g - b_g]) translate([x, -l_gz]) square([b_g, l_gz + 0.01]);
}
module gelaender_druck() translate([0, l_gz, 0]) linear_extrude(t_g) gelaender_2d();
module gelaender_welt(sy, ex = 0) translate([X_g, sy * (Y_g + 0.6 * ex) + t_g / 2, Z_dk + ex]) rotate([90, 0, 0]) linear_extrude(t_g) gelaender_2d();

// =====================================================================
//  Container-Bausatz (lokal: x 0..Lc, y 0..W_ct, z 0..H_ct; Türen bei x = Lc)
//  boden (kopfüber), dach (kopfüber), seite 2x (innen unten), stirn und
//  tuer (außen unten).  Wände stecken mit Federn in Nuten von Boden und Dach.
// =====================================================================
g_n  = max(M(0.04), 0.8);                 // Nuttiefe
t_tg = max(0.8, t_cw - 0.4);              // Federdicke
z_f  = h_ur;                              // Bodenoberkante
t_fl = max(M(0.06), g_n + 0.8);           // Bodenplatte
tr   = max(h_or, g_n + 0.8, t_cw);        // Dachdicke
hc   = max(h_eb, h_tw + 1.0);             // obere Eckbeschläge (unter dem Dach)
h_tb = max(M(0.12), 1.2);                 // Obergurt Stirn/Tür
z_wo = H_ct - tr;                         // Wand-Oberkante
z_e1 = H_ct - hc - h_tb;                  // Stirnblech/Türen oben
rib_h = b_cl;                             // Schott unter dem Dach (Clips)
y_s0 = cd + t_cw - t_tg;                  // Feder der Seitenwand (innen)
y_cs = cd + t_cw + spiel + 1;             // Clip-Bereich ab hier
bw_t = max(M(0.05), 0.8);
function ct_xs(Lc) = Lc > usable ? seams_at(Lc, [], mw) : [];
function ct_S(xs) = [for (sx = xs) [sx - spw / 2, y_cs, sx + spw / 2, W_ct - y_cs]];
function info_boden(Lc) = [Lc, W_ct, ct_xs(Lc), [], [], false, z_f, ct_S(ct_xs(Lc))];
function info_dach(Lc) = [Lc, W_ct, ct_xs(Lc), [], [], true, tr + rib_h, ct_S(ct_xs(Lc))];
function info_seite(Lc) = let(Lw = Lc - 2 * cx_e - 2 * spiel, xa = cx_e + spiel)
    [Lw, z_wo - z_f + 2 * g_n, Lw > usable ? seams_at(Lw, [[Lc / 2 - xa - 15, Lc / 2 - xa + 15]], 10) : [], [], [[-1e4, -1e4, 1e4, 1e4]], false, 0, []];
module cbox(a, b) translate(a) cube(b - a);
module ct_ring(Lc, zb, h, w, o) translate([-o, -o, zb - o]) difference() {
    cube([Lc + 2 * o, W_ct + 2 * o, h + 2 * o]);
    translate([w, w, -1]) cube([Lc - 2 * w + 2 * o, W_ct - 2 * w + 2 * o, h + 2 * o + 2]);
}
module eck_oval(Lc, zc, h) if (h >= 2) for (x = [0, Lc - cx_e], y = [0, W_ct - cy_e]) {
    translate([x + cx_e / 2, y == 0 ? -1 : W_ct - 0.5, zc]) rotate([-90, 0, 0]) linear_extrude(1.5) hull() for (d = [-1, 1]) translate([d * cx_e * 0.18, 0]) circle(d = h * 0.45, $fn = 16);
    translate([x == 0 ? -1 : Lc - 0.5, y + cy_e / 2, zc]) rotate([0, 90, 0]) linear_extrude(1.5) circle(d = h * 0.45, $fn = 16);
}
// Nuten (Welt), z von zn - tiefe .. zn + 1 (oben offen) bzw. umgekehrt
module ct_nuten(Lc, zn, unten) let(z0 = unten ? zn - g_n - 0.2 : zn - 1, h = g_n + 1.2) {
    for (sy = [0, 1]) translate([cx_e, sy == 0 ? y_s0 - spiel : W_ct - cd - t_cw - spiel, z0]) cube([Lc - 2 * cx_e, t_tg + 2 * spiel, h]);
    if (unten) {
        translate([-1, cy_e, z0]) cube([cd + t_cw + spiel + 1, W_ct - 2 * cy_e, h]);
        translate([Lc - dt - t_cw - spiel, cy_e, z0]) cube([dt + t_cw + spiel + 1, W_ct - 2 * cy_e, h]);
    }
}
// ---- Boden (einfarbig: Rahmen) ----
module ct_boden(Lc, xs = []) difference() {
    union() {
        ct_ring(Lc, 0, z_f, rb, 0);
        translate([rb - 0.01, rb - 0.01, z_f - t_fl]) cube([Lc - 2 * rb + 0.02, W_ct - 2 * rb + 0.02, t_fl]);
        for (x = [0, Lc - cx_e], y = [0, W_ct - cy_e]) translate([x, y, 0]) cube([cx_e, cy_e, z_f]);
        for (xx = [p_r : p_r : Lc - p_r / 2]) translate([xx - t_r / 2, rb - 0.01, 0]) cube([t_r, W_ct - 2 * rb + 0.02, z_f]);
        for (sx = xs) translate([sx - spw / 2 - 1, rb - 0.01, 0]) cube([spw + 2, W_ct - 2 * rb + 0.02, z_f]);
    }
    ct_nuten(Lc, z_f, true);
}
// ---- Dach: A Dachblech, B Obergurte + Eckbeschläge ----
module ct_dach_b(Lc, o = 0) {
    ct_ring(Lc, H_ct - tr, tr, rb, o);
    for (x = [0, Lc - cx_e], y = [0, W_ct - cy_e]) translate([x - o, y - o, H_ct - hc - o]) cube([cx_e + 2 * o, cy_e + 2 * o, hc + 2 * o]);
}
module ct_dach(Lc, fp, xs = []) {
    module loecher() {
        ct_nuten(Lc, H_ct - tr, false);
        for (x = [in_x, Lc - in_x], y = [in_y, W_ct - in_y]) translate([x, y, H_ct - h_tw - 0.4]) {
            cylinder(r = r_zl, h = h_tw + 1, $fn = 24);
        }
    }
    if (inc(fp, "A")) difference() {
        union() {
            translate([rb, rb, H_ct - tr]) cube([Lc - 2 * rb, W_ct - 2 * rb, tr]);
            for (sx = xs) translate([sx - spw / 2 - 1, y_cs - 1, H_ct - tr - rib_h]) cube([spw + 2, W_ct - 2 * y_cs + 2, rib_h + 0.01]);
        }
        ct_dach_b(Lc, 0.02); loecher();
    }
    if (inc(fp, "B")) difference() { ct_dach_b(Lc); loecher(); }
}
// ---- Seitenwand (y = 0; die zweite ist um 180° gedreht) ----
module ct_seite(Lc) {
    xa = cx_e + spiel; xb = Lc - cx_e - spiel;
    n = floor((Lc - 2 * cx_e) / p_sk); x0 = (Lc - n * p_sk) / 2;
    translate([0, 0, z_f]) linear_extrude(z_wo - z_f) {
        translate([xa, cd]) square([xb - xa, t_cw]);
        for (k = [0 : n - 1]) let(x = x0 + k * p_sk) polygon([[x + 0.1 * p_sk, cd + 0.01], [x + 0.25 * p_sk, 0], [x + 0.6 * p_sk, 0], [x + 0.75 * p_sk, cd + 0.01]]);
    }
    for (z = [z_f - g_n, z_wo - 0.01]) translate([xa, y_s0, z]) cube([xb - xa, t_tg, g_n + 0.01]);
}
// ---- Stirnwand (x = 0) und Türseite (x = Lc): B Pfosten + Obergurt ----
module ct_end_b(Lc, tuer, o = 0) let(xo = tuer ? Lc - cx_e : 0) {
    for (y = [0, W_ct - cy_e]) translate([xo - o, y - o, z_f - o]) cube([cx_e + 2 * o, cy_e + 2 * o, H_ct - hc - z_f + 2 * o]);
    translate([xo - o, -o, z_e1 - o]) cube([cx_e + 2 * o, W_ct + 2 * o, h_tb + 2 * o]);
    translate([xo - o, cy_e + spiel - o, H_ct - hc - 0.01 - o]) cube([cx_e + 2 * o, W_ct - 2 * cy_e - 2 * spiel + 2 * o, hc - tr + 0.01 + 2 * o]);
}
module ct_stirn_a() {
    m = floor((W_ct - 2 * cy_e) / p_sk); y0 = (W_ct - m * p_sk) / 2;
    translate([0, 0, z_f]) linear_extrude(z_e1 - z_f + 0.01) {
        translate([cd, cy_e]) square([t_cw, W_ct - 2 * cy_e]);
        // V-Täler: außen unten gedruckt, keine flachen Decken
        for (k = [0 : m - 1]) let(y = y0 + k * p_sk) polygon([[cd + 0.01, y], [cd + 0.01, y + p_sk], [0, y + p_sk - cd], [0, y + cd]]);
    }
    translate([0, cy_e + spiel, z_f - g_n]) cube([cd + t_cw, W_ct - 2 * cy_e - 2 * spiel, g_n + 0.01]);   // Feder bis außen (liegt beim Druck auf)
}
module ct_tuer_a(Lc) difference() {
    union() {
        translate([Lc - dt - t_cw, cy_e, z_f]) cube([t_cw, W_ct - 2 * cy_e, z_e1 - z_f + 0.01]);
        for (f = [0.15, 0.37, 0.63, 0.85]) translate([Lc - dt - 0.01, f * W_ct - bw_t / 2, z_f]) cube([dt + 0.01, bw_t, z_e1 - z_f + 0.01]);
        translate([Lc - dt - 0.01, W_ct / 2 - bw_t * 0.75, z_f]) cube([dt + 0.01, bw_t * 1.5, z_e1 - z_f + 0.01]);   // Dichtleiste in der Mitte
        for (y = [cy_e, W_ct - cy_e - max(M(0.12), 1.2)], f = [0.15, 0.38, 0.62, 0.85])
            translate([Lc - dt - 0.01, y, z_f + f * (z_e1 - z_f) - max(M(0.05), 0.5)]) cube([dt + 0.01, max(M(0.12), 1.2), max(M(0.1), 1.0)]);
        translate([Lc - dt - t_cw, cy_e + spiel, z_f - g_n]) cube([dt + t_cw, W_ct - 2 * cy_e - 2 * spiel, g_n + 0.01]);   // Schwelle bis außen
    }
    translate([Lc + 0.01 - 0.3, W_ct / 2 - 0.2, z_f + 0.5]) cube([0.3, 0.4, z_e1 - z_f - 1]);   // Fuge zwischen den Flügeln
}
module ct_stirn(Lc, fp, tuer = false) {
    if (inc(fp, "A")) difference() { if (tuer) ct_tuer_a(Lc); else ct_stirn_a(); ct_end_b(Lc, tuer, 0.02); }
    if (inc(fp, "B")) ct_end_b(Lc, tuer);
}
// ---- Druck ----
module ct_druck(Lc, nm, fp, stk) {
    if (nm == "boden") split_out(info_boden(Lc), stk) translate([0, W_ct, z_f]) rotate([180, 0, 0]) ct_boden(Lc, ct_xs(Lc));
    else if (nm == "dach") split_out(info_dach(Lc), stk) translate([0, W_ct, H_ct]) rotate([180, 0, 0]) ct_dach(Lc, fp, ct_xs(Lc));
    else if (nm == "seite") split_out(info_seite(Lc), stk)
        multmatrix([[1, 0, 0, -(cx_e + spiel)], [0, 0, 1, -(z_f - g_n)], [0, -1, 0, cd + t_cw], [0, 0, 0, 1]]) ct_seite(Lc);
    else if (nm == "stirn") multmatrix([[0, 1, 0, 0], [0, 0, 1, -(z_f - g_n)], [1, 0, 0, 0], [0, 0, 0, 1]]) ct_stirn(Lc, fp);
    else if (nm == "tuer") multmatrix([[0, -1, 0, W_ct], [0, 0, 1, -(z_f - g_n)], [-1, 0, 0, Lc], [0, 0, 0, 1]]) ct_stirn(Lc, fp, true);
}
// ---- Zusammenbau (lokal) ----
module ct_welt(Lc, ex = 0) {
    translate([0, 0, -ex]) bunt(farbe_beschlag) ct_boden(Lc);
    translate([0, 0, ex]) { bunt(farbe_container) ct_dach(Lc, "A"); bunt(farbe_beschlag) ct_dach(Lc, "B"); }
    translate([0, -ex, 0]) bunt(farbe_container) ct_seite(Lc);
    translate([Lc, W_ct + ex, 0]) rotate([0, 0, 180]) bunt(farbe_container) ct_seite(Lc);
    translate([-ex, 0, 0]) { bunt(farbe_container) ct_stirn(Lc, "A"); bunt(farbe_beschlag) ct_stirn(Lc, "B"); }
    translate([ex, 0, 0]) { bunt(farbe_container) ct_stirn(Lc, "A", true); bunt(farbe_beschlag) ct_stirn(Lc, "B", true); }
}
CLIPS = clip_count(info_boden(L_c40)) * (len(ct_xs(L_c40)) > 0 ? 1 : 0) + clip_count(info_dach(L_c40)) * (len(ct_xs(L_c40)) > 0 ? 1 : 0)
      + clip_count(info_boden(L_c20)) * (len(ct_xs(L_c20)) > 0 ? 1 : 0) + clip_count(info_dach(L_c20)) * (len(ct_xs(L_c20)) > 0 ? 1 : 0);

// =====================================================================
//  Zusammenbau
// =====================================================================
module reachstacker(ex = 0) {
    bunt(farbe_gelb) fahrgestell_welt("A");
    bunt(farbe_rahmen) fahrgestell_welt("B");
    bunt(farbe_auspuff) fahrgestell_welt("C");
    translate([0, 0, ex]) { bunt(farbe_kabine) kabine_welt("A"); bunt(farbe_glas) kabine_welt("B"); }
    for (i = [0 : 3]) { bunt(farbe_reifen) rad_welt(i, "A", ex); bunt(farbe_felge) rad_welt(i, "B", ex); }
    for (sy = [-1, 1]) translate([0, sy * 0.6 * ex, 0]) bunt(farbe_gelb) kotfluegel_welt(sy);
    for (sy = [-1, 1]) bunt(farbe_gelaender) gelaender_welt(sy, 0.8 * ex);
    translate([0, 0, 1.6 * ex]) {
        ausleger_rahmen() {
            bunt(farbe_ausleger) aussen_lokal();
            translate([u_ir + auszug * HUB + 0.8 * ex, 0, 0]) { bunt(farbe_ausleger) innen_lokal("A"); bunt(farbe_kopf) innen_lokal("B"); }
        }
        K = kopf_welt(auszug) + [0.8 * ex * cos(a_w), 0.8 * ex * sin(a_w)];
        translate([K[0], 0, K[1] - 0.5 * ex]) {
            bunt(farbe_haenger) haenger();
            translate([0, 0, -d_n - h_bh - h_sd - 0.5 * ex]) rotate([0, 0, spreader_drehung]) {
                bunt(farbe_spreader) spreader_rahmen("A"); bunt(farbe_streifen) spreader_rahmen("B");
                for (r = [0, 180]) rotate([0, 0, r]) translate([0, -spreader_auszug * E40 - 0.5 * ex, 0]) bunt(farbe_arm) spreader_arm();
                if (container_zeigen) let(Lc = spreader_auszug > 0.5 ? L_c40 : L_c20)
                    translate([0, 0, ARM[3] - eb_h - H_ct - 1.2 * ex]) rotate([0, 0, 90]) translate([-Lc / 2, -W_ct / 2, 0]) {
                        ct_welt(Lc, 0.4 * ex);
                    }
            }
        }
    }
    for (sy = [-1, 1]) translate([0, 0, 0.8 * ex]) { bunt(farbe_zylinder) zylinder_welt(sy, "A", ex * 0.4); bunt(farbe_stange) zylinder_welt(sy, "B", ex * 0.4); }
}

// =====================================================================
//  Info und Ausgabe
// =====================================================================
function zm(v) = r2(v * den / 1000);          // mm -> Vorbild-Meter
z_tw0 = kopf_welt(0)[1] - d_n - h_bh - h_sd + ARM[3] - eb_h - h_tw;
z_tw1 = kopf_welt(1)[1] - d_n - h_bh - h_sd + ARM[3] - eb_h - h_tw;
KOL_K = [for (u = [u0 : 1 : u1]) for (w = [wb_o]) let(p = rot_aw([u, w])) if (p[0] > K_X[0] && p[0] < K_X[1] && p[1] < K_Z[1] + 0.3) 1];
KOL_B = [for (u = [u_kb - M(0.3) : 0.5 : u_kb + M(0.3)]) let(p = rot_aw([u, w_kb - r_e])) if (p[0] > K_X[0] - 1 && p[0] < K_X[1] + 1 && p[1] < K_Z[1] + 0.3) 1];
L_stift = [2 * (y_lb + t_lb) + 1, 2 * (yc + t_e / 2) + 1, 2 * (yc + t_e / 2) + 1, W_i];

echo(str("Reach Stacker 1:", den, " | Fahrgestell ", r2(L_ch), " x ", r2(M(breite_m)), " mm | Höhe (Ausleger) ",
         r2(max(rot_aw([u1, wb_o + H_o])[1], rot_aw([u0, wb_o + H_o])[1])), " mm | Winkel ", a_w, "°"));
echo(str("Grundrohr ", r2(L_o), " mm, Innenrohr ", r2(L_i), " mm, Hub ", r2(HUB), " mm | Hubzylinder ", r2(L_c), " mm | Aufhängung ", r2(d_n + h_bh), " mm"));
echo(str("Twistlock-Unterkante: eingefahren ", zm(z_tw0), " m, ausgefahren ", zm(z_tw1), " m (Vorbild) | Spreader 20'/40': ",
         r2(M(spreader_20_m)), " / ", r2(M(spreader_40_m)), " mm"));
echo(str("Filament-Bolzen Ø ", stift_d, ": Lager ", r2(L_stift[0]), " mm, Zylinder unten ", r2(L_stift[1]), " mm, oben ", r2(L_stift[2]), " mm, Kopf ", r2(L_stift[3]), " mm"));
echo(str("Mindestmaße: Rohrwand ", r2(t_o), " | Teleskoparm ", r2(ARM[1] - ARM[0]), " x ", r2(ARM[3] - ARM[2]), " | Geländer ", r2(b_g), " | Laschenspalt ", r2(T_t), " mm"));
echo(str("Container 20'/40': ", r2(L_c20), " / ", r2(L_c40), " x ", r2(W_ct), " x ", r2(H_ct), " mm | Zapfen Ø ", r2(d_tw), " x ", r2(h_tw),
         " mm, Bohrung Ø ", r2(2 * r_zl), " | 40' Boden/Dach ", n_pieces(info_boden(L_c40)), " Stück(e), Seitenwand ", n_pieces(info_seite(L_c40)),
         " Stück(e), ", CLIPS, " Clips", len(ct_xs(L_c40)) > 0 && zero_seams(info_boden(L_c40)) + zero_seams(info_dach(L_c40)) > 0 ? "  WARNUNG: Naht ohne Clip" : ""));
if (L_ch > usable) echo("WARNUNG: Fahrgestell länger als das Druckbett");
if (L_o + M(0.3) > usable) echo("WARNUNG: Grundrohr länger als das Druckbett");
if (L_i > usable) echo("WARNUNG: Innenrohr länger als das Druckbett – innen_sichtbar_m oder ausleger_hub_m verkleinern");
if (u_ir < u_cv + 0.5) echo("WARNUNG: Innenrohr stößt hinten an – innen_sichtbar_m vergrößern");
if (len(KOL_K) + len(KOL_B) > 0) echo("WARNUNG: Ausleger berührt die Kabine – ausleger_winkel vergrößern");
if (z_tw0 < 0) echo("WARNUNG: Spreader steht auf dem Boden");
if (T_t < 2 * r_h + 1.6) echo("WARNUNG: Aufhängung zu dünn für den Bolzen");
if (2 * eb_x > usable || y_ai - y_ae + eb_w > usable) echo("WARNUNG: Teleskoparm größer als das Druckbett");
mass_echo(L_ch, M(breite_m), rot_aw([u1, wb_o + H_o])[1]);

druck("fahrgestell", 1, "A", farbe_gelb, 1); druck("fahrgestell", 1, "B", farbe_rahmen, 1); druck("fahrgestell", 1, "C", farbe_auspuff, 1);
druck("kabine", 1, "A", farbe_kabine, 1); druck("kabine", 1, "B", farbe_glas, 1);
druck("rad_vorne", 1, "A", farbe_reifen, 2); druck("rad_vorne", 1, "B", farbe_felge, 2);
druck("rad_hinten", 1, "A", farbe_reifen, 2); druck("rad_hinten", 1, "B", farbe_felge, 2);
druck("kotfluegel_links", 1, "alle", farbe_gelb, 1); druck("kotfluegel_rechts", 1, "alle", farbe_gelb, 1);
druck("ausleger_aussen", 1, "alle", farbe_ausleger, 1);
druck("ausleger_innen", 1, "A", farbe_ausleger, 1); druck("ausleger_innen", 1, "B", farbe_kopf, 1);
druck("zylinder", 1, "A", farbe_zylinder, 2); druck("zylinder", 1, "B", farbe_stange, 2);
druck("haenger", 1, "alle", farbe_haenger, 1);
druck("spreader_rahmen", 1, "A", farbe_spreader, 1); druck("spreader_rahmen", 1, "B", farbe_streifen, 1);
druck("spreader_arm", 1, "alle", farbe_arm, 2);
druck("gelaender", 1, "alle", farbe_gelaender, 2);
for (c = [[20, L_c20], [40, L_c40]]) let(n = str("c", c[0], "_"), Lc = c[1]) {
    druck(str(n, "boden"), n_pieces(info_boden(Lc)), "alle", farbe_beschlag, 1);
    druck(str(n, "dach"), n_pieces(info_dach(Lc)), "A", farbe_container, 1); druck(str(n, "dach"), n_pieces(info_dach(Lc)), "B", farbe_beschlag, 1);
    druck(str(n, "seite"), n_pieces(info_seite(Lc)), "alle", farbe_container, 2);
    druck(str(n, "stirn"), 1, "A", farbe_container, 1); druck(str(n, "stirn"), 1, "B", farbe_beschlag, 1);
    druck(str(n, "tuer"), 1, "A", farbe_container, 1); druck(str(n, "tuer"), 1, "B", farbe_beschlag, 1);
}
if (CLIPS > 0) druck("verbinder", 1, "alle", farbe_clips, 1);
farben_echo();

if (teil == "aufbau") reachstacker();
else if (teil == "explosion") reachstacker(max(M(1.5), 14));
else if (teil == "fahrgestell") fahrgestell_druck(farbteil);
else if (teil == "kabine") kabine_druck(farbteil);
else if (teil == "rad_vorne") rad(farbteil, true);
else if (teil == "rad_hinten") rad(farbteil);
else if (teil == "kotfluegel_links") kotfluegel_druck(1);
else if (teil == "kotfluegel_rechts") kotfluegel_druck(-1);
else if (teil == "ausleger_aussen") aussen_druck();
else if (teil == "ausleger_innen") innen_druck(farbteil);
else if (teil == "zylinder") zylinder(farbteil);
else if (teil == "haenger") haenger_druck();
else if (teil == "spreader_rahmen") rahmen_druck(farbteil);
else if (teil == "spreader_arm") spreader_druck();
else if (teil == "gelaender") gelaender_druck();
else if (starts(teil, "c20_")) ct_druck(L_c20, chr([for (i = [4 : len(teil) - 1]) ord(teil[i])]), farbteil, stueck);
else if (starts(teil, "c40_")) ct_druck(L_c40, chr([for (i = [4 : len(teil) - 1]) ord(teil[i])]), farbteil, stueck);
else if (teil == "verbinder") verbinder_platten(max(CLIPS, 4), stueck);
