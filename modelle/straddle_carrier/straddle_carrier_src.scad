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
//    innenbein         Innenbein (schwarz) mit Kolbenstange (silber)           4x
//    quertraeger       Querträger an den Enden mit Leuchtenleiste              2x
//    mitteltraeger     Mittelträger, trägt den Spreader am Drehzapfen          1x
//    spreader_rahmen   Spreader-Mittelteil mit zwei Kanälen und Drehzapfen     1x
//    spreader_arm      Teleskoparm mit Kopfträger, Magnettasche(n), Koni       2x
//    rad               Rad mit Profil und Felge                                4x
//    kabine            Fahrerkabine (Rahmen + Glas)                            1x
//    motor             Motormodul mit Lüftergitter                             1x
//
//  BEWEGLICH
//    * Räder drehen sich auf den Achszapfen.
//    * Beide Teleskoparme ziehen den Spreader von 20 Fuß auf 40 Fuß aus.
//    * Der Spreader steckt mit dem Drehzapfen stramm im Mittelträger (abnehmbar).
//    * Container-Halterung: Magnete in Taschen unter den Kopfträgern (Gegenstück:
//      Stahlscheibe oder Magnet auf dem Containerdach); Koni zentrieren in den
//      Eckbeschlägen (ISO-Lochabstand).
//  STARR
//    Die Hubhöhe (hubhoehe_m = Unterkante Spreader) legt die Länge der Innenbeine
//    fest.  Für eine andere Hubhöhe nur die vier Innenbeine neu drucken.
//  DRUCK
//    Alle Teile stützfrei: Fahrwerk und Oberrahmen auf der Innenseite liegend
//    (Beinschächte mit gefastem Dach, kurze Brücke), Quer- und Mittelträger auf der Rückseite,
//    Spreader-Rahmen aufrecht, Arme kopfüber, Innenbeine auf der Außenseite,
//    Räder auf der Innenseite, Kabine und Motor aufrecht.
//  MONTAGE (Kurzfassung)
//    1. Räder auf die Achszapfen, Kabine und Motor an das linke Fahrwerk stecken.
//    2. Innenbeine in die Beinfüße stecken (Stange zur Fahrzeugmitte).
//    3. Oberrahmen mit Quer- und Mittelträgern verbinden.
//    4. Magnete in die Kopfträger kleben, Arme in den Spreader schieben,
//       Spreader von unten in den Mittelträger stecken.
//    5. Oberteil auf die Innenbeine setzen.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, fahrwerk_links:Fahrwerk links, fahrwerk_rechts:Fahrwerk rechts, oberrahmen:Oberrahmen (2x), innenbein:Innenbein mit Stange (4x), quertraeger:Querträger (2x), mitteltraeger:Mittelträger, spreader_rahmen:Spreader-Rahmen, spreader_arm:Spreader-Teleskoparm (2x), rad:Rad (4x), kabine:Fahrerkabine, motor:Motormodul]
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
oberbein_breite_m = 0.75;
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
// Zentrierzapfen (Koni) unter den Kopfträgern
koni = true;

/* [Container (Vorbild in Metern)] */
container_20_m = 6.058;
container_40_m = 12.192;
container_breite_m = 2.438;
// 2.591 Standard, 2.896 High Cube
container_hoehe_m = 2.591;

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
farbe_container = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

/* [Druck & Passung] */
rennbahn_taschen = true;   // (keine Bodenplatte – bleibt für die Bibliothek stehen)
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;
// Luft je Seite in den Teleskopkanälen
tele_spiel = 0.2;
// Luft je Seite: Koni und Drehzapfen (klein = stramm)
zapfen_spiel = 0.05;

