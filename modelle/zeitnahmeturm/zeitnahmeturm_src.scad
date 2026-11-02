// =====================================================================
//  ZEITNAHMETURM (Race Control)  –  zerlegbarer Deko-Bausatz
//  Rechteckiger Turm mit 3 Geschossen: Technikraum (EG), Zeitnahme-Etage,
//  darüber die verglaste Kanzel im Flughafen-Tower-Stil (schräge Glas-
//  wände, Rennsport-Optik mit Zielflaggen-Band und Schild RACE CONTROL).
//  Außen eine umlaufende Stahltreppe mit Eck-Podesten bis zur Kanzel.
//  Reihe Rennbahn-Deko: alle gängigen Maßstäbe, FDM-optimiert
//  (stützfrei), zu große Teile werden automatisch geteilt (Clips),
//  Stecksystem kompatibel zu rennbahn_deko.scad, Farben je Bauteil
//  (Vorschau, Dateinamen, 3MF über farb_export.py)
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    bodenplatte       Platz (Asphalt) mit Sockel, Nuten für die Technikraum-Wände
//    eg_wand_*         Technikraum: Stahltür, Fenster, Lüftungsgitter (vorne/links/rechts/hinten)
//    decke_1           Decke über dem Technikraum (roter Rand)
//    og_wand_*         Zeitnahme-Etage: Fenster, Tür zum Podest
//    decke_2           Zielflaggen-Band (Karo, rote Streifen) = Boden der Kanzel
//    kanzel_front      schräge Glaswand der Kanzel, vorne und hinten (2x)
//    kanzel_links / kanzel_rechts   schräge Glaswände der Seiten (rechts mit Glastür)
//    dach              Kanzeldach mit rotem Rand
//    schild            Schild RACE CONTROL auf dem Dach
//    pult              Zeitnahme-Pult in der Kanzel
//    fahne             Fahnenmast mit Zielflagge (Dach hinten rechts)
//    treppe_1 .. 4     Treppenläufe (Stahl, Geländer außen)
//    podest_1 .. 4     Eck-Podeste (mit Löchern für die Geländer-Zapfen)
//    gelaender_1 .. 4  Podest-Geländer: geschlossene Rahmen, flach liegend gedruckt, gesteckt
//    stuetze_1 .. 4    Stützen unter den Podesten
//    verbinder         Clips für alle geteilten Teile
//
//  TREPPE: läuft gegen den Uhrzeigersinn um den Turm: rechts hoch, hinten zum
//  Podest an der Zeitnahme-Tür (links hinten), links und vorne weiter bis zum
//  Podest vor der Glastür der Kanzel (rechts vorne).
//
//  BEWEGLICH / ZERLEGBAR
//    * Alle Geschosse sind nur gesteckt: Dach, Kanzel, Etagen abheben und
//      hineinschauen.
//
//  MONTAGE (Kurzfassung)
//    1. Bodenplatte, Technikraum-Wände in die Sockelnut, Decke 1 auflegen.
//    2. Etagen-Wände in Decke 1, Zielflaggen-Band (Decke 2) auflegen.
//    3. Kanzel-Glaswände in die schräge Nut, Dach auflegen, Schild stecken.
//    4. Stützen in die Bodenplatte, Treppen und Podeste mit den Zapfen in
//       die Löcher der Wände/Decken stecken, Geländer in die Podeste stecken.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, bodenplatte:Bodenplatte mit Sockel, eg_wand_vorne:Technikraum vorne (Stahltür), eg_wand_links:Technikraum links, eg_wand_rechts:Technikraum rechts, eg_wand_hinten:Technikraum hinten, decke_1:Decke 1, og_wand_vorne:Etage vorne, og_wand_links:Etage links (Tür), og_wand_rechts:Etage rechts, og_wand_hinten:Etage hinten, decke_2:Zielflaggen-Band (Decke 2), kanzel_front:Kanzel Glaswand vorne/hinten, kanzel_links:Kanzel Glaswand links, kanzel_rechts:Kanzel Glaswand rechts (Tür), dach:Kanzeldach, schild:Schild, pult:Zeitnahme-Pult, fahne:Fahnenmast mit Zielflagge, treppe_1:Treppe 1 (rechts), treppe_2:Treppe 2 (hinten), treppe_3:Treppe 3 (links), treppe_4:Treppe 4 (vorne), podest_1:Podest 1 (rechts hinten), podest_2:Podest 2 (links hinten), podest_3:Podest 3 (links vorne), podest_4:Podest 4 (rechts vorne), gelaender_1:Geländer Podest 1, gelaender_2:Geländer Podest 2, gelaender_3:Geländer Podest 3, gelaender_4:Geländer Podest 4, stuetze_1:Stütze 1, stuetze_2:Stütze 2, stuetze_3:Stütze 3, stuetze_4:Stütze 4, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Mehrfarbige Teile: alle oder einzelne Farbe (A = Grundkörper)
farbteil = "alle"; // [alle, A, B, C, D]

/* [Vorschau] */
dach_zeigen = true;
treppe_zeigen = true;

/* [Turm (Vorbild in Metern)] */
turm_breite_m = 4.0;
turm_tiefe_m = 3.2;
hoehe_technik_m = 3.0;
hoehe_etage_m = 2.7;
hoehe_kanzel_m = 2.6;
// Neigung der Glaswände nach außen
kanzel_neigung = 15;  // [5:1:25]
decke_m = 0.3;
band_m = 0.7;
dach_ueberstand_m = 0.4;
kanzel_felder_vorne = 4; // [2:1:6]
kanzel_felder_seite = 3; // [2:1:5]
treppe_breite_m = 1.0;
podest_laenge_m = 1.3;
sockel_hoehe_m = 0.15;
platz_rand_m = 0.6;
platz_vorne_m = 1.4;
schild_text = "RACE CONTROL";
schild_font = "Liberation Sans:style=Bold Italic";
pult = true;
// Fahnenmast mit Zielflagge auf dem Dach
fahne = true;
fahne_hoehe_m = 2.4;

/* [Farben] */
farbe_technik     = "puderblau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_etage       = "weiss";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_rahmen      = "orange";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_glas        = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_decke       = "weiss";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_streifen    = "orange";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_karo        = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kanzel      = "puderblau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_kanzel_karo = "orange";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_dach        = "weiss";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_dachrand    = "orange";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schild      = "puderblau";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schrift     = "orange";       // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_treppe      = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_gelaender   = "orange";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_stuetzen    = "orange";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_mast        = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_fahne_1     = "weiss";     // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_fahne_2     = "schwarz";   // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_pult        = "anthrazit"; // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_platz       = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_sockel      = "silber";    // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_clips       = "grau";      // [rot, gelb, blau, hellblau, puderblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

/* [Druck & Passung] */
rennbahn_taschen = true;
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
verbinder_anzahl = 0;

include <../../lib/deko_grundlagen.scad>

// =====================================================================
//  Maße  (Welt: x = Breite links -> rechts, y = vorne 0 -> hinten D, z = 0 Unterseite Platte)
// =====================================================================
W   = M(turm_breite_m, 30);
D   = M(turm_tiefe_m, 25);
H0  = M(hoehe_technik_m, 20);
H1  = M(hoehe_etage_m, 18);
Hc  = M(hoehe_kanzel_m, 18);
ac  = kanzel_neigung;
g_n = max(sc(60), 1.2);  tg = g_n - spiel;       // Nut / Feder
hp   = max(M(0.1), 1.4);        // Zapfen in Wand / Decke
td1 = max(M(decke_m), 2 * g_n + hp + 1.0);
tb2 = max(M(band_m), 2 * g_n + 2.4);
h_s = max(M(sockel_hoehe_m), g_n + 0.6);
t_bp = max(M(0.15), b_cl + 0.4);
z_f  = t_bp + h_s;              // Fußboden Technikraum
z_d1 = z_f + H0;  z1 = z_d1 + td1;  z_d2 = z1 + H1;  z2 = z_d2 + tb2;  zr = z2 + Hc;
w_split = max(W, H0 + 2 * g_n) > usable;
t_w  = max(M(0.12), 2.4, w_split ? b_cl : 0);
fk   = Hc * tan(ac);            // Ausladung der Kanzel oben
// Kanzel
k_split = W + 2 * fk > usable || Hc / cos(ac) > usable;
tc   = max(M(0.1), 2.4, k_split ? b_cl : 0);  tc_h = tc / cos(ac);
tgc  = g_n;
o_r  = M(dach_ueberstand_m, 2);
t_rf = max(M(0.3), 2.4 + g_n);
z_top = zr + t_rf;
RX0 = -fk - tgc * tan(ac) - o_r; RX1 = W - RX0; RY0 = RX0; RY1 = D - RX0;
// Treppe
sw   = M(treppe_breite_m, 8);
Lpod = M(podest_laenge_m, 10);
a_ex = M(0.6, 5);
g_f  = max(M(0.03), max(sc(40), 0.6) + 0.3, max(sc(15), 0.3) * 2.5 + 0.3);   // Luft zwischen Treppe und Wand (über Fensterbank/Gitter)
tl   = max(M(0.2), 1.6, g_n + 0.4 + hp);   // Podestdicke (Zapfen unter der Wandnut)
wp   = M(0.15, 2.0);            // Stütze
lz   = t_bp - 1.0;              // Zapfen in die Platte
lp   = t_w - 0.4;
h_g  = M(1.0, 6);               // Geländerhöhe
br   = max(M(0.05), 0.8);       // Geländerstab
r_s  = M(0.19);                 // Steigung (Soll)
d_s  = M(0.12, 1.2);            // Wange unter der Stufenlinie
tt   = max(M(0.05), 1.0);       // Trittstufe
// Platz
m_p = M(platz_rand_m, 4); m_v = M(platz_vorne_m, 8);
PX0 = -g_f - sw - m_p; PX1 = W + g_f + sw + m_p; PY0 = -g_f - sw - m_v; PY1 = D + g_f + sw + m_p;
BX = PX1 - PX0; BY = PY1 - PY0;
// Treppenhöhen
run_a = D - a_ex; run_b = W + 2 * g_f;  za = t_bp + (z1 - t_bp) * run_a / (run_a + run_b);
run_c = D - Lpod + g_f; run_d = W + g_f - a_ex; zc = z1 + (z2 - z1) * run_c / (run_c + run_d);
// Fenster/Tür-Details
fr = max(M(0.07), 0.8); fs = max(sc(40), 0.6); dm = max(sc(15), 0.3); gdp = max(min(sc(12), 0.6), 0.3); f_gw = max(sc(15), 0.4); ds = max(sc(40), 0.6);
tg_l = 0.6;

