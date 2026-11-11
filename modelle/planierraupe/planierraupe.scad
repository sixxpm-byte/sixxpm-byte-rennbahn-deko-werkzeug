// =====================================================================
//  PLANIERRAUPE  –  Kettendozer der 18-t-Klasse mit 6-Wege-Schild und Heckaufreißer
//  Vorbild: Cat D6N (Laufwerk 3,5 m, Spur 1,89 m, Schild 3,27 m breit, 3,1 m hoch)
//  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei), Farben je Bauteil,
//  Maßstab 1:43 / 1:87.  Schild hebt und senkt sich am C-Rahmen (zwei Hubzylinder),
//  der Aufreißer schwenkt am Heck (ein Zylinder); die Kolbenstangen gleiten in den
//  Rohren und halten die Stellung durch Reibung.
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    unterwagen      Rahmen zwischen den Ketten: Steckzungen, Zapfen zum Aufbau,
//                    Taschen der Kotflügel, Lagerbock des Aufreißers                 1x
//    kette           Raupenlaufwerk mit Bodenplatten, Turas, Leitrad und Rollen,
//                    Loch für den Schwenkzapfen des Schildrahmens                     2x
//    rahmen          Aufbau: Motorhaube mit Kühlergrill, Auspuff und Vorfilter,
//                    Kabinenboden, Tank, Lagerböcke der Hubzylinder, Ripper-Hubbock   1x
//    kabine          Fahrerkabine (unten offen, A) + Glaskern von unten (B)           1x
//    kotfluegel      Kotflügel über den Ketten (flach, Rauten-Zapfen in den Unterwagen) 2x
//    schild          Planierschild (Rückseite auf dem Bett, Taschen für den Rahmen)   1x
//    schildrahmen    C-Rahmen (flach): Schwenkzapfen in die Ketten, Zapfen ins Schild,
//                    Gabeln für die Hubzylinder                                       1x
//    zylinder_hub    Hubzylinder: Rohr (A) + Kolbenstange (B)                         2x
//    ripper          Heckaufreißer: Balken, Schwenkarme, drei Zinken, Lasche          1x
//    zylinder_ripper Ripperzylinder: Rohr (A) + Kolbenstange (B)                      1x
//
//  BOLZEN
//    6 Filament-Stücke Ø stift_d (Längen siehe Echo): Hubzylinder oben (2) und unten (2),
//    Ripper-Schwenkachse (1), Ripperzylinder oben (1) und unten (1).
//  BEWEGLICH
//    * Schild mit C-Rahmen schwenkt um die Zapfen in den Ketten (0–10°), die
//      Hubzylinder fahren mit und halten die Stellung (1:43 sicher, 1:87 bedingt).
//    * Aufreißer schwenkt um den Bolzen im Unterwagen (0–15°), Zylinder fährt mit.
//  DRUCK
//    Alle Teile stützfrei: Unterwagen und Rahmen aufrecht, Ketten auf der Innenseite
//    liegend, Kabine kopfüber, Kotflügel und Schildrahmen flach, Schild mit der
//    Rückseite nach unten, Aufreißer mit der Rückseite nach unten, Zylinder liegend.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, unterwagen:Unterwagen, kette:Raupenlaufwerk (2x), rahmen:Aufbau mit Motorhaube, kabine:Kabine mit Glaskern, kotfluegel:Kotflügel (2x), schild:Planierschild, schildrahmen:Schildrahmen (C-Rahmen), zylinder_hub:Hubzylinder (2x), ripper:Heckaufreißer, zylinder_ripper:Ripperzylinder]
stueck = 0;
farbteil = "alle"; // [alle, A, B]

/* [Vorschau] */
// Schild: 0 = Schneide am Boden, 10 = angehoben
schild_winkel = 0; // [0:1:10]
// Aufreißer: 0 = abgesenkt, 15 = angehoben
ripper_winkel = 10; // [0:1:15]

/* [Planierraupe (Vorbild in Metern)] */
laufwerk_laenge_m = 3.5;
spur_m = 1.89;
kette_breite_m = 0.6;
schild_breite_m = 3.27;
schild_hoehe_m = 1.13;
kabine_hoehe_m = 3.1;

/* [Farben] */
farbe_gelb       = "catgelb";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_unterwagen = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_kette      = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_kabine     = "catgelb";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_glas       = "puderblau"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_zylinder   = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_stange     = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]

