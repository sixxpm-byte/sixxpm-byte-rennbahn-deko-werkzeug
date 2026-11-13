// =====================================================================
//  GABELSTAPLER 8 t  (Vorbild: Linde H80D / H80 EVO, Baureihe 396, Vollkabine)
//  Stil der Rennbahn-Deko-Reihe: Steck-Bausatz, FDM-optimiert, Farben je Bauteil.
//  3 Farben + transparent: A Lack (rot), B Rahmen/Reifen (schwarz),
//  C Akzent (orange), D Glas (transparent).  Maßstab 1:24 / 1:43 / 1:87.
//  Optional: alle Teile als Bausatz-Karte mit Angüssen (teil = "karte").
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)            Nr. auf der Karte
//    karte            optional: alle Teile auf einer Bausatz-Karte (ein AMS-Druck)
//    fahrgestell      großes, gerundetes Heckteil (Gegengewicht/Haube) mit
//                     Grill, Leuchten, Kupplung; Trittnische mit 2 Stufen,
//                     Sitz, Lenkrad, Armaturen, Rad- und Mastzapfen (A/B/C)  1   1x
//    kabine           Kabine: A-Säulen nach hinten, dicke Überrollsäulen
//                     nach vorn geneigt, Tür mit Querholm, Dreiecksfenster,
//                     Dach mit Scheinwerfern und Lamellen-Blende (B)        2   1x
//    glaskern         Glaskern (unten offen), steckt in der Kabine (D)    3   1x
//    mast             Hubmast (Duplex-Optik) mit Hubzylinder (B)          4   1x
//    gabeltraeger     Gabelträger mit Führungsplatten und Zapfen (B)      5   1x
//    kotfluegel_links / _rechts  C-förmiger Kotflügel mit Spritzlappen
//                     (A/B)                                             6/7 je 1x
//    gabel            Gabelzinke mit Einhängehaken (B)                    8   2x
//    reifen_vorne     Zwillingsreifen vorne (B)                           9   2x
//    reifen_hinten    Reifen hinten (B)                                  10   2x
//    felge_vorne / felge_hinten  Steck-Felgen (A)                     11/12 je 2x
//    rundumleuchte    Rundumleuchte mit Steckzapfen (C)                  13   1x
//    neigezylinder    Neigezylinder auf dem Dach (wie beim Vorbild) (B)  14   2x
//    ansaugrohr       Luftansaugung mit Filter hinter der Kabine (B)     15   1x
//
//  BEWEGLICH
//    * Räder drehen sich auf den Rautenzapfen.
//    * Gabelträger in 4 Hubstufen steckbar (Lochpaare im Mast).
//    * Gabelzinken hängen auf der oberen Leiste und lassen sich seitlich schieben.
//  FARBTEILE
//    Kabine, Glaskern, Felgen, Kotflügel, Mast, Träger, Gabeln, Reifen,
//    Neigezylinder, Ansaugrohr und Rundumleuchte sind eigene, gesteckte Teile.
//    Am Fahrgestell und an den Kotflügeln sind die schwarzen und orangen
//    Bereiche Farbzonen (AMS).
//  DRUCK
//    Mit Stützmaterial (nur vom Druckbett): Radkästen, Leuchtengehäuse und
//    Kupplungsmaul am Fahrgestell, Dachüberstand und Lamellen-Blende der
//    kopfüber gedruckten Kabine, Türholm (Brücke).  Alle übrigen Teile
//    stützfrei.  (Karte: Angüsse 0,6 mm hoch, mit Seitenschneider abtrennen.)
//  MONTAGE (Kurzfassung)
//    1. Felgen von außen in die Reifen drücken, Räder auf die Zapfen schieben.
//    2. Kotflügel mit den Zapfen seitlich in den Vorderteil stecken.
//    3. Glaskern über den Sockel drücken, Kabine darüberschieben,
//       Rundumleuchte und Ansaugrohr einstecken.
//    4. Mast auf die Zapfen vorne schieben, Neigezylinder mit dem Zapfen ins
//       Dach und mit dem Auge auf den Mastkopf stecken.
//    5. Gabelträger in eine Hubstufe stecken, Gabeln einhängen.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [24:1/24 Slotcar (Carrera Digital 124), 43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, karte:Bausatz-Karte (Druck), fahrgestell:1 Fahrgestell, kabine:2 Kabine, glaskern:3 Glaskern, mast:4 Hubmast, gabeltraeger:5 Gabelträger, kotfluegel_links:6 Kotflügel links, kotfluegel_rechts:7 Kotflügel rechts, gabel:8 Gabelzinke, reifen_vorne:9 Zwillingsreifen vorne, reifen_hinten:10 Reifen hinten, felge_vorne:11 Felge vorne, felge_hinten:12 Felge hinten, rundumleuchte:13 Rundumleuchte, neigezylinder:14 Neigezylinder, ansaugrohr:15 Ansaugrohr]
stueck = 0;
farbteil = "alle"; // [alle, A, B, C, D]

/* [Vorschau] */
// Hubstufe des Gabelträgers (Lochpaar im Mast)
gabel_stufe = 0; // [0:unten, 1:0,6 m, 2:1,2 m, 3:1,8 m]

/* [Gabelstapler (Vorbild in Metern)] */
// Länge bis Gabelrücken (l2)
laenge_m = 3.53;
radstand_m = 2.20;
// Vorderachse bis Gabelrücken
ueberhang_vorne_m = 0.64;
// Breite Heckteil (b2)
breite_m = 1.87;
spur_vorne_m = 1.742;
spur_hinten_m = 1.55;
// Zwillingsreifen 8.25-15
rad_vorne_d_m = 0.84;
rad_vorne_b_m = 0.235;
zwilling_luft_m = 0.03;
// Reifen hinten 315/70-15
rad_hinten_d_m = 0.82;
rad_hinten_b_m = 0.315;
felge_d_m = 0.50;
bodenfreiheit_m = 0.25;
// Kabinenboden / Tür-Unterkante
deck_hoehe_m = 1.00;
// Oberkante Heckteil (Sitz steht darauf)
gegengewicht_hoehe_m = 1.39;
// Vorderkante Heckteil hinter der Vorderachse: unten / oben (schräg)
heck_vorne_unten_m = 1.20;
heck_vorne_oben_m = 1.49;
// A-Säule unten hinter der Vorderachse
kabine_vorne_m = 0.145;
// Neigung der A-Säulen nach hinten / der Überrollsäulen nach vorn (Grad)
kabine_neigung_vorne = 14;
kabine_neigung_hinten = 26;
// Hinterkante der Überrollsäule unten, vom Heck
kabine_heck_m = 0.99;
// B-Säule (Türscharnier) hinter der Vorderachse
tuer_hinten_m = 1.14;
kabine_breite_m = 1.46;
// Höhe über Kabine (h6)
kabine_hoehe_m = 2.746;
// Masthöhe eingefahren (h1)
mast_hoehe_m = 2.737;
mast_breite_m = 1.14;
gabeltraeger_breite_m = 2.18;
gabeltraeger_hoehe_m = 0.60;
gabel_laenge_m = 1.20;
gabel_breite_m = 0.15;
gabel_dicke_m = 0.07;
// Mitte zu Mitte (wird bei Bedarf an die Führungsplatten angepasst)
gabel_abstand_m = 0.60;

/* [Farben] */
// A: Fahrgestell, Kotflügel, Felgen
farbe_lack    = "rot";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau, glas]
// B: Kabine, Mast, Gabeln, Reifen, Trittnische, Karte
farbe_rahmen  = "schwarz"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau, glas]
// C: Rundumleuchte, Rückleuchten
farbe_akzent  = "orange";  // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau, glas]
// D: Glaskern (transparentes Filament)
farbe_glas    = "glas";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau, glas]

