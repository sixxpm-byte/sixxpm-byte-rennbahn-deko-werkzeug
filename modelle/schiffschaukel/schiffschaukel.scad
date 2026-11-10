// =====================================================================
//  SCHIFFSCHAUKEL  –  Piratenschiff-Schaukel (Pendelfahrgeschäft) als Bausatz
//  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei), Farben je Bauteil,
//  Maßstab 1:43 / 1:87.  Das Schiff pendelt wirklich (Schwingarme auf Achszapfen).
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    bodenplatte     Bodenplatte mit Schlitzen für Böcke und Zaun (1:43 geteilt, Clips)
//    abock           A-Bock: zwei Stützen, Querriegel, Leiter, Lagerkopf (flach)     2x
//    plattform       Wartungsplattform mit Brüstung und Antrieb, auf dem Lagerkopf  2x
//    achszapfen      Vierkant-Achszapfen (flach gedruckt), Drehachse des Schiffs     2x
//    arm             Schwingarm (Fachwerk, flach), Nabe dreht auf dem Achszapfen    2x
//    rumpf           Rumpfkern mit Sitzreihen (Spanten; beim Druck auf der Seite
//                    stehend, 1:43 in der Mitte geteilt)                          1x
//    bordwand        Bordwand mit Planken, Zierleiste (B) und Sitzfeldern, beidseitig
//                    gleich (1:43 zweiteilig)                                     2x
//    duebel_lang / duebel_kurz  Vierkant-Dübel: Arm – Bordwand – Rumpf – Bordwand – Arm
//    grossmast / mast  Masten mit Rahen, Wanten, Segeln (B) und Flagge (C, Großmast)
//    bugspriet       Bugspriet mit Galionsfigur (flach)                            1x
//    zaun_vorne / zaun_hinten / zaun_seite / tor   Lattenzaun mit Ausgangstor (flach)
//    rampe           Einstiegsrampe mit Podest und Steg unter dem Schwingarm bis an die
//                    Bordwand, Geländer angeformt (auf der Seite liegend gedruckt)  2x
//    laterne / laternenkopf   Laternensäule mit Steinsockel und fünfarmigem Kopf
//    haus_*          Kassenhäuschen (Bibliothek deko_kasse)
//    verbinder       Clips für die geteilte Bodenplatte
//
//  BEWEGLICH
//    Die Schwingarme drehen sich auf den Achszapfen in den Lagerköpfen der A-Böcke;
//    das Schiff pendelt.  Arretierung: Rastbogen am Arm mit 3 oder 5 Löchern (Stellungen),
//    ein Stück Filament (Ø stift_d) durch das Loch im Knotenblech des A-Bocks sichert die Stellung.  Der Kiel ist ein Kreisbogen um die Drehachse – das Schiff
//    streift in keiner Stellung den Boden.
//  STECKSYSTEM
//    Dübel durch Arme, Bordwände und Rumpf halten das Schiff zusammen; Böcke, Zaun,
//    Masten, Bugspriet: Zungen in Schlitze; Plattform und Laternenkopf auf Zapfen.
//  DRUCK
//    Alles stützfrei: Rumpfkern auf der Seite stehend (alle Formen senkrecht), Böcke,
//    Arme, Bordwände, Masten, Zaun flach, Plattform, Laterne und Bodenplatte aufrecht.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, bodenplatte:Bodenplatte, abock:A-Bock (2x), plattform:Plattform (2x), achszapfen:Achszapfen (2x), arm:Schwingarm (2x), rumpf:Rumpfkern, bordwand:Bordwand (2x), duebel_lang:Dübel lang, duebel_kurz:Dübel kurz, duebel_mitte:Dübel Rumpfmitte (1:43), grossmast:Großmast, mast:Fock-/Besanmast (2x), bugspriet:Bugspriet, zaun_vorne:Zaun vorne (2x), zaun_hinten:Zaun hinten (2x), zaun_seite:Zaun Seite (2x), tor:Ausgangstor, laterne:Laternensäule, laternenkopf:Laternenkopf, rampe:Einstiegsrampe (2x), haus_boden:Kassenhaus Boden, haus_wand_vorne:Kassenhaus Wand vorne, haus_wand_hinten:Kassenhaus Wand hinten, haus_wand_links:Kassenhaus Wand links, haus_wand_rechts:Kassenhaus Wand rechts, haus_dach:Kassenhaus Dach, haus_schild:Kassenhaus Schild, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
farbteil = "alle"; // [alle, A, B, C]

/* [Vorschau] */
// Stellung des Schiffs in der Vorschau (Raststufe, 0 = unten)
schaukel_stufe = 2; // [-2:1:2]
kassenhaus_zeigen = true;

/* [Schiffschaukel (Vorbild in Metern)] */
achs_hoehe_m = 8.0;
schiff_laenge_m = 10.0;
schiff_breite_m = 2.9;
// Kielbogen (Abstand Drehachse - Kiel)
kiel_radius_m = 6.7;
// Bordwand-Oberkante (Bogen um die Drehachse)
bord_radius_m = 5.25;
reihen = 4; // [3:1:5]
bock_spreizung_m = 4.2;
// Raststellungen des Schiffs (Filament-Stift) und Winkel je Stufe
positionen = 5; // [3, 5]
winkel_schritt = 20; // [15:5:25]
stift_d = 1.75;
// Einstiegsrampen: Höhe des Stegs, Breite
rampe_hoehe_m = 1.1;
rampe_breite_m = 1.0;

/* [Kassenhäuschen] */
haus_stil = "holz"; // [flightcase, holz]
haus_breite_m = 2.4;
haus_tiefe_m  = 1.8;
haus_hoehe_m  = 2.3;
tuer = "links"; // [links, rechts]
schild_text = "PIRATENSCHIFF";
kasse_text  = "KASSE";
schild_font = "Liberation Sans:style=Bold";

/* [Farben] */
farbe_gestell   = "olivgrau";  // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_rumpf     = "braun";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_sitze     = "holz";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_zierleiste = "rot";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_mast      = "braun";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_segel     = "creme";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_flagge    = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_boden     = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_zaun      = "rot";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_stein     = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_laterne   = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_rampe     = "olivgrau";  // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_haus_boden  = "grau";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_haus_wand   = "holz";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_haus_kanten = "braun";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_haus_dach   = "rot";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_schild_A    = "creme";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]
farbe_schild_B    = "braun";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, catgelb, olivgrau]

