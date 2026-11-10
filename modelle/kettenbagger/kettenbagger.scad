// =====================================================================
//  KETTENBAGGER  –  Hydraulikbagger der 50-t-Klasse mit Tieflöffel
//  Vorbild: Cat 349D L (Ausleger 6,9 m, Stiel 3,35 m, Laufwerk 5,36 m)
//  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei), Farben je Bauteil,
//  Maßstab 1:43 / 1:87.  Oberwagen dreht, Ausleger, Stiel und Löffel bewegen sich,
//  die teleskopischen Hydraulikzylinder fahren mit und halten jede Stellung.
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    unterwagen      Unterwagen mit Drehkranz, Königszapfen und Steckzungen           1x
//    kette           Raupenlaufwerk mit Bodenplatten, Laufrollen, Leit- und Turasrad  2x
//    oberwagen       Plattform mit Motorhaus, Gegengewicht, Tank, Auslegerlager (A),
//                    dunkles Band an der Plattformkante (B, Farbzone)                 1x
//    kabine          Fahrerkabine (unten offen) + Glaskern von unten                  1x
//    ausleger_links / ausleger_rechts   Auslegerhälften (flach, Außenseite unten)  je 1x
//    stiel_links / stiel_rechts         Stielhälften (flach, Außenseite unten)     je 1x
//    duebel          Vierkant-Dübel zwischen den Hälften                              4x
//    loeffel         Tieflöffel mit Zähnen und Lageraugen (Öffnung unten gedruckt)    1x
//    zylinder_ausleger  Hubzylinder: Rohr (A) + Kolbenstange (B)                      2x
//    zylinder_stiel     Stielzylinder: Rohr (A) + Kolbenstange (B)                    1x
//    zylinder_loeffel   Löffelzylinder: Rohr (A) + Kolbenstange (B)                   1x
//    umlenkhebel     Umlenkhebel des Löffelgestänges (flach)                          2x
//    koppel          Koppelstange vom Umlenkhebel zum Löffel (flach)                  2x
//    handlauf        Handlauf (flach), in Schlitze auf Tankkasten und Motorhaus       2x
//    spiegel         Außenspiegel (flach), in Schlitze auf Tankkasten und Kabinendach 2x
//
//  BOLZEN
//    11 Filament-Stücke Ø stift_d (Längen siehe Echo).
//  BEWEGLICH
//    * Oberwagen dreht auf dem Königszapfen.
//    * Ausleger, Stiel und Löffel schwenken an Bolzen; die Kolbenstangen gleiten in
//      den Rohren und halten die Stellung durch Reibung (zylinder_spiel).
//  DRUCK
//    Alle Teile stützfrei: Unterwagen und Oberwagen aufrecht, Ketten auf der Innenseite
//    liegend, Ausleger- und Stielhälften flach, Löffel mit der Öffnung nach unten,
//    Zylinder liegend, Kabine kopfüber.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, unterwagen:Unterwagen, kette:Raupenlaufwerk (2x), oberwagen:Oberwagen, kabine:Kabine mit Glaskern, ausleger_links:Ausleger links, ausleger_rechts:Ausleger rechts, stiel_links:Stiel links, stiel_rechts:Stiel rechts, duebel:Dübel (4x), loeffel:Tieflöffel, zylinder_ausleger:Hubzylinder (2x), zylinder_stiel:Stielzylinder, zylinder_loeffel:Löffelzylinder, umlenkhebel:Umlenkhebel (2x), koppel:Koppelstange (2x), handlauf:Handlauf (2x), spiegel:Außenspiegel (2x)]
stueck = 0;
farbteil = "alle"; // [alle, A, B]

/* [Vorschau] */
// Drehung des Oberwagens
drehung = 0; // [-180:5:180]
// Ausleger: Winkel über der Waagerechten
ausleger_winkel = 28; // [0:1:50]
// Stiel: Winkel zum Ausleger (-50 = gestreckt, -140 = angezogen)
stiel_winkel = -100; // [-140:1:-50]
// Löffel: Winkel zum Stiel (-48 = eingekippt, 45 = ausgekippt)
loeffel_winkel = -25; // [-48:1:45]

/* [Bagger (Vorbild in Metern)] */
laufwerk_laenge_m = 5.36;
spur_m = 2.74;
kette_breite_m = 0.6;
oberwagen_breite_m = 3.0;
heckradius_m = 3.6;
kabine_hoehe_m = 3.2;
ausleger_m = 6.9;
stiel_m = 3.35;
loeffel_breite_m = 1.5;

/* [Farben] */
farbe_gelb      = "catgelb";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_unterwagen = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_kette     = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_kabine    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_glas      = "puderblau"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_loeffel   = "catgelb";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_zylinder  = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_stange    = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_band      = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_anbau     = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]

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
// Luft je Seite für eingepresste Teile (Zungen, Dübel, Glaskern, Zapfen; 0 = sehr stramm)
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
//  Maße (Welt: x = 0 Drehachse, +x nach vorne, +y links, z = 0 Boden; mm)
// =====================================================================
function K(m) = m * 1000 / den;
function KP(p) = [K(p[0]), K(p[1])];
function rot2(p, a) = [p[0] * cos(a) - p[1] * sin(a), p[0] * sin(a) + p[1] * cos(a)];
es    = einsatz_spiel;
r_h   = (stift_d + 0.25) / 2;               // Bolzenloch lose
r_pr  = stift_d / 2 + es;                   // stramm
r_e   = max(M(0.17), r_h + 1.0);            // Augen
d_p   = max(M(0.16), 2.0);                  // Steckzapfen (Raute)