/* [Bausatz-Karte] */
karte_titel = "GABELSTAPLER 8T";
// leer = "FDM-KIT 1:43" bzw. "1:87"
karte_untertitel = "";
// Farbteil von Rahmen und Nummernscheiben
karte_farbteil = "B";   // [A, B, C]
// Farbteil von Titel und Nummern
schrift_farbteil = "A"; // [A, B, C]
rahmen_breite = 2.2;
rahmen_hoehe = 1.6;
// Anguss: Breite am Teil, Höhe
steg_breite = 1.0;
steg_hoehe = 0.6;
// Luft zwischen Teilen und Rahmen
karte_abstand = 2.5;
// größte Kartenbreite in mm (0 = automatisch, möglichst quadratisch)
karte_max_breite = 0;

/* [Druck & Passung] */
rennbahn_taschen = true;   // (keine Bodenplatte – bleibt für die Bibliothek stehen)
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;
// Luft je Seite für eingepresste Teile (Felge, Glaskern, Kabine; 0 = sehr stramm)
einsatz_spiel = 0.05;

include <../../lib/deko_grundlagen.scad>

// =====================================================================
//  Maße (Welt: x = 0 Heck, +x nach vorne, y = 0 Mitte (+y links), z = 0 Boden; mm)
// =====================================================================
es    = einsatz_spiel;
X_VA  = M(laenge_m - ueberhang_vorne_m);        // Vorderachse
X_HA  = X_VA - M(radstand_m);                   // Hinterachse
R_V   = M(rad_vorne_d_m / 2);  B_V = M(rad_vorne_b_m);
G_ZW  = max(M(zwilling_luft_m), 0.8);  B_ZW = 2 * B_V + G_ZW;
R_H   = M(rad_hinten_d_m / 2); B_H = M(rad_hinten_b_m);
R_FE  = M(felge_d_m / 2);
Y_VI  = M(spur_vorne_m / 2) - B_ZW / 2;         // Innenseite Zwillingsrad
Y_HI  = M(spur_hinten_m / 2) - B_H / 2;         // Innenseite Rad hinten
Y_B   = M(breite_m / 2);
Z0    = M(bodenfreiheit_m);
Z_D   = M(deck_hoehe_m);
Z_G   = M(gegengewicht_hoehe_m);
Z_SK  = M(0.32);                                // Oberkante schwarze Schürze
d_in  = max(M(0.03), 0.6);                      // Tiefe der Farbfelder

// Heckteil: Vorderkante schräg von (X_RBF0, Z0) nach (X_RBF1, Z_G)
X_RBF0 = X_VA - M(heck_vorne_unten_m);
X_RBF1 = X_VA - M(heck_vorne_oben_m);
function xs(z) = X_RBF0 + (z - Z0) * (X_RBF1 - X_RBF0) / (Z_G - Z0);
R_hk  = M(0.38);  R_top = M(0.36);  R_s = M(0.2);
Y_W   = Y_HI - max(M(0.03), 0.5);               // Innenwand Radkasten hinten
R_WK  = R_H + max(M(0.06), 0.8);

// Kotflügel (C-Form) und Vorderteil
R_KI  = R_V + max(M(0.05), 0.6);
t_kf  = max(M(0.10), 1.2);  t_kr = max(M(0.18), 2.4);  d_kr = t_kr - t_kf;
R_KO  = R_KI + t_kf;
X_BF  = X_VA - R_KI - t_kr - max(M(0.02), 0.3); // Front Trittnische = Rückseite Kotflügel
Y_FS  = Y_VI - max(M(0.04), 0.5);               // Vorderteil (zwischen den Rädern)
X_FV  = X_VA + M(0.16);                         // Front Vorderteil
Y_KFA = Y_VI + B_ZW + max(M(0.02), 0.3);
Z_KT  = R_V + R_KO;                             // Oberkante Kotflügel
Z_KFB = M(0.10);
X_KFC = X_VA + R_KO * cos(80);                  // Ende des roten Bogens, davor Spritzlappen
t_fl  = max(M(0.04), 1.0);
d_kp  = max(M(0.08), 1.4);  l_kp = min(max(M(0.12), 1.5), Y_FS - 0.5);
KP    = [for (a = [155, 185]) let(r = R_KI + (t_kf + d_kr * abs(cos(a))) / 2) [X_VA + r * cos(a), R_V + r * sin(a)]];

// Trittnische
rec   = max(M(0.08), 0.8);  Y_SW = Y_B - rec;
Z_SL  = Z_D - M(0.15);                          // Unterkante Schweller
t_st  = max(M(0.04), 1.0);
ST    = [[M(0.65), X_BF - M(0.45)], [M(0.30), X_BF - M(0.55)]];   // [Höhe, Beginn hinten]

// Radzapfen
d_rz  = max(M(0.18), 2.6);
t_nbv = B_ZW - max(M(0.06), 0.8);   t_nbh = B_H - max(M(0.06), 0.8);
l_rzv = Y_VI - Y_FS + t_nbv - 0.4;  l_rzh = Y_HI - Y_W + t_nbh - 0.4;

// Hubmast
d_mz  = max(M(0.09), 1.5);                      // Rautenzapfen Mast / Träger
gap_m = max(M(0.03), 0.4);
X_M0  = X_FV + gap_m;
D_M   = max(M(0.25), 4.0);  X_M1 = X_M0 + D_M;  X_MZ = (X_M0 + X_M1) / 2;
Y_M   = min(M(mast_breite_m / 2), Y_FS - 0.3);   // innen neben Vorderteil und Kotflügeln
W_R   = max(M(0.22), 2.6);
Z_M0  = M(0.2);  Z_M1 = M(mast_hoehe_m);
l_in  = min(max(M(0.1), 1.2), (D_M - 0.8) / 2 - 0.3);
Y_MZ  = Y_M - W_R / 2;
Z_PV  = Z0 + d_mz * 0.5 + 0.4;                  // Mastlager unten

// Gabelträger und Gabeln
T_CB  = max(M(0.08), 1.2);
t_gp  = max(M(0.05), 1.2, X_VA + R_V + 0.4 - X_M1);
X_C0  = X_M1 + t_gp;  X_C1 = X_C0 + T_CB;
W_CT  = M(gabeltraeger_breite_m);  H_CT = M(gabeltraeger_hoehe_m);
b_bar = max(M(0.13), 1.4);
w_po  = max(M(0.08), 1.2);
w_gp  = max(M(0.1), d_mz + 0.8);
Tf    = max(M(gabel_dicke_m), 1.0);  Wf = max(M(gabel_breite_m), 1.5);  L_F = M(gabel_laenge_m);
D_FB  = max(M(0.08), Tf);
function HC(k) = D_FB + M(0.6 * k);             // Unterkante Träger je Hubstufe
t_hk  = t_gp - 0.3;  h_hk = max(M(0.1), 1.2);  t_ht = max(M(0.05), 1.0);
Y_G   = min(M(gabel_abstand_m / 2), Y_MZ - w_gp / 2 - Wf / 2 - 0.3);
XS_F  = X_C1 + spiel;
XH_F  = X_C0 - spiel - t_hk;
XE_F  = XS_F + Tf + L_F;
X_KFV = min(X_VA + (R_KI + t_fl) * cos(40), X_C0 - 0.4);   // Spitze Spritzlappen

