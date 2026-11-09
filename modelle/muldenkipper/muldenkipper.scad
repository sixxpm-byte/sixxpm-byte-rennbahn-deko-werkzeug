// =====================================================================
//  MULDENKIPPER  –  Starrrahmen-Muldenkipper der 180-t-Klasse
//  Vorbild: Cat 789D (Radstand 5,70 m, Reifen 37.00R57, Breite 7,67 m)
//  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei), Farben je Bauteil,
//  Maßstab 1:43 / 1:87.  Räder drehen sich, die Mulde kippt (Teleskop-Kippzylinder).
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    rahmen          Längsträger mit Hinterachsbrücke, Kraftstoff- und Hydrauliktank,
//                    Muldenauflagen, Deckstützen und Radzapfen hinten              1x
//    vorbau          Motorhaube, Kühlerhaus, Stoßstange, Scheinwerferkästen und
//                    Federbeine mit Radzapfen vorne – auf die Längsträger gesteckt 1x
//    kuehlergrill    Kühlergrill, in die Tasche des Kühlerhauses gedrückt          1x
//    leuchte         Scheinwerferplatte mit 4 Leuchten, in den Kasten gedrückt     2x
//    oberdeck        Oberdeck über den Vorderrädern                                1x
//    kabine          Fahrerkabine (unten offen) + Glaskern, von unten eingeschoben 1x
//    gelaender_vorne_rechts / gelaender_vorne_links / gelaender_seite_rechts /
//    gelaender_seite_links   Geländer (flach gedruckt, in Löcher im Oberdeck) je 1x
//    treppe          Diagonaltreppe vor dem Kühler (flach gedruckt)                1x
//    leiter          Aufstiegsleiter an der Stoßstange (flach gedruckt)            2x
//    rad_vorne       Rad vorne, Felge von außen in den Reifen gedrückt             2x
//    rad_hinten      Zwillingsrad hinten, Felge von außen gedrückt                 2x
//    mulde           Mulde mit Bordwand-Rippen, Obergurt und Stirnwand             1x
//    schutzdach      Schutzdach über Kabine und Deck, auf die Stirnwand gesteckt   1x
//    muldentraeger   Muldenträger mit Kipplager und Zylinderauge (flach gedruckt)  2x
//    zylinder        Kippzylinder: Rohr (A) + Kolbenstange (B), teleskopisch       2x
//    spiegel         Außenspiegel mit Halter (flach gedruckt, ins Oberdeck)        2x
//    auspuff         Schalldämpfer mit Endrohr (auf Zapfen im Oberdeck)            2x
//    rueckleuchte    Rückleuchte (Steckzunge ins Rahmenende)                      2x
//    achszapfen_vorne / achszapfen_hinten  Rautenzapfen für die Räder, flach
//                    gedruckt (Schichten längs), in Rautenlöcher gesteckt      je 2x
//
//  BOLZEN
//    3 Filament-Stücke Ø stift_d (Längen siehe Echo): Kipplager, Zylinder oben,
//    Zylinder unten.  Die Bolzen drehen sich lose im Rahmen bzw. in den Muldenträgern,
//    in den Zylinderaugen und in den Lageraugen der Muldenträger sitzen sie stramm.
//  BEWEGLICH
//    * Räder drehen sich auf den Achszapfen (Raute in runder Bohrung).
//    * Die Mulde kippt am Kipplager; die Kolbenstangen gleiten in den Rohren und halten
//      die Mulde durch Reibung in jeder Stellung (zylinder_spiel).
//  FARBTEILE
//    Alle Farbbauteile werden gesteckt (Felgen, Glaskern, Kühlergrill, Leuchten,
//    Kolbenstangen, Geländer, Spiegel, Auspuff, Rückleuchten).  Nur die dunkle Kante am Schutzdach ist eine Farbzone
//    (dünnes Inlay, mit AMS/MMU oder einfarbig).
//  DRUCK
//    Alle Teile stützfrei: Rahmen, Vorbau und Mulde aufrecht, Kabine und Schutzdach
//    kopfüber, Oberdeck flach, Geländer/Treppe/Leiter/Muldenträger flach liegend,
//    Zylinder liegend, Räder mit der Innenseite auf dem Bett.
//  MONTAGE (Kurzfassung)
//    0. Felgen in die Reifen, Glaskern in die Kabine, Kühlergrill und Leuchten in den
//       Vorbau, Kolbenstangen in die Rohre schieben.
//    1. Vorbau auf die Zungen der Längsträger stecken, Achszapfen einstecken, Räder aufschieben.
//    2. Oberdeck auf den Vorbau, Kabine und Geländer ins Deck, Treppe und Leitern stecken.
//    3. Zylinder unten mit Bolzen an den Rahmen.
//    4. Muldenträger in den Muldenboden, Mulde mit dem Kipplager-Bolzen an den Rahmen,
//       Zylinder oben mit Bolzen an die Muldenträger.  Schutzdach aufstecken.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, rahmen:Rahmen mit Hinterachse, vorbau:Vorbau mit Kühler und Federbeinen, kuehlergrill:Kühlergrill, leuchte:Scheinwerferplatte (2x), oberdeck:Oberdeck, kabine:Fahrerkabine mit Glaskern, gelaender_vorne_rechts:Geländer vorne rechts, gelaender_vorne_links:Geländer vorne links, gelaender_seite_rechts:Geländer Seite rechts, gelaender_seite_links:Geländer Seite links, treppe:Diagonaltreppe, leiter:Leiter (2x), rad_vorne:Rad vorne (2x), rad_hinten:Zwillingsrad hinten (2x), mulde:Mulde, schutzdach:Schutzdach, muldentraeger:Muldenträger (2x), zylinder:Kippzylinder (2x), spiegel:Außenspiegel (2x), auspuff:Auspuff (2x), rueckleuchte:Rückleuchte (2x), achszapfen_vorne:Achszapfen vorne (2x), achszapfen_hinten:Achszapfen hinten (2x)]
stueck = 0;
farbteil = "alle"; // [alle, A, B]

/* [Vorschau] */
// Kippwinkel der Mulde in der Vorschau (0 = abgesenkt)
mulde_winkel = 0; // [0:1:45]

/* [Muldenkipper (Vorbild in Metern)] */
laenge_m = 12.65;
radstand_m = 5.7;
// Vorderachse bis Stoßstange
ueberhang_vorne_m = 3.05;
spur_vorne_m = 5.41;
// Mitte der Zwillingsräder
spur_hinten_m = 4.625;
rad_d_m = 3.58;
rad_b_m = 0.94;
felge_d_m = 1.45;
zwilling_luft_m = 0.1;
// Breite über Mulde und Schutzdach
breite_m = 7.67;
// Oberkante der Bordwände
mulde_hoehe_m = 6.0;
// Oberkante Schutzdach
dach_hoehe_m = 6.5;
deck_hoehe_m = 3.85;
kabine_hoehe_m = 5.4;
// größter Kippwinkel (prüft die Zylinderlänge)
kippwinkel = 45; // [30:1:50]

/* [Farben] */
farbe_gelb      = "catgelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_mulde     = "catgelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_dachkante = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_kabine    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_glas      = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_grill     = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_leuchte   = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_gelaender = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_reifen    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_felge     = "catgelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_zylinder  = "catgelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_stange    = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_spiegel   = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_auspuff   = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]
farbe_ruecklicht = "rot";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb]