/* [Druck & Passung] */
rennbahn_taschen = true;   // (keine Bodenplatte – bleibt für die Bibliothek stehen)
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;
stift_d = 1.75;
// Luft je Seite zwischen Kolbenstange und Rohr (klein = Stellung hält besser)
zylinder_spiel = 0.1;
// Luft je Seite für eingepresste Teile (Zungen, Zapfen, Glaskern; 0 = sehr stramm)
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
          ["hellblau", "#5aa2dc"], ["dunkelgruen", "#1f6b3a"], ["puderblau", "#8cc8ea"], ["catgelb", "#eeb111"], ["olivgrau", "#5f6b55"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

// =====================================================================
//  Maße (Welt: x = 0 Laufwerksmitte, +x nach vorne (Schild), +y links, z = 0 Boden; mm)
// =====================================================================
function K(m) = m * 1000 / den;
function KP(p) = [K(p[0]), K(p[1])];
function rot2(p, a) = [p[0] * cos(a) - p[1] * sin(a), p[0] * sin(a) + p[1] * cos(a)];
es    = einsatz_spiel;
zyl_r_s_min  = max(1.0, 0);                 // schlankere Zylinder als Standard (kurze Hübe)
zyl_wand_min = max(0.9, 0);
// =====================================================================
//  deko_hydraulik.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Teleskopische Hydraulikzylinder (Rohr + Kolbenstange), liegend stützfrei gedruckt,
//  und Bolzen-Maße.  Erwartet im Modell: stift_d, zylinder_spiel, einsatz_spiel und
//  (nach deko_grundlagen) M().  Optional vorab: zyl_r_s_m, zyl_r_o_m (Vorbild-Radien in m),
//  zyl_r_s_min (kleinster Stangenradius, mm) und zyl_wand_min (kleinste Rohrwand, mm).
//  Ein Zylinder wird durch Z = [L_min, L_max] (Augenabstand eingefahren/ausgefahren)
//  beschrieben; ov(Z) ist die Überdeckung der Stange im Rohr bei L_max (>= ov_min halten).
// =====================================================================
r_h   = (stift_d + 0.25) / 2;               // Bolzenloch lose
r_pr  = stift_d / 2 + einsatz_spiel;        // Bolzenloch stramm
r_e   = max(M(0.17), r_h + 1.0);            // Augenradius
r_s   = max(M(is_undef(zyl_r_s_m) ? 0.065 : zyl_r_s_m), is_undef(zyl_r_s_min) ? 1.2 : zyl_r_s_min);   // Kolbenstange
hs    = 0.62 * r_s;                         // Stange: oben und unten abgeflacht
r_b   = r_s + zylinder_spiel;
r_o   = max(M(is_undef(zyl_r_o_m) ? 0.14 : zyl_r_o_m), r_b + (is_undef(zyl_wand_min) ? 1.0 : zyl_wand_min));   // Rohr
hz    = 0.9 * r_o;                          // Rohrachse über dem Bett
x_b0  = r_e + max(M(0.05), 0.8);            // Boden der Bohrung
g_tz  = max(M(0.06), 0.8);
ov_min = max(5 * r_s, M(0.3));
function ov(Z) = (Z[0] - r_e - g_tz) - (x_b0 + Z[1] - Z[0]);
module rohr_2d() intersection() { hull() { translate([0, hz]) circle(r = r_o, $fn = 40); translate([-0.56 * r_o, 0]) square([1.12 * r_o, 0.01]); } translate([-r_o - 1, 0]) square([2 * r_o + 2, 2 * r_o + 2]); }
module stange_2d(o) intersection() { translate([0, hs]) circle(r = r_s + o, $fn = 32); translate([-r_s - o - 1, -o]) square([2 * (r_s + o) + 2, 2 * hs + 2 * o]); }
// lokal = Druck: Achse x ab dem Rohr-Auge, Augen flach auf dem Bett (Auge des Rohrs 2*hz dick, der Stange 2*hs)
module zyl_rohr(Z, press) let(L_tb = Z[0] - r_e - g_tz) difference() {
    union() {
        cylinder(r = r_e, h = 2 * hz, $fn = 32);
        translate([r_e - 0.4, 0, 0]) rotate([90, 0, 90]) linear_extrude(L_tb - r_e + 0.4) rohr_2d();
    }
    translate([0, 0, -1]) cylinder(r = press ? r_pr : r_h, h = 2 * hz + 2, $fn = 24);
    // Bohrung: Stangenprofil mit Luft, Decke als 45°-Giebel (stützfrei)
    translate([x_b0, 0, hz - hs]) rotate([90, 0, 90]) linear_extrude(L_tb) let(o = zylinder_spiel, wt = sqrt(pow(r_s + o, 2) - pow(hs + o, 2)))
        hull() { stange_2d(o); translate([-0.01, 2 * hs + o + wt * 1.1]) square(0.02); }
}
module zyl_stange(Z, L, press) difference() {
    union() {
        translate([L, 0, 0]) cylinder(r = r_e, h = 2 * hs, $fn = 32);
        translate([x_b0 + L - Z[0], 0, 0]) rotate([90, 0, 90]) linear_extrude(Z[0] - x_b0 - r_e + 0.4) stange_2d(0);
    }
    translate([L, 0, -1]) cylinder(r = press ? r_pr : r_h, h = 2 * hs + 2, $fn = 24);
}
module zylinder_druck(fp, Z, pa, pb) {
    if (inc(fp, "A")) zyl_rohr(Z, pa);
    if (inc(fp, "B")) translate([0, 2 * r_e + 3, 0]) zyl_stange(Z, Z[0], pb);
}
// zwischen zwei Punkten einer x-z-Schwenkebene (P = Rohr-Auge, Q = Stangen-Auge), Mitte bei y = yc
module zyl_zw(P, Q, yc, fp, Z, pa, pb) let(L = norm(Q - P), d = (Q - P) / L) {
    if (inc(fp, "A")) multmatrix([[d[0], d[1], 0, P[0]], [0, 0, 1, yc - hz], [d[1], -d[0], 0, P[1]], [0, 0, 0, 1]]) zyl_rohr(Z, pa);
    if (inc(fp, "B")) multmatrix([[d[0], d[1], 0, P[0]], [0, 0, 1, yc - hs], [d[1], -d[0], 0, P[1]], [0, 0, 0, 1]]) zyl_stange(Z, L, pb);
}
d_p   = max(M(0.16), 2.0);                  // Steckzapfen (Raute) Unterwagen/Kabine

// Laufwerk (Bibliothek deko_laufwerk)
r_k   = K(0.45);
c_k   = K(laufwerk_laenge_m / 2) - r_k;
B_k   = K(kette_breite_m);
Y_k0  = K(spur_m / 2) - B_k / 2;            // Innenseite der Kette
h_gr  = max(M(0.04), 0.5);
t_sh  = max(M(0.1), 1.2);
d_rf  = max(M(0.08), 0.8);
lw_zaehne = true;
// =====================================================================
//  deko_laufwerk.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Raupenlaufwerk: Kettenband mit Stollen, Laufwerksrahmen, Leit-/Turasrad,
//  Lauf- und Stützrollen als Relief auf der Außenseite.  Das Teil wird liegend auf
//  der Innenseite gedruckt (Innenseite = Druckbett, Relief oben) – stützfrei.
//  Erwartet im Modell (nach deko_grundlagen):
//    c_k   halber Abstand der Umlenkachsen (mm)      r_k   Umlenkradius (mm)
//    B_k   Kettenbreite (mm)                          Y_k0  Innenseite der linken Kette (mm)
//    h_gr  Stollenhöhe, t_sh Bodenplatten-Band, d_rf Relieftiefe (mm)
//  Optional vorab: lw_rollen (Laufrollen, Standard 6), lw_stuetz (Stützrollen, 2),
//    lw_zaehne (Turas hinten mit Zähnen, Standard false).
//  lw_h_nabe: Überstand der Radnaben außen (Freiraum für Anbauteile einplanen).
//  lw_koerper() liefert die LINKE Kette in Welt-Koordinaten (x = Fahrtrichtung,
//  y = Y_k0 .. Y_k0 + B_k, z = 0 Boden); die rechte Kette ist das gleiche Teil, um 180°
//  um z gedreht (Taschen des Modells also symmetrisch in x anlegen).
// =====================================================================
lw_n_r = is_undef(lw_rollen) ? 6 : lw_rollen;
lw_n_s = is_undef(lw_stuetz) ? 2 : lw_stuetz;
lw_zh  = is_undef(lw_zaehne) ? false : lw_zaehne;
lw_h_nabe = max(M(0.04), 0.5);              // Radnaben stehen so weit über die Außenseite
module lw_xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 8) children();
module lw_ci(p, r) translate(p) circle(r = r, $fn = 40);
module lw_umriss_2d() hull() { lw_ci([-c_k, r_k], r_k); lw_ci([c_k, r_k], r_k); }
// Band mit Stollen (Bodenplatten) rundum
module lw_band_2d() {
    lw_umriss_2d();
    n = max(8, round(2 * c_k / max(M(0.22), 1.6))); p = 2 * c_k / n; w = p * 0.45;
    for (i = [0 : n]) for (z = [0, 2 * r_k]) translate([-c_k + i * p, z]) square([w, 2 * h_gr], center = true);
    m = max(4, round(PI * r_k / p));
    for (s = [-1, 1], i = [1 : m - 1]) translate([s * c_k, r_k]) rotate(s * (i * 180 / m) - 90) translate([r_k, 0]) square([2 * h_gr, w], center = true);
}
// Laufwerksrahmen, Räder und Rollen (innerhalb des Bandes)
module lw_relief_2d() {
    r_w = r_k - t_sh - max(M(0.03), 0.4);
    hull() { lw_ci([-c_k * 0.8, r_k], r_k * 0.42); lw_ci([c_k * 0.8, r_k], r_k * 0.42); }
    lw_ci([c_k, r_k], r_w);                                     // Leitrad vorne
    if (lw_zh) {                                                // Turas hinten mit Zähnen
        nz = max(8, round(2 * PI * r_w / max(M(0.2), 1.2)));
        lw_ci([-c_k, r_k], r_w - max(M(0.05), 0.5));
        for (i = [0 : nz - 1]) translate([-c_k, r_k]) rotate(i * 360 / nz) translate([r_w - max(M(0.05), 0.5), 0]) square([2 * max(M(0.05), 0.5), max(M(0.06), 0.6)], center = true);
    } else lw_ci([-c_k, r_k], r_w);
    r_r = max(M(0.13), 1.0);
    for (i = [0 : lw_n_r]) lw_ci([-c_k * 0.78 + i * c_k * 1.56 / lw_n_r, t_sh + r_r + max(M(0.01), 0.1)], r_r);
    for (i = [0 : lw_n_s - 1]) lw_ci([-c_k * 0.35 + i * c_k * 0.7 / max(1, lw_n_s - 1), 2 * r_k - t_sh - r_r * 0.8 - max(M(0.01), 0.1)], r_r * 0.8);
}
// Körper der linken Kette (Welt)
module lw_koerper() union() {
    lw_xz(Y_k0, Y_k0 + B_k - d_rf) lw_band_2d();
    lw_xz(Y_k0 + B_k - d_rf - 0.01, Y_k0 + B_k) { difference() { lw_band_2d(); offset(delta = -t_sh) lw_umriss_2d(); } lw_relief_2d(); }
    for (s = [-1, 1]) translate([s * c_k, Y_k0 + B_k - 0.01, r_k]) rotate([-90, 0, 0]) cylinder(r1 = r_k * 0.3, r2 = r_k * 0.22, h = lw_h_nabe, $fn = 24);
}
P_c   = [0, K(0.55)];                       // Schwenkachse des Schildrahmens (in beiden Ketten)
d_pz  = max(M(0.12), 2.0);                  // Schwenkzapfen (Raute, liegend)
r_pz  = d_pz / 2 + spiel;
l_pz  = max(M(0.12), 2.5);                  // Zapfentiefe in der Kette