// Kabine (Seitenprofil: Trapez, unten gestuft auf Deck und Heckteil)
a_f   = kabine_neigung_vorne;  a_r = kabine_neigung_hinten;
X_AF0 = X_VA - M(kabine_vorne_m);
X_R0  = M(kabine_heck_m);
function xa(z) = X_AF0 - (z - Z_D) * tan(a_f);  // Außenkante vorn
function xr(z) = X_R0 + (z - Z_G) * tan(a_r);   // Außenkante hinten
Y_K   = M(kabine_breite_m / 2);
Z_K1  = M(kabine_hoehe_m);
t_k   = max(M(0.06), 1.2);   t_dach = max(M(0.12), 1.6);  ue = max(M(0.04), 0.6);
Z_PT  = Z_K1 - t_dach + t_k;                    // Profil-Oberkante (Innenraum endet unter dem Dach)
X_BP1 = X_VA - M(tuer_hinten_m);  X_BP0 = X_BP1 - max(M(0.06), 1.2);   // B-Säule
p_a   = max(M(0.09), t_k / cos(a_f) + 0.5);  p_ay = max(M(0.09), t_k + 0.5);
p_rs  = max(M(0.2), t_k / cos(a_r) + 1.0);   p_ry = max(M(0.16), t_k + 0.6);
r_b   = max(M(0.07), 1.0);   r_l = max(M(0.07), 1.0);
Z_WB  = Z_D + r_b;  Z_QB = Z_G + r_b;  Z_WT = Z_K1 - t_dach - r_l;
Z_TB  = M(1.80);  b_tb = max(M(0.05), 1.0);                     // Türholm
Z_QT  = min(Z_WT, Z_G + (X_BP0 - p_rs - X_R0) / tan(a_r));     // Spitze Dreiecksfenster
X_RF  = xa(Z_K1 - t_dach) + M(0.1);             // Dach vorn (Überstand)
X_RR  = xr(Z_K1 - t_dach);                      // Dach hinten
X_VR  = X_RR - M(0.5);  Z_VR = Z_K1 - M(0.32);  t_v = max(M(0.08), 1.2);   // Lamellen-Blende
X_KMIN = min(X_R0, X_VR);
// Glaskern, Sockel, Innenraum
o1    = t_k + es;  t_g = max(M(0.04), 1.2);  o2 = o1 + t_g;  o3 = o2 + es;
t_pl  = max(M(0.05), 1.2);   h_pl = max(M(0.12), 1.4);
o4    = o3 + t_pl + 0.3;
X_GMIN = xr(Z_G) + o1 / cos(a_r);  X_GMAX = xa(Z_D) - o1 / cos(a_f);  Z_GT = Z_PT - o1;

// Rundumleuchte, Neigezylinder, Ansaugrohr
r_rl  = max(M(0.09), 1.4);  h_rl = max(M(0.2), 2.4);  c_rl = r_rl * 0.3;
d_rp  = max(M(0.06), 1.2);  l_rp = t_dach - 0.3;
X_RL  = X_RR + M(0.1);      Y_RL = Y_K - M(0.08);
r_tc  = max(M(0.075), d_mz / 2 + 0.9);  r_tr = max(M(0.04), 0.7);
X_TZ  = X_RR + M(0.32);     X_B1 = X_RF + M(0.05);
t_ey  = max(M(0.08), 1.6);  r_ey = d_mz / 2 + 0.9;
Z_EY  = max(Z_K1, Z_M1 + 0.3);
d_tp  = max(M(0.08), 1.4);  l_tp = t_dach - 0.3;
l_mt  = Z_EY - Z_M1 + t_ey - 0.4;               // Zapfen auf dem Mastkopf
X_PE  = X_M0 + d_mz / 2;                        // Auge / Mastkopf-Zapfen (Zapfen bündig mit der Mast-Rückseite)
X_AR  = X_R0 - M(0.18);     Y_AR = Y_K - M(0.1);
d_ar  = max(M(0.13), 2.0);  d_af = max(M(0.22), 3.0);  d_ak = max(M(0.26), 3.4);  h_ak = max(M(0.1), 1.2);
d_arp = max(M(0.08), 1.4);  l_arp = max(M(0.1), 1.5);
Z_AR  = M(2.2) + h_ak;                          // Oberkante Ansaugkappe

// Reifen (wie lib/deko_rad.scad)
c_tv  = min(M(0.28), 0.4 * B_V);  c_th = min(M(0.28), 0.4 * B_H);
lip_w = max(M(0.08), 0.8);

include <../../lib/deko_hilfen.scad>
include <../../lib/deko_rad.scad>

// =====================================================================
//  Hilfen
// =====================================================================
module xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 8) children();
module yz(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0, convexity = 6) children();
module raute2(d) rotate(45) square(d / sqrt(2), center = true);
module zapfen_x(p, d, l, sx = 1) translate(p) rotate([0, sx > 0 ? 90 : -90, 0]) linear_extrude(l) raute2(d);
module zapfen_y(p, d, l, sy = 1) translate(p) rotate([sy > 0 ? -90 : 90, 0, 0]) linear_extrude(l) raute2(d);
module loch_z(x, y, z0, l, d) translate([x, y, z0]) linear_extrude(l) raute2(d + spiel);
function fcol(g) = g == "A" ? farbe_lack : g == "B" ? farbe_rahmen : g == "C" ? farbe_akzent : farbe_glas;
GR = ["A", "B", "C", "D"];
// Bereich oberhalb von Deck, Schräge und Heckteil (xz)
module ueber_boden() polygon([[-M(5), Z_G], [xs(Z_G), Z_G], [xs(Z_D), Z_D], [M(10), Z_D], [M(10), M(10)], [-M(5), M(10)]]);

