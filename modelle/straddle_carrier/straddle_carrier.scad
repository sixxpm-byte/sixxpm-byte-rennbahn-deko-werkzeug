// =====================================================================
//  STRADDLE CARRIER  –  Portalhubwagen mit Teleskopbeinen
//  (Vorbild: Shuttle Carrier, 1 über 1; der Oberrahmen hebt sich auf den
//  Innenbeinen).  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei),
//  Farben je Bauteil, Maßstab 1:43 / 1:87.  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    fahrwerk_links    Fahrwerk links: Längsträger, zwei Radstützen mit Beinfuß,
//                      Zapfen für Räder, Kabine und Motor                      1x
//    fahrwerk_rechts   Fahrwerk rechts (ohne Kabinen-/Motorzapfen)              1x
//    oberrahmen        Seitenteil oben: Obergurt, zwei Oberbeine, Streben      2x
//    innenbein         Innenbein (A, schwarz) und Kolbenstange (B, silber):
//                      zwei Stäbe, stecken gemeinsam in den Beinschächten       4x
//    quertraeger       Querträger an den Enden; Leuchtenleiste (B) steckt in einer Tasche 2x
//    mitteltraeger     Mittelträger, trägt den Spreader am Drehzapfen          1x
//    spreader_rahmen   Spreader-Mittelteil mit zwei Kanälen und Drehzapfen     1x
//    spreader_arm      Teleskoparm (schwarz) mit Schwalbenschwanz am Ende       2x
//    kopftraeger       Kopfträger mit Schwalbenschwanz-Aufnahme, Magnettasche(n), Koni 2x
//    c20_... / c40_... Container-Bausatz 20 bzw. 40 Fuß (lib/deko_container.scad):
//      boden, dach (mit Magnettaschen von innen), seite 2x, stirn, tuer
//      (40 Fuß bei 1:43: Boden/Dach mit Clips geteilt, Seitenwände zweiteilig)
//    verbinder         Clips für geteilte Container-Teile (nur wenn nötig)
//    rad               Reifen mit Innenrand (A) und Felge (B, von außen eingedrückt) 4x
//    kabine            Fahrerkabine unten offen (A), Glaskern (B) von unten eingeschoben,
//                      von den Kabinenzapfen gesichert                         1x
//    motor             Motormodul mit Tasche für das Lüftergitter              1x
//    motor_gitter      Lüftergitter, flach gedruckt, in die Tasche gedrückt    1x
//  Alle Farbteile sind gesteckt: einfarbig jede STL einzeln drucken und zusammenstecken.
//
//  BEWEGLICH
//    * Räder drehen sich auf den Achszapfen.
//    * Beide Teleskoparme ziehen den Spreader von 20 Fuß auf 40 Fuß aus.
//    * Der Spreader steckt mit dem Drehzapfen stramm im Mittelträger (abnehmbar).
//    * Container-Halterung: Magnete in Taschen unter den Kopfträgern, Gegenstück
//      (Magnet oder Stahlscheibe) unsichtbar von innen im Containerdach; Koni
//      zentrieren in den Eckbeschlägen (ISO-Lochabstand).
//  STARR
//    Die Hubhöhe (hubhoehe_m = Unterkante Spreader) legt die Länge der Innenbeine
//    fest.  Für eine andere Hubhöhe nur die vier Innenbeine neu drucken.
//  DRUCK
//    Alle Teile stützfrei: Fahrwerk und Oberrahmen auf der Innenseite liegend
//    (Beinschächte mit gefastem Dach, kurze Brücke), Quer- und Mittelträger auf der Rückseite,
//    Spreader-Rahmen aufrecht, Arme und Kopfträger kopfüber, Innenbeine auf der
//    Außenseite, Räder auf der Innenseite, Kabine und Motor aufrecht, Gitter flach.  Container: Boden und
//    Dach kopfüber, Seitenwände innen unten, Stirn- und Türseite außen unten.
//  MONTAGE (Kurzfassung)
//    1. Felgen in die Reifen drücken, Räder auf die Achszapfen; Glaskern in die
//       Kabine, Gitter in den Motor; Kabine und Motor an das linke Fahrwerk stecken.
//    2. Innenbein und Stange nebeneinander in die Beinfüße stecken (Stange zur Mitte).
//    3. Leuchtenleisten einsetzen, Oberrahmen mit Quer- und Mittelträgern verbinden.
//    4. Magnete in die Kopfträger kleben, Arme von oben in die Kopfträger drücken,
//       Arme in den Spreader schieben, Spreader von unten in den Mittelträger stecken.
//    5. Oberteil auf die Innenbeine setzen.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, fahrwerk_links:Fahrwerk links, fahrwerk_rechts:Fahrwerk rechts, oberrahmen:Oberrahmen (2x), innenbein:Innenbein mit Stange (4x), quertraeger:Querträger (2x), mitteltraeger:Mittelträger, spreader_rahmen:Spreader-Rahmen, spreader_arm:Teleskoparm (2x), kopftraeger:Kopfträger (2x), rad:Rad (4x), kabine:Fahrerkabine, motor:Motormodul, motor_gitter:Lüftergitter, c20_boden:Container 20' Boden, c20_dach:Container 20' Dach, c20_seite:Container 20' Seitenwand (2x), c20_stirn:Container 20' Stirnwand, c20_tuer:Container 20' Türseite, c40_boden:Container 40' Boden, c40_dach:Container 40' Dach, c40_seite:Container 40' Seitenwand (2x), c40_stirn:Container 40' Stirnwand, c40_tuer:Container 40' Türseite, verbinder:Verbinder-Clips (Container)]
stueck = 0;
farbteil = "alle"; // [alle, A, B]

/* [Vorschau] */
// Spreader-Länge (0 = 20 Fuß, 1 = 40 Fuß)
spreader_auszug = 0; // [0:0.05:1]
// Container am Spreader (20 Fuß bei eingefahrenen, 40 Fuß bei ausgefahrenen Armen)
container_zeigen = true;

/* [Straddle Carrier (Vorbild in Metern)] */
// Unterkante Spreader = Oberkante des getragenen Containers (legt die Innenbein-Länge fest)
hubhoehe_m = 5.0;
laenge_m = 8.0;
// Achsabstand = Abstand der Beine
radstand_m = 5.6;
// Breite über die Räder
breite_m = 5.2;
rahmen_dicke_m = 0.5;
oberbein_breite_m = 0.85;
oberbein_laenge_m = 2.6;
obergurt_hoehe_m = 0.7;
laengstraeger_unten_m = 1.0;
laengstraeger_hoehe_m = 0.55;
// Oberkante Beinfuß (darauf stehen Innenbein und Stange)
beinfuss_hoehe_m = 1.9;
rad_d_m = 1.5;
rad_b_m = 0.55;
kabine_laenge_m = 1.6;
kabine_hoehe_m = 2.1;
kabine_tiefe_m = 0.85;
motor_laenge_m = 2.0;
motor_hoehe_m = 1.45;

