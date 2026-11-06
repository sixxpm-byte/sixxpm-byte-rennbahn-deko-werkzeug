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
//  FARBTEILE
//    Fensterglas (von innen in den Falz gedrückt) und Sockel (in die Mulde der
//    Bodenplatte gedrückt) sind gesteckt, die Pflanze steckt im Kübel – einzeln
//    druckbar. Fensterrahmen, Läden, Sprossen, Türgriff, Dachkanten und Blüten
//    sind Inlays: mit AMS/MMU – oder die 3MF einfarbig drucken.
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
// Luft je Seite für eingepresste Farbteile (Fensterglas, Sockel; 0 = sehr stramm)
einsatz_spiel = 0.05;

include <../../lib/deko_grundlagen.scad>

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

include <../../lib/deko_hilfen.scad>
include <../../lib/deko_zubehoer.scad>

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
// Glas: liegt im Falz auf der Innenseite (Druckbett), o = Presssitz-Spiel
module wand_C(k, o = 0) for (uc = FEN(k)) linear_extrude(tg_l) offset(delta = -o) rect2([uc - fb / 2 - fr * 0.5, v_s - fr * 0.5, uc + fb / 2 + fr * 0.5, v_s + fh + fr * 0.5]);
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
    if (!is_br(k) && inc(fp, "C")) wand_C(k, einsatz_spiel);
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
    translate([0, 0, t_bp - g_sk]) cube([B, D, g_sk + 1]);   // Mulde für den Sockel
    if (rennbahn_taschen) {
        translate([-m_l, D / 2, 0]) rb_slot();
        translate([B + m_r, D / 2, 0]) rotate(180) rb_slot();
        for (x = FX) translate([x, -m_v, 0]) rotate(90) rb_slot();
    }
}
g_sk = min(max(sc(40), 0.6), t_bp - 1.2);           // Sockel steckt so tief in der Bodenplatte
module sockel_B() difference() {
    translate([einsatz_spiel, einsatz_spiel, t_bp - g_sk]) cube([B - 2 * einsatz_spiel, D - 2 * einsatz_spiel, h_s + g_sk]);
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
echo(str("Steckteile: Sockel ", r2(g_sk), " mm tief in der Bodenplatte | Fensterglas ", tg_l, " mm im Falz | Einsatz-Spiel ", einsatz_spiel, " mm"));
if (g_sk < 0.5) echo("WARNUNG: Sockel-Mulde zu flach");
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
