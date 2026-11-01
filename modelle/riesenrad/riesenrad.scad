// =====================================================================
//  RIESENRAD mit KASSENHÄUSCHEN  –  zerlegbarer Deko-Bausatz
//  parametrisch, alle gängigen Maßstäbe, FDM-optimiert (stützfrei),
//  Teile über dem Druckbett werden automatisch geteilt (Clips),
//  Stecksystem kompatibel zu rennbahn_deko.scad
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    radscheibe     Radscheibe: Nabe, Speichen, Fachwerkkranz,
//                   Lampen – bei Übergröße in Ringsegmente geteilt   2x
//    achse          Achshälfte: Nabentrommel, Sechskant, Lagerzapfen   2x
//    querstange     Gondelachse (entfällt bei querstange = filament)  1x je Gondel
//    stuetze        A-Stütze (Fachwerk, flach) mit Lagerauge          2x
//    strebe         Seitenstrebe (hält die A-Stütze seitlich)          2x
//    grundrahmen    Trägerrost mit Steckschlitzen, Podestzapfen und
//                   Rennbahn-Taschen an den Stirnseiten                1x
//    einstieg       Einstiegspodest mit Treppe und Geländer            1x
//    gondel_korb    Gondel: Boden, Brüstung, Eckpfosten, Bänke         1x je Gondel
//    gondel_dach    Gondel: Bogendach mit Gehänge (Augen)              1x je Gondel
//    haus_boden     Kassenhäuschen: Bodenplatte mit Wandnut            1x
//    haus_wand_*    Kassenhäuschen: vorne (Kassenfenster), hinten,
//                   links, rechts (Tür / Fenster)                       je 1x
//    haus_dach      Kassenhäuschen: Walmdach mit Schildlöchern          1x
//    haus_schild    Dachschild mit Text (2-farbig: farbteil A/B)        1x
//    verbinder      Clips für alle geteilten Teile
//
//  BEWEGLICH
//    * Das Rad dreht sich: die Achshälften stecken mit Sechskant fest in
//      den Radscheiben und laufen rund in den Lageraugen der A-Stützen.
//    * Jede Gondel pendelt frei an ihrer Querachse und hängt so in jeder
//      Radstellung senkrecht.
//
//  MONTAGE
//    1. Geteilte Radscheiben mit Clips zusammenstecken (Clips von der
//       Innenseite = Seite ohne Lampen einschieben). Stützen und Rahmen
//       ebenso: Clips immer von der Druckbett-Seite.
//    2. Erste Radscheibe flach hinlegen (Lampen nach unten), Achshälfte
//       von innen durch den Sechskant stecken, Querachsen in die D-Löcher.
//    3. Gondeldächer auf die Korbpfosten kleben, Gondeln über die
//       Querachsen schieben (Augen über die Achse).
//    4. Zweite Achshälfte in die zweite Scheibe, Scheibe auflegen – alle
//       Querachsen in die D-Löcher drücken.
//    5. A-Stützen auf die Lagerzapfen schieben (Lagerring zur Scheibe).
//    6. Grundrahmen: Podest auf die Zapfen, Streben in ihre Schlitze.
//    7. Rad mit beiden Stützen absenken: Füße in die Schlitze, die
//       Strebenzapfen gleiten in die unten offenen Kerben der Stützen.
//
//  DRUCK: alle Teile werden druckfertig ausgerichtet ausgegeben.
//    Radscheiben, Stützen, Streben, Platten flach; Gondeln, Podest,
//    Dächer aufrecht; Achsen liegend mit Abflachung. Keine Stützen nötig.
//    Geteilte Teile: stueck = 1..n (die Konsole nennt die Anzahl).
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, radscheibe:Radscheibe, achse:Achshälfte, querstange:Gondelachse, stuetze:A-Stütze, strebe:Seitenstrebe, grundrahmen:Grundrahmen, einstieg:Einstiegspodest, gondel_korb:Gondel-Korb, gondel_dach:Gondel-Dach mit Gehänge, haus_boden:Kassenhaus Boden, haus_wand_vorne:Kassenhaus Wand vorne, haus_wand_hinten:Kassenhaus Wand hinten, haus_wand_links:Kassenhaus Wand links, haus_wand_rechts:Kassenhaus Wand rechts, haus_dach:Kassenhaus Dach, haus_schild:Kassenhaus Schild, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Schild: A = Tafel, B = Schrift und Rand
farbteil = "alle"; // [alle, A, B]

/* [Vorschau] */
// Drehwinkel des Rades
radstellung = 0; // [0:360]
// Auslenkung der Gondeln (Wind / Anfahren)
pendeln = 0; // [-30:30]
kassenhaus_zeigen = true;

/* [Riesenrad (Vorbild in Metern)] */
// Durchmesser des Gondelachsen-Kreises
rad_durchmesser_m = 20;
gondeln = 12; // [6:1:24]
felgen_tiefe_m = 1.2;
// lichter Abstand der beiden Radscheiben
rad_abstand_m = 2.4;
gondel_laenge_m = 1.6;
gondel_breite_m = 1.6;
// Korb: Boden bis Dachunterkante
korb_hoehe_m = 1.9;
dach_hoehe_m = 0.45;
// Gondelachse bis Dachunterkante
gehaenge_m = 0.9;
einstieg_hoehe_m = 0.9;
// Lampen auf Kranz und Speichen (Außenseite)
lampen = true;

/* [Kassenhäuschen (Vorbild in Metern)] */
haus_breite_m = 2.2;
haus_tiefe_m  = 1.6;
haus_hoehe_m  = 2.3;
tuer = "links"; // [links, rechts]
schild_text = "RIESENRAD";
kasse_text  = "KASSE";
schild_font = "Liberation Sans:style=Bold";

/* [Druck & Passung] */
// Gondelachsen: gedruckt (mit D-Zapfen) oder Filament-Stücke
querstange = "auto"; // [auto:automatisch, gedruckt:gedruckt, filament:Filament]
// Taschen für das Rennbahn-Stecksystem in Grundrahmen und Kassenhaus
rennbahn_taschen = true;
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
stift_d = 1.75;
stift_spiel = 0.2;
// Clips auf der Clip-Platte (0 = so viele wie benötigt)
verbinder_anzahl = 0;

// =====================================================================
//  Grundlagen
// =====================================================================
$fa = 3; $fs = 0.3;
e   = 0.01;
den = massstab == 0 ? eigener_massstab : massstab;
s   = 1 / den;
function sc(mm, mn = 0) = max(mm * s, mn);
function r2(x) = round(x * 100) / 100;
function inc(fp, g) = fp == "alle" || fp == g;
function deg(x) = x * 180 / PI;
usable = druckbett - 2 * rand;
gap = 0.1;
cl  = 0.3;                                      // Laufspiel drehender Teile

function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] : d <= 20 ? [16, 6, 10, 3.2] : d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] : d <= 50 ? [10, 4, 7, 2] : [8, 3.2, 5.6, 1.6];
CT = conn_tab(den);
cL = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];
deck  = 0.8;
clipd = ch + spiel + deck;
mw  = cw1 / 2 + spiel + min_wand;               // halbe Mindestbreite einer Clip-Tasche
mi  = cL / 2 + 1.5;
spw = cL + 3;                                   // Stoßblech quer zur Naht

// =====================================================================
//  Maße
// =====================================================================
// ---- Gondelachsen ----
rod_fil = querstange == "filament" || (querstange == "auto" && sc(180) < 3);
d_q    = rod_fil ? stift_d : max(sc(180), 3);
d_t    = rod_fil ? stift_d : d_q - 2 * max(0.5, sc(25));      // D-Zapfen
c_t    = 0.35 * d_t;                                         // Abflachung (Abstand zur Achse)
q_hole = rod_fil ? stift_d + 0.1 : d_t + 2 * spiel;
e_hole = rod_fil ? stift_d + 2 * stift_spiel : d_q + 2 * cl;