/* [Container-Halterung] */
// Magnettaschen unter den Kopfträgern (Magnet von unten bündig einkleben)
magnete = true;
// Magnet-Durchmesser in mm (z. B. 5 x 2 Neodym)
magnet_d = 5;
// Magnet-Höhe in mm
magnet_h = 2;
// Luft je Seite in der Tasche (0 = stramm einpressen)
magnet_spiel = 0.1;
// Magnete je Kopfträger
magnet_anzahl = 1; // [1, 2]
// Dachhaut über dem Container-Magnet in mm (Magnet sitzt unsichtbar von innen im Dach)
magnet_haut = 0.6;
// Zentrierzapfen (Koni) unter den Kopfträgern
koni = true;

/* [Container (Vorbild in Metern)] */
container_20_m = 6.058;
container_40_m = 12.192;
container_breite_m = 2.438;
// 2.591 Standard, 2.896 High Cube
container_hoehe_m = 2.591;
// Dachrahmen, Eckpfosten und Obergurte in Beschlagfarbe – nur für Mehrfarbdruck in einem Durchgang (diese Farbteile sind dann nicht gesteckt)
container_zweifarbig = false;

/* [Farben] */
farbe_gelb      = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_leuchte   = "weiss";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_spreader  = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kopf      = "gelb";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_innenbein = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_stange    = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_reifen    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_felge     = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_glas      = "puderblau"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gitter    = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_beschlag  = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_clips     = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_container = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

/* [Druck & Passung] */
rennbahn_taschen = true;   // (keine Bodenplatte – bleibt für die Bibliothek stehen)
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 4;
// Luft je Seite in den Teleskopkanälen
tele_spiel = 0.2;
// Luft je Seite: Koni, Drehzapfen und Schwalbenschwanz Arm/Kopfträger (klein = stramm)
zapfen_spiel = 0.05;
// Luft je Seite für eingedrückte Farbteile: Felge, Glaskern, Leuchtenleiste, Lüftergitter (klein = Klemmsitz)
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
          ["hellblau", "#5aa2dc"], ["dunkelgruen", "#1f6b3a"], ["puderblau", "#8cc8ea"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

// =====================================================================
//  Maße (Welt: x = 0 Mitte, +x nach vorne, y = 0 Mitte, +y links, z = 0 Boden; mm)
// =====================================================================
XL   = M(radstand_m / 2);                 // Beinmitte
XE   = M(laenge_m / 2);                   // Ende Obergurt
HO   = M(obergurt_hoehe_m);
BO   = M(oberbein_breite_m);
BU   = M(oberbein_breite_m + 0.05);       // Beinfuß
ZS0  = M(laengstraeger_unten_m);
ZS1  = ZS0 + M(laengstraeger_hoehe_m);
Z_f1 = M(beinfuss_hoehe_m);
R_w  = M(rad_d_m / 2);
z_ax = R_w;
B_w  = M(rad_b_m);
s_r  = max(M(0.03), 0.4);                 // Luft Rad – Rahmen
t_f  = M(rahmen_dicke_m);
y_a  = M(breite_m / 2) - B_w - s_r;       // Außenseite Rahmen
y_i  = y_a - t_f;                         // Innenseite Rahmen
dmr  = max(sc(20), 0.3);                  // Relieftiefe
w_rd = max(M(0.08), 1.0);                 // Rand um vertiefte Felder
e_x  = M(0.25);                           // Schräge an den Obergurt-Enden
kb2  = M(0.4);                            // Knie am Beinfuß

// Achszapfen (rund, im Druck senkrecht) und Nabe
d_rz = max(M(0.22), 3);
r_bs = max(M(0.4), d_rz / 2 + 1.6);       // Radstütze (Kreis um die Achse)
h_hub = B_w - max(M(0.08), 1.0);
l_rz = s_r + h_hub - 0.4;
c_rz = max(M(0.04), 0.4);                 // Fase an Zapfenspitzen

// Spreader (Welt: Mitte x = y = 0)
d_mt = magnet_d + 2 * magnet_spiel;       // Magnettasche
h_mt = magnet_h + 0.1;
// Container-Bausatz (Koni d_tw/h_tw, Lochabstand in_x/in_y, Maße L_c20 … aus der Bibliothek)
ct_mag = magnete; ct_mag_d = d_mt; ct_mag_h = h_mt; ct_mag_n = magnet_anzahl; ct_mag_haut = magnet_haut;
ct_zweifarbig = container_zweifarbig;
// =====================================================================
//  deko_container.scad – Container-Bausatz 20/40 Fuß (ISO) für die Rennbahn-Deko-Reihe
//  Teile: boden, dach (A Dachblech, B Obergurte + Eckbeschläge), seite 2x, stirn, tuer;
//  40 Fuß bei 1:43 mit Clips geteilt (CLIPS).  Druck: ct_druck(Lc, name, farbteil, stueck),
//  Welt/Vorschau: ct_welt(Lc, ex) lokal (x 0..Lc, y 0..W_ct, z 0..H_ct; Türen bei x = Lc).
//
//  Einbinden NACH deko_grundlagen.scad, VOR deko_hilfen.scad; vorher im Modell festlegen:
//    container_20_m, container_40_m, container_breite_m, container_hoehe_m, zapfen_spiel,
//    farbe_container, farbe_beschlag,
//    ct_mag (Magnettaschen im Dach an/aus), ct_mag_d, ct_mag_h (Tasche in mm),
//    ct_mag_n (1 = mittig, 2 = bei 1/4 und 3/4 der Breite), ct_mag_haut (Dachhaut über dem Magnet),
//    ct_zweifarbig (true: Dach, Stirn und Tür mit Farbteil B = Dachrahmen/Eckpfosten/Obergurte in
//    farbe_beschlag – nur für Mehrfarbdruck in einem Durchgang, B ist nicht gesteckt;
//    false: diese Teile einfarbig, dann druck(..., "alle", farbe_container, ...))
//  Die Magnettaschen sitzen von innen im Dachblech, ct_mag_x von jeder Stirnseite.
// =====================================================================
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

// Magnettaschen im Dach (von innen, unsichtbar): Mitte ct_mag_x ab Stirnseite, Boss frei von Eckpfosten/Obergurt
ct_mag_x  = cx_e + spiel + ct_mag_d / 2 + min_wand;
ct_mag_z0 = H_ct - ct_mag_haut - ct_mag_h;          // Unterkante Magnet (= Boss-Unterkante)
function ct_mag_ys() = ct_mag_n == 2 ? [W_ct / 4, 3 * W_ct / 4] : [W_ct / 2];
function ct_mag_pos(Lc) = [for (x = [ct_mag_x, Lc - ct_mag_x], y = ct_mag_ys()) [x, y]];
ct_p_r = 12; ct_t_r = 1.2;                           // Rippen im Boden

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
        for (xx = [ct_p_r : ct_p_r : Lc - ct_p_r / 2]) translate([xx - ct_t_r / 2, rb - 0.01, 0]) cube([ct_t_r, W_ct - 2 * rb + 0.02, z_f]);
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
            if (!ct_zweifarbig) ct_dach_b(Lc);
            for (sx = xs) translate([sx - spw / 2 - 1, y_cs - 1, H_ct - tr - rib_h]) cube([spw + 2, W_ct - 2 * y_cs + 2, rib_h + 0.01]);
            if (ct_mag && ct_mag_z0 < H_ct - tr) for (p = ct_mag_pos(Lc)) translate([p[0], p[1], ct_mag_z0]) cylinder(d = ct_mag_d + 2 * min_wand, h = H_ct - tr - ct_mag_z0 + 0.01, $fn = 48);
        }
        if (ct_zweifarbig) ct_dach_b(Lc, 0.02);
        loecher();
        if (ct_mag) for (p = ct_mag_pos(Lc)) translate([p[0], p[1], ct_mag_z0 - 1]) cylinder(d = ct_mag_d, h = ct_mag_h + 1, $fn = 48);
    }
    if (ct_zweifarbig && inc(fp, "B")) difference() { ct_dach_b(Lc); loecher(); }
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
    if (!ct_zweifarbig) { if (inc(fp, "A")) { if (tuer) ct_tuer_a(Lc); else ct_stirn_a(); ct_end_b(Lc, tuer); } }
    else {
        if (inc(fp, "A")) difference() { if (tuer) ct_tuer_a(Lc); else ct_stirn_a(); ct_end_b(Lc, tuer, 0.02); }
        if (inc(fp, "B")) ct_end_b(Lc, tuer);
    }
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
    translate([0, 0, -ex]) vorschau_farbe(farbe_beschlag) ct_boden(Lc);
    translate([0, 0, ex]) { vorschau_farbe(farbe_container) ct_dach(Lc, "A"); vorschau_farbe(farbe_beschlag) ct_dach(Lc, "B"); }
    translate([0, -ex, 0]) vorschau_farbe(farbe_container) ct_seite(Lc);
    translate([Lc, W_ct + ex, 0]) rotate([0, 0, 180]) vorschau_farbe(farbe_container) ct_seite(Lc);
    translate([-ex, 0, 0]) { vorschau_farbe(farbe_container) ct_stirn(Lc, "A"); vorschau_farbe(farbe_beschlag) ct_stirn(Lc, "B"); }
    translate([ex, 0, 0]) { vorschau_farbe(farbe_container) ct_stirn(Lc, "A", true); vorschau_farbe(farbe_beschlag) ct_stirn(Lc, "B", true); }
}
CLIPS = clip_count(info_boden(L_c40)) * (len(ct_xs(L_c40)) > 0 ? 1 : 0) + clip_count(info_dach(L_c40)) * (len(ct_xs(L_c40)) > 0 ? 1 : 0)
      + clip_count(info_boden(L_c20)) * (len(ct_xs(L_c20)) > 0 ? 1 : 0) + clip_count(info_dach(L_c20)) * (len(ct_xs(L_c20)) > 0 ? 1 : 0);
