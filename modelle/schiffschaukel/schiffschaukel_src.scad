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

include <../../lib/deko_grundlagen.scad>

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

include <../../lib/deko_hilfen.scad>
include <../../lib/deko_kasse.scad>

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