include <../../lib/deko_hilfen.scad>

// =====================================================================
//  WÄNDE  (e = 0 Technikraum, 1 Etage; lokal u, v, w wie im Gartenhaus)
// =====================================================================
SIDES = ["vorne", "links", "rechts", "hinten"];
function wl(s) = (s == "vorne" || s == "hinten") ? W : D - 2 * t_w;
function wh(e) = e == 0 ? H0 : H1;
function wz(e) = e == 0 ? z_f : z1;
function wname(e, s) = str(e == 0 ? "eg_wand_" : "og_wand_", s);
function OPN(e, s) = let(L = wl(s)) e == 0 ? (
      s == "vorne"  ? [["T", W / 2 - M(0.5), 0, W / 2 + M(0.5), M(2.1)], ["F", W * 0.17 - M(0.35), M(1.5), W * 0.17 + M(0.35), M(2.1)]] :
      s == "links"  ? [["F", L * 0.3 - M(0.35), M(1.5), L * 0.3 + M(0.35), M(2.1)], ["L", L * 0.7 - M(0.3), M(0.4), L * 0.7 + M(0.3), M(0.9)]] :
      s == "rechts" ? [["L", L * 0.5 - M(0.3), M(2.0), L * 0.5 + M(0.3), M(2.5)]] :
                      [["L", L * 0.5 - M(0.3), M(2.2), L * 0.5 + M(0.3), M(2.65)]])
    : (s == "vorne"  ? [for (c = [0.27, 0.73]) ["F", W * c - M(0.5), M(0.9), W * c + M(0.5), M(2.1)]] :
       s == "links"  ? [["T", max(M(0.25) - t_w, fr + 0.6), 0, max(M(0.25) - t_w, fr + 0.6) + M(0.9), M(2.0)]] :
                       [["F", L / 2 - M(0.5), M(0.9), L / 2 + M(0.5), M(2.1)]]);
function has_F(e, s) = len([for (o = OPN(e, s)) if (o[0] == "F") 1]) > 0;

// Zapfen (Treppen, Podeste) -> Ziel: Wand oder Decke
function tgt(z) = (z - hp / 2 > z_f + 0.6 && z + hp / 2 < z_d1 - 0.6) ? ["W", 0] : (z - hp / 2 > z_d1 + g_n + 0.3 && z + hp / 2 < z1 - g_n - 0.3) ? ["D", 1] :
                  (z - hp / 2 > z1 + 0.6 && z + hp / 2 < z_d2 - 0.6) ? ["W", 1] : (z - hp / 2 > z_d2 + g_n + 0.3 && z + hp / 2 < z2 - g_n - 0.3) ? ["D", 2] : ["X", 0];
function u_of(s, c) = s == "vorne" ? c : s == "hinten" ? W - c : s == "links" ? D - t_w - c : c - t_w;
function slen(s) = (s == "vorne" || s == "hinten") ? W : D;
function in_opn(e, s, u, v) = len([for (o = OPN(e, s)) if (u > o[1] - fr * 1.6 - hp / 2 - 0.5 && u < o[3] + fr * 1.6 + hp / 2 + 0.5 &&
                                                               v > o[2] - fr * 1.8 - hp / 2 - 0.5 && v < o[4] + fr + hp / 2 + 0.5) 1]) > 0;
function pin_ok(s, c, z) = let(t = tgt(z))
    t[0] == "W" ? (u_of(s, c) > hp && u_of(s, c) < wl(s) - hp && !in_opn(t[1], s, u_of(s, c), z - wz(t[1]))) :
    t[0] == "D" ? (c > t_w + hp && c < slen(s) - t_w - hp) : false;

// ---- Treppenläufe: [Seite, Start, Ende (entlang der Seite), z unten, z oben]
FL = [["rechts", 0, D - a_ex, t_bp, za], ["hinten", W + g_f, -g_f, za, z1], ["links", D - Lpod, -g_f, z1, zc], ["vorne", a_ex, W + g_f, zc, z2]];
function hv(s) = s == "vorne" ? [0, -1] : s == "rechts" ? [1, 0] : s == "hinten" ? [0, 1] : [-1, 0];
function wpt(s, c, o) = s == "rechts" ? [W + o, c] : s == "hinten" ? [c, D + o] : s == "links" ? [-o, c] : [c, -o];   // Punkt außerhalb der Wandfläche
function f_run(f) = abs(f[2] - f[1]);
function f_n(f) = max(2, round((f[4] - f[3]) / r_s));
function f_r(f) = (f[4] - f[3]) / f_n(f);
function f_g(f) = f_run(f) / f_n(f);
function f_line(f, s) = f[3] + (f[4] - f[3]) * s / f_run(f);
function f_zlo(f) = max(f[3] - d_s, t_bp);
function f_zhi(f) = f[4] + f_r(f) + h_g;
function f_pz(f, s) = f_line(f, s) - d_s / 2 + f_r(f) / 2;
function f_c(f, s) = f[1] + sign(f[2] - f[1]) * s;
FRAC = [0.22, 0.3, 0.38, 0.46, 0.54, 0.62, 0.7, 0.78, 0.86];
function f_pins(f) = let(ok = [for (q = FRAC) if (pin_ok(f[0], f_c(f, q * f_run(f)), f_pz(f, q * f_run(f)))) q],
                         lo = [for (q = ok) if (q < 0.5) q], hi = [for (q = ok) if (q > 0.5) q])
    concat(len(lo) > 0 ? [lo[0]] : [], len(hi) > 0 ? [hi[len(hi) - 1]] : []);

// ---- Podeste: [Rechteck x0,y0,x1,y1, z oben, Stützenpunkt, Wandseite, c0, c1, Geländerkanten]
PD = [[[W + g_f, D - a_ex, W + g_f + sw, D + g_f + sw], za, [W + g_f + sw - wp / 2, D + g_f + sw - wp / 2], "rechts", D - a_ex, D, ["x1", "y1"]],
      [[-g_f - sw, D - Lpod, -g_f, D + g_f + sw], z1, [-g_f - sw + wp / 2, D + g_f + sw - wp / 2], "links", D - Lpod, D, ["x0", "y1"]],
      [[-g_f - sw, -g_f - sw, a_ex, -g_f], zc, [-g_f - sw + wp / 2, -g_f - sw + wp / 2], "vorne", 0, a_ex, ["x0", "y0"]],
      [[W + g_f, -g_f - sw, W + g_f + sw, Lpod], z2, [W + g_f + sw - wp / 2, -g_f - sw + wp / 2], "rechts", 0, Lpod, ["x1", "y0", "y1"]]];
function p_pz(p) = p[1] - tl + hp / 2;
function p_pins(p) = [for (q = [0.2, 0.4, 0.6, 0.8]) let(c = p[4] + q * (p[5] - p[4])) if (pin_ok(p[3], c, p_pz(p))) c];
function p_pins2(p) = let(l = p_pins(p)) len(l) <= 2 ? l : [l[0], l[len(l) - 1]];

// alle Zapfen: [Seite, c, z]
PINS = concat([for (f = FL) for (q = f_pins(f)) [f[0], f_c(f, q * f_run(f)), f_pz(f, q * f_run(f))]],
              [for (p = PD) for (c = p_pins2(p)) [p[3], c, p_pz(p)]]);

