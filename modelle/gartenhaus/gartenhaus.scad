// =====================================================================
//  GARTENHAUS mit Vorbau-Veranda (Blockbohlen, Schwedenrot)  –  zerlegbarer Deko-Bausatz
//  Rotes Blockbohlen-Gartenhaus, Giebel nach vorne: überdachte Veranda
//  mit weißem Giebel-Fachwerk, dahinter die Front mit Sprossenfenster,
//  Fensterläden und Fischgrät-Tür. Satteldach mit grauen Pfannen und
//  weißen Kanten, rote Brüstung mit Eingang vorne.
//  Reihe Rennbahn-Deko: alle gängigen Maßstäbe, FDM-optimiert
//  (stützfrei), zu große Teile werden automatisch geteilt (Clips),
//  Stecksystem kompatibel zu rennbahn_deko.scad, Farben je Bauteil
//  (Vorschau, Dateinamen, 3MF über farb_export.py)
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    bodenplatte       Terrassenplatte (Fugen) mit hellem Sockel, Nuten für Wände
//    wand_vorne        Front (Giebel) mit Sprossenfenster, Läden und Türöffnung
//    wand_links / wand_rechts   Seitenwände mit Fenster und Läden
//    wand_hinten       Rückwand (Giebel)
//    tuer              Tür mit Fischgrät-Muster, drehbar (Zapfen oben/unten)
//    rahmen_giebel     weißer Veranda-Giebel (Eckpfosten, Spannbalken, Stiel, Streben, Kopfbänder)
//    pfette_links / pfette_rechts   weiße Seitenbalken der Veranda
//    bruestung_vorne_links / bruestung_vorne_rechts / bruestung_seite (2x)   rote Brüstung
//    dach_links / dach_rechts   Dachhälften mit Pfannen, First und weißen Kanten
//    bank / stuhl / kuebel      Gartenbank, Gartenstuhl, Blumenkübel (3x)
//    verbinder         Clips für alle geteilten Teile
//
//  BEWEGLICH
//    * Die Tür dreht sich auf zwei Zapfen (Sockel unten, Sturz oben).
//    * Das Dach ist nur aufgelegt (Nuten auf den Giebeln): abnehmen und
//      hineinschauen.
//
//  MONTAGE (Kurzfassung)
//    1. Bodenplatte (bei Teilung verclipsen).
//    2. Wände mit der Feder in die Sockelnut stecken: Front, links, rechts,
//       hinten. Tür einsetzen (oben einfädeln, unten absenken).
//    3. Veranda-Giebel vorne einstecken, Seitenbalken mit dem Zapfen in die
//       Eckpfosten, Brüstungen einsetzen.
//    4. Dachhälften auflegen (Nuten greifen über die Giebel), Zubehör aufstellen.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, bodenplatte:Bodenplatte mit Sockel, wand_vorne:Front mit Tür und Fenster, wand_links:Wand links, wand_rechts:Wand rechts, wand_hinten:Rückwand, tuer:Tür (drehbar), rahmen_giebel:Veranda-Giebel, pfette_links:Seitenbalken links, pfette_rechts:Seitenbalken rechts, bruestung_vorne_links:Brüstung vorne links, bruestung_vorne_rechts:Brüstung vorne rechts, bruestung_seite:Brüstung Seite (2x), dach_links:Dach links, dach_rechts:Dach rechts, bank:Gartenbank, stuhl:Gartenstuhl, kuebel:Blumenkübel, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Mehrfarbige Teile: alle oder einzelne Farbe (A = Grundkörper)
farbteil = "alle"; // [alle, A, B, C, D]

/* [Vorschau] */
// Öffnungswinkel der Tür (nach außen)
tuer_winkel = 0;      // [0:90]
dach_zeigen = true;
zubehoer_zeigen = true;

/* [Gartenhaus (Vorbild in Metern)] */
// Breite der Giebelseite (vorne)
haus_breite_m = 4.0;
// Tiefe unter Dach (Veranda-Giebel bis Rückwand)
haus_tiefe_m = 6.0;
// Tiefe der Veranda vor der Front
veranda_tiefe_m = 1.6;
wand_hoehe_m = 2.2;
dachneigung = 25;     // [15:1:40]
dachueberstand_m = 0.4;
giebelueberstand_m = 0.35;
sockel_hoehe_m = 0.15;
terrasse_vorne_m = 1.3;
terrasse_rand_m = 0.4;
fenster_breite_m = 0.8;
fenster_hoehe_m = 1.1;
fensterbank_hoehe_m = 0.9;
fensterlaeden = true;
fenster_links = true;
fenster_rechts = true;
fenster_hinten = false;
tuer_breite_m = 0.85;
tuer_hoehe_m = 2.0;
veranda_bruestung = true;
bruestung_hoehe_m = 0.9;
eingang_breite_m = 1.0;
// Gartenbank, Stuhl und 3 Blumenkübel mitdrucken
zubehoer = true;

/* [Farben] */
farbe_wand        = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_holzwerk    = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_glas        = "anthrazit"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_dach        = "anthrazit"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_bruestung   = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_griff       = "anthrazit"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_platten     = "grau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_sockel      = "silber";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_bank        = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_stuhl       = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kuebel      = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_pflanze     = "gruen";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_blueten     = "rosa";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_clips       = "grau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