/* [Druck & Passung] */
rennbahn_taschen = true;   // Clip-Taschen an den Seiten der Bodenplatte
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;
// Luft je Seite für Zungen, Dübel und Zapfen (0 = sehr stramm)
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
//  Maße (Welt: x Schiffslängsachse (Bug +x), y = Drehachse, z = 0 Boden; mm)
// =====================================================================
function K(m) = m * 1000 / den;
es    = einsatz_spiel;
t_bp  = max(M(0.25), 2.4);                  // Bodenplatte
H     = K(achs_hoehe_m) + t_bp;             // Drehachse über dem Tisch
XS    = K(schiff_laenge_m / 2);
Bs    = K(schiff_breite_m);
Rk    = K(kiel_radius_m);
Rg    = K(bord_radius_m);
Rf    = Rk - K(0.5);                        // Sitzboden
function zb(R, x) = H - sqrt(R * R - x * x);
X_e0  = XS - K(0.5);                        // Steven: unten
n_r   = reihen;
p_r   = K(0.9);  c0 = K(0.45);
function a_r(k) = c0 + k * p_r;
X_re  = a_r(n_r);                           // Ende der Sitzreihen
// Rumpf
t_w   = max(M(0.12), 1.6);                  // Bordwand
d_rl  = max(M(0.03), 0.4);                  // Relief der Bordwand
B_i   = Bs - 2 * t_w;                       // Rumpfkern
w_c   = max(M(0.12), 1.6);                  // Schale des Kerns
d_dw  = max(M(0.2), 2.4);                   // Dübel (Diagonale)
w_rb  = max(M(0.25), d_dw + 2 * min_wand);  // Spant mit Dübel
X_DW  = concat([for (k = [1 : 2 : n_r]) a_r(k)], n_r % 2 == 0 ? [a_r(n_r)] : []);   // Dübel-Spanten (ungerade Reihen + Ende)
X_DA  = [for (k = [1 : 2 : n_r - 1]) a_r(k)];   // davon mit Schwingarm
function z_dw(x) = (zb(Rk, x) + min(z_sitz(x), zb(Rg, x) - K(0.4))) / 2;
function z_sitz(x) = let(k = floor((abs(x) - c0) / p_r)) abs(x) < c0 ? zb(Rf, 0) : k >= n_r ? zb(Rg, abs(x)) - K(0.35) : zb(Rf, a_r(k));
// Arme
t_a   = max(M(0.15), 2.0);
g_y   = max(M(0.05), 0.6);
Y_a0  = Bs / 2 + d_rl + g_y;               // Arm innen
d_az  = max(M(0.35), 3.4);                  // Achszapfen (Diagonale)
r_hb  = max(M(0.5), d_az / 2 + 2.4);       // Nabe
w_ar  = max(M(0.35), 3.0);                  // Armprofil
// A-Bock
t_A   = max(M(0.35), 3.0);
Y_A0  = Y_a0 + t_a + g_y;
X_bk  = K(bock_spreizung_m);
w_l   = max(M(0.45), 3.0);                  // Stütze
r_lk  = max(M(0.5), d_az / 2 + 3);        // Lagerkopf
l_tb  = max(M(0.2), 2.0);                   // Zungen
// Plattform
P_x   = K(2.2);  P_y = max(K(1.6), t_A + 6);  t_pl = max(M(0.15), 1.6);
Z_pl  = H + r_lk + l_tb * 0;               // Unterkante Plattform
h_br  = M(1.0);  t_br = max(M(0.06), 0.8);
// Achszapfen-Länge: durch den Bock und die Nabe
l_az  = t_A + g_y + t_a;
// Arretierung
r_h   = (stift_d + 0.25) / 2;
POS   = positionen == 3 ? [-1, 0, 1] : [-2, -1, 0, 1, 2];
a_max = max(POS) * winkel_schritt;
r_ix  = max(M(0.85), (2 * r_h + 1.2) / (winkel_schritt * PI / 180), r_lk + 0.6);   // Lochkreis
r_rb  = r_ix + r_h + max(M(0.08), 1.2);     // Rastbogen außen
l_st  = t_A + g_y + t_a;                    // Arretier-Stift
schaukel_winkel = max(min(schaukel_stufe, max(POS)), min(POS)) * winkel_schritt;
// Einstiegsrampen (Steuerbord; Backbord um z gedreht)
Z_r   = K(rampe_hoehe_m) + t_bp;             // Stegoberkante
W_r   = K(rampe_breite_m);
Y_r0  = Y_A0 + t_A + g_y;                    // Podest innen (außerhalb des Bocks)
Y_r1  = Y_r0 + W_r;
Y_rs  = Bs / 2 + d_rl + g_y;                 // Steg endet an der Bordwand
X_rp  = [-K(1.6), K(1.6)];                   // Podest/Steg
X_rr  = K(4.3);                              // Rampenfuß
t_rp  = max(M(0.1), 1.6);                    // Belag/Schale
H_rg  = M(1.0);  b_rg = max(M(0.05), 0.8);  t_rg = max(M(0.05), 1.2);
// Bodenplatte
XP    = X_bk + K(0.5);
YP    = Y_A0 + t_A + g_y + K(rampe_breite_m) + K(0.45);
split = 2 * XP > usable;                   // Bodenplatte geteilt
split_r = 2 * XS + K(0.2) > usable;          // Rumpfkern geteilt
// Zaun
H_z   = M(1.0);  t_z = max(M(0.05), 1.2);  b_zl = max(M(0.08), 0.8);  p_zl = M(0.16);
X_tor = K(0.7);
m_z   = K(0.15);                            // Abstand vom Plattenrand
// Masten
t_m   = max(M(0.06), 1.2);
w_m   = max(M(0.12), 1.2);                  // Mast
w_y   = max(M(0.07), 0.8);                  // Rahen, Wanten
t_sg  = max(M(0.03), 0.6);                  // Segel (Inlay unten)
MASTEN = [  // [x, Höhe über Fuß, Rah-Halbbreite, Großmast?]
    [0, K(5.0), min(K(1.2), B_i / 2 * 0.95), true],
    [a_r(2) + K(0.775), K(3.8), B_i / 2 * 0.8, false],
    [-(a_r(2) + K(0.775)), K(3.8), B_i / 2 * 0.8, false]];