// =====================================================================
//  Fahrgestell
// =====================================================================
module rb_plan(o) offset(delta = -o) hull() {
    for (sy = [-1, 1]) translate([R_hk, sy * (Y_B - R_hk)]) circle(r = R_hk, $fn = 48);
    for (sy = [-1, 1]) translate([X_RBF0 - M(0.06), sy * (Y_B - M(0.06))]) circle(r = M(0.06), $fn = 16);
}
module rb_raw() intersection() {
    hull() {
        translate([0, 0, Z0]) linear_extrude(Z_G - R_s - Z0) rb_plan(0);
        for (k = [1 : 4]) let(a = k * 22.5) translate([0, 0, Z_G - R_s + R_s * sin(a) - 0.01]) linear_extrude(0.01) rb_plan(R_s * (1 - cos(a)));
    }
    xz(-Y_B - 1, Y_B + 1) hull() {
        polygon([[0, Z0], [X_RBF0, Z0], [X_RBF1, Z_G], [R_top, Z_G], [0, Z_G - R_top]]);
        translate([R_top, Z_G - R_top]) circle(r = R_top, $fn = 48);
    }
}
module mitte_2d() polygon([[-Y_SW, Z0], [Y_SW, Z0], [Y_SW, Z_SL - rec], [Y_B, Z_SL], [Y_B, Z_D], [-Y_B, Z_D], [-Y_B, Z_SL], [-Y_SW, Z_SL - rec]]);
module deck_plan() {
    translate([M(0.3), -(Y_B - R_s)]) square([X_RBF1 - M(0.3), 2 * (Y_B - R_s)]);
    translate([X_RBF1 - 0.01, -Y_B]) square([X_BF - 0.3 - X_RBF1 + 0.01, 2 * Y_B]);   // Stufe nicht auf der Vorderteil-Kante
    translate([X_BF - 0.31, -Y_FS]) square([X_FV - X_BF + 0.31, 2 * Y_FS]);
}
g_p = max(M(0.07), 1.2);  g_w = max(M(0.03), 0.5);       // Grillrillen: Teilung, Breite
module koerper_roh() difference() {
    union() {
        rb_raw();
        yz(X_RBF1, X_BF) mitte_2d();
        translate([X_BF, -Y_FS, Z0]) cube([X_FV - X_BF, 2 * Y_FS, Z_D - Z0]);
    }
    // Radkästen hinten
    for (sy = [-1, 1]) let(y0 = sy > 0 ? Y_W : -Y_B - 1) xz(y0, y0 + Y_B + 1 - Y_W) translate([X_HA, R_H]) circle(r = R_WK, $fn = 96);
    // Rillen im Heckgrill
    for (z = [M(1.03) + g_p / 2 : g_p : M(1.27)]) translate([-1, -M(0.33), z]) cube([1.4, M(0.66), g_w]);
    // Löcher: Kotflügel, Ansaugrohr
    for (sy = [-1, 1], p = KP) translate([p[0], sy * (Y_FS + 0.01), p[1]]) rotate([sy > 0 ? 90 : -90, 0, 0]) linear_extrude(l_kp + 0.31) raute2(d_kp + spiel);
    loch_z(X_AR, Y_AR, Z_G - l_arp - 0.3, l_arp + 1, d_arp);
}
module zone_b() {
    translate([-1, -Y_B - 2, -1]) cube([X_FV + 2, 2 * Y_B + 4, Z_SK + 1]);                  // Schürze
    translate([X_BF - 0.01, -Y_FS, -1]) cube([X_FV - X_BF + 1.01, 2 * Y_FS, Z_D + 2]);   // Vorderteil
    difference() { translate([X_RBF1 - 1, -Y_B - 2, -1]) cube([X_BF - X_RBF1 + 1, 2 * Y_B + 4, Z_SL - rec + 1]); rb_raw(); }   // Trittnische
    translate([-1, -M(0.48), M(1.0)]) cube([d_in + 1, M(0.96), M(0.28)]);                    // Heckgrill (reicht bis zu den Leuchten)
    for (sy = [-1, 1]) translate([-1, sy > 0 ? M(0.47) : -Y_B - 1, M(1.0)]) cube([M(0.3) + 1, Y_B - M(0.47) + 1, M(0.28)]);   // Leuchtengehäuse
    translate([-1, -M(0.16), M(0.70)]) cube([d_in + 1, M(0.32), M(0.31)]);                   // Kupplungsmaul (bis zum Grill)
    translate([-1, -M(0.05), Z_SK - 1]) cube([d_in + 1, M(0.1), M(0.7) - Z_SK + 2]);          // Steg Kupplung – Schürze
    for (sy = [-1, 1]) translate([X_HA - d_rz / 2 - 0.5, sy > 0 ? Y_W - d_in : -Y_W - 1, -1])  // Radzapfen-Feld an der Radkasten-Innenwand
        cube([d_rz + 1, d_in + 1, R_H + d_rz / 2 + 1.5]);
    for (sy = [-1, 1]) let(y0 = sy > 0 ? Y_W - 0.01 : -Y_B - 1) xz(y0, y0 + Y_B + 1.01 - Y_W)   // Kotflügelrand hinten
        intersection() { translate([X_HA, R_H]) difference() { circle(r = R_WK + max(M(0.06), 0.8), $fn = 96); circle(r = R_WK - 0.01, $fn = 96); }
                         union() { translate([-1, Z_SK - 1]) square([X_HA + 1, M(2)]); translate([-1, R_H + M(0.1)]) square([X_HA + M(0.15) + 1, M(2)]); } }
}
module zone_c() {
    for (sy = [-1, 1]) translate([-1, sy * M(0.68), M(1.14)]) rotate([0, 90, 0]) cylinder(r = max(M(0.065), 0.8), h = d_in + 1 + M(0.05) + 0.6, $fn = 24);
    translate([d_in + 0.2, -M(0.68), M(1.14) - 0.4]) cube([0.8, 2 * M(0.68), 0.8]);      // verdeckte Verbindung der Lampen
}
module pins_b() for (sy = [-1, 1]) {
    zapfen_y([X_VA, sy * (Y_FS - 0.01), R_V], d_rz, l_rzv + 0.01, sy);                     // Rad vorne
    zapfen_y([X_HA, sy * (Y_W - 0.01), R_H], d_rz, l_rzh + 0.01, sy);                      // Rad hinten
    zapfen_x([X_FV - 0.01, sy * Y_MZ, Z_PV], d_mz, gap_m + l_in + 0.01);                   // Mastlager
}
module stufen_b() for (s = ST, sy = [-1, 1]) let(z = s[0], x0 = max(s[1], xs(z) + 0.3)) intersection() {
    yz(x0, X_BF - M(0.02)) polygon([[sy * (Y_SW - 0.01), z - t_st - rec], [sy * Y_B, z - t_st], [sy * Y_B, z], [sy * (Y_SW - 0.01), z]]);
    translate([0, -Y_B - 1, Z0]) cube([X_FV, 2 * Y_B + 2, Z_D]);
}
module sockel() intersection() {
    difference() {
        xz(-(Y_K - o3), Y_K - o3) offset(delta = -o3) kab_prof_ext();
        xz(-(Y_K - o3 - t_pl), Y_K - o3 - t_pl) offset(delta = -(o3 + t_pl)) kab_prof_ext();
    }
    xz(-Y_B - 5, Y_B + 5) difference() { ueber_boden(); translate([0, h_pl]) ueber_boden(); }
    translate([0, 0, -1]) linear_extrude(M(4)) deck_plan();
}
module deck_b() {
    sockel();
    // dünne Bodenmatte im Innenraum verbindet Sockel, Sitz und Armaturen
    intersection() {
        xz(-(Y_K - o3), Y_K - o3) offset(delta = -o3) kab_prof_ext();
        xz(-Y_B - 5, Y_B + 5) difference() { ueber_boden(); translate([0, 0.5]) ueber_boden(); }
        translate([0, 0, -1]) linear_extrude(M(4)) deck_plan();
    }
    let(o4r = o4 / cos(a_r), x0 = xr(Z_G) + o4r + M(0.02), t_br = max(M(0.12), 1.2), Z_BR = M(2.15)) {
        translate([x0, -M(0.26), Z_D]) cube([M(0.45), M(0.52), M(1.5) - Z_D]);                                  // Sitz
        xz(-M(0.24), M(0.24)) polygon([[x0, Z_G], [x0 + t_br, Z_G], [xr(Z_BR) + o4r + M(0.02) + t_br, Z_BR], [xr(Z_BR) + o4r + M(0.02), Z_BR]]);   // Lehne
    }
    let(o4f = o4 / cos(a_f), Z_DA = M(1.45), xd0 = xa(Z_DA) - o4f - M(0.22))
        xz(-M(0.42), M(0.42)) polygon([[xd0, Z_D], [xa(Z_D) - o4f, Z_D], [xa(Z_DA) - o4f, Z_DA], [xd0, Z_DA]]);   // Armaturen
    let(o4f = o4 / cos(a_f), r_ls = max(M(0.04), 0.8), R_lr = max(M(0.17), 2.0), Z_LR = M(1.85), x_ls = xa(Z_LR) - o4f - R_lr - M(0.02))
        translate([x_ls, 0, Z_D]) {
            cylinder(r = r_ls, h = Z_LR - Z_D, $fn = 16);                                                     // Lenksäule
            translate([0, 0, Z_LR - Z_D - (R_lr - r_ls)]) cylinder(r1 = r_ls, r2 = R_lr, h = R_lr - r_ls, $fn = 32);
            translate([0, 0, Z_LR - Z_D - 0.01]) cylinder(r = R_lr, h = 0.6, $fn = 32);
        }
}
module fahrgestell_welt(fp) {
    if (inc(fp, "A")) difference() { koerper_roh(); zone_b(); zone_c(); pins_b(); deck_b(); stufen_b(); }
    if (inc(fp, "B")) { intersection() { koerper_roh(); difference() { zone_b(); zone_c(); } } pins_b(); deck_b(); stufen_b(); }
    if (inc(fp, "C")) intersection() { koerper_roh(); zone_c(); }
}
YH_FG = max(Y_B, Y_VI + t_nbv - 0.4, Y_HI + t_nbh - 0.4);
module fahrgestell_druck(fp) translate([0, YH_FG, -Z0]) fahrgestell_welt(fp);

// =====================================================================
//  Kotflügel (Welt links; gedruckt auf der Außenseite liegend)
// =====================================================================
module kf_2d_a() intersection() {
    difference() {
        hull() { for (dx = [0, d_kr]) translate([X_VA - dx, R_V]) circle(r = R_KO, $fn = 96); }
        translate([X_VA, R_V]) circle(r = R_KI, $fn = 96);
    }
    translate([X_BF, Z_KFB]) square([X_KFC - X_BF, Z_KT - Z_KFB + 1]);
}
module kf_2d_b() intersection() {
    translate([X_VA, R_V]) difference() { circle(r = R_KI + t_fl, $fn = 96); circle(r = R_KI, $fn = 96); }
    translate([X_VA, R_V]) polygon([[0, 0], [3 * R_KO * cos(40), 3 * R_KO * sin(40)], [3 * R_KO * cos(40), 3 * R_KO], [0, 3 * R_KO]]);
    translate([X_KFC, 0]) square([X_KFV - X_KFC, M(3)]);
}
module kf_links(fp) {
    if (inc(fp, "A")) { xz(Y_FS, Y_KFA) kf_2d_a(); for (p = KP) zapfen_y([p[0], Y_FS + 0.01, p[1]], d_kp, l_kp + 0.01, -1); }
    if (inc(fp, "B")) xz(Y_FS, Y_KFA) kf_2d_b();
}
module kf_welt(sy, fp) { if (sy > 0) kf_links(fp); else mirror([0, 1, 0]) kf_links(fp); }
module kf_druck(sy, fp) if (sy > 0) multmatrix([[-1, 0, 0, X_KFV], [0, 0, -1, Z_KT], [0, -1, 0, Y_KFA], [0, 0, 0, 1]]) kf_welt(1, fp);
    else multmatrix([[1, 0, 0, -X_BF], [0, 0, -1, Z_KT], [0, 1, 0, Y_KFA], [0, 0, 0, 1]]) kf_welt(-1, fp);