/* [Druck & Passung] */
rennbahn_taschen = true;
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;

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
          ["hellblau", "#5aa2dc"], ["dunkelgruen", "#1f6b3a"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

// =====================================================================
//  Maße  (Welt: x = Breite links -> rechts, y = vorne 0 -> hinten D (Firstrichtung),
//         z = 0 Unterseite Bodenplatte)
// =====================================================================
ta  = tan(dachneigung);
B   = M(haus_breite_m, 25);
D   = M(haus_tiefe_m, 40);
P   = min(M(veranda_tiefe_m), D - M(2.5, 18));   // Front (Giebelwand) bei y = P
H   = M(wand_hoehe_m, 18);
o_e = M(dachueberstand_m, 1.5);
o_g = M(giebelueberstand_m, 1.5);
function vt(x) = H + min(x, B - x) * ta;          // Dachunterseite über Fußboden
H_f = vt(B / 2);

g_n  = max(sc(60), 1.2);  tg = g_n - spiel;      // Sockelnut / Feder
h_s  = max(M(sockel_hoehe_m), g_n + 0.6);
t_bp = max(M(0.12), b_cl);
z_f  = t_bp + h_s;                                // Fußboden
w_split = max(B, D - P, H_f + 2 * g_n) > usable;
t_w  = max(M(0.10), 2.4, w_split ? b_cl : 0);
wp   = M(0.14, 2.0);  t_p = wp;                   // Pfosten, Rahmenstärke
hb   = M(0.16, 1.6);  hr = M(0.16, 1.6);  wk = M(0.12, 1.4);  kb = M(0.45, 3);
lz   = min(max(M(0.1), 1.2), h_s - 0.6);          // Zapfen in den Sockel
gr   = max(sc(40), 0.8);  gt = gr - spiel;        // Dachnut / Giebelfeder
Lp   = P - t_p - 0.05;                            // Seitenbalken
lpf  = wp * 0.6;                                  // Balkenzapfen
h_br = M(bruestung_hoehe_m, 6);
kb_b = M(0.08, 1.0);  kv_b = max(sc(40), 0.6);   // Abdeckbrett
lh   = max(M(0.15), 1.6); f_gw = max(sc(15), 0.4); gdp = max(min(sc(12), 0.6), 0.3); dm = max(sc(15), 0.3);
// Fenster
fb = M(fenster_breite_m, 6); fh = M(fenster_hoehe_m, 6); v_s = M(fensterbank_hoehe_m);
fr = max(M(0.07), 0.8); fs = max(sc(40), 0.6); fsp = max(sc(25), 0.45); lb = fb / 2; ds = max(sc(40), 0.6);
tg_l = 0.6;                                       // Glas (erste Schichten)
// Tür (in der Front, rechts der Mitte; Bänder rechts, öffnet nach außen)
t_d = max(t_w * 0.55, 1.2); dp = t_d; gv = max(spiel, 0.2);
lpb = min(max(M(0.12), 1.2), h_s - 0.5); lpt = lpb + 0.5;
dw  = M(tuer_breite_m, 7);
dh  = min(M(tuer_hoehe_m), H - 0.05 - lpt - lpb - 0.5);
du0 = max(B * 0.58, fb + 2 * fr + (fensterlaeden ? 2 * lb : 0) + M(0.25));
du1 = min(du0 + dw, B - t_w - fr - M(0.1));
u_ax = du1 - t_d / 2 - spiel; xa_d = u_ax - du0 - spiel; hd = dh - 2 * gv;
// Brüstung und Eingang (vor der Tür)
x_e0 = max((du0 + du1) / 2 - M(eingang_breite_m) / 2, wp + M(0.3));
x_e1 = min((du0 + du1) / 2 + M(eingang_breite_m) / 2, B - wp - M(0.3));
x_b0 = wp + 0.05; x_b1 = B - wp - 0.05;
// Dach
S_r = (B / 2 + o_e) / cos(dachneigung);           // Unterseite Traufe -> First
RX  = D + 2 * o_g;
rc  = max(M(0.12), 1.0);
t_r0 = max(M(0.12), 2.0);
RYl = S_r + (t_r0 + rc * 1.4) * ta + rc;
r_split = RX > usable || RYl > usable;
t_r = max(t_r0, r_split ? b_cl : 0);
t_wl = 0.6; w_f = max(M(0.12), 1.0); z_fb = t_r * 0.7;
tr_p = max(M(0.32), 1.6); dt = max(sc(25), 0.45); tc_p = max(M(0.3), 1.6); cg = max(sc(18), 0.4); gdr = max(sc(10), 0.25);
// Bodenplatte
m_l = M(terrasse_rand_m, 3); m_r = m_l; m_h = m_l; m_v = M(terrasse_vorne_m, 8);
BX = B + m_l + m_r; BY = D + m_v + m_h;
pp = M(0.6, 4); pwd = max(sc(15), 0.35); pd = max(sc(10), 0.3);
// Zubehör
BANK   = [M(0.95), -M(0.8)];
STUHL  = [B * 0.27, t_p + M(0.55), 10];
KUEBEL = [[x_e0 - M(0.3), -M(0.4), t_bp], [x_e1 + M(0.3), -M(0.4), t_bp], [B - M(0.42), P - M(0.4), z_f]];
module bank3d()  gartenbank(M(1.4, 14), M(0.55, 5.5), M(0.45, 4.5), M(0.85, 8.5));
module stuhl3d() gartenstuhl(M(0.42, 4.5), M(0.45, 4.8), M(0.45, 4.5), M(0.85, 8.5));
module kuebel3d(fp = "alle") pflanzkuebel(M(0.2, 2.2), M(0.35, 3), M(0.4, 3), fp);

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
//  deko_zubehoer.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Kleinteile für Szenen: Gartenbank, Gartenstuhl, Pflanzkübel mit Blüten.
//  Maße in mm (das Modell rechnet vorher mit M()/sc() um).
//  Alle Teile werden aufrecht gedruckt, Ursprung = Mitte der Standfläche,
//  Vorderseite zeigt nach -y. Stützfrei: unter Sitzflächen höchstens
//  zb_spann mm Brücke (sonst Mittelstege), Lehnen max. 12° geneigt.
//  Erwartet: deko_grundlagen.scad (e, spiel, inc)
// =====================================================================
zb_spann = 16;

// Gartenbank: Länge l, Tiefe d, Sitzhöhe hs, Lehnenhöhe hl
module gartenbank(l, d, hs, hl) {
    ws = max(l * 0.05, 1.0);  wl = max(d * 0.12, 1.0);
    ts = max(hs * 0.14, 1.0); tb = max(d * 0.1, 1.0);
    yb = d / 2 - wl;                                  // Lehnenfuß
    dl = (hl - hs) * tan(12);                         // Neigung der Lehne
    ha = hs + (hl - hs) * 0.4;                        // Armlehne
    ya = yb + dl * (ha - hs) / (hl - hs);             // Armlehne endet an der Lehne
    g  = max(min(ts, tb) * 0.3, 0.3);                 // Lattenfugen
    n  = max(1, ceil((l - 2 * ws) / zb_spann));
    for (x = [-l / 2, l / 2 - ws]) translate([x, 0, 0]) rotate([90, 0, 90]) linear_extrude(ws) {
        translate([-d / 2, 0]) square([wl, ha]);
        translate([yb - wl / 2, 0]) square([wl, hs]);
        hull() { translate([yb - tb / 2, hs - ts]) square([tb, e]); translate([yb - tb / 2 + dl, hl - e]) square([tb, e]); }
        translate([-d / 2, ha - wl * 0.7]) square([ya + d / 2, wl * 0.7]);
        if (ya + d / 2 - wl > zb_spann)               // Armlehne mit 45°-Knagge statt langer Brücke
            polygon([[-d / 2 + wl, ha - wl * 0.7], [ya, ha - wl * 0.7], [-d / 2 + wl, ha - wl * 0.7 - (ya + d / 2 - wl)]]);
    }
    difference() {
        translate([-l / 2, -d / 2, hs - ts]) cube([l, yb + tb / 2 + d / 2, ts]);
        for (j = [1 : 3]) translate([-l / 2 - 1, -d / 2 + j * (yb + d / 2) / 4 - g / 2, hs - g]) cube([l + 2, g, g + 1]);
    }
    difference() {
        hull() { translate([-l / 2, yb - tb / 2, hs - ts]) cube([l, tb, e]); translate([-l / 2, yb - tb / 2 + dl, hl - e]) cube([l, tb, e]); }
        for (j = [1 : 3]) let(z = hs + j * (hl - hs) / 4)
            translate([-l / 2 + ws, yb - tb / 2 + dl * (z - hs + ts) / (hl - hs + ts) - g, z - g / 2]) cube([l - 2 * ws, 2 * g, g]);
    }
    for (i = [1 : 1 : n - 1]) translate([-l / 2 + ws + i * (l - 2 * ws) / n - ws * 0.3, -d / 2 + wl, 0]) cube([ws * 0.6, yb - wl / 2 + d / 2 - wl, hs - ts + e]);
}

// Gartenstuhl (Bistro-Stil): Breite b, Tiefe d, Sitzhöhe hs, Lehnenhöhe hl
module gartenstuhl(b, d, hs, hl) {
    wl = max(b * 0.08, 0.8); ts = max(hs * 0.1, 0.8); tb = max(d * 0.08, 0.8);
    dl = (hl - hs) * tan(8);
    for (x = [-b / 2, b / 2 - wl], y = [-d / 2, d / 2 - wl]) translate([x, y, 0]) cube([wl, wl, hs]);
    translate([-b / 2, -d / 2, hs - ts]) cube([b, d, ts]);
    for (y = [-d / 2, d / 2 - wl]) translate([-b / 2, y, hs - ts - wl]) cube([b, wl, wl + e]);       // Zargen
    if (b - 2 * wl > zb_spann) translate([-wl * 0.3, -d / 2 + wl, 0]) cube([wl * 0.6, d - 2 * wl, hs]);
    difference() {
        hull() { translate([-b / 2, d / 2 - tb, hs - e]) cube([b, tb, e]); translate([-b / 2, d / 2 - tb + dl, hl - e]) cube([b, tb, e]); }
        if (b > 7) for (i = [-1, 0, 1]) let(sw = b * 0.14)
            translate([i * b * 0.26, d / 2 + dl + 1, hs + (hl - hs) * 0.2]) rotate([90, 0, 0]) linear_extrude(tb + dl + 3)
                hull() { translate([-sw / 2, 0]) square([sw, (hl - hs) * 0.5]); translate([0, (hl - hs) * 0.5 + sw / 2]) square(e, center = true); }
    }
}

// Pflanzkübel: Radius oben r, Kübelhöhe h, Pflanzenhöhe hp (über Rand); fp A = Kübel, B = Pflanze, C = Blüten
function zb_rb(r) = r * 1.15;
module zb_busch(r, h, hp) {
    wk = max(r * 0.15, 0.8); rb = zb_rb(r); r0 = r - wk - spiel;
    translate([0, 0, h - wk]) rotate_extrude($fn = 28, convexity = 4)
        polygon([[0, 0], [r0, 0], [rb, rb - r0], [rb, max(rb - r0, hp * 0.55)], [rb * 0.8, hp * 0.82], [rb * 0.45, hp * 0.97], [0, hp]]);
}
function zb_blueten(r, h, hp) = let(rb = zb_rb(r), wk = max(r * 0.15, 0.8), z0 = h - wk)
    concat([[0, 0, z0 + hp]], [for (i = [0 : 4]) let(a = i * 72 + 15) [0.6 * rb * cos(a), 0.6 * rb * sin(a), z0 + 0.906 * hp]],
           [for (i = [0 : 6]) let(a = i * 360 / 7 + 40) [0.88 * rb * cos(a), 0.88 * rb * sin(a), z0 + 0.71 * hp]]);
module zb_bluete(p, fd) translate([p[0], p[1], p[2] - fd]) cylinder(d = fd, h = fd * 1.45, $fn = 8);
module pflanzkuebel(r, h, hp, fp = "alle") {
    wk = max(r * 0.15, 0.8); fd = max(r * 0.28, 0.9);
    if (inc(fp, "A")) difference() {
        union() {
            cylinder(r1 = r * 0.78, r2 = r, h = h, $fn = 28);
            translate([0, 0, h - wk]) cylinder(r1 = r, r2 = r + wk * 0.3, h = wk, $fn = 28);
        }
        translate([0, 0, h - wk]) cylinder(r = r - wk, h = h, $fn = 28);
    }
    if (inc(fp, "B")) difference() { zb_busch(r, h, hp); for (p = zb_blueten(r, h, hp)) zb_bluete(p, fd); }
    if (inc(fp, "C")) for (p = zb_blueten(r, h, hp)) zb_bluete(p, fd);
}

// =====================================================================
//  WÄNDE und BRÜSTUNGEN
//  lokal: u = Länge (von außen gesehen links -> rechts), v = Höhe ab Fußboden,
//  w = Dicke (w = t_w außen = beim Druck oben). Feder unten in die Sockelnut,
//  Giebel mit Feder oben in die Dachnut.
// =====================================================================
WK = ["vorne", "links", "rechts", "hinten"];
BK = veranda_bruestung ? ["br_vl", "br_vr", "br_sl", "br_sr"] : [];
function is_br(k) = k == "br_vl" || k == "br_vr" || k == "br_sl" || k == "br_sr";
function is_giebel(k) = k == "vorne" || k == "hinten";
function bk_name(k) = k == "br_vl" ? "bruestung_vorne_links" : k == "br_vr" ? "bruestung_vorne_rechts" : "bruestung_seite";
function WL(k) = is_giebel(k) ? B : (k == "links" || k == "rechts") ? D - P - 2 * t_w :
                 k == "br_vl" ? x_e0 - x_b0 : k == "br_vr" ? x_b1 - x_e1 : P - t_p;
// Grundriss der Wand (Welt x0, y0, x1, y1)
function WFP(k) = k == "vorne" ? [0, P, B, P + t_w] : k == "hinten" ? [0, D - t_w, B, D] :
                  k == "links" ? [0, P + t_w, t_w, D - t_w] : k == "rechts" ? [B - t_w, P + t_w, B, D - t_w] :
                  k == "br_vl" ? [x_b0, 0, x_e0, t_w] : k == "br_vr" ? [x_e1, 0, x_b1, t_w] :
                  k == "br_sl" ? [0, t_p, t_w, P] : [B - t_w, t_p, B, P];
function WPOLY(k) = let(Lw = WL(k), b = -tg)
    is_giebel(k) ? [[0, b], [Lw, b], [Lw, H + gt], [B / 2, H_f + gt], [0, H + gt]] :
    (k == "links" || k == "rechts") ? [[0, b], [Lw, b], [Lw, H - 0.05], [0, H - 0.05]] :
    [[0, b], [Lw, b], [Lw, h_br], [0, h_br]];
function vtop(k) = max([for (p = WPOLY(k)) p[1]]);
function FEN(k) = k == "vorne" ? [(du0 - fr) / 2] : (k == "links" && fenster_links) || (k == "rechts" && fenster_rechts) ? [WL(k) / 2] :
                  (k == "hinten" && fenster_hinten) ? [B / 2] : [];
function laden_ok(k, uc) = fensterlaeden && uc - fb / 2 - fr - lb >= M(0.03) && uc + fb / 2 + fr + lb <= (k == "vorne" ? du0 - fr : WL(k)) - M(0.03);
function has_B(k) = len(FEN(k)) > 0 || k == "vorne";

module fluegel_2d(u0, v0, u1, v1) {
    um = (u0 + u1) / 2;
    difference() { rect2([u0 - e, v0 - e, u1 + e, v1 + e]); rect2([u0 + fs, v0 + fs, u1 - fs, v1 - fs]); }
    rect2([um - fs, v0, um + fs, v1]);
    pw = (u1 - u0) / 2 - 1.5 * fs; ph = v1 - v0 - 2 * fs;
    if (pw / 2 > 1.6 && ph / 3 > 1.6) {
        for (c = [(u0 + um) / 2, (um + u1) / 2]) rect2([c - fsp / 2, v0, c + fsp / 2, v1]);
        for (j = [1, 2]) rect2([u0, v0 + fs + j * ph / 3 - fsp / 2, u1, v0 + fs + j * ph / 3 + fsp / 2]);
    }
}
module wand_B(k) {
    for (uc = FEN(k)) let(u0 = uc - fb / 2, u1 = uc + fb / 2, v0 = v_s, v1 = v_s + fh) {
        translate([0, 0, t_w - gdp]) linear_extrude(gdp + dm) difference() { rect2([u0 - fr, v0 - fr, u1 + fr, v1 + fr]); rect2([u0, v0, u1, v1]); }
        translate([0, 0, t_w - gdp]) linear_extrude(gdp + dm * 2.5) rect2([u0 - fr * 1.6, v0 - fr * 1.8, u1 + fr * 1.6, v0 - fr * 0.6]);
        translate([0, 0, tg_l]) linear_extrude(t_w - tg_l + dm * 0.5) fluegel_2d(u0, v0, u1, v1);
        if (laden_ok(k, uc)) for (a = [u0 - fr - lb, u1 + fr]) difference() {
            translate([0, 0, t_w - gdp]) linear_extrude(gdp + ds) rect2([a, v0 - fr * 0.4, a + lb, v1 + fr * 0.4]);
            nbr = max(2, round(lb / max(M(0.1), 1.2)));
            for (j = [1 : nbr - 1]) translate([a + j * lb / nbr - f_gw / 2, v0 - fr, t_w + ds - gdp]) cube([f_gw, fh + 2 * fr, gdp + 1]);
            for (vq = [v0 + fh * 0.2, v1 - fh * 0.2]) translate([a + lb * 0.15, vq - f_gw / 2, t_w + ds - gdp]) cube([lb * 0.7, f_gw, gdp + 1]);
        }
    }
    if (k == "vorne") translate([0, 0, t_w - gdp]) linear_extrude(gdp + dm) difference() { rect2([du0 - fr, 0, du1 + fr, dh + fr]); rect2([du0, -1, du1, dh]); }
}
// Taschen für B in A (leicht vergrößert: keine Haarspalte/Nullwände an gemeinsamen Kanten)
module wand_B_fp(k) offset(delta = 0.02) union() {
    for (uc = FEN(k)) let(u0 = uc - fb / 2, u1 = uc + fb / 2, v0 = v_s, v1 = v_s + fh) {
        rect2([u0 - fr, v0 - fr, u1 + fr, v1 + fr]);
        rect2([u0 - fr * 1.6, v0 - fr * 1.8, u1 + fr * 1.6, v0 - fr * 0.6]);
        if (laden_ok(k, uc)) for (a = [u0 - fr - lb, u1 + fr]) rect2([a, v0 - fr * 0.4, a + lb, v1 + fr * 0.4]);
    }
    if (k == "vorne") rect2([du0 - fr, -1, du1 + fr, dh + fr]);
}
module wand_C(k) for (uc = FEN(k)) linear_extrude(tg_l) rect2([uc - fb / 2 - fr * 0.5, v_s - fr * 0.5, uc + fb / 2 + fr * 0.5, v_s + fh + fr * 0.5]);
module wand_A(k) difference() {
    union() {
        linear_extrude(t_w, convexity = 4) polygon(WPOLY(k));
        if (is_br(k)) translate([0, h_br - kb_b, t_w - e]) cube([WL(k), kb_b, kv_b + e]);
    }
    for (j = [1 : 1 : floor(vtop(k) / lh)]) if (!is_br(k) || j * lh < h_br - kb_b - f_gw)
        translate([-1, j * lh - f_gw / 2, t_w - gdp * 0.8]) cube([WL(k) + 2, f_gw, gdp + 1]);
    for (uc = FEN(k)) translate([uc - fb / 2, v_s, -1]) cube([fb, fh, t_w + 2]);
    if (k == "vorne") {
        translate([du0, -tg - 1, -1]) cube([du1 - du0, dh + tg + 1, t_w + 2]);
        translate([u_ax, dh - 1, t_w / 2]) rotate([-90, 0, 0]) linear_extrude(vtop(k) - dh + 3) rotate(-90)
            intersection() { teardrop(dp / 2 + spiel); translate([-dp - 2, -dp - 2]) square([dp + 2 + max(dp / 2 + spiel, t_w / 2 - gdp - 0.3), 2 * dp + 4]); }
    }
    translate([0, 0, t_w - gdp]) linear_extrude(gdp + 1) wand_B_fp(k);
    wand_C(k);
}
module wand_lokal(k, fp = "alle") {
    if (inc(fp, "A")) wand_A(k);
    if (!is_br(k) && inc(fp, "B")) wand_B(k);
    if (!is_br(k) && inc(fp, "C")) wand_C(k);
}
module wand_welt(k, fp = "alle") {
    if (k == "vorne")       translate([0, P + t_w, z_f]) rotate([90, 0, 0]) wand_lokal(k, fp);
    else if (k == "hinten") translate([B, D - t_w, z_f]) rotate([90, 0, 180]) wand_lokal(k, fp);
    else if (k == "links")  translate([t_w, D - t_w, z_f]) rotate([90, 0, -90]) wand_lokal(k, fp);
    else if (k == "rechts") translate([B - t_w, P + t_w, z_f]) rotate([90, 0, 90]) wand_lokal(k, fp);
    else if (k == "br_vl")  translate([x_b0, t_w, z_f]) rotate([90, 0, 0]) wand_lokal(k, fp);
    else if (k == "br_vr")  translate([x_e1, t_w, z_f]) rotate([90, 0, 0]) wand_lokal(k, fp);
    else if (k == "br_sl")  translate([t_w, P, z_f]) rotate([90, 0, -90]) wand_lokal(k, fp);
    else                    translate([B - t_w, t_p, z_f]) rotate([90, 0, 90]) wand_lokal(k, fp);
}
module wand_druck(k, fp = "alle") translate([0, tg, 0]) wand_lokal(k, fp);
function wkp(k) = concat([[-1, -1, WL(k) + 1, tg + 1.5]],
    [for (uc = FEN(k)) [uc - fb / 2 - fr * 1.6 - 1, v_s + tg - fr * 1.8 - 1, uc + fb / 2 + fr * 1.6 + 1, v_s + fh + tg + fr + 1]],
    k == "vorne" ? [[du0 - fr - 1, -1, du1 + fr + 1, dh + fr + tg + 1], [u_ax - dp - 1, dh + tg - 1, u_ax + dp + 1, vtop(k) + tg + 1]] : []);
function wv_min(k) = is_br(k) ? h_br - kb_b : H;
function info_wand(k) = let(Lw = WL(k), SY = vtop(k) + tg,
    mb = cL / 2 + 3,
    xs = seams_at(Lw, concat([for (uc = FEN(k)) [uc - fb / 2 - fr * 1.6 - mb, uc + fb / 2 + fr * 1.6 + mb]], k == "vorne" ? [[du0 - fr - mb, du1 + fr + mb]] : []), mw),
    ys = seams_at(SY, [for (uc = FEN(k)) [v_s + tg - fr * 2 - mb, v_s + fh + tg + fr + mb]], mw))
    [Lw, SY, xs, ys, wkp(k), false, 0, wS(k)];
// Clip-Bereiche: Wandfläche bis Traufe, bei Giebeln zusätzlich gestufte Streifen im Dreieck
function wS(k) = concat([[0, tg + 0.5, WL(k), tg + wv_min(k) - 1]], is_giebel(k) ? [for (j = [1 : 3])
    let(v0 = H + (H_f - H) * (j - 1) / 4, v1 = H + (H_f - H) * j / 4, hw = (H_f - v1) / ta - 1) [B / 2 - hw, tg + v0 - cL - 2, B / 2 + hw, tg + v1]] : []);

// ---- Tür (lokal: x = Breite, 0 = Schlossseite, y = Höhe, z = Dicke, außen oben) ----
module fisch_2d(x0, y0, x1, y1, pit, gw) {
    xc = (x0 + x1) / 2; n = ceil((y1 - y0 + x1 - x0) / pit) + 2;
    intersection() { rect2([x0, y0, xc - gw / 2, y1]); for (j = [-n : n]) translate([xc, y0 + j * pit]) rotate(135) translate([0, -gw / 2]) square([x1 - x0 + 10, gw]); }
    intersection() { rect2([xc + gw / 2, y0, x1, y1]); for (j = [-n : n]) translate([xc, y0 + j * pit]) rotate(45) translate([0, -gw / 2]) square([x1 - x0 + 10, gw]); }
    rect2([xc - gw / 2, y0, xc + gw / 2, y1]);
}
module tuer_lokal(fp = "alle") {
    m_i = max(M(0.08), 0.8); gd = min(max(sc(10), 0.3), t_d * 0.25); gw = max(sc(15), 0.35);
    if (inc(fp, "A")) difference() {
        union() {
            cube([xa_d, hd, t_d]);
            translate([xa_d, 0, t_d / 2]) rotate([-90, 0, 0]) cylinder(d = t_d, h = hd, $fn = 8);
            translate([xa_d, -lpb, t_d / 2]) rotate([-90, 0, 0]) cylinder(d = dp, h = lpb + e, $fn = 8);
            translate([xa_d, hd - e, t_d / 2]) rotate([-90, 0, 0]) cylinder(d = dp, h = lpt + e, $fn = 8);
        }
        translate([0, 0, t_d - gd]) linear_extrude(gd + 1) {
            fisch_2d(m_i, m_i, xa_d - m_i, hd - m_i, max(sc(110), 1.3), gw);
            difference() { rect2([m_i - gw, m_i - gw, xa_d - m_i + gw, hd - m_i + gw]); rect2([m_i, m_i, xa_d - m_i, hd - m_i]); }
        }
        translate([M(0.08, 0.8), M(1.05) - gv, t_d - e]) cube([M(0.04, 0.6), M(0.16, 1.2), 1]);
    }
    if (inc(fp, "B")) translate([M(0.08, 0.8), M(1.05) - gv, t_d - e]) cube([M(0.04, 0.6), M(0.16, 1.2), max(sc(40), 0.5) + e]);
}
module tuer_welt(fp = "alle") translate([0, P + t_w, z_f]) rotate([90, 0, 0])
    translate([u_ax, 0, t_w / 2]) rotate([0, tuer_winkel, 0]) translate([-u_ax, 0, -t_w / 2])
    translate([du0 + spiel, gv, t_w / 2 - t_d / 2]) tuer_lokal(fp);
module tuer_druck(fp = "alle") translate([1, lpb + 1, 0]) tuer_lokal(fp);

// =====================================================================
//  VERANDA: Giebel vorne (y = 0 .. t_p) und Seitenbalken (flach gedruckt)
// =====================================================================
module portal_2d() {
    rect2([0, 0, wp, H]); rect2([B - wp, 0, B, H]);
    polygon([[0, H - hr], [B / 2, H_f - hr], [B, H - hr], [B, H + gt], [B / 2, H_f + gt], [0, H + gt]]);
    rect2([0, H - hb, B, H]);
    rect2([B / 2 - wk / 2, H - hb, B / 2 + wk / 2, H_f]);
    for (sd = [-1, 1]) let(u = B / 2 + sd * B * 0.28) sbar([B / 2, H - hb / 2], [u, vt(u) - hr / 2], wk * 0.8);
    sbar([wp / 2, H - hb - kb], [wp / 2 + kb, H - hb / 2], wk);
    sbar([B - wp / 2, H - hb - kb], [B - wp / 2 - kb, H - hb / 2], wk);
    for (u = [wp / 4, B - wp * 3 / 4]) rect2([u, -lz, u + wp / 2, e]);
}
// Taschen für die Zapfen der Seitenbalken (von innen = Bettseite)
module portal_lokal() difference() {
    linear_extrude(t_p, convexity = 6) portal_2d();
    for (u0 = [wp / 2 - spiel, B - wp - 0.01]) translate([u0, H - hb * 0.75 - spiel, -1]) cube([wp / 2 + spiel + 0.01, hb / 2 + 2 * spiel, lpf + 1.3]);
}
module portal_welt() translate([0, t_p, z_f]) rotate([90, 0, 0]) portal_lokal();
PM = [[[wp / 2, 0], [wp / 2, H], wp], [[B - wp / 2, 0], [B - wp / 2, H], wp], [[0, H - hb / 2], [B, H - hb / 2], hb],
      [[0, H - hr / 2], [B / 2, H_f - hr / 2], hr], [[B / 2, H_f - hr / 2], [B, H - hr / 2], hr], [[B / 2, H - hb], [B / 2, H_f], wk]];
function shM(Mx, dx, dy) = [for (m = Mx) [m[0] + [dx, dy], m[1] + [dx, dy], m[2]]];
function info_portal() = let(SY = H_f + gt + lz + mw + 1, xs = seams_at(B, [], mw), ys = seams_at(SY, [], mw), P2 = shM(PM, 0, lz))
    [B, SY, xs, ys, [[-1, -1, B + 1, lz + 1.5], [wp / 2 - 2, lz + H - hb - 2, wp + 2, lz + H + 2], [B - wp - 2, lz + H - hb - 2, B - wp / 2 + 2, lz + H + 2]],
     false, 0, pads(P2, xs, ys), occ(P2, 0, 0)];

// Seitenbalken: lokal u entlang des Balkens, Zapfen am vorderen Ende (rechts: u < 0, links: u > Lp), auf der Bettseite
module pfette_lokal(re) {
    linear_extrude(wp) {
        rect2([0, H - hb, Lp, H - 0.05]);
        if (re) sbar([wk / 2, H - hb - kb], [kb, H - hb / 2], wk); else sbar([Lp - wk / 2, H - hb - kb], [Lp - kb, H - hb / 2], wk);
    }
    translate([re ? -lpf : Lp - e, H - hb * 0.75, 0]) cube([lpf + e, hb / 2, wp / 2]);
}
module pfette_welt(re) if (re) translate([B - wp, t_p, z_f]) rotate([90, 0, 90]) pfette_lokal(true);
                       else translate([wp, P - 0.05, z_f]) rotate([90, 0, -90]) pfette_lokal(false);
module pfette_druck(re) translate([lpf + 1, -(H - hb - kb) + wk, 0]) pfette_lokal(re);

// =====================================================================
//  DACH  (lokal: x = Firstrichtung, y = s entlang der Unterseite ab Traufe,
//         z = Dicke; Unterseite auf dem Bett, Pfannen oben)
// =====================================================================
cc = [S_r + t_r * ta + rc * 0.35 * sin(dachneigung), t_r + rc * 0.35 * cos(dachneigung)];
function dprof() = let(st = S_r - rc * 0.9, n = floor(st / tr_p))
    concat([[0, 0], [S_r, 0], [S_r + t_r * ta, t_r], [st, t_r]],
           [for (k = [n - 1 : -1 : 0]) each [[(k + 1) * tr_p, t_r], [k * tr_p, t_r + dt]]]);
module dach_2d() {
    polygon(dprof());
    intersection() { translate(cc) circle(r = rc, $fn = 32); polygon([[-1, 0], [S_r, 0], [S_r + 50 * ta, 50], [-1, 50]]); }
}
// Giebelnuten (Welt-y von .. bis): Veranda-Giebel, Front, Rückwand
DN = [[0, t_p], [P, P + t_w], [D - t_w, D]];
function xl(h, y) = h == "l" ? D + o_g - y : y + o_g;
s_e = o_e / cos(dachneigung);
// Farbbereiche als 2D-Profile (Vorschau-sicher): B = weiße Unterschicht, Traufbrett, Ortgang
module prof_bz(rand) if (rand) translate([-1, -1]) square([S_r + 60, z_fb + 1]);
    else union() { translate([-1, -1]) square([S_r + 60, t_wl + 1]); translate([-1, -1]) square([w_f + 1, z_fb + 1]); }
module prof(fp, rand) if (fp == "A") difference() { dach_2d(); prof_bz(rand); } else intersection() { dach_2d(); prof_bz(rand); }
module dach_roh(fp) rotate([90, 0, 90]) {
    translate([0, 0, w_f]) linear_extrude(RX - 2 * w_f, convexity = 12) prof(fp, false);
    for (z = [0, RX - w_f]) translate([0, 0, z]) linear_extrude(w_f, convexity = 12) prof(fp, true);
}
module dach_lokal(h, fp = "alle") difference() {
    union() { if (inc(fp, "A")) dach_roh("A"); if (inc(fp, "B")) dach_roh("B"); }
    for (d = DN) let(a = min(xl(h, d[0]), xl(h, d[1])) - spiel, b = max(xl(h, d[0]), xl(h, d[1])) + spiel)
        translate([a, s_e - spiel, -1]) cube([b - a, S_r + 10, gr + 1]);
    for (x = [tc_p : tc_p : RX - tc_p / 2]) translate([x - cg / 2, -1, t_r - gdr]) cube([cg, S_r - rc * 0.9 + 1, dt + gdr + 1]);
}
// linke Hälfte: Traufe bei x = -o_e, First bei x = B/2; rechte Hälfte = um 180° gedreht
module dach_place() translate([0, D, 0]) rotate(-90) translate([-o_g, -o_e, z_f + H - o_e * ta]) rotate([dachneigung, 0, 0]) children();
module dach_welt(h, fp = "alle") {
    if (h == "l") dach_place() dach_lokal(h, fp);
    else translate([B / 2, D / 2, 0]) rotate(180) translate([-B / 2, -D / 2, 0]) dach_place() dach_lokal(h, fp);
}
function info_dach(h) = let(kp = [for (d = DN) let(a = min(xl(h, d[0]), xl(h, d[1])), b = max(xl(h, d[0]), xl(h, d[1]))) [a - 1.5, s_e - 1.5, b + 1.5, RYl + 1]])
    [RX, RYl, seams_at(RX, [for (k = kp) [k[0] - cL, k[2] + cL]], mw), seams_at(RYl, [], mw), kp, false, 0, [[0, 0, RX, S_r - 0.5]], [], 30];

// =====================================================================
//  BODENPLATTE (Terrasse, A) mit Sockel (B)
// =====================================================================
FX = [B * 0.2, B * 0.8];
module platte_A() difference() {
    translate([-m_l, -m_v, 0]) cube([BX, BY, t_bp]);
    translate([0, 0, t_bp - pd]) linear_extrude(pd + 1) difference() {
        union() {
            for (x = [-m_l + pp : pp : B + m_r - 0.5]) translate([x - pwd / 2, -m_v - 1]) square([pwd, BY + 2]);
            for (y = [-m_v + pp : pp : D + m_h - 0.5]) translate([-m_l - 1, y - pwd / 2]) square([BX + 2, pwd]);
        }
        square([B, D]);
    }
    if (rennbahn_taschen) {
        translate([-m_l, D / 2, 0]) rb_slot();
        translate([B + m_r, D / 2, 0]) rotate(180) rb_slot();
        for (x = FX) translate([x, -m_v, 0]) rotate(90) rb_slot();
    }
}
module sockel_B() difference() {
    translate([0, 0, t_bp]) cube([B, D, h_s]);
    translate([0, 0, z_f - g_n]) linear_extrude(g_n + 1) difference() {
        offset(delta = spiel) for (k = concat(WK, BK)) rect2(WFP(k));
        translate([du0 + spiel, P - 1]) square([du1 - du0 - 2 * spiel, t_w + 2]);
    }
    for (u = [wp / 4, B - wp * 3 / 4]) translate([u - spiel, -spiel, z_f - lz - 0.3]) cube([wp / 2 + 2 * spiel, t_p + 2 * spiel, lz + 1]);
    translate([u_ax, P + t_w / 2, z_f - (lpb - gv) - 0.3]) cylinder(d = dp + 2 * spiel, h = lpb + 1, $fn = 16);
}
module bodenplatte(fp = "alle") { if (inc(fp, "A")) platte_A(); if (inc(fp, "B")) sockel_B(); }
module platte_druck(fp = "alle") translate([m_l, m_v, 0]) bodenplatte(fp);
function info_platte() = let(kp = rennbahn_taschen ? concat(
        [[-1, m_v + D / 2 - cw1, cL + 1, m_v + D / 2 + cw1], [BX - cL - 1, m_v + D / 2 - cw1, BX + 1, m_v + D / 2 + cw1]],
        [for (x = FX) [m_l + x - cw1, -1, m_l + x + cw1, cL + 1]]) : [])
    [BX, BY, seams_at(BX, [], mw), seams_at(BY, [], mw), kp, false, 0, [], [], 30];

// =====================================================================
//  Zusammenbau
// =====================================================================
module zubehoer_welt() {
    translate([BANK[0], BANK[1], t_bp]) color(fhex(farbe_bank)) bank3d();
    translate([STUHL[0], STUHL[1], z_f]) rotate(STUHL[2]) color(fhex(farbe_stuhl)) stuhl3d();
    for (p = KUEBEL) translate(p) { color(fhex(farbe_kuebel)) kuebel3d("A"); color(fhex(farbe_pflanze)) kuebel3d("B"); color(fhex(farbe_blueten)) kuebel3d("C"); }
}
module gartenhaus(ex = 0) {
    color(fhex(farbe_platten)) bodenplatte("A"); color(fhex(farbe_sockel)) bodenplatte("B");
    translate([0, 0, ex]) {
        for (k = WK) { color(fhex(farbe_wand)) wand_welt(k, "A"); color(fhex(farbe_holzwerk)) wand_welt(k, "B"); color(fhex(farbe_glas)) wand_welt(k, "C"); }
        color(fhex(farbe_holzwerk)) tuer_welt("A"); color(fhex(farbe_griff)) tuer_welt("B");
        for (k = BK) color(fhex(farbe_bruestung)) wand_welt(k);
    }
    translate([0, 0, ex * 1.7]) color(fhex(farbe_holzwerk)) { portal_welt(); pfette_welt(false); pfette_welt(true); }
    if (dach_zeigen) translate([0, 0, ex * 2.8]) for (h = ["l", "r"]) { color(fhex(farbe_dach)) dach_welt(h, "A"); color(fhex(farbe_holzwerk)) dach_welt(h, "B"); }
    if (zubehoer_zeigen && zubehoer) zubehoer_welt();
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
BN = len(BK) > 0 ? ["br_vl", "br_vr", "br_sl"] : [];     // je Form ein Teil (Seite 2x)
INFOS = concat([["bodenplatte", info_platte(), 1]], [for (k = WK) [str("wand_", k), info_wand(k), 1]],
               [for (k = BN) [bk_name(k), info_wand(k), k == "br_sl" ? 2 : 1]],
               [["rahmen_giebel", info_portal(), 1], ["dach_links", info_dach("l"), 1], ["dach_rechts", info_dach("r"), 1]]);
CLIPS = lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
cpp = floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3));
function np_of(n) = [for (i = INFOS) if (i[0] == n) n_pieces(i[1])][0];

