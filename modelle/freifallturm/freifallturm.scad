// =====================================================================
//  FREIFALLTURM  –  parametrischer Kirmes-Freifallturm als Bausatz
//  Stil der Rennbahn-Deko-Reihe: FDM-optimiert (stützfrei), große Teile
//  werden automatisch geteilt (Clips), Farben je Bauteil, Maßstab 1:43 / 1:87
//  OpenSCAD >= 2021.01 (Einzeldatei, Bibliothek eingebettet)
// =====================================================================
//
//  TEILE  (teil = ...)
//    podest        Podest mit Sicherheitsring und Mastzapfen (geteilt, Clips)
//    treppe        Treppe vorne                                         1x
//    mast          Gittermast-Schuss (Gurte + Diagonalen, 2-farbig)      n x
//    gondel        Sitzring mit Sitzen und Schulterbügeln (verschiebbar) 1x
//    kopf          Maschinenhaus mit Lichtband, Dach und Fahne           1x
//    portal        Eingangsportal mit Schriftzug (flach gedruckt)        1x
//    zaun          Absperrgitter (achteckig, vorne offen)                7x
//    kasse / kasse_dach   Kassenhäuschen                                 1x
//    verbinder     Clips für das geteilte Podest
//
//  STECKSYSTEM
//    Mast-Schüsse, Podest und Maschinenhaus stecken mit Rautenzapfen
//    ineinander (Rauten-Querschnitt = stützfrei in jeder Lage).
//  BEWEGLICH
//    Der Sitzring gleitet auf dem Mast. Ein Filament-Stift (Ø stift_d) durch
//    die Bohrung im Kragen liegt auf einer Diagonale auf und hält ihn in
//    jeder Höhe – oben "vor dem Fall" oder unten beim Einsteigen.
// =====================================================================

/* [Maßstab] */
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, podest:Podest, treppe:Treppe, mast:Mast-Schuss, gondel:Sitzring, kopf:Maschinenhaus, portal:Eingangsportal, zaun:Absperrgitter, kasse:Kassenhaus, kasse_dach:Kassenhaus Dach, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
farbteil = "alle"; // [alle, A, B, C]

/* [Vorschau] */
// Höhe des Sitzrings (0 = unten, 1 = oben)
gondel_pos = 0.75; // [0:0.05:1]
zubehoer_zeigen = true;

/* [Turm (Vorbild in Metern)] */
turm_hoehe_m   = 30;     // Mastlänge über dem Podest
mast_breite_m  = 2.2;
sitze          = 16;     // [8:1:24]
ring_radius_m  = 2.6;    // Außenradius des Sitzrings
kopf_hoehe_m   = 2.8;
podest_m       = 12;
podest_hoehe_m = 0.4;
zaun_radius_m  = 3.8;    // Absperrung (Inkreis)
zaun_hoehe_m   = 1.1;
portal_breite_m = 7.5;
portal_hoehe_m  = 4.2;
portal_text = "FREEFALL";
schrift = "Liberation Sans:style=Bold";

/* [Farben] */
farbe_podest   = "anthrazit"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_linie    = "gelb";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_gurt     = "gelb";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_gitter   = "gruen";     // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_ring     = "gold";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_sitz     = "rot";       // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_buegel   = "gelb";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_kopf     = "silber";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_licht    = "rot";       // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_kopf_dach = "violett";  // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_portal   = "violett";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_schrift  = "gelb";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_birnen   = "weiss";     // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_zaun     = "silber";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_kasse    = "creme";     // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_kasse_dach = "rot";     // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_treppe   = "grau";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]
farbe_clips    = "grau";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau]

/* [Druck & Passung] */
rennbahn_taschen = true;
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
stift_d = 1.75;
// Luft zwischen Mast und Sitzring (je Seite)
ring_spiel = 0.4;

$fa = 3; $fs = 0.3;
// =====================================================================
//  RENNBAHN_LIB  –  gemeinsame Bausteine der Rennbahn-Deko-Reihe
//  Einbinden im Modell (NACH den eigenen Customizer-Parametern):
//      include <rennbahn_lib.scad>
//
//  Erwartet im Modell definiert:
//      massstab, druckbett, rand, spiel, min_wand, stift_d, schrift
//  Liefert:
//      Maßstab:   den, s, sc(mm, min), r2(), usable, e
//      Farben:    FARBEN, fhex(name), farben_echo()
//      Ausgabe:   druck(teil, stücke, farbteil, farbe, menge), inc(fp, g),
//                 mass_echo(x, y, z)  -> "MASS|x|y|z" für release.py
//      Clips:     cL cw0 cw1 ch clipd, clip(), clip_cut(), rb_slot(),
//                 verbinder_platte(n)
//      Teilung:   info = [SX,SY,Nähte x,Nähte y,Sperrflächen,von oben?,Oberkante,Körper]
//                 seams_at(), split_out(info, stück), n_pieces(), clip_count()
//      Stecker:   raute_zapfen_x(l, s), raute_tasche(depth, s)
//      Traverse:  traverse_koerper(L, w, chord, diag, fp)  (4-Punkt-Gitter)
//                 steil = true: Diagonalen mind. 45° zur Querrichtung (stehend gedruckt stützfrei)
//      Text:      text_fit(txt, size, max_w)
// =====================================================================