// =====================================================================
//  Kabine (unten offen, kopfüber gedruckt) und Glaskern
// =====================================================================
module kab_prof() polygon([[xa(Z_D), Z_D], [xa(Z_PT), Z_PT], [xr(Z_PT), Z_PT], [xr(Z_G), Z_G], [xs(Z_G), Z_G], [xs(Z_D), Z_D]]);
// nach unten verlängertes Trapez (Innenraum, Glaskern und Sockel sind unten offen)
module kab_prof_ext() let(ze = -M(1)) polygon([[xa(ze), ze], [xa(Z_PT), Z_PT], [xr(Z_PT), Z_PT], [xr(ze), ze]]);
module kab_fenster() {
    let(zb = Z_TB - b_tb / 2, zt = Z_TB + b_tb / 2) xz(-Y_K - 1, Y_K + 1) {                           // Tür unten / oben
        polygon([[X_BP1, Z_WB], [xa(Z_WB) - p_a, Z_WB], [xa(zb) - p_a, zb], [X_BP1, zb]]);
        polygon([[X_BP1, zt], [xa(zt) - p_a, zt], [xa(Z_WT) - p_a, Z_WT], [X_BP1, Z_WT]]);
        polygon([[X_BP0, Z_QB], [xr(Z_QB) + p_rs, Z_QB], [X_BP0, Z_QT]]);                              // Dreiecksfenster
    }
    xz(-(Y_K - p_ay), Y_K - p_ay) polygon([[xa(Z_WB) - 3 * t_k, Z_WB], [xa(Z_WB) + 1, Z_WB], [xa(Z_WT) + 1, Z_WT], [xa(Z_WT) - 3 * t_k, Z_WT]]);   // Frontscheibe
    xz(-(Y_K - p_ry), Y_K - p_ry) polygon([[xr(Z_QB) - 1, Z_QB], [xr(Z_QB) + 3 * t_k, Z_QB], [xr(Z_WT) + 3 * t_k, Z_WT], [xr(Z_WT) - 1, Z_WT]]);  // Heckscheibe
}
module kabine_welt(fp) if (inc(fp, "B")) difference() {
    union() {
        intersection() { xz(-Y_K, Y_K) kab_prof(); xz(-Y_K - 1, Y_K + 1) translate([0, 0.02]) ueber_boden(); }
        translate([X_RR, -Y_K - ue, Z_K1 - t_dach]) cube([X_RF - X_RR, 2 * (Y_K + ue), t_dach]);                 // Dach
        xz(-Y_K - ue, Y_K + ue) polygon([[X_RR + M(0.05), Z_K1], [X_VR, Z_VR], [X_VR, Z_VR - t_v], [X_RR + M(0.05), Z_K1 - t_v]]);   // Lamellen-Blende
        for (sy = [-1, 1]) translate([X_RF - M(0.06), sy > 0 ? Y_K - M(0.22) : -Y_K + M(0.04), Z_K1 - t_dach - M(0.09)])
            cube([M(0.1), M(0.18), t_dach + M(0.09)]);                                                           // Arbeitsscheinwerfer
    }
    xz(-(Y_K - t_k), Y_K - t_k) offset(delta = -t_k) kab_prof_ext();
    kab_fenster();
    // Dachscheibe (3 Felder)
    let(rx0 = X_TZ + M(0.16), rx1 = X_RF - M(0.12), bw = max(M(0.06), 1.0), rw = (rx1 - rx0 - 2 * bw) / 3, ry = Y_K - M(0.16))
        for (i = [0 : 2]) translate([rx0 + i * (rw + bw), -ry, Z_K1 - t_dach - t_k - 1]) cube([rw, 2 * ry, t_dach + t_k + 2]);
    // Lamellen der Blende
    let(n = 4, x0 = X_VR + M(0.06), x1 = X_RR - M(0.12), w = max(M(0.04), 0.8), sp = (x1 - x0 - w) / (n - 1), ry = Y_K - M(0.08))
        for (i = [0 : n - 1]) let(x = x0 + i * sp, zt = Z_K1 + (x - X_RR) * (Z_K1 - Z_VR) / (X_RR - X_VR))
            translate([x, -ry, zt - t_v - 0.5]) cube([w, 2 * ry, t_v + 1 + M(0.05)]);
    // runde Aussparungen in den Überrollsäulen
    let(d = min(p_rs * 0.55, M(0.11))) for (sy = [-1, 1], k = [1 : 3]) let(z = Z_G + k * (Z_WT - Z_G) / 4)
        translate([xr(z) + p_rs / 2, sy > 0 ? Y_K - 0.4 : -Y_K - 1, z]) rotate([-90, 0, 0]) cylinder(d = d, h = 1.4, $fn = 24);
    // Löcher: Neigezylinder, Rundumleuchte
    for (sy = [-1, 1]) translate([X_TZ - (d_tp + spiel) / 2, sy * Y_MZ - r_tc - spiel / 2, Z_K1 - t_dach - 1]) cube([d_tp + spiel, 2 * r_tc + spiel, t_dach + 2]);
    loch_z(X_RL, Y_RL, Z_K1 - t_dach - 1, t_dach + 2, d_rp);
}
module kabine_druck(fp) multmatrix([[1, 0, 0, -X_KMIN], [0, -1, 0, Y_K + ue], [0, 0, -1, Z_K1], [0, 0, 0, 1]]) kabine_welt(fp);
module kern_welt(fp) if (inc(fp, "D")) difference() {
    intersection() { xz(-(Y_K - o1), Y_K - o1) offset(delta = -o1) kab_prof_ext(); xz(-Y_B - 5, Y_B + 5) translate([0, 0.02]) ueber_boden(); }
    xz(-(Y_K - o2), Y_K - o2) offset(delta = -o2) kab_prof_ext();
}
module kern_druck(fp) multmatrix([[1, 0, 0, -X_GMIN], [0, -1, 0, Y_K - o1], [0, 0, -1, Z_GT], [0, 0, 0, 1]]) kern_welt(fp);

// Rundumleuchte (gedruckt kopfüber, Zapfen nach oben)
module rl_welt(fp) if (inc(fp, "C")) translate([X_RL, Y_RL, Z_K1]) {
    cylinder(r = r_rl, h = h_rl - c_rl, $fn = 32);
    translate([0, 0, h_rl - c_rl - 0.01]) cylinder(r1 = r_rl, r2 = r_rl - c_rl, h = c_rl + 0.01, $fn = 32);
    translate([0, 0, -l_rp]) linear_extrude(l_rp + 0.01) raute2(d_rp);
}
module rl_druck(fp) translate([r_rl, r_rl, h_rl]) rotate([180, 0, 0]) translate([-X_RL, -Y_RL, -Z_K1]) rl_welt(fp);