// Laufwerk
r_k   = K(0.52);                            // Umlenkradius der Kette
c_k   = K(laufwerk_laenge_m / 2) - r_k;
B_k   = K(kette_breite_m);
Y_k0  = K(spur_m / 2) - B_k / 2;            // Innenseite der Kette
h_gr  = max(M(0.04), 0.5);                  // Stollen
t_sh  = max(M(0.1), 1.2);                   // Bodenplatten-Band
d_rf  = max(M(0.08), 0.8);                  // Relieftiefe außen
// Unterwagen
Z_u0  = K(0.5);  Z_u1 = K(1.05);  Z_dk = K(1.15);
X_u   = K(1.3);
Y_u   = Y_k0 - max(M(0.02), 0.3);
TG_X  = [-K(0.8), K(0.8)];  w_tg = K(0.6);  h_tg = max(M(0.3), 2.4);  l_tg = max(M(0.3), 3);
r_kp  = max(M(0.28), 2.5);  h_kp = K(0.42);
// Oberwagen
Z_o0  = K(1.2);  Z_o1 = K(1.45);            // Plattform
Y_o   = K(oberwagen_breite_m / 2);
X_h   = -K(heckradius_m);
X_mh  = -K(0.95);                           // Motorhaus vorne
X_vo  = K(1.3);                             // Plattform vorne (Seiten)
Z_mh  = K(2.75);
Z_tk  = K(2.3);                             // Tankkasten rechts
// Kabine
K_X   = [-K(0.45), K(1.2)];
K_Y   = [K(0.68), Y_o];
K_Z   = [Z_o1, K(kabine_hoehe_m)];
t_k   = max(M(0.08), 1.2);
t_kr  = max(M(0.1), 1.2);
p_k   = max(M(0.22), d_p + 1.6);
c_kd  = M(0.12);

// Arbeitsausrüstung (2D in der Schwenkebene, Vorbild-Meter)
T_s   = max(M(0.6), 6.6);                   // Stiel-Dicke
G_b   = T_s + 2 * spiel;                    // Gabel im Ausleger
T_b   = G_b + 2 * max(M(0.12), 1.3);        // Ausleger-Dicke
F_m   = [0.3, 2.0];                         // Auslegerfuß (Welt)
CF_m  = [1.5, 1.7];                         // Hubzylinder-Fuß (Welt)
A_m   = [3.1, 0.55];                        // Hubzylinder am Ausleger (lokal)
K_m   = [3.0, 0.9];                         // Knick
S1_m  = [3.3, 1.75];                        // Stielzylinder am Ausleger
T_m   = [ausleger_m, 0];                    // Stielgelenk
R_m   = [-0.75, 0.45];                      // Stielzylinder am Stiel (lokal Stiel)
C1_m  = [0.3, 0.6];                          // Löffelzylinder am Stiel
B_m   = [stiel_m, 0];                       // Löffelgelenk
// Löffel (lokal = Druckrahmen: Öffnung q = 0, Rückwand links, Schneide rechts)
LB_m  = [0.0, 0.7];                         // Löffelgelenk im Löffelrahmen
LQ_m  = [0.14, 1.18];                       // Koppel-Auge im Löffelrahmen
I_m   = [2.75, 0.05];                        // Umlenkhebel am Stiel (lokal Stiel)
l_hb  = K(0.62);  l_kp = K(0.62);           // Umlenkhebel, Koppel
Qr_m  = LQ_m - LB_m;
W_l   = K(loeffel_breite_m);
t_bk  = max(M(0.06), 1.2);
t_ohr = max(M(0.1), 1.6);
F_p = KP(F_m); CF_p = KP(CF_m); A_p = KP(A_m); K_p = KP(K_m); S1_p = KP(S1_m); T_p = KP(T_m);
R_p = KP(R_m); C1_p = KP(C1_m); B_p = KP(B_m); Qr_p = KP(Qr_m); I_p = KP(I_m);
t_gs  = max(M(0.08), 1.4);                  // Dicke Umlenkhebel / Koppel
// Gelenk J von Umlenkhebel, Koppel und Kolbenstange (Stiel-lokal) für den Löffelwinkel c
function Q_st(c) = B_p + rot2(Qr_p, c);
function J_st(c) = let(Q = Q_st(c), d = norm(Q - I_p), e = (Q - I_p) / d, a = (l_hb * l_hb - l_kp * l_kp + d * d) / (2 * d), h = sqrt(max(l_hb * l_hb - a * a, 0)))
    I_p + a * e + h * [-e[1], e[0]];
t_lg  = max(M(0.14), 1.6);                  // Lagerwangen am Oberwagen
Y_lg  = T_b / 2 + spiel;

// Zylinder (gedruckt liegend; Rohr unten 45° abgeflacht, Stange oben und unten flach)
r_s   = max(M(0.065), 1.2);
hs    = 0.62 * r_s;
r_b   = r_s + zylinder_spiel;
r_o   = max(M(0.14), r_b + 1.0);
hz    = 0.9 * r_o;
x_b0  = r_e + max(M(0.05), 0.8);
g_tz  = max(M(0.06), 0.8);
ov_min = max(5 * r_s, M(0.3));
// Längenbereiche über die Schwenkbereiche
BW = [0, 50]; SW = [-140, -50]; LW = [-48, 45];
function L_hub(t) = norm(F_p + rot2(A_p, t) - CF_p);
function L_sti(p) = norm(S1_p - (T_p + rot2(R_p, p)));
function L_loe(c) = norm(C1_p - J_st(c));
function lmin(v) = min(v);
ZH = [min([for (a = [BW[0] : 2 : BW[1]]) L_hub(a)]), max([for (a = [BW[0] : 2 : BW[1]]) L_hub(a)])];
ZS = [min([for (a = [SW[0] : 2 : SW[1]]) L_sti(a)]), max([for (a = [SW[0] : 2 : SW[1]]) L_sti(a)])];
ZL = [min([for (a = [LW[0] : 2 : LW[1]]) L_loe(a)]), max([for (a = [LW[0] : 2 : LW[1]]) L_loe(a)])];
function ov(Z) = (Z[0] - r_e - g_tz) - (x_b0 + Z[1] - Z[0]);
Y_hz  = T_b / 2 + max(M(0.03), 0.4) + hz;   // Mitte der Hubzylinder
// Dübel der Hälften
a_dw  = max(M(0.15), 1.8);
function d_dp(T) = min(T / 2 - 0.8, max(M(0.2), 2));
DB = [[1.5, 0.4], [4.9, 0.45]];             // Ausleger (lokal, m)
DS = [[1.2, 0], [2.4, 0]];                  // Stiel

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
module yz(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0, convexity = 8) children();   // 2D (y,z) entlang x
module hole_y(p, r, y0, y1) xz(y0, y1) translate(p) rotate(90) teardrop(r);
module bunt(f) color(fhex(f)) render(convexity = 8) children();
module rstift(d, h) let(c = min(0.4, d * 0.2)) { linear_extrude(h - c + 0.01) raute2(d); translate([0, 0, h - c]) linear_extrude(c, scale = (d - 2 * c) / d) raute2(d); }
module ci(p, r) translate(p) circle(r = r, $fn = 40);
// Druck: Ebene x-z, Seite y = y0 aufs Bett (Teil bei y >= y0)
module xz_druck0(y0) multmatrix([[1, 0, 0, 0], [0, 0, -1, 0], [0, 1, 0, -y0], [0, 0, 0, 1]]) children();