module wand_B(e, s) for (o = OPN(e, s)) let(u0 = o[1], v0 = o[2], u1 = o[3], v1 = o[4]) {
    if (o[0] == "F") {
        translate([0, 0, t_w - gdp]) linear_extrude(gdp + dm) difference() { rect2([u0 - fr, v0 - fr, u1 + fr, v1 + fr]); rect2([u0, v0, u1, v1]); }
        translate([0, 0, t_w - gdp]) linear_extrude(gdp + dm * 2.5) rect2([u0 - fr * 1.6, v0 - fr * 1.8, u1 + fr * 1.6, v0 - fr * 0.6]);
        translate([0, 0, tg_l]) linear_extrude(t_w - tg_l + dm * 0.5) {
            difference() { rect2([u0 - e, v0 - e, u1 + e, v1 + e]); rect2([u0 + fs, v0 + fs, u1 - fs, v1 - fs]); }
            if (u1 - u0 > M(0.8)) rect2([(u0 + u1) / 2 - fs / 2, v0, (u0 + u1) / 2 + fs / 2, v1]);
        }
    }
    if (o[0] == "T") {
        translate([0, 0, t_w - gdp]) linear_extrude(gdp + dm) difference() { rect2([u0 - fr, v0, u1 + fr, v1 + fr]); rect2([u0, -1, u1, v1]); }
        difference() {
            translate([u0 - 0.01, v0, 0]) cube([u1 - u0 + 0.02, v1 - v0 + 0.01, t_w - dm]);
            for (j = [1 : 5]) translate([u0 + (u1 - u0) * 0.2, v0 + (v1 - v0) * (0.05 + j * 0.05) - f_gw / 2, t_w - dm - gdp]) cube([(u1 - u0) * 0.6, f_gw, gdp + 1]);
            translate([u0 + (u1 - u0) * 0.15, v0 + (v1 - v0) * 0.45, t_w - dm - gdp]) difference() {
                cube([(u1 - u0) * 0.7, (v1 - v0) * 0.45, gdp + 1]);
                translate([f_gw, f_gw, -1]) cube([(u1 - u0) * 0.7 - 2 * f_gw, (v1 - v0) * 0.45 - 2 * f_gw, gdp + 3]);
            }
        }
        translate([u0 + (u1 - u0) * 0.05, v0 + M(1.0), t_w - dm - e]) cube([min(M(0.04, 0.6), (u1 - u0) * 0.08), M(0.15, 1.2), dm * 2.5 + e]);
    }
    if (o[0] == "L") difference() {
        translate([0, 0, t_w - gdp]) linear_extrude(gdp + ds) rect2([u0, v0, u1, v1]);
        nl = max(2, floor((v1 - v0) / max(M(0.08), 1.2)));
        for (j = [1 : nl - 1]) translate([u0 + fr, v0 + j * (v1 - v0) / nl - f_gw / 2, t_w + ds - gdp]) cube([u1 - u0 - 2 * fr, f_gw, gdp + 1]);
    }
}
module wand_B_fp(e, s) offset(delta = 0.02) for (o = OPN(e, s)) let(u0 = o[1], v0 = o[2], u1 = o[3], v1 = o[4]) {
    if (o[0] == "F") { rect2([u0 - fr, v0 - fr, u1 + fr, v1 + fr]); rect2([u0 - fr * 1.6, v0 - fr * 1.8, u1 + fr * 1.6, v0 - fr * 0.6]); }
    if (o[0] == "T") rect2([u0 - fr, v0, u1 + fr, v1 + fr]);
    if (o[0] == "L") rect2([u0, v0, u1, v1]);
}
module wand_C(e, s) for (o = OPN(e, s)) if (o[0] == "F") linear_extrude(tg_l) rect2([o[1] - fr * 0.5, o[2] - fr * 0.5, o[3] + fr * 0.5, o[4] + fr * 0.5]);
function wpins(e, s) = [for (p = PINS) if (p[0] == s && tgt(p[2])[0] == "W" && tgt(p[2])[1] == e) [u_of(s, p[1]), p[2] - wz(e)]];
module wand_A(e, s) difference() {
    translate([0, -tg, 0]) cube([wl(s), wh(e) + 2 * tg, t_w]);
    lh = e == 0 ? max(M(0.3), 2.4) : max(M(0.15), 1.6);
    for (j = [1 : 1 : floor(wh(e) / lh - 0.01)]) translate([-1, j * lh - f_gw / 2, t_w - gdp * 0.8]) cube([wl(s) + 2, f_gw, gdp + 1]);
    for (o = OPN(e, s)) if (o[0] != "L") let(x = o[0] == "T" ? 0.02 : 0) translate([o[1] - x, o[2], -1]) cube([o[3] - o[1] + 2 * x, o[4] - o[2] + x, t_w + 2]);
    translate([0, 0, t_w - gdp]) linear_extrude(gdp + 1) wand_B_fp(e, s);
    wand_C(e, s);
    for (p = wpins(e, s)) translate([p[0] - hp / 2 - spiel, p[1] - hp / 2 - spiel, -1]) cube([hp + 2 * spiel, hp + 2 * spiel, t_w + 2]);
}
module wand_lokal(e, s, fp = "alle") {
    if (inc(fp, "A")) wand_A(e, s);
    if (inc(fp, "B")) wand_B(e, s);
    if (inc(fp, "C")) wand_C(e, s);
}
module wand_welt(e, s, fp = "alle") translate([0, 0, wz(e)]) {
    if (s == "vorne")       translate([0, t_w, 0]) rotate([90, 0, 0]) wand_lokal(e, s, fp);
    else if (s == "hinten") translate([W, D - t_w, 0]) rotate([90, 0, 180]) wand_lokal(e, s, fp);
    else if (s == "links")  translate([t_w, D - t_w, 0]) rotate([90, 0, -90]) wand_lokal(e, s, fp);
    else                    translate([W - t_w, t_w, 0]) rotate([90, 0, 90]) wand_lokal(e, s, fp);
}
module wand_druck(e, s, fp = "alle") translate([0, tg, 0]) wand_lokal(e, s, fp);
function info_wand(e, s) = let(L = wl(s), SY = wh(e) + 2 * tg, mb = cL / 2 + mw + 3,
    kp = concat([[-1, -1, L + 1, tg + 1.5], [-1, SY - tg - 1.5, L + 1, SY + 1]],
                [for (o = OPN(e, s)) if (o[0] == "F") [o[1] - fr * 1.6 - 1, o[2] + tg - fr * 1.8 - 1, o[3] + fr * 1.6 + 1, o[4] + tg + fr + 1]],
                [for (p = wpins(e, s)) [p[0] - hp - 1, p[1] + tg - hp - 1, p[0] + hp + 1, p[1] + tg + hp + 1]]),
    xs = seams_pref(L, [for (o = OPN(e, s)) if (o[0] == "F") [o[1] - fr * 1.6, o[3] + fr * 1.6]], mb),
    ys = seams_pref(SY, [for (o = OPN(e, s)) if (o[0] == "F") [o[2] + tg - fr * 2, o[4] + tg + fr]], mb))
    [L, SY, xs, ys, kp, false, 0, [[0, tg + 0.5, L, SY - tg - 0.5]]];
WALLS = [for (e = [0, 1], s = SIDES) [e, s]];
// Nähte mit großem Abstand zu Fenstern (Platz für Clips); wenn das nicht aufgeht, mit kleinem Abstand
function seams_pref(S, R, mb) = let(n0 = max(1, ceil(S / usable)) - 1, a = seams_at(S, [for (r = R) [r[0] - mb, r[1] + mb]], mw),
    b = seams_at(S, [for (r = R) [r[0] - cL / 2 - 2, r[1] + cL / 2 + 2]], mw)) (len(a) <= n0 && max_gap(a, S) <= usable) ? a : b;

// =====================================================================
//  DECKEN, KANZEL-SCHALE, DACH  (in Welt-Koordinaten, gedruckt oben = oben)
// =====================================================================
function wfp(s) = s == "vorne" ? [0, 0, W, t_w] : s == "hinten" ? [0, D - t_w, W, D] : s == "links" ? [0, t_w, t_w, D - t_w] : [W - t_w, t_w, W, D - t_w];
module nut_2d() offset(delta = spiel) for (s = SIDES) rect2(wfp(s));
// Zapfentaschen in Decke k (1/2)
module taschen(k) for (p = PINS) if (tgt(p[2])[0] == "D" && tgt(p[2])[1] == k) let(s = p[0], h = hv(s), c = p[1], z = p[2], dd = lp + 0.3)
    translate([s == "rechts" ? W - dd : s == "links" ? -1 : c - hp / 2 - spiel, s == "hinten" ? D - dd : s == "vorne" ? -1 : c - hp / 2 - spiel, z - hp / 2 - spiel])
        cube([(s == "rechts" || s == "links") ? dd + 1 : hp + 2 * spiel, (s == "vorne" || s == "hinten") ? dd + 1 : hp + 2 * spiel, hp + 2 * spiel]);