include <../../lib/deko_grundlagen.scad>

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
d_tw = max(M(0.12), 1.8);                 // Koni
h_tw = max(M(0.15), 2.0);
in_x = max(M((container_20_m - 5.853) / 2), d_tw / 2 + zapfen_spiel + 1.1);
in_y = max(M((container_breite_m - 2.259) / 2), d_tw / 2 + zapfen_spiel + 1.1);
L_c20 = M(container_20_m); L_c40 = M(container_40_m);
W_ct = M(container_breite_m); H_ct = M(container_hoehe_m);
d_mt = magnet_d + 2 * magnet_spiel;       // Magnettasche
h_mt = magnet_h + 0.1;
eb_x = max(M(0.35), magnete ? d_mt + 2 * min_wand : 0);   // Kopfträger-Breite (x)
h_kt = max(M(0.55), magnete ? h_mt + min_wand + 0.4 : 0);
x_kt = L_c20 / 2 - in_x;                  // Kopfträger-Mitte (20 Fuß)
E40  = (L_c40 - L_c20) / 2;
W_kt = W_ct;
Y_MG = magnet_anzahl == 2 ? [-W_kt / 4, W_kt / 4] : [0];
t_s  = max(M(0.07), min_wand);
w_ch = M(0.42); h_ch = M(0.42);           // Kanal je Arm
W_sr = 2 * w_ch + 3 * t_s;
g_sr = max(M(0.05), 0.6);
L_sr = 2 * (x_kt - eb_x / 2 - g_sr);
Z_hub = M(hubhoehe_m);
z_bt = Z_hub + h_kt;                      // Oberkante Arm-Balken = Kopfträger
z_r1 = z_bt + tele_spiel + t_s;           // Oberkante Spreader-Rahmen
z_r0 = z_r1 - h_ch - 2 * t_s;
y_ch = t_s / 2 + w_ch / 2;
L_ab = min(E40 + M(1.0), x_kt - eb_x / 2 + L_sr / 2 - M(0.15));
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

// Kabine und Motor (außen am linken Längsträger)
K_T  = M(kabine_tiefe_m);
y_k0 = y_a + spiel;
g_kr = max(M(0.15), 1.5);
K_X1 = XL - R_w - g_kr;
K_X0 = K_X1 - M(kabine_laenge_m);
K_Z0 = M(0.45);
K_Z1 = K_Z0 + M(kabine_hoehe_m);
t_k  = max(M(0.07), 1.0);
r_g  = max(M(0.03), 0.4);
MO_X0 = -K_X1;
MO_X1 = MO_X0 + M(motor_laenge_m);
MO_Z1 = K_Z0 + M(motor_hoehe_m);
d_kz = max(M(0.2), 2.5);
l_kz = max(M(0.15), 2.0);
z_kz = (ZS0 + ZS1) / 2;
KZ_X = [K_X0 + M(0.4), K_X1 - M(0.4)];
MZ_X = [MO_X0 + M(0.45), MO_X1 - M(0.45)];