// Neigezylinder (auf dem Dach, Auge auf dem Mastkopf; gedruckt auf der Seite liegend)
module nz_2d() let(x0 = X_TZ - M(0.08), c = r_tc * 0.4) {
    polygon([[x0, Z_K1], [X_B1, Z_K1], [X_B1, Z_K1 + 2 * r_tc - c], [X_B1 - c, Z_K1 + 2 * r_tc], [x0 + c, Z_K1 + 2 * r_tc], [x0, Z_K1 + 2 * r_tc - c]]);
    translate([X_B1 - 0.01, Z_K1 + r_tc - r_tr]) square([X_PE - X_B1 + 0.01, 2 * r_tr]);
    translate([X_PE - r_ey, Z_EY]) square([2 * r_ey, t_ey]);
}
module nz_welt(yc, fp) if (inc(fp, "B")) difference() {
    union() {
        xz(yc - r_tc, yc + r_tc) nz_2d();
        translate([X_TZ - d_tp / 2, yc - r_tc, Z_K1 - l_tp]) cube([d_tp, 2 * r_tc, l_tp + 0.01]);   // Steckzunge (liegt beim Druck auf dem Bett)
    }
    translate([X_PE, yc, Z_EY - 1]) linear_extrude(t_ey + 2) raute2(d_mz + spiel);   // Raute: druckt liegend als Spitzbogen
}
module nz_druck(fp) multmatrix([[1, 0, 0, -(X_TZ - M(0.08))], [0, 0, 1, -(Z_K1 - l_tp)], [0, -1, 0, r_tc], [0, 0, 0, 1]]) nz_welt(0, fp);

// Ansaugrohr mit Luftfilter (gedruckt kopfüber, Zapfen nach oben)
module ar_welt(fp) if (inc(fp, "B")) translate([X_AR, Y_AR, Z_G]) {
    cylinder(d = d_ar, h = M(2.2) - Z_G, $fn = 24);
    translate([0, 0, M(1.85) - Z_G - (d_af - d_ar) / 2]) cylinder(d1 = d_ar, d2 = d_af, h = (d_af - d_ar) / 2 + 0.01, $fn = 32);
    translate([0, 0, M(1.85) - Z_G]) cylinder(d = d_af, h = M(0.35), $fn = 32);
    translate([0, 0, M(2.2) - Z_G - (d_ak - d_af) / 2]) cylinder(d1 = d_af, d2 = d_ak, h = (d_ak - d_af) / 2 + 0.01, $fn = 32);
    translate([0, 0, M(2.2) - Z_G]) cylinder(d = d_ak, h = h_ak, $fn = 32);
    translate([0, 0, -l_arp]) linear_extrude(l_arp + 0.01) raute2(d_arp);
}
module ar_druck(fp) translate([d_ak / 2, d_ak / 2, Z_AR - Z_G]) rotate([180, 0, 0]) translate([-X_AR, -Y_AR, -Z_G]) ar_welt(fp);

// =====================================================================
//  Hubmast, Gabelträger, Gabeln
// =====================================================================
module mast_welt(fp) if (inc(fp, "B")) difference() {
    union() {
        for (sy = [-1, 1]) translate([X_M0, sy > 0 ? Y_M - W_R : -Y_M, Z_M0]) cube([D_M, W_R, Z_M1 - Z_M0]);
        for (zz = [[Z_M0, M(0.16)], [M(1.32), M(0.12)], [Z_M1 - M(0.14), M(0.14)]])
            translate([X_M0, -Y_M + 0.01, zz[0]]) cube([D_M * 0.7, 2 * Y_M - 0.02, zz[1]]);
        // Hubzylinder mittig (vorn gefast) und Kolbenstange
        let(w = max(M(0.16), 2.0), d = min(D_M * 0.75, max(M(0.16), 2.0)), c = d * 0.3)
            translate([0, 0, Z_M0]) linear_extrude(M(2.25) - Z_M0) polygon([[X_M0, -w / 2], [X_M0 + d - c, -w / 2], [X_M0 + d, -w / 2 + c], [X_M0 + d, w / 2 - c], [X_M0 + d - c, w / 2], [X_M0, w / 2]]);
        let(w = max(M(0.08), 1.2)) translate([X_M0, -w / 2, Z_M0]) cube([min(D_M * 0.5, max(M(0.1), 1.4)), w, Z_M1 - Z_M0 - 0.01]);
        // Zapfen für die Augen der Neigezylinder
        for (sy = [-1, 1]) translate([X_PE, sy * Y_MZ, Z_M1 - 0.01]) linear_extrude(l_mt + 0.01) raute2(d_mz);   // Spitze unten auf dem Druckbett
    }
    // Fuge Außen-/Innenmast (vorn)
    if (W_R >= d_mz + 2.4) for (sy = [-1, 1]) translate([X_M1 - 0.4, sy * (Y_M - 0.18 * W_R) - 0.2, Z_M0 + M(0.25)]) cube([1, 0.4, Z_M1 - Z_M0 - M(0.5)]);
    // hinten: Mastlager
    for (sy = [-1, 1]) translate([X_M0 - 0.01, sy * Y_MZ, Z_PV]) rotate([0, 90, 0]) linear_extrude(l_in + 0.31) raute2(d_mz + spiel);
    // vorne: Hubstufen des Gabelträgers
    for (sy = [-1, 1], k = [0 : 3]) translate([X_M1 + 0.01, sy * Y_MZ, HC(k) + H_CT / 2]) rotate([0, -90, 0]) linear_extrude(l_in + 0.31) raute2(d_mz + spiel);
}
module mast_druck(fp) multmatrix([[0, 0, 1, -Z_M0], [0, -1, 0, Y_M], [1, 0, 0, -X_M0], [0, 0, 0, 1]]) mast_welt(fp);

module traeger_welt(hc, fp) if (inc(fp, "B")) {
    translate([X_C0, -W_CT / 2, hc + H_CT - b_bar]) cube([T_CB, W_CT, b_bar]);
    translate([X_C0, -W_CT / 2, hc]) cube([T_CB, W_CT, b_bar]);
    for (y = [-W_CT / 2, W_CT / 2 - w_po]) translate([X_C0, y, hc]) cube([T_CB, w_po, H_CT]);
    for (sy = [-1, 1]) {
        translate([X_C0, sy * Y_MZ - w_gp / 2, hc]) cube([T_CB, w_gp, H_CT]);
        translate([X_M1 + 0.1, sy * Y_MZ - w_gp / 2, hc]) cube([X_C0 - X_M1 - 0.1 + 0.01, w_gp, H_CT]);
        translate([X_M1 + 0.11, sy * Y_MZ, hc + H_CT / 2]) rotate([0, -90, 0]) linear_extrude(l_in + 0.11) raute2(d_mz);
    }
}
module traeger_druck(fp) multmatrix([[0, -1, 0, W_CT / 2], [0, 0, 1, 0], [-1, 0, 0, X_C1], [0, 0, 0, 1]]) traeger_welt(0, fp);

module gabel_2d(hc) let(zb = hc - D_FB, zt = hc + H_CT + spiel + t_ht, zl = hc + H_CT - h_hk,
                        t_tip = max(Tf * 0.35, 0.5), L_tip = M(0.2), r_h = Tf * 0.6)
    polygon([[XS_F, zb], [XE_F, zb], [XE_F, zb + t_tip], [XE_F - L_tip, zb + Tf], [XS_F + Tf + r_h, zb + Tf], [XS_F + Tf, zb + Tf + r_h],
             [XS_F + Tf, zt], [XH_F, zt], [XH_F, zl], [XH_F + t_hk, zl], [XH_F + t_hk, zt - t_ht], [XS_F, zt - t_ht]]);
module gabel_welt(sy, hc, fp) if (inc(fp, "B")) xz(sy * Y_G - Wf / 2, sy * Y_G + Wf / 2) gabel_2d(hc);
module gabel_druck(fp) if (inc(fp, "B")) multmatrix([[1, 0, 0, -XH_F], [0, 0, 1, 0], [0, -1, 0, Wf / 2], [0, 0, 0, 1]]) xz(-Wf / 2, Wf / 2) gabel_2d(D_FB);

// =====================================================================
//  Räder (Reifen B, Felge A)
// =====================================================================
module rad_lokal(vorne, fp) let(R = vorne ? R_V : R_H, B = vorne ? B_V : B_H, t = vorne ? t_nbv : t_nbh, g = vorne ? G_ZW : 0) {
    if (inc(fp, "B")) reifen_rad("A", R, B, R_FE, d_rz, t, g, M(0.13));
    if (inc(fp, "A")) reifen_rad("B", R, B, R_FE, d_rz, t, g, M(0.13));
}
module rad_welt(vorne, sy, fp, ex = 0) translate([vorne ? X_VA : X_HA, sy * ((vorne ? Y_VI : Y_HI) + ex), vorne ? R_V : R_H])
    rotate([sy > 0 ? -90 : 90, 0, 0]) rad_lokal(vorne, fp);