// Unterwagen
Z_u0  = K(0.5);  Z_u1 = K(1.2);
X_u   = [K(-2.35), K(1.6)];
Y_u   = Y_k0 - max(M(0.025), 0.3);
TG_X  = [K(-0.9), K(0.9)];  w_tg = K(0.6);  h_tg = max(M(0.3), 2.4);  l_tg = max(M(0.3), 3);
UP    = [for (x = [K(-1.9), K(1.2)], y = [-K(0.35), K(0.35)]) [x, y]];   // Zapfen zum Rahmen
h_up  = max(M(0.25), 2.5);

// Kotflügel (flach, Rauten-Zapfen in den Unterwagen; rechts = links um x gedreht)
X_f   = [K(-1.9), K(-0.5)];
Y_f   = [Y_k0 + max(M(0.02), 0.3), K(1.3)];
t_f   = max(M(0.14), 2.0);  d_f = t_f;
z_f0  = 2 * r_k + h_gr + 0.25;  zc_f = z_f0 + t_f / 2;   // knapp über den Stollen
FX    = [K(-1.6), K(-0.8)];  l_f = max(M(0.2), 2.5);

// Rahmen (Aufbau)
Z_b0  = Z_u1;  Z_b1 = K(1.45);  Y_b = K(0.8);
X_h   = [K(-0.45), K(1.55)];  Z_hr = K(2.08);  Z_hf = K(1.9);   // Haube hinten / vorne
X_t   = [K(-2.1), K(-1.75)];  Z_t = K(1.9);                      // Tank hinter der Kabine
X_rb  = [K(-2.35), K(-2.1)];  Y_rb = K(0.6);                     // Ripper-Lagerbock
t_pl  = max(M(0.15), 1.6);                                       // Gabelwangen
t_lg  = max(M(0.2), 2.5);                                        // Lagerbock der Hubzylinder an der Haubenseite
g_fk  = r_o + spiel;                                             // halbe Gabelweite (Rohr ist dicker als das Auge)
z_nt  = K(1.6);                                                  // Ausschnitt im Hubbock zwischen den Wangen
RZ_p  = [K(-2.27), K(2.45)];  Z_fk = K(2.7);  X_fk = [K(-2.35), K(-2.15)];   // Ripperzylinder oben
HZ_p  = [K(0.68), K(2.1)];                                       // Hubzylinder oben: Auge des Rohrs am Lagerbock
X_hb  = [K(0.5), K(0.86)];                                       // Fuß des Lagerbocks auf der Flanke
Y_hz  = Y_b + t_lg + spiel + 0.2 + r_o;                          // Mitte der Hubzylinder (Rohr-Auge außen neben dem Lagerbock, Rohr frei)
g_fs  = hs + spiel;                                              // halbe Gabelweite für das Stangen-Auge
AP    = [K(1.0), -K(0.5)];  r_ap = max(M(0.07), 0.7);  Z_ap = K(2.95);   // Auspuff
VF    = [K(0.95), K(0.5)];  r_vf = max(M(0.15), 1.6);  Z_vf = K(2.55);   // Vorfilter
function z_haube(x) = Z_hr + (Z_hf - Z_hr) * (x - X_h[0]) / (X_h[1] - X_h[0]);