// ---- Rad ----
n_g   = gondeln;
beta  = 360 / n_g;
th0   = -90;                                    // Gondel 0 unten am Einstieg
TH    = [for (k = [0 : n_g - 1]) th0 + k * beta];
R_o   = sc(rad_durchmesser_m * 500, 30);
h_rim = max(sc(felgen_tiefe_m * 1000), 6);
R_i   = R_o - h_rim;
w_r   = max(sc(200), 2.0);
w_sp  = max(sc(180), 1.8);
w_l   = max(sc(110), 1.2);
r_boss = q_hole / 2 + max(sc(120), 1.6);
Rmax  = R_o + max(w_r / 2, r_boss);
face_split = 2 * Rmax + 1 > usable;
t_r   = max(sc(150), 2.4, face_split ? clipd + 0.6 : 0);
z_n   = 2 * max(1, round(R_o * beta * PI / 180 / (2.2 * h_rim)));
NL    = n_g * z_n;
gam   = 360 / NL;

// ---- Achse & Nabe ----
a_x   = max(sc(350), 6);                        // Sechskant-Schlüsselweite
r_hex = a_x / 2 / cos(30);
r_j   = a_x / 2 - 0.6;                          // Lagerzapfen
c_ax  = 0.7 * r_j;                              // Abflachung der liegend gedruckten Achse
r_hub = r_hex + max(sc(200), 2.5);
r_n   = r_hex + max(sc(100), 1.0);              // Nabentrommel

// ---- Gondel (lokal: Drehachse = y, Gondel hängt nach -z) ----
g_l   = sc(gondel_laenge_m * 1000, 8);
g_w   = sc(gondel_breite_m * 1000, 8);
cl_ax = max(sc(40), 0.5);
t_e   = max(sc(100), 1.6);                      // Gehängeblech
r_eye = e_hole / 2 + max(sc(100), 1.2);
W_in  = max(sc(rad_abstand_m * 1000), g_w + 2 * (t_e + cl_ax) + 2 * max(sc(100), 1));
y_e   = W_in / 2 - cl_ax - t_e / 2;
ov_g  = max(sc(150), 1.5);
g_lr  = g_l + 2 * ov_g;
GRY   = 2 * y_e + t_e;                          // Dachbreite (y)
g_split = g_lr > usable || GRY > usable;
h_d   = max(sc(dach_hoehe_m * 1000), 2);
t_rb  = max(sc(60), 1.2, g_split ? clipd + 0.2 : 0);
g_d   = max(sc(40), 0.8);                       // Nut im Dach für die Korbpfosten
h_k   = sc(korb_hoehe_m * 1000, 8);
g_drop = max(sc(gehaenge_m * 1000), h_d + r_eye + 0.5);
z_r0  = -g_drop;                                // Dachunterseite
z_bot = z_r0 - h_k;                             // Korbboden unten
hang  = -z_bot;
t_g   = max(sc(60), 1.2);
t_fl  = max(sc(80), 1.2);
p_g   = max(sc(120), 1.6);                      // Eckpfosten
h_par = min(sc(950), h_k * 0.5);
bk_d  = min(max(sc(400), 2), g_w * 0.25);       // Banktiefe
bk_h  = min(max(sc(450), 2), h_par * 0.8);
g_dw  = min(sc(600), g_w - 2 * (t_g + bk_d) - 1);   // Türbreite

// ---- Einstieg / Höhen ----
h_e   = sc(einstieg_hoehe_m * 1000, 3);
clr   = max(sc(150), 1.5);

// ---- Stützen (A-Rahmen, 2D in x, z; Dicke t_s in y) ----
s_gap = max(sc(80), 1.0);
y_s0  = W_in / 2 + t_r + s_gap;                 // Innenseite Stütze
r_e   = r_j + cl + max(sc(250), 3);
w_leg = max(sc(600), 5);
c_leg = max(sc(150), 1.6);
d_leg = max(sc(100), 1.2);
h_ft  = max(sc(300), 3);
fl    = max(sc(1200), 10, 2 * mw + 2);           // Fußlänge
tl    = fl * 0.6;                                // Fußzapfen

// ---- Streben (2D in y, z; Dicke t_st in x) ----
t_st  = max(sc(150), 2.4);
w_st  = max(sc(300), 3);
h_sl  = max(w_st * 0.7, 2.4);
w_t   = max(sc(400), 4, h_sl + 2 * (spiel + min_wand));
fl_s  = max(sc(900), 8);
tl_s  = fl_s * 0.6;
h_fs  = max(sc(250), 2.5);
h_hd  = h_sl + 2 * max(sc(100), 1.2);

// ---- Grundrahmen (Höhe wird für die Nabenhöhe gebraucht) ----
// Nabenhöhe ohne Rahmendicke -> Spreizung -> Rahmengröße -> Dicke
zh0   = h_e + clr + hang + R_o;
x_f   = 0.36 * zh0;
m_b   = max(sc(300), 3);
bw_o  = max(sc(800), 2 * mw + 2);
X_b   = x_f + fl / 2 + m_b;
base_split = 2 * X_b > usable;
tb    = max(sc(120), 2.4, base_split ? clipd + 0.6 : 0);
z_b   = tb;
z_hub = z_b + zh0;
function xleg(z) = x_f * (z_hub - z) / (z_hub - (z_b + h_ft / 2));
z_t1  = z_b + 0.28 * zh0;
z_s   = z_b + 0.58 * zh0;                        // Strebenanschluss
z_kb  = z_s + 0.55 * (z_hub - z_s);
t_s   = max(sc(150), 2.4, (2 * x_f + fl > usable || zh0 + r_e + tb > usable) ? clipd + 0.6 : 0);
y_o   = y_s0 + t_s;                              // Außenseite Stütze
d_s   = 0.5 * (z_s - z_b);
y_ft  = y_o + d_s;
Y_b   = y_s0 + t_s / 2 + max(t_s + 2 * max(sc(250), 2.5), 2 * mw + 2) / 2;
Y_o   = y_ft + fl_s / 2 + m_b;
L_jz  = s_gap + t_s + max(sc(100), 1.5);         // Lagerzapfen-Länge

// ---- Einstiegspodest ----
p_l   = g_lr + 2 * max(sc(400), 3);
p_w   = 2 * (y_s0 - max(sc(100), 1));
st_d  = max(sc(280), 2);
st_n  = max(2, round(h_e / max(sc(200), 1.5)));
st_w  = min(p_w * 0.5, max(sc(1200), 10));
r_t   = max(sc(60), 1.2);
r_h   = sc(1000, 5);
pg    = max(sc(150), 2);
h_pg  = min(h_e * 0.4, max(sc(100), 1.5));

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
h_rf = sc(700, 4);
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
function clips_v(sx, a, b, kp, S, tot) = let(
    ok = [for (y = cand(a, b, tot, S, 0, sx)) if (okc([sx - cL / 2 - 1, y - mw, sx + cL / 2 + 1, y + mw], kp, S)) y])
    pick(ok, max(16, 2 * mw + 2));
function clips_h(sy, a, b, kp, S, tot) = let(
    ok = [for (x = cand(a, b, tot, S, 1, sy)) if (okc([x - mw, sy - cL / 2 - 1, x + mw, sy + cL / 2 + 1], kp, S)) x])
    pick(ok, max(16, 2 * mw + 2));
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
    lsum([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp, S, SY))]) +
    lsum([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp, S, SX))]);