e    = 0.01;
den  = massstab;
s    = 1 / den;
function sc(mm, mn = 0) = max(mm * s, mn);
function r2(x) = round(x * 100) / 100;
function inc(fp, g) = fp == "alle" || fp == g;
function pol(r, a) = [r * cos(a), r * sin(a)];
function lsum(l, i = 0) = i >= len(l) ? 0 : l[i] + lsum(l, i + 1);
usable = druckbett - 2 * rand;
gap  = 0.1;

// ---------------------------------------------------------------------
//  Farben
// ---------------------------------------------------------------------
FARBEN = [["rot", "#c62828"], ["gelb", "#f9c80e"], ["blau", "#1e5bb8"], ["gruen", "#2e9d4f"], ["weiss", "#f4f4f4"],
          ["schwarz", "#222222"], ["grau", "#8a8f94"], ["silber", "#c0c4c8"], ["gold", "#d4a017"], ["orange", "#ef7d1a"],
          ["lila", "#7b3fa0"], ["rosa", "#f27fb2"], ["tuerkis", "#1fb5b0"], ["braun", "#7a4b2a"], ["holz", "#c19a6b"], ["creme", "#f3e3c3"],
          ["anthrazit", "#3a3f45"], ["cyan", "#12b5e8"], ["pink", "#e43d8f"], ["violett", "#8e3fc2"], ["neongruen", "#2ad957"],
          ["beton", "#a8a59c"], ["hellgrau", "#d0d3d6"], ["glas", "#8fb8c8"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;
module farben_echo() for (f = FARBEN) echo(str("FARBE|", f[0], "|", f[1]));

// Druckliste für farb_export.py / release.py
module druck(t, n, fp, f, m) if (m > 0) echo(str("DRUCK|", t, "|", n, "|", fp, "|", f, "|", m));
// Außenmaße des Aufbaus (mm) für Beschreibung / release.py
module mass_echo(x, y, z) echo(str("MASS|", r2(x), "|", r2(y), "|", r2(z)));

// ---------------------------------------------------------------------
//  Schwalbenschwanz-Clips (Größe abhängig vom Maßstab)
// ---------------------------------------------------------------------
function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] : d <= 20 ? [16, 6, 10, 3.2] : d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] : d <= 50 ? [10, 4, 7, 2] : [8, 3.2, 5.6, 1.6];
CT = conn_tab(den);
cL = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];
deck  = 0.8;
clipd = ch + spiel + deck;          // Mindestdicke eines Teils mit Clip-Taschen
mw  = cw1 / 2 + spiel + min_wand;
mi  = cL / 2 + 1.5;
spw = cL + 3;

module bowtie_2d() polygon([[-cL / 2, -cw1 / 2], [0, -cw0 / 2], [cL / 2, -cw1 / 2], [cL / 2, cw1 / 2], [0, cw0 / 2], [-cL / 2, cw1 / 2]]);
module clip() linear_extrude(ch) bowtie_2d();
module clip_cut(rot, top = false, zt2 = 0) rotate([0, 0, rot]) {
    if (top) translate([0, 0, zt2 - ch - spiel]) linear_extrude(ch + spiel + 1) offset(delta = spiel) bowtie_2d();
    else {
        translate([0, 0, -1]) linear_extrude(ch + spiel + 1) offset(delta = spiel) bowtie_2d();
        translate([0, 0, -1]) linear_extrude(1.3) offset(delta = spiel + 0.3) bowtie_2d();   // Elefantenfuß
    }
}
// Rennbahn-Tasche: Kante bei x = 0, Tasche nach +x (Unterseite)
module rb_slot() {
    w0 = cw0 / 2 + spiel; w1 = cw1 / 2 + spiel; l = cL / 2 + spiel;
    pts = [[-1, -w0], [0, -w0], [l, -w1], [l, w1], [0, w0], [-1, w0]];
    translate([0, 0, -e]) linear_extrude(ch + spiel + e) polygon(pts);
    translate([0, 0, -e]) linear_extrude(0.3 + e) offset(delta = 0.3) polygon(pts);
}
cpp = floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3));   // Clips pro Druckplatte
module verbinder_platte(n) {
    px = floor((usable + 3) / (cL + 3));
    for (i = [0 : n - 1]) translate([(i % px) * (cL + 3), floor(i / px) * (cw1 + 3), 0]) clip();
}

// ---------------------------------------------------------------------
//  Rechteck-Teilung mit Clips
//  info = [SX, SY, Nähte x, Nähte y, Sperrflächen, von oben?, Oberkante, Körper]
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
function clips_v(sx, a, b, kp, S, tot, sep = 30) = let(
    ok = [for (y = cand(a, b, tot, S, 0, sx)) if (okc([sx - cL / 2 - 1, y - mw, sx + cL / 2 + 1, y + mw], kp, S)) y])
    pick(ok, max(sep, 2 * mw + 2));