eb = max(sc(20), 0.6);                       // Farbrand-Tiefe
module rand_ring(z0, h, x = 0) translate([0, 0, z0]) linear_extrude(h) difference() { translate([-x, -x]) square([W + 2 * x, D + 2 * x]); translate([eb, eb]) square([W - 2 * eb, D - 2 * eb]); }
// Decke 1
module decke1(fp = "alle") difference() {
    union() {
        if (inc(fp, "A")) difference() { translate([0, 0, z_d1]) cube([W, D, td1]); rand_ring(z_d1 - 1, td1 + 2, 1); }
        if (inc(fp, "B")) rand_ring(z_d1, td1);
    }
    translate([0, 0, z_d1 - 1]) linear_extrude(g_n + 1) nut_2d();
    translate([0, 0, z1 - g_n]) linear_extrude(g_n + 1) nut_2d();
    taschen(1);
}
// Kanzel-Schale (Kegelstumpf, Wände nach außen geneigt)
module stumpf(off, ext = 0) hull() for (z = [z2 - tgc - ext, zr + tgc + ext]) let(d = (z - z2) * tan(ac) + off) translate([-d, -d, z]) cube([W + 2 * d, D + 2 * d, 0.01]);
module schale(off = 0) difference() { stumpf(off); stumpf(-tc_h - off, 1); }
// Decke 2 = Zielflaggen-Band
// Sichtbarer Bereich: über der Wandfeder (unten) bis zur Auflage der Kanzel (oben).
// Streifen (C) und Karo (B) liegen nur dort, sonst würden Nut und Kanzel-Auflage sie zu dünnen Rahmen beschneiden.
zv0 = z_d2 + g_n; zv1 = z2 - tgc - spiel; hb2 = zv1 - zv0;
hs2 = hb2 * 0.2; nq = 2; q2 = (hb2 - 2 * hs2) / nq;
zk0 = zv0 + hs2; zk1 = zv1 - hs2;
ce = 0.02;                                   // Karo-Felder überlappen leicht (sonst Kanten-Berührung = undicht)
cb = max(0.5, q2 * 0.14);                    // Eckbrücke: verbindet diagonal benachbarte Karo-Felder zu einem Körper
nkx = max(2, round(W / q2)); qx2 = W / nkx;  // ganze Felder je Seite (keine Splitter an den Ecken)
nky = max(2, round(D / q2)); qy2 = D / nky;
cw2 = max(0.8, eb);                          // verdeckte Ecksäule (C) hinter dem Karo: verbindet die beiden Streifen
module karo_ring(x = 0) intersection() {
    union() {
        for (j = [0 : nq - 1]) let(z0 = zk0 + j * q2) {
            for (i = [0 : nkx - 1]) if ((i + j) % 2 == 0) for (y = [-x, D - eb]) translate([i * qx2 - ce, y, z0 - ce]) cube([qx2 + 2 * ce, eb + x, q2 + 2 * ce]);
            for (i = [0 : nky - 1]) if ((i + j) % 2 == 1) for (xx = [-x, W - eb]) translate([xx, i * qy2 - ce, z0 - ce]) cube([eb + x, qy2 + 2 * ce, q2 + 2 * ce]);
        }
        for (j = [1 : nq - 1]) let(z = zk0 + j * q2) {
            for (i = [1 : nkx - 1]) for (y = [-x, D - eb]) translate([i * qx2 - cb / 2, y, z - cb / 2]) cube([cb, eb + x, cb]);
            for (i = [1 : nky - 1]) for (xx = [-x, W - eb]) translate([xx, i * qy2 - cb / 2, z - cb / 2]) cube([eb + x, cb, cb]);
        }
    }
    translate([-x - 1, -x - 1, zk0]) cube([W + 2 * x + 2, D + 2 * x + 2, zk1 - zk0]);
}
module eck_saeulen() for (c = [[0, 0, 1, 1], [W, 0, -1, 1], [0, D, 1, -1], [W, D, -1, -1]]) {
    translate([c[0] + c[2] * (eb - ce) - (c[2] < 0 ? cw2 + ce : 0), c[1] + c[3] * (eb - ce) - (c[3] < 0 ? cw2 + ce : 0), zv0]) cube([cw2 + ce, cw2 + ce, zv1 - zv0]);
    // in Höhe der Streifen bis an die Außenfläche: breite Verbindung Säule–Streifen
    for (z = [[zv0, zk0], [zk1, zv1]]) translate([c[0] - (c[2] < 0 ? eb + cw2 : 0), c[1] - (c[3] < 0 ? eb + cw2 : 0), z[0]]) cube([eb + cw2, eb + cw2, z[1] - z[0]]);
}
// Zwischen zwei Zapfenlöchern derselben Seite wäre der obere Streifen abgetrennt: dort eine weitere Säule
function d2_pins(s) = qsort([for (p = PINS) if (p[0] == s && tgt(p[2])[0] == "D" && tgt(p[2])[1] == 2) p[1]]);
module saeule_sq(s, c, t0, t1) {             // t = Tiefe ab Außenfläche, Höhe 1
    if (s == "vorne")  translate([c - cw2 / 2, t0, 0]) cube([cw2, t1 - t0, 1]);
    if (s == "hinten") translate([c - cw2 / 2, D - t1, 0]) cube([cw2, t1 - t0, 1]);
    if (s == "links")  translate([t0, c - cw2 / 2, 0]) cube([t1 - t0, cw2, 1]);
    if (s == "rechts") translate([W - t1, c - cw2 / 2, 0]) cube([t1 - t0, cw2, 1]);
}
module mitte_saeulen() for (s = SIDES) let(P = d2_pins(s)) for (k = [0 : 1 : len(P) - 2]) let(c = (P[k] + P[k + 1]) / 2) {
    translate([0, 0, zv0]) scale([1, 1, zv1 - zv0]) saeule_sq(s, c, eb - ce, eb + cw2);
    for (z = [[zv0, zk0], [zk1, zv1]]) translate([0, 0, z[0]]) scale([1, 1, z[1] - z[0]]) saeule_sq(s, c, 0, eb + cw2);
}
module streifen_2() difference() { union() { rand_ring(zv0, zk0 - zv0); rand_ring(zk1, zv1 - zk1); eck_saeulen(); mitte_saeulen(); } karo_ring(); }
module decke2(fp = "alle") difference() {
    union() {
        if (inc(fp, "A")) difference() { translate([0, 0, z_d2]) cube([W, D, tb2]); rand_ring(zv0, zk0 - zv0, 1); rand_ring(zk1, zv1 - zk1, 1); eck_saeulen(); mitte_saeulen(); karo_ring(1); }
        if (inc(fp, "B")) karo_ring();
        if (inc(fp, "C")) streifen_2();
    }
    translate([0, 0, z_d2 - 1]) linear_extrude(g_n + 1) nut_2d();
    // Auflage der Kanzel: außen offen (kein dünner Splitter vor der Glaswand)
    difference() { translate([-50, -50, z2 - tgc - spiel]) cube([W + 100, D + 100, tgc + spiel + 1]); stumpf(-tc_h - spiel, 1); }
    taschen(2);
}
// Dach
sch_w = min(W * 0.95, M(3.6)); sch_h = M(0.6, 6); sch_t = max(M(0.06), 1.6);
sch_y = RY0 + o_r * 0.5; sch_px = [W / 2 - sch_w * 0.35, W / 2 + sch_w * 0.35]; sch_pw = max(M(0.12), 2.0); sch_pl = min(t_rf - 0.8, max(M(0.12), 1.6));
module dach_rand_2d(x = 0) difference() { translate([RX0 - x, RY0 - x]) square([RX1 - RX0 + 2 * x, RY1 - RY0 + 2 * x]); translate([RX0 + eb, RY0 + eb]) square([RX1 - RX0 - 2 * eb, RY1 - RY0 - 2 * eb]); }
module dach(fp = "alle") difference() {
    union() {
        if (inc(fp, "A")) difference() { translate([RX0, RY0, zr]) cube([RX1 - RX0, RY1 - RY0, t_rf]); translate([0, 0, zr - 1]) linear_extrude(t_rf + 2) dach_rand_2d(1); }
        if (inc(fp, "B")) translate([0, 0, zr]) linear_extrude(t_rf) dach_rand_2d();
    }
    intersection() { schale(spiel); translate([-50, -50, zr - 1]) cube([W + 100, D + 100, tgc + spiel + 1]); }
    for (x = sch_px) translate([x - sch_pw / 2 - spiel, sch_y - spiel, z_top - sch_pl - 0.3]) cube([sch_pw + 2 * spiel, sch_t + 2 * spiel, sch_pl + 1]);
    if (fahne) translate([fm_x - fm_w * 0.3 - spiel, fm_y - fm_w * 0.5 - spiel, z_top - fm_pl - 0.3]) cube([fm_w * 0.6 + 2 * spiel, fm_w * 0.6 + 2 * spiel, fm_pl + 1]);
}

// ---- Kanzel-Glaswände: Schale, an den Ecken auf Gehrung geteilt, flach gedruckt ----
function KA(k) = [[0, 0], [W, 0], [W, D], [0, D]][k];
function KB(k) = [[W, 0], [W, D], [0, D], [0, 0]][k];
function KH(k) = [[0, -1], [1, 0], [0, 1], [-1, 0]][k];
function KL(k) = k % 2 == 0 ? W : D;
function KU(k) = (KB(k) - KA(k)) / KL(k);
function KV(k) = [KH(k)[0] * sin(ac), KH(k)[1] * sin(ac), cos(ac)];
function KN(k) = [KH(k)[0] * cos(ac), KH(k)[1] * cos(ac), -sin(ac)];
function KO(k) = [KA(k)[0], KA(k)[1], z2] - tc * KN(k);
function MK(k) = let(u = KU(k), v = KV(k), n = KN(k), o = KO(k)) [[u[0], v[0], n[0], o[0]], [u[1], v[1], n[1], o[1]], [0, v[2], n[2], o[2]], [0, 0, 0, 1]];
function MI(k) = let(u = [KU(k)[0], KU(k)[1], 0], v = KV(k), n = KN(k), o = KO(k)) [[u[0], u[1], u[2], -(u * o)], [v[0], v[1], v[2], -(v * o)], [n[0], n[1], n[2], -(n * o)], [0, 0, 0, 1]];
BIG = fk + tgc + tc + 2;
function KREG(k) = k == 0 ? [[-BIG, -BIG], [W + BIG, -BIG], [W - D / 2, D / 2], [D / 2, D / 2]] :
                   k == 2 ? [[D / 2, D / 2], [W - D / 2, D / 2], [W + BIG, D + BIG], [-BIG, D + BIG]] :
                   k == 3 ? [[-BIG, -BIG], [D / 2, D / 2], [-BIG, D + BIG]] : [[W + BIG, -BIG], [W + BIG, D + BIG], [W - D / 2, D / 2]];