function crosses(S, ax, at, a, b) = len(S) == 0 || len([for (q = S) if (q[ax] < at && q[ax + 2] > at && q[3 - ax] > a && q[1 - ax] < b) 1]) > 0;
function zero_seams(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7])
    len([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) let(a = band_a(ys, iy), b = band_b(ys, iy, SY))
         if (crosses(S, 0, xs[k], a, b) && len(clips_v(xs[k], a, b, kp, S, SY)) == 0) 1]) +
    len([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) let(a = band_a(xs, ix), b = band_b(xs, ix, SX))
         if (crosses(S, 1, ys[k], a, b) && len(clips_h(ys[k], a, b, kp, S, SX)) == 0) 1]);
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
                if (ix > 0)      for (y = clips_v(xa, ya, yb, kp, S, SY)) translate([xa, y, 0]) clip_cut(0, top, zt2);
                if (ix < nx - 1) for (y = clips_v(xb, ya, yb, kp, S, SY)) translate([xb, y, 0]) clip_cut(0, top, zt2);
                if (iy > 0)      for (x = clips_h(ya, xa, xb, kp, S, SX)) translate([x, ya, 0]) clip_cut(90, top, zt2);
                if (iy < ny - 1) for (x = clips_h(yb, xa, xb, kp, S, SX)) translate([x, yb, 0]) clip_cut(90, top, zt2);
            }
    }
}

// =====================================================================
//  RADSCHEIBE – polare Teilung in Nabenstern + Ringsegmente
//  Kreisnähte kreuzen nur Speichen, radiale Nähte liegen zwischen den
//  Speichen und kreuzen nur Kranz / Zwischenring – dort Stoßbleche + Clips
// =====================================================================
pwd  = max(w_sp, 2 * mw + 0.5);                   // Speichen-Stoßblech (quer)
pr_z = max(w_r, 2 * mw + 0.5);                    // Zwischenring-Stoßblech (radial)
R_c  = min(usable / 2 - spw / 2 - 1, R_i - w_r / 2 - spw / 2 - 1);
b_top_max = R_i - w_r / 2 - spw / 2 - 1;
b_top = max(R_c, min(b_top_max, Rmax - usable * 0.8));
n_mid = (face_split && b_top > R_c + 1) ? ceil((b_top - R_c) / (usable * 0.75)) : 0;
dmid  = n_mid > 0 ? (b_top - R_c) / n_mid : 0;
// Band = [innen, außen, Art (0 = Speichen + Zwischenring, 1 = Kranz), Zwischenring-Radius]
BANDS = face_split ? concat([for (i = [0 : 1 : n_mid - 1]) [R_c + i * dmid, R_c + (i + 1) * dmid, 0, R_c + (i + 0.5) * dmid]],
                            [[b_top, Rmax + 0.5, 1, 0]]) : [];
ZR = concat(face_split ? ((R_c - r_hub) / 2 > spw / 2 + w_r + 1 && R_c - r_hub > 8 * w_r ? [(r_hub + R_c) / 2] : [])
                       : (R_i - r_hub > 8 * w_r ? [(r_hub + R_i) / 2] : []),
            [for (b = BANDS) if (b[2] == 0) b[3]]);

function near_spoke(a, d) = min([for (t = TH) adiff(a, t)]) < d;
function nudge(t, d, k = 0) = k > 2000 ? t :
    let(v = t + (k % 2 == 0 ? 1 : -1) * floor((k + 1) / 2) * 0.25)
    !near_spoke(v, d) ? v : nudge(t, d, k + 1);
function dlt(b) = b[2] == 1 ? max(deg((spw / 2 + w_sp / 2 + 1) / b[0]), deg((spw / 2 + r_boss + 1) / R_o))
                            : deg((spw / 2 + w_sp / 2 + 1) / b[0]);
function reg(n) = n_g % n == 0 || n % n_g == 0;                 // gleich große Segmente möglich
function seam_list(b, bi, n) = let(
    base  = n >= n_g ? th0 + 180 / n : th0 + beta / 2,
    shift = reg(n) ? (n < n_g ? (bi % 2) * floor(n_g / n / 2) * beta : 0) : (bi % 2) * 180 / n)
    qsort([for (j = [0 : n - 1]) nudge(base + shift + j * 360 / n, dlt(b))]);
function pieces_of(b, ss) = let(n = len(ss)) [for (j = [0 : n - 1]) [b[0], b[1], ss[j], j == n - 1 ? ss[0] + 360 : ss[j + 1]]];
function spts(bl, bh, a0, a1) = let(N = 24) concat([for (i = [0 : N]) pol(bh, a0 + i * (a1 - a0) / N)],
                                                  bl > 0.01 ? [for (i = [0 : N]) pol(bl, a0 + i * (a1 - a0) / N)] : [[0, 0]]);
function fit_rho(bl, bh, a0, a1) = (a1 - a0 >= 359.9) ? (2 * bh <= usable ? 0 : undef) :
    let(r0 = 90 - (a0 + a1) / 2, P = spts(bl, bh, a0, a1),
        ok = [for (d = [0, 10, -10, 20, -20, 30, -30, 45, -45, 60, -60, 90]) let(b = bb([for (p = P) rotp(p, r0 + d)]))
              if (b[2] - b[0] <= usable && b[3] - b[1] <= usable) r0 + d])
    len(ok) > 0 ? ok[0] : undef;
function band_ok(b, ss) = len([for (p = pieces_of(b, ss)) if (fit_rho(p[0], p[1], p[2], p[3]) == undef) 1]) == 0;
function nmax_band(b) = max(2, floor(360 / (2 * dlt(b) + 1)));
function band_g(b, bi, n = 2) = n > nmax_band(b) ? -1 : band_ok(b, seam_list(b, bi, n)) ? n : band_g(b, bi, n + 1);
function first_fit(b, bi, L, i = 0) = i >= len(L) ? -1 : band_ok(b, seam_list(b, bi, L[i])) ? L[i] : first_fit(b, bi, L, i + 1);
function band_n(b, bi) = let(G = band_g(b, bi), R = first_fit(b, bi, [for (n = [2 : nmax_band(b)]) if (reg(n)) n]))
    (R > 0 && (G < 0 || R <= G * 2)) ? R : G;
NP  = [for (i = [0 : 1 : len(BANDS) - 1]) 2 * BANDS[i][1] <= usable ? 1 : band_n(BANDS[i], i)];
NPE = [for (i = [0 : 1 : len(BANDS) - 1]) NP[i] > 0 ? NP[i] : nmax_band(BANDS[i])];
SEAMS = [for (i = [0 : 1 : len(BANDS) - 1]) NPE[i] > 1 ? seam_list(BANDS[i], i, NPE[i]) : []];
FP = face_split ? concat([[0, R_c, 0, 360, -1]],
        [for (i = [0 : 1 : len(BANDS) - 1]) each (NPE[i] == 1 ? [[BANDS[i][0], BANDS[i][1], 0, 360, i]]
                                                 : [for (p = pieces_of(BANDS[i], SEAMS[i])) concat(p, [i])])])
     : [[0, Rmax + 0.5, 0, 360, 0]];
RHO = [for (p = FP) let(r = fit_rho(p[0], p[1], p[2], p[3])) r == undef ? 90 - (p[2] + p[3]) / 2 : r];
FIT = [for (p = FP) fit_rho(p[0], p[1], p[2], p[3]) != undef];
CSEAMS = face_split ? [for (b = BANDS) b[0]] : [];
function rad_clip_r(b) = b[2] == 1 ?
    let(ra = R_i - w_r / 2 + mw, rb = R_o + w_r / 2 - mw, n = max(1, min(3, floor((rb - ra) / max(16, 2 * mw + 2)) + 1)))
    (n == 1 ? [(ra + rb) / 2] : [for (k = [0 : n - 1]) ra + k * (rb - ra) / (n - 1)]) : [b[3]];