// =====================================================================
//  Laufwerk
// =====================================================================
module kette_umriss_2d() hull() { ci([-c_k, r_k], r_k); ci([c_k, r_k], r_k); }
module kette_2d() {
    kette_umriss_2d();
    // Stollen
    n = max(8, round(2 * c_k / max(M(0.22), 1.6))); p = 2 * c_k / n; w = p * 0.45;
    for (i = [0 : n]) for (z = [0, 2 * r_k]) translate([-c_k + i * p, z]) square([w, 2 * h_gr], center = true);
    m = max(4, round(PI * r_k / p));
    for (s = [-1, 1], i = [1 : m - 1]) translate([s * c_k, r_k]) rotate(s * (i * 180 / m) - 90) translate([r_k, 0]) square([2 * h_gr, w], center = true);
}
module kette_relief_2d() {   // Laufwerksrahmen, Räder und Rollen (innerhalb des Bandes)
    hull() { ci([-c_k * 0.8, r_k], r_k * 0.42); ci([c_k * 0.8, r_k], r_k * 0.42); }
    for (s = [-1, 1]) { ci([s * c_k, r_k], r_k - t_sh - max(M(0.03), 0.4)); }
    for (i = [0 : 6]) ci([-c_k * 0.78 + i * c_k * 1.56 / 6, t_sh + K(0.14)], K(0.13));
    for (x = [-c_k * 0.35, c_k * 0.35]) ci([x, 2 * r_k - t_sh - K(0.11)], K(0.1));
}
// Welt (linke Kette, y = Y_k0 .. Y_k0 + B_k); rechte Kette = um z gedreht (gleiches Teil)
module kette_welt(sy) rotate(sy > 0 ? 0 : 180) difference() {
    union() {
        xz(Y_k0, Y_k0 + B_k - d_rf) kette_2d();
        xz(Y_k0 + B_k - d_rf - 0.01, Y_k0 + B_k) { difference() { kette_2d(); offset(delta = -t_sh) kette_umriss_2d(); } kette_relief_2d(); }
        // Radnaben
        for (s = [-1, 1]) translate([s * c_k, Y_k0 + B_k - 0.01, r_k]) rotate([-90, 0, 0]) cylinder(r1 = r_k * 0.3, r2 = r_k * 0.22, h = max(M(0.04), 0.5), $fn = 24);
    }
    // Taschen für die Steckzungen des Unterwagens (innen)
    for (x = TG_X) translate([x - w_tg / 2 - es, Y_k0 - 1, Z_u0 - es]) cube([w_tg + 2 * es, l_tg + 1.3, h_tg + 2 * es]);
}
module kette_druck() xz_druck0(Y_k0) kette_welt(1);

module unterwagen_welt() {
    c = M(0.12);
    hull() {
        translate([-X_u, -Y_u, Z_u0]) cube([2 * X_u, 2 * Y_u, Z_u1 - Z_u0 - c]);
        translate([-X_u + c, -Y_u + c, Z_u0]) cube([2 * (X_u - c), 2 * (Y_u - c), Z_u1 - Z_u0]);
    }
    for (x = TG_X) translate([x - w_tg / 2, -Y_k0 - l_tg, Z_u0]) cube([w_tg, 2 * (Y_k0 + l_tg), h_tg]);
    translate([0, 0, Z_u1 - 0.01]) cylinder(r = K(0.8), h = Z_dk - Z_u1 + 0.01, $fn = 64);
    translate([0, 0, Z_dk - 0.01]) { cylinder(r = r_kp, h = h_kp - 0.4, $fn = 40); translate([0, 0, h_kp - 0.4 - 0.01]) cylinder(r1 = r_kp, r2 = r_kp - 0.4, h = 0.4, $fn = 40); }
}
module unterwagen_druck() translate([0, 0, -Z_u0]) unterwagen_welt();