eb_x = M(0.35);                           // Kopfträger: Breite außen der Koni-Mitte
d_xm = ct_mag_x - in_x;                   // Magnet liegt um d_xm weiter innen als die Koni
k_in = max(eb_x / 2, magnete ? d_xm + d_mt / 2 + min_wand : 0);   // Kopfträger innen der Koni-Mitte
t_s  = max(M(0.07), min_wand);
w_ch = M(0.42); h_ch = M(0.42);           // Kanal je Arm
b_ab = h_ch - 2 * tele_spiel;             // Arm-Balken: Höhe
n_d  = max(M(0.25), 3);                   // Schwalbenschwanz: Tiefe im Kopfträger
dw   = max(M(0.04), 0.6);                 // Schwalbenschwanz: Aufweitung je Seite
// Kopfträger: Boden unter der Aufnahme trägt die Magnettasche darunter
h_kt = max(M(0.55), b_ab + zapfen_spiel + min_wand + (magnete ? h_mt : 0));
x_kt = L_c20 / 2 - in_x;                  // Kopfträger-Mitte (20 Fuß)
E40  = (L_c40 - L_c20) / 2;
W_kt = W_ct;
Y_MG = magnet_anzahl == 2 ? [-W_kt / 4, W_kt / 4] : [0];
W_sr = 2 * w_ch + 3 * t_s;
g_sr = max(M(0.05), 0.6);
L_sr = 2 * (x_kt - k_in - g_sr);
Z_hub = M(hubhoehe_m);
z_bt = Z_hub + h_kt;                      // Oberkante Arm-Balken = Kopfträger
z_r1 = z_bt + tele_spiel + t_s;           // Oberkante Spreader-Rahmen
z_r0 = z_r1 - h_ch - 2 * t_s;
y_ch = t_s / 2 + w_ch / 2;
yb0  = y_ch - w_ch / 2 + tele_spiel; yb1 = y_ch + w_ch / 2 - tele_spiel;   // Arm-Balken quer
zb0  = z_bt - b_ab;                       // Arm-Balken Unterkante
L_ab = min(E40 + M(1.0), x_kt - k_in + L_sr / 2 - M(0.15));
d_dz = max(M(0.25), 3.0);                 // Drehzapfen
h_dz = max(M(0.25), 2.5);
g_dz = 0.3;

// Oberrahmen: der Obergurt sitzt direkt über dem Spreader
H    = z_r1 + g_dz + HO;                  // Gesamthöhe
Z_ob0 = H - HO - M(oberbein_laenge_m);    // Unterkante Oberbein
w_st = M(0.3);                            // Strebe
x_st = M(1.9);                            // Strebe: Länge in x

// Innenbein (Profil: Rechteck, außen (+y) 45° gefast) und Kolbenstange
b_ib = M(0.38);
t_ib = min(M(0.3), t_f - 2 * (min_wand + spiel));
c_ib = 0.25 * min(b_ib, t_ib);
d_r  = max(M(0.16), 1.6);
l_in = max(M(0.5), 4);                    // Einstecktiefe oben und unten
g_ir = 0.1;                               // Luft Innenbein – Stange
u_ib = (g_ir + d_r) / 2;                  // Bein und Stange zusammen mittig im Schacht
W_ib = b_ib + g_ir + d_r;                 // Breite Bein + Stange
y_ib = y_i + (t_f - t_ib) / 2;            // Innenseite Innenbein
L_ib = Z_ob0 - Z_f1 + 2 * l_in;

// Querträger an den Enden, Mittelträger in der Mitte
b_q  = M(0.45);
x_q  = XE - e_x - b_q / 2 - M(0.05);
yq   = y_i - spiel;
kq   = max(0, min(M(0.6), H - HO - z_bt - M(0.05) + (yq - W_kt / 2)));   // Eckblech (frei über dem Kopfträger)
b_m  = M(0.5);
h_tg = max(M(0.15), 1.6);                 // Feder (liegt im Druck auf dem Bett)
w_tg = max(M(0.3), 3.0);
l_tg = max(M(0.2), 2.5);
z_tc = H - HO / 2;
t_ll = max(M(0.05), 0.8);
h_ll = max(M(0.12), 1.4);
p_ll = max(M(0.03), 0.6);                 // Tasche für die Leuchtenleiste