FCLIPS = concat([for (b = CSEAMS, t = TH) concat(pol(b, t), [t])],
                [for (i = [0 : 1 : len(BANDS) - 1]) if (NPE[i] > 1) for (a = SEAMS[i], r = rad_clip_r(BANDS[i])) concat(pol(r, a), [a + 90])]);
ALL_RSEAMS = [for (i = [0 : 1 : len(BANDS) - 1]) if (NPE[i] > 1) for (a = SEAMS[i]) [a, BANDS[i][0], BANDS[i][1]]];

module face_pads() {
    for (b = CSEAMS, t = TH) rotate(t) translate([b - spw / 2, -pwd / 2]) square([spw, pwd]);
    for (i = [0 : 1 : len(BANDS) - 1]) if (NPE[i] > 1) for (a = SEAMS[i]) rotate(a) {
        if (BANDS[i][2] == 1) translate([R_i - w_r / 2, -spw / 2]) square([h_rim + w_r, spw]);
        else translate([BANDS[i][3] - pr_z / 2, -spw / 2]) square([pr_z, spw]);
    }
}
module rod_hole_2d(t) {
    if (rod_fil) circle(d = q_hole, $fn = 16);
    else rotate(t + 180) dprof(q_hole, c_t + spiel);   // Abflachung zeigt zur Nabe
}
module face_2d() {
    difference() {
        union() {
            circle(r = r_hub);
            for (t = TH) rotate(t) translate([r_hub - 0.5, -w_sp / 2]) square([R_o - r_hub + 0.5, w_sp]);
            ring2(R_o, w_r); ring2(R_i, w_r);
            for (r = ZR) ring2(r, w_r);
            for (j = [0 : NL - 1]) let(a = th0 + j * gam)
                bar(pol(j % 2 == 0 ? R_o : R_i, a), pol(j % 2 == 0 ? R_i : R_o, a + gam), w_l);
            for (t = TH) translate(pol(R_o, t)) circle(r = r_boss);
            if (face_split) face_pads();
        }
        circle(r = (a_x / 2 + spiel) / cos(30), $fn = 6);
        for (t = TH) translate(pol(R_o, t)) rod_hole_2d(t);
    }
}
d_lp = max(min(w_r, w_sp) * 0.7, 1.0);
h_lp = max(sc(40), 0.4);
function lamp_ok(p) = let(r = norm(p), a = atan2(p[1], p[0]))
    len([for (b = CSEAMS) if (abs(r - b) < spw / 2 + d_lp) 1]) == 0 &&
    len([for (q = ALL_RSEAMS) if (r >= q[1] && r <= q[2] && adiff(a, q[0]) * PI / 180 * r < spw / 2 + d_lp) 1]) == 0;
LAMPS = lampen ? [for (p = concat(
        [for (j = [0 : NL - 1]) if (j % z_n != 0) pol(j % 2 == 0 ? R_o : R_i, th0 + j * gam)],
        [for (t = TH, k = [1 : 1 : max(1, floor((R_i - r_hub - 2 * w_r) / max(sc(1500), 6)))]) pol(r_hub + w_r + k * (R_i - r_hub - 2 * w_r) / (floor((R_i - r_hub - 2 * w_r) / max(sc(1500), 6)) + 1), t)]))
        if (lamp_ok(p)) p] : [];

module face_3d() {
    difference() {
        linear_extrude(t_r) face_2d();
        for (c = FCLIPS) translate([c[0], c[1], 0]) clip_cut(c[2], false, 0);
    }
    for (p = LAMPS) translate([p[0], p[1], t_r - e]) cylinder(d = d_lp, h = h_lp + e, $fn = 12);
}
module face_mask(p) {
    bl = p[0]; bh = p[1]; a0 = p[2]; a1 = p[3];
    is_top = !face_split || p[4] == len(BANDS) - 1;
    difference() {
        intersection() {
            circle(r = is_top ? bh + 3 : bh - gap, $fa = 1);
            if (a1 - a0 < 359.9) polygon(concat([[0, 0]], [for (i = [0 : 36]) pol(2 * bh + 10, a0 + i * (a1 - a0) / 36)]));
        }
        if (bl > 0) circle(r = bl + gap, $fa = 1);
        if (a1 - a0 < 359.9) for (a = [a0, a1]) rotate(a) translate([0, -gap]) square([2 * bh + 20, 2 * gap]);
    }
}
// Stück direkt in 2D ausschneiden (schnell), dann nur die Clips und Lampen dieses Stücks
function in_piece(p, P, m) = let(r = norm(p), a = atan2(p[1], p[0]), da = deg(m / max(r, 1)),
                                  x = ((a - P[2] + da) % 360 + 360) % 360)
    r >= P[0] - m && r <= P[1] + m && (P[3] - P[2] >= 359.9 || x <= P[3] - P[2] + 2 * da);
module face_piece(i) {
    P = FP[i];
    difference() {
        linear_extrude(t_r) intersection() { face_2d(); face_mask(P); }
        for (c = FCLIPS) if (in_piece([c[0], c[1]], P, cL)) translate([c[0], c[1], 0]) clip_cut(c[2], false, 0);
    }
    for (q = LAMPS) if (in_piece(q, P, -d_lp)) translate([q[0], q[1], t_r - e]) cylinder(d = d_lp, h = h_lp + e, $fn = 12);
}
function piece_bb(i) = let(p = FP[i]) (p[3] - p[2] >= 359.9) ? [-p[1], -p[1], p[1], p[1]]
                                      : bb([for (q = spts(p[0], p[1], p[2], p[3])) rotp(q, RHO[i])]);
module face_piece_druck(i) let(b = piece_bb(i)) translate([-b[0], -b[1], 0]) rotate([0, 0, RHO[i]]) face_piece(i);
module radscheibe_druck(stk) {
    if (!face_split) translate([Rmax, Rmax, 0]) face_3d();
    else if (stk > 0) face_piece_druck(min(stk, len(FP)) - 1);
    else for (i = [0 : len(FP) - 1]) translate([(i % 4) * (usable + 10), floor(i / 4) * (usable + 10), 0]) face_piece_druck(i);
}

// =====================================================================
//  ACHSE (2 gleiche Hälften), Gondelachse
// =====================================================================
module achse_lokal() {   // entlang +x: Trommel, Sechskant, Zapfen; Abflachung bei z = -c_ax
    L1 = W_in / 2 - 0.05; L2 = t_r; L3 = L_jz;
    rotate([0, 90, 0]) {
        linear_extrude(L1) dprof(2 * r_n, c_ax);
        translate([0, 0, L1 - e]) linear_extrude(L2 + 2 * e) intersection() { rotate(30) circle(r = r_hex, $fn = 6); dprof(4 * r_hex, c_ax); }
        translate([0, 0, L1 + L2]) linear_extrude(L3) dprof(2 * r_j, c_ax);
        translate([0, 0, L1 + L2 + L3 - e]) linear_extrude(0.4 + e, scale = (r_j - 0.4) / r_j) dprof(2 * r_j, c_ax);   // Fase
    }
}
L_ax = W_in / 2 - 0.05 + t_r + L_jz + 0.4;
module achse_druck() translate([0, 0, c_ax]) achse_lokal();

module querstange_lokal() {   // entlang +x
    Lt = t_r - 0.2;
    rotate([0, 90, 0]) {
        linear_extrude(Lt + e) dprof(d_t, c_t);
        translate([0, 0, Lt]) linear_extrude(W_in) dprof(d_q, c_t);
        translate([0, 0, Lt + W_in - e]) linear_extrude(Lt + e) dprof(d_t, c_t);
    }
}
L_q = W_in + 2 * (t_r - 0.2);
module querstange_druck() translate([0, 0, c_t]) querstange_lokal();

