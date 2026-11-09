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

include <../../lib/deko_grundlagen.scad>

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

include <../../lib/deko_hilfen.scad>

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