/* [Druck & Passung] */
rennbahn_taschen = true;   // (keine Bodenplatte – bleibt für die Bibliothek stehen)
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;
stift_d = 1.75;
// Luft je Seite zwischen Kolbenstange und Rohr (klein = Mulde hält besser)
zylinder_spiel = 0.1;
// Luft je Seite für eingepresste Teile (Felge, Glaskern, Grill, Leuchten, Zapfen; 0 = sehr stramm)
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
          ["hellblau", "#5aa2dc"], ["dunkelgruen", "#1f6b3a"], ["puderblau", "#8cc8ea"], ["catgelb", "#eeb111"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

// =====================================================================
//  Maße (Welt: x = 0 Hinterachse, +x nach vorne, +y links, z = 0 Boden; mm)
// =====================================================================
function K(m) = m * 1000 / den;            // Koordinate (Vorbild-Meter -> mm, auch negativ)
function KP(p) = [K(p[0]), K(p[1])];
es    = einsatz_spiel;

// Räder
X_fa  = K(radstand_m);
X_fb  = K(radstand_m + ueberhang_vorne_m);
X_t   = X_fb - K(laenge_m);                // Muldenende
R_w   = K(rad_d_m / 2);  z_ax = R_w;
B_w   = K(rad_b_m);
g_zw  = max(K(zwilling_luft_m), 0.8);
B_zw  = 2 * B_w + g_zw;
R_fe  = K(felge_d_m / 2);
y_fi  = K(spur_vorne_m / 2) - B_w / 2;      // Innenseite Vorderrad
y_hi  = K(spur_hinten_m / 2) - B_zw / 2;    // Innenseite Zwillingsrad
g_r   = max(M(0.03), 0.4);                  // Luft Rad - Fahrzeug
d_rz  = max(M(0.3), 3);                     // Radzapfen (Raute)
function h_hub(zw) = (zw ? B_zw : B_w) - max(M(0.08), 0.8);   // Nabenloch-Tiefe
a_az  = d_rz / sqrt(2);                    // Achszapfen: Vierkant, in der Welt als Raute (Diagonale d_rz)
l_in  = max(M(0.35), 3);                   // Einstecktiefe im Federbein / in der Achsbrücke

// Bolzen
r_h   = (stift_d + 0.25) / 2;               // lose
r_pr  = stift_d / 2 + es;                   // stramm
r_e   = max(M(0.22), r_h + 1.2);            // Augen

// Rahmen
Z_rb  = K(1.45);  Z_rt = K(2.9);
Y_r0  = K(0.3);   Y_r1 = K(0.6);
X_r0  = K(-2.45); X_j  = K(5.35);
a_h   = z_ax - Z_rb;                        // Achsbrücke: Achteck, Unterseite auf dem Bett
w_tg  = max(M(0.12), 1.6);  l_t = max(M(0.35), 3);   // senkrechte Steckzungen Rahmen -> Vorbau
z_tg  = Z_rt - K(0.25);

// Kipplager, Zylinderaugen (Welt x-z)
P_pv  = KP([-1.9, 2.55]);                   // Kipplager
F_zy  = KP([5.0, 1.75]);                    // Zylinder unten (Rahmen)
B_zy  = KP([1.4, 3.4]);                     // Zylinder oben (Muldenträger, Mulde abgesenkt)

// Mulde
Z_fu  = K(3.75);                            // Unterkante Muldenboden
Z_top = K(mulde_hoehe_m);
Y_b   = K(2.95);  Y_t = K(3.6);  Y_tr = K(breite_m / 2);
X_fw0 = K(3.85);  X_fw1 = K(4.55);          // Stirnwand unten / oben
t_m   = max(M(0.08), 1.6);
t_bo  = max(M(0.2), 2.4);
h_tr  = max(M(0.3), 2.0);                   // Obergurt
c_tl  = K(0.7);                             // 45°-Fase unter dem Muldenende (Heck steigt an)
k_s   = (Y_t - Y_b) / (Z_top - Z_fu);
function ys(z) = Y_b + (z - Z_fu) * k_s;
tw_s  = t_m * sqrt(1 + k_s * k_s);
tphi  = (X_fw1 - X_fw0) / (Z_top - Z_fu);
t_fw  = t_m * sqrt(1 + tphi * tphi);
function xfi(z) = X_fw0 - t_fw + (z - Z_fu) * tphi;   // Innenseite Stirnwand
d_p   = max(M(0.16), 2.0);  l_p = max(M(0.25), 2.5); // Steckzapfen (Raute)
w_fb  = max(M(0.5), d_p + t_fw + 2.4);       // Stirnwand-Gurt (Auflage Schutzdach)
h_fb  = l_p + max(M(0.1), 1.0);
x_fb  = X_fw1 - w_fb;
x_ph  = x_fb + (w_fb - t_fw) / 2;
DACH_Y = [-K(2.2), 0, K(2.2)];
RIB_X = [for (m = [-3.0, -1.8, -0.6, 0.6, 1.8, 3.0]) K(m)];
w_rb  = max(M(0.12), 1.2);  p_rb = max(M(0.1), 0.8);

// Muldenträger
t_mt  = max(M(0.15), 1.6);
Y_m0  = Y_r1 + spiel;  Y_m1 = Y_m0 + t_mt;
Z_mb  = K(2.65);
X_m0  = K(-2.3);
h_tab = t_bo - max(M(0.05), 0.6);
w_tab = max(M(0.4), 3);
TAB_X = [K(-1.2), K(0.6)];
r_e2  = max(M(0.25), r_pr + 1.4);

// Zylinder (gedruckt liegend: Achse x, Augen flach auf dem Bett)
r_s   = max(M(0.12), 1.2);                  // Kolbenstange (Tropfen, flache Unterseite)
r_b   = r_s + zylinder_spiel;
hs    = 0.7071 * r_s;
r_o   = max(M(0.2), (2.12 * r_b + min_wand) / 1.707, (sqrt(r_b * r_b - hs * hs) + min_wand) / 0.7071);
hz    = 0.7071 * r_o;
t_e   = max(M(0.16), 2.0);
y_e0  = Y_m1 + max(M(0.03), 0.3);           // Innenseite der Zylinderaugen
x_b0  = r_e + min_wand;                     // Boden der Bohrung
g_tz  = max(M(0.08), 1.0);
function rotP(p, a) = let(dx = p[0] - P_pv[0], dz = p[1] - P_pv[1])
    [P_pv[0] + dx * cos(a) - dz * sin(a), P_pv[1] + dx * sin(a) + dz * cos(a)];
function L_zy(a) = norm(rotP(B_zy, a) - F_zy);
L0    = L_zy(0);
L_tb  = L0 - r_e - g_tz;                    // Rohrende
function ov(a) = L_tb - (x_b0 + L_zy(a) - L0);   // Überdeckung Stange im Rohr
ov_min = max(4 * r_s, M(0.4));

// Oberdeck
Z_dk  = K(deck_hoehe_m);
t_d   = max(M(0.15), 1.6);
Z_db  = Z_dk - t_d;
X_d0  = K(4.3);  X_df = K(8.0);  Y_d = K(3.2);

// Vorbau
Z_vb  = K(1.15);
X_ra  = K(7.4);  X_gf = K(7.95);            // Kühlerhaus hinten / Grill-Ebene
Y_h   = K(1.15); Y_ra = K(1.35);
Z_bu  = K(1.75); Y_bu = K(2.5);             // Stoßstange
Y_fs  = K(1.95); r_fs = K(0.25);            // Federbeine
w_web = max(M(0.2), 1.6);
X_l0  = K(7.45); Y_l1 = K(2.15); Z_l0 = K(2.75);   // Scheinwerferkasten
d_e   = max(M(0.1), 1.6);                   // Tiefe der Einsatz-Taschen
GR    = [-K(1.15), K(1.15), K(1.9), K(3.2)];       // Grill [y0, y1, z0, z1]
LT    = [K(1.45), K(2.05), K(2.85), K(3.6)];       // Leuchte (linke Seite)
VB_PIN = [[K(6.0), K(0.6)], [K(6.0), -K(0.6)], [K(7.65), K(0.95)], [K(7.65), -K(0.95)]];
DS_X  = [K(4.5), K(4.85)];                  // Deckstütze auf den Längsträgern
AU_X  = [K(3.2), K(3.7)];                   // Muldenauflage

// Kabine
K_X   = [K(4.65), K(6.75)];
K_Y   = [K(1.1), K(3.1)];
K_Z   = [Z_dk, K(kabine_hoehe_m)];
t_k   = max(M(0.08), 1.2);
t_kr  = max(M(0.1), 1.2);
p_k   = max(M(0.25), d_p + 1.6);
c_kd  = M(0.12);

// Geländer, Treppe, Leiter
H_g   = M(1.1);
b_g   = max(M(0.06), 0.8);
t_g   = max(M(0.06), 1.2);
l_gz  = t_d;
X_gv  = X_df - K(0.1);                      // Geländer vorne (Mitte der Ebene)
Y_gs  = Y_d - K(0.1);                       // Geländer Seite
GEL   = [  // [Name, Richtung (0 = entlang y, 1 = entlang x), von, bis, Ebene]
    ["vorne_rechts", 0, -K(3.1), K(0.85), X_gv],
    ["vorne_links",  0,  K(1.5), K(3.1),  X_gv],
    ["seite_rechts", 1,  K(4.45), K(7.75), -Y_gs],
    ["seite_links",  1,  K(6.85), K(7.75),  Y_gs]];
X_st  = [K(8.0), K(8.6)];
YS    = [-K(1.3), K(1.3)];
n_st  = 9;
a_st  = (YS[1] - YS[0]) / n_st;
r_st  = (Z_dk - Z_bu) / n_st;
h_sv  = M(0.45);                            // Wangenhöhe (senkrecht)
l_tb  = max(M(0.2), 2.0);                   // Steckzungen Treppe/Leiter
w_ts  = max(M(0.35), 2.4);
TT    = [K(0.85), K(1.15), K(3.27), K(3.45)];   // obere Zunge (y0, y1, z0, z1) ins Kühlerhaus
Y_le  = K(2.25);  w_le = M(0.5);  Z_le0 = K(0.45);
t_le  = max(M(0.06), 1.2);
X_le  = X_fb - K(0.3);

// Spiegel, Auspuff, Rückleuchten
x_sp  = K(7.3);  y_sp = Y_gs - K(0.25);     // Spiegelhalter (Mitte) auf dem Deck
H_sp  = M(1.5);  b_sp = max(M(0.08), 1.0);  t_sp = max(M(0.08), 1.2);
u_sp  = K(3.65) - y_sp;  w_hd = M(0.4);  h_hd = M(0.6);
AP    = [[K(4.85), -K(2.05)], [K(4.85), -K(2.6)]];   // Schalldämpfer auf dem Deck
r_mu  = max(M(0.24), d_p / 2 + 1.2);  h_mu = M(1.0);
r_pi  = max(M(0.1), 0.9);  h_pi = M(0.65);
l_dp  = min(l_p, h_mu - 1);
z_rl  = K(1.95);  y_rl = (Y_r0 + Y_r1) / 2;
w_rl  = max(M(0.32), d_p + 2.4);  d_rl = max(M(0.18), l_p * 0.6 + 1);
l_rl  = l_p;  w_rp = max(d_p * 0.8, 1.6);  h_rp = max(d_p * 0.6, 1.2);   // Steckzunge (unten bündig)

// Schutzdach
X_c1  = K(8.5);
Z_c1  = K(dach_hoehe_m);
t_cp  = max(M(0.15), 1.6);
h_sk  = M(0.45);
w_ks  = M(0.3);  d_ks = max(M(0.03), 0.4);  // dunkle Kante (Inlay oben)

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
//  Hilfen
// =====================================================================
module raute2(d) rotate(45) square(d / sqrt(2), center = true);
module yz(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0, convexity = 6) children();   // 2D (y,z) entlang x
module xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 6) children();    // 2D (x,z) entlang y
module hole_y(p, r, y0, y1) xz(y0, y1) translate(p) rotate(90) teardrop(r);       // waagerechte Bohrung, Spitze oben
// waagerechte Rautenzapfen: senkrechte Diagonale d, waagerechte 0,8 d (Flanken steiler als 45°)
module raute_y(x, z, y0, l, d) translate([x, y0, z]) rotate([-90, 0, 0]) linear_extrude(l) scale([0.8, 1]) raute2(d);
module raute_x(x0, y, z, l, d) translate([x0, y, z]) rotate([0, 90, 0]) linear_extrude(l) scale([1, 0.8]) raute2(d);
// Rautenzapfen nach oben mit Fase
module rstift(d, h) let(c = min(0.4, d * 0.2)) {
    linear_extrude(h - c + 0.01) raute2(d);
    translate([0, 0, h - c]) linear_extrude(c, scale = (d - 2 * c) / d) raute2(d);
}
module bunt(f) color(fhex(f)) render(convexity = 6) children();
// Einsatz-Tasche in einer Front (Normale +x) mit 45°-Decke; Einsatz = gleiche Form minus Spiel
module tasche_2d(xf, z0, z1, d, o) polygon([[xf + 1, z0 - o], [xf - d - o, z0 - o], [xf - d - o, z1 - d + o], [xf, z1 + o + 0.01], [xf + 1, z1 + o + 0.01]]);
module einsatz_2d(xf, z0, z1, d) polygon([[xf - es, z0 + es], [xf - d + es, z0 + es], [xf - d + es, z1 - d - es * 0.4], [xf - es, z1 - es * 2.4]]);
// Druck einer Front-Platte: Rückseite (x = xf - d) auf dem Bett
module front_druck(xf, d) multmatrix([[0, 1, 0, 0], [0, 0, 1, 0], [1, 0, 0, -(xf - d + es)], [0, 0, 0, 1]]) children();
// Druck flacher Teile mit Ebene y-z (Vorderseite x = x1 auf dem Bett)
module yz_druck(x1) multmatrix([[0, 1, 0, 0], [0, 0, -1, 0], [-1, 0, 0, x1], [0, 0, 0, 1]]) children();
// Druck flacher Teile mit Ebene x-z (Seite y = y1 auf dem Bett)
module xz_druck(y1) multmatrix([[1, 0, 0, 0], [0, 0, 1, 0], [0, -1, 0, y1], [0, 0, 0, 1]]) children();