// Kabine
K_X   = [K(-1.75), K(-0.5)];
K_Y   = [-Y_b, Y_b];
K_Z   = [Z_b1, K(kabine_hoehe_m)];
t_k   = max(M(0.08), 1.2);
t_kr  = max(M(0.1), 1.2);
p_k   = max(M(0.22), d_p + 1.6);
h_pk  = max(M(0.2), 2.0);
c_kd  = M(0.12);

// Schild (Profil hinter x_b: (x - x_b, z) in Metern, Rückseite eben)
x_b   = K(2.1);
W_s   = K(schild_breite_m);
H_s   = K(schild_hoehe_m);
SP_m  = [[0, 0.15], [0, 1.13], [0.48, 1.13], [0.33, 0.85], [0.25, 0.55], [0.3, 0.25], [0.42, 0]];

// Schildrahmen (C-Rahmen, flach in Höhe der Schwenkachse)
t_c   = max(M(0.15), 2.4);                  // Dicke (z)
w_a   = max(M(0.2), 2.0);                   // Armbreite (y)
Ya0   = Y_k0 + B_k + lw_h_nabe + max(M(0.03), 0.3);   // Innenkante der Arme (außen neben Kette und Radnaben)
zc    = P_c[1];
X_q   = [K(1.85), x_b - 0.02];              // Querträger (0,02 mm vor dem Schildrücken)
LZ_p  = [K(1.88), K(1.0)];                  // Auge der Kolbenstange in der Gabel (Stellung 0)
PY    = [-K(0.7), K(0.7)];  a_p = t_c - 0.4;  l_p = max(M(0.15), 2.0);   // Zapfen ins Schild

// Aufreißer
R_p   = [K(-2.25), K(0.8)];                 // Schwenkachse (Bolzen im Unterwagen)
t_r   = max(M(0.15), 2.0);  Yr0 = K(0.3);   // Arme
X_rp  = [K(-2.95), K(-2.7)];  Z_rp = [K(0.8), K(1.1)];  Y_rp = K(0.9);   // Balken
RL_p  = [K(-2.78), K(1.32)];                // Auge der Kolbenstange (Stellung 0); Lasche reicht bis zur Rückseite
SY_r  = [-K(0.6), 0, K(0.6)];  t_s = max(M(0.1), 1.6);   // Zinken
r_ra  = max(M(0.2), r_h + 1.0);

// Zylinder-Längen über die Schwenkbereiche
SW = [0, 10];  RW = [0, 15];
function lug_s(a) = P_c + rot2(LZ_p - P_c, a);
function lug_r(a) = R_p + rot2(RL_p - R_p, -a);
function L_hub(a) = norm(HZ_p - lug_s(a));
function L_rip(a) = norm(RZ_p - lug_r(a));
ZH = [min([for (a = [SW[0] : 1 : SW[1]]) L_hub(a)]), max([for (a = [SW[0] : 1 : SW[1]]) L_hub(a)])];
ZR = [min([for (a = [RW[0] : 1 : RW[1]]) L_rip(a)]), max([for (a = [RW[0] : 1 : RW[1]]) L_rip(a)])];
ov_fuehr = 2.5;                             // kleinste Führung der Stange im Rohr (mm)

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
module xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 8) children();    // 2D (x,z) entlang y
// Loch entlang y als Tropfen; dir = Richtung der Spitze in der x-z-Ebene (90 = +z, 0 = +x)
module hole_y(p, r, y0, y1, dir = 90) xz(y0, y1) translate(p) rotate(dir) teardrop(r);
module bunt(f) color(fhex(f)) render(convexity = 8) children();
module rstift(d, h) let(c = min(0.4, d * 0.2)) { linear_extrude(h - c + 0.01) raute2(d); translate([0, 0, h - c]) linear_extrude(c, scale = (d - 2 * c) / d) raute2(d); }
module ci(p, r) translate(p) circle(r = r, $fn = 40);
// Druck: Ebene x-z, Seite y = y0 aufs Bett (Teil bei y >= y0)
module xz_druck0(y0) multmatrix([[1, 0, 0, 0], [0, 0, -1, 0], [0, 1, 0, -y0], [0, 0, 0, 1]]) children();
// Druck: Fläche x = x0 aufs Bett (Teil bei x >= x0), reine Drehung um y
module yz_druck0(x0) rotate([0, -90, 0]) translate([-x0, 0, 0]) children();
// spitze Lasche (First 52°, stützfrei): r = halbe Breite in Lochhöhe; dir 0 = Spitze nach +z, 90 = nach +x
module spitz2(p, r, dir = 0) translate(p) rotate(dir) scale([1, 1.3]) raute2(2 * r);
module fase_box(p, s, c) hull() { translate([p[0], p[1], p[2]]) cube([s[0], s[1], s[2] - c]); translate([p[0] + c, p[1] + c, p[2]]) cube([s[0] - 2 * c, s[1] - 2 * c, s[2]]); }