// =====================================================================
//  Oberwagen
// =====================================================================
function kab_pins() = [for (x = [K_X[0] + p_k / 2, K_X[1] - p_k / 2], y = [K_Y[0] + p_k / 2, K_Y[1] - p_k / 2]) [x, y]];
r_hk = K(0.6);
d_bd = max(M(0.03), 0.5);                    // Tiefe des dunklen Bandes
module plattform_2d() {   // runde Heckecken, vorne Nase für die Hubzylinder
    hull() { for (s = [-1, 1]) ci([X_h + r_hk, s * (Y_o - r_hk)], r_hk); translate([X_vo - 1, -Y_o]) square([1, 2 * Y_o]); }
    translate([X_vo - 1, -K(0.62)]) square([K(1.85) - X_vo + 1, K(1.24)]);
}
// Band: Ring der Tiefe d_bd, oben in 4 Stufen auslaufend (45°, damit der Oberwagen auch einfarbig stützfrei druckt)
module band(o) let(hb = Z_o1 - Z_o0, n = 4) {
    translate([0, 0, Z_o0 + (o > 0 ? 0 : -1)]) linear_extrude(hb - d_bd + (o > 0 ? 0 : 1), convexity = 6) difference() { offset(delta = o > 0 ? -0.02 : 1) plattform_2d(); offset(delta = -d_bd) plattform_2d(); }
    for (k = [0 : n - 1]) translate([0, 0, Z_o1 - d_bd + k * d_bd / n - 0.01]) linear_extrude(d_bd / n + 0.01, convexity = 6) difference() { offset(delta = o > 0 ? -0.02 : 1) plattform_2d(); offset(delta = -d_bd * (1 - (k + 1) / n) - 0.03) plattform_2d(); }
}
module oberwagen_welt(fp = "alle") {
    if (inc(fp, "A")) difference() { oberwagen_koerper(); band(0); }
    if (inc(fp, "B")) band(1);
}
module oberwagen_koerper() {
    c = M(0.1);
    difference() {
        union() {
            translate([0, 0, Z_o0]) linear_extrude(Z_o1 - Z_o0, convexity = 6) plattform_2d();
            // Motorhaus mit Gegengewicht (Oberkante gefast)
            hull() {
                for (s = [-1, 1]) translate([X_h + r_hk, s * (Y_o - r_hk), Z_o1 - 0.01]) cylinder(r = r_hk, h = Z_mh - Z_o1 - c, $fn = 40);
                for (s = [-1, 1]) translate([X_h + r_hk, s * (Y_o - r_hk), Z_o1 - 0.01]) cylinder(r = r_hk - c, h = Z_mh - Z_o1, $fn = 40);
                translate([X_mh - 1, -Y_o, Z_o1 - 0.01]) cube([1, 2 * Y_o, Z_mh - Z_o1 - c]);
                translate([X_mh - 1, -Y_o + c, Z_o1 - 0.01]) cube([1, 2 * (Y_o - c), Z_mh - Z_o1]);
            }
            // Tank- und Werkzeugkasten rechts, Kasten hinter der Kabine
            hull() { translate([X_mh - 1, -Y_o, Z_o1 - 0.01]) cube([X_vo - K(0.1) - X_mh + 1, Y_o - K(0.68), Z_tk - Z_o1 - c]);
                     translate([X_mh - 1, -Y_o + c, Z_o1 - 0.01]) cube([X_vo - K(0.1) - X_mh + 1 - c, Y_o - K(0.68) - c, Z_tk - Z_o1]); }
            translate([X_mh - 1, K_Y[0], Z_o1 - 0.01]) cube([K_X[0] - X_mh + 1 - max(M(0.03), 0.4), Y_o - K_Y[0], K(0.9)]);
            // Auspuff und Luftfilter-Haube
            translate([X_mh - K(0.7), K(0.75), Z_mh - 0.01]) { cylinder(r = max(M(0.09), 1.0), h = K(0.55), $fn = 20); }
            translate([X_mh - K(1.5), -K(0.3), Z_mh - 0.01]) hull() { cube([K(1.0), K(1.2), K(0.01)]); translate([c, c, 0]) cube([K(1.0) - 2 * c, K(1.2) - 2 * c, c]); }
            // Auslegerlager: zwei Wangen
            for (s = [-1, 1]) xz(s > 0 ? Y_lg : -Y_lg - t_lg, s > 0 ? Y_lg + t_lg : -Y_lg) hull() { ci(F_p, K(0.34)); translate([F_p[0] - K(0.75), Z_o1 - 0.01]) square([K(1.4), 0.02]); }
            // Bock für die Hubzylinder (so breit wie der Ausleger)
            xz(-T_b / 2, T_b / 2) hull() { ci(CF_p, r_e); translate([CF_p[0] - r_e, Z_o1 - 0.01]) square([2 * r_e, 0.02]); }
            // Drehdurchführung über dem Königszapfen
            translate([0, 0, Z_o1 - 0.01]) cylinder(r = r_kp + max(M(0.15), 1.6), h = K(0.17), $fn = 40);
        }
        // Königszapfen
        translate([0, 0, Z_o0 - 1]) cylinder(r = r_kp + spiel, h = K(1), $fn = 40);   // durchgehend (keine Decke)
        hole_y(F_p, r_pr, -Y_lg - t_lg - 1, Y_lg + t_lg + 1);
        hole_y(CF_p, r_h, -T_b / 2 - 1, T_b / 2 + 1);
        for (p = kab_pins()) translate([p[0], p[1], Z_o0 - 1]) linear_extrude(Z_o1 - Z_o0 + 2) raute2(d_p + 2 * es);
        // Schlitze: Handläufe, Spiegel
        for (h = HL) for (u = [0, (L_hl - b_hl) / 2, L_hl - b_hl]) schlitz(h[0] + u + b_hl / 2, h[1], h[2], b_hl, t_hl);
        schlitz(SP[0][0], SP[0][1], SP[0][2], t_hl, b_hl);
        // Lüftungsgitter (senkrechte Schlitze) und Fuge des Gegengewichts
        let(n = 9, w = max(M(0.05), 0.6), dg = max(M(0.03), 0.4)) for (s = [-1, 1], i = [0 : n - 1])
            translate([X_mh - K(1.45) + i * K(0.14), s > 0 ? Y_o - dg : -Y_o - 1, Z_o1 + K(0.35)]) cube([w, dg + 1, K(0.7)]);
        let(dg = max(M(0.03), 0.4)) for (s = [-1, 1]) translate([X_h + K(0.95), s > 0 ? Y_o - dg : -Y_o - 1, Z_o1 - 1]) cube([max(M(0.03), 0.5), dg + 1, Z_mh]);
        // Türfuge rechts
        let(dg = max(M(0.03), 0.4)) for (x = [X_mh + K(0.7), X_mh + K(1.5)]) translate([x, -Y_o - 1, Z_o1 + K(0.1)]) cube([max(M(0.03), 0.5), dg + 1, Z_tk - Z_o1 - K(0.25)]);
    }
}
module oberwagen_druck(fp) translate([0, 0, -Z_o0]) oberwagen_welt(fp);