function mast_fuss(x) = abs(x) < c0 ? zb(Rf, 0) : z_sitz(x) + K(1.05);

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
//  deko_kasse.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Kassenhäuschen (Maße + Module + info_*). Erwartet im Modell die Parameter
//  haus_stil, haus_breite_m, haus_tiefe_m, haus_hoehe_m, tuer, schild_text, kasse_text,
//  schild_font, rennbahn_taschen und die Farben farbe_haus_*, farbe_schild_A/B, farbteil.
//  INFOS/DRUCK/Dispatch: siehe doku/KONVENTIONEN.md (Abschnitt Kasse).
// =====================================================================
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
h_rf = haus_stil == "flightcase" ? sc(250, 2) : sc(700, 4);
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
module wand_local(k, fp = "alle") {
    L = wlen(k);
    if (inc(fp, "A")) difference() {
        union() {
            cube([L, H_h, t_h]);
            translate([0, -(g_h - spiel), 0]) cube([L, g_h - spiel + e, t_h]);
            translate([0, H_h - e, 0]) cube([L, g_h - spiel + e, t_h]);
        }
        trim = (k == "vorne" || k == "hinten") ? fwid * 1.3 + f_gw : 0;
        if (haus_stil != "flightcase") for (j = [1 : 1 : floor(L / f_pitch - 0.01)]) if (j * f_pitch > trim && j * f_pitch < L - trim)
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
    if (inc(fp, "B")) {
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
    if (haus_stil == "flightcase") {   // Alu-Kanten, Eckschoner, Verschlüsse
        fw2 = max(sc(80), 1.0); ec = max(sc(250), 2.5); vh = sc(120, 1.2);
        raised(0, 0, L, fw2, dm * 2); raised(0, H_h - fw2, L, H_h, dm * 2);
        raised(0, 0, fw2, H_h, dm * 2); raised(L - fw2, 0, L, H_h, dm * 2);
        for (u = [0, L - ec], v = [0, H_h - ec]) raised(u, v, u + ec, v + ec, dm * 3.5);
        if (k == "links" || k == "rechts" || k == "hinten") for (u = [L * 0.25, L * 0.75 - sc(250, 2.5)]) if (k != tuer_wand || u + sc(250, 2.5) < du0 || u > du0 + dw_h)
            raised(u, H_h * 0.62, u + sc(250, 2.5), H_h * 0.62 + vh, dm * 3);
    }
    }
}
module wand_welt(k, fp = "alle") {
    if (k == "vorne")       translate([0, t_h, hb_h]) rotate([90, 0, 0]) wand_local(k, fp);
    else if (k == "hinten") translate([W_h, D_h - t_h, hb_h]) rotate([90, 0, 180]) wand_local(k, fp);
    else if (k == "links")  translate([t_h, D_h - t_h, hb_h]) rotate([90, 0, -90]) wand_local(k, fp);
    else                    translate([W_h - t_h, t_h, hb_h]) rotate([90, 0, 90]) wand_local(k, fp);
}
module wand_druck(k, fp = "alle") translate([0, g_h, 0]) wand_local(k, fp);
function info_wand(k) = let(L = wlen(k), SY = H_h + 2 * g_h,
    kp = concat([for (o = openings(k)) [o[0] - 1, o[1] + g_h - 1, o[2] + 1, o[3] + g_h + 1]],
                [[-1, -1, L + 1, g_h + 1.5], [-1, H_h + g_h - 1.5, L + 1, SY + 1]]))
    [L, SY, seams_at(L, [], mw), seams_at(SY, [], mw), kp, false, 0, []];

z_rh = hb_h + H_h;                                // Dachunterseite
rk_e = max(sc(200), 2);
module kugelecken() for (x = [-ov_h + rk_e * 1.2, W_h + ov_h - rk_e * 1.2], y = [-ov_h + rk_e * 1.2, D_h + ov_h - rk_e * 1.2]) translate([x, y, z_rh + rt_h]) sphere(r = rk_e, $fn = 20);
module haus_dach(fp = "alle") {   // aufrecht gedruckt (Unterseite auf dem Bett)
    if (inc(fp, "B") && haus_stil == "flightcase") intersection() { kugelecken(); translate([-ov_h - 1, -ov_h - 1, z_rh + 0.6]) cube([RXh + 2, RYh + 2, rt_h + h_rf + 5]); }
    if (inc(fp, "A")) difference() {
        union() {
            translate([-ov_h, -ov_h, z_rh]) cube([RXh, RYh, rt_h]);
            hull() {
                translate([-ov_h, -ov_h, z_rh + rt_h - e]) cube([RXh, RYh, e]);
                translate([W_h / 2 - PXh / 2, D_h / 2 - PYh / 2, z_rh + rt_h + h_rf - e]) cube([PXh, PYh, e]);
            }
        }
        translate([0, 0, z_rh - e]) linear_extrude(g_h + e) ring_2d();
        if (haus_stil == "flightcase") intersection() { kugelecken(); translate([-ov_h - 1, -ov_h - 1, z_rh + 0.6]) cube([RXh + 2, RYh + 2, rt_h + h_rf + 5]); }
        for (x = spx) translate([W_h / 2 - sw_h / 2 + x - pw_h / 2 - spiel, D_h / 2 - st_h / 2 - spiel, z_rh + rt_h + h_rf - pl_h - 0.2])
            cube([pw_h + 2 * spiel, st_h + 2 * spiel, pl_h + 1]);
        // Traufkante
        tk = max(sc(40), 0.4);
        translate([-ov_h - 1, -ov_h - 1, z_rh + rt_h * 0.5]) difference() {   // Kerbe mit 45°-Oberseite (stützfrei)
            cube([RXh + 2, RYh + 2, tk]);
            hull() { translate([1 + tk, 1 + tk, -0.01]) cube([RXh - 2 * tk, RYh - 2 * tk, 0.02]); translate([1, 1, tk]) cube([RXh, RYh, 0.01]); }
        }
    }
}
module haus_dach_druck(fp = "alle") translate([ov_h, ov_h, -z_rh]) haus_dach(fp);
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
    for (k = ["vorne", "hinten", "links", "rechts"]) translate([0, 0, ex]) { color(fhex(farbe_haus_wand)) wand_welt(k, "A"); color(fhex(farbe_haus_kanten)) wand_welt(k, "B"); }
    translate([0, 0, 2 * ex]) { color(fhex(farbe_haus_dach)) haus_dach("A"); color(fhex(farbe_haus_kanten)) haus_dach("B"); }
    translate([0, 0, 3 * ex]) { if (inc(farbteil, "A")) color(fhex(farbe_schild_A)) schild_welt("A"); if (inc(farbteil, "B")) color(fhex(farbe_schild_B)) schild_welt("B"); }
}

// =====================================================================
//  Hilfen
// =====================================================================
module raute2(d) rotate(45) square(d / sqrt(2), center = true);
module yz(x0, x1) translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0, convexity = 6) children();
module xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 6) children();
module bunt(f) color(fhex(f)) render(convexity = 6) children();
module schwing(a) translate([0, 0, H]) rotate([0, a, 0]) translate([0, 0, -H]) children();
function arc_pts(R, x0, x1, n = 24) = [for (i = [0 : n]) let(x = x0 + (x1 - x0) * i / n) [x, zb(R, x)]];
// Druck flacher Teile: Ebene x-z, Seite y = y0 aufs Bett (Teil liegt bei y >= y0)
module xz_druck0(y0) multmatrix([[1, 0, 0, 0], [0, 0, -1, 0], [0, 1, 0, -y0], [0, 0, 0, 1]]) children();
// Ebene x-z, Seite y = y1 aufs Bett (Teil liegt bei y <= y1)
module xz_druck(y1) multmatrix([[1, 0, 0, 0], [0, 0, 1, 0], [0, -1, 0, y1], [0, 0, 0, 1]]) children();
// Ebene y-z, Seite x = x0 aufs Bett (Teil bei x >= x0)
module yz_druck0(x0) multmatrix([[0, 1, 0, 0], [0, 0, -1, 0], [1, 0, 0, -x0], [0, 0, 0, 1]]) children();

// =====================================================================
//  Rumpf
// =====================================================================
// Außenkontur (x-z) – Kiel- und Bordbogen, schräge Steven
module rumpf_umriss_2d() polygon(concat(arc_pts(Rk, -X_e0, X_e0), [[XS, zb(Rg, XS)]], arc_pts(Rg, XS, -XS), [[-XS, zb(Rg, XS)]]));
// Oberseite des Kerns: Mittelgang, Sitzreihen (Fußraum, Bank, Lehne), Back/Achterdeck
function reihe_pts(s) = [for (k = [0 : n_r - 1]) let(a = a_r(k), f = zb(Rf, a)) each
    [[s * a, f], [s * (a + K(0.3)), f], [s * (a + K(0.3)), f + K(0.45)], [s * (a + K(0.65)), f + K(0.45)], [s * (a + K(0.65)), f + K(1.05)], [s * (a + p_r), f + K(1.05)]]];
module kern_2d() let(zd = zb(Rg, X_re) - K(0.35))
    intersection() {
        rumpf_umriss_2d();
        polygon(concat([[-XS - 5, -1], [-XS - 5, zd]], [[-X_re, zd]], [for (p = [for (i = [len(reihe_pts(-1)) - 1 : -1 : 0]) reihe_pts(-1)[i]]) p],
                       [[-c0, zb(Rf, 0)], [c0, zb(Rf, 0)]], reihe_pts(1), [[X_re, zd], [XS + 5, zd], [XS + 5, -1]]));
    }
// Spantgerüst: Schale + Spanten (Öffnungen gehen quer durch, werden von den Bordwänden verdeckt)
module kern_gitter_2d() difference() {
    kern_2d();
    difference() {
        offset(delta = -w_c) kern_2d();
        for (k = [0 : n_r]) for (s = [-1, 1]) let(x = s * a_r(k)) translate([x - (len([for (d = X_DW) if (abs(abs(x) - d) < 0.01) 1]) > 0 ? w_rb : w_c) / 2, -1]) square([len([for (d = X_DW) if (abs(abs(x) - d) < 0.01) 1]) > 0 ? w_rb : w_c, 2 * H]);
        translate([-c0, -1]) square([2 * c0, 2 * H]);       // Mittelblock (Großmast, Teilung)
    }
}
module rumpfkern(stk = 0) difference() {
    xz(-B_i / 2, B_i / 2) kern_gitter_2d();
    // Dübelkanäle quer (y)
    for (s = [-1, 1], x = X_DW) translate([s * x, 0, z_dw(x)]) rotate([90, 0, 0]) linear_extrude(B_i + 2, center = true) raute2(d_dw + 2 * es);
    // Teilungsdübel (längs, nur bei geteiltem Kern)
    if (split_r) for (y = [-B_i / 4, B_i / 4]) translate([-c0 - 1, y, (zb(Rk, 0) + zb(Rf, 0)) / 2]) rotate([0, 90, 0]) linear_extrude(2 * c0 + 2) raute2(d_dw + 2 * es);
    // Schlitze für Masten und Bugspriet
    for (m = MASTEN) translate([m[0] - t_m / 2 - es, -w_m / 2 - es, mast_fuss(m[0]) - l_tb - 0.3]) cube([t_m + 2 * es, w_m + 2 * es, l_tb + 1.3]);
    translate([XS - K(0.9), -t_m / 2 - es, zb(Rg, X_re) - K(0.35) - l_tb - 0.3]) cube([K(0.5), t_m + 2 * es, l_tb + 1.3]);
}
module rumpf_teil(stk) intersection() { rumpfkern(); translate([stk == 1 ? -XS - 10 : 0, -Bs, 0]) cube([XS + 10, 2 * Bs, 2 * H]); }
// Druck: auf der Backbordseite stehend (alle Formen senkrecht)
module rumpf_druck(stk) let(n = split_r ? (stk == 0 ? [1, 2] : [stk]) : [0])
    for (i = n) translate([i == 2 ? 10 : 0, 0, 0]) xz_druck0(-B_i / 2) if (i == 0) rumpfkern(); else rumpf_teil(i);