// =====================================================================
//  Laufwerk und Unterwagen
// =====================================================================
// Welt (linke Kette); rechte Kette = um z gedreht (gleiches Teil)
module kette_welt(sy) rotate(sy > 0 ? 0 : 180) difference() {
    lw_koerper();
    for (x = TG_X) translate([x - w_tg / 2 - es, Y_k0 - 1, Z_u0 - es]) cube([w_tg + 2 * es, l_tg + 1.3, h_tg + 2 * es]);
    translate([P_c[0], Y_k0 + B_k - l_pz - 0.3, P_c[1]]) rotate([-90, 0, 0]) cylinder(r = r_pz, h = l_pz + 2, $fn = 28);
}
module kette_druck() xz_druck0(Y_k0) kette_welt(1);

module unterwagen_welt() difference() {
    union() {
        fase_box([X_u[0], -Y_u, Z_u0], [X_u[1] - X_u[0], 2 * Y_u, Z_u1 - Z_u0], M(0.1));
        for (x = TG_X) translate([x - w_tg / 2, -Y_k0 - l_tg, Z_u0]) cube([w_tg, 2 * (Y_k0 + l_tg), h_tg]);
        for (p = UP) translate([p[0], p[1], Z_u1 - 0.01]) rstift(d_p, h_up + 0.01);
    }
    // Schlitze für die Ripper-Arme (durchgehend, offen nach oben und unten) und Schwenkbolzen
    for (s = [-1, 1]) translate([X_rb[0] - 1, s > 0 ? Yr0 - spiel : -Yr0 - t_r - spiel, Z_u0 - 1]) cube([R_p[0] + r_ra + 0.3 - X_rb[0] + 1, t_r + 2 * spiel, Z_u1 - Z_u0 + 2]);
    hole_y(R_p, r_pr, -Y_u - 1, Y_u + 1);
    // Taschen für die Kotflügel-Zapfen (Raute, waagerecht, Spitze oben)
    for (s = [-1, 1], x = FX) xz(s > 0 ? Y_u - l_f - 0.3 : -Y_u - 1, s > 0 ? Y_u + 1 : -Y_u + l_f + 0.3) translate([x, zc_f]) raute2(d_f + 2 * es);
}
module unterwagen_druck() translate([0, 0, -Z_u0]) unterwagen_welt();

// Kotflügel: links in Welt; rechts = links um x gedreht (symmetrisch in z)
module kf_links() {
    translate([X_f[0], Y_f[0], z_f0]) cube([X_f[1] - X_f[0], Y_f[1] - Y_f[0], t_f]);
    for (x = FX) xz(Y_u - l_f, Y_f[0] + 0.01) translate([x, zc_f]) raute2(d_f);
}
module kotfluegel_welt(s) if (s > 0) kf_links(); else translate([0, 0, 2 * z_f0 + t_f]) rotate([180, 0, 0]) kf_links();
module kotfluegel_druck() translate([0, 0, -z_f0]) kf_links();