// Kabine (Welt; gedruckt kopfüber, Glaskern von unten)
module kab_aussen() hull() {
    translate([K_X[0], K_Y[0], K_Z[0]]) cube([K_X[1] - K_X[0], K_Y[1] - K_Y[0], K_Z[1] - K_Z[0] - c_kd]);
    translate([K_X[0] + c_kd, K_Y[0] + c_kd, K_Z[0]]) cube([K_X[1] - K_X[0] - 2 * c_kd, K_Y[1] - K_Y[0] - 2 * c_kd, K_Z[1] - K_Z[0]]);
}
module kab_raum(o) difference() {
    translate([K_X[0] + t_k - o, K_Y[0] + t_k - o, K_Z[0] - 1]) cube([K_X[1] - K_X[0] - 2 * t_k + 2 * o, K_Y[1] - K_Y[0] - 2 * t_k + 2 * o, K_Z[1] - K_Z[0] - t_kr + 1 + min(o, 0)]);
    for (p = kab_pins()) translate([p[0] - p_k / 2 - o, p[1] - p_k / 2 - o, K_Z[0] - 2]) cube([p_k + 2 * o, p_k + 2 * o, K_Z[1]]);
}
module kab_fenster() {
    xm = (K_X[0] + K_X[1]) / 2; w2 = max(M(0.08), 1.0); z1 = K_Z[1] - M(0.2);
    // vorne eine hohe Scheibe, hinten kurz, seitlich Tür- und Seitenscheibe
    translate([K_X[1] - t_k - 1, K_Y[0] + p_k, K_Z[0] + M(0.25)]) cube([t_k + 2, K_Y[1] - K_Y[0] - 2 * p_k, z1 - K_Z[0] - M(0.25)]);
    translate([K_X[0] - 1, K_Y[0] + p_k, K_Z[0] + M(1.0)]) cube([t_k + 2, K_Y[1] - K_Y[0] - 2 * p_k, z1 - K_Z[0] - M(1.0)]);
    for (y = [K_Y[0] - 1, K_Y[1] - t_k - 1]) for (xx = [[K_X[0] + p_k, xm - w2 / 2], [xm + w2 / 2, K_X[1] - p_k]])
        translate([xx[0], y, K_Z[0] + M(0.7)]) cube([xx[1] - xx[0], t_k + 2, z1 - K_Z[0] - M(0.7)]);
}
module kabine_welt(fp) {
    if (inc(fp, "A")) {
        difference() { kab_aussen(); kab_raum(0); kab_fenster(); schlitz(SP[1][0], SP[1][1], SP[1][2], t_hl, b_hl); }
        for (p = kab_pins()) translate([p[0], p[1], K_Z[0] + 0.01]) rotate([180, 0, 0]) rstift(d_p, Z_o1 - Z_o0 + 0.01);
    }
    if (inc(fp, "B")) intersection() { kab_raum(-es); translate([-K(5), 0, K_Z[0]]) cube([K(10), K(10), K_Z[1] - K_Z[0] - t_kr - es]); }
}
module kabine_druck(fp) translate([0, 0, K_Z[1]]) rotate([180, 0, 0]) kabine_welt(fp);

// =====================================================================
//  Ausleger und Stiel (zwei Hälften, flach gedruckt mit der Außenseite unten)
// =====================================================================
module ausleger_kern_2d() { hull() { ci([0, 0], K(0.32)); ci(K_p, K(0.5)); } hull() { ci(K_p, K(0.5)); ci(T_p, K(0.28)); } }
module ausleger_lasche_2d() hull() { ci(S1_p, r_e + max(M(0.03), 0.4)); ci(K_p + [-K(0.2), K(0.2)], K(0.3)); ci(K_p + [K(0.5), K(0.1)], K(0.3)); }
module ausleger_2d() { ausleger_kern_2d(); ausleger_lasche_2d(); }
// Gabel: Stielgelenk und die ganze Lasche des Stielzylinders oberhalb des Grundkörpers
module ausleger_gabel_2d() { ci(T_p, K(1.05)); difference() { offset(delta = 1) ausleger_lasche_2d(); ausleger_kern_2d(); } }
module ausleger_loecher_2d() { ci([0, 0], r_h); ci(A_p, r_h); ci(S1_p, r_pr); ci(T_p, r_pr); }
module stiel_kern_2d() { hull() { ci([0, 0], K(0.3)); ci(B_p, K(0.2)); } hull() { ci([0, 0], K(0.3)); ci([K(1.0), K(0.02)], K(0.28)); } }
module stiel_laschen_2d() {
    hull() { ci(R_p, r_e + max(M(0.03), 0.4)); ci([-K(0.05), K(0.02)], K(0.26)); }
    hull() { ci(C1_p, r_e + max(M(0.03), 0.4)); ci([K(0.3), K(0.12)], K(0.2)); ci([-K(0.05), K(0.12)], K(0.2)); }
}
module stiel_2d() { stiel_kern_2d(); stiel_laschen_2d(); }
module stiel_gabel_2d() difference() { offset(delta = 1) stiel_laschen_2d(); stiel_kern_2d(); }
module stiel_loecher_2d() { ci([0, 0], r_h); ci(B_p, r_h); ci(I_p, r_h); ci(R_p, r_pr); ci(C1_p, r_pr); }
// Hälfte im Druck: z = 0 Außenseite; n = 0 Ausleger, 1 Stiel
G_s = 2 * r_o + 2 * spiel;                   // Gabel im Stiel (Zylinderrohr passt hinein)
module haelfte(n) let(T = n == 0 ? T_b : T_s, G = n == 0 ? G_b : G_s, D = n == 0 ? DB : DS) difference() {
    union() {
        linear_extrude((T - G) / 2, convexity = 6) if (n == 0) ausleger_2d(); else stiel_2d();
        translate([0, 0, (T - G) / 2 - 0.01]) linear_extrude(G / 2 + 0.01, convexity = 6) difference() { if (n == 0) ausleger_2d(); else stiel_2d(); if (n == 0) ausleger_gabel_2d(); else stiel_gabel_2d(); }
    }
    translate([0, 0, -1]) linear_extrude(T) if (n == 0) ausleger_loecher_2d(); else stiel_loecher_2d();
    for (p = D) translate([K(p[0]), K(p[1]), T / 2 - d_dp(T)]) linear_extrude(d_dp(T) + 1) square(a_dw + 2 * es, center = true);
}
// lokal (u, v) in der Schwenkebene: links = +y
module haelfte_lokal(n, sy) let(T = n == 0 ? T_b : T_s)
    if (sy > 0) multmatrix([[1, 0, 0, 0], [0, 0, -1, T / 2], [0, 1, 0, 0], [0, 0, 0, 1]]) haelfte(n);
    else mirror([0, 1, 0]) multmatrix([[1, 0, 0, 0], [0, 0, -1, T / 2], [0, 1, 0, 0], [0, 0, 0, 1]]) haelfte(n);