k_vt = Hc / cos(ac); k_vp = M(0.9) / cos(ac); k_vr = (Hc - M(0.2)) / cos(ac);
k_cp = max(M(0.2), tc + 0.8); k_mw = max(M(0.1), 1.0);
function k_n(k) = k % 2 == 0 ? kanzel_felder_vorne : kanzel_felder_seite;
function k_bw(k, v) = (KL(k) + 2 * v * sin(ac) - 2 * k_cp - (k_n(k) - 1) * k_mw) / k_n(k);
function k_u(k, i, v) = -v * sin(ac) + k_cp + i * (k_bw(k, v) + k_mw);
function k_tuer(k, i) = k == 1 && i == 0;
k_vd = M(1.0) / cos(ac);                     // Querstrebe der Glastür
function k_quads(k) = [for (i = [0 : k_n(k) - 1]) each (k_tuer(k, i) ?
        [[i, 0.0, k_vd - k_mw / 2], [i, k_vd + k_mw / 2, k_vr]] : [[i, k_vp, k_vr]])];
function k_qpts(k, q, m = 0) = let(i = q[0], va = q[1], vb = q[2])
    [[k_u(k, i, va) - m, va - m], [k_u(k, i, va) + k_bw(k, va) + m, va - m], [k_u(k, i, vb) + k_bw(k, vb) + m, vb + m], [k_u(k, i, vb) - m, vb + m]];
kq = k_vp / 3;
function k_karo_ij(k) = [for (i = [0 : floor((KL(k) - 2 * k_cp) / kq) - 1], j = [0 : 2]) if ((i + j) % 2 == 0 &&
        !(k == 1 && k_cp + (i + 1) * kq > k_u(k, 0, 0) - k_mw && k_cp + i * kq < k_u(k, 0, 0) + k_bw(k, 0) + k_mw)) [i, j]];
function k_karo(k) = [for (c = k_karo_ij(k)) [k_cp + c[0] * kq, c[1] * kq]];
function has_ij(L, i, j) = len([for (c = L) if (c[0] == i && c[1] == j) 1]) > 0;
kcb = max(0.5, kq * 0.14);                   // Eckbrücken: Karo-Felder hängen als ein Gitter zusammen
function k_bruecken(k) = let(L = k_karo_ij(k)) [for (c = L) each concat(
        has_ij(L, c[0] + 1, c[1] + 1) ? [[k_cp + (c[0] + 1) * kq, (c[1] + 1) * kq]] : [],
        has_ij(L, c[0] - 1, c[1] + 1) ? [[k_cp + c[0] * kq, (c[1] + 1) * kq]] : [])];
module k_karo_2d(k, m = 0) {
    for (c = k_karo(k)) translate([c[0] - ce - m, c[1] - ce - m]) square([kq + 2 * ce + 2 * m, kq + 2 * ce + 2 * m]);
    for (b = k_bruecken(k)) translate([b[0] - kcb / 2 - m, b[1] - kcb / 2 - m]) square([kcb + 2 * m, kcb + 2 * m]);
}
module kanzel_roh(k) multmatrix(MI(k)) intersection() { schale(); translate([0, 0, z2 - tgc - 3]) linear_extrude(Hc + 2 * tgc + 6) polygon(KREG(k)); }
module kanzel_lokal(k, fp = "alle") {
    if (inc(fp, "A")) difference() {
        kanzel_roh(k);
        for (q = k_quads(k)) translate([0, 0, -1]) linear_extrude(tc + 2) polygon(k_qpts(k, q));
        for (q = k_quads(k)) translate([0, 0, -1]) linear_extrude(tg_l + 1) polygon(k_qpts(k, q, k_mw * 0.35));
        translate([0, 0, tc - 0.6]) linear_extrude(1) k_karo_2d(k);
    }
    if (inc(fp, "B")) translate([0, 0, tc - 0.6]) linear_extrude(0.59) k_karo_2d(k);
    if (inc(fp, "C")) for (q = k_quads(k)) linear_extrude(tg_l) polygon(k_qpts(k, q, k_mw * 0.35));
}
module kanzel_welt(k, fp = "alle") multmatrix(MK(k)) kanzel_lokal(k, fp);
function k_off(k) = [k_vt * sin(ac) + tc + tgc + 1, tgc / cos(ac) + tc + 1];
module kanzel_druck(k, fp = "alle") translate(concat(k_off(k), [0])) kanzel_lokal(k, fp);
function k_bars(k) = let(o = k_off(k), vb = k_vt + tgc)
    concat([[[-vb * sin(ac), k_vp / 2] + o, [KL(k) + vb * sin(ac), k_vp / 2] + o, k_vp], [[-vb * sin(ac), (k_vr + k_vt) / 2] + o, [KL(k) + vb * sin(ac), (k_vr + k_vt) / 2] + o, k_vt - k_vr]],
           [for (i = [0 : k_n(k)]) let(u0 = k_u(k, i, 0) - k_mw / 2, u1 = k_u(k, i, k_vt) - k_mw / 2) [[u0, 0] + o, [u1, k_vt] + o, max(k_mw, k_cp)]]);
function info_kanzel(k) = let(SX = KL(k) + 2 * (k_vt * sin(ac) + tc + tgc + 1), SY = k_vt + 2 * (tgc / cos(ac) + tc + 1),
    xs = seams_at(SX, [], mw), ys = seams_at(SY, [], mw))
    [SX, SY, xs, ys, [], false, 0, pads(k_bars(k), xs, ys), occ(k_bars(k), 0, 0)];

// ---- Schild auf dem Dach (lokal: x = Breite, y = Höhe, z = Dicke, Schauseite oben) ----
// Karo oben und unten mit dünnem Rand rundum: die Felder hängen als ein Körper zusammen
module schild_karo_2d() {
    nq_s = max(6, round(sch_w / (sch_h * 0.18)));  qq = sch_w / nq_s;  bl = max(0.5, qq * 0.15);
    for (i = [0 : nq_s - 1], j = [0, 1]) if ((i + j) % 2 == 0) translate([i * qq - ce, j == 0 ? 0 : sch_h - qq]) square([qq + 2 * ce, qq]);
    difference() { square([sch_w, sch_h]); translate([bl, bl]) square([sch_w - 2 * bl, sch_h - 2 * bl]); }
}
module schild_lokal(fp) {
    if (inc(fp, "A")) difference() {
        union() { cube([sch_w, sch_h, sch_t]); for (x = sch_px) translate([x - (W / 2 - sch_w / 2) - sch_pw / 2, -sch_pl, 0]) cube([sch_pw, sch_pl + e, sch_t]); }
        translate([0, 0, sch_t - 0.6]) linear_extrude(1) offset(delta = 0.02) schild_karo_2d();
    }
    if (inc(fp, "B")) translate([sch_w / 2, sch_h / 2, sch_t - e]) linear_extrude(max(sc(30), 0.6) + e)
        resize([sch_w * 0.9, 0], auto = [true, true]) text(schild_text, size = (sch_h - 2 * qq_s()) * 0.6, font = schild_font, halign = "center", valign = "center");
    if (inc(fp, "C")) translate([0, 0, sch_t - 0.6]) linear_extrude(0.6) schild_karo_2d();
}
function qq_s() = sch_w / max(6, round(sch_w / (sch_h * 0.18)));
module schild_welt(fp = "alle") translate([W / 2 - sch_w / 2, sch_y + sch_t, z_top]) rotate([90, 0, 0]) schild_lokal(fp);
module schild_druck(fp = "alle") translate([0, sch_pl, 0]) schild_lokal(fp);

// ---- Fahnenmast mit Zielflagge (flach gedruckt: Mast und Flagge in einer Ebene) ----
fm_pl = min(t_rf - 0.8, max(M(0.15), 1.6));
fm_h = min(M(fahne_hoehe_m, 20), usable - fm_pl - 4); fm_w = max(M(0.08), 1.6); fl_w = M(1.1, 10); fl_h = M(0.75, 7); fl_t = max(M(0.03), 1.0);
fm_x = RX1 - M(0.4, 3); fm_y = RY1 - M(0.4, 3);
fl_n = 6; fl_m = 4; fl_q = [fl_w / fl_n, fl_h / fl_m];
// Karo der Flagge: an jeder inneren Ecke oben eine schwarze, unten eine weiße Brücke –
// so hängen die schwarzen und die weißen Felder jeweils als ein Körper zusammen
fl_cb = max(0.5, min(fl_q[0], fl_q[1]) * 0.14);
module fahne_ecken(z0, h) for (i = [1 : fl_n - 1], j = [1 : fl_m - 1])
    translate([fm_w + i * fl_q[0] - fl_cb / 2, fm_h - fl_h + j * fl_q[1] - fl_cb / 2, z0]) cube([fl_cb, fl_cb, h]);
module fahne_zellen(x = 0) difference() {
    union() {
        for (i = [0 : fl_n - 1], j = [0 : fl_m - 1]) if ((i + j) % 2 == 0)
            translate([fm_w + i * fl_q[0] - ce, fm_h - fl_h + j * fl_q[1] - ce, -x]) cube([fl_q[0] + 2 * ce, fl_q[1] + 2 * ce, fl_t + 2 * x]);
        fahne_ecken(fl_t / 2, fl_t / 2 + x);
    }
    fahne_ecken(-x - 1, fl_t / 2 + x + 1);
}
module fahne_lokal(fp = "alle") {
    if (inc(fp, "A")) { cube([fm_w, fm_h, fm_w]); translate([fm_w * 0.2, -fm_pl, 0]) cube([fm_w * 0.6, fm_pl + e, fm_w * 0.6]);
                        translate([fm_w / 2, fm_h, 0]) cylinder(d = fm_w * 1.4, h = fm_w, $fn = 16); }
    if (inc(fp, "B")) difference() { translate([fm_w - e, fm_h - fl_h, 0]) cube([fl_w + e, fl_h, fl_t]); fahne_zellen(1); }
    if (inc(fp, "C")) intersection() { translate([fm_w, fm_h - fl_h, 0]) cube([fl_w, fl_h, fl_t]); fahne_zellen(); }
}
module fahne_welt(fp = "alle") translate([fm_x + fm_w / 2, fm_y - fm_w / 2, z_top]) rotate([90, 0, 180]) fahne_lokal(fp);
module fahne_druck(fp = "alle") translate([1, fm_pl + 1, 0]) fahne_lokal(fp);