// =====================================================================
//  Rahmen (Aufbau) – aufrecht gedruckt, Unterseite z = Z_b0
// =====================================================================
function kab_pins() = [for (x = [K_X[0] + p_k / 2, K_X[1] - p_k / 2], y = [K_Y[0] + p_k / 2, K_Y[1] - p_k / 2]) [x, y]];
module bock_2d(dz) hull() { spitz2(HZ_p, r_e + 0.4); translate([X_hb[0], Z_b1 - 0.01 + dz]) square([X_hb[1] - X_hb[0], 0.02]); }
module rahmen_koerper() {
    c = M(0.1);
    // Grundkörper: unten so breit wie der Unterwagen, 45°-Flanke auf Haubenbreite (Kabinenboden oben)
    hull() {
        translate([X_rb[1], -Y_u, Z_b0]) cube([X_h[1] - X_rb[1], 2 * Y_u, 0.02]);
        translate([X_rb[1], -Y_b, Z_b1 - 0.02]) cube([X_h[1] - X_rb[1], 2 * Y_b, 0.02]);
    }
    // Motorhaube: Oberkante fällt nach vorne, Längskanten gefast
    hull() for (q = [[X_h[0], Z_hr], [X_h[1] - 0.02, Z_hf]]) {
        translate([q[0], -Y_b, Z_b1 - 0.01]) cube([0.02, 2 * Y_b, q[1] - Z_b1 - c]);
        translate([q[0], -Y_b + c, Z_b1 - 0.01]) cube([0.02, 2 * (Y_b - c), q[1] - Z_b1]);
    }
    // Tank hinter der Kabine und Lagerbock des Aufreißers
    fase_box([X_t[0], -Y_b, Z_b1 - 0.01], [X_t[1] - X_t[0] - 0.3, 2 * Y_b, Z_t - Z_b1 + 0.01], c);   // 0,3 mm Fuge zur Kabine
    translate([X_rb[0], -Y_rb, Z_b0]) cube([X_rb[1] - X_rb[0] + 0.02, 2 * Y_rb, Z_t - Z_b0]);
    // Hubbock des Ripperzylinders (zwei Wangen)
    for (s = [-1, 1]) translate([X_fk[0], s > 0 ? g_fk : -g_fk - t_pl, Z_b0]) cube([X_fk[1] - X_fk[0], t_pl, Z_fk - Z_b0]);
    // Lagerböcke der Hubzylinder: Rippe an der Haubenseite, spitz nach oben
    for (s = [-1, 1]) hull() {
        xz(s > 0 ? Y_b - 0.01 : -Y_b - 0.01, s > 0 ? Y_b + 0.01 : -Y_b + 0.01) bock_2d(0);
        xz(s > 0 ? Y_b + t_lg - 0.02 : -Y_b - t_lg, s > 0 ? Y_b + t_lg : -Y_b - t_lg + 0.02) bock_2d(1.2 * t_lg);
    }
    // Auspuff und Vorfilter auf der Haube
    translate([AP[0], AP[1], z_haube(AP[0]) - 0.5]) { cylinder(r = r_ap, h = Z_ap - z_haube(AP[0]) + 0.5 - 0.3, $fn = 20); translate([0, 0, Z_ap - z_haube(AP[0]) + 0.5 - 0.31]) cylinder(r1 = r_ap, r2 = r_ap - 0.3, h = 0.3, $fn = 20); }
    translate([VF[0], VF[1], z_haube(VF[0]) - 0.5]) {
        cylinder(r = r_vf, h = Z_vf - z_haube(VF[0]) + 0.5 - max(M(0.12), 1.0), $fn = 32);
        translate([0, 0, Z_vf - z_haube(VF[0]) + 0.5 - max(M(0.12), 1.0) - 0.01]) cylinder(r1 = r_vf, r2 = r_vf + 0.3, h = max(M(0.08), 0.7), $fn = 32);
        translate([0, 0, Z_vf - z_haube(VF[0]) + 0.5 - max(M(0.04), 0.3) - 0.01]) cylinder(r1 = r_vf + 0.3, r2 = r_vf - 0.2, h = max(M(0.04), 0.3), $fn = 32);
    }
}
module rahmen_welt() difference() {
    rahmen_koerper();
    // Taschen für die Zapfen des Unterwagens (von unten) und der Kabine (von oben)
    for (p = UP) translate([p[0], p[1], Z_b0 - 1]) linear_extrude(h_up + es + 1) raute2(d_p + 2 * es);
    for (p = kab_pins()) translate([p[0], p[1], Z_b1 - h_pk - es]) linear_extrude(h_pk + es + 1) raute2(d_p + 2 * es);
    // Bolzenlöcher der Lagerböcke (stramm, blind zur Haube hin)
    for (s = [-1, 1]) hole_y(HZ_p, r_pr, s > 0 ? Y_b - 1.0 : -Y_b - t_lg - 1, s > 0 ? Y_b + t_lg + 1 : -Y_b + 1.0);
    // Bolzenloch des Ripperzylinders, Ausschnitt zwischen den Wangen (Rohr schwenkt hinein)
    hole_y(RZ_p, r_pr, -Y_rb - 1, Y_rb + 1);
    translate([X_rb[0] - 1, -g_fk, z_nt]) cube([X_fk[1] - X_rb[0] + 1, 2 * g_fk, Z_fk]);
    // Kühlergrill vorne (senkrechte Schlitze) und Lüftungsschlitze seitlich
    let(n = 9, w = max(M(0.05), 0.6), dg = max(M(0.03), 0.4), z0 = Z_b1 + K(0.12), z1 = Z_hf - K(0.18))
        for (i = [0 : n - 1]) translate([X_h[1] - dg, -K(0.6) + i * K(1.2) / (n - 1) - w / 2, z0]) cube([dg + 1, w, z1 - z0]);
    let(n = 6, w = max(M(0.05), 0.6), dg = max(M(0.03), 0.4)) for (s = [-1, 1], i = [0 : n - 1])
        translate([X_h[0] + K(0.15) + i * K(0.13), s > 0 ? Y_b - dg : -Y_b - 1, Z_b1 + K(0.3)]) cube([w, dg + 1, K(0.5)]);
    // Türfugen am Tank
    let(dg = max(M(0.03), 0.4)) for (s = [-1, 1]) translate([X_t[0] + K(0.1), s > 0 ? Y_b - dg : -Y_b - 1, Z_b1 + K(0.1)]) cube([max(M(0.03), 0.5), dg + 1, Z_t - Z_b1 - K(0.25)]);
}
module rahmen_druck() translate([0, 0, -Z_b0]) rahmen_welt();

// =====================================================================
//  Kabine (Welt; gedruckt kopfüber, Glaskern von unten)
// =====================================================================
module kab_aussen() hull() {
    translate([K_X[0], K_Y[0], K_Z[0]]) cube([K_X[1] - K_X[0], K_Y[1] - K_Y[0], K_Z[1] - K_Z[0] - c_kd]);
    translate([K_X[0] + c_kd, K_Y[0] + c_kd, K_Z[0]]) cube([K_X[1] - K_X[0] - 2 * c_kd, K_Y[1] - K_Y[0] - 2 * c_kd, K_Z[1] - K_Z[0]]);
}
module kab_raum(o) difference() {
    translate([K_X[0] + t_k - o, K_Y[0] + t_k - o, K_Z[0] - 1]) cube([K_X[1] - K_X[0] - 2 * t_k + 2 * o, K_Y[1] - K_Y[0] - 2 * t_k + 2 * o, K_Z[1] - K_Z[0] - t_kr + 1 + min(o, 0)]);
    for (p = kab_pins()) translate([p[0] - p_k / 2 - o, p[1] - p_k / 2 - o, K_Z[0] - 2]) cube([p_k + 2 * o, p_k + 2 * o, K_Z[1]]);
}
module kab_fenster() {
    xm = (K_X[0] + K_X[1]) / 2; w2 = max(M(0.08), 1.0); z1 = K_Z[1] - M(0.22);
    // vorne tief heruntergezogen, hinten kürzer, seitlich Tür- und Seitenscheibe
    translate([K_X[1] - t_k - 1, K_Y[0] + p_k, K_Z[0] + M(0.3)]) cube([t_k + 2, K_Y[1] - K_Y[0] - 2 * p_k, z1 - K_Z[0] - M(0.3)]);
    translate([K_X[0] - 1, K_Y[0] + p_k, K_Z[0] + M(0.75)]) cube([t_k + 2, K_Y[1] - K_Y[0] - 2 * p_k, z1 - K_Z[0] - M(0.75)]);
    for (y = [K_Y[0] - 1, K_Y[1] - t_k - 1]) for (xx = [[K_X[0] + p_k, xm - w2 / 2], [xm + w2 / 2, K_X[1] - p_k]])
        translate([xx[0], y, K_Z[0] + M(0.55)]) cube([xx[1] - xx[0], t_k + 2, z1 - K_Z[0] - M(0.55)]);
}
module kabine_welt(fp) {
    if (inc(fp, "A")) {
        difference() { kab_aussen(); kab_raum(0); kab_fenster(); }
        for (p = kab_pins()) translate([p[0], p[1], K_Z[0] + 0.01]) rotate([180, 0, 0]) rstift(d_p, h_pk + 0.01);
    }
    if (inc(fp, "B")) intersection() { kab_raum(-es); translate([-K(5), -K(5), K_Z[0]]) cube([K(10), K(10), K_Z[1] - K_Z[0] - t_kr - es]); }
}
module kabine_druck(fp) translate([0, 0, K_Z[1]]) rotate([180, 0, 0]) kabine_welt(fp);