include <../../lib/deko_hilfen.scad>

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
module bein_schacht(z, dir) for (sx = [-1, 1]) translate([sx * XL, y_ib - y_i, dir > 0 ? z - 1 : z - l_in - spiel])
    linear_extrude(l_in + spiel + 1) offset(delta = spiel) kant_prof(b_ib, t_ib, c_ib);
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
        linear_extrude(L_ib) kant_prof(b_ib, t_ib, c_ib);
        // Zierfugen (Abstreifer) an den Enden des sichtbaren Teils
        for (z = [l_in + M(0.06), L_ib - l_in - M(0.1)]) translate([0, 0, z]) linear_extrude(max(M(0.04), 0.4))
            difference() { offset(delta = 1) kant_prof(b_ib, t_ib, c_ib); offset(delta = -max(M(0.03), 0.3)) kant_prof(b_ib, t_ib, c_ib); }
    }
    if (inc(fp, "B")) translate([-b_ib / 2 - d_r / 2, t_ib - d_r, l_in + 0.1]) linear_extrude(L_ib - 2 * l_in - 0.2) kant_prof(d_r, d_r, 0.3 * d_r);
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
module quertraeger_welt(fp) {
    xa = x_q - b_q / 2;
    if (inc(fp, "A")) {
        difference() { qt_x(xa, x_q + b_q / 2) qt_2d(kq); qt_x(x_q + b_q / 2 - dmr, x_q + b_q / 2 + 1) offset(delta = -w_rd) qt_2d(kq); }
        federn(xa);
    }
    if (inc(fp, "B")) let(x0 = x_q + b_q / 2 - dmr, yl = yq - max(kq, w_rd) - M(0.1), zl = H - w_rd - h_ll) {
        translate([x0, -yl, zl]) cube([dmr + t_ll, 2 * yl, h_ll]);
        for (sy = [-1, 1]) translate([x0, sy * (yl - h_ll), zl + h_ll / 2]) rotate([0, 90, 0]) cylinder(d = 1.6 * h_ll, h = dmr + 1.6 * t_ll, $fn = 24);
    }
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
// Arm vorne (+x, Kanal +y) bei 20 Fuß; Arm hinten = 180° gedreht
module spreader_arm_welt(fp) {
    xk = x_kt - eb_x / 2;
    if (inc(fp, "B")) box([xk - L_ab, y_ch - w_ch / 2 + tele_spiel, z_r0 + t_s + tele_spiel], [xk, y_ch + w_ch / 2 - tele_spiel, z_bt]);
    if (inc(fp, "A")) {
        difference() {
            box([xk, -W_kt / 2, Z_hub], [x_kt + eb_x / 2, W_kt / 2, z_bt]);
            // Magnettaschen (von unten; im Druck oben offen)
            if (magnete) for (y = Y_MG) translate([x_kt, y, Z_hub - 1]) cylinder(d = d_mt, h = h_mt + 1, $fn = 48);
        }
        if (koni) for (sy = [-1, 1]) translate([x_kt, sy * (W_ct / 2 - in_y), Z_hub + 0.01]) mirror([0, 0, 1]) zapfen_rund(d_tw, h_tw + 0.01, c_rz);
    }
}
module spreader_rahmen_druck() translate([0, 0, -z_r0]) spreader_rahmen_welt();
module spreader_arm_druck(fp) translate([0, 0, z_bt]) rotate([180, 0, 0]) spreader_arm_welt(fp);

// =====================================================================
//  Rad (lokal: Achse z, Innenseite z = 0 auf dem Bett, Außenseite oben)
// =====================================================================
R_fe = M(0.48);
module rad(fp) {
    c_t = max(M(0.08), 0.6); n_p = 24; g_d = max(M(0.05), 0.6);
    if (inc(fp, "A")) difference() {
        rotate_extrude($fn = 96) polygon([[R_fe, 0], [R_w - c_t, 0], [R_w, c_t], [R_w, B_w - c_t], [R_w - c_t, B_w], [R_fe, B_w]]);
        translate([0, 0, -1]) cylinder(r = R_fe, h = B_w + 2, $fn = 96);
        // Profil: durchgehende Rillen, dazu versetzte Halbrillen auf der Außenhälfte
        // (im Druck oben offen, daher kein Überhang)
        for (hf = [0, 1]) translate([0, 0, hf * B_w / 2 - 1])
            linear_extrude(B_w * (hf == 0 ? 1 : 0.5) + 2) rotate(hf * 180 / n_p)
            for (k = [0 : n_p - 1]) rotate(k * 360 / n_p) translate([R_w - g_d, -R_w * PI / n_p * 0.3]) square([g_d + 2, R_w * 2 * PI / n_p * 0.3]);
    }
    if (inc(fp, "B")) difference() {
        union() {
            cylinder(r = R_fe, h = B_w - M(0.12), $fn = 96);
            difference() { cylinder(r = R_fe, h = B_w - M(0.03), $fn = 96); translate([0, 0, -1]) cylinder(r = R_fe - max(M(0.06), 0.8), h = B_w + 2, $fn = 96); }
            cylinder(r = max(M(0.18), d_rz / 2 + 1.2), h = B_w - M(0.05), $fn = 48);
        }
        translate([0, 0, -1]) cylinder(d = d_rz + spiel, h = h_hub + 1, $fn = 32);
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
    if (inc(fp, "A")) difference() {
        box([K_X0, y_k0, K_Z0], [K_X1, y_k0 + K_T, K_Z1]);
        box([K_X0 + t_k, y_k0 + t_k, K_Z0 + t_k], [K_X1 - t_k, y_k0 + K_T - t_k, K_Z1 - t_k]);
        kab_fenster();
        kz_loecher(KZ_X);
        translate([K_X0 + M(0.25), y_k0 + K_T - dmr, K_Z0 + M(0.15)]) difference() { cube([M(0.8), dmr + 1, z_fu - K_Z0 - M(0.15)]); translate([0.5, -1, 0.5]) cube([M(0.8) - 1, dmr + 3, z_fu - K_Z0]); }
    }
    if (inc(fp, "B")) difference() {
        union() {
            box([K_X0 + t_k, y_k0 + t_k, K_Z0 + t_k], [K_X1 - t_k, y_k0 + K_T - t_k, K_Z1 - t_k]);
            intersection() { kab_fenster(); box([K_X0 + r_g, y_k0 + r_g, K_Z0], [K_X1 - r_g, y_k0 + K_T - r_g, K_Z1]); }
        }
        kz_loecher(KZ_X);
    }
}
module motor_welt(fp) {
    xg0 = MO_X0 + M(0.2); xg1 = MO_X1 - M(0.2); zg0 = K_Z0 + M(0.3); zg1 = MO_Z1 - M(0.25);
    b_gs = max(M(0.05), 0.8); n_g = max(3, floor((xg1 - xg0) / max(M(0.14), 1.6)));
    if (inc(fp, "A")) difference() {
        union() {
            box([MO_X0, y_k0, K_Z0], [MO_X1, y_k0 + K_T, MO_Z1]);
            box([MO_X1 - M(0.7), y_k0 + M(0.1), MO_Z1 - 0.01], [MO_X1 - M(0.1), y_k0 + K_T - M(0.1), MO_Z1 + M(0.25)]);
        }
        translate([xg0, y_k0 + K_T - 2 * dmr, zg0]) cube([xg1 - xg0, 2 * dmr + 1, zg1 - zg0]);
        kz_loecher(MZ_X);
    }
    // Lüftergitter: senkrechte Stäbe auf einer Rückplatte (ein Körper)
    if (inc(fp, "B")) translate([0, y_k0 + K_T - 2 * dmr, 0]) {
        translate([xg0, 0, zg0]) cube([xg1 - xg0, dmr, zg1 - zg0]);
        for (z = [zg0, zg1 - b_gs]) translate([xg0, 0, z]) cube([xg1 - xg0, 2 * dmr, b_gs]);
        for (k = [0 : n_g]) translate([xg0 + k * (xg1 - xg0 - b_gs) / n_g, 0, zg0]) cube([b_gs, 2 * dmr, zg1 - zg0]);
    }
}
module kabine_druck(fp) translate([0, 0, -K_Z0]) kabine_welt(fp);
module motor_druck(fp) translate([0, 0, -K_Z0]) motor_welt(fp);

// =====================================================================
//  Container (nur Vorschau)
// =====================================================================
module container_vorschau(Lc) translate([0, 0, Z_hub - H_ct]) {
    vorschau_farbe(farbe_container) difference() {
        translate([-Lc / 2, -W_ct / 2, 0]) cube([Lc, W_ct, H_ct]);
        for (k = [1 : floor(Lc / M(0.3)) - 1], sy = [-1, 1]) translate([-Lc / 2 + k * M(0.3) - M(0.06), sy * W_ct / 2 - M(0.03), M(0.2)]) cube([M(0.12), M(0.06), H_ct - M(0.4)]);
    }
    vorschau_farbe("anthrazit") for (sx = [-1, 1], sy = [-1, 1], z = [0, H_ct - M(0.12)]) translate([sx * Lc / 2 - (sx > 0 ? M(0.18) : 0), sy * W_ct / 2 - (sy > 0 ? M(0.16) : 0), z]) cube([M(0.18), M(0.16), M(0.12)]);
}

// =====================================================================
//  Zusammenbau
// =====================================================================
module straddle_carrier(ex = 0) {
    for (sy = [-1, 1]) translate([0, sy * ex, 0]) {
        vorschau_farbe(farbe_gelb) fahrwerk_welt(sy);
        for (sx = [-1, 1]) translate([0, sy * 0.6 * ex, 0]) { vorschau_farbe(farbe_reifen) rad_welt(sx, sy, "A"); vorschau_farbe(farbe_felge) rad_welt(sx, sy, "B"); }
        translate([0, 0, 0.7 * ex]) for (sx = [-1, 1]) { vorschau_farbe(farbe_innenbein) innenbein_welt(sx, sy, "A"); vorschau_farbe(farbe_stange) innenbein_welt(sx, sy, "B"); }
        translate([0, 0, 1.6 * ex]) vorschau_farbe(farbe_gelb) oberrahmen_welt(sy);
    }
    translate([0, 1.8 * ex, 0]) {
        vorschau_farbe(farbe_gelb) kabine_welt("A"); vorschau_farbe(farbe_glas) kabine_welt("B");
        vorschau_farbe(farbe_gelb) motor_welt("A"); vorschau_farbe(farbe_gitter) motor_welt("B");
    }
    translate([0, 0, 2.4 * ex]) {
        for (r = [0, 180]) rotate([0, 0, r]) translate([0.3 * ex, 0, 0]) { vorschau_farbe(farbe_gelb) quertraeger_welt("A"); vorschau_farbe(farbe_leuchte) quertraeger_welt("B"); }
        vorschau_farbe(farbe_gelb) mitteltraeger_welt();
    }
    translate([0, 0, 1.2 * ex]) {
        vorschau_farbe(farbe_spreader) spreader_rahmen_welt();
        for (r = [0, 180]) rotate([0, 0, r]) translate([spreader_auszug * E40 + 0.6 * ex, 0, -0.4 * ex]) { vorschau_farbe(farbe_kopf) spreader_arm_welt("A"); vorschau_farbe(farbe_spreader) spreader_arm_welt("B"); }
        if (container_zeigen) translate([0, 0, -1.4 * ex]) container_vorschau(spreader_auszug > 0.5 ? L_c40 : L_c20);
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
         " mm | Kopfträger ", r2(eb_x), " x ", r2(W_kt), " x ", r2(h_kt), " mm"));
echo(str("Container-Halterung: ", magnete ? str(magnet_anzahl, " Magnet(e) je Kopfträger, Tasche Ø ", r2(d_mt), " x ", r2(h_mt), " mm (Magnet ", magnet_d, " x ", magnet_h,
         "), Abstand zur Mitte ", r2(x_kt), " mm 20' / ", r2(x_kt + E40), " mm 40'") : "keine Magnete", koni ? str(" | Koni Ø ", r2(d_tw), " x ", r2(h_tw), " mm") : " | ohne Koni"));
echo(str("Mindestmaße: Wand ", r2(t_s), " | Innenbein ", r2(b_ib), " x ", r2(t_ib), ", Stange ", r2(d_r), " | Feder ", r2(h_tg), " x ", r2(w_tg), " | Räder Ø ", r2(2 * R_w), " x ", r2(B_w), ", Zapfen Ø ", r2(d_rz), " mm"));
if (max(F_X, F_ZO, 2 * XL + BU) > usable) echo("WARNUNG: Rahmenteil größer als das Druckbett");
if (max(L_ib, 2 * x_kt + eb_x, L_ab + eb_x) > usable) echo("WARNUNG: Innenbein oder Spreader-Teil größer als das Druckbett");
if (Z_ob0 - Z_f1 < M(0.2)) echo("WARNUNG: Innenbein kaum sichtbar – hubhoehe_m vergrößern oder oberbein_laenge_m verkleinern");
if (Z_ob0 < Z_f1 + 0.01) echo("WARNUNG: Oberbein reicht bis aufs Fahrwerk – oberbein_laenge_m verkleinern");
if (2 * y_i < W_ct + M(0.2)) echo("WARNUNG: Container passt nicht zwischen die Beine – breite_m vergrößern");
if (z_bt + M(0.03) > z_gq) echo("WARNUNG: Kopfträger stößt an die Eckbleche der Querträger");
if (Z_hub - H_ct < M(0.1)) echo("WARNUNG: Container schleift am Boden – hubhoehe_m vergrößern");
if (L_ab < E40 + M(0.5)) echo("WARNUNG: Teleskoparm bei 40 Fuß zu kurz im Kanal");
if (MO_X1 + M(0.1) > K_X0) echo("WARNUNG: Motor und Kabine berühren sich – Längen verkleinern");
if (magnete && h_mt + min_wand > h_kt) echo("WARNUNG: Magnettasche zu tief für den Kopfträger");
if (magnete && magnet_anzahl == 2 && W_kt / 4 < d_mt / 2 + d_tw / 2 + 1) echo("WARNUNG: Magnettaschen zu nah an den Koni");
if (magnete && magnet_anzahl == 1 && koni && W_ct / 2 - in_y - d_tw / 2 < d_mt / 2 + 0.8) echo("WARNUNG: Magnettasche zu nah an den Koni");
mass_echo(F_X, 2 * (y_a + s_r + B_w), H);

druck("fahrwerk_links", 1, "alle", farbe_gelb, 1); druck("fahrwerk_rechts", 1, "alle", farbe_gelb, 1);
druck("oberrahmen", 1, "alle", farbe_gelb, 2);
druck("innenbein", 1, "A", farbe_innenbein, 4); druck("innenbein", 1, "B", farbe_stange, 4);
druck("quertraeger", 1, "A", farbe_gelb, 2); druck("quertraeger", 1, "B", farbe_leuchte, 2);
druck("mitteltraeger", 1, "alle", farbe_gelb, 1);
druck("spreader_rahmen", 1, "alle", farbe_spreader, 1);
druck("spreader_arm", 1, "A", farbe_kopf, 2); druck("spreader_arm", 1, "B", farbe_spreader, 2);
druck("rad", 1, "A", farbe_reifen, 4); druck("rad", 1, "B", farbe_felge, 4);
druck("kabine", 1, "A", farbe_gelb, 1); druck("kabine", 1, "B", farbe_glas, 1);
druck("motor", 1, "A", farbe_gelb, 1); druck("motor", 1, "B", farbe_gitter, 1);
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
else if (teil == "spreader_arm") spreader_arm_druck(farbteil);
else if (teil == "rad") rad(farbteil);
else if (teil == "kabine") kabine_druck(farbteil);
else if (teil == "motor") motor_druck(farbteil);