// Bordwand (Welt, Steuerbord, y = Bs/2 - t_w .. Bs/2 + Relief); Backbord = um z gedreht
x_bw = K(1.8);                               // Teilung der Bordwand (1:43)
module bordwand_2d() union() {
    rumpf_umriss_2d();
    // Steven mit Schnecke (Bug und Heck gleich)
    for (s = [-1, 1]) let(z0 = zb(Rg, XS)) translate([s * XS, z0]) {
        hull() { translate([s > 0 ? -K(0.6) : 0, -K(1.8)]) square([K(0.6), K(1.8)]); translate([s * K(0.05), K(0.7)]) circle(d = K(0.3), $fn = 16); }
        translate([s * K(0.05), K(0.7)]) difference() { circle(d = K(0.6), $fn = 24); circle(d = K(0.3), $fn = 16); translate([s > 0 ? -K(0.6) : 0, -K(0.6)]) square([K(0.6), K(0.6)]); }
    }
}
module bordwand_relief_2d() {
    // Plankengänge (Fugen werden ausgespart), Sitzfelder mit Nieten
    for (k = [0 : n_r - 1], s = [-1, 1]) let(a = a_r(k), x0 = s > 0 ? a + K(0.08) : -a - p_r + K(0.08), z0 = zb(Rk, a + p_r) + K(0.35), z1 = zb(Rg, a) - K(0.45))
        if (z1 - z0 > K(0.4)) translate([x0, z0]) difference() {
            square([p_r - K(0.16), z1 - z0]);
            for (i = [1 : 2], j = [1 : 3]) translate([(p_r - K(0.16)) * i / 3, (z1 - z0) * j / 4]) circle(d = max(M(0.1), 0.8), $fn = 10);
        }
}
module zierleiste_2d() difference() { offset(delta = 0) intersection() { rumpf_umriss_2d(); polygon(concat(arc_pts(Rg + K(0.15), -X_e0, X_e0), [for (p = arc_pts(Rg + K(0.32), X_e0, -X_e0)) p])); } }
module bordwand_welt(fp = "alle") let(y0 = Bs / 2 - t_w) {
    if (inc(fp, "A")) difference() {
        union() { xz(y0, Bs / 2) bordwand_2d(); xz(Bs / 2 - 0.01, Bs / 2 + d_rl) intersection() { bordwand_relief_2d(); rumpf_umriss_2d(); } }
        translate([0, Bs / 2 - d_rl, 0]) xz(0, 2 * d_rl) offset(delta = es * 0) zierleiste_2d();
        for (s = [-1, 1], x = X_DW) translate([s * x, Bs / 2, z_dw(x)]) rotate([90, 0, 0]) linear_extrude(4 * t_w, center = true) raute2(d_dw + 2 * es);
        // Plankenfugen (Rillen, außen)
        for (i = [1 : 3]) let(R = Rk - i * (Rk - Rg) / 4, A = arc_pts(R, -X_e0, X_e0)) translate([0, Bs / 2 - max(M(0.015), 0.25), 0]) xz(0, 1) for (j = [0 : len(A) - 2]) bar(A[j], A[j + 1], max(M(0.025), 0.4));
    }
    if (inc(fp, "B")) translate([0, Bs / 2 - d_rl, 0]) xz(0, d_rl) zierleiste_2d();
}
module bordwand_teil_welt(stk, fp) intersection() { bordwand_welt(fp); if (stk == 1) translate([-XS - 20, -Bs, 0]) cube([XS + 20 + x_bw, 2 * Bs, 2 * H]); else if (stk == 2) translate([x_bw, -Bs, 0]) cube([XS + 20, 2 * Bs, 2 * H]); else cube(1e4, center = true); }
split_bw = 2 * XS + K(0.7) > usable;
module bordwand_druck(stk, fp) let(n = split_bw ? (stk == 0 ? [1, 2] : [stk]) : [0])
    for (i = n) translate([0, i == 2 ? -K(4) : 0, 0]) xz_druck0(Bs / 2 - t_w) bordwand_teil_welt(i, fp);
module bordwand_paar(fp) { bordwand_welt(fp); rotate(180) bordwand_welt(fp); }

// Dübel: lang = mit Armen, kurz = nur durch Bordwände und Kern
l_dl = 2 * (Y_a0 + t_a) - 0.4;
l_dk = Bs - 0.4;
module duebel(L) let(a = d_dw / sqrt(2), c = min(0.4, a * 0.2)) hull() { cube([L, a, a - c]); translate([c, 0, 0]) cube([L - 2 * c, a, a]); }
module duebel_welt(x, lang) translate([x, 0, z_dw(abs(x))]) rotate([90, 0, 0]) linear_extrude(lang ? l_dl : l_dk, center = true) raute2(d_dw);

// =====================================================================
//  Schwingarm (Ebene x-z, Steuerbord bei y = Y_a0 .. Y_a0 + t_a)
// =====================================================================
module arm_2d() let(P0 = [0, H], A = [for (x = X_DA) [x, z_dw(x)]], As = concat([for (i = [len(A) - 1 : -1 : 0]) [-A[i][0], A[i][1]]], A)) difference() {
    union() {
        for (p = As) girder([0, H], p, w_ar * 1.6, w_ar * 0.45, w_ar * 0.35);
        // Untergurt durch die Dübelpunkte
        for (i = [0 : len(As) - 2]) bar(As[i], As[i + 1], w_ar);
        for (p = As) translate(p) circle(d = d_dw + 2 * min_wand + 0.6, $fn = 20);
        translate([0, H]) circle(r = r_hb, $fn = 40);
        // Rastbogen unter der Nabe
        translate([0, H]) intersection() { circle(r = r_rb, $fn = 60); polygon([[0, 0], for (w = [-90 - a_max - 14 : 4 : -90 + a_max + 14]) 2 * r_rb * [cos(w), sin(w)]]); }
    }
    translate([0, H]) circle(d = d_az + spiel, $fn = 32);
    for (j = POS) translate([0, H] + r_ix * [cos(-90 + j * winkel_schritt), sin(-90 + j * winkel_schritt)]) circle(r = r_h, $fn = 16);
    for (p = As) translate(p) raute2(d_dw + 2 * es);
}
module arm_welt(sy) rotate(sy > 0 ? 0 : 180) xz(Y_a0, Y_a0 + t_a) arm_2d();
module arm_druck() translate([0, 0, 0]) linear_extrude(t_a) translate([0, -H]) arm_2d();

// Achszapfen (Welt): steckt im Lagerkopf, ragt durch die Nabe
module achszapfen_welt(sy) rotate(sy > 0 ? 0 : 180) translate([0, Y_a0 + 0.2, H]) rotate([-90, 0, 0]) linear_extrude(l_az - 0.2 + t_A * 0 - 0.2) raute2(d_az);
module achszapfen_druck() let(a = d_az / sqrt(2), c = min(0.5, a * 0.2), L = l_az - 0.4) hull() { cube([L, a, a - c]); translate([c, 0, 0]) cube([L - 2 * c, a, a]); }