// =====================================================================
//  Rahmen
// =====================================================================
module rahmen_tank(sy) let(x0 = K(2.05), x1 = K(3.75), y0 = K(1.3), y1 = K(2.25), z1 = K(2.85), c = M(0.15)) {
    translate([0, 0, 0]) hull() {
        translate([x0, sy > 0 ? y0 : -y1, Z_rb]) cube([x1 - x0, y1 - y0, z1 - Z_rb - c]);
        translate([x0 + c, sy > 0 ? y0 + c : -y1 + c, Z_rb]) cube([x1 - x0 - 2 * c, y1 - y0 - 2 * c, z1 - Z_rb]);
    }
    // Halter unter dem Zylinder bis zum Längsträger
    translate([K(2.4), sy > 0 ? Y_r1 - 0.01 : -y0 - 0.01, Z_rb]) cube([K(1.0), y0 - Y_r1 + 0.02, K(0.35)]);
}
module rahmen_koerper() difference() {
    union() {
        // Längsträger (hinten oben gefast)
        for (sy = [-1, 1]) xz(sy > 0 ? Y_r0 : -Y_r1, sy > 0 ? Y_r1 : -Y_r0)
            polygon([[X_r0, Z_rb], [X_j, Z_rb], [X_j, Z_rt], [X_r0 + K(0.45), Z_rt], [X_r0, Z_rt - K(0.6)]]);
        // Querträger (Brücken zwischen den Längsträgern)
        for (q = [[K(-1.2), K(0.3)], [K(2.6), K(0.35)], [K(4.6), K(0.35)]])
            translate([q[0] - q[1] / 2, -Y_r0 - 0.01, Z_rt - K(0.5)]) cube([q[1], 2 * Y_r0 + 0.02, K(0.5)]);
        // Hinterachsbrücke (Achteck, liegt auf dem Bett) und Differential
        translate([0, y_hi - g_r, z_ax]) rotate([90, 0, 0]) linear_extrude(2 * (y_hi - g_r)) rotate(22.5) circle(r = a_h / cos(22.5), $fn = 8);
        let(a_d = K(0.5)) translate([0, K(0.5), Z_rb + a_d]) rotate([90, 0, 0]) linear_extrude(K(1.0)) rotate(22.5) circle(r = a_d / cos(22.5), $fn = 8);
        // Tanks
        for (sy = [-1, 1]) rahmen_tank(sy);
        // Muldenauflagen und Deckstützen
        for (sy = [-1, 1]) {
            translate([AU_X[0], sy > 0 ? Y_r0 : -Y_r1, Z_rt - 0.01]) cube([AU_X[1] - AU_X[0], Y_r1 - Y_r0, Z_fu - Z_rt + 0.01]);
            translate([DS_X[0], sy > 0 ? Y_r0 : -Y_r1, Z_rt - 0.01]) cube([DS_X[1] - DS_X[0], Y_r1 - Y_r0, Z_db - Z_rt + 0.01]);
        }
        // Distanzstücke am unteren Zylinderauge (Unterseite 45°)
        for (sy = [-1, 1]) let(rs = r_e, y2 = y_e0 - 0.2) intersection() {
            translate([F_zy[0] - rs, 0, 0]) yz(0, 2 * rs) polygon(sy > 0
                ? [[Y_r1 - 0.01, F_zy[1] - rs - (y2 - Y_r1)], [Y_r1 - 0.01, F_zy[1] + rs], [y2, F_zy[1] + rs], [y2, F_zy[1] - rs]]
                : [[-Y_r1 + 0.01, F_zy[1] - rs - (y2 - Y_r1)], [-Y_r1 + 0.01, F_zy[1] + rs], [-y2, F_zy[1] + rs], [-y2, F_zy[1] - rs]]);
            translate([-500, -500, Z_rb]) cube([1000, 1000, 1000]);
        }
        // Steckzungen zum Vorbau (senkrecht, stehen auf dem Bett)
        for (sy = [-1, 1]) translate([X_j - 0.01, sy * (Y_r0 + Y_r1) / 2 - w_tg / 2, Z_rb]) cube([l_t + 0.01, w_tg, z_tg - Z_rb]);
    }
    // Rautenlöcher für die Achszapfen hinten, Schlitze für die Rückleuchten
    for (sy = [-1, 1]) rotate([0, 0, sy > 0 ? 0 : 180]) translate([0, y_hi - g_r - l_in - 0.3, z_ax]) rotate([-90, 0, 0]) linear_extrude(l_in + 1) raute2(d_rz + 2 * es);
    for (sy = [-1, 1]) translate([X_r0 - 1, sy * y_rl - w_rp / 2 - es, z_rl - w_rl / 2 - es]) cube([l_rl + 1.3, w_rp + 2 * es, h_rp + 2 * es]);
    hole_y(P_pv, r_h, -Y_r1 - 1, Y_r1 + 1);
    hole_y(F_zy, r_h, -y_e0 - 1, y_e0 + 1);
}
module rahmen_druck() translate([0, 0, -Z_rb]) rahmen_koerper();