module haelfte_druck(n, sy) if (sy > 0) haelfte(n); else mirror([0, 1, 0]) haelfte(n);
module duebel_lokal(n, i) let(T = n == 0 ? T_b : T_s, D = n == 0 ? DB : DS) translate([K(D[i][0]), 0, K(D[i][1])]) cube([a_dw, 2 * d_dp(T) - 0.4, a_dw], center = true);
function l_dw(n) = 2 * d_dp(n == 0 ? T_b : T_s) - 0.4;
module duebel_druck() for (n = [0, 1], i = [0, 1]) translate([(2 * n + i) * (a_dw + 3), 0, 0]) cube([a_dw, l_dw(n), a_dw]);

// =====================================================================
//  Löffel (lokal = Druck: Öffnung auf dem Bett, x_p = Breite)
// =====================================================================
LP = [[0, 0], [1.5, 0], [0.66, 1.02], [0.49, 1.02]];
module loeffel_2d() polygon([for (p = LP) KP(p)]);
module loeffel_ohr_2d() hull() { ci(KP(LB_m), r_e + max(M(0.03), 0.4)); ci(KP(LQ_m), r_e + max(M(0.03), 0.4)); polygon([KP([0.06, 0.12]), KP([0.49, 1.02]), KP([0.3, 0.5])]); }
// 2D (p, q) -> lokal x = p, z = q, Breite entlang y
module loeffel_lokal() translate([-K(LB_m[0]), 0, -K(LB_m[1])]) difference() {
    union() {
        difference() {
            xz(-W_l / 2, W_l / 2) loeffel_2d();
            xz(-W_l / 2 + t_bk, W_l / 2 - t_bk) { offset(delta = -t_bk) loeffel_2d(); translate([t_bk * 1.3, -1]) square([K(1.5) - t_bk * 3.2, t_bk + 1.5]); }
        }
        // Schneide und Zähne (liegen auf dem Bett)
        let(n = 5, w = W_l / (2 * n - 1)) for (i = [0 : n - 1]) translate([0, -W_l / 2 + 2 * i * w, 0]) xz(0, w) polygon([KP([1.42, 0]), KP([1.78, 0]), KP([1.36, 0.2])]);
        // Seitenschneiden
        for (s = [-1, 1]) xz(s > 0 ? W_l / 2 - t_bk : -W_l / 2, s > 0 ? W_l / 2 : -W_l / 2 + t_bk) polygon([KP([1.5, 0]), KP([1.62, 0]), KP([0.9, 0.78])]);
        // Lageraugen
        for (s = [-1, 1]) xz(s > 0 ? T_s / 2 + spiel : -T_s / 2 - spiel - t_ohr, s > 0 ? T_s / 2 + spiel + t_ohr : -T_s / 2 - spiel) loeffel_ohr_2d();
    }
    hole_y(KP(LB_m), r_pr, -W_l, W_l);
    hole_y(KP(LQ_m), r_h, -W_l, W_l);
}
module loeffel_druck() translate([K(LB_m[0]), 0, K(LB_m[1])]) loeffel_lokal();

// =====================================================================
//  Zylinder (lokal = Druck: Achse x ab dem Rohr-Auge, Augen flach auf dem Bett)
// =====================================================================
module rohr_2d() intersection() { hull() { translate([0, hz]) circle(r = r_o, $fn = 40); translate([-0.56 * r_o, 0]) square([1.12 * r_o, 0.01]); } translate([-r_o - 1, 0]) square([2 * r_o + 2, 2 * r_o + 2]); }
module stange_2d(o) intersection() { translate([0, hs]) circle(r = r_s + o, $fn = 32); translate([-r_s - o - 1, -o]) square([2 * (r_s + o) + 2, 2 * hs + 2 * o]); }
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
// zwischen zwei Punkten der Schwenkebene (P = Rohr-Auge, Q = Stangen-Auge), Mitte bei y = yc
module zyl_zw(P, Q, yc, fp, Z, pa, pb) let(L = norm(Q - P), d = (Q - P) / L) {
    if (inc(fp, "A")) multmatrix([[d[0], d[1], 0, P[0]], [0, 0, 1, yc - hz], [d[1], -d[0], 0, P[1]], [0, 0, 0, 1]]) zyl_rohr(Z, pa);
    if (inc(fp, "B")) multmatrix([[d[0], d[1], 0, P[0]], [0, 0, 1, yc - hs], [d[1], -d[0], 0, P[1]], [0, 0, 0, 1]]) zyl_stange(Z, L, pb);
}

// =====================================================================
//  Löffelgestänge, Handlauf, Spiegel (flach gedruckt)
// =====================================================================
Y_hb = T_s / 2 + spiel;                      // Umlenkhebel und Löffelaugen: innen
Y_kp = Y_hb + max(t_gs, t_ohr) + max(M(0.02), 0.3);   // Koppel: außen daneben
module lasche_2d(l, ra, rb) difference() { hull() { ci([0, 0], r_e + max(M(0.02), 0.3)); ci([l, 0], r_e + max(M(0.02), 0.3)); } ci([0, 0], ra); ci([l, 0], rb); }
module lasche_zw(P, Q, y0, t, ra, rb) let(d = (Q - P) / norm(Q - P))
    multmatrix([[d[0], -d[1], 0, P[0]], [0, 0, -1, y0 + t], [d[1], d[0], 0, P[1]], [0, 0, 0, 1]]) linear_extrude(t) lasche_2d(norm(Q - P), ra, rb);