// =====================================================================
//  A-Bock (Ebene x-z, Steuerbord bei y = Y_A0 .. Y_A0 + t_A)
// =====================================================================
z_qr = K(3.2);                                // Querriegel
module abock_2d() let(F = [[-X_bk, t_bp], [X_bk, t_bp]], T = [0, H]) difference() {
    union() {
        for (f = F) sbar(f + [0, w_l / 2], T, w_l);
        // Querriegel (Höhe z_qr) zwischen den Stützen
        let(u = (z_qr - t_bp) / (H - t_bp)) translate([-X_bk * (1 - u), z_qr - w_l * 0.35]) square([2 * X_bk * (1 - u), w_l * 0.7]);
        // Leiter an der rechten Stütze (innen, parallel)
        let(d = [X_bk, t_bp - H] / norm([X_bk, t_bp - H]), nrm = [d[1], -d[0]], o = w_l * 1.3, P1 = T + nrm * o + d * (r_lk + 1), P2 = F[1] + nrm * o + [0, w_l]) {
            for (s = [-1, 1]) sbar(P1 + nrm * s * w_l * 0.35, P2 + nrm * s * w_l * 0.35, max(M(0.05), 0.8));
            let(n = max(4, round(norm(P2 - P1) / M(0.35)))) for (i = [0 : n]) let(q = P1 + (P2 - P1) * i / n) sbar(q - nrm * w_l * 0.35, q + nrm * w_l * 0.35, max(M(0.05), 0.8));
            for (t = [0.25, 0.6, 0.95]) let(q = P1 + (P2 - P1) * t) sbar(q - nrm * w_l * 0.35, q - nrm * o, max(M(0.06), 0.8));
        }
        translate(T) circle(r = r_lk, $fn = 40);
        // Knotenblech mit Loch für den Arretier-Stift
        let(d = r_ix + r_h + max(M(0.1), 1.5), xg = X_bk * d / (H - t_bp)) hull() { translate(T) circle(r = r_lk, $fn = 40); translate([-xg, H - d - w_l * 0.4]) square([2 * xg, w_l * 0.4]); }
        // Zungen: oben in die Plattform, unten in die Bodenplatte
        translate([-w_l / 2, H + r_lk - 0.01]) square([w_l, l_tb]);
        for (f = F) translate([f[0] - w_l * 0.35, t_bp - l_tb]) square([w_l * 0.7, l_tb + w_l]);
    }
    translate(T) raute2(d_az + 2 * es);
    translate(T - [0, r_ix]) circle(r = r_h, $fn = 16);
    translate([-1e3, -1e3]) square([2e3, 1e3 + t_bp - l_tb]);
}
module abock_welt(sy) rotate(sy > 0 ? 0 : 180) xz(Y_A0, Y_A0 + t_A) abock_2d();
module abock_druck() linear_extrude(t_A) translate([0, -t_bp + l_tb]) abock_2d();

module spitz_2d(w, h) polygon([[-w / 2, h * 0.12], [w / 2, h * 0.12], [w / 2, h - w / 2], [0, h], [-w / 2, h - w / 2]]);
// Plattform (Welt, Steuerbord) – aufrecht gedruckt, Brüstung mit vielen Pfosten (kurze Brücken)
Y_Ac = Y_A0 + t_A / 2;
module plattform_welt(sy) rotate(sy > 0 ? 0 : 180) translate([0, Y_Ac, H + r_lk]) difference() {
    union() {
        translate([-P_x / 2, -P_y / 2, 0]) cube([P_x, P_y, t_pl]);
        // Brüstung ringsum (Öffnungen kurz genug zum Überbrücken)
        difference() {
            translate([-P_x / 2, -P_y / 2, 0]) cube([P_x, P_y, t_pl + h_br]);
            translate([-P_x / 2 + t_br, -P_y / 2 + t_br, t_pl]) cube([P_x - 2 * t_br, P_y - 2 * t_br, h_br + 1]);
            // Öffnungen mit spitzem Sturz (45°) – keine Brücken
            let(n = max(2, round(P_x / max(M(0.5), 6))), w = P_x / n - t_br * 1.5) for (i = [0 : n - 1]) for (s = [-1, 1])
                translate([-P_x / 2 + P_x * (i + 0.5) / n, s * P_y / 2 + t_br + 1, t_pl]) rotate([90, 0, 0]) linear_extrude(2 * t_br + 2) spitz_2d(w, h_br * 0.82);
            let(n = max(2, round(P_y / max(M(0.5), 6))), w = P_y / n - t_br * 1.5) for (i = [0 : n - 1]) for (s = [-1, 1])
                translate([s * P_x / 2 - t_br - 1, -P_y / 2 + P_y * (i + 0.5) / n, t_pl]) rotate([90, 0, 90]) linear_extrude(2 * t_br + 2) spitz_2d(w, h_br * 0.82);
        }
        // Antrieb
        translate([-P_x * 0.3, -P_y * 0.25, t_pl - 0.01]) cube([P_x * 0.35, P_y * 0.5, K(0.7)]);
        translate([P_x * 0.05 + K(0.4), 0, t_pl - 0.01]) cylinder(r = K(0.25), h = K(0.55), $fn = 24);   // Motor (stehend)
    }
    translate([-w_l / 2 - es, -t_A / 2 - es, -1]) cube([w_l + 2 * es, t_A + 2 * es, l_tb + 1.2]);
}
module plattform_druck() translate([0, -Y_Ac, -(H + r_lk)]) plattform_welt(1);

// =====================================================================
//  Masten (Ebene y-z), Bugspriet (Ebene x-z)
// =====================================================================
// 2D lokal: u = y, v = z über dem Fuß
module mast_2d(h, ry, gross, fp) let(y1 = 0.45 * h, y2 = 0.85 * h) {
    if (inc(fp, "A")) {
        translate([-w_m / 2, -l_tb]) square([w_m, h + l_tb]);
        for (v = [y1, y2]) translate([-(v == y1 ? ry : ry * 0.75), v - w_y / 2]) square([2 * (v == y1 ? ry : ry * 0.75), w_y]);
        for (s = [-1, 1]) sbar([s * ry * 0.95, w_y / 2 + 0.05], [0, 0.8 * h], w_y);   // Wanten (enden knapp über dem Fuß)
        if (gross) translate([-K(0.4), 0.72 * h]) square([K(0.8), w_y * 1.5]);   // Mastkorb
    }
}
module segel_2d(h, ry) let(y1 = 0.45 * h, y2 = 0.85 * h) {
    // Obersegel und Untersegel bilden eine Fläche (hinter der unteren Rah verbunden)
    polygon(concat([[-ry * 0.75, y2], [ry * 0.75, y2], [ry * 0.95, y1]], [for (i = [0 : 8]) let(u = ry * 0.9 - i * ry * 1.8 / 8) [u, y1 - K(0.9) - (i % 2) * K(0.15)]], [[-ry * 0.95, y1]]));
}
module flagge_2d(h) translate([w_m / 2 - 0.01, h - K(0.6)]) square([K(0.9), K(0.55)]);
module mast_lokal(i, fp) let(m = MASTEN[i]) {
    if (inc(fp, "A")) difference() { linear_extrude(t_m) mast_2d(m[1], m[2], m[3], "A"); translate([0, 0, -1]) linear_extrude(t_sg + 1) intersection() { segel_2d(m[1], m[2]); mast_2d(m[1], m[2], m[3], "A"); } }
    if (inc(fp, "B")) linear_extrude(t_sg) segel_2d(m[1], m[2]);
    if (m[3] && inc(fp, "C")) linear_extrude(t_m) flagge_2d(m[1]);
}
module mast_welt(i, fp) let(m = MASTEN[i]) translate([m[0] - t_m / 2, 0, mast_fuss(m[0])]) multmatrix([[0, 0, 1, 0], [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 1]]) mast_lokal(i, fp);
module mast_druck(i, fp) translate([0, l_tb, 0]) mast_lokal(i, fp);