// =====================================================================
//  GONDEL (lokal: Drehachse = y durch den Ursprung)
// =====================================================================
module korb_ring_2d(sp) difference() {
    offset(delta = sp) square([g_l, g_w], center = true);
    offset(delta = -sp) square([g_l - 2 * t_g, g_w - 2 * t_g], center = true);
}
// Fensteröffnungen: oben offen (keine Brücken), Eckpfosten bleiben
function wspans(L) = L > 3 * p_g + 2 * sc(700, 6) ?
    [[-L / 2 + p_g, -p_g / 2], [p_g / 2, L / 2 - p_g]] : [[-L / 2 + p_g, L / 2 - p_g]];
module korb() {
    zt = z_r0 + g_d - 0.2;
    difference() {
        union() {
            translate([-g_l / 2, -g_w / 2, z_bot]) cube([g_l, g_w, t_fl]);
            translate([0, 0, z_bot]) linear_extrude(zt - z_bot) korb_ring_2d(0);
            for (sy = [-1, 1]) translate([-g_l / 2 + t_g - e, sy > 0 ? g_w / 2 - t_g - bk_d : -g_w / 2 + t_g, z_bot + t_fl - e])
                cube([g_l - 2 * t_g + 2 * e, bk_d, bk_h + e]);
        }
        // Fenster in den Längswänden (y = ±) und Stirnwänden (x = ±)
        for (sp = wspans(g_l), sy = [-1, 1]) translate([sp[0], sy > 0 ? g_w / 2 - t_g - 1 : -g_w / 2 - 1, z_bot + h_par]) cube([sp[1] - sp[0], t_g + 2, h_k + 5]);
        for (sp = wspans(g_w), sx = [-1, 1]) translate([sx > 0 ? g_l / 2 - t_g - 1 : -g_l / 2 - 1, sp[0], z_bot + h_par]) cube([t_g + 2, sp[1] - sp[0], h_k + 5]);
        // Tür (Stirnseite +x)
        translate([g_l / 2 - t_g - 1, -g_dw / 2, z_bot + t_fl]) cube([t_g + 2, g_dw, h_k + 5]);
    }
}
// Dachprofil (x, z): Platte + Bogen
rho_d = let(a = g_lr / 2, H = h_d - t_rb) (a * a + H * H) / (2 * H);
module dach_prof_2d() {
    translate([-g_lr / 2, z_r0]) square([g_lr, t_rb]);
    intersection() {
        translate([0, z_r0 + h_d - rho_d]) circle(r = rho_d, $fa = 2);
        translate([-g_lr / 2, z_r0 + t_rb - e]) square([g_lr, h_d]);
    }
}
module gehaenge_2d() {
    fw = max(sc(120), 1.4);
    k  = g_drop / (g_lr / 2);                     // Steigung der Außenkante
    zb = z_r0 + h_d + fw;                         // Fensterunterkante über dem Dachfirst
    zt = -r_eye - fw;
    hb = min((g_lr / 2) * (-zb) / g_drop - fw * 1.5, (zt - zb) / k);
    difference() {
        hull() { dach_prof_2d(); circle(r = r_eye); }
        if (hb > 1.5) polygon([[-hb, zb], [hb, zb], [0, zb + hb * k]]);
    }
}
module gondel_dach() {
    difference() {
        union() {
            translate([0, GRY / 2, 0]) rotate([90, 0, 0]) linear_extrude(GRY) dach_prof_2d();
            for (sy = [-1, 1]) translate([0, sy * y_e + t_e / 2, 0]) rotate([90, 0, 0]) linear_extrude(t_e) gehaenge_2d();
        }
        translate([0, W_in, 0]) rotate([90, 0, 0]) linear_extrude(2 * W_in) rotate(90) teardrop(e_hole / 2);
        translate([0, 0, z_r0 - e]) linear_extrude(g_d + e) korb_ring_2d(spiel);
    }
}
module gondel(c = "#e74c3c") {
    color(c) korb();
    color("#ecf0f1") gondel_dach();
}
module korb_druck() translate([g_l / 2, g_w / 2, -z_bot]) korb();
module gondel_dach_druck() translate([g_lr / 2, GRY / 2, -z_r0]) gondel_dach();
function info_gdach() = let(ox = g_lr / 2, oy = GRY / 2,
    kp = [[ox - g_l / 2 - 1.5, oy - g_w / 2 - 1.5, ox + g_l / 2 + 1.5, oy + g_w / 2 + 1.5]])
    [g_lr, GRY, seams_at(g_lr, [], mw), seams_at(GRY, [for (sy = [-1, 1]) [oy + sy * y_e - t_e - spw, oy + sy * y_e + t_e + spw]], mw), [], false, 0,
     [[0, 0, g_lr, oy - g_w / 2 - 1.5], [0, oy + g_w / 2 + 1.5, g_lr, GRY], [0, 0, ox - g_l / 2 - 1.5, GRY], [ox + g_l / 2 + 1.5, 0, g_lr, GRY],
      [ox - g_l / 2 + t_g + 1.5, oy - g_w / 2 + t_g + 1.5, ox + g_l / 2 - t_g - 1.5, oy + g_w / 2 - t_g - 1.5]]];

// =====================================================================
//  A-STÜTZE (2D in x, z)
// =====================================================================
FA_M = [[[-x_f, z_b + h_ft / 2], [0, z_hub], w_leg], [[x_f, z_b + h_ft / 2], [0, z_hub], w_leg],
        [[-xleg(z_t1), z_t1], [xleg(z_t1), z_t1], w_t], [[-xleg(z_s), z_s], [xleg(z_s), z_s], w_t]];
FA_BR = concat([for (sx = [-1, 1]) [[0, z_s], [sx * xleg(z_kb), z_kb], d_leg * 1.5]],
               [for (sx = [-1, 1]) [[sx * xleg(z_t1), z_t1], [0, z_s], d_leg * 1.3]],
               [for (sx = [-1, 1]) [[0, z_t1], [sx * xleg(z_s), z_s], d_leg * 1.3]]);
fa_xmin = -x_f - fl / 2; fa_xmax = x_f + fl / 2;
fa_zmin = z_b - tb + 0.3; fa_zmax = z_hub + r_e;
n_top = z_s + h_sl / 2 + spiel;                  // Oberkante Strebenkerbe
gus_w = t_st / 2 + spiel + 2 * min_wand;
gus_t = n_top + max(2 * min_wand, w_t / 2);
FA_BADX = [[-r_e - spw / 2, r_e + spw / 2], [-gus_w - spw / 2, gus_w + spw / 2],
           [x_f - fl / 2 - spw / 2, 1e9], [-1e9, -x_f + fl / 2 + spw / 2]];
FA_BADZ = [[z_t1 - w_t / 2 - spw / 2, z_t1 + w_t / 2 + spw / 2], [z_s - w_t / 2 - spw / 2, gus_t + spw / 2],
           [z_kb - spw, z_kb + spw], [z_hub - r_e - spw / 2, 1e9], [-1e9, z_b + h_ft + spw / 2]];
fa_xs = [for (v = seams_at(fa_xmax - fa_xmin, [for (b = FA_BADX) [b[0] - fa_xmin, b[1] - fa_xmin]], spw)) v + fa_xmin];
FA_PX = pads(concat(FA_M, FA_BR), fa_xs, []);         // Stoßbleche der senkrechten Nähte: waagrechte Nähte meiden sie
fa_zs = [for (v = seams_at(fa_zmax - fa_zmin, [for (b = concat(FA_BADZ, [for (r = FA_PX) [r[1] - mi - 1, r[3] + mi + 1]])) [b[0] - fa_zmin, b[1] - fa_zmin]], spw)) v + fa_zmin];
FA_PADS = pads(concat(FA_M, FA_BR), fa_xs, fa_zs);