function clips_h(sy, a, b, kp, S, tot, sep = 30) = let(
    ok = [for (x = cand(a, b, tot, S, 1, sy)) if (okc([x - mw, sy - cL / 2 - 1, x + mw, sy + cL / 2 + 1], kp, S)) x])
    pick(ok, max(sep, 2 * mw + 2));
function n_pieces(info) = (len(info[2]) + 1) * (len(info[3]) + 1);
function clip_count(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7])
    lsum([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp, S, SY))]) +
    lsum([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp, S, SX))]);
function zero_seams(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7])
    len([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) if (len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp, S, SY)) == 0) 1]) +
    len([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) if (len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp, S, SX)) == 0) 1]);
function bad_at(v, bads) = len([for (b = bads) if (v > b[0] && v < b[1]) 1]) > 0;
function seam_pick(t, bads, lo, hi, k = 0) =
    k > 4000 ? t :
    let(d = (k % 2 == 0 ? 1 : -1) * floor((k + 1) / 2) * 0.5, v = t + d)
    (v > lo && v < hi && !bad_at(v, bads)) ? v : seam_pick(t, bads, lo, hi, k + 1);
function seams_n(S, bads, margin, n) = [for (k = [1 : 1 : n - 1]) seam_pick(k * S / n, bads, margin, S - margin)];
function max_gap(l, S) = max([for (i = [0 : len(l)]) band_b(l, i, S) - band_a(l, i)]);
function seams_at(S, bads, margin, n = 0) = let(n0 = max(1, ceil(S / usable)), nn = n == 0 ? n0 : n, l = seams_n(S, bads, margin, nn))
    (max_gap(l, S) <= usable || nn > n0 + 8) ? l : seams_at(S, bads, margin, nn + 1);
// einfache Rechteck-Info ohne Sperrflächen
function info_rect(SX, SY, kp = [], top = false, zt2 = 0) =
    [SX, SY, SX > usable ? seams_at(SX, [], mw) : [], SY > usable ? seams_at(SY, [], mw) : [], kp, top, zt2, []];