module gestaenge_stiel(c, ex = 0) for (s = [-1, 1]) {
    translate([0, s * ex * 0.9, 0]) bunt(farbe_gelb) lasche_zw(I_p, J_st(c), s > 0 ? Y_hb : -Y_hb - t_gs, t_gs, r_pr, r_h);
    translate([0, s * ex * 1.3, 0]) bunt(farbe_gelb) lasche_zw(J_st(c), Q_st(c), s > 0 ? Y_kp : -Y_kp - t_gs, t_gs, r_pr, r_pr);
}
// Handlauf 2D (u entlang, v Höhe), Spiegel 2D (u nach außen, v Höhe); Zungen nach unten
L_hl = K(1.6);  H_hl = M(0.5);  b_hl = max(M(0.05), 0.9);  t_hl = max(M(0.05), 1.2);  l_tb = max(M(0.15), 1.8);
HL = [[X_mh + K(0.15), -Y_o + K(0.16), Z_tk], [X_h + K(1.3), Y_o - K(0.22), Z_mh]];   // [x0, y, z] rechts auf dem Tank, links auf dem Motorhaus
module handlauf_2d() {
    translate([0, H_hl - b_hl]) square([L_hl, b_hl]);
    for (u = [0, (L_hl - b_hl) / 2, L_hl - b_hl]) translate([u, -l_tb]) square([b_hl, H_hl + l_tb]);
}
module handlauf_welt(i) translate([HL[i][0], 0, HL[i][2]]) xz(HL[i][1] - t_hl / 2, HL[i][1] + t_hl / 2) handlauf_2d();
module spiegel_2d() {
    translate([-b_hl / 2, -l_tb]) square([b_hl, l_tb + M(0.28) + b_hl]);
    translate([-b_hl / 2, M(0.28)]) square([M(0.38), b_hl]);
    translate([M(0.3), M(0.06)]) square([max(M(0.16), 1.6), M(0.5)]);
}
SP = [[X_vo - K(0.3), -Y_o + K(0.14), Z_tk, -1], [K_X[1] - p_k / 2, K_Y[1] - p_k / 2, K_Z[1], 1]];   // [x, y, z, Seite]
module spiegel_welt(i) translate([SP[i][0], SP[i][1], SP[i][2]]) rotate(SP[i][3] > 0 ? 0 : 180) translate([-t_hl / 2, 0, 0]) rotate([90, 0, 90]) linear_extrude(t_hl) spiegel_2d();
module schlitz(x, y, z, lx, ly) translate([x - lx / 2 - es, y - ly / 2 - es, z - l_tb - 0.3]) cube([lx + 2 * es, ly + 2 * es, l_tb + 1.3]);

// =====================================================================
//  Zusammenbau
// =====================================================================
module in_ausleger(t) translate([F_p[0], 0, F_p[1]]) rotate([0, -t, 0]) children();
module in_stiel(p) translate([T_p[0], 0, T_p[1]]) rotate([0, -p, 0]) children();
module in_loeffel(c) translate([B_p[0], 0, B_p[1]]) rotate([0, -c, 0]) children();
module ausruestung(t, p, c, ex = 0) {
    in_ausleger(t) {
        for (s = [-1, 1]) translate([0, s * ex * 0.5, 0]) bunt(farbe_gelb) haelfte_lokal(0, s);
        if (ex > 0) for (i = [0, 1]) bunt(farbe_gelb) duebel_lokal(0, i);
        bunt(farbe_zylinder) zyl_zw(S1_p, T_p + rot2(R_p, p), 0, "A", ZS, false, false);
        bunt(farbe_stange) zyl_zw(S1_p, T_p + rot2(R_p, p), 0, "B", ZS, false, false);
        translate([ex * 0.8, 0, 0]) in_stiel(p) {
            for (s = [-1, 1]) translate([0, s * ex * 0.5, 0]) bunt(farbe_gelb) haelfte_lokal(1, s);
            if (ex > 0) for (i = [0, 1]) bunt(farbe_gelb) duebel_lokal(1, i);
            bunt(farbe_zylinder) zyl_zw(C1_p, J_st(c), 0, "A", ZL, false, false);
            bunt(farbe_stange) zyl_zw(C1_p, J_st(c), 0, "B", ZL, false, false);
            gestaenge_stiel(c, ex);
            translate([ex * 0.8, 0, 0]) in_loeffel(c) bunt(farbe_loeffel) loeffel_lokal();
        }
    }
    // Hubzylinder (Welt)
    for (s = [-1, 1]) translate([0, s * ex * 1.2, 0]) {
        bunt(farbe_zylinder) zyl_zw(CF_p, F_p + rot2(A_p, t), s * Y_hz, "A", ZH, true, true);
        bunt(farbe_stange) zyl_zw(CF_p, F_p + rot2(A_p, t), s * Y_hz, "B", ZH, true, true);
    }
}
module kettenbagger(ex = 0) {
    bunt(farbe_unterwagen) unterwagen_welt();
    for (s = [-1, 1]) translate([0, s * ex, 0]) bunt(farbe_kette) kette_welt(s);
    translate([0, 0, ex]) rotate(ex > 0 ? 0 : drehung) {
        bunt(farbe_gelb) oberwagen_welt("A"); bunt(farbe_band) oberwagen_welt("B");
        for (i = [0, 1]) translate([0, 0, ex * 0.7]) { bunt(farbe_anbau) handlauf_welt(i); translate([0, 0, i * ex * 0.8]) bunt(farbe_anbau) spiegel_welt(i); }
        translate([0, 0, ex * 0.8]) { bunt(farbe_kabine) kabine_welt("A"); translate([0, 0, -ex * 0.4]) bunt(farbe_glas) kabine_welt("B"); }
        translate([ex * 0.8, 0, ex * 0.6]) ausruestung(ex > 0 ? 28 : ausleger_winkel, ex > 0 ? -100 : stiel_winkel, ex > 0 ? -25 : loeffel_winkel, ex);
    }
}