// Kabine und Motor (außen am linken Längsträger)
K_T  = M(kabine_tiefe_m);
y_k0 = y_a + spiel;
g_kr = max(M(0.15), 1.5);
K_X1 = XL - R_w - g_kr;
K_X0 = K_X1 - M(kabine_laenge_m);
K_Z0 = M(0.45);
K_Z1 = K_Z0 + M(kabine_hoehe_m);
t_k  = max(M(0.07), 1.0);
MO_X0 = -K_X1;
MO_X1 = MO_X0 + M(motor_laenge_m);
MO_Z1 = K_Z0 + M(motor_hoehe_m);
d_kz = max(M(0.2), 2.5);
l_kz = max(M(0.15), 2.0);
z_kz = (ZS0 + ZS1) / 2;
KZ_X = [K_X0 + M(0.4), K_X1 - M(0.4)];
MZ_X = [MO_X0 + M(0.45), MO_X1 - M(0.45)];

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
module box(a, b) translate(a) cube(b - a);
// Kantprofil: x mittig, y 0 .. t, Kanten bei y = t um c gefast
module kant_prof(b, t, c) polygon([[-b / 2, 0], [b / 2, 0], [b / 2, t - c], [b / 2 - c, t], [-b / 2 + c, t], [-b / 2, t - c]]);
module zapfen_rund(d, l, c) { cylinder(d = d, h = l - c, $fn = 24); translate([0, 0, l - c - 0.01]) cylinder(d1 = d, d2 = d - 2 * c, h = c + 0.01, $fn = 24); }
// x-z-Profil auf eine Dicke ziehen (lokal: y = 0 Innenseite)
module rahmen_y(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0) children();
// Schacht für das Innenbein (lokal im Rahmen, ab Höhe z nach unten (dir -1) oder oben (+1))
// Profil Innenbein + Stange (lokal am Bein, Stange bei -x); hinten gespiegelt
module ib_stange_2d() translate([u_ib - b_ib / 2 - g_ir - d_r / 2, t_ib - d_r]) kant_prof(d_r, d_r, 0.3 * d_r);
module ib_bein_2d() translate([u_ib, 0]) kant_prof(b_ib, t_ib, c_ib);
module bein_schacht(z, dir) for (sx = [-1, 1]) translate([sx * XL, y_ib - y_i, dir > 0 ? z - 1 : z - l_in - spiel])
    mirror([sx > 0 ? 0 : 1, 0, 0]) linear_extrude(l_in + spiel + 1) offset(delta = spiel) { ib_bein_2d(); ib_stange_2d();   // Luft g_ir < 2 * spiel: ein gemeinsamer Schacht
        translate([u_ib - b_ib / 2 - g_ir - d_r / 2, t_ib - max(c_ib, 0.3 * d_r)]) square([b_ib / 2 + g_ir + d_r / 2, max(c_ib, 0.3 * d_r)]); }   // Kerbe zwischen Bein und Stange füllen: glatte Decke (Brücke) statt hängender Grat
module vertieft(t) rahmen_y(t - dmr, t + 1) offset(delta = -w_rd) children();

// =====================================================================
//  Fahrwerk (Welt, linke Seite: y_i .. y_a; rechts = 180° gedreht)
// =====================================================================
module fahrwerk_2d() {
    for (sx = [-1, 1]) {
        hull() {
            translate([sx * XL - BU / 2, z_ax]) square([BU, Z_f1 - z_ax]);
            translate([sx * XL, z_ax]) circle(r = r_bs, $fn = 48);
        }
        polygon([[sx * (XL - BU / 2 + 0.01), ZS1 - 0.01], [sx * (XL - BU / 2 - kb2), ZS1 - 0.01], [sx * (XL - BU / 2 + 0.01), ZS1 + kb2]]);
    }
    translate([-XL, ZS0]) square([2 * XL, ZS1 - ZS0]);
}
module fahrwerk_lokal(links) {
    difference() {
        rahmen_y(0, t_f) fahrwerk_2d();
        vertieft(t_f) fahrwerk_2d();
        bein_schacht(Z_f1, -1);
    }
    for (sx = [-1, 1]) translate([sx * XL, t_f - dmr - 0.02, z_ax]) rotate([-90, 0, 0]) zapfen_rund(d_rz, l_rz + dmr + 0.02, c_rz);
    if (links) for (x = concat(KZ_X, MZ_X)) translate([x, t_f - dmr - 0.02, z_kz]) rotate([-90, 0, 0]) zapfen_rund(d_kz, l_kz + spiel + dmr + 0.02, c_rz);
}
module fahrwerk_welt(sy) if (sy > 0) translate([0, y_i, 0]) fahrwerk_lokal(true);
    else rotate([0, 0, 180]) translate([0, y_i, 0]) fahrwerk_lokal(false);
module fahrwerk_druck(links) translate([0, Z_f1, 0]) rotate([90, 0, 0]) fahrwerk_lokal(links);

// =====================================================================
//  Oberrahmen (Welt, linke Seite; rechts = 180° gedreht, gleiches Teil)
// =====================================================================
module oberrahmen_2d() {
    polygon([[-XE, H], [XE, H], [XE, H - 0.55 * HO], [XE - e_x, H - HO], [-XE + e_x, H - HO], [-XE, H - 0.55 * HO]]);
    for (sx = [-1, 1]) {
        translate([sx * XL - BO / 2, Z_ob0]) square([BO, H - Z_ob0 - 0.5 * HO]);
        // Kragen unten am Oberbein
        translate([sx * XL - BO / 2 - M(0.06), Z_ob0]) square([BO + M(0.12), M(0.35)]);
        // Strebe vom Bein schräg zum Obergurt (ragt in Bein und Obergurt hinein)
        hull() {
            translate([sx * (XL - BO / 2 + M(0.1)) - w_st / 2, Z_ob0 + 0.45 * (H - HO - Z_ob0)]) square([w_st, w_st]);
            translate([sx * (XL - BO / 2 - x_st) - w_st / 2, H - HO - w_st / 2]) square([w_st, w_st]);
        }
    }
}
module feder_tasche(xa) translate([xa - spiel, -1, z_tc - w_tg / 2 - spiel]) cube([h_tg + 2 * spiel, l_tg + 1.3, w_tg + 2 * spiel]);
module oberrahmen_lokal() difference() {
    rahmen_y(0, t_f) oberrahmen_2d();
    vertieft(t_f) oberrahmen_2d();
    bein_schacht(Z_ob0, 1);
    feder_tasche(x_q - b_q / 2); feder_tasche(-(x_q - b_q / 2) - h_tg);
    // Mittelträger: Taschen für beide Einbaulagen (links und rechts gleiches Teil)
    feder_tasche(-b_m / 2); feder_tasche(b_m / 2 - h_tg);
}
module oberrahmen_welt(sy) if (sy > 0) translate([0, y_i, 0]) oberrahmen_lokal();
    else rotate([0, 0, 180]) translate([0, y_i, 0]) oberrahmen_lokal();
module oberrahmen_druck() translate([0, H, 0]) rotate([90, 0, 0]) oberrahmen_lokal();