// =====================================================================
//  Schild und Schildrahmen (Welt in Stellung 0)
// =====================================================================
module schild_prof_2d() polygon([for (p = SP_m) KP(p)]);
module schild_welt() difference() {
    translate([x_b, 0, 0]) xz(-W_s / 2, W_s / 2) schild_prof_2d();
    for (y = PY) translate([x_b - 1, y - a_p / 2 - es, zc - t_c / 2 - es]) cube([l_p + 0.3 + 1, a_p + 2 * es, a_p + 2 * es]);
}
module schild_druck() yz_druck0(x_b) schild_welt();

module rahmen_s_2d() {   // Draufsicht
    for (s = [-1, 1]) translate([P_c[0] - K(0.15), s > 0 ? Ya0 : -Ya0 - w_a]) square([X_q[1] - P_c[0] + K(0.15), w_a]);
    translate([X_q[0], -Ya0 - w_a]) square([X_q[1] - X_q[0], 2 * (Ya0 + w_a)]);
    for (s = [-1, 1]) polygon([[X_q[0], s * (Ya0 + w_a)], [X_q[0] - K(0.3), s * (Ya0 + w_a)], [X_q[0], s * Ya0]]);   // Eckbleche
}
module lasche_s_2d() hull() { spitz2(LZ_p, r_e + max(M(0.03), 0.4)); translate([X_q[0], zc - t_c / 2]) square([X_q[1] - X_q[0], 0.02]); }
YG = [[Y_hz - g_fs - t_c, Y_hz - g_fs], [Y_hz + g_fs, Y_hz + g_fs + t_c]];   // Gabelwangen (links)
module schildrahmen_welt() difference() {
    union() {
        translate([0, 0, zc - t_c / 2]) linear_extrude(t_c, convexity = 6) rahmen_s_2d();
        for (s = [-1, 1], g = YG) xz(s > 0 ? g[0] : -g[1], s > 0 ? g[1] : -g[0]) lasche_s_2d();
        for (y = PY) translate([X_q[1] - 0.01, y - a_p / 2, zc - t_c / 2]) cube([l_p + 0.03, a_p, a_p]);
        for (s = [-1, 1]) xz(s > 0 ? Y_k0 + B_k - l_pz : -Ya0 - 0.01, s > 0 ? Ya0 + 0.01 : -(Y_k0 + B_k - l_pz)) translate(P_c) raute2(d_pz);
    }
    for (s = [-1, 1]) hole_y(LZ_p, r_pr, s > 0 ? YG[0][0] - 1 : -YG[1][1] - 1, s > 0 ? YG[1][1] + 1 : -YG[0][0] + 1);
}
module schildrahmen_druck() translate([0, 0, -(zc - t_c / 2)]) schildrahmen_welt();

// =====================================================================
//  Aufreißer (Welt in Stellung 0; gedruckt mit der Rückseite x = X_rp[0] nach unten)
// =====================================================================
module ripper_arm_2d() hull() { ci(R_p, r_ra); translate([X_rp[0], Z_rp[0]]) square([X_rp[1] - X_rp[0], Z_rp[1] - Z_rp[0]]); }
module ripper_lasche_2d() intersection() {
    hull() { spitz2(RL_p, r_e + max(M(0.03), 0.4), 90); translate([X_rp[0], Z_rp[1] - 0.02]) square([X_rp[1] - X_rp[0], 0.02]); translate([X_rp[0], Z_rp[1]]) square([0.02, RL_p[1] - Z_rp[1]]); }
    translate([X_rp[0], 0]) square([K(2), K(3)]);   // nichts hinter der Rückseite (Druckauflage)
}
module zinken_2d() {
    translate([X_rp[0], K(0.15)]) square([X_rp[1] - X_rp[0] - K(0.03), Z_rp[1] - K(0.15) - 0.02]);
    polygon([[X_rp[1] - K(0.03) - 0.01, K(0.47)], [X_rp[1] - K(0.03) - 0.01, K(0.15)], [X_rp[1] - K(0.03) + K(0.3), K(0.15)]]);
}
module ripper_welt() difference() {
    union() {
        translate([X_rp[0], -Y_rp, Z_rp[0]]) cube([X_rp[1] - X_rp[0], 2 * Y_rp, Z_rp[1] - Z_rp[0]]);
        for (s = [-1, 1]) xz(s > 0 ? Yr0 : -Yr0 - t_r, s > 0 ? Yr0 + t_r : -Yr0) ripper_arm_2d();
        xz(hs + spiel, hs + spiel + t_r) ripper_lasche_2d();
        for (y = SY_r) xz(y - t_s / 2, y + t_s / 2) zinken_2d();
    }
    hole_y(R_p, r_h, -Y_rp, Y_rp, 0);
    hole_y(RL_p, r_pr, -Y_rp, Y_rp, 0);
}
module ripper_druck() yz_druck0(X_rp[0]) ripper_welt();