// =====================================================================
//  Zusammenbau
// =====================================================================
module stapler_welt(fp, ex = 0) {
    fahrgestell_welt(fp);
    for (sy = [-1, 1]) translate([0, sy * 0.6 * ex, 0]) kf_welt(sy, fp);
    translate([0, 0, 1.2 * ex]) kabine_welt(fp);
    translate([0, 0, 0.6 * ex]) kern_welt(fp);
    translate([0, 0, 1.8 * ex]) rl_welt(fp);
    translate([0, 0, 1.4 * ex]) ar_welt(fp);
    translate([ex, 0, 0]) mast_welt(fp);
    for (sy = [-1, 1]) translate([0.5 * ex, 0, 2.2 * ex]) nz_welt(sy * Y_MZ, fp);
    translate([1.8 * ex, 0, 0]) traeger_welt(HC(gabel_stufe), fp);
    for (sy = [-1, 1]) translate([2.6 * ex, 0, 0]) gabel_welt(sy, HC(gabel_stufe), fp);
    for (v = [true, false], sy = [-1, 1]) rad_welt(v, sy, fp, 0.9 * ex);
}
module bunt(f) color(fhex(f)) render(convexity = 8) children();

// =====================================================================
//  Bausatz-Karte
// =====================================================================
w_r = rahmen_breite; h_r = rahmen_hoehe; g_k = karte_abstand; h_g = steg_hoehe; w_g = steg_breite;
d_tag = 4.4; h_s = 0.4; H_TB = 7;
S_FG = [X_M0 + l_in, 2 * YH_FG];
S_KB = [xa(Z_D) - X_KMIN, 2 * (Y_K + ue)];
S_GK = [X_GMAX - X_GMIN, 2 * (Y_K - o1)];
S_MA = [Z_M1 - Z_M0 + l_mt, 2 * Y_M];
S_TR = [W_CT, H_CT];
S_KF = [X_KFV - X_BF, Z_KT - Z_KFB];
S_GA = [XE_F - XH_F, D_FB + H_CT + spiel + t_ht];
S_NZ = [X_PE + r_ey - X_TZ + M(0.08), max(2 * r_tc, Z_EY + t_ey - Z_K1) + l_tp];
r_fx = R_FE - es;
KF_GX = [X_VA - d_kr / 2 - M(0.25), X_VA - d_kr / 2 + M(0.05)];   // Anguss an der Oberseite
KF_T  = 1 + R_KO - sqrt(R_KO * R_KO - M(0.21) * M(0.21));
GK_X  = [xr(Z_GT) + o1 / cos(a_r), xa(Z_GT) - o1 / cos(a_f)];      // Deckel des Glaskerns
// [teil, sx, sy, Anguss-x (lokal), Eindringtiefe, Farbteil, Nummer]
ITEMS = [
    ["fahrgestell",       S_FG[0], S_FG[1], [M(0.12), (X_HA + R_WK + X_RBF0) / 2], YH_FG - Y_B + M(0.09) + 1.5, "B", 1],
    ["kabine",            S_KB[0], S_KB[1], [for (f = [0.2, 0.8]) X_RR + f * (X_RF - X_RR) - X_KMIN], 1, "B", 2],
    ["glaskern",          S_GK[0], S_GK[1], [for (f = [0.25, 0.75]) GK_X[0] + f * (GK_X[1] - GK_X[0]) - X_GMIN], 1, "D", 3],
    ["mast",              S_MA[0], S_MA[1], [0.12 * S_MA[0], 0.5 * S_MA[0], 0.85 * S_MA[0]], 1, "B", 4],
    ["reifen_vorne",      2 * R_V, 2 * R_V, [R_V], 0.7 * c_tv + 1, "B", 9],
    ["reifen_vorne",      2 * R_V, 2 * R_V, [R_V], 0.7 * c_tv + 1, "B", 9],
    ["reifen_hinten",     2 * R_H, 2 * R_H, [R_H], 0.7 * c_th + 1, "B", 10],
    ["reifen_hinten",     2 * R_H, 2 * R_H, [R_H], 0.7 * c_th + 1, "B", 10],
    ["gabel",             S_GA[0], S_GA[1], [for (f = [0.35, 0.85]) XS_F - XH_F + f * (XE_F - XS_F)], 1, "B", 8],
    ["gabel",             S_GA[0], S_GA[1], [for (f = [0.35, 0.85]) XS_F - XH_F + f * (XE_F - XS_F)], 1, "B", 8],
    ["gabeltraeger",      S_TR[0], S_TR[1], [0.1 * S_TR[0], 0.9 * S_TR[0]], 1, "B", 5],
    ["neigezylinder",     S_NZ[0], S_NZ[1], [for (f = [0.3, 0.75]) M(0.08) + f * (X_B1 - X_TZ)], l_tp + 1, "B", 14],
    ["neigezylinder",     S_NZ[0], S_NZ[1], [for (f = [0.3, 0.75]) M(0.08) + f * (X_B1 - X_TZ)], l_tp + 1, "B", 14],
    ["felge_vorne",       2 * r_fx, 2 * r_fx, [r_fx], lip_w + 1, "A", 11],
    ["felge_vorne",       2 * r_fx, 2 * r_fx, [r_fx], lip_w + 1, "A", 11],
    ["felge_hinten",      2 * r_fx, 2 * r_fx, [r_fx], lip_w + 1, "A", 12],
    ["felge_hinten",      2 * r_fx, 2 * r_fx, [r_fx], lip_w + 1, "A", 12],
    ["kotfluegel_links",  S_KF[0], S_KF[1], [for (x = KF_GX) X_KFV - x], KF_T, "A", 6],
    ["kotfluegel_rechts", S_KF[0], S_KF[1], [for (x = KF_GX) x - X_BF], KF_T, "A", 7],
    ["ansaugrohr",        d_ak, d_ak, [d_ak / 2], 1, "B", 15],
    ["rundumleuchte",     2 * r_rl, 2 * r_rl, [r_rl], c_rl + 1, "C", 13]
];
NI = len(ITEMS);
A_SUM = lsum([for (it = ITEMS) (it[1] + g_k) * (it[2] + 2 * g_k + w_r)]);
W_MAX = min(usable - 2 * (w_r + g_k), max(max([for (it = ITEMS) it[1]]), karte_max_breite > 0 ? karte_max_breite : sqrt(A_SUM) * 1.15));
// Reihen füllen: jedes Teil in die erste Reihe, in die es nach Breite und Höhe passt (sonst neue Reihe)
function ff(i = 0, rows = [], out = []) = i >= NI ? [out, rows] :
    let(w = ITEMS[i][1], h = ITEMS[i][2],
        fit = len(rows) == 0 ? [] : [for (r = [0 : len(rows) - 1]) if (rows[r][0] + g_k + w <= W_MAX && h <= rows[r][1] + 0.01) r],
        r = len(fit) > 0 ? fit[0] : len(rows), x = len(fit) > 0 ? rows[r][0] + g_k : 0,
        nr = len(fit) > 0 ? [for (k = [0 : len(rows) - 1]) k == r ? [x + w, rows[k][1]] : rows[k]] : concat(rows, [[w, h]]))
    ff(i + 1, nr, concat(out, [[x, r]]));
FF = ff(); PK = FF[0]; RW = FF[1];
NR = len(RW);
function row_h(r) = RW[r][1];
function row_y(r) = r == 0 ? w_r + g_k : row_y(r - 1) + row_h(r - 1) + 2 * g_k + w_r;
W_K = max([for (r = RW) r[0]]) + 2 * (w_r + g_k);
Y_TOP = row_y(NR - 1) + row_h(NR - 1) + g_k;
H_K = Y_TOP + H_TB;
function ix(i) = w_r + g_k + PK[i][0];
function iy(i) = row_y(PK[i][1]);
function tag_x(i) = let(it = ITEMS[i], m = it[1] / 2, hit = len([for (gx = it[3]) if (abs(gx - m) < d_tag / 2 + 1.6 * w_g) 1]) > 0)
    ix(i) + (hit ? it[1] + g_k / 2 : m);