// =====================================================================
//  Innenbein (lokal: x mittig, y 0 innen .. t_ib außen (gefast), z 0 .. L_ib;
//  Stange bei -x = zur Fahrzeugmitte für das Bein vorne links)
// =====================================================================
module innenbein_lokal(fp) {
    if (inc(fp, "A")) difference() {
        linear_extrude(L_ib) ib_bein_2d();
        // Zierfugen (Abstreifer) an den Enden des sichtbaren Teils
        for (z = [l_in + M(0.06), L_ib - l_in - M(0.1)]) translate([u_ib, 0, z]) linear_extrude(max(M(0.04), 0.4))
            difference() { offset(delta = 1) kant_prof(b_ib, t_ib, c_ib); offset(delta = -max(M(0.03), 0.3)) kant_prof(b_ib, t_ib, c_ib); }
    }
    // Kolbenstange: eigener Stab, steckt wie das Bein oben und unten im Schacht
    if (inc(fp, "B")) linear_extrude(L_ib) ib_stange_2d();
}
module innenbein_links(sx, fp) let(z0 = Z_f1 - l_in)
    if (sx > 0) translate([XL, y_ib, z0]) innenbein_lokal(fp);
    else translate([-XL, y_ib, z0 + L_ib]) rotate([0, 180, 0]) innenbein_lokal(fp);
module innenbein_welt(sx, sy, fp) if (sy > 0) innenbein_links(sx, fp); else rotate([0, 0, 180]) innenbein_links(-sx, fp);
// Druck: Außenseite (Fase) unten
module innenbein_druck(fp) translate([0, 0, t_ib]) rotate([0, 0, 90]) rotate([-90, 0, 0]) innenbein_lokal(fp);

// =====================================================================
//  Querträger (Enden) und Mittelträger (Welt; gedruckt auf der Rückseite liegend)
// =====================================================================
module qt_2d(k) {
    translate([-yq, H - HO]) square([2 * yq, HO]);
    if (k > 0) for (sy = [-1, 1]) polygon([[sy * yq, H - HO + 0.01], [sy * (yq - k), H - HO + 0.01], [sy * yq, H - HO - k]]);
}
module qt_x(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0) children();
module federn(xa) for (sy = [-1, 1]) translate([xa, sy > 0 ? yq - 0.01 : -(yq + l_tg + spiel), z_tc - w_tg / 2]) cube([h_tg, l_tg + spiel + 0.01, w_tg]);
yl_ll = yq - max(kq, w_rd) - M(0.1); zl_ll = H - w_rd - 1.3 * h_ll;     // Leuchtenleiste (y, z)
module ll_leiste_2d() translate([-yl_ll, zl_ll]) square([2 * yl_ll, h_ll]);
module ll_lampen_2d() for (sy = [-1, 1]) translate([sy * (yl_ll - h_ll), zl_ll + h_ll / 2]) circle(d = 1.6 * h_ll, $fn = 24);
module quertraeger_welt(fp) {
    xa = x_q - b_q / 2;
    x0 = x_q + b_q / 2 - dmr;                 // Boden des vertieften Feldes
    if (inc(fp, "A")) {
        difference() {
            qt_x(xa, x_q + b_q / 2) qt_2d(kq);
            qt_x(x0, x_q + b_q / 2 + 1) offset(delta = -w_rd) qt_2d(kq);
            qt_x(x0 - p_ll, x0 + 1) offset(delta = einsatz_spiel) { ll_leiste_2d(); ll_lampen_2d(); }   // Tasche
        }
        federn(xa);
    }
    // Leuchtenleiste: steckt mit dem Fuß (p_ll) in der Tasche
    if (inc(fp, "B")) { qt_x(x0 - p_ll, x0 + dmr + t_ll) ll_leiste_2d(); qt_x(x0 - p_ll, x0 + dmr + 1.6 * t_ll) ll_lampen_2d(); }
}
module quertraeger_druck(fp) rotate([0, -90, 0]) translate([-(x_q - b_q / 2), 0, 0]) quertraeger_welt(fp);
module mitteltraeger_welt() difference() {
    union() { qt_x(-b_m / 2, b_m / 2) qt_2d(0); federn(-b_m / 2); }
    // Loch für den Drehzapfen (im Druck waagerecht: Tropfen, Spitze nach oben = +x)
    translate([0, 0, H - HO - 1]) linear_extrude(h_dz + 1.3) teardrop(d_dz / 2 + zapfen_spiel);
}
module mitteltraeger_druck() rotate([0, -90, 0]) translate([b_m / 2, 0, 0]) mitteltraeger_welt();

// =====================================================================
//  Spreader (Welt)
// =====================================================================
module spreader_rahmen_welt() {
    difference() {
        box([-L_sr / 2, -W_sr / 2, z_r0], [L_sr / 2, W_sr / 2, z_r1]);
        for (sy = [-1, 1]) translate([-L_sr / 2 - 1, sy * y_ch - w_ch / 2, z_r0 + t_s]) cube([L_sr + 2, w_ch, h_ch]);
        for (sy = [-1, 1], x = [-L_sr / 4, 0, L_sr / 4]) translate([x - 0.3, sy > 0 ? W_sr / 2 - 0.3 : -W_sr / 2 - 0.01, z_r0 + t_s]) cube([0.6, 0.31, h_ch]);
    }
    translate([0, 0, z_r1 - 0.01]) zapfen_rund(d_dz, h_dz + g_dz + 0.01, c_rz);
}
// Arm vorne (+x, Kanal +y) bei 20 Fuß; Arm hinten = 180° gedreht.
// Steckverbindung: Schwalbenschwanz am Arm-Ende, von oben in die Aufnahme des
// Kopfträgers gedrückt (oben offen, unten Boden): der Kopfträger hängt am Arm und
// lässt sich beim Ausziehen nicht abziehen.
xk = x_kt - k_in;                         // Innenseite Kopfträger
module schwalbe_2d(o) offset(delta = o) polygon([[xk - 0.01, yb0], [xk + n_d, yb0 - dw], [xk + n_d, yb1 + dw], [xk - 0.01, yb1]]);
module spreader_arm_welt() {
    box([xk - L_ab, yb0, zb0], [xk, yb1, z_bt]);
    translate([0, 0, zb0]) linear_extrude(b_ab) schwalbe_2d(0);
}
module kopftraeger_welt() {
    difference() {
        box([xk, -W_kt / 2, Z_hub], [x_kt + eb_x / 2, W_kt / 2, z_bt]);
        // Aufnahme für den Schwalbenschwanz (oben und zur Innenseite offen)
        translate([0, 0, zb0 - zapfen_spiel]) linear_extrude(b_ab + zapfen_spiel + 1) {
            schwalbe_2d(zapfen_spiel);
            translate([xk - 1, yb0 - zapfen_spiel]) square([1 + 0.02, yb1 - yb0 + 2 * zapfen_spiel]);
        }
        // Magnettaschen (von unten; im Druck oben offen)
        if (magnete) for (y = Y_MG) translate([x_kt - d_xm, y, Z_hub - 1]) cylinder(d = d_mt, h = h_mt + 1, $fn = 48);
    }
    if (koni) for (sy = [-1, 1]) translate([x_kt, sy * (W_ct / 2 - in_y), Z_hub + 0.01]) mirror([0, 0, 1]) zapfen_rund(d_tw, h_tw + 0.01, c_rz);
}
module spreader_rahmen_druck() translate([0, 0, -z_r0]) spreader_rahmen_welt();
module spreader_arm_druck() translate([0, 0, z_bt]) rotate([180, 0, 0]) spreader_arm_welt();
module kopftraeger_druck() translate([0, 0, z_bt]) rotate([180, 0, 0]) kopftraeger_welt();