module bugspriet_2d() let(z0 = zb(Rg, X_re) - K(0.35), x0 = XS - K(0.9)) {
    translate([x0, z0 - l_tb]) square([K(0.5), l_tb + K(0.3)]);
    hull() { translate([x0, z0]) square([K(0.5), K(0.3)]); translate([XS + K(2.0), z0 + K(1.1)]) circle(d = w_m, $fn = 12); }
    // Galionsfigur (Silhouette) unter dem Bugspriet
    translate([XS + K(0.15), z0 + K(0.25)]) hull() { circle(d = K(0.35), $fn = 16); translate([K(0.35), -K(0.7)]) circle(d = K(0.25), $fn = 12); }
    translate([XS + K(0.55), z0 + K(0.25)]) circle(d = K(0.3), $fn = 16);
}
module bugspriet_welt() xz(-t_m / 2, t_m / 2) bugspriet_2d();
module bugspriet_druck() linear_extrude(t_m) translate([-XS + K(0.9), -zb(Rg, X_re) + K(0.35) + l_tb]) bugspriet_2d();

// =====================================================================
//  Bodenplatte, Zaun, Laterne
// =====================================================================
function zaun_seiten() = [  // [Name, Richtung (0 = entlang x, 1 = entlang y), von, bis, Ebene]
    ["vorne", 0, -XP + m_z, -X_tor, -YP + m_z], ["vorne", 0, X_tor, XP - m_z, -YP + m_z],
    ["hinten", 0, -XP + m_z, 0 - 0.2, YP - m_z], ["hinten", 0, 0 + 0.2, XP - m_z, YP - m_z],
    ["seite", 1, -YP + m_z + t_z, YP - m_z - t_z, -XP + m_z], ["seite", 1, -YP + m_z + t_z, YP - m_z - t_z, XP - m_z]];
function zposten(Lz) = let(n = max(1, round(Lz / M(2.0)))) [for (i = [0 : n]) b_zl + i * (Lz - 2 * b_zl) / n];
module zaun_2d(Lz) {
    for (v = [H_z * 0.2, H_z * 0.7]) translate([0, v]) square([Lz, b_zl]);
    let(n = floor(Lz / p_zl)) for (i = [0 : n]) let(u = min(Lz - b_zl, i * p_zl)) translate([u, 0]) polygon([[0, 0], [b_zl, 0], [b_zl, H_z - b_zl * 0.5], [b_zl / 2, H_z], [0, H_z - b_zl * 0.5]]);
    for (u = zposten(Lz)) translate([u - b_zl, -l_tb]) square([b_zl * 2, l_tb + 0.01]);
}
module tor_2d() let(Lz = 2 * X_tor - 2 * es) {
    for (v = [H_z * 0.2, H_z * 0.7]) translate([0, v]) square([Lz, b_zl]);
    let(n = floor(Lz / p_zl)) for (i = [0 : n]) translate([min(Lz - b_zl, i * p_zl), 0]) square([b_zl, H_z * (0.85 + 0.15 * sin(180 * i / n))]);
    for (u = [b_zl, Lz - b_zl]) translate([u - b_zl, -l_tb]) square([b_zl * 2, l_tb + 0.01]);
    sbar([b_zl, H_z * 0.25], [Lz - b_zl, H_z * 0.7], b_zl);
}
module zaun_welt(z) let(Lz = z[3] - z[2])
    if (z[1] == 0) translate([z[2], 0, t_bp]) xz(z[4] - t_z / 2, z[4] + t_z / 2) zaun_2d(Lz);
    else translate([0, z[2], t_bp]) yz(z[4] - t_z / 2, z[4] + t_z / 2) zaun_2d(Lz);
module tor_welt() translate([-X_tor + es, 0, t_bp]) xz(-YP + m_z - t_z / 2, -YP + m_z + t_z / 2) tor_2d();

module bodenplatte_welt() difference() {
    translate([-XP, -YP, 0]) cube([2 * XP, 2 * YP, t_bp]);
    // Schlitze: A-Böcke
    for (sy = [-1, 1], sx = [-1, 1]) translate([sx * X_bk - w_l * 0.35 - es, sy > 0 ? Y_A0 - es : -Y_A0 - t_A - es, t_bp - l_tb - 0.3]) cube([w_l * 0.7 + 2 * es, t_A + 2 * es, l_tb + 1]);
    // Schlitze: Rampen
    for (sy = [-1, 1]) rotate(sy > 0 ? 0 : 180) for (x = [X_rp[0] + K(0.4), X_rr - K(1.2)]) translate([x - es, Y_r0 + W_r * 0.2 - es, t_bp - l_tb - 0.3]) cube([t_rp + 2 * es, W_r * 0.6 + 2 * es, l_tb + 1]);
    // Schlitze: Zaun und Tor
    for (z = zaun_seiten()) for (u = zposten(z[3] - z[2])) let(c = z[2] + u)
        if (z[1] == 0) translate([c - b_zl - es, z[4] - t_z / 2 - es, t_bp - l_tb - 0.3]) cube([2 * b_zl + 2 * es, t_z + 2 * es, l_tb + 1]);
        else translate([z[4] - t_z / 2 - es, c - b_zl - es, t_bp - l_tb - 0.3]) cube([t_z + 2 * es, 2 * b_zl + 2 * es, l_tb + 1]);
    for (u = [b_zl, 2 * X_tor - 2 * es - b_zl]) translate([-X_tor + es + u - b_zl - es, -YP + m_z - t_z / 2 - es, t_bp - l_tb - 0.3]) cube([2 * b_zl + 2 * es, t_z + 2 * es, l_tb + 1]);
    // Clip-Taschen: Teilung (unten) und Rennbahn-Anschluss an den Seiten
    if (split) for (y = [-YP * 0.6, 0, YP * 0.6]) translate([0, y, 0]) clip_cut(0, false, 0);
    if (rennbahn_taschen) for (s = [-1, 1]) translate([s * XP, 0, 0]) rotate(s > 0 ? 180 : 0) rb_slot();
}
module bodenplatte_druck(stk) let(n = split ? (stk == 0 ? [1, 2] : [stk]) : [0])
    for (i = n) translate([i == 2 ? 10 : 0, 0, 0]) intersection() { bodenplatte_welt(); if (i == 1) translate([-XP - 1, -YP - 1, -1]) cube([XP + 1, 2 * YP + 2, t_bp + 2]); else if (i == 2) translate([0, -YP - 1, -1]) cube([XP + 1, 2 * YP + 2, t_bp + 2]); else cube(1e4, center = true); }