// Kinder liegen lokal in [0..SX] x [0..SY]
module split_out(info, stk) {
    SX = info[0]; SY = info[1]; xs = info[2]; ys = info[3]; kp = info[4]; top = info[5]; zt2 = info[6]; S = info[7];
    nx = len(xs) + 1; ny = len(ys) + 1;
    if (nx * ny == 1) children();
    else for (iy = [0 : ny - 1], ix = [0 : nx - 1]) {
        idx = iy * nx + ix + 1;
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

// ---------------------------------------------------------------------
//  Rauten-Stecker (stützfrei in jeder Lage)
// ---------------------------------------------------------------------
module raute_2d(a) rotate(45) square(a, center = true);
module raute_zapfen_x(l, a) rotate([0, 90, 0]) linear_extrude(l) raute_2d(a);           // entlang +x
module raute_zapfen_z(l, a) linear_extrude(l) raute_2d(a);                               // entlang +z
module raute_tasche(depth, a) linear_extrude(depth) raute_2d(a + 2 * spiel);
// Tasche nach oben offen von unten (z 0..depth) mit 45°-Spitze statt flacher Decke -> stützfrei
module raute_tasche_spitz(depth, a) let(d = (a + 2 * spiel) / sqrt(2)) {
    linear_extrude(depth) raute_2d(a + 2 * spiel);
    translate([0, 0, depth - e]) cylinder(r1 = d, r2 = 0, h = d, $fn = 4);
}

// ---------------------------------------------------------------------
//  4-Punkt-Gittertraverse  (Achse x von 0..L, Querschnitt w um y = z = 0)
//  fp "A" = Gurte + Endplatten, "B" = Diagonalen + Sprossen, "alle" = beides
//  Druck: auf einer Seite liegend (Gurte unten/oben, Diagonalen 45°)
//  steil = true: weniger, steilere Felder – stehend druckbar (ohne Sprossen, die wären schmale Brücken)
// ---------------------------------------------------------------------
module bar3(p, q, d) hull() { translate(p) cube(d, center = true); translate(q) cube(d, center = true); }
module traverse_koerper(L, w, cw, db, te = 1.0, fp = "alle", sprossen = false, steil = false) {
    yc = w / 2 - cw / 2;
    if (inc(fp, "A")) {
        for (sy = [-1, 1], sz = [-1, 1]) translate([0, sy * yc - cw / 2, sz * yc - cw / 2]) cube([L, cw, cw]);
        for (x = [0, L - te]) translate([x, -w / 2, -w / 2]) cube([te, w, w]);
    }
    if (inc(fp, "B")) {
        Li = L - 2 * te;
        n = steil ? max(1, floor(Li / (2 * yc))) : max(1, ceil(Li / (0.9 * 2 * yc)));
        q = Li / n;
        for (i = [0 : n - 1]) let(x0 = te + i * q, x1 = x0 + q, a = (i % 2 == 0 ? -1 : 1) * yc)
            for (sg = [-1, 1]) {
                bar3([x0, a, sg * yc], [x1, -a, sg * yc], db);
                bar3([x0, sg * yc, a], [x1, sg * yc, -a], db);
            }
        if (sprossen) for (i = [1 : n - 1]) let(x = te + i * q) for (sg = [-1, 1]) {
            bar3([x, -yc, sg * yc], [x, yc, sg * yc], db);
            bar3([x, sg * yc, -yc], [x, sg * yc, yc], db);
        }
    }
}

// ---------------------------------------------------------------------
//  Text, der in eine Breite passt (2D, zentriert)
// ---------------------------------------------------------------------
module text_fit(txt, size, max_w)
    resize([min(max_w, len(txt) * size * 0.72), 0], auto = [true, true])
        text(txt, size = size, font = schrift, halign = "center", valign = "center");

// =====================================================================
//  Maße  (Welt: Turmachse im Ursprung, vorne = -y, z = 0 Boden)
// =====================================================================
P    = sc(podest_m * 1000, 100);
H_p  = max(sc(podest_hoehe_m * 1000), 5, clipd + 2.4);
d_in = max(sc(30), 0.6);                       // Inlay-Tiefe (Farbeinleger)

// Mast
w    = max(sc(mast_breite_m * 1000), 18);
cw   = max(sc(250), 1.8);                      // Gurt
db   = max(sc(110), 1.0);                      // Diagonale
a_p  = 0.32 * w;                               // Rautenzapfen (Kantenlänge)
d_p  = max(3, min(8, 0.3 * w));                // Zapfenlänge / Taschentiefe
te   = 1.2;                                    // Endplatte oben
te_b = d_p + 1.2;                              // Endplatte unten (mit Tasche)
L_m  = sc(turm_hoehe_m * 1000, 120);
n_sek = ceil(L_m / (usable - d_p - 2));
L_sek = L_m / n_sek;

// Sitzring
R_r  = max(sc(ring_radius_m * 1000), w / 2 * 1.35 + 12);
bo   = w + 2 * ring_spiel;                     // Bohrung (quadratisch)
t_r  = max(sc(350), 2.4);                      // Ringplatte
t_k  = max(sc(250), 2.4);                      // Kragen-Wand
h_k  = max(sc(1400), 12);                      // Kragen-Höhe
w_s  = sc(550, 5);                             // Sitzbreite
t_b  = max(sc(80), 1.2);                       // Lehne
h_b  = sc(650, 6);                             // Lehnenhöhe
d_s  = sc(420, 4);                             // Sitztiefe
h_sp = sc(380, 3.5);                           // Sitzhöhe über Ring
d_bg = max(sc(70), 0.9);                       // Bügel
r_b  = R_r - t_b - d_s - 0.3;                  // Lehne innen
z_pin = h_k * 0.55;                            // Stiftbohrung im Kragen

// Maschinenhaus
w_kh = w * 1.45;
h_kh = sc(kopf_hoehe_m * 1000, 14);
h_kd = w_kh * 0.35;                            // Dach
h_fm = sc(2500, 14);                           // Fahnenmast

// Portal (flach gedruckt, steht mit Zapfen im Podest)
B_po = min(sc(portal_breite_m * 1000), usable - 4);
H_po = sc(portal_hoehe_m * 1000, 30);
t_po = max(sc(250), 2.4);
b_pf = max(sc(500), 4);                        // Pfeilerbreite
h_sg = H_po * 0.38;                            // Schildhöhe
Y_PO = -P / 2 + max(sc(900), 8);

// Zaun
R_z  = sc(zaun_radius_m * 1000);
H_z  = sc(zaun_hoehe_m * 1000, 8);
L_z  = 2 * R_z * tan(22.5) - 0.6;
t_z  = max(sc(60), 1.2);
p_z  = max(sc(150), 1.6);                      // Stababstand
z_tz = max(sc(250), 2.5);                      // Zapfen
h_sl = min(H_p - 1.2, max(sc(250), 2.5));      // Schlitztiefe

// Kasse
B_ka = sc(2400, 20); T_ka = sc(1800, 15); H_ka = sc(2300, 20);
t_ka = max(sc(80), 1.2);
X_KA = B_po / 2 + B_ka / 2 + sc(600, 4); Y_KA = Y_PO - sc(200);

// Treppe
w_st = sc(1600, 14); d_st = sc(300, 3);

// =====================================================================
//  PODEST
// =====================================================================
ZAUN_K = [0, 1, 2, 3, 4, 5, 7];                // Seite 6 (vorne, -y) bleibt offen
function zaun_rot(k) = k * 45;                 // Seite k: Normale bei k*45° (0 = +x)
function zaun_slot_pos(k, sg) = let(a = zaun_rot(k)) pol(R_z, a) + pol(sg * L_z / 4, a + 90);
module podest_loecher() {
    for (k = ZAUN_K, sg = [-1, 1]) let(p = zaun_slot_pos(k, sg)) translate([p[0], p[1], H_p - h_sl]) rotate(zaun_rot(k))
        translate([-t_z / 2 - spiel, -z_tz / 2 - spiel, 0]) cube([t_z + 2 * spiel, z_tz + 2 * spiel, h_sl + 1]);
    for (sg = [-1, 1]) translate([sg * (B_po / 2 - b_pf / 2), Y_PO, H_p - h_sl])
        translate([-z_tz - spiel, -t_po / 2 - spiel, 0]) cube([2 * z_tz + 2 * spiel, t_po + 2 * spiel, h_sl + 1]);
}
module tropfen(r) hull() { circle(r = r, $fn = 16); translate([r * sqrt(2) - 0.01, 0]) square(0.02, center = true); }   // Spitze +x
module sicherheitslinie_2d() let(lw = max(sc(150), 1.2), r = R_z - sc(400, 2))
    difference() { rotate(22.5) circle(r = r / cos(22.5), $fn = 8); rotate(22.5) circle(r = (r - lw) / cos(22.5), $fn = 8); }
module podest_welt(fp = "alle") {
    if (inc(fp, "A")) {
        difference() {
            translate([-P / 2, -P / 2, 0]) cube([P, P, H_p]);
            translate([0, 0, H_p - d_in]) linear_extrude(d_in + 1) sicherheitslinie_2d();
            podest_loecher();
            for (v = [-P / 2 + sc(1000, 8) : sc(1000, 8) : P / 2 - 1]) {          // Plattenfugen
                translate([v - 0.2, -P / 2 + 0.5, H_p - 0.4]) cube([0.4, P - 1, 1]);
                translate([-P / 2 + 0.5, v - 0.2, H_p - 0.4]) cube([P - 1, 0.4, 1]);
            }
            if (rennbahn_taschen) for (r = [[-P / 2, 0, 0], [P / 2, 0, 180]]) translate([r[0], r[1], 0]) rotate(r[2]) rb_slot();
        }
        translate([0, 0, H_p - e]) raute_zapfen_z(d_p - 0.3 + e, a_p);                  // Mastzapfen
    }
    if (inc(fp, "B")) translate([0, 0, H_p - d_in]) linear_extrude(d_in) sicherheitslinie_2d();
}
module podest_lokal(fp) translate([P / 2, P / 2, 0]) podest_welt(fp);
function sh(r) = [r[0] + P / 2, r[1] + P / 2, r[2] + P / 2, r[3] + P / 2];
function info_podest() = let(
    m = max(t_z, z_tz) + 3,
    kp = concat([for (k = ZAUN_K, sg = [-1, 1]) let(p = zaun_slot_pos(k, sg)) sh([p[0] - m, p[1] - m, p[0] + m, p[1] + m])],
                [for (sg = [-1, 1]) let(x = sg * (B_po / 2 - b_pf / 2)) sh([x - z_tz - 3, Y_PO - m, x + z_tz + 3, Y_PO + m])],
                [for (x = [0, P]) [x - cL - 1, P / 2 - cw1, x + cL + 1, P / 2 + cw1]]),
    hz = a_p / sqrt(2) + spw,
    xb = concat([[P / 2 - hz, P / 2 + hz]],
                [for (k = ZAUN_K, sg = [-1, 1]) let(x = zaun_slot_pos(k, sg)[0] + P / 2) [x - m - spw / 2, x + m + spw / 2]],
                [for (sg = [-1, 1]) let(x = sg * (B_po / 2 - b_pf / 2) + P / 2) [x - z_tz - spw, x + z_tz + spw]]),
    yb = concat([[P / 2 - hz, P / 2 + hz]],
                [for (k = ZAUN_K, sg = [-1, 1]) let(y = zaun_slot_pos(k, sg)[1] + P / 2) [y - m - spw / 2, y + m + spw / 2]],
                [[Y_PO + P / 2 - m - spw, Y_PO + P / 2 + m + spw]]))
    [P, P, P > usable ? seams_at(P, xb, mw) : [], P > usable ? seams_at(P, yb, mw) : [], kp, false, 0, []];

module treppe_2d() let(h = H_p / 2) polygon([[0, 0], [2 * d_st, 0], [2 * d_st, 2 * h], [d_st, 2 * h], [d_st, h], [0, h]]);
module treppe() linear_extrude(w_st) treppe_2d();
module treppe_welt() translate([-w_st / 2, -P / 2 - 2 * d_st, 0]) rotate([90, 0, 90]) treppe();

// =====================================================================
//  MAST-SCHUSS  (lokal: Achse x 0..L_sek, Tasche bei x = 0, Zapfen bei L_sek)
// =====================================================================
module mast_schuss(fp = "alle") {
    module gurte() union() {
        traverse_koerper(L_sek, w, cw, db, te, "A");
        translate([0, -w / 2, -w / 2]) cube([te_b, w, w]);
        translate([L_sek - e, 0, 0]) raute_zapfen_x(d_p - 0.3 + e, a_p);
    }
    if (inc(fp, "A")) difference() {
        gurte();
        translate([-1, 0, 0]) rotate([0, 90, 0]) raute_tasche(d_p + 1, a_p);
    }
    // Gitter: nur Diagonalen, mind. 45° steil – waagerechte Sprossen wären stehend schmale, nicht überbrückbare Stege
    if (inc(fp, "B")) difference() {
        traverse_koerper(L_sek, w, cw, db, te, "B", steil = true); gurte();
        for (x = [-w, L_sek]) translate([x, -w, -w]) cube([w, 2 * w, 2 * w]);   // Stabenden nicht über die Endplatten hinaus
    }
}
module mast_druck(fp) translate([w / 2, w / 2, 0]) rotate([0, -90, 0]) mast_schuss(fp);   // stehend: Tasche unten, Zapfen oben, Diagonalen steiler als 45°
module mast_welt(i, fp, up = 0) translate([0, 0, H_p + i * L_sek + up]) rotate([0, -90, 0]) mast_schuss(fp);

// =====================================================================
//  SITZRING  (Unterseite z = 0, Achse z)
// =====================================================================
module gondel(fp = "alle") {
    N = sitze;
    module ring_koerper() difference() {
        union() {
            rotate(180 / N) cylinder(r = R_r / cos(180 / N), h = t_r, $fn = N);
            translate([-bo / 2 - t_k, -bo / 2 - t_k, 0]) cube([bo + 2 * t_k, bo + 2 * t_k, h_k]);
        }
        translate([-bo / 2, -bo / 2, -1]) cube([bo, bo, h_k + 2]);
        translate([0, 0, z_pin]) rotate([90, 0, 90]) linear_extrude(bo + 2 * t_k + 2, center = true) rotate(90) tropfen((stift_d + 0.15) / 2);   // Spitze oben: stützfrei
        // Lichterkranz (Einleger in der Ringunterseite)
        for (i = [0 : 2 * N - 1]) rotate(i * 180 / N + 90 / N) translate([R_r - max(sc(180), 1.4), 0, -1]) cylinder(d = max(sc(140), 1.0), h = 1 + d_in, $fn = 12);
    }
    x0 = r_b + t_b; x1 = R_r - 0.3; top = h_sp + t_b;
    module sitz() {     // lokal: x radial, z ab Ringoberseite; Lehne innen, Sitz schaut nach außen
        translate([r_b, -w_s / 2, 0]) cube([t_b, w_s, h_b]);
        translate([0, w_s / 2 - 0.4, 0]) rotate([90, 0, 0]) linear_extrude(w_s - 0.8)
            polygon([[x0 - e, 0], [x0 - e, top], [x1, top], [x1, h_sp], [max(x0, x1 - h_sp), 0]]);   // 45°-Unterseite
    }
    module buegel() for (sg = [-1, 1]) let(y = sg * (w_s / 2 - d_bg / 2 - 0.3), xp = x1 - d_s * 0.3, zt = top + h_b * 0.45) {
        bar3([xp, y, top - 0.2], [xp, y, zt], d_bg);
        bar3([xp, y, zt], [x0 + t_b / 2, y, zt + (xp - x0 - t_b / 2)], d_bg);
    }
    if (inc(fp, "A")) ring_koerper();
    if (inc(fp, "B")) for (i = [0 : N - 1]) rotate(i * 360 / N) translate([0, 0, t_r - e]) sitz();
    if (inc(fp, "C")) {
        for (i = [0 : N - 1]) rotate(i * 360 / N) translate([0, 0, t_r - e]) difference() { buegel(); sitz(); }
        for (i = [0 : 2 * N - 1]) rotate(i * 180 / N + 90 / N) translate([R_r - max(sc(180), 1.4), 0, 0]) cylinder(d = max(sc(140), 1.0), h = d_in, $fn = 12);
    }
}
z_g0 = H_p + max(sc(300), 2);                                          // unterste Ringlage
z_g1 = H_p + L_m - h_k - sc(800, 6);                                   // oberste Ringlage

// =====================================================================
//  MASCHINENHAUS  (Unterseite z = 0, Tasche unten)
// =====================================================================
module kopf(fp = "alle") {
    hb = h_kh * 0.18;                                                  // Lichtband
    if (inc(fp, "A")) difference() {
        union() {
            translate([-w_kh / 2, -w_kh / 2, 0]) cube([w_kh, w_kh, h_kh]);
            translate([0, 0, h_kh + h_kd - e]) cylinder(d = max(sc(120), 1.6), h = h_fm, $fn = 12);
        }
        translate([0, 0, -1]) raute_tasche_spitz(d_p + 1, a_p);
        translate([0, 0, h_kh * 0.6]) lichtband(1);
    }
    module lichtband(x = 0) linear_extrude(hb) difference() { square(w_kh + 2 * x, center = true); square(w_kh - 2 * d_in, center = true); }
    if (inc(fp, "B")) {
        translate([0, 0, h_kh * 0.6]) lichtband();
        let(hf = sc(700, 4.5), tf = 2 * max(sc(30), 0.6)) translate([max(sc(60), 0.8) - e, tf / 2, h_kh + h_kd + h_fm - hf]) rotate([90, 0, 0])
            linear_extrude(tf) polygon([[0, 0], [0, hf], [hf * 0.95, hf]]);        // Wimpel (Unterkante 45° -> stützfrei)
    }
    if (inc(fp, "C")) translate([0, 0, h_kh - e]) rotate(45) cylinder(r1 = w_kh / 2 * sqrt(2) + 0.5, r2 = w_kh * 0.12, h = h_kd, $fn = 4);
}
module kopf_welt(fp, up = 0) translate([0, 0, H_p + L_m + up]) kopf(fp);

// =====================================================================
//  PORTAL  (flach: x Breite, y Höhe, z Dicke; Schauseite oben)
// =====================================================================
module portal_2d() {
    for (sg = [-1, 1]) translate([sg * (B_po / 2 - b_pf / 2) - b_pf / 2, 0]) square([b_pf, H_po - h_sg / 2]);
    translate([0, H_po - h_sg]) hull() {
        translate([-B_po / 2, 0]) square([B_po, h_sg * 0.6]);
        translate([0, h_sg - B_po * 0.9]) intersection() { circle(r = B_po * 0.9, $fn = 120); translate([-B_po, B_po * 0.9 - h_sg * 0.6]) square([2 * B_po, h_sg]); }
    }
}
module portal(fp = "alle") {
    ts = h_sg * 0.36;
    module schrift_2d() translate([0, H_po - h_sg * 0.52]) text_fit(portal_text, ts, B_po * 0.78);
    module birnen() {
        n = max(6, floor(B_po / max(sc(400), 3)));
        for (i = [0 : n]) translate([-B_po / 2 + b_pf * 0.3 + i * (B_po - b_pf * 0.6) / n, H_po - h_sg + b_pf * 0.3]) circle(d = max(sc(160), 1.2), $fn = 12);
        for (sg = [-1, 1], j = [0 : 5]) translate([sg * (B_po / 2 - b_pf / 2), b_pf + j * (H_po - h_sg - 1.5 * b_pf) / 5]) circle(d = max(sc(160), 1.2), $fn = 12);
    }
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(t_po) portal_2d();
            for (sg = [-1, 1]) translate([sg * (B_po / 2 - b_pf / 2) - z_tz, -h_sl + 0.3, 0]) cube([2 * z_tz, h_sl - 0.3 + e, t_po]);
        }
        translate([0, 0, t_po - d_in]) linear_extrude(1) { schrift_2d(); birnen(); }
    }
    if (inc(fp, "B")) translate([0, 0, t_po - d_in]) linear_extrude(d_in) schrift_2d();
    if (inc(fp, "C")) translate([0, 0, t_po - d_in]) linear_extrude(d_in) birnen();
}
module portal_druck(fp) translate([B_po / 2, h_sl, 0]) portal(fp);
module portal_welt(fp, up = 0) translate([0, Y_PO + t_po / 2, H_p + up]) rotate([90, 0, 0]) portal(fp);