// =====================================================================
//  Rad (lokal: Achse z, Innenseite z = 0 auf dem Bett, Außenseite oben)
// =====================================================================
R_fe = M(0.48);
lip_h = max(M(0.05), 0.6);                // Innenrand im Reifen (Felge liegt darauf)
lip_w = max(M(0.06), 0.8);
module rad(fp) {
    c_t = max(M(0.08), 0.6); n_p = 24; g_d = max(M(0.05), 0.6);
    if (inc(fp, "A")) difference() {
        rotate_extrude($fn = 96) polygon([[R_fe - lip_w, 0], [R_w - c_t, 0], [R_w, c_t], [R_w, B_w - c_t], [R_w - c_t, B_w], [R_fe, B_w], [R_fe, lip_h], [R_fe - lip_w, lip_h]]);
        // Profil: durchgehende Rillen, dazu versetzte Halbrillen auf der Außenhälfte
        // (im Druck oben offen, daher kein Überhang)
        for (hf = [0, 1]) translate([0, 0, hf * B_w / 2 - 1])
            linear_extrude(B_w * (hf == 0 ? 1 : 0.5) + 2) rotate(hf * 180 / n_p)
            for (k = [0 : n_p - 1]) rotate(k * 360 / n_p) translate([R_w - g_d, -R_w * PI / n_p * 0.3]) square([g_d + 2, R_w * 2 * PI / n_p * 0.3]);
    }
    // Felge: von außen in den Reifen gedrückt, liegt auf dem Innenrand; am Fahrzeug hält
    // die Felge (auf dem Achszapfen) den Reifen gegen den Rahmen
    if (inc(fp, "B")) let(r_f = R_fe - einsatz_spiel) difference() {
        translate([0, 0, lip_h]) union() {
            cylinder(r = r_f, h = B_w - M(0.12) - lip_h, $fn = 96);
            difference() { cylinder(r = r_f, h = B_w - M(0.03) - lip_h, $fn = 96); translate([0, 0, -1]) cylinder(r = R_fe - max(M(0.06), 0.8), h = B_w + 2, $fn = 96); }
            cylinder(r = max(M(0.18), d_rz / 2 + 1.2), h = B_w - M(0.05) - lip_h, $fn = 48);
        }
        translate([0, 0, lip_h - 1]) cylinder(d = d_rz + spiel, h = h_hub - lip_h + 1, $fn = 32);
        for (k = [0 : 7]) rotate(k * 45 + 22.5) translate([M(0.3), 0, B_w - M(0.12) - max(M(0.03), 0.4)]) cylinder(r = max(M(0.04), 0.5), h = 2, $fn = 12);
    }
}
module rad_welt(sx, sy, fp) translate([sx * XL, sy * (y_a + s_r), z_ax]) rotate([sy > 0 ? -90 : 90, 0, 0]) rad(fp);

// =====================================================================
//  Kabine und Motor (Welt, außen am linken Längsträger) – gedruckt aufrecht
// =====================================================================
module kz_loecher(xs) for (x = xs) translate([x, y_k0 - 1, z_kz]) rotate([-90, 0, 0]) linear_extrude(l_kz + 1.3) rotate(-90) teardrop(d_kz / 2 + spiel);
z_fu = K_Z0 + 0.45 * (K_Z1 - K_Z0);       // Fensterunterkante
module kab_fenster() {
    zf0 = z_fu; zf1 = K_Z1 - M(0.15);
    for (x = [K_X1 - t_k - 1, K_X0 - 1]) translate([x, y_k0 + t_k + M(0.1), zf0]) cube([t_k + 2, K_T - 2 * t_k - M(0.2), zf1 - zf0]);
    translate([K_X0 + t_k + M(0.12), y_k0 + K_T - t_k - 1, zf0]) cube([K_X1 - K_X0 - 2 * t_k - M(0.24), t_k + 2, zf1 - zf0]);
}
module kabine_welt(fp) {
    // Gehäuse unten offen; Glaskern (B) wird von unten eingeschoben und von den
    // Kabinenzapfen des Fahrwerks gesichert (Löcher durch Wand und Kern)
    if (inc(fp, "A")) difference() {
        box([K_X0, y_k0, K_Z0], [K_X1, y_k0 + K_T, K_Z1]);
        box([K_X0 + t_k, y_k0 + t_k, K_Z0 - 1], [K_X1 - t_k, y_k0 + K_T - t_k, K_Z1 - t_k]);
        kab_fenster();
        kz_loecher(KZ_X);
        translate([K_X0 + M(0.25), y_k0 + K_T - dmr, K_Z0 + M(0.15)]) difference() { cube([M(0.8), dmr + 1, z_fu - K_Z0 - M(0.15)]); translate([0.5, -1, 0.5]) cube([M(0.8) - 1, dmr + 3, z_fu - K_Z0]); }
    }
    if (inc(fp, "B")) let(e = einsatz_spiel) difference() {
        box([K_X0 + t_k + e, y_k0 + t_k + e, K_Z0], [K_X1 - t_k - e, y_k0 + K_T - t_k - e, K_Z1 - t_k - e]);
        kz_loecher(KZ_X);
    }
}
xg0 = MO_X0 + M(0.2); xg1 = MO_X1 - M(0.2); zg0 = K_Z0 + M(0.3); zg1 = MO_Z1 - M(0.25);
t_gp = max(M(0.04), 0.8);                 // Rückplatte des Gitters (steckt in der Tasche)
y_go = y_k0 + K_T; y_gt = y_go - 2 * dmr - t_gp;   // Außenfläche / Taschenboden
module motor_welt(fp = "alle") {
    if (inc(fp, "A")) difference() {
        union() {
            box([MO_X0, y_k0, K_Z0], [MO_X1, y_k0 + K_T, MO_Z1]);
            box([MO_X1 - M(0.7), y_k0 + M(0.1), MO_Z1 - 0.01], [MO_X1 - M(0.1), y_k0 + K_T - M(0.1), MO_Z1 + M(0.25)]);
        }
        translate([xg0, y_gt, zg0]) cube([xg1 - xg0, y_go - y_gt + 1, zg1 - zg0]);   // Tasche für das Gitter
        kz_loecher(MZ_X);
    }
}
// Lüftergitter (eigenes Teil): senkrechte Stäbe auf einer Rückplatte, Klemmsitz in der Tasche
module motor_gitter_welt() let(e = einsatz_spiel, a0 = xg0 + e, a1 = xg1 - e, c0 = zg0 + e, c1 = zg1 - e,
        b_gs = max(M(0.05), 0.8), n_g = max(3, floor((xg1 - xg0) / max(M(0.14), 1.6)))) {
    translate([a0, y_gt, c0]) cube([a1 - a0, y_go - dmr - y_gt, c1 - c0]);
    for (z = [c0, c1 - b_gs]) translate([a0, y_gt, z]) cube([a1 - a0, y_go - y_gt, b_gs]);
    for (k = [0 : n_g]) translate([a0 + k * (a1 - a0 - b_gs) / n_g, y_gt, c0]) cube([b_gs, y_go - y_gt, c1 - c0]);
}
module kabine_druck(fp) translate([0, 0, -K_Z0]) kabine_welt(fp);
module motor_druck() translate([0, 0, -K_Z0]) motor_welt();
// Gitter flach: Rückseite auf dem Bett, Stäbe oben
module motor_gitter_druck() translate([0, 0, -y_gt]) rotate([90, 0, 0]) motor_gitter_welt();