module stuetze_2d() {
    difference() {
        union() {
            for (sx = [-1, 1]) girder([sx * x_f, z_b + h_ft / 2], [0, z_hub], w_leg, c_leg, d_leg);
            for (z = [z_t1, z_s]) sbar([-xleg(z), z], [xleg(z), z], w_t);
            for (m = FA_BR) bar(m[0], m[1], m[2]);
            translate([0, z_hub]) circle(r = r_e);
            for (sx = [-1, 1]) {
                translate([sx * x_f - fl / 2, z_b]) square([fl, h_ft]);
                translate([sx * x_f - tl / 2, z_b - (tb - 0.3)]) square([tl, tb - 0.3 + e]);
            }
            translate([-gus_w, z_s - w_t / 2]) square([2 * gus_w, gus_t - (z_s - w_t / 2)]);
            for (r = FA_PADS) rect2(r);
        }
        // unten offene Kerbe für den Strebenzapfen
        translate([-t_st / 2 - spiel, z_s - w_t / 2 - 1]) square([t_st + 2 * spiel, n_top - (z_s - w_t / 2 - 1)]);
    }
}
r_bs = r_hub - 0.5;
module stuetze_3d() {   // Druckorientierung: Außenseite unten, Lagerring oben (zur Radscheibe)
    difference() {
        union() {
            linear_extrude(t_s) stuetze_2d();
            translate([0, z_hub, t_s - 0.3]) cylinder(r = r_bs, h = s_gap - 0.2 + 0.3);
        }
        translate([0, z_hub, -1]) cylinder(r = r_j + cl, h = t_s + s_gap + 2, $fn = 48);
    }
}
module stuetze_druck() translate([-fa_xmin, -fa_zmin, 0]) stuetze_3d();
module stuetze_welt(sy) rotate([0, 0, sy > 0 ? 0 : 180]) translate([0, y_o, 0]) rotate([90, 0, 0]) stuetze_3d();
function info_stuetze() = let(ox = -fa_xmin, oy = -fa_zmin,
    kp = [[-r_e + ox, z_hub - r_e + oy, r_e + ox, z_hub + r_e + oy], [-gus_w - 1 + ox, z_s - w_t / 2 - 2 + oy, gus_w + 1 + ox, n_top + 1 + oy]])
    [fa_xmax - fa_xmin, fa_zmax - fa_zmin, [for (v = fa_xs) v + ox], [for (v = fa_zs) v + oy], kp, false, 0, shift_r(FA_PADS, ox, oy),
     concat(occ(concat(FA_M, FA_BR), ox, oy), [[-r_e + ox, z_hub - r_e + oy, r_e + ox, z_hub + r_e + oy]],
            [for (sx = [-1, 1]) [sx * x_f - fl / 2 + ox, fa_zmin + oy, sx * x_f + fl / 2 + ox, z_b + h_ft + oy]])];

// =====================================================================
//  SEITENSTREBE (2D in y, z; Dicke t_st in x)
// =====================================================================
SB_M = [[[y_o + w_st / 2, z_s], [y_ft, z_b + h_fs / 2], w_st]];
sb_ymin = y_s0 + 0.2; sb_ymax = y_ft + fl_s / 2;
sb_zmin = z_b - tb + 0.3; sb_zmax = z_s + h_hd / 2;
sb_xs = [for (v = seams_at(sb_ymax - sb_ymin, [[-1e9, y_o + w_st + spw / 2 - sb_ymin], [y_ft - fl_s / 2 - spw / 2 - sb_ymin, 1e9]], spw)) v + sb_ymin];
sb_zs = [for (v = seams_at(sb_zmax - sb_zmin, [[-1e9, z_b + h_fs + spw / 2 - sb_zmin], [z_s - h_hd / 2 - spw / 2 - sb_zmin, 1e9]], spw)) v + sb_zmin];
SB_PADS = pads(SB_M, sb_xs, sb_zs);
module strebe_2d() {
    bar(SB_M[0][0], SB_M[0][1], w_st);
    translate([y_o - e, z_s - h_hd / 2]) square([w_st + e, h_hd]);                 // Kopf
    translate([y_s0 + 0.2, z_s - h_sl / 2]) square([y_o - y_s0 - 0.2 + e, h_sl]);  // Zapfen durch die Stütze
    translate([y_ft - fl_s / 2, z_b]) square([fl_s, h_fs]);                        // Fuß
    translate([y_ft - tl_s / 2, z_b - (tb - 0.3)]) square([tl_s, tb - 0.3 + e]);   // Fußzapfen
    for (r = SB_PADS) rect2(r);
}
module strebe_druck() linear_extrude(t_st) translate([-sb_ymin, -sb_zmin]) strebe_2d();
module strebe_welt(sy) rotate([0, 0, sy > 0 ? 0 : 180]) translate([-t_st / 2, 0, 0]) rotate([90, 0, 90]) linear_extrude(t_st) strebe_2d();
function info_strebe() = let(ox = -sb_ymin, oy = -sb_zmin)
    [sb_ymax - sb_ymin, sb_zmax - sb_zmin, [for (v = sb_xs) v + ox], [for (v = sb_zs) v + oy], [], false, 0, shift_r(SB_PADS, ox, oy),
     concat(occ(SB_M, ox, oy), [[y_s0 + ox, z_s - h_hd / 2 + oy, y_o + w_st + ox, z_s + h_hd / 2 + oy],
                               [y_ft - fl_s / 2 + ox, sb_zmin + oy, y_ft + fl_s / 2 + ox, z_b + h_fs + oy]])];

// =====================================================================
//  GRUNDRAHMEN
// =====================================================================
bl_w = max(t_s + 2 * max(sc(250), 2.5), 2 * mw + 2);     // Längsträger unter den Stützen
bq_w = max(sc(600), 2 * mw + 2, cL + 4);                  // Querträger an den Enden
y_lb = y_s0 + t_s / 2;
x_d0 = -p_l / 2 - m_b; x_d1 = p_l / 2 + st_n * st_d + m_b; // Plattform unter dem Podest
BASE_R = [[-X_b, y_lb - bl_w / 2, X_b, y_lb + bl_w / 2], [-X_b, -y_lb - bl_w / 2, X_b, -y_lb + bl_w / 2],
          [-X_b, -Y_b, -X_b + bq_w, Y_b], [X_b - bq_w, -Y_b, X_b, Y_b],
          [x_d0, -Y_b, x_d1, Y_b],
          [-bw_o / 2, Y_b - 1, bw_o / 2, Y_o], [-bw_o / 2, -Y_o, bw_o / 2, -Y_b + 1]];
BASE_SLOTS = concat(
    [for (sx = [-1, 1], sy = [-1, 1]) let(y0 = sy > 0 ? y_s0 : -y_o)
        [sx * x_f - tl / 2 - spiel, y0 - spiel, sx * x_f + tl / 2 + spiel, y0 + t_s + spiel]],
    [for (sy = [-1, 1]) [-t_st / 2 - spiel, sy * y_ft - tl_s / 2 - spiel, t_st / 2 + spiel, sy * y_ft + tl_s / 2 + spiel]]);