// ---- Pult in der Kanzel ----
pu_l = W - 2 * M(0.5); pu_t = M(0.6, 5); pu_h = M(0.85, 7);
module pult3d() {
    hull() { cube([pu_l, pu_t, pu_h * 0.75]); translate([0, pu_t * 0.45, 0]) cube([pu_l, pu_t * 0.55, pu_h]); }
    for (i = [0 : 2]) translate([pu_l * (0.2 + i * 0.3) - M(0.25), pu_t * 0.6, pu_h - e]) cube([M(0.5), max(M(0.05), 0.8), M(0.35, 3)]);
}
module pult_welt() translate([M(0.5), tc_h + M(0.25), z2]) pult3d();

// =====================================================================
//  TREPPE: Läufe (auf der Außenwange gedruckt), Podeste, Stützen
// =====================================================================
t_st = max(M(0.04), 1.0);       // Wangendicke
// Profil in s (0 = unten) und z, im Druck x = run - s
module lauf_lokal(i, fp = "alle") difference() { lauf_roh(i, fp); multmatrix(lauf_mi(i)) stumpf(0.3, 1); }
module lauf_roh(i, fp = "alle") {
    f = FL[i]; R = f_run(f); n = f_n(f); r = f_r(f); g = f_g(f); zlo = f_zlo(f);
    module wange_2d() intersection() {
        polygon([[R, f[3] - d_s], [0, f[4] - d_s], [0, f[4] + r + tt * 0.5], [R, f[3] + r + tt * 0.5]]);
        translate([-1, zlo]) square([R + 2, f[4] + 10 - zlo]);
    }
    module gel_2d() {
        np = max(2, ceil(R / M(1.2)));
        for (j = [0 : np]) let(s = min(R - br / 2, max(br / 2, j * R / np))) translate([R - s - br / 2, f_line(f, s) + r]) square([br, h_g]);
        for (hh = [h_g - br, h_g * 0.5]) hull() { translate([R - 0.01, f[3] + r + hh]) square([0.01, br]); translate([0, f[4] + r + hh]) square([0.01, br]); }
    }
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(t_st, convexity = 4) wange_2d();
            translate([0, 0, sw - t_st]) linear_extrude(t_st, convexity = 4) wange_2d();
            for (k = [1 : n]) translate([R - k * g, f[3] + k * r - tt, 0]) cube([g, tt, sw]);
            for (q = f_pins(f)) translate([R - q * R - hp / 2, f_pz(f, q * R) - hp / 2, sw - e]) cube([hp, hp, g_f + lp + e]);
        }
        translate([0, 0, -1]) linear_extrude(t_st + 1.01, convexity = 8) offset(delta = 0.01) gel_2d();
    }
    if (inc(fp, "B")) linear_extrude(t_st, convexity = 8) gel_2d();
}
function lauf_m(i) = let(f = FL[i], s = f[0], h = hv(s), d = sign(f[2] - f[1]), dir = (s == "rechts" || s == "links") ? [0, d] : [d, 0], qe = wpt(s, f[2], g_f + sw))
    [[-dir[0], 0, -h[0], qe[0]], [-dir[1], 0, -h[1], qe[1]], [0, 1, 0, 0], [0, 0, 0, 1]];
function lauf_mi(i) = let(m = lauf_m(i), q = [m[0][3], m[1][3]])
    [[m[0][0], m[1][0], 0, -(m[0][0] * q[0] + m[1][0] * q[1])], [0, 0, 1, 0], [m[0][2], m[1][2], 0, -(m[0][2] * q[0] + m[1][2] * q[1])], [0, 0, 0, 1]];
module lauf_welt(i, fp = "alle") multmatrix(lauf_m(i)) lauf_lokal(i, fp);
module lauf_druck(i, fp = "alle") translate([0, -f_zlo(FL[i]) + 1, 0]) lauf_lokal(i, fp);
function lauf_bars(i) = let(f = FL[i], R = f_run(f), o = -f_zlo(f) + 1)
    [[[R, f[3] - d_s / 2 + f_r(f) / 2 + o], [0, f[4] - d_s / 2 + f_r(f) / 2 + o], d_s + f_r(f)]];
function info_lauf(i) = let(f = FL[i], SX = f_run(f), SY = f_zhi(f) - f_zlo(f) + 2, xs = seams_at(SX, [], mw), ys = seams_at(SY, [], mw), B = lauf_bars(i))
    [SX, SY, xs, ys, [for (q = f_pins(f)) [SX - q * SX - hp - 1, -1, SX - q * SX + hp + 1, SY + 1]], false, 0, pads(B, xs, ys), occ(B, 0, 0)];

// Podest: Platte, Geländer an den Außenkanten, Zapfen zur Wand (unten), Loch für die Stütze
pb_sp = max(M(0.15), 2.5);
function st_pc(i) = [PD[i][2][0] + 0.2 * wp, PD[i][2][1]];     // Mitte des Stützenzapfens
function pin_box(s, c) = s == "rechts" ? [W - lp, c - hp / 2, W + g_f + 0.05, c + hp / 2] : s == "links" ? [-g_f - 0.05, c - hp / 2, lp, c + hp / 2] :
                         s == "vorne" ? [c - hp / 2, -g_f - 0.05, c + hp / 2, lp] : [c - hp / 2, D - lp, c + hp / 2, D + g_f + 0.05];
// ---- Podest-Geländer: eigene Teile (gelaender_1..4), flach liegend gedruckt.
//      Je Podestkante ein geschlossener Rahmen (Fußleiste, Knieleiste, Handlauf, Pfosten),
//      unten Zapfen, die in Löcher im Podest gesteckt werden.
t_g  = max(br, 1.0);                          // Dicke des Geländers (im Druck: Höhe)
pz_w = max(br, 1.2);                          // Zapfenbreite
pz_l = max(1.0, min(tl - 0.9, max(M(0.15), 2.0)));   // Zapfenlänge (Loch bleibt 0,6 mm über der Unterseite)
g_ro = t_g / 2 + spiel + 0.6;                 // Geländermitte ab Podestkante (Wand neben dem Loch)
function gp_pt(r, k, a) = let(x0 = r[0] + g_ro, x1 = r[2] - g_ro, y0 = r[1] + g_ro, y1 = r[3] - g_ro)
    k == "x0" ? (a == 0 ? [x0, y0] : [x0, y1]) : k == "x1" ? (a == 0 ? [x1, y0] : [x1, y1]) :
    k == "y0" ? (a == 0 ? [x0, y0] : [x1, y0]) : (a == 0 ? [x0, y1] : [x1, y1]);
// Ecke mit einer früheren Kante: kurz davor enden; mit einer späteren: bündig bis außen; freies Ende: halber Pfosten
function gp_sh(E, r, m, a, vor) = let(p = gp_pt(r, E[m], a))
    len([for (n = [0 : len(E) - 1]) if (vor ? n < m : n > m) for (b = [0, 1]) if (norm(p - gp_pt(r, E[n], b)) < 0.01) 1]) > 0;
function gp_ext(E, r, m, a) = gp_sh(E, r, m, a, true) ? -(t_g / 2 + 0.2) : gp_sh(E, r, m, a, false) ? t_g / 2 : br / 2;
function gp_roh(i, m) = let(r = PD[i][0], E = PD[i][6], A = gp_pt(r, E[m], 0), B = gp_pt(r, E[m], 1), d = (B - A) / norm(B - A))
    [A - d * gp_ext(E, r, m, 0), B + d * gp_ext(E, r, m, 1)];
// Freiraum unter der schrägen Kanzel: Geländer endet außerhalb (Abstand d zur Turmfläche)
function gp_d(zt) = zt + h_g > z2 - tgc - 1 ? (zt + h_g - z2) * tan(ac) + 0.6 : -1e9;
function gp_clip(S, d) = let(A = S[0], B = S[1], ax = abs(B[0] - A[0]) > abs(B[1] - A[1]) ? 0 : 1, ot = 1 - ax,
        lo = -d, hi = (ax == 0 ? W : D) + d, c = A[ot], a = min(A[ax], B[ax]), b = max(A[ax], B[ax]))
    (d < -1e8 || c <= -d || c >= (ot == 0 ? W : D) + d) ? [A, B] :
    let(a2 = a < hi && b > hi ? hi : a, b2 = b > lo && a < lo ? lo : b)
    (a2 >= hi || b2 <= lo) && b2 - a2 > 3 * br ? (ax == 0 ? [[a2, c], [b2, c]] : [[c, a2], [c, b2]]) : undef;
function gp_teile(S) = let(L = norm(S[1] - S[0]), d = (S[1] - S[0]) / L, n = ceil(L / (usable - 4)))
    [for (k = [0 : n - 1]) [S[0] + d * (L * k / n + (k > 0 ? 0.1 : 0)), S[0] + d * (L * (k + 1) / n - (k < n - 1 ? 0.1 : 0))]];