// =====================================================================
//  Container (nur Vorschau)
// =====================================================================
// Container (lokal aus der Bibliothek) unter den Spreader setzen
module container_welt(Lc, ex = 0) translate([-Lc / 2, -W_ct / 2, Z_hub - H_ct]) ct_welt(Lc, ex);

// =====================================================================
//  Zusammenbau
// =====================================================================
module straddle_carrier(ex = 0) {
    for (sy = [-1, 1]) translate([0, sy * ex, 0]) {
        vorschau_farbe(farbe_gelb) fahrwerk_welt(sy);
        for (sx = [-1, 1]) translate([0, sy * 0.6 * ex, 0]) { vorschau_farbe(farbe_reifen) rad_welt(sx, sy, "A"); translate([0, sy * 0.5 * ex, 0]) vorschau_farbe(farbe_felge) rad_welt(sx, sy, "B"); }
        translate([0, 0, 0.7 * ex]) for (sx = [-1, 1]) { vorschau_farbe(farbe_innenbein) innenbein_welt(sx, sy, "A"); translate([0, 0, 0.3 * ex]) vorschau_farbe(farbe_stange) innenbein_welt(sx, sy, "B"); }
        translate([0, 0, 1.6 * ex]) vorschau_farbe(farbe_gelb) oberrahmen_welt(sy);
    }
    translate([0, 1.8 * ex, 0]) {
        vorschau_farbe(farbe_gelb) kabine_welt("A"); translate([0, 0, -0.8 * ex]) vorschau_farbe(farbe_glas) kabine_welt("B");
        vorschau_farbe(farbe_gelb) motor_welt(); translate([0, 0.5 * ex, 0]) vorschau_farbe(farbe_gitter) motor_gitter_welt();
    }
    translate([0, 0, 2.4 * ex]) {
        for (r = [0, 180]) rotate([0, 0, r]) translate([0.3 * ex, 0, 0]) { vorschau_farbe(farbe_gelb) quertraeger_welt("A"); translate([0.4 * ex, 0, 0]) vorschau_farbe(farbe_leuchte) quertraeger_welt("B"); }
        vorschau_farbe(farbe_gelb) mitteltraeger_welt();
    }
    translate([0, 0, 1.2 * ex]) {
        vorschau_farbe(farbe_spreader) spreader_rahmen_welt();
        for (r = [0, 180]) rotate([0, 0, r]) translate([spreader_auszug * E40 + 0.6 * ex, 0, -0.4 * ex]) {
            vorschau_farbe(farbe_spreader) spreader_arm_welt(); translate([0.3 * ex, 0, -0.3 * ex]) vorschau_farbe(farbe_kopf) kopftraeger_welt();
        }
        if (container_zeigen) translate([0, 0, -1.4 * ex]) container_welt(spreader_auszug > 0.5 ? L_c40 : L_c20, 0.4 * ex);
    }
}

// =====================================================================
//  Info und Ausgabe
// =====================================================================
function zm(v) = r2(v * den / 1000);       // mm -> Vorbild-Meter
F_X = 2 * XE; F_ZO = H - Z_ob0; F_ZU = Z_f1 - (z_ax - r_bs);
z_gq = H - HO - kq + (yq - W_kt / 2);
echo(str("Straddle Carrier 1:", den, " | ", r2(F_X), " x ", r2(2 * (y_a + s_r + B_w)), " x ", r2(H), " mm (", zm(H), " m) | Oberrahmen im Druck ", r2(F_X), " x ", r2(F_ZO),
         " mm, Fahrwerk ", r2(2 * XL + BU), " x ", r2(F_ZU), " mm, Dicke ", r2(t_f), " mm"));
echo(str("Lichte Weite ", zm(2 * y_i), " m (Container ", container_breite_m, " m) | Hubhöhe ", hubhoehe_m, " m, Container-Unterkante ", zm(Z_hub - H_ct),
         " m | Innenbein ", r2(L_ib), " mm, davon sichtbar ", r2(Z_ob0 - Z_f1), " mm (", zm(Z_ob0 - Z_f1), " m)"));
echo(str("Spreader-Rahmen ", r2(L_sr), " x ", r2(W_sr), " x ", r2(z_r1 - z_r0), " mm | Arm-Balken ", r2(L_ab), " mm | 20'/40': ", r2(2 * x_kt + eb_x), " / ", r2(2 * (x_kt + E40) + eb_x),
         " mm | Kopfträger ", r2(k_in + eb_x / 2), " x ", r2(W_kt), " x ", r2(h_kt), " mm"));
echo(str("Container-Halterung: ", magnete ? str(magnet_anzahl, " Magnet(e) je Kopfträger und Containerende, Tasche Ø ", r2(d_mt), " x ", r2(h_mt), " mm (Magnet ", magnet_d, " x ", magnet_h,
         "), im Containerdach von innen, ", r2(ct_mag_x), " mm ab Stirnseite, Dachhaut ", r2(magnet_haut), " mm") : "keine Magnete", koni ? str(" | Koni Ø ", r2(d_tw), " x ", r2(h_tw), " mm") : " | ohne Koni",
         " | Kopfträger ", r2(k_in + eb_x / 2), " mm breit"));
echo(str("Container 20'/40': ", r2(L_c20), " / ", r2(L_c40), " x ", r2(W_ct), " x ", r2(H_ct), " mm | 40' Boden/Dach ", n_pieces(info_boden(L_c40)), " Stück(e), Seitenwand ",
         n_pieces(info_seite(L_c40)), " Stück(e), ", CLIPS, " Clips", len(ct_xs(L_c40)) > 0 && zero_seams(info_boden(L_c40)) + zero_seams(info_dach(L_c40)) > 0 ? "  WARNUNG: Naht ohne Clip" : ""));
w_ob = (BO - W_ib) / 2 - spiel; w_bf = (BU - W_ib) / 2 - spiel;   // Wand neben dem Beinschacht
echo(str("Steckverbindungen: Schwalbenschwanz ", r2(n_d), " mm tief, Boden unter der Aufnahme ", r2(h_kt - b_ab - zapfen_spiel), " mm | Beinschacht ", r2(W_ib + 2 * spiel), " mm, Wand Oberbein/Beinfuß ",
         r2(w_ob), " / ", r2(w_bf), " mm | Felge auf Innenrand ", r2(lip_h), " x ", r2(lip_w), " mm | Leuchtenleiste ", r2(p_ll), " mm, Gitter ", r2(y_go - y_gt), " mm tief | Einsatz-Spiel ", einsatz_spiel, " mm"));