PEGS = [for (sy = [-1, 1]) [0, sy * p_w / 4]];
module base_2d() for (r = BASE_R) rect2(r);
module grundrahmen() {
    rl = max(sc(100), 0.8); rh = max(sc(40), 0.4);
    difference() {
        union() {
            linear_extrude(tb) base_2d();
            for (p = PEGS) translate([p[0] - pg / 2, p[1] - pg / 2, tb - e]) cube([pg, pg, h_pg + e]);
            translate([0, 0, tb - e]) linear_extrude(rh + e) difference() { base_2d(); offset(delta = -rl) base_2d(); }   // Randleiste
        }
        for (r = BASE_SLOTS) translate([r[0], r[1], -1]) cube([r[2] - r[0], r[3] - r[1], tb + 5]);
        if (rennbahn_taschen) for (sx = [-1, 1]) translate([sx * X_b, 0, 0]) rotate([0, 0, sx > 0 ? 180 : 0]) rb_slot();
    }
}
module grundrahmen_druck() translate([X_b, Y_o, 0]) grundrahmen();
function info_grundrahmen() = let(ox = X_b, oy = Y_o, SX = 2 * X_b, SY = 2 * Y_o,
    kp = concat([for (r = BASE_SLOTS) [r[0] + ox - 1, r[1] + oy - 1, r[2] + ox + 1, r[3] + oy + 1]],
                [for (p = PEGS) [p[0] + ox - pg, p[1] + oy - pg, p[0] + ox + pg, p[1] + oy + pg]],
                rennbahn_taschen ? [[-1, oy - cw1, cL + 1, oy + cw1], [SX - cL - 1, oy - cw1, SX + 1, oy + cw1]] : []),
    badx = concat([for (r = BASE_SLOTS) [r[0] + ox - spw / 2, r[2] + ox + spw / 2]],
                  [[ox - bw_o / 2 - spw, ox + bw_o / 2 + spw], [-1e9, bq_w + spw], [SX - bq_w - spw, 1e9],
                   [ox + x_d0 - spw, ox + x_d0 + spw], [ox + x_d1 - spw, ox + x_d1 + spw]]),
    bady = concat([for (r = BASE_SLOTS) [r[1] + oy - spw / 2, r[3] + oy + spw / 2]], [for (p = PEGS) [p[1] + oy - pg - spw / 2, p[1] + oy + pg + spw / 2]],
                  [for (sy = [-1, 1]) [oy + sy * y_lb - bl_w / 2 - spw, oy + sy * y_lb + bl_w / 2 + spw]],
                  rennbahn_taschen ? [[oy - cw1 - spw, oy + cw1 + spw]] : []))
    [SX, SY, seams_at(SX, badx, mw), seams_at(SY, bady, mw), kp, false, 0, shift_r(BASE_R, ox, oy), shift_r(BASE_R, ox, oy)];

// =====================================================================
//  EINSTIEGSPODEST (aufrecht gedruckt)
// =====================================================================
module einstieg() {
    difference() {
        union() {
            translate([-p_l / 2, -p_w / 2, 0]) cube([p_l, p_w, h_e]);
            for (i = [1 : st_n]) translate([p_l / 2 - e, -st_w / 2, 0]) cube([(st_n + 1 - i) * st_d + e, st_w, h_e * i / (st_n + 1)]);
            // Seitengeländer (Füllung) mit Handlauf
            for (sy = [-1, 1]) translate([-p_l / 2, sy > 0 ? p_w / 2 - r_t : -p_w / 2, h_e - e]) {
                cube([p_l, r_t, r_h + e]);
                translate([0, sy > 0 ? -r_t * 0.6 : 0, r_h - r_t]) cube([p_l, r_t * 1.6, r_t]);
            }
        }
        // Trittrillen
        rr = max(sc(20), 0.3);
        for (k = [1 : 1 : floor(p_l / max(sc(250), 1.6)) - 1]) translate([-p_l / 2 + k * max(sc(250), 1.6) - rr / 2, -p_w / 2 + r_t * 2, h_e - rr]) cube([rr, p_w - 4 * r_t, rr + 1]);
        for (p = PEGS) translate([p[0] - pg / 2 - spiel, p[1] - pg / 2 - spiel, -e]) cube([pg + 2 * spiel, pg + 2 * spiel, h_pg + 0.3 + e]);
    }
}

module einstieg_druck() translate([p_l / 2, p_w / 2, 0]) einstieg();
function info_einstieg() = let(SX = p_l + st_n * st_d, SY = p_w, ox = p_l / 2, oy = p_w / 2,
    kp = [for (p = PEGS) [p[0] + ox - pg, p[1] + oy - pg, p[0] + ox + pg, p[1] + oy + pg]])
    [SX, SY, seams_at(SX, [[p_l - spw, p_l + spw]], mw), seams_at(SY, [for (p = PEGS) [p[1] + oy - pg - spw, p[1] + oy + pg + spw]], mw), kp, false, 0,
     [[0, 0, p_l, p_w], [p_l, oy - st_w / 2, SX, oy + st_w / 2]]];

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
module wand_local(k) {
    L = wlen(k);
    difference() {
        union() {
            cube([L, H_h, t_h]);
            translate([0, -(g_h - spiel), 0]) cube([L, g_h - spiel + e, t_h]);
            translate([0, H_h - e, 0]) cube([L, g_h - spiel + e, t_h]);
        }
        trim = (k == "vorne" || k == "hinten") ? fwid * 1.3 + f_gw : 0;
        for (j = [1 : 1 : floor(L / f_pitch - 0.01)]) if (j * f_pitch > trim && j * f_pitch < L - trim)
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
}
module wand_welt(k) {
    if (k == "vorne")       translate([0, t_h, hb_h]) rotate([90, 0, 0]) wand_local(k);
    else if (k == "hinten") translate([W_h, D_h - t_h, hb_h]) rotate([90, 0, 180]) wand_local(k);
    else if (k == "links")  translate([t_h, D_h - t_h, hb_h]) rotate([90, 0, -90]) wand_local(k);
    else                    translate([W_h - t_h, t_h, hb_h]) rotate([90, 0, 90]) wand_local(k);
}
module wand_druck(k) translate([0, g_h, 0]) wand_local(k);
function info_wand(k) = let(L = wlen(k), SY = H_h + 2 * g_h,
    kp = concat([for (o = openings(k)) [o[0] - 1, o[1] + g_h - 1, o[2] + 1, o[3] + g_h + 1]],
                [[-1, -1, L + 1, g_h + 1.5], [-1, H_h + g_h - 1.5, L + 1, SY + 1]]))
    [L, SY, seams_at(L, [], mw), seams_at(SY, [], mw), kp, false, 0, []];

z_rh = hb_h + H_h;                                // Dachunterseite
module haus_dach() {   // aufrecht gedruckt (Unterseite auf dem Bett)
    difference() {
        union() {
            translate([-ov_h, -ov_h, z_rh]) cube([RXh, RYh, rt_h]);
            hull() {
                translate([-ov_h, -ov_h, z_rh + rt_h - e]) cube([RXh, RYh, e]);
                translate([W_h / 2 - PXh / 2, D_h / 2 - PYh / 2, z_rh + rt_h + h_rf - e]) cube([PXh, PYh, e]);
            }
        }
        translate([0, 0, z_rh - e]) linear_extrude(g_h + e) ring_2d();
        for (x = spx) translate([W_h / 2 - sw_h / 2 + x - pw_h / 2 - spiel, D_h / 2 - st_h / 2 - spiel, z_rh + rt_h + h_rf - pl_h - 0.2])
            cube([pw_h + 2 * spiel, st_h + 2 * spiel, pl_h + 1]);
        // Traufkante
        tk = max(sc(40), 0.4);
        translate([-ov_h - 1, -ov_h - 1, z_rh + rt_h * 0.5]) difference() {
            cube([RXh + 2, RYh + 2, tk]);
            translate([1 + tk, 1 + tk, -1]) cube([RXh - 2 * tk, RYh - 2 * tk, tk + 2]);
        }
    }
}
module haus_dach_druck() translate([ov_h, ov_h, -z_rh]) haus_dach();
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
    color("#bdc3c7") haus_boden();
    color("#f5deb3") for (k = ["vorne", "hinten", "links", "rechts"]) translate([0, 0, ex]) wand_welt(k);
    color("#c0392b") translate([0, 0, 2 * ex]) haus_dach();
    translate([0, 0, 3 * ex]) { if (inc(farbteil, "A")) color("#f1c40f") schild_welt("A"); if (inc(farbteil, "B")) color("#c0392b") schild_welt("B"); }
}