// =====================================================================
//  ZAUN  (flach: x Länge, y Höhe, z Dicke)
// =====================================================================
module zaun() {
    rl = max(sc(80), 1.4);
    n = max(2, round(L_z / p_z));
    for (y = [0, H_z * 0.5, H_z - rl]) translate([0, y, 0]) cube([L_z, rl, t_z]);
    for (i = [0 : n]) translate([i * (L_z - rl) / n, 0, 0]) cube([rl, H_z, t_z]);
    for (sg = [-1, 1]) translate([L_z / 2 + sg * L_z / 4 - z_tz / 2, -h_sl + 0.3, 0]) cube([z_tz, h_sl - 0.3 + e, t_z]);
}
module zaun_druck() translate([0, h_sl, 0]) zaun();
module zaun_welt(k, up = 0) rotate(zaun_rot(k)) translate([R_z + t_z / 2, L_z / 2, H_p + up]) rotate([90, 0, -90]) zaun();

// =====================================================================
//  KASSE  (Kasten oben offen + Dach)
// =====================================================================
module kasse() difference() {
    translate([-B_ka / 2, -T_ka / 2, 0]) cube([B_ka, T_ka, H_ka]);
    translate([-B_ka / 2 + t_ka, -T_ka / 2 + t_ka, t_ka]) cube([B_ka - 2 * t_ka, T_ka - 2 * t_ka, H_ka]);
    // Schalter und Tür reichen bis unter das Dach (kein frei überbrückter Sturz in der dünnen Wand – das Dach ist der Sturz)
    translate([-B_ka * 0.32, -T_ka / 2 - 1, H_ka * 0.45]) cube([B_ka * 0.64, t_ka + 2, H_ka]);              // Schalter
    translate([B_ka / 2 - 1, -T_ka * 0.3, t_ka]) cube([t_ka + 2, T_ka * 0.45, H_ka]);                       // Tür
}
module kasse_dach() {
    u = max(sc(250), 2);
    cube([B_ka + 2 * u, T_ka + 2 * u, max(sc(80), 1.2)]);
    translate([B_ka / 2 + u, T_ka / 2 + u, 0]) linear_extrude(sc(700, 6), scale = 0.15) square([B_ka + 2 * u, T_ka + 2 * u], center = true);
}
module kasse_dach_druck() kasse_dach();