// =====================================================================
//  Vorbau
// =====================================================================
module vorbau_koerper() difference() {
    union() {
        // Motorhaube und Kühlerhaus
        translate([X_j, -Y_h, Z_vb]) cube([X_ra - X_j + 0.01, 2 * Y_h, Z_db - Z_vb]);
        translate([X_ra, -Y_ra, Z_vb]) cube([X_gf - X_ra, 2 * Y_ra, Z_db - Z_vb]);
        // Stoßstange
        translate([X_gf - 0.01, -Y_bu, Z_vb]) cube([X_fb - X_gf + 0.01, 2 * Y_bu, Z_bu - Z_vb]);
        // Scheinwerferkästen (Unterseite 45°)
        for (sy = [-1, 1]) yz(X_l0, X_gf) polygon(sy > 0
            ? [[Y_ra - 0.01, Z_l0 - (Y_l1 - Y_ra)], [Y_ra - 0.01, Z_db], [Y_l1, Z_db], [Y_l1, Z_l0]]
            : [[-Y_ra + 0.01, Z_l0 - (Y_l1 - Y_ra)], [-Y_ra + 0.01, Z_db], [-Y_l1, Z_db], [-Y_l1, Z_l0]]);
        // Federbeine mit Stegen zur Haube, Radzapfen vorne
        for (sy = [-1, 1]) {
            translate([X_fa, sy * Y_fs, Z_vb]) cylinder(r = r_fs, h = Z_db - Z_vb, $fn = 32);
            translate([X_fa - w_web / 2, sy > 0 ? Y_h - 0.01 : -Y_fs, Z_vb]) cube([w_web, Y_fs - Y_h + 0.01, Z_db - Z_vb]);
        }
        // Zapfen ins Oberdeck
        for (p = VB_PIN) translate([p[0], p[1], Z_db - 0.01]) rstift(d_p, t_d + 0.01);
    }
    // Taschen: Grill, Leuchten
    translate([0, GR[0] - es, 0]) xz(0, GR[1] - GR[0] + 2 * es) tasche_2d(X_gf, GR[2], GR[3], d_e, es);
    for (sy = [-1, 1]) translate([0, sy > 0 ? LT[0] - es : -LT[1] - es, 0]) xz(0, LT[1] - LT[0] + 2 * es) tasche_2d(X_gf, LT[2], LT[3], d_e, es);
    // Steckzungen: Treppe oben (Kühlerhaus), Treppe unten (Stoßstange), Leitern (Unterseite Stoßstange)
    translate([X_gf - l_tb - 0.3, TT[0] - es, TT[2] - es]) cube([l_tb + 1.3, TT[1] - TT[0] + 2 * es, TT[3] - TT[2] + 2 * es]);
    translate([X_st[0] - es, YS[0] - es, Z_bu - l_tb - 0.3]) cube([X_st[1] - X_st[0] + 2 * es, w_ts + 2 * es, l_tb + 1.3]);
    for (sy = [-1, 1], dy = [-1, 1]) translate([X_le - es, sy * Y_le + dy * (w_le / 2 - b_g / 2) - b_g / 2 - es, Z_vb - 1]) cube([t_le + 2 * es, b_g + 2 * es, l_tb + 1.3]);
    // Schlitze für die Steckzungen der Längsträger (unten offen)
    for (sy = [-1, 1]) translate([X_j - 1, sy * (Y_r0 + Y_r1) / 2 - w_tg / 2 - es, Z_vb - 1]) cube([l_t + 1.3, w_tg + 2 * es, z_tg + es - Z_vb + 1]);
    // Rautenlöcher für die Achszapfen vorne
    for (sy = [-1, 1]) rotate([0, 0, sy > 0 ? 0 : 180]) translate([sy > 0 ? X_fa : -X_fa, Y_fs + r_fs - l_in, z_ax]) rotate([-90, 0, 0]) linear_extrude(l_in + 1) raute2(d_rz + 2 * es);
}
module vorbau_druck() translate([0, 0, -Z_vb]) vorbau_koerper();

// Kühlergrill (Welt): Platte in der Tasche, senkrechte Lamellen
module grill_welt() let(xb = X_gf - M(0.05)) intersection() {
    translate([0, GR[0] + es, 0]) xz(0, GR[1] - GR[0] - 2 * es) einsatz_2d(X_gf, GR[2], GR[3], d_e);
    union() {
        translate([X_gf - d_e, -K(2), 0]) cube([xb - X_gf + d_e, K(4), K(5)]);
        let(n = max(7, round((GR[1] - GR[0]) / max(M(0.18), 1.6))), p = (GR[1] - GR[0]) / n, w = max(p * 0.45, 0.8))
            for (i = [0 : n]) translate([X_gf - d_e, GR[0] + i * p - w / 2, 0]) cube([d_e - es, w, K(5)]);
        // Rahmen
        difference() { translate([X_gf - d_e, -K(2), 0]) cube([d_e - es, K(4), K(5)]);
                       translate([X_gf - d_e - 1, GR[0] + max(M(0.08), 0.8), GR[2] + max(M(0.08), 0.8)]) cube([d_e + 2, GR[1] - GR[0] - 2 * max(M(0.08), 0.8), GR[3] - GR[2] - d_e - 2 * max(M(0.08), 0.8)]); }
    }
}
module grill_druck() front_druck(X_gf, d_e) grill_welt();

// Scheinwerferplatte (Welt, linke Seite): Platte mit 4 Leuchten
r_lt = max(M(0.13), 1.0);
module leuchte_welt(sy = 1) let(yc = (LT[0] + LT[1]) / 2, zc = (LT[2] + LT[3] - d_e) / 2, dy = (LT[1] - LT[0]) / 4, dz = (LT[3] - d_e - LT[2]) / 4)
    mirror([0, sy > 0 ? 0 : 1, 0]) {
        translate([0, LT[0] + es, 0]) xz(0, LT[1] - LT[0] - 2 * es) einsatz_2d(X_gf, LT[2], LT[3], d_e);
        for (a = [-1, 1], b = [-1, 1]) translate([X_gf - es - 0.01, yc + a * dy, zc + b * dz]) rotate([0, 90, 0]) cylinder(r = min(r_lt, dy * 0.85, dz * 0.85), h = max(M(0.06), 0.6), $fn = 24);
    }
module leuchte_druck() front_druck(X_gf, d_e) leuchte_welt(1);

// =====================================================================
//  Oberdeck
// =====================================================================
function gel_posts(L) = let(n = max(1, round(L / M(1.1)))) [for (i = [0 : n]) b_g / 2 + i * (L - b_g) / n];
module oberdeck_welt() difference() {
    union() {
        translate([X_d0, -Y_d, Z_db]) cube([X_df - X_d0, 2 * Y_d, t_d]);
        for (p = AP) translate([p[0], p[1], Z_dk - 0.01]) rstift(d_p, l_dp + 0.01);
    }
    for (sy = [-1, 1]) translate([x_sp - t_sp / 2 - es, sy * y_sp - b_sp / 2 - es, Z_db - 1]) cube([t_sp + 2 * es, b_sp + 2 * es, t_d + 2]);
    for (p = VB_PIN) translate([p[0], p[1], Z_db - 1]) linear_extrude(t_d + 2) raute2(d_p + 2 * es);
    for (p = kab_pins()) translate([p[0], p[1], Z_db - 1]) linear_extrude(t_d + 2) raute2(d_p + 2 * es);
    for (g = GEL) for (u = gel_posts(g[3] - g[2])) let(c = g[2] + u)
        if (g[1] == 0) translate([g[4] - t_g / 2 - es, c - b_g / 2 - es, Z_db - 1]) cube([t_g + 2 * es, b_g + 2 * es, t_d + 2]);
        else translate([c - b_g / 2 - es, g[4] - t_g / 2 - es, Z_db - 1]) cube([b_g + 2 * es, t_g + 2 * es, t_d + 2]);
}
module oberdeck_druck() translate([0, 0, -Z_db]) oberdeck_welt();