echo(str("Gartenhaus 1:", den, " | Haus ", r2(B), " x ", r2(D), " mm (Veranda ", r2(P), ") | Firsthöhe ", r2(z_f + H_f + t_r / cos(dachneigung) + rc), " mm | Bodenplatte ",
         r2(BX), " x ", r2(BY), " mm | Wand ", r2(t_w), " mm, Dach ", r2(t_r), " mm"));
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
if (CLIPS > 0) echo(str("Verbinder-Clips gesamt: ", CLIPS, CLIPS > cpp ? str(" -> ", ceil(CLIPS / cpp), " Clip-Platten") : ""));

druck("bodenplatte", np_of("bodenplatte"), "A", farbe_platten, 1); druck("bodenplatte", np_of("bodenplatte"), "B", farbe_sockel, 1);
for (k = WK) let(n = str("wand_", k)) {
    druck(n, np_of(n), has_B(k) ? "A" : "alle", farbe_wand, 1);
    if (has_B(k)) druck(n, np_of(n), "B", farbe_holzwerk, 1);
    if (len(FEN(k)) > 0) druck(n, np_of(n), "C", farbe_glas, 1);
}
druck("tuer", 1, "A", farbe_holzwerk, 1); druck("tuer", 1, "B", farbe_griff, 1);
for (k = BN) druck(bk_name(k), np_of(bk_name(k)), "alle", farbe_bruestung, k == "br_sl" ? 2 : 1);
druck("rahmen_giebel", np_of("rahmen_giebel"), "alle", farbe_holzwerk, 1);
druck("pfette_links", 1, "alle", farbe_holzwerk, 1); druck("pfette_rechts", 1, "alle", farbe_holzwerk, 1);
for (h = ["links", "rechts"]) { druck(str("dach_", h), np_of(str("dach_", h)), "A", farbe_dach, 1); druck(str("dach_", h), np_of(str("dach_", h)), "B", farbe_holzwerk, 1); }
if (zubehoer) {
    druck("bank", 1, "alle", farbe_bank, 1); druck("stuhl", 1, "alle", farbe_stuhl, 1);
    druck("kuebel", 1, "A", farbe_kuebel, len(KUEBEL)); druck("kuebel", 1, "B", farbe_pflanze, len(KUEBEL)); druck("kuebel", 1, "C", farbe_blueten, len(KUEBEL));
}
if (CLIPS > 0) druck("verbinder", ceil(CLIPS / cpp), "alle", farbe_clips, 1);
farben_echo();

