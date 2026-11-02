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