echo(str("Mindestmaße: Wand ", r2(t_s), " | Innenbein ", r2(b_ib), " x ", r2(t_ib), ", Stange ", r2(d_r), " | Feder ", r2(h_tg), " x ", r2(w_tg), " | Räder Ø ", r2(2 * R_w), " x ", r2(B_w), ", Zapfen Ø ", r2(d_rz), " mm"));
if (max(F_X, F_ZO, 2 * XL + BU) > usable) echo("WARNUNG: Rahmenteil größer als das Druckbett");
if (max(L_ib, 2 * x_kt + eb_x, L_ab + n_d) > usable) echo("WARNUNG: Innenbein oder Spreader-Teil größer als das Druckbett");
if (Z_ob0 - Z_f1 < M(0.2)) echo("WARNUNG: Innenbein kaum sichtbar – hubhoehe_m vergrößern oder oberbein_laenge_m verkleinern");
if (Z_ob0 < Z_f1 + 0.01) echo("WARNUNG: Oberbein reicht bis aufs Fahrwerk – oberbein_laenge_m verkleinern");
if (2 * y_i < W_ct + M(0.2)) echo("WARNUNG: Container passt nicht zwischen die Beine – breite_m vergrößern");
if (z_bt + M(0.03) > z_gq) echo("WARNUNG: Kopfträger stößt an die Eckbleche der Querträger");
if (Z_hub - H_ct < M(0.1)) echo("WARNUNG: Container schleift am Boden – hubhoehe_m vergrößern");
if (L_ab < E40 + M(0.5)) echo("WARNUNG: Teleskoparm bei 40 Fuß zu kurz im Kanal");
if (MO_X1 + M(0.1) > K_X0) echo("WARNUNG: Motor und Kabine berühren sich – Längen verkleinern");
if (magnete && h_mt + min_wand > h_kt) echo("WARNUNG: Magnettasche zu tief für den Kopfträger");
if (min(w_ob, w_bf) < min_wand) echo("WARNUNG: Wand neben dem Beinschacht zu dünn – oberbein_breite_m vergrößern");
if (n_d + zapfen_spiel + min_wand > k_in + eb_x / 2) echo("WARNUNG: Schwalbenschwanz zu tief für den Kopfträger");
if (magnete && koni && len([for (y = Y_MG, sy = [-1, 1]) if (norm([d_xm, sy * (W_ct / 2 - in_y) - y]) < d_mt / 2 + d_tw / 2 + 0.8) 1]) > 0) echo("WARNUNG: Magnettasche zu nah an den Koni");
if (magnete && magnet_anzahl == 2 && W_ct / 4 < d_mt / 2 + min_wand + cd + t_cw + spiel) echo("WARNUNG: Magnettaschen im Containerdach zu nah an den Seitenwänden");
if (magnete && magnet_haut < 0.4) echo("WARNUNG: Dachhaut über dem Container-Magnet unter 0,4 mm – reißt beim Druck");
mass_echo(F_X, 2 * (y_a + s_r + B_w), H);

druck("fahrwerk_links", 1, "alle", farbe_gelb, 1); druck("fahrwerk_rechts", 1, "alle", farbe_gelb, 1);
druck("oberrahmen", 1, "alle", farbe_gelb, 2);
druck("innenbein", 1, "A", farbe_innenbein, 4); druck("innenbein", 1, "B", farbe_stange, 4);
druck("quertraeger", 1, "A", farbe_gelb, 2); druck("quertraeger", 1, "B", farbe_leuchte, 2);
druck("mitteltraeger", 1, "alle", farbe_gelb, 1);
druck("spreader_rahmen", 1, "alle", farbe_spreader, 1);
druck("spreader_arm", 1, "alle", farbe_spreader, 2); druck("kopftraeger", 1, "alle", farbe_kopf, 2);
druck("rad", 1, "A", farbe_reifen, 4); druck("rad", 1, "B", farbe_felge, 4);
druck("kabine", 1, "A", farbe_gelb, 1); druck("kabine", 1, "B", farbe_glas, 1);
druck("motor", 1, "alle", farbe_gelb, 1); druck("motor_gitter", 1, "alle", farbe_gitter, 1);
for (c = [[20, L_c20], [40, L_c40]]) let(n = str("c", c[0], "_"), Lc = c[1]) {
    druck(str(n, "boden"), n_pieces(info_boden(Lc)), "alle", farbe_beschlag, 1);
    druck(str(n, "seite"), n_pieces(info_seite(Lc)), "alle", farbe_container, 2);
    if (ct_zweifarbig) {
        druck(str(n, "dach"), n_pieces(info_dach(Lc)), "A", farbe_container, 1); druck(str(n, "dach"), n_pieces(info_dach(Lc)), "B", farbe_beschlag, 1);
        druck(str(n, "stirn"), 1, "A", farbe_container, 1); druck(str(n, "stirn"), 1, "B", farbe_beschlag, 1);
        druck(str(n, "tuer"), 1, "A", farbe_container, 1); druck(str(n, "tuer"), 1, "B", farbe_beschlag, 1);
    } else {
        druck(str(n, "dach"), n_pieces(info_dach(Lc)), "alle", farbe_container, 1);
        druck(str(n, "stirn"), 1, "alle", farbe_container, 1); druck(str(n, "tuer"), 1, "alle", farbe_container, 1);
    }
}
if (CLIPS > 0) druck("verbinder", 1, "alle", farbe_clips, 1);
farben_echo();

if (teil == "aufbau") straddle_carrier();
else if (teil == "explosion") straddle_carrier(max(M(1.5), 14));
else if (teil == "fahrwerk_links") fahrwerk_druck(true);
else if (teil == "fahrwerk_rechts") fahrwerk_druck(false);
else if (teil == "oberrahmen") oberrahmen_druck();
else if (teil == "innenbein") innenbein_druck(farbteil);
else if (teil == "quertraeger") quertraeger_druck(farbteil);
else if (teil == "mitteltraeger") mitteltraeger_druck();
else if (teil == "spreader_rahmen") spreader_rahmen_druck();
else if (teil == "spreader_arm") spreader_arm_druck();
else if (teil == "kopftraeger") kopftraeger_druck();
else if (teil == "rad") rad(farbteil);
else if (teil == "kabine") kabine_druck(farbteil);
else if (teil == "motor") motor_druck();
else if (teil == "motor_gitter") motor_gitter_druck();
else if (starts(teil, "c20_")) ct_druck(L_c20, chr([for (i = [4 : len(teil) - 1]) ord(teil[i])]), farbteil, stueck);
else if (starts(teil, "c40_")) ct_druck(L_c40, chr([for (i = [4 : len(teil) - 1]) ord(teil[i])]), farbteil, stueck);
else if (teil == "verbinder") verbinder_platten(max(CLIPS, 4), stueck);