// =====================================================================
//  Kabine (Welt; gedruckt kopfüber, unten offen, Glaskern von unten)
// =====================================================================
function kab_pins() = [for (x = [K_X[0] + p_k / 2, K_X[1] - p_k / 2], y = [K_Y[0] + p_k / 2, K_Y[1] - p_k / 2]) [x, y]];
module kab_aussen() hull() {
    translate([K_X[0], K_Y[0], K_Z[0]]) cube([K_X[1] - K_X[0], K_Y[1] - K_Y[0], K_Z[1] - K_Z[0] - c_kd]);
    translate([K_X[0] + c_kd, K_Y[0] + c_kd, K_Z[0]]) cube([K_X[1] - K_X[0] - 2 * c_kd, K_Y[1] - K_Y[0] - 2 * c_kd, K_Z[1] - K_Z[0]]);
}
module kab_raum(o) difference() {
    translate([K_X[0] + t_k - o, K_Y[0] + t_k - o, K_Z[0] - 1]) cube([K_X[1] - K_X[0] - 2 * t_k + 2 * o, K_Y[1] - K_Y[0] - 2 * t_k + 2 * o, K_Z[1] - K_Z[0] - t_kr + 1 + min(o, 0)]);
    for (p = kab_pins()) translate([p[0] - p_k / 2 - o, p[1] - p_k / 2 - o, K_Z[0] - 2]) cube([p_k + 2 * o, p_k + 2 * o, K_Z[1]]);
}
zw0 = K_Z[0] + M(0.6);  zw1 = K_Z[1] - M(0.22);
module kab_fenster() {
    hm = (K_Y[0] + K_Y[1]) / 2; xm = (K_X[0] + K_X[1]) / 2; w2 = max(M(0.08), 1.0);
    // vorne und hinten zwei Scheiben, seitlich zwei Scheiben (Brücken beim Kopfüber-Druck kurz)
    for (x = [K_X[0] - 1, K_X[1] - t_k - 1]) for (y = [[K_Y[0] + p_k, hm - w2 / 2], [hm + w2 / 2, K_Y[1] - p_k]])
        translate([x, y[0], zw0]) cube([t_k + 2, y[1] - y[0], zw1 - zw0]);
    for (y = [K_Y[0] - 1, K_Y[1] - t_k - 1]) for (xx = [[K_X[0] + p_k, xm - w2 / 2], [xm + w2 / 2, K_X[1] - p_k]])
        translate([xx[0], y, zw0]) cube([xx[1] - xx[0], t_k + 2, zw1 - zw0]);
}
module kabine_welt(fp) {
    if (inc(fp, "A")) {
        difference() { kab_aussen(); kab_raum(0); kab_fenster(); }
        for (p = kab_pins()) translate([p[0], p[1], K_Z[0] + 0.01]) rotate([180, 0, 0]) rstift(d_p, t_d + 0.01);
    }
    if (inc(fp, "B")) intersection() { kab_raum(-es); translate([0, 0, K_Z[0]]) cube([K(20), K(20), K_Z[1] - K_Z[0] - t_kr - es]); }
}
module kabine_druck(fp) translate([0, 0, K_Z[1]]) rotate([180, 0, 0]) kabine_welt(fp);

// =====================================================================
//  Geländer, Treppe, Leiter (flach gedruckt)
// =====================================================================
// 2D lokal: u entlang, v nach oben (v = 0 Deck), Zungen nach unten
module gelaender_2d(L) {
    for (v = [0, H_g / 2 - b_g / 2, H_g - b_g]) translate([0, v]) square([L, b_g]);
    for (u = gel_posts(L)) translate([u - b_g / 2, 0]) square([b_g, H_g]);
    for (u = gel_posts(L)) translate([u - b_g / 2, -l_gz]) square([b_g, l_gz + 0.01]);
}
module gelaender_welt(g) let(L = g[3] - g[2])
    if (g[1] == 0) translate([0, g[2], Z_dk]) yz(g[4] - t_g / 2, g[4] + t_g / 2) gelaender_2d(L);
    else translate([g[2], 0, Z_dk]) xz(g[4] - t_g / 2, g[4] + t_g / 2) gelaender_2d(L);
module gelaender_druck(g) translate([0, l_gz, 0]) linear_extrude(t_g) gelaender_2d(g[3] - g[2]);

function st_y(k) = YS[0] + k * a_st;
function st_z(k) = Z_bu + k * r_st;
module treppe_2d() {
    intersection() {
        polygon(concat([[YS[0], Z_bu - 1]], [for (k = [1 : n_st]) each [[st_y(k - 1), st_z(k)], [st_y(k), st_z(k)]]],
                       [[YS[1], st_z(n_st) - h_sv], [YS[0], Z_bu - h_sv]]));
        translate([YS[0] - 1, Z_bu]) square([YS[1] - YS[0] + 2, Z_dk - Z_bu + 1]);
    }
    translate([YS[0], Z_bu - l_tb]) square([w_ts, l_tb + 0.01]);
}
module treppe_gel_2d() let(P0 = [st_y(0) + b_g / 2, st_z(1)], P1 = [st_y(n_st) - b_g / 2, st_z(n_st)], km = round(n_st / 2), Pm = [st_y(km) - b_g / 2, st_z(km)]) {
    for (p = [P0, Pm, P1]) translate([p[0] - b_g / 2, p[1] - 0.01]) square([b_g, H_g]);
    for (v = [H_g / 2, H_g - b_g / 2]) sbar(P0 + [0, v], P1 + [0, v], b_g);
}
module treppe_welt() {
    yz(X_st[0], X_st[1]) treppe_2d();
    yz(X_st[1] - t_g, X_st[1]) treppe_gel_2d();
    yz(X_st[0] - l_tb, X_st[0] + 0.01) translate([TT[0], TT[2]]) square([TT[1] - TT[0], TT[3] - TT[2]]);
}
module treppe_druck() yz_druck(X_st[1]) treppe_welt();

module leiter_2d() let(n = max(2, round((Z_vb - Z_le0) / M(0.3)))) {
    for (dy = [-1, 1]) translate([dy * (w_le / 2 - b_g / 2) - b_g / 2, Z_le0]) square([b_g, Z_vb - Z_le0 + l_tb]);
    for (i = [0 : n - 1]) translate([-w_le / 2 + 0.01, Z_le0 + i * (Z_vb - Z_le0 - b_g) / (n - 0.5)]) square([w_le - 0.02, b_g]);
}
module leiter_welt(sy) translate([0, sy * Y_le, 0]) yz(X_le, X_le + t_le) leiter_2d();
module leiter_druck() yz_druck(X_le + t_le) leiter_welt(1);