// Laterne (eigenständig, Steinsäule auf Sockel; Kopf mit 5 Leuchten auf Zapfen)
L_X = [XP + K(1.2), -YP + K(0.6)];
w_ls = M(0.7); h_ls = M(3.2);
module laterne() {
    // Sockel und Säule mit Steinfugen
    difference() {
        union() {
            translate([-w_ls * 0.8, -w_ls * 0.8, 0]) cube([w_ls * 1.6, w_ls * 1.6, M(0.35)]);
            translate([-w_ls * 0.65, -w_ls * 0.65, 0]) cube([w_ls * 1.3, w_ls * 1.3, M(1.1)]);
            translate([-w_ls / 2, -w_ls / 2, 0]) cube([w_ls, w_ls, h_ls]);
        }
        for (z = [M(0.35) : M(0.25) : h_ls - M(0.2)]) for (r = [0 : 3]) rotate(r * 90) translate([-w_ls, z < M(1.1) ? w_ls * 0.65 - max(M(0.02), 0.3) : w_ls / 2 - max(M(0.02), 0.3), z]) cube([2 * w_ls, 1, max(M(0.03), 0.4)]);
    }
    translate([0, 0, h_ls - 0.01]) linear_extrude(l_tb + 0.01) raute2(max(M(0.2), 2.0));   // Zapfen für den Kopf
}
r_lt = max(M(0.17), 1.4);
module laternenkopf() let(d = max(M(0.2), 2.0), hk = M(1.4), hd = max(M(0.15), l_tb + 0.8)) {
    // Deckstein (steht beim Druck auf dem Bett) mit Loch für den Zapfen der Säule
    difference() { translate([-w_ls * 0.55, -w_ls * 0.55, 0]) cube([w_ls * 1.1, w_ls * 1.1, hd]); translate([0, 0, -1]) linear_extrude(l_tb + 1.3) raute2(d + 2 * es); }
    cylinder(d = max(M(0.15), 1.4), h = hk, $fn = 12);
    // vier schräge Arme (45°) mit Leuchten, eine Leuchte oben
    for (r = [0 : 3]) rotate(r * 90 + 45) {
        hull() { translate([0, 0, hk * 0.3]) cylinder(d = max(M(0.1), 1.0), h = 0.01, $fn = 8); translate([M(0.45), 0, hk * 0.3 + M(0.7)]) cylinder(d = max(M(0.1), 1.0), h = 0.01, $fn = 8); }
        translate([M(0.45), 0, hk * 0.3 + M(0.7)]) leuchte();
    }
    translate([0, 0, hk - 0.05]) leuchte();
}
module leuchte() {
    r0 = max(M(0.1), 1.0) * 0.45; hc = (r_lt - r0) * 1.3;
    cylinder(r1 = r0, r2 = r_lt, h = hc, $fn = 6);   // Fuß (nicht breiter als der Arm), steiler als 45°
    translate([0, 0, hc - 0.01]) cylinder(r = r_lt, h = r_lt * 1.4, $fn = 6);
    translate([0, 0, hc + r_lt * 1.4 - 0.02]) cylinder(r1 = r_lt, r2 = r_lt * 0.2, h = r_lt * 1.0, $fn = 6);
}
module laterne_welt() translate([L_X[0], L_X[1], 0]) { laterne(); }
module laternenkopf_welt() translate([L_X[0], L_X[1], h_ls]) laternenkopf();

// =====================================================================
//  Einstiegsrampe (Ebene x-z, Steuerbord; Backbord um z gedreht)
// =====================================================================
module rampe_2d() polygon([[X_rp[0], t_bp + 0.02], [X_rr, t_bp + 0.02], [X_rp[1], Z_r], [X_rp[0], Z_r]]);
// Stahlgerüst: Schale + Streben (Öffnungen quer durch)
module rampe_gitter_2d() difference() {
    rampe_2d();
    difference() {
        offset(delta = -t_rp) rampe_2d();
        for (x = [X_rp[0] + K(0.8) : K(0.8) : X_rr - K(0.4)]) translate([x - t_rp / 2, 0]) square([t_rp, 2 * Z_r]);
        for (x = [X_rp[0] : K(0.8) : X_rr - K(0.8)]) bar([x, t_bp], [x + K(0.8), Z_r], t_rp);
    }
}
module rampe_gel_2d() let(s = (Z_r - t_bp) / (X_rr - X_rp[1]), P = [[X_rr - K(0.25), t_bp + K(0.25) * s], [X_rp[1], Z_r], [X_rp[0] + b_rg / 2, Z_r]]) {
    for (i = [0 : 1]) for (v = [H_rg / 2, H_rg - b_rg / 2]) sbar(P[i] + [0, v], P[i + 1] + [0, v], b_rg);
    for (p = P) translate([p[0] - b_rg / 2, p[1] - 0.01]) square([b_rg, H_rg]);
    for (x = [X_rp[1] + K(1.0) : K(1.0) : X_rr - K(0.5)]) translate([x - b_rg / 2, Z_r - (x - X_rp[1]) * s - 0.01]) square([b_rg, H_rg]);
    translate([X_rp[0] + K(0.8), Z_r - 0.01]) square([b_rg, H_rg]);
}
module rampe_welt(sy) rotate(sy > 0 ? 0 : 180) difference() {
    union() {
        xz(Y_r0, Y_r1) rampe_gitter_2d();
        xz(Y_r1 - t_rg, Y_r1) rampe_gel_2d();
        // Steg bis an die Bordwand (unter dem Schwingarm)
        xz(Y_rs, Y_r0 + 0.01) intersection() { rampe_gitter_2d(); translate([X_rp[0], 0]) square([X_rp[1] - X_rp[0], 2 * Z_r]); }
        // Zungen in die Bodenplatte
        for (x = [X_rp[0] + K(0.4), X_rr - K(1.2)]) translate([x, Y_r0 + W_r * 0.2, t_bp - l_tb]) cube([t_rp, W_r * 0.6, l_tb + 0.05]);
    }
}
module rampe_druck() xz_druck(Y_r1) rampe_welt(1);
function arm_tief() = H - max([for (x = X_DA) norm([x, z_dw(x)] - [0, H]) + (d_dw / 2 + min_wand + 0.3)]);

// =====================================================================
//  Zusammenbau
// =====================================================================
module schiff(ex = 0, fp_ok = true) {
    bunt(farbe_sitze) rumpfkern();
    for (s = [-1, 1]) translate([0, s * ex * 0.6, 0]) { bunt(farbe_rumpf) rotate(s > 0 ? 0 : 180) bordwand_welt("A"); bunt(farbe_zierleiste) rotate(s > 0 ? 0 : 180) bordwand_welt("B"); }
    for (s = [-1, 1], x = X_DW) translate([0, 0, -ex * 0.3]) bunt(farbe_sitze) duebel_welt(s * x, len([for (d = X_DA) if (abs(d - x) < 0.01) 1]) > 0);
    translate([0, 0, ex * 0.8]) {
        for (i = [0 : len(MASTEN) - 1]) { bunt(farbe_mast) mast_welt(i, "A"); bunt(farbe_segel) mast_welt(i, "B"); if (MASTEN[i][3]) bunt(farbe_flagge) mast_welt(i, "C"); }
        translate([ex * 0.5, 0, 0]) bunt(farbe_mast) bugspriet_welt();
    }
    for (s = [-1, 1]) translate([0, s * ex * 1.1, 0]) bunt(farbe_gestell) arm_welt(s);
}
module schiffschaukel(ex = 0) {
    a = ex > 0 ? 0 : schaukel_winkel;
    bunt(farbe_boden) bodenplatte_welt();
    for (s = [-1, 1]) translate([0, s * ex * 1.6, ex * 0.3]) {
        bunt(farbe_gestell) abock_welt(s);
        translate([0, 0, ex * 0.6]) bunt(farbe_gestell) plattform_welt(s);
        translate([0, -s * ex * 0.5, 0]) bunt(farbe_gestell) achszapfen_welt(s);
    }
    translate([0, 0, ex * 0.5]) schwing(a) schiff(ex);
    for (z = zaun_seiten()) translate([0, 0, ex * 0.3]) bunt(farbe_zaun) zaun_welt(z);
    translate([0, -ex * 0.5, ex * 0.3]) bunt(farbe_zaun) tor_welt();
    for (s = [-1, 1]) translate([0, s * ex * 2.2, 0]) bunt(farbe_rampe) rampe_welt(s);
    bunt(farbe_stein) laterne_welt();
    translate([0, 0, ex * 0.5]) bunt(farbe_laterne) laternenkopf_welt();
}
module kasse_platz() translate([-XP - W_h - K(0.6), -YP - K(0.2), 0]) children();

// =====================================================================
//  Info und Ausgabe
// =====================================================================
INFOS = [["haus_boden", info_haus_boden(), 1], ["haus_wand_vorne", info_wand("vorne"), 1], ["haus_wand_hinten", info_wand("hinten"), 1],
         ["haus_wand_links", info_wand("links"), 1], ["haus_wand_rechts", info_wand("rechts"), 1],
         ["haus_dach", info_haus_dach(), 1], ["haus_schild", info_schild(), 1]];