function gel_panels(i) = [for (m = [0 : len(PD[i][6]) - 1]) let(S = gp_clip(gp_roh(i, m), gp_d(PD[i][1]))) if (S != undef) each gp_teile(S)];
function gp_posts(L) = let(n = max(2, ceil((L - br) / pb_sp))) [for (j = [0 : n]) br / 2 + j * (L - br) / n];
function gp_okpin(i, P) = norm(P - st_pc(i)) > wp * 0.3 + spiel + max(pz_w, t_g) / 2 + 1.0;
function gp_pins(i, S) = let(L = norm(S[1] - S[0]), d = (S[1] - S[0]) / L, ok = [for (u = gp_posts(L)) if (gp_okpin(i, S[0] + d * u)) u])
    len(ok) <= 1 ? ok : concat([ok[0]], len(ok) >= 7 ? [ok[floor(len(ok) / 2)]] : [], [ok[len(ok) - 1]]);
module gp_2d(L, pins) {
    for (u = gp_posts(L)) translate([u - br / 2, 0]) square([br, h_g]);
    for (v = [0, h_g * 0.5, h_g - br]) translate([0, v]) square([L, br]);
    for (u = pins) translate([u - pz_w / 2, -pz_l]) square([pz_w, pz_l + 0.01]);
}
function gp_mat(S, zt) = let(L = norm(S[1] - S[0]), d = (S[1] - S[0]) / L) [[d[0], 0, d[1], S[0][0]], [d[1], 0, -d[0], S[0][1]], [0, 1, 0, zt], [0, 0, 0, 1]];
module gel_welt(i) for (S = gel_panels(i)) multmatrix(gp_mat(S, PD[i][1])) translate([0, 0, -t_g / 2]) linear_extrude(t_g) gp_2d(norm(S[1] - S[0]), gp_pins(i, S));
module gel_loecher(i) for (S = gel_panels(i)) for (u = gp_pins(i, S))
    multmatrix(gp_mat(S, PD[i][1])) translate([u - pz_w / 2 - spiel, -pz_l - 0.3, -t_g / 2 - spiel]) cube([pz_w + 2 * spiel, pz_l + 1.3, t_g + 2 * spiel]);
gp_h = h_g + pz_l + 3;                        // Platzbedarf je Rahmen im Druck
function gel_stk(i) = len(gel_panels(i)) * gp_h <= usable ? 1 : len(gel_panels(i));
module gel_druck(i, stk) {
    P = gel_panels(i); one = gel_stk(i) == 1;
    for (m = [0 : len(P) - 1]) if (stk == 0 || (one ? stk == 1 : stk == m + 1))
        translate([1, (stk == 0 || one ? m * gp_h : 0) + pz_l + 1, 0]) linear_extrude(t_g) gp_2d(norm(P[m][1] - P[m][0]), gp_pins(i, P[m]));
}
module podest_welt(i, fp = "alle") difference() { podest_roh(i, fp); stumpf(0.3, 1); }
module podest_roh(i, fp = "alle") {
    p = PD[i]; r = p[0]; zt = p[1]; s = p[3];
    if (inc(fp, "A")) difference() {
        union() {
            translate([r[0], r[1], zt - tl]) cube([r[2] - r[0], r[3] - r[1], tl]);
            for (c = p_pins2(p)) let(b = pin_box(s, c)) translate([b[0], b[1], zt - tl]) cube([b[2] - b[0], b[3] - b[1], hp]);
        }
        translate([st_pc(i)[0] - wp * 0.3 - spiel, st_pc(i)[1] - wp * 0.3 - spiel, zt - tl - 1]) cube([wp * 0.6 + 2 * spiel, wp * 0.6 + 2 * spiel, min(tl - 0.6, lz) + 1.3]);
        for (x = [r[0] + max(M(0.1), 1.2) : max(M(0.1), 1.2) : r[2] - 0.5]) translate([x - f_gw / 2, r[1] - 1, zt - gdp]) cube([f_gw, r[3] - r[1] + 2, 1]);
        gel_loecher(i);
    }
}
module podest_druck(i, fp = "alle") let(r = PD[i][0]) translate([-r[0] + lp + g_f + 1, -r[1] + lp + g_f + 1, -(PD[i][1] - tl)]) podest_welt(i, fp);
function info_podest(i) = let(r = PD[i][0], o = lp + g_f + 1, SX = r[2] - r[0] + 2 * o, SY = r[3] - r[1] + 2 * o)
    [SX, SY, seams_at(SX, [], mw), seams_at(SY, [], mw), [[PD[i][2][0] - r[0] + o - wp, PD[i][2][1] - r[1] + o - wp, PD[i][2][0] - r[0] + o + wp, PD[i][2][1] - r[1] + o + wp]],
     false, 0, [[o + 0.5, o + 0.5, SX - o - 0.5, SY - o - 0.5]]];

// Stütze: steht in der Platte, Zapfen oben ins Podest
function st_h(i) = PD[i][1] - tl - t_bp;
module stuetze_lokal(i) { cube([st_h(i), wp, wp]); for (x = [-lz + 0.3, st_h(i) - e]) translate([x, wp * 0.2, 0]) cube([x < 0 ? lz - 0.3 + e : min(tl - 0.6, lz), wp * 0.6, wp * 0.6]); }
module stuetze_welt(i) translate([PD[i][2][0] + wp / 2, PD[i][2][1] - wp / 2, t_bp]) rotate([0, -90, 0]) stuetze_lokal(i);
st_oy = max(0, mw + 1 - wp / 2);               // Stütze im Druck so weit verschoben, dass Clips Platz haben
module stuetze_druck(i) translate([lz + 1, st_oy, 0]) stuetze_lokal(i);
function info_stuetze(i) = let(SX = st_h(i) + lz + 1 + 3, SY = wp + 2 * st_oy, xs = seams_at(SX, [[0, lz + 3], [SX - 6, SX]], mw), B = [[[lz + 1, st_oy + wp / 2], [lz + 1 + st_h(i), st_oy + wp / 2], wp]])
    [SX, SY, xs, [], [], false, 0, pads(B, xs, []), occ(B, 0, 0)];

// =====================================================================
//  BODENPLATTE
// =====================================================================
FXp = [W * 0.25, W * 0.75];
module bodenplatte(fp = "alle") {
    if (inc(fp, "A")) difference() {
        translate([PX0, PY0, 0]) cube([BX, BY, t_bp]);
        for (i = [0 : 3]) translate([st_pc(i)[0] - wp * 0.3 - spiel, st_pc(i)[1] - wp * 0.3 - spiel, t_bp - lz - 0.3]) cube([wp * 0.6 + 2 * spiel, wp * 0.6 + 2 * spiel, lz + 1]);
        // Startlinie vor der Treppe
        if (rennbahn_taschen) {
            translate([PX0, D / 2, 0]) rb_slot();
            translate([PX1, D / 2, 0]) rotate(180) rb_slot();
            for (x = FXp) translate([x, PY0, 0]) rotate(90) rb_slot();
        }
    }
    if (inc(fp, "B")) difference() {
        translate([0, 0, t_bp]) cube([W, D, h_s]);
        translate([0, 0, z_f - g_n]) linear_extrude(g_n + 1) nut_2d();
    }
}
module platte_druck(fp = "alle") translate([-PX0, -PY0, 0]) bodenplatte(fp);
function info_platte() = let(kp = concat(rennbahn_taschen ? concat([[-1, D / 2 - PY0 - cw1, cL + 1, D / 2 - PY0 + cw1], [BX - cL - 1, D / 2 - PY0 - cw1, BX + 1, D / 2 - PY0 + cw1]],
        [for (x = FXp) [x - PX0 - cw1, -1, x - PX0 + cw1, cL + 1]]) : [], [for (i = [0 : 3]) [PD[i][2][0] - PX0 - wp, PD[i][2][1] - PY0 - wp, PD[i][2][0] - PX0 + wp, PD[i][2][1] - PY0 + wp]]))
    [BX, BY, seams_at(BX, [], mw), seams_at(BY, [], mw), kp, false, 0, [], [], 30];
// Decken / Dach drucken (oben = oben)
module decke1_druck(fp = "alle") translate([0, 0, -z_d1]) decke1(fp);
module decke2_druck(fp = "alle") translate([0, 0, -z_d2]) decke2(fp);
module dach_druck(fp = "alle") translate([-RX0, -RY0, -zr]) dach(fp);
function kp_tasche(k) = [for (p = PINS) if (tgt(p[2])[0] == "D" && tgt(p[2])[1] == k) let(s = p[0], c = p[1])
    s == "rechts" ? [W - lp - 3, c - hp - 2, W + 1, c + hp + 2] : s == "links" ? [-1, c - hp - 2, lp + 3, c + hp + 2] :
    s == "vorne" ? [c - hp - 2, -1, c + hp + 2, lp + 3] : [c - hp - 2, D - lp - 3, c + hp + 2, D + 1]];
function info_decke(k) = [W, D, seams_at(W, [], mw), seams_at(D, [], mw), kp_tasche(k), false, 0, [[t_w + 1, t_w + 1, W - t_w - 1, D - t_w - 1]]];
function info_dach() = let(SX = RX1 - RX0, SY = RY1 - RY0, b = -RX0 - fk + tc_h + 2)
    [SX, SY, seams_at(SX, [], mw), seams_at(SY, [], mw), [], false, 0, [[b + 1, b + 1, SX - b - 1, SY - b - 1]]];