// =====================================================================
//  Rad (gedruckt: Achse senkrecht, Innenseite auf dem Bett)
// =====================================================================
lip_h = max(M(0.03), 0.4); lip_w = max(M(0.08), 0.8);   // Innenrand im Reifen: senkrecht lip_h, dann 45°-Konus (Breite lip_w)
lip_t = lip_h + lip_w;
module rad(fp, zw = false) {
    c_t = M(0.28); n_p = 18; g_d = max(M(0.11), 0.8); c_v = M(0.18);
    H2 = zw ? B_zw : B_w;
    prof = zw ? [[R_fe - lip_w, 0], [R_w - 0.7 * c_t, 0], [R_w, c_t], [R_w, B_w - c_v], [R_w - c_v, B_w], [R_w - c_v, B_w + g_zw],
                 [R_w, B_w + g_zw + c_v / 0.7], [R_w, H2 - c_t], [R_w - c_t, H2], [R_fe, H2], [R_fe, lip_t], [R_fe - lip_w, lip_h]]
              : [[R_fe - lip_w, 0], [R_w - 0.7 * c_t, 0], [R_w, c_t], [R_w, B_w - c_t], [R_w - c_t, B_w], [R_fe, B_w], [R_fe, lip_t], [R_fe - lip_w, lip_h]];
    if (inc(fp, "A")) difference() {
        rotate_extrude($fn = 96, convexity = 6) polygon(prof);
        // Stollen: je Reifenhälfte schräge Rillen, in der Mitte zum V verbunden (Pfeilprofil)
        for (t0 = zw ? [0, B_w + g_zw] : [0], hf = [0, 1]) translate([0, 0, t0 + hf * B_w / 2 - (hf == 0 ? 0.01 : 0)])
            linear_extrude(B_w / 2 + 0.01, twist = hf == 0 ? 9 : -9, slices = 6, convexity = 6)
            rotate(hf == 0 ? 0 : -9) for (k = [0 : n_p - 1]) rotate(k * 360 / n_p)   // durchgehendes V-Profil (keine Überhänge in der Mitte)
                translate([R_w - g_d, -R_w * PI / n_p * 0.42]) square([g_d + 2, R_w * 2 * PI / n_p * 0.42]);
    }
    if (inc(fp, "B")) let(r_f = R_fe - es, w_fl = max(M(0.08), 0.8), r_hb = max(M(0.32), d_rz / 2 + 1.2), rec = M(0.14)) difference() {
        union() {
            // Felgenkörper: steht auf dem Bett, Konus liegt auf dem Innenrand des Reifens
            rotate_extrude($fn = 96, convexity = 4) polygon([[0, 0], [R_fe - lip_w - es, 0], [R_fe - lip_w - es, lip_h], [r_f, lip_t], [r_f, H2 - rec], [0, H2 - rec]]);
            difference() { translate([0, 0, lip_t]) cylinder(r = r_f, h = H2 - M(0.03) - lip_t, $fn = 96); translate([0, 0, -1]) cylinder(r = r_f - w_fl, h = H2 + 2, $fn = 96); }
            cylinder(r = r_hb, h = H2 - M(0.05), $fn = 48);
            cylinder(r = r_hb * 0.55, h = H2 - M(0.01), $fn = 32);
            // Radmuttern
            for (k = [0 : 11]) rotate(k * 30) translate([(r_hb + r_f - w_fl) / 2, 0, 0]) cylinder(r = max(M(0.04), 0.5), h = H2 - rec + max(M(0.04), 0.4), $fn = 10);
        }
        translate([0, 0, -1]) cylinder(d = d_rz + spiel, h = h_hub(zw) + 1, $fn = 32);
    }
}
// Welt: Rad i (0 vl, 1 vr, 2 hl, 3 hr); Innenseite zum Fahrzeug
module rad_welt(i, fp, ex = 0) let(x = i < 2 ? X_fa : 0, yi = i < 2 ? y_fi : y_hi, sy = i % 2 == 0 ? 1 : -1)
    translate([x, sy * (yi + ex), z_ax]) rotate([sy > 0 ? -90 : 90, 0, 0]) rad(fp, i >= 2);

// =====================================================================
//  Mulde (Welt, abgesenkt; gedruckt aufrecht)
// =====================================================================
module mulde_quer_2d() {   // Außenquerschnitt mit Obergurt
    polygon([[-Y_b, Z_fu], [Y_b, Z_fu], [Y_t, Z_top], [-Y_t, Z_top]]);
    let(z1 = Z_top - h_tr, u = (Y_tr - ys(z1)) / (1 - k_s)) for (m = [0, 1]) mirror([m, 0])
        polygon([[ys(Z_top) - 0.3, Z_top], [Y_tr, Z_top], [Y_tr, z1], [Y_tr - u, z1 - u], [ys(z1 - u) - 0.3, z1 - u]]);
}
module mulde_laengs_2d() polygon([[X_t, Z_fu + c_tl], [X_t + c_tl, Z_fu], [X_fw0, Z_fu], [X_fw1, Z_top], [X_t, Z_top]]);
module mulde_raum() {
    x_k = X_t + c_tl; z_k = Z_fu + t_bo + K(0.35);   // Boden steigt ab x = -1,2 m an, am Heck steiler (Heckabschluss)
    sl = (Z_fu + c_tl + t_bo - z_k) / c_tl;
    intersection() {
        yz(X_t - 2, X_fw1 + 2) polygon([[-(ys(Z_fu - 1) - tw_s), Z_fu - 1], [ys(Z_fu - 1) - tw_s, Z_fu - 1], [ys(Z_top + 1) - tw_s, Z_top + 1], [-(ys(Z_top + 1) - tw_s), Z_top + 1]]);
        xz(-Y_tr - 1, Y_tr + 1) polygon([[X_t - 2, z_k + sl * (c_tl + 2)], [x_k, z_k], [K(-1.2), Z_fu + t_bo], [xfi(Z_fu + t_bo), Z_fu + t_bo],
                                         [xfi(Z_top + 1), Z_top + 1], [X_t - 2, Z_top + 1]]);
    }
}
module mulde_gurt() let(u = (xfi(Z_top) - h_fb * tphi - x_fb) / (1 + tphi))   // Gurt unter der Stirnwand-Oberkante (Unterseite 45°)
    xz(-Y_tr - 1, Y_tr + 1) polygon([[x_fb, Z_top + 2], [x_fb, Z_top - h_fb], [x_fb + u + 20, Z_top - h_fb - u - 20], [X_fw1 + 25, Z_top - h_fb - u - 20], [X_fw1 + 25, Z_top + 2]]);
module mulde_rippen() for (x = RIB_X, m = [0, 1]) mirror([0, m, 0])
    yz(x - w_rb / 2, x + w_rb / 2) let(z1 = Z_top - h_tr) let(hr = 1.25 * p_rb / (1 - k_s)) polygon([[ys(Z_fu) - 0.3, Z_fu], [ys(Z_fu + hr) + p_rb, Z_fu + hr], [ys(z1) + p_rb, z1], [ys(z1) - 0.3, z1]]);
module mulde_welt() difference() {
    union() {
        intersection() {
            yz(X_t - 1, X_fw1 + 1) mulde_quer_2d();
            xz(-Y_tr - 1, Y_tr + 1) mulde_laengs_2d();
        }
        intersection() { mulde_rippen(); xz(-Y_tr - 1, Y_tr + 1) mulde_laengs_2d(); }
    }
    difference() { mulde_raum(); mulde_gurt(); }
    // Löcher: Schutzdach-Zapfen, Muldenträger-Zungen
    for (y = DACH_Y) translate([x_ph, y, Z_top - l_p - 0.3]) linear_extrude(l_p + 1) raute2(d_p + 2 * es);
    for (sy = [-1, 1], x = TAB_X) translate([x - w_tab / 2 - es, sy > 0 ? Y_m0 - es : -Y_m1 - es, Z_fu - 1]) cube([w_tab + 2 * es, t_mt + 2 * es, h_tab + 1.3]);
}
module mulde_druck() translate([0, 0, -Z_fu]) mulde_welt();

// =====================================================================
//  Schutzdach (Welt; gedruckt kopfüber)
// =====================================================================
module schutzdach_welt(fp) {
    if (inc(fp, "A")) difference() {
        union() {
            translate([x_fb, -Y_tr, Z_c1 - t_cp]) cube([X_c1 - x_fb, 2 * Y_tr, t_cp]);
            // Schürze vorne und seitlich
            difference() { translate([x_fb, -Y_tr, Z_c1 - h_sk]) cube([X_c1 - x_fb, 2 * Y_tr, h_sk]);
                           translate([x_fb - 1, -Y_tr + t_m, Z_c1 - h_sk - 1]) cube([X_c1 - x_fb - t_m + 1, 2 * (Y_tr - t_m), h_sk + 1]); }
            // Auflage auf der Stirnwand
            translate([x_fb, -Y_tr, Z_top]) cube([X_fw1 + M(0.05) - x_fb, 2 * Y_tr, Z_c1 - Z_top]);
            // Querrippen
            for (x = [K(5.6), K(6.6), K(7.6)]) translate([x - max(M(0.08), 0.8) / 2, -Y_tr + 0.01, Z_c1 - M(0.3)]) cube([max(M(0.08), 0.8), 2 * Y_tr - 0.02, M(0.3)]);
            for (y = DACH_Y) translate([x_ph, y, Z_top + 0.01]) rotate([180, 0, 0]) rstift(d_p, l_p + 0.01);
        }
        translate([X_c1 - w_ks, -Y_tr - 1, Z_c1 - d_ks]) cube([w_ks + 1, 2 * Y_tr + 2, d_ks + 1]);
    }
    if (inc(fp, "B")) translate([X_c1 - w_ks + 0.02, -Y_tr + 0.02, Z_c1 - d_ks]) cube([w_ks - 0.04, 2 * Y_tr - 0.04, d_ks]);
}
module schutzdach_druck(fp) translate([0, 0, Z_c1]) rotate([180, 0, 0]) schutzdach_welt(fp);