function np_of(n) = [for (i = INFOS) if (i[0] == n) n_pieces(i[1])][0];
CLIPS = (split ? 3 : 0) + lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
echo(str("Schiffschaukel 1:", den, " | Drehachse ", r2(H), " mm | Schiff ", r2(2 * XS), " x ", r2(Bs), " mm, ", 2 * n_r, " Sitzreihen | Bodenplatte ", r2(2 * XP), " x ", r2(2 * YP), " mm",
         split ? " (geteilt)" : "", " | Bordwand ", split_bw ? "zweiteilig" : "einteilig"));
echo(str("A-Bock ", r2(2 * X_bk + w_l), " x ", r2(H + r_lk + l_tb), " mm | Arm ", r2(2 * max(X_DA) + w_ar), " x ", r2(H - min([for (x = X_DA) z_dw(x)]) + r_hb), " mm | Kiel über Platte ", r2(H - Rk - t_bp), " mm"));
echo(str("Dübel ◇ ", r2(d_dw), ": lang ", r2(l_dl), " mm (", 2 * len(X_DA), "x), kurz ", r2(l_dk), " mm (", 2 * (len(X_DW) - len(X_DA)), "x) | Achszapfen ◇ ", r2(d_az), " x ", r2(l_az - 0.4), " mm"));
echo(str("Arretierung: ", len(POS), " Stellungen (", winkel_schritt, "°), Lochkreis ", r2(r_ix), " mm, Filament-Stift Ø ", stift_d, " x ", r2(l_st), " mm | Rampe: Steg ", r2(Z_r), " mm, Arm tiefster Punkt ", r2(arm_tief()), " mm"));
if (Z_r > arm_tief() - 0.5) echo("WARNUNG: Steg streift den Schwingarm");
echo(str("Mindestmaße: Bordwand ", r2(t_w), " | Kernschale ", r2(w_c), " | Arm ", r2(t_a), " | Bock ", r2(t_A), " | Segel ", r2(t_sg), " | Zaunlatte ", r2(b_zl), " mm"));
if (2 * X_bk + w_l > usable || H + r_lk + l_tb > usable + 5) echo("WARNUNG: A-Bock größer als das Druckbett");
if (H - Rk < t_bp + 1) echo("WARNUNG: Kiel streift die Bodenplatte");
if (max([for (m = MASTEN) mast_fuss(m[0]) + m[1]]) > H - K(0.8)) echo("WARNUNG: Mast zu hoch (Drehachse)");
mass_echo(2 * max(XP, L_X[0] + w_ls), 2 * YP, H + r_lk + t_pl + h_br);

druck("bodenplatte", split ? 2 : 1, "alle", farbe_boden, 1);
druck("abock", 1, "alle", farbe_gestell, 2);
druck("plattform", 1, "alle", farbe_gestell, 2);
druck("achszapfen", 1, "alle", farbe_gestell, 2);
druck("arm", 1, "alle", farbe_gestell, 2);
druck("rumpf", split_r ? 2 : 1, "alle", farbe_sitze, 1);
druck("duebel_mitte", 1, "alle", farbe_sitze, split_r ? 2 : 0);
druck("bordwand", split_bw ? 2 : 1, "A", farbe_rumpf, 2); druck("bordwand", split_bw ? 2 : 1, "B", farbe_zierleiste, 2);
druck("duebel_lang", 1, "alle", farbe_sitze, 2 * len(X_DA));
druck("duebel_kurz", 1, "alle", farbe_sitze, 2 * (len(X_DW) - len(X_DA)));
druck("grossmast", 1, "A", farbe_mast, 1); druck("grossmast", 1, "B", farbe_segel, 1); druck("grossmast", 1, "C", farbe_flagge, 1);
druck("mast", 1, "A", farbe_mast, 2); druck("mast", 1, "B", farbe_segel, 2);
druck("bugspriet", 1, "alle", farbe_mast, 1);
druck("zaun_vorne", 1, "alle", farbe_zaun, 2);
druck("zaun_hinten", 1, "alle", farbe_zaun, 2);
druck("zaun_seite", 1, "alle", farbe_zaun, 2);
druck("tor", 1, "alle", farbe_zaun, 1);
druck("laterne", 1, "alle", farbe_stein, 1);
druck("laternenkopf", 1, "alle", farbe_laterne, 1);
druck("rampe", 1, "alle", farbe_rampe, 2);
druck("haus_boden", np_of("haus_boden"), "alle", farbe_haus_boden, 1);
for (w = ["vorne", "hinten", "links", "rechts"]) {
    druck(str("haus_wand_", w), np_of(str("haus_wand_", w)), "A", farbe_haus_wand, 1);
    druck(str("haus_wand_", w), np_of(str("haus_wand_", w)), "B", farbe_haus_kanten, 1);
}
druck("haus_dach", np_of("haus_dach"), "A", farbe_haus_dach, 1);
if (haus_stil == "flightcase") druck("haus_dach", np_of("haus_dach"), "B", farbe_haus_kanten, 1);
druck("haus_schild", np_of("haus_schild"), "A", farbe_schild_A, 1);
druck("haus_schild", np_of("haus_schild"), "B", farbe_schild_B, 1);
druck("verbinder", 1, "alle", farbe_boden, CLIPS > 0 ? 1 : 0);
farben_echo();

if (teil == "aufbau") { schiffschaukel(); if (kassenhaus_zeigen) kasse_platz() kassenhaus(); }
else if (teil == "explosion") { schiffschaukel(max(M(1.5), 12)); if (kassenhaus_zeigen) kasse_platz() kassenhaus(max(M(0.8), 8)); }
else if (teil == "bodenplatte") bodenplatte_druck(stueck);
else if (teil == "abock") abock_druck();
else if (teil == "plattform") plattform_druck();
else if (teil == "achszapfen") achszapfen_druck();
else if (teil == "arm") arm_druck();
else if (teil == "rumpf") rumpf_druck(stueck);
else if (teil == "bordwand") bordwand_druck(stueck, farbteil);
else if (teil == "duebel_lang") duebel(l_dl);
else if (teil == "duebel_kurz") duebel(l_dk);
else if (teil == "duebel_mitte") duebel(2 * c0 - 0.4);
else if (teil == "grossmast") mast_druck(0, farbteil);
else if (teil == "mast") mast_druck(1, farbteil);
else if (teil == "bugspriet") bugspriet_druck();
else if (teil == "zaun_vorne") translate([0, l_tb, 0]) linear_extrude(t_z) zaun_2d(zaun_seiten()[0][3] - zaun_seiten()[0][2]);
else if (teil == "zaun_hinten") translate([0, l_tb, 0]) linear_extrude(t_z) zaun_2d(zaun_seiten()[2][3] - zaun_seiten()[2][2]);
else if (teil == "zaun_seite") translate([0, l_tb, 0]) linear_extrude(t_z) zaun_2d(zaun_seiten()[4][3] - zaun_seiten()[4][2]);
else if (teil == "tor") translate([0, l_tb, 0]) linear_extrude(t_z) tor_2d();
else if (teil == "laterne") laterne();
else if (teil == "laternenkopf") laternenkopf();
else if (teil == "rampe") rampe_druck();
else if (teil == "haus_boden") split_out(info_haus_boden(), stueck) haus_boden_druck();
else if (teil == "haus_wand_vorne") split_out(info_wand("vorne"), stueck) wand_druck("vorne", farbteil);
else if (teil == "haus_wand_hinten") split_out(info_wand("hinten"), stueck) wand_druck("hinten", farbteil);
else if (teil == "haus_wand_links") split_out(info_wand("links"), stueck) wand_druck("links", farbteil);
else if (teil == "haus_wand_rechts") split_out(info_wand("rechts"), stueck) wand_druck("rechts", farbteil);
else if (teil == "haus_dach") split_out(info_haus_dach(), stueck) haus_dach_druck(farbteil);
else if (teil == "haus_schild") split_out(info_schild(), stueck) schild_druck(farbteil);
else if (teil == "verbinder") verbinder_platten(max(CLIPS, 4), stueck);