// =====================================================================
//  Zusammenbau
// =====================================================================
module wand_c(e, s) { color(fhex(e == 0 ? farbe_technik : farbe_etage)) wand_welt(e, s, "A"); color(fhex(farbe_rahmen)) wand_welt(e, s, "B"); color(fhex(farbe_glas)) wand_welt(e, s, "C"); }
module decke1_c() { color(fhex(farbe_decke)) decke1("A"); color(fhex(farbe_streifen)) decke1("B"); }
module decke2_c() { color(fhex(farbe_decke)) decke2("A"); color(fhex(farbe_karo)) decke2("B"); color(fhex(farbe_streifen)) decke2("C"); }
module kanzel_c(k) { color(fhex(farbe_kanzel)) kanzel_welt(k, "A"); color(fhex(farbe_kanzel_karo)) kanzel_welt(k, "B"); color(fhex(farbe_glas)) kanzel_welt(k, "C"); }
module dach_c() { color(fhex(farbe_dach)) dach("A"); color(fhex(farbe_dachrand)) dach("B");
                  color(fhex(farbe_schild)) schild_welt("A"); color(fhex(farbe_schrift)) schild_welt("B"); color(fhex(farbe_karo)) schild_welt("C");
                  if (fahne) { color(fhex(farbe_mast)) fahne_welt("A"); color(fhex(farbe_fahne_1)) fahne_welt("B"); color(fhex(farbe_fahne_2)) fahne_welt("C"); } }
module treppe_c() {
    for (i = [0 : 3]) { color(fhex(farbe_treppe)) lauf_welt(i, "A"); color(fhex(farbe_gelaender)) lauf_welt(i, "B");
                        color(fhex(farbe_treppe)) podest_welt(i, "A"); color(fhex(farbe_gelaender)) gel_welt(i);
                        color(fhex(farbe_stuetzen)) stuetze_welt(i); }
}
module turm(ex = 0) {
    color(fhex(farbe_platz)) bodenplatte("A"); color(fhex(farbe_sockel)) bodenplatte("B");
    translate([0, 0, ex]) for (s = SIDES) wand_c(0, s);
    translate([0, 0, 2 * ex]) decke1_c();
    translate([0, 0, 3 * ex]) for (s = SIDES) wand_c(1, s);
    translate([0, 0, 4 * ex]) decke2_c();
    translate([0, 0, 5 * ex]) { for (k = [0 : 3]) kanzel_c(k); if (pult) color(fhex(farbe_pult)) pult_welt(); }
    if (dach_zeigen) translate([0, 0, 6 * ex]) dach_c();
    if (treppe_zeigen) translate([ex * 1.5, -ex * 1.5, 0]) treppe_c();
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFOS = concat([["bodenplatte", info_platte(), 1]], [for (w = WALLS) [wname(w[0], w[1]), info_wand(w[0], w[1]), 1]],
               [["decke_1", info_decke(1), 1], ["decke_2", info_decke(2), 1], ["kanzel_front", info_kanzel(0), 2], ["kanzel_links", info_kanzel(3), 1],
                ["kanzel_rechts", info_kanzel(1), 1], ["dach", info_dach(), 1]],
               [for (i = [0 : 3]) [str("treppe_", i + 1), info_lauf(i), 1]], [for (i = [0 : 3]) [str("podest_", i + 1), info_podest(i), 1]],
               [for (i = [0 : 3]) [str("stuetze_", i + 1), info_stuetze(i), 1]]);
CLIPS = lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
cpp = floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3));
function np_of(n) = [for (i = INFOS) if (i[0] == n) n_pieces(i[1])][0];

echo(str("Zeitnahmeturm 1:", den, " | Turm ", r2(W), " x ", r2(D), " mm, Höhe bis Dach ", r2(z_top), " mm (Fahne ", r2(z_top + (fahne ? fm_h : sch_h)), ") | Platz ", r2(BX), " x ", r2(BY),
         " mm | Treppen: ", [for (f = FL) str(f_n(f), " Stufen, ", r2(atan((f[4] - f[3]) / f_run(f))), "°")]));
for (i = [0 : 3]) if (len(f_pins(FL[i])) < 2) echo(str("WARNUNG: Treppe ", i + 1, " hat nur ", len(f_pins(FL[i])), " Zapfen"));
for (i = [0 : 3]) if (len(p_pins2(PD[i])) < 1) echo(str("WARNUNG: Podest ", i + 1, " ohne Zapfen"));
for (i = [0 : 3]) for (S = gel_panels(i)) if (len(gp_pins(i, S)) < 2) echo(str("WARNUNG: Geländer ", i + 1, " hat einen Rahmen mit ", len(gp_pins(i, S)), " Zapfen"));
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
if (CLIPS > 0) echo(str("Verbinder-Clips gesamt: ", CLIPS, CLIPS > cpp ? str(" -> ", ceil(CLIPS / cpp), " Clip-Platten") : ""));

druck("bodenplatte", np_of("bodenplatte"), "A", farbe_platz, 1); druck("bodenplatte", np_of("bodenplatte"), "B", farbe_sockel, 1);
for (w = WALLS) let(n = wname(w[0], w[1])) {
    druck(n, np_of(n), "A", w[0] == 0 ? farbe_technik : farbe_etage, 1);
    druck(n, np_of(n), "B", farbe_rahmen, 1);
    if (has_F(w[0], w[1])) druck(n, np_of(n), "C", farbe_glas, 1);
}
druck("decke_1", np_of("decke_1"), "A", farbe_decke, 1); druck("decke_1", np_of("decke_1"), "B", farbe_streifen, 1);
druck("decke_2", np_of("decke_2"), "A", farbe_decke, 1); druck("decke_2", np_of("decke_2"), "B", farbe_karo, 1); druck("decke_2", np_of("decke_2"), "C", farbe_streifen, 1);
for (k = [["kanzel_front", 2], ["kanzel_links", 1], ["kanzel_rechts", 1]]) {
    druck(k[0], np_of(k[0]), "A", farbe_kanzel, k[1]); druck(k[0], np_of(k[0]), "B", farbe_kanzel_karo, k[1]); druck(k[0], np_of(k[0]), "C", farbe_glas, k[1]);
}
druck("dach", np_of("dach"), "A", farbe_dach, 1); druck("dach", np_of("dach"), "B", farbe_dachrand, 1);
druck("schild", 1, "A", farbe_schild, 1); druck("schild", 1, "B", farbe_schrift, 1); druck("schild", 1, "C", farbe_karo, 1);
if (pult) druck("pult", 1, "alle", farbe_pult, 1);
if (fahne) { druck("fahne", 1, "A", farbe_mast, 1); druck("fahne", 1, "B", farbe_fahne_1, 1); druck("fahne", 1, "C", farbe_fahne_2, 1); }
for (i = [1 : 4]) { druck(str("treppe_", i), np_of(str("treppe_", i)), "A", farbe_treppe, 1); druck(str("treppe_", i), np_of(str("treppe_", i)), "B", farbe_gelaender, 1); }
for (i = [1 : 4]) druck(str("podest_", i), np_of(str("podest_", i)), "alle", farbe_treppe, 1);
for (i = [1 : 4]) druck(str("gelaender_", i), gel_stk(i - 1), "alle", farbe_gelaender, 1);
for (i = [1 : 4]) druck(str("stuetze_", i), np_of(str("stuetze_", i)), "alle", farbe_stuetzen, 1);
if (CLIPS > 0) druck("verbinder", ceil(CLIPS / cpp), "alle", farbe_clips, 1);
farben_echo();

if (teil == "aufbau") turm();
else if (teil == "explosion") turm(max(M(1.2), 12));
else if (teil == "bodenplatte") split_out(info_platte(), stueck) platte_druck(farbteil);
else if (teil == "decke_1") split_out(info_decke(1), stueck) decke1_druck(farbteil);
else if (teil == "decke_2") split_out(info_decke(2), stueck) decke2_druck(farbteil);
else if (teil == "kanzel_front") split_out(info_kanzel(0), stueck) { kanzel_druck(0, farbteil); if (inc(farbteil, "A")) linear_extrude(tc) for (r = info_kanzel(0)[7]) rect2(r); }
else if (teil == "kanzel_links") split_out(info_kanzel(3), stueck) { kanzel_druck(3, farbteil); if (inc(farbteil, "A")) linear_extrude(tc) for (r = info_kanzel(3)[7]) rect2(r); }
else if (teil == "kanzel_rechts") split_out(info_kanzel(1), stueck) { kanzel_druck(1, farbteil); if (inc(farbteil, "A")) linear_extrude(tc) for (r = info_kanzel(1)[7]) rect2(r); }
else if (teil == "dach") split_out(info_dach(), stueck) dach_druck(farbteil);
else if (teil == "schild") schild_druck(farbteil);
else if (teil == "pult") pult3d();
else if (teil == "fahne") fahne_druck(farbteil);
else if (teil == "verbinder") verbinder_platten(verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4), stueck);
for (w = WALLS) if (teil == wname(w[0], w[1])) split_out(info_wand(w[0], w[1]), stueck) wand_druck(w[0], w[1], farbteil);
for (i = [0 : 3]) {
    if (teil == str("treppe_", i + 1)) split_out(info_lauf(i), stueck) { lauf_druck(i, farbteil); if (inc(farbteil, "A")) linear_extrude(t_st) for (r = info_lauf(i)[7]) rect2(r); }
    if (teil == str("podest_", i + 1)) split_out(info_podest(i), stueck) podest_druck(i, farbteil);
    if (teil == str("gelaender_", i + 1)) gel_druck(i, stueck);
    if (teil == str("stuetze_", i + 1)) split_out(info_stuetze(i), stueck) { stuetze_druck(i); linear_extrude(wp) for (r = info_stuetze(i)[7]) rect2(r); }
}