// =====================================================================
//  Zusammenbau
// =====================================================================
module in_schild(a) translate([P_c[0], 0, P_c[1]]) rotate([0, -a, 0]) translate([-P_c[0], 0, -P_c[1]]) children();
module in_ripper(a) translate([R_p[0], 0, R_p[1]]) rotate([0, a, 0]) translate([-R_p[0], 0, -R_p[1]]) children();
module hubzylinder(a, fp, s) {
    if (inc(fp, "A")) bunt(farbe_zylinder) zyl_zw(HZ_p, lug_s(a), s * Y_hz, "A", ZH, false, false);
    if (inc(fp, "B")) bunt(farbe_stange) zyl_zw(HZ_p, lug_s(a), s * Y_hz, "B", ZH, false, false);
}
module ripperzylinder(a, fp) {
    if (inc(fp, "A")) bunt(farbe_zylinder) zyl_zw(RZ_p, lug_r(a), 0, "A", ZR, false, false);
    if (inc(fp, "B")) bunt(farbe_stange) zyl_zw(RZ_p, lug_r(a), 0, "B", ZR, false, false);
}
module planierraupe(ex = 0) {
    a = ex > 0 ? 0 : schild_winkel;
    b = ex > 0 ? 10 : ripper_winkel;
    bunt(farbe_unterwagen) unterwagen_welt();
    for (s = [-1, 1]) translate([0, s * ex * 1.4, 0]) bunt(farbe_kette) kette_welt(s);
    for (s = [-1, 1]) translate([0, s * ex * 1.4, ex * 0.5]) bunt(farbe_gelb) kotfluegel_welt(s);
    translate([0, 0, ex]) {
        bunt(farbe_gelb) rahmen_welt();
        translate([0, 0, ex * 0.8]) { bunt(farbe_kabine) kabine_welt("A"); translate([0, 0, -ex * 0.4]) bunt(farbe_glas) kabine_welt("B"); }
    }
    translate([ex * 0.8, 0, 0]) in_schild(a) {
        bunt(farbe_gelb) schildrahmen_welt();
        translate([ex * 0.8, 0, 0]) bunt(farbe_gelb) schild_welt();
    }
    for (s = [-1, 1]) translate([ex * 0.4, s * ex * 0.5, ex * 0.6]) hubzylinder(a, "alle", s);
    translate([-ex * 0.9, 0, 0]) in_ripper(b) bunt(farbe_gelb) ripper_welt();
    translate([-ex * 0.5, 0, ex * 0.7]) ripperzylinder(b, "alle");
}

// =====================================================================
//  Info und Ausgabe
// =====================================================================
BOLZ = [["Hubzylinder oben (Lagerbock)", t_lg + spiel + 0.2 + 2 * hz + 1.0], ["Hubzylinder unten (Gabel)", 2 * (g_fs + t_c)],
        ["Ripper-Schwenkachse", 2 * Y_u], ["Ripperzylinder oben (Hubbock)", 2 * (g_fk + t_pl)], ["Ripperzylinder unten (Lasche)", 2 * hs + spiel + t_r + 0.5]];
L_ges = (x_b + K(SP_m[6][0])) - (X_rp[0]);
echo(str("Planierraupe 1:", den, " | Laufwerk ", r2(2 * (c_k + r_k)), " x ", r2(2 * (Y_k0 + B_k)), " mm | Länge mit Schild und Ripper ", r2(L_ges), " mm | Schild ", r2(W_s), " x ", r2(H_s), " mm | Höhe ", r2(K_Z[1]), " mm"));
echo(str("Zylinder: Rohr Ø ", r2(2 * r_o), ", Stange Ø ", r2(2 * r_s), ", Auge Ø ", r2(2 * r_e), " mm | Hubzylinder ", r2(ZH[0]), "–", r2(ZH[1]), " mm (Führung ", r2(ov(ZH)), ", hält ab ", r2(ov_min), ") | Ripperzylinder ", r2(ZR[0]), "–", r2(ZR[1]), " (", r2(ov(ZR)), ")"));
echo(str("Schildrahmen ", r2(t_c), " mm dick, Schwenkzapfen Raute ", r2(d_pz), " mm | Zapfen Raute ", r2(d_p), " mm | Kotflügel ", r2(t_f), " mm"));
echo(str("Filament-Bolzen Ø ", stift_d, ": ", [for (b = BOLZ) str(b[0], " ", r2(b[1]), " mm")]));
if (min(ov(ZH), ov(ZR)) < ov_fuehr) echo("WARNUNG: Kolbenstange zu kurz für den Schwenkbereich");
if (ov(ZH) < ov_min || ov(ZR) < ov_min) echo(str("Hinweis: Zylinder halten die Stellung in 1:", den, " nur bedingt (Führung unter ", r2(ov_min), " mm)"));
if (W_s > usable) echo("WARNUNG: Schild breiter als das Druckbett");
if (d_pz > t_c - 0.2) echo("WARNUNG: Schwenkzapfen dicker als der Schildrahmen");
if (zc_f + d_f / 2 + es > Z_u1 - 0.6) echo("WARNUNG: Kotflügel-Tasche zu nah an der Oberkante des Unterwagens");
mass_echo(L_ges, W_s, K_Z[1]);

druck("unterwagen", 1, "alle", farbe_unterwagen, 1);
druck("kette", 1, "alle", farbe_kette, 2);
druck("rahmen", 1, "alle", farbe_gelb, 1);
druck("kabine", 1, "A", farbe_kabine, 1); druck("kabine", 1, "B", farbe_glas, 1);
druck("kotfluegel", 1, "alle", farbe_gelb, 2);
druck("schild", 1, "alle", farbe_gelb, 1);
druck("schildrahmen", 1, "alle", farbe_gelb, 1);
druck("zylinder_hub", 1, "A", farbe_zylinder, 2); druck("zylinder_hub", 1, "B", farbe_stange, 2);
druck("ripper", 1, "alle", farbe_gelb, 1);
druck("zylinder_ripper", 1, "A", farbe_zylinder, 1); druck("zylinder_ripper", 1, "B", farbe_stange, 1);
farben_echo();

if (teil == "aufbau") planierraupe();
else if (teil == "explosion") planierraupe(max(M(1.4), 12));
else if (teil == "unterwagen") unterwagen_druck();
else if (teil == "kette") kette_druck();
else if (teil == "rahmen") rahmen_druck();
else if (teil == "kabine") kabine_druck(farbteil);
else if (teil == "kotfluegel") kotfluegel_druck();
else if (teil == "schild") schild_druck();
else if (teil == "schildrahmen") schildrahmen_druck();
else if (teil == "zylinder_hub") zylinder_druck(farbteil, ZH, false, false);
else if (teil == "ripper") ripper_druck();
else if (teil == "zylinder_ripper") zylinder_druck(farbteil, ZR, false, false);