// =====================================================================
//  Info und Ausgabe
// =====================================================================
L_ausl = T_p[0] + K(0.32) + K(0.28);
BOLZ = [["Auslegerfuß", 2 * (Y_lg + t_lg)], ["Hubzylinder unten", 2 * (Y_hz + hz)], ["Hubzylinder oben", 2 * (Y_hz + hs)], ["Stielzylinder am Ausleger", T_b],
        ["Stielgelenk", T_b], ["Stielzylinder am Stiel", T_s], ["Löffelzylinder am Stiel", T_s], ["Löffelgelenk", 2 * (Y_hb + t_ohr)], ["Umlenkhebel am Stiel", 2 * (Y_hb + t_gs)], ["Gelenk Hebel/Koppel/Stange", 2 * (Y_kp + t_gs)], ["Koppel am Löffel", 2 * (Y_kp + t_gs)]];
echo(str("Kettenbagger 1:", den, " | Laufwerk ", r2(2 * (c_k + r_k)), " x ", r2(2 * (Y_k0 + B_k)), " mm | Oberwagen ", r2(X_vo - X_h), " x ", r2(2 * Y_o), " mm, Kabine ", r2(K_Z[1]), " mm hoch | Ausleger ", r2(L_ausl), " mm, Stiel ", r2(B_p[0] + K(1.2)), " mm"));
echo(str("Ausleger ", r2(T_b), " mm dick (Gabel ", r2(G_b), "), Stiel ", r2(T_s), " mm (Gabel ", r2(G_s), ") | Zylinder: Rohr Ø ", r2(2 * r_o), ", Stange Ø ", r2(2 * r_s), ", Auge Ø ", r2(2 * r_e), " mm"));
echo(str("Hubzylinder ", r2(ZH[0]), "–", r2(ZH[1]), " mm (Überdeckung ", r2(ov(ZH)), ") | Stielzylinder ", r2(ZS[0]), "–", r2(ZS[1]), " (", r2(ov(ZS)), ") | Löffelzylinder ", r2(ZL[0]), "–", r2(ZL[1]), " (", r2(ov(ZL)), ") | min ", r2(ov_min)));
echo(str("Filament-Bolzen Ø ", stift_d, ": ", [for (b = BOLZ) str(b[0], " ", r2(b[1]), " mm")]));
if (min(ov(ZH), ov(ZS), ov(ZL)) < ov_min) echo("WARNUNG: Kolbenstange zu kurz für den Schwenkbereich");
if ((T_s - G_s) / 2 < 0.8) echo("WARNUNG: Gabelwangen im Stiel zu dünn");
if (Y_hz + hz > K_Y[0] - 0.3 && CF_p[0] - r_e < K_X[1] + 0.3) echo("WARNUNG: Hubzylinder streift die Kabine");
if (L_ausl > usable || X_vo - X_h > usable) echo("WARNUNG: Ausleger/Oberwagen größer als das Druckbett");
mass_echo(2 * (c_k + r_k), 2 * (Y_k0 + B_k), K_Z[1]);

druck("unterwagen", 1, "alle", farbe_unterwagen, 1);
druck("kette", 1, "alle", farbe_kette, 2);
druck("oberwagen", 1, "A", farbe_gelb, 1); druck("oberwagen", 1, "B", farbe_band, 1);
druck("kabine", 1, "A", farbe_kabine, 1); druck("kabine", 1, "B", farbe_glas, 1);
for (t = ["ausleger_links", "ausleger_rechts", "stiel_links", "stiel_rechts"]) druck(t, 1, "alle", farbe_gelb, 1);
druck("duebel", 1, "alle", farbe_gelb, 1);
druck("loeffel", 1, "alle", farbe_loeffel, 1);
druck("zylinder_ausleger", 1, "A", farbe_zylinder, 2); druck("zylinder_ausleger", 1, "B", farbe_stange, 2);
druck("zylinder_stiel", 1, "A", farbe_zylinder, 1); druck("zylinder_stiel", 1, "B", farbe_stange, 1);
druck("zylinder_loeffel", 1, "A", farbe_zylinder, 1); druck("zylinder_loeffel", 1, "B", farbe_stange, 1);
druck("umlenkhebel", 1, "alle", farbe_gelb, 2);
druck("koppel", 1, "alle", farbe_gelb, 2);
druck("handlauf", 1, "alle", farbe_anbau, 2);
druck("spiegel", 1, "alle", farbe_anbau, 2);
farben_echo();

if (teil == "aufbau") kettenbagger();
else if (teil == "explosion") kettenbagger(max(M(1.6), 12));
else if (teil == "unterwagen") unterwagen_druck();
else if (teil == "kette") kette_druck();
else if (teil == "oberwagen") oberwagen_druck(farbteil);
else if (teil == "kabine") kabine_druck(farbteil);
else if (teil == "ausleger_links") haelfte_druck(0, 1);
else if (teil == "ausleger_rechts") haelfte_druck(0, -1);
else if (teil == "stiel_links") translate([-R_p[0] + r_e + 1, 0, 0]) haelfte_druck(1, 1);
else if (teil == "stiel_rechts") translate([-R_p[0] + r_e + 1, 0, 0]) haelfte_druck(1, -1);
else if (teil == "duebel") duebel_druck();
else if (teil == "loeffel") loeffel_druck();
else if (teil == "zylinder_ausleger") zylinder_druck(farbteil, ZH, true, true);
else if (teil == "zylinder_stiel") zylinder_druck(farbteil, ZS, false, false);
else if (teil == "zylinder_loeffel") zylinder_druck(farbteil, ZL, false, false);
else if (teil == "umlenkhebel") linear_extrude(t_gs) lasche_2d(l_hb, r_pr, r_h);
else if (teil == "koppel") linear_extrude(t_gs) lasche_2d(l_kp, r_pr, r_pr);
else if (teil == "handlauf") translate([0, l_tb, 0]) linear_extrude(t_hl) handlauf_2d();
else if (teil == "spiegel") translate([b_hl, l_tb, 0]) linear_extrude(t_hl) spiegel_2d();