module teil_druck(n, fp) {
    if (n == "fahrgestell") fahrgestell_druck(fp);
    else if (n == "kabine") kabine_druck(fp);
    else if (n == "glaskern") kern_druck(fp);
    else if (n == "mast") mast_druck(fp);
    else if (n == "gabeltraeger") traeger_druck(fp);
    else if (n == "kotfluegel_links") kf_druck(1, fp);
    else if (n == "kotfluegel_rechts") kf_druck(-1, fp);
    else if (n == "gabel") gabel_druck(fp);
    else if (n == "reifen_vorne") { if (inc(fp, "B")) translate([R_V, R_V, 0]) rad_lokal(true, "B"); }
    else if (n == "reifen_hinten") { if (inc(fp, "B")) translate([R_H, R_H, 0]) rad_lokal(false, "B"); }
    else if (n == "felge_vorne") { if (inc(fp, "A")) translate([r_fx, r_fx, 0]) rad_lokal(true, "A"); }
    else if (n == "felge_hinten") { if (inc(fp, "A")) translate([r_fx, r_fx, 0]) rad_lokal(false, "A"); }
    else if (n == "rundumleuchte") rl_druck(fp);
    else if (n == "neigezylinder") nz_druck(fp);
    else if (n == "ansaugrohr") ar_druck(fp);
}
module steg(x, y0, y1) hull() {
    translate([x - 0.8 * w_g, y0, 0]) cube([1.6 * w_g, 0.01, h_g]);
    translate([x - w_g / 2, y1 - 0.01, 0]) cube([w_g, 0.01, h_g]);
}
module rahmen() {
    for (r = [0 : NR - 1]) translate([0, row_y(r) - g_k - w_r, 0]) cube([W_K, w_r, h_r]);
    translate([0, Y_TOP, 0]) cube([W_K, H_TB, h_r]);
    for (x = [0, W_K - w_r]) translate([x, 0, 0]) cube([w_r, H_K, h_r]);
    for (i = [0 : NI - 1]) if (ITEMS[i][6] > 0) translate([tag_x(i), iy(i) - g_k - w_r / 2, 0]) cylinder(d = d_tag, h = h_r, $fn = 32);
}
module schrift() translate([0, 0, h_r - 0.01]) linear_extrude(h_s + 0.01) {
    fnt = "Liberation Sans:style=Bold";
    translate([w_r + 1.5, Y_TOP + H_TB / 2]) text(karte_titel, size = H_TB * 0.5, font = fnt, valign = "center");
    translate([W_K - w_r - 1.5, Y_TOP + H_TB / 2]) text(karte_untertitel != "" ? karte_untertitel : str("FDM-KIT 1:", den), size = H_TB * 0.42, font = fnt, halign = "right", valign = "center");
    for (i = [0 : NI - 1]) if (ITEMS[i][6] > 0) translate([tag_x(i), iy(i) - g_k - w_r / 2]) text(str(ITEMS[i][6]), size = d_tag * 0.5, font = fnt, halign = "center", valign = "center");
}
module karte(fp) {
    if (inc(fp, karte_farbteil)) rahmen();
    if (inc(fp, schrift_farbteil)) schrift();
    for (i = [0 : NI - 1]) let(it = ITEMS[i], x0 = ix(i), y0 = iy(i)) {
        translate([x0, y0, 0]) teil_druck(it[0], fp);
        if (inc(fp, it[5])) for (gx = it[3]) steg(x0 + gx, y0 - g_k - (it[5] == karte_farbteil ? 0.01 : 0), y0 + it[4]);
    }
}

// =====================================================================
//  Info und Ausgabe
// =====================================================================
echo(str("Gabelstapler 1:", den, " | bis Gabelrücken ", r2(XS_F + Tf), " mm, mit Gabeln ", r2(XE_F), " mm | Breite ", r2(2 * Y_KFA),
         " mm | Kabine ", r2(Z_K1), " mm | Mast ", r2(Z_M1), " mm"));
echo(str("Karte ", r2(W_K), " x ", r2(H_K), " mm, ", NR, " Reihen, ", NI, " Teile | Anguss ", w_g, " x ", h_g, " mm"));
echo(str("Zapfen: Rad ◇", r2(d_rz), " | Mast/Träger ◇", r2(d_mz), " x ", r2(l_in), " | Kotflügel ◇", r2(d_kp), " x ", r2(l_kp),
         " | Neigezylinder ◇", r2(d_tp), " x ", r2(l_tp), " / Mastkopf ", r2(l_mt), " | Gabelmitte ±", r2(Y_G), " mm | Einsatz-Spiel ", es, " mm"));
echo(str("Mindestmaße: A-Säule ", r2(p_a), " | Überrollsäule ", r2(p_rs), " | Kabinenwand ", r2(t_k), " | Glaswand ", r2(t_g), " | Gabel ", r2(Tf), " x ", r2(Wf), " | Mastschiene ", r2(W_R), " x ", r2(D_M), " mm"));
if (teil == "karte" && (W_K > usable || H_K > usable)) echo("WARNUNG: Karte größer als das Druckbett");
if (Y_G < Wf) echo("WARNUNG: Gabeln zu eng (Führungsplatten)");
if (W_R < d_mz + 1.0) echo("WARNUNG: Mastschiene zu schmal für die Zapfen");
if (XH_F < X_M1 + 0.1) echo("WARNUNG: Gabelhaken berührt den Mast");
if (len([for (p = KP) if (p[0] - d_kp / 2 < X_BF + 0.3 || p[1] - d_kp / 2 < Z0 + 0.3) 1]) > 0) echo("WARNUNG: Kotflügel-Zapfen außerhalb des Vorderteils");
if (Z_QT < Z_QB + 2) echo("WARNUNG: Dreiecksfenster zu klein");
if (xa(Z_PT) - p_a <= X_BP1 + 1) echo("WARNUNG: Tür zu schmal");
mass_echo(XE_F, 2 * Y_KFA, Z_EY + t_ey);

druck("fahrgestell", 1, "A", farbe_lack, 1); druck("fahrgestell", 1, "B", farbe_rahmen, 1); druck("fahrgestell", 1, "C", farbe_akzent, 1);
druck("kabine", 1, "alle", farbe_rahmen, 1);
druck("glaskern", 1, "alle", farbe_glas, 1);
druck("mast", 1, "alle", farbe_rahmen, 1);
druck("gabeltraeger", 1, "alle", farbe_rahmen, 1);
druck("kotfluegel_links", 1, "A", farbe_lack, 1); druck("kotfluegel_links", 1, "B", farbe_rahmen, 1);
druck("kotfluegel_rechts", 1, "A", farbe_lack, 1); druck("kotfluegel_rechts", 1, "B", farbe_rahmen, 1);
druck("gabel", 1, "alle", farbe_rahmen, 2);
druck("reifen_vorne", 1, "alle", farbe_rahmen, 2);
druck("reifen_hinten", 1, "alle", farbe_rahmen, 2);
druck("felge_vorne", 1, "alle", farbe_lack, 2);
druck("felge_hinten", 1, "alle", farbe_lack, 2);
druck("rundumleuchte", 1, "alle", farbe_akzent, 1);
druck("neigezylinder", 1, "alle", farbe_rahmen, 2);
druck("ansaugrohr", 1, "alle", farbe_rahmen, 1);
farben_echo();

if (teil == "aufbau" || teil == "explosion") {
    ex = teil == "explosion" ? max(M(1.2), 10) : 0;
    if ($preview && farbteil == "alle") for (g = GR) bunt(fcol(g)) stapler_welt(g, ex); else stapler_welt(farbteil, ex);
}
else if (teil == "karte") {
    if ($preview && farbteil == "alle") for (g = GR) bunt(fcol(g)) karte(g); else karte(farbteil);
}
else {
    if ($preview && farbteil == "alle") for (g = GR) bunt(fcol(g)) teil_druck(teil, g); else teil_druck(teil, farbteil);
}