if (teil == "aufbau") gartenhaus();
else if (teil == "explosion") gartenhaus(max(M(1.3), 14));
else if (teil == "bodenplatte") split_out(info_platte(), stueck) platte_druck(farbteil);
else if (teil == "tuer") tuer_druck(farbteil);
else if (teil == "rahmen_giebel") split_out(info_portal(), stueck) { translate([0, lz, 0]) portal_lokal(); linear_extrude(t_p) for (r = info_portal()[7]) rect2(r); }
else if (teil == "pfette_links") pfette_druck(false);
else if (teil == "pfette_rechts") pfette_druck(true);
else if (teil == "dach_links") split_out(info_dach("l"), stueck) dach_lokal("l", farbteil);
else if (teil == "dach_rechts") split_out(info_dach("r"), stueck) dach_lokal("r", farbteil);
else if (teil == "bank") translate([M(0.7, 7) + 1, M(0.3, 3) + 1, 0]) bank3d();
else if (teil == "stuhl") translate([M(0.25, 3) + 1, M(0.25, 3) + 1, 0]) stuhl3d();
else if (teil == "kuebel") translate([M(0.25, 3) + 1, M(0.25, 3) + 1, 0]) kuebel3d(farbteil);
else if (teil == "verbinder") verbinder_platten(verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4), stueck);
for (k = WK) if (teil == str("wand_", k)) split_out(info_wand(k), stueck) wand_druck(k, farbteil);
for (k = BN) if (teil == bk_name(k)) split_out(info_wand(k), stueck) wand_druck(k);