// =====================================================================
//  Muldenträger (Ebene x-z; gedruckt liegend)
// =====================================================================
module mt_2d() difference() {
    union() {
        hull() {
            translate([X_m0, Z_mb]) square([B_zy[0] - X_m0, Z_fu - Z_mb - 0.03]);   // 0,03 mm Luft unter dem Muldenboden
            translate(P_pv) circle(r = r_e2, $fn = 32);
            translate(B_zy) circle(r = r_e2, $fn = 32);
        }
        for (x = TAB_X) translate([x - w_tab / 2, Z_fu - 0.05]) square([w_tab, h_tab + 0.05]);
    }
    translate(P_pv) circle(r = r_pr, $fn = 24);
    translate(B_zy) circle(r = r_h, $fn = 24);
}
module muldentraeger_welt(sy) xz(sy > 0 ? Y_m0 : -Y_m1, sy > 0 ? Y_m1 : -Y_m0) mt_2d();
module muldentraeger_druck() linear_extrude(t_mt) mt_2d();

// =====================================================================
//  Kippzylinder (lokal = Druck: x Achse vom unteren Auge, Augen flach auf dem Bett)
// =====================================================================
module zyl_rohr() difference() {
    union() {
        cylinder(r = r_e, h = t_e, $fn = 32);
        intersection() {
            translate([r_e - 0.3, 0, hz]) rotate([0, 90, 0]) cylinder(r = r_o, h = L_tb - r_e + 0.3, $fn = 40);
            translate([0, -r_o - 1, 0]) cube([L_tb + 1, 2 * r_o + 2, 2 * r_o + 1]);
        }
    }
    translate([0, 0, -1]) cylinder(r = r_pr, h = t_e + 2, $fn = 24);
    translate([x_b0, 0, 0]) rotate([90, 0, 90]) linear_extrude(L_tb) intersection() { translate([0, hs]) rotate(90) teardrop(r_b, $fn = 24); translate([-r_b - 1, -1]) square([2 * r_b + 2, hs + 2 * r_b + 1]); }
}
module zyl_stange(L) difference() {
    union() {
        translate([L, 0, 0]) cylinder(r = r_e, h = t_e, $fn = 32);
        translate([x_b0 + L - L0, 0, 0]) rotate([90, 0, 90]) linear_extrude(L0 - x_b0 - r_e + 0.3) intersection() { translate([0, hs]) rotate(90) teardrop(r_s, $fn = 24); translate([-r_s - 1, 0]) square([2 * r_s + 2, hs + 2 * r_s + 1]); }
    }
    translate([L, 0, -1]) cylinder(r = r_pr, h = t_e + 2, $fn = 24);
}
module zylinder(fp) {
    if (inc(fp, "A")) zyl_rohr();
    if (inc(fp, "B")) translate([0, 2 * r_o + 3, 0]) zyl_stange(L0);
}
module zylinder_welt(sy, fp, a, ex = 0) let(Bz = rotP(B_zy, a), L = L_zy(a), d = (Bz - F_zy) / L)
    translate([F_zy[0], sy * (y_e0 + ex), F_zy[1]])
        multmatrix(sy > 0 ? [[d[0], d[1], 0, 0], [0, 0, 1, 0], [d[1], -d[0], 0, 0], [0, 0, 0, 1]]
                          : [[d[0], -d[1], 0, 0], [0, 0, -1, 0], [d[1], d[0], 0, 0], [0, 0, 0, 1]]) {
            if (inc(fp, "A")) zyl_rohr();
            if (inc(fp, "B")) zyl_stange(L);
        }

// =====================================================================
//  Spiegel, Auspuff, Rückleuchte
// =====================================================================
// Spiegel 2D lokal: u nach außen (0 = Halter-Mitte), v Höhe über Deck; Zunge durchs Deck
module spiegel_2d() {
    translate([-b_sp / 2, -t_d]) square([b_sp, H_sp + t_d]);
    translate([-b_sp / 2, H_sp - b_sp]) square([u_sp + b_sp / 2, b_sp]);
    translate([u_sp - w_hd, H_sp - h_hd]) square([w_hd, h_hd]);
}
module spiegel_welt(sy) mirror([0, sy > 0 ? 0 : 1, 0]) translate([0, y_sp, Z_dk]) yz(x_sp - t_sp / 2, x_sp + t_sp / 2) spiegel_2d();
module spiegel_druck() yz_druck(x_sp + t_sp / 2) spiegel_welt(1);
// Auspuff (lokal, stehend gedruckt): Schalldämpfer, Konus, Endrohr schräg abgeschnitten; Loch unten für den Deck-Zapfen
module auspuff_lokal() difference() {
    union() {
        cylinder(r = r_mu, h = h_mu, $fn = 32);
        translate([0, 0, h_mu - 0.01]) cylinder(r1 = r_mu, r2 = r_pi, h = r_mu - r_pi, $fn = 32);
        cylinder(r = r_pi, h = h_mu + h_pi, $fn = 20);
    }
    translate([0, 0, h_mu + h_pi - r_pi]) rotate([0, 45, 0]) translate([-5, -5, 0]) cube([10, 10, 10]);
    translate([0, 0, -1]) linear_extrude(l_dp + 1.3) raute2(d_p + 2 * es);
}
module auspuff_welt(i) translate([AP[i][0], AP[i][1], Z_dk]) auspuff_lokal();
// Rückleuchte (Welt): Kästchen am Rahmenende, Linse nach hinten
module rueckleuchte_welt(sy) translate([X_r0, sy * y_rl, z_rl]) difference() {
    union() {
        translate([-d_rl, -w_rl / 2, -w_rl / 2]) cube([d_rl, w_rl, w_rl]);
        translate([-0.01, -w_rp / 2, -w_rl / 2]) cube([l_rl + 0.01, w_rp, h_rp]);   // Steckzunge
    }
    // Leuchtenglas als Vertiefung mit Rand
    let(r = max(M(0.05), 0.5)) translate([-d_rl - 1, -w_rl / 2 + r, -w_rl / 2 + r]) cube([1 + max(M(0.02), 0.3), w_rl - 2 * r, w_rl - 2 * r]);
}
module rueckleuchte_druck() translate([0, -y_rl, w_rl / 2 - z_rl]) rueckleuchte_welt(1);   // liegt auf der Unterseite

// Achszapfen (Welt): Vierkant als Raute, steckt l_in tief, reicht bis h_hub - 0.4 in die Nabe
function l_az(v) = v ? l_in + (y_fi - Y_fs - r_fs) + h_hub(false) - 0.4 : l_in + g_r + h_hub(true) - 0.4;
module achszapfen_welt(i) let(v = i < 2, sy = i % 2 == 0 ? 1 : -1, y0 = v ? Y_fs + r_fs - l_in : y_hi - g_r - l_in)
    translate([v ? X_fa : 0, sy * y0, z_ax]) rotate([sy > 0 ? -90 : 90, 0, 0]) linear_extrude(l_az(v)) raute2(d_rz);
module achszapfen_druck(v) let(c = min(0.5, a_az * 0.2)) hull() {   // liegt flach, Enden oben gefast
    cube([l_az(v), a_az, a_az - c]);
    translate([c, 0, 0]) cube([l_az(v) - 2 * c, a_az, a_az]);
}