// =====================================================================
//  ZUSAMMENBAU
// =====================================================================
module anlage(ex = 0) {
    color(fhex(farbe_podest)) render() podest_welt("A"); color(fhex(farbe_linie)) render() podest_welt("B");
    color(fhex(farbe_treppe)) translate([0, -ex * 0.5, 0]) treppe_welt();
    for (i = [0 : n_sek - 1]) { color(fhex(farbe_gurt)) render() mast_welt(i, "A", ex * (1 + i)); color(fhex(farbe_gitter)) render() mast_welt(i, "B", ex * (1 + i)); }
    zg = z_g0 + gondel_pos * (z_g1 - z_g0);
    translate([0, 0, zg + ex * 0.5]) {
        color(fhex(farbe_ring)) render() gondel("A"); color(fhex(farbe_sitz)) render() gondel("B"); color(fhex(farbe_buegel)) render() gondel("C");
    }
    color(fhex(farbe_kopf)) render() kopf_welt("A", ex * (n_sek + 1.5)); color(fhex(farbe_licht)) render() kopf_welt("B", ex * (n_sek + 1.5));
    color(fhex(farbe_kopf_dach)) render() kopf_welt("C", ex * (n_sek + 1.5));
    for (k = ZAUN_K) color(fhex(farbe_zaun)) render() zaun_welt(k, ex * 0.6);
    if (zubehoer_zeigen) {
        color(fhex(farbe_portal)) render() portal_welt("A", ex * 0.6); color(fhex(farbe_schrift)) render() portal_welt("B", ex * 0.6);
        color(fhex(farbe_birnen)) render() portal_welt("C", ex * 0.6);
        translate([X_KA, Y_KA, H_p + ex * 0.3]) { color(fhex(farbe_kasse)) render() kasse();
            color(fhex(farbe_kasse_dach)) translate([-B_ka / 2 - max(sc(250), 2), -T_ka / 2 - max(sc(250), 2), H_ka + ex * 0.5]) render() kasse_dach(); }
    }
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFO_P = info_podest();
CLIPS = clip_count(INFO_P);
echo(str("Freifallturm 1:", den, " | Höhe ", r2(H_p + L_m + h_kh + h_kd + h_fm), " mm | Podest ", r2(P), " mm | Mast ", r2(w), " mm, ",
         n_sek, " Schüsse à ", r2(L_sek), " mm | Sitzring Ø ", r2(2 * R_r), " mm"));
echo(str("Filament-Stift Ø ", stift_d, ": 1 x ", r2(bo + 2 * t_k + 4), " mm (Sitzring)"));
if (n_pieces(INFO_P) > 1) echo(str("Teilung Podest: ", n_pieces(INFO_P), " Stücke, ", CLIPS, " Clips",
    zero_seams(INFO_P) > 0 ? str("  WARNUNG: ", zero_seams(INFO_P), " Naht/Nähte ohne Clip") : ""));
if (L_sek + d_p > usable) echo("WARNUNG: Mast-Schuss länger als das Druckbett");
if (2 * R_r > usable) echo("WARNUNG: Sitzring größer als das Druckbett");
if (r_b - d_s < bo / 2 + t_k + 0.5) echo("WARNUNG: Sitze stoßen an den Kragen – ring_radius_m erhöhen");
if (2 * PI * (r_b + t_b) < sitze * (w_s + 0.6)) echo("WARNUNG: zu viele Sitze für den Ringumfang");
if (R_z + 3 < R_r) echo("WARNUNG: Absperrung liegt innerhalb des Sitzrings");
if (R_z + t_z + 3 > P / 2) echo("WARNUNG: Absperrung ragt über das Podest");
mass_echo(P, P + 2 * d_st, H_p + L_m + h_kh + h_kd + h_fm);

druck("podest", n_pieces(INFO_P), "A", farbe_podest, 1); druck("podest", n_pieces(INFO_P), "B", farbe_linie, 1);
druck("treppe", 1, "alle", farbe_treppe, 1);
druck("mast", 1, "A", farbe_gurt, n_sek); druck("mast", 1, "B", farbe_gitter, n_sek);
druck("gondel", 1, "A", farbe_ring, 1); druck("gondel", 1, "B", farbe_sitz, 1); druck("gondel", 1, "C", farbe_buegel, 1);
druck("kopf", 1, "A", farbe_kopf, 1); druck("kopf", 1, "B", farbe_licht, 1); druck("kopf", 1, "C", farbe_kopf_dach, 1);
druck("portal", 1, "A", farbe_portal, 1); druck("portal", 1, "B", farbe_schrift, 1); druck("portal", 1, "C", farbe_birnen, 1);
druck("zaun", 1, "alle", farbe_zaun, len(ZAUN_K));
druck("kasse", 1, "alle", farbe_kasse, 1); druck("kasse_dach", 1, "alle", farbe_kasse_dach, 1);
if (CLIPS > 0) druck("verbinder", 1, "alle", farbe_clips, 1);
farben_echo();

if (teil == "aufbau") anlage();
else if (teil == "explosion") anlage(max(sc(1500), 14));
else if (teil == "podest") split_out(INFO_P, stueck) podest_lokal(farbteil);
else if (teil == "treppe") treppe();
else if (teil == "mast") mast_druck(farbteil);
else if (teil == "gondel") gondel(farbteil);
else if (teil == "kopf") kopf(farbteil);
else if (teil == "portal") portal_druck(farbteil);
else if (teil == "zaun") zaun_druck();
else if (teil == "kasse") kasse();
else if (teil == "kasse_dach") kasse_dach_druck();
else if (teil == "verbinder") verbinder_platte(max(CLIPS, 4));