// =====================================================================
//  ZUSAMMENBAU
// =====================================================================
G_COL = ["#e74c3c", "#f1c40f", "#2ecc71", "#3498db", "#9b59b6", "#e67e22"];
function pivot(k, phi) = [R_o * cos(TH[k] + phi), 0, z_hub + R_o * sin(TH[k] + phi)];
module scheibe_welt(sy) rotate([0, 0, sy > 0 ? 180 : 0]) translate([0, -W_in / 2, 0]) rotate([90, 0, 0]) face_3d();
module rad(phi, ex = 0) {
    translate([0, 0, z_hub]) rotate([0, -phi, 0]) {
        color("#ecf0f1") for (sy = [-1, 1]) translate([0, sy * ex, 0]) scheibe_welt(sy);
        color("#7f8c8d") for (sy = [-1, 1]) translate([0, sy * ex * 0.5, 0]) rotate([0, 0, sy > 0 ? 0 : 180]) rotate([0, 0, 90]) achse_lokal();
        color("#555") for (t = TH) translate([R_o * cos(t), -W_in / 2 - t_r + 0.2, R_o * sin(t)])
            rotate([0, 0, 90]) rotate([90 - t, 0, 0]) querstange_lokal();
    }
    for (k = [0 : n_g - 1]) translate(pivot(k, phi)) rotate([0, -pendeln, 0]) gondel(G_COL[k % len(G_COL)]);
}
module riesenrad(phi, ex = 0) {
    color("#95a5a6") translate([0, 0, -2 * ex]) grundrahmen();
    color("#d35400") translate([0, 0, z_b - ex]) einstieg();
    color("#2c3e50") for (sy = [-1, 1]) translate([0, sy * ex * 2, 0]) { stuetze_welt(sy); strebe_welt(sy); }
    translate([0, 0, ex]) rad(phi, ex);
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFOS = [["stuetze", info_stuetze(), 2], ["strebe", info_strebe(), 2], ["grundrahmen", info_grundrahmen(), 1], ["einstieg", info_einstieg(), 1],
         ["gondel_dach", info_gdach(), n_g], ["haus_boden", info_haus_boden(), 1],
         ["haus_wand_vorne", info_wand("vorne"), 1], ["haus_wand_hinten", info_wand("hinten"), 1],
         ["haus_wand_links", info_wand("links"), 1], ["haus_wand_rechts", info_wand("rechts"), 1],
         ["haus_dach", info_haus_dach(), 1], ["haus_schild", info_schild(), 1]];
CLIPS = 2 * len(FCLIPS) + lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
c1 = 2 * R_o * sin(beta / 2);
g_reach = max(sqrt(pow(g_lr / 2, 2) + pow(hang, 2)) + d_q / 2 + 0.5, sqrt(pow(g_lr, 2) + pow(hang + r_eye, 2)) + 0.5);
H_ges = z_hub + Rmax;

echo(str("Riesenrad 1:", den, " | Rad Ø ", r2(2 * Rmax), " mm, Nabenhöhe ", r2(z_hub), " mm, Gesamthöhe ", r2(H_ges + r_eye), " mm | ",
         n_g, " Gondeln ", r2(g_lr), " × ", r2(GRY), " × ", r2(hang + r_eye), " mm"));
echo(str("Grundrahmen ", r2(2 * X_b), " × ", r2(2 * Y_o), " mm | Kassenhaus ", r2(HBX), " × ", r2(HBY), " mm"));
echo(str("Radscheibe: ", len(FP), " Stück(e) je Scheibe", face_split ? str(" (Nabenstern + ", len(BANDS), " Ring(e): ", NPE, " Segmente), ", len(FCLIPS), " Clips je Scheibe") : ""));
if (face_split && len([for (f = FIT) if (!f) 1]) > 0) echo("WARNUNG: Ein Radsegment passt nicht aufs Druckbett – mehr Gondeln oder größeres Druckbett wählen.");
if (rod_fil) echo(str("Gondelachsen: ", n_g, " Stück Filament Ø ", stift_d, " mm, je ", r2(W_in + 2 * t_r), " mm lang (in die Radscheiben drücken)"));
else echo(str("Gondelachsen: ", n_g, " gedruckt, Ø ", r2(d_q), " mm, Länge ", r2(L_q), " mm (D-Zapfen Ø ", r2(d_t), ")"));
if (c1 < g_reach) echo(str("WARNUNG: Gondeln zu groß für den Gondelabstand (", r2(c1), " mm < ", r2(g_reach), " mm) – sie würden an die Nachbarachsen stoßen. Weniger Gondeln oder größeren Durchmesser wählen."));
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
echo(str("Verbinder-Clips gesamt: ", CLIPS, CLIPS > floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3)) ?
         str(" -> ", ceil(CLIPS / (floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3)))), " Clip-Platten (teil = verbinder, stueck = 1..n)") : ""));

if (teil == "aufbau") {
    riesenrad(radstellung);
    if (kassenhaus_zeigen) translate([X_b + m_h + 3, -Y_o - D_h * 0.3, 0]) kassenhaus();
}
else if (teil == "explosion") {
    riesenrad(radstellung, max(sc(1500), 12));
    if (kassenhaus_zeigen) translate([X_b + m_h + 3 + HBX, -Y_o - D_h * 0.3, 0]) kassenhaus(max(sc(800), 8));
}
else if (teil == "radscheibe") radscheibe_druck(stueck);
else if (teil == "achse") achse_druck();
else if (teil == "querstange") { if (!rod_fil) querstange_druck(); }
else if (teil == "stuetze") split_out(info_stuetze(), stueck) stuetze_druck();
else if (teil == "strebe") split_out(info_strebe(), stueck) strebe_druck();
else if (teil == "grundrahmen") split_out(info_grundrahmen(), stueck) grundrahmen_druck();
else if (teil == "einstieg") split_out(info_einstieg(), stueck) einstieg_druck();
else if (teil == "gondel_korb") korb_druck();
else if (teil == "gondel_dach") split_out(info_gdach(), stueck) gondel_dach_druck();
else if (teil == "haus_boden") split_out(info_haus_boden(), stueck) haus_boden_druck();
else if (teil == "haus_wand_vorne") split_out(info_wand("vorne"), stueck) wand_druck("vorne");
else if (teil == "haus_wand_hinten") split_out(info_wand("hinten"), stueck) wand_druck("hinten");
else if (teil == "haus_wand_links") split_out(info_wand("links"), stueck) wand_druck("links");
else if (teil == "haus_wand_rechts") split_out(info_wand("rechts"), stueck) wand_druck("rechts");
else if (teil == "haus_dach") split_out(info_haus_dach(), stueck) haus_dach_druck();
else if (teil == "haus_schild") split_out(info_schild(), stueck) schild_druck(farbteil);
else if (teil == "verbinder") {
    n = verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4);
    px = floor((usable + 3) / (cL + 3)); py = floor((usable + 3) / (cw1 + 3));
    npl = ceil(n / (px * py));
    for (pl = [0 : npl - 1]) if (stueck == 0 || stueck == pl + 1)
        translate(stueck == 0 ? [pl * (usable + 10), 0, 0] : [0, 0, 0])
        for (i = [pl * px * py : min(n, (pl + 1) * px * py) - 1]) let(j = i - pl * px * py)
            translate([(j % px) * (cL + 3), floor(j / px) * (cw1 + 3), 0]) clip();
}