// =====================================================================
//  Zusammenbau
// =====================================================================
module kipp(a) translate([P_pv[0], 0, P_pv[1]]) rotate([0, -a, 0]) translate([-P_pv[0], 0, -P_pv[1]]) children();
module muldenkipper(ex = 0) {
    a = ex > 0 ? 0 : mulde_winkel;
    bunt(farbe_gelb) rahmen_koerper();
    translate([ex, 0, 0]) {
        bunt(farbe_gelb) vorbau_koerper();
        translate([ex * 0.6, 0, 0]) { bunt(farbe_grill) grill_welt(); for (sy = [-1, 1]) bunt(farbe_leuchte) leuchte_welt(sy); }
        translate([ex * 0.5, 0, 0]) { bunt(farbe_gelb) treppe_welt(); for (sy = [-1, 1]) bunt(farbe_gelaender) leiter_welt(sy); }
        translate([0, 0, 0.8 * ex]) {
            bunt(farbe_gelb) oberdeck_welt();
            translate([0, 0, 0.6 * ex]) { bunt(farbe_kabine) kabine_welt("A"); bunt(farbe_glas) kabine_welt("B");
                                          for (g = GEL) bunt(farbe_gelaender) gelaender_welt(g);
                                          for (sy = [-1, 1]) bunt(farbe_spiegel) spiegel_welt(sy);
                                          for (i = [0 : 1]) bunt(farbe_auspuff) auspuff_welt(i); }
        }
    }
    for (sy = [-1, 1]) translate([-0.4 * ex, 0, 0]) bunt(farbe_ruecklicht) rueckleuchte_welt(sy);
    for (i = [0 : 3]) translate([i < 2 ? ex : 0, (i % 2 == 0 ? 1 : -1) * ex * 0.5, 0]) bunt(farbe_gelb) achszapfen_welt(i);
    for (i = [0 : 3]) translate([i < 2 ? ex : 0, 0, 0]) { bunt(farbe_reifen) rad_welt(i, "A", ex); bunt(farbe_felge) rad_welt(i, "B", ex); }
    for (sy = [-1, 1]) { bunt(farbe_zylinder) zylinder_welt(sy, "A", a, ex * 0.5); bunt(farbe_stange) zylinder_welt(sy, "B", a, ex * 0.5); }
    translate([0, 0, 1.6 * ex]) kipp(a) {
        for (sy = [-1, 1]) translate([0, 0, -0.5 * ex]) bunt(farbe_gelb) muldentraeger_welt(sy);
        bunt(farbe_mulde) mulde_welt();
        translate([0, 0, 0.8 * ex]) { bunt(farbe_mulde) schutzdach_welt("A"); bunt(farbe_dachkante) schutzdach_welt("B"); }
    }
}

// =====================================================================
//  Info und Ausgabe
// =====================================================================
function zm(v) = r2(v * den / 1000);
L_rahmen = X_j + l_t - X_r0;
B_rahmen = 2 * (y_hi + h_hub(true) - 0.4);
L_mulde = X_fw1 - X_t;
L_vorbau = X_fb - X_j;
B_vorbau = 2 * max(Y_bu, y_fi + h_hub(false) - 0.4);
L_dach = X_c1 - x_fb;
L_bolz = [2 * Y_m1 + 0.5, 2 * (y_e0 + t_e), 2 * (y_e0 + t_e)];
y_zyl = y_e0 + hz + r_o;

echo(str("Muldenkipper 1:", den, " | Länge ", r2(X_fb - X_t), " x Breite ", r2(2 * Y_tr), " mm | Höhe Schutzdach ", r2(Z_c1), " mm | Radstand ", r2(X_fa), " mm"));
echo(str("Rad Ø ", r2(2 * R_w), " x ", r2(B_w), " mm, Zwilling ", r2(B_zw), " mm | Radzapfen ◇ ", r2(d_rz), " | Felge auf 45°-Innenrand ", r2(lip_w), " mm"));
echo(str("Druckteile: Rahmen ", r2(L_rahmen), " x ", r2(B_rahmen), " | Vorbau ", r2(L_vorbau), " x ", r2(B_vorbau), " | Mulde ", r2(L_mulde), " x ", r2(2 * Y_tr),
         " x ", r2(Z_top - Z_fu), " | Schutzdach ", r2(L_dach), " x ", r2(2 * Y_tr), " | Oberdeck ", r2(X_df - X_d0), " x ", r2(2 * Y_d), " mm"));
echo(str("Kippzylinder: eingefahren ", r2(L0), " mm, bei ", kippwinkel, "° ", r2(L_zy(kippwinkel)), " mm | Überdeckung ", r2(ov(kippwinkel)), " mm (min ", r2(ov_min),
         ") | Rohr Ø ", r2(2 * r_o), ", Stange Ø ", r2(2 * r_s), " mm | außen bis y = ", r2(y_zyl), " (Zwillingsrad innen ", r2(y_hi), ")"));
echo(str("Filament-Bolzen Ø ", stift_d, ": Kipplager ", r2(L_bolz[0]), " mm, Zylinder oben ", r2(L_bolz[1]), " mm, unten ", r2(L_bolz[2]), " mm"));
echo(str("Mindestmaße: Muldenwand ", r2(t_m), " | Boden ", r2(t_bo), " | Deck ", r2(t_d), " | Geländer ", r2(b_g), " | Zylinderauge ", r2(t_e), " | Zapfen ◇ ", r2(d_p), " x ", r2(l_p), " mm"));
if (ov(kippwinkel) < ov_min) echo("WARNUNG: Kolbenstange zu kurz für den Kippwinkel");
if (y_zyl > y_hi - 0.3) echo("WARNUNG: Kippzylinder streift die Zwillingsräder");
if (Z_db < 2 * R_w + 0.5) echo("WARNUNG: Oberdeck streift die Vorderräder");
if (Z_fu < 2 * R_w + 0.5) echo("WARNUNG: Mulde streift die Hinterräder");
if (max(L_rahmen, B_rahmen) > usable) echo("WARNUNG: Rahmen größer als das Druckbett");
if (max(L_mulde, 2 * Y_tr) > usable) echo("WARNUNG: Mulde größer als das Druckbett");
if (max(L_vorbau, B_vorbau) > usable || max(L_dach, X_df - X_d0) > usable) echo("WARNUNG: Vorbau/Schutzdach/Deck größer als das Druckbett");
mass_echo(X_fb - X_t, 2 * Y_tr, Z_c1);

druck("rahmen", 1, "alle", farbe_gelb, 1);
druck("vorbau", 1, "alle", farbe_gelb, 1);
druck("kuehlergrill", 1, "alle", farbe_grill, 1);
druck("leuchte", 1, "alle", farbe_leuchte, 2);
druck("oberdeck", 1, "alle", farbe_gelb, 1);
druck("kabine", 1, "A", farbe_kabine, 1); druck("kabine", 1, "B", farbe_glas, 1);
for (g = GEL) druck(str("gelaender_", g[0]), 1, "alle", farbe_gelaender, 1);
druck("treppe", 1, "alle", farbe_gelb, 1);
druck("leiter", 1, "alle", farbe_gelaender, 2);
druck("rad_vorne", 1, "A", farbe_reifen, 2); druck("rad_vorne", 1, "B", farbe_felge, 2);
druck("rad_hinten", 1, "A", farbe_reifen, 2); druck("rad_hinten", 1, "B", farbe_felge, 2);
druck("mulde", 1, "alle", farbe_mulde, 1);
druck("schutzdach", 1, "A", farbe_mulde, 1); druck("schutzdach", 1, "B", farbe_dachkante, 1);
druck("muldentraeger", 1, "alle", farbe_gelb, 2);
druck("zylinder", 1, "A", farbe_zylinder, 2); druck("zylinder", 1, "B", farbe_stange, 2);
druck("spiegel", 1, "alle", farbe_spiegel, 2);
druck("auspuff", 1, "alle", farbe_auspuff, 2);
druck("rueckleuchte", 1, "alle", farbe_ruecklicht, 2);
druck("achszapfen_vorne", 1, "alle", farbe_gelb, 2);
druck("achszapfen_hinten", 1, "alle", farbe_gelb, 2);
farben_echo();

function gel_nr(n) = [for (i = [0 : len(GEL) - 1]) if (str("gelaender_", GEL[i][0]) == n) i];
if (teil == "aufbau") muldenkipper();
else if (teil == "explosion") muldenkipper(max(M(2.0), 14));
else if (teil == "rahmen") rahmen_druck();
else if (teil == "vorbau") vorbau_druck();
else if (teil == "kuehlergrill") grill_druck();
else if (teil == "leuchte") leuchte_druck();
else if (teil == "oberdeck") oberdeck_druck();
else if (teil == "kabine") kabine_druck(farbteil);
else if (len(gel_nr(teil)) > 0) gelaender_druck(GEL[gel_nr(teil)[0]]);
else if (teil == "treppe") treppe_druck();
else if (teil == "leiter") leiter_druck();
else if (teil == "rad_vorne") rad(farbteil, false);
else if (teil == "rad_hinten") rad(farbteil, true);
else if (teil == "mulde") mulde_druck();
else if (teil == "schutzdach") schutzdach_druck(farbteil);
else if (teil == "muldentraeger") muldentraeger_druck();
else if (teil == "zylinder") zylinder(farbteil);
else if (teil == "spiegel") spiegel_druck();
else if (teil == "auspuff") auspuff_lokal();
else if (teil == "rueckleuchte") rueckleuchte_druck();
else if (teil == "achszapfen_vorne") achszapfen_druck(true);
else if (teil == "achszapfen_hinten") achszapfen_druck(false);
