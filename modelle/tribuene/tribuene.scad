// =====================================================================
//  ZUSCHAUERTRIBÜNE  –  zerlegbarer, erweiterbarer Deko-Bausatz
//  im Stil der Rennbahn-Deko-Reihe: alle gängigen Maßstäbe,
//  FDM-optimiert (stützfrei), Teile über dem Druckbett werden automatisch
//  geteilt (Clips), Stecksystem kompatibel zu rennbahn_deko.scad,
//  Farben je Bauteil (Vorschau, Dateinamen, 3MF über farb_export.py)
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  ERWEITERBAR
//    Die Tribüne besteht aus Modulen, die Seite an Seite mit denselben
//    Schwalbenschwanz-Clips verbunden werden wie die Rennbahn-Deko.
//    Jedes Modulende hat dieselben Taschen -> jedes Modul passt an jedes.
//    "anordnung" legt die Reihenfolge fest (von links nach rechts, Blick
//    von der Strecke) – die Druckliste zählt die Teile automatisch mit:
//        B = Tribünenblock (gerade)       T = Treppe / Gang
//        K = Kurvenblock (Tribüne an der Kurvenaußenseite)
//        I = Kurvenblock (Tribüne an der Kurveninnenseite)
//    Beispiele: "BTBTB", "BTBKKBTB", "KKBTBKK"
//    Nachrüsten: einfach Buchstaben ergänzen und die neuen Teile drucken.
//
//  FARBTEILE
//    Das Glas der Geländer steckt im Falz des Rahmens (von unten eingedrückt, einzeln
//    druckbar). Schrift, Treppenkanten, Banden-Text und Fahne sind Inlays:
//    mit AMS/MMU oder die 3MF einfarbig drucken.
//
//  TEILE  (teil = ...)
//    block / treppe / kurve_aussen / kurve_innen   Tribünenkörper: hohl,
//                       Unterseite offen mit Rippen (stützfrei), bei Bedarf
//                       an einer Setzstufe in der Tiefe geteilt
//    sitze_block        Sitzreihe (Schalensitze auf Leiste) für Block
//    sitze_kurve_aussen_N / sitze_kurve_innen_N   Sitzreihe N der Kurve
//    gelaender_*        Glasgeländer (Pfosten/Handlauf + Glas)
//    bande_1..4         Werbebanden an der Stirnwand (Schrift als Einleger)
//    seitenwand_links / _rechts   Abschlusswände mit Brüstung
//    binder_*           Dachbinder (flach gedruckter Fachwerkträger)
//    dach_*             Dachfläche (Stehfalz, Blende mit Schriftzug)
//    fahne              Zielflagge mit Mast-Hülse (dreht sich)
//    verbinder          Clips für Modulstöße und geteilte Teile
//
//  BEWEGLICH
//    * Die Zielflaggen drehen sich auf ihrem Stift (Filament Ø stift_d).
//    * Dach, Sitzreihen, Geländer, Banden sind nur gesteckt -> abnehmbar.
//
//  MONTAGE
//    1. Körper eines Moduls (falls in der Tiefe geteilt) mit Clips von
//       unten verbinden. Module nebeneinanderstellen, Clips unten in die
//       Taschen an den Stößen drücken. Seitenwände an beide Enden stecken.
//    2. Sitzreihen auf die Zapfen der Stufen drücken, Geländer und Banden
//       in die Schlitze / Löcher stecken.
//    3. Binder in die Köcher im oberen Umgang stecken, Dachfläche auf die
//       Zapfen der Binder legen. Stift in die Dachhülse, Fahne aufstecken.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, block:Tribünenblock gerade, treppe:Treppenblock (Gang), kurve_aussen:Kurvenblock außen, kurve_innen:Kurvenblock innen, sitze_block:Sitzreihe Block, sitze_kurve_aussen_1:Sitzreihe Kurve außen 1 (Nummer = Reihe), sitze_kurve_innen_1:Sitzreihe Kurve innen 1 (Nummer = Reihe), gelaender_block:Geländer Block, gelaender_treppe:Geländer Treppe, gelaender_kurve_aussen_vorne:Geländer Kurve außen vorn, gelaender_kurve_aussen_hinten:Geländer Kurve außen hinten, gelaender_kurve_innen_vorne:Geländer Kurve innen vorn, gelaender_kurve_innen_hinten:Geländer Kurve innen hinten, bande_1:Werbebande 1, bande_2:Werbebande 2, bande_3:Werbebande 3, bande_4:Werbebande 4, seitenwand_links:Seitenwand links, seitenwand_rechts:Seitenwand rechts, binder_block:Dachbinder gerade, binder_kurve_aussen:Dachbinder Kurve außen, binder_kurve_innen:Dachbinder Kurve innen, dach_block:Dach Block, dach_treppe:Dach Treppe, dach_kurve_aussen:Dach Kurve außen, dach_kurve_innen:Dach Kurve innen, fahne:Zielflagge, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Mehrfarbige Teile: alle oder einzelne Farbe (A = Grundkörper)
farbteil = "alle"; // [alle, A, B]

/* [Anordnung] */
// B = Block, T = Treppe/Gang, K = Kurve (außen), I = Kurve (innen)
anordnung = "BTBTB";

/* [Vorschau] */
fahnen_winkel = 25; // [0:360]

/* [Tribüne (Vorbild in Metern)] */
reihen = 8;            // [2:1:20]
sitze_pro_reihe = 12;  // [2:1:60]
sitz_abstand_m = 0.5;
reihen_tiefe_m = 0.8;
stufen_hoehe_m = 0.4;
stirnwand_hoehe_m = 1.2;
vorderer_gang_m = 0.6;
umgang_tiefe_m = 1.6;
treppe_breite_m = 1.2;
gelaender_hoehe_m = 1.1;
// Eingänge an der Rückseite der Blöcke
eingaenge = true;
// Sitzfarben: einfarbig, abwechselnd je Reihe, untere/obere Hälfte
sitz_muster = "reihen"; // [einfarbig, reihen, unten_oben]

/* [Kurven] */
// Winkel je K / I (wird bei Bedarf in gleiche Segmente geteilt)
kurve_winkel = 30; // [5:5:90]
// Radius der Stirnwand (Vorbild in Metern)
kurve_radius_m = 15;

/* [Dach] */
dach = true;
// lichte Höhe über dem oberen Umgang (hinten)
dach_hoehe_m = 3.2;
// Neigung in Grad, positiv = steigt nach vorn an
dach_neigung = 5; // [-10:1:15]
// Überstand vor der Stirnwand
dach_ueberstand_m = 0.3;
dach_text = "GRANDSTAND";
fahnen = true;
fahnen_mast_m = 3.0;

/* [Werbebanden & Schrift] */
banden = true;
werbung_1 = "RACING";
werbung_2 = "TURBO";
werbung_3 = "PIT STOP";
werbung_4 = "SPEED";
// Schrift in den Seitenwänden (leer = keine)
seiten_text = "";
schrift = "Liberation Sans:style=Bold";

/* [Farben] */
farbe_beton      = "beton";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_stufenkante = "gelb";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_sitz_1     = "rot";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_sitz_2     = "weiss";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_gelaender  = "silber";   // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_glas       = "glas";     // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_bande      = "weiss";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_bande_text = "rot";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_seitenwand = "beton";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_seiten_text = "rot";     // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_stahl      = "hellgrau"; // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_dach       = "weiss";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_dach_text  = "rot";      // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_fahne_1    = "weiss";    // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_fahne_2    = "schwarz";  // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]
farbe_clips      = "grau";     // [rot, gelb, blau, gruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen, beton, hellgrau, glas]

/* [Druck & Passung] */
druckbett = 220;
rand = 5;
// maximale Druckhöhe des Druckers (nur Warnung)
druckhoehe = 250;
min_wand = 1.2;
spiel = 0.15;
// Luft je Seite für eingepresste Farbteile (Geländer-Glas; 0 = sehr stramm)
einsatz_spiel = 0.05;
// Fahnenstift (1.75 = Filament)
stift_d = 1.75;
stift_spiel = 0.2;
// größte Brückenlänge unter den Stufen (Rippenabstand, mm)
rippen_abstand = 28;
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

FARBEN = [["rot", "#c62828"], ["gelb", "#f9c80e"], ["blau", "#1e5bb8"], ["gruen", "#2e9d4f"], ["weiss", "#f4f4f4"],
          ["schwarz", "#222222"], ["grau", "#8a8f94"], ["silber", "#c0c4c8"], ["gold", "#d4a017"], ["orange", "#ef7d1a"],
          ["lila", "#7b3fa0"], ["rosa", "#f27fb2"], ["tuerkis", "#1fb5b0"], ["braun", "#7a4b2a"], ["holz", "#c19a6b"], ["creme", "#f3e3c3"],
          ["anthrazit", "#3a3f45"], ["cyan", "#12b5e8"], ["pink", "#e43d8f"], ["violett", "#8e3fc2"], ["neongruen", "#2ad957"],
          ["beton", "#aaa69d"], ["hellgrau", "#d3d6d9"], ["glas", "#b9dfeb"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

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

function starts(sx, q) = len(sx) >= len(q) && len([for (i = [0 : len(q) - 1]) if (sx[i] != q[i]) 1]) == 0;
function sint(sx, i, acc = 0) = i >= len(sx) ? acc : sint(sx, i + 1, acc * 10 + ord(sx[i]) - 48);
function fitrot(P) = let(c = [for (d = [0 : 5 : 175]) let(b = bb([for (q = P) rotp(q, d)])) [max(b[2] - b[0], b[3] - b[1]), d, b]],
                         m = min([for (x = c) x[0]])) [for (x = c) if (x[0] == m) x][0];
module place_fit(P) { f = fitrot(P); translate([-f[2][0], -f[2][1], 0]) rotate(f[1]) children(); }
function cnt(l, v) = len([for (x = l) if (x == v) 1]);
function uniq(l) = [for (i = [0 : 1 : len(l) - 1]) if (len([for (j = [0 : 1 : i - 1]) if (l[j] == l[i]) 1]) == 0) l[i]];

// =====================================================================
//  Maße
// =====================================================================
n_r  = max(1, reihen);
p    = sc(sitz_abstand_m * 1000, 3.5);
d_r  = sc(reihen_tiefe_m * 1000, 6);
h_r  = sc(stufen_hoehe_m * 1000, 2.5);
H_f  = sc(stirnwand_hoehe_m * 1000, 8);
d_v  = sc(vorderer_gang_m * 1000);
d_u  = sc(umgang_tiefe_m * 1000, 12);
function Y(i) = d_v + i * d_r;
function Z(i) = H_f + i * h_r;
D    = Y(n_r) + d_u;
z_u  = Z(n_r);
t_w  = max(1.6, min(sc(60), 2.4));              // Schale / Rippen
W_T  = sc(treppe_breite_m * 1000, 8);
cvx  = 2 * n_r + 10;                            // für die Vorschau

// ---- Geländer ----
t_g  = max(sc(50), 1.2);
w_po = max(sc(80), 1.6);
h_g  = sc(gelaender_hoehe_m * 1000, 5);
h_hr = max(sc(60), 1.0);
g_b  = max(sc(100), 0.8);
h_br = max(sc(50), 0.8);
p_l  = max(sc(250), 3);                         // Zapfentiefe
c_e  = 0.2;                                     // Abstand zum Modulende
c_in = max(sc(60), 0.8);                        // Handlauf-Überstand über den Endpfosten
t_f  = max(t_w + 0.8, t_g + 2 * spiel + 2.0);   // Stirn- und Rückwand

// ---- Sitze ----
p_s   = max(sc(60), 1.2);
g_s   = max(sc(40), 0.4);
w_s   = p - g_s;
w_p   = w_s * 0.45;
d_s   = sc(450, 3);
d_ped = min(d_s * 0.6, max(sc(250), 2));
z_pan = sc(420, 3);
t_pan = max(sc(60), 0.8);
h_bk  = sc(380, 2.5);
t_bk  = max(sc(60), 1.0);
lean  = 8;
t_bs  = max(sc(60), 1.2);
d_base = max(sc(300), p_s + 2 * spiel + 1.6);
c_b   = max(sc(40), 0.4);
l_top = (t_pan + h_bk) * tan(lean);
function y_back(i) = Y(i + 1) - c_b - l_top;
function y_peg(i)  = y_back(i) - d_base / 2;
function pegj(n) = n <= 1 ? [] : n == 2 ? [1] : n < 6 ? [1, n - 1] : [1, floor(n / 2), n - 1];
function rowc(i) = sitz_muster == "einfarbig" ? farbe_sitz_1 : sitz_muster == "reihen" ? (i % 2 == 0 ? farbe_sitz_1 : farbe_sitz_2)
                 : (i < n_r / 2 ? farbe_sitz_1 : farbe_sitz_2);

// ---- Block-Breite (Teilung in gleiche Unterblöcke) ----
function nsb(k) = ceil(sitze_pro_reihe / k) * p <= usable || k > 60 ? k : nsb(k + 1);
n_x  = nsb(1);
n_sb = ceil(sitze_pro_reihe / n_x);
W_sb = n_sb * p;

// ---- Tiefen-Teilung an den Setzstufen ----
function riser_near(t) = max(1, min(n_r, round((t - d_v) / d_r)));
function dedup(l) = [for (i = [0 : 1 : len(l) - 1]) if (i == 0 || l[i] != l[i - 1]) l[i]];
function yseams_n(n) = dedup([for (j = [1 : 1 : n - 1]) Y(riser_near(D * j / n))]);
function yseams(n = 0) = let(n0 = max(1, ceil(D / usable)), nn = max(n, n0), l = yseams_n(nn))
    (max_gap(l, D) <= usable || nn > n_r) ? l : yseams(nn + 1);
YS = yseams();
NB = len(YS) + 1;
function YA(b) = b == 0 ? 0 : YS[b - 1];
function YB(b) = b == NB - 1 ? D : YS[b];

// ---- Modul-Arten  ["S", Länge] / ["K" | "I", Winkel, Radius Stirnwand] ----
r_K = sc(kurve_radius_m * 1000, 20);
I_OK = r_K > D + 10;
function rho_of(k, y) = k[0] == "K" ? k[2] + y : k[2] - y;
function lp(k, u, y) = k[0] == "S" ? [u, y] : k[0] == "K" ? [0, -k[2]] + (k[2] + y) * [sin(u), cos(u)] : [0, k[2]] + (k[2] - y) * [sin(u), -cos(u)];
function band_pts(k, b) = [for (i = [0 : 24], y = [b == 0 ? -1 : YA(b), b == NB - 1 ? D + 1 : YB(b)]) lp(k, k[1] * i / 24, y)];
function seg_fits(k) = len([for (b = [0 : NB - 1]) if (fitrot(band_pts(k, b))[0] > usable) 1]) == 0;
function nseg(typ, n = 1) = n >= 60 ? n : seg_fits([typ, kurve_winkel / n, r_K]) ? n : nseg(typ, n + 1);
nsegK = nseg("K");
nsegI = I_OK ? nseg("I") : 1;
KS = ["S", W_sb];
KT = ["S", W_T];
KK = ["K", kurve_winkel / nsegK, r_K];
KI = ["I", kurve_winkel / nsegI, r_K];

// ---- Anordnung ----
CH = [for (i = [0 : len(anordnung) - 1]) let(c = anordnung[i]) c == "b" ? "B" : c == "t" ? "T" : c == "k" ? "K" : c == "i" ? "I" : c];
EL0 = [for (c = CH) each (c == "B" ? [for (j = [1 : n_x]) "B"] : c == "T" ? ["T"] : c == "K" ? [for (j = [1 : nsegK]) "K"]
                          : (c == "I" && I_OK) ? [for (j = [1 : nsegI]) "I"] : [])];
EL = len(EL0) > 0 ? EL0 : ["B"];
function kind_of(t) = t == "B" ? KS : t == "T" ? KT : t == "K" ? KK : KI;
function typ_of(t) = t == "T" ? "T" : "B";
nBe = cnt(EL, "B"); nTe = cnt(EL, "T"); nKe = cnt(EL, "K"); nIe = cnt(EL, "I");

// ---- Rippen, Clips an den Tiefen-Nähten, Taschen an den Modulenden ----
function ribs(k) = k[0] == "S" ? let(L = k[1], n = max(1, ceil((L - 2 * t_w) / rippen_abstand))) [for (j = [1 : 1 : n - 1]) t_w + j * (L - 2 * t_w) / n]
    : let(rmax = k[0] == "K" ? k[2] + D : k[2], n = max(1, ceil(rmax * k[1] * PI / 180 / rippen_abstand))) [for (j = [1 : 1 : n - 1]) j * k[1] / n];
function seam_clips(k, ys) = k[0] == "S" ? let(L = k[1], n = max(1, round((L - cL - 8) / 50))) [for (j = [0 : n - 1]) L * (j + 0.5) / n]
    : let(arc = rho_of(k, ys) * k[1] * PI / 180, n = max(1, round(arc / 50))) [for (j = [0 : n - 1]) k[1] * (j + 0.5) / n];
function rby_band(b) = let(a = b == 0 ? t_f + mw + 1 : YA(b) + spw / 2 + t_w + mw + 1,
                           z = b == NB - 1 ? D - t_f - mw - 1 : YB(b) - spw / 2 - t_w - mw - 1,
                           n = max(1, floor((z - a) / 60) + 1))
    n == 1 ? [(a + z) / 2] : [for (j = [0 : n - 1]) a + j * (z - a) / (n - 1)];
RBY = [for (b = [0 : NB - 1]) each rby_band(b)];
// Zapfen der Seitenwände (y, z)
p_e = max(sc(80), 1.6);
EWP = [for (b = [0 : NB - 1]) let(a = YA(b) + t_f, z = YB(b) - t_f, n = (z - a) > 60 ? 2 : 1)
       for (j = [0 : n - 1]) [a + (z - a) * (j + 0.5) / n, max(clipd + 1 + p_e, H_f * 0.45)]];

// ---- Werbebanden ----
WRB  = [werbung_1, werbung_2, werbung_3, werbung_4];
WL   = [for (j = [0 : 3]) if (WRB[j] != "") j];
L_wb = W_sb - 2 * max(sc(250), 3);
h_wb = min(H_f - p_l - 3, max(sc(800), 6));
z_wb = (H_f - p_l - h_wb) * 0.55;
t_wb = max(sc(50), 1.2);
p_d  = max(sc(70), 1.4);
l_d  = t_f - 0.4;
c_pg = max(sc(300), 4);
t_tx = 0.6;
function wb_px(L) = L > 80 ? [c_pg, L / 2, L - c_pg] : [c_pg, L - c_pg];

// ---- Seitenwand ----
h_par = sc(gelaender_hoehe_m * 900, 4);

// ---- Dach ----
y_rf    = -sc(dach_ueberstand_m * 1000);
y_rb    = D;
z_back  = z_u + sc(dach_hoehe_m * 1000, 15);
z_front = z_back + (y_rb - y_rf) * tan(dach_neigung);
y_c     = Y(n_r) + d_u * 0.55;
w_c     = max(sc(300), 2.4);
w_m     = max(sc(160), 1.6);
p_bl    = min(max(sc(600), 4), z_u - 2);
l_tn    = max(sc(300), 3);
y_tip   = y_rf + sc(400);
y_bk    = y_rb - max(sc(150), 1);
h_fa    = max(sc(700), 3);
t_fa    = max(sc(100), 1.2);
w_sn    = max(sc(40), 0.8);
h_sn    = max(sc(40), 0.4);
d_boss  = stift_d + 0.15 + 2 * 1.2;
h_boss  = max(sc(300), 3);
f_w     = sc(1200, 8);
f_h     = sc(800, 5);
t_fl    = max(sc(30), 0.8);
s_sl    = stift_d + 2 * stift_spiel + 2 * max(0.8, sc(40));
h_pole  = sc(fahnen_mast_m * 1000, 20);
function binders(k) = k[0] == "S" ? (k[1] < sc(3000) ? [k[1] / 2] : [k[1] / 4, 3 * k[1] / 4]) : [k[1] / 4, 3 * k[1] / 4];
function fr_t(k, y) = k[0] == "S" ? y : rho_of(k, y) * cos(k[1] / 2);
function hw(k, y) = k[0] == "S" ? k[1] / 2 : fr_t(k, y) * tan(k[1] / 2);
function Lsl(k) = norm([fr_t(k, y_rb) - fr_t(k, y_rf), z_back - z_front]);
function zr(k, y) = let(tf = fr_t(k, y_rf), tb = fr_t(k, y_rb), t = k[0] == "S" ? y : rho_of(k, y) * cos(k[1] / 4))
    z_front + (t - tf) / (tb - tf) * (z_back - z_front);
function h_kn(k) = min(sc(1600), (zr(k, y_c) - z_u) * 0.5);
function zbot(k, y) = let(zc = zr(k, y_c) - h_kn(k), zt = zr(k, y_tip) - w_m * 1.2) zc + (y - y_c) / (y_tip - y_c) * (zt - zc);
function ndg(k) = max(2, round((y_c - y_tip) / max(h_kn(k), 4)));
function bind_M(k) = let(n = ndg(k)) concat(
    [[[y_c, z_u - p_bl], [y_c, zr(k, y_c) - w_m / 2], w_c]],
    [[[y_tip, zr(k, y_tip) - w_m / 2 - 0.25], [y_bk, zr(k, y_bk) - w_m / 2 - 0.25], w_m]],
    [[[y_c, zbot(k, y_c)], [y_tip + w_m, zbot(k, y_tip + w_m)], w_m * 0.8]],
    [for (j = [0 : n - 1]) let(ya = y_c - j * (y_c - y_tip) / n, yb = y_c - (j + 1) * (y_c - y_tip) / n)
        j % 2 == 0 ? [[ya, zbot(k, ya)], [yb, zr(k, yb) - w_m / 2], w_m * 0.7] : [[ya, zr(k, ya) - w_m / 2], [yb, zbot(k, yb)], w_m * 0.7]],
    y_bk - y_c > w_c + 2 * w_m ? [[[y_c, z_u + (zr(k, y_c) - z_u) * 0.45], [y_bk - w_m / 2, zr(k, y_bk - w_m / 2) - w_m / 2], w_m * 0.7]] : []);
b_ymin = y_tip - w_m - 0.5;
b_zmin = z_u - p_bl + 0.4;
function b_SX(k) = y_bk + w_m - b_ymin;
function b_SY(k) = max(zr(k, y_tip), zr(k, y_bk), zr(k, y_c)) + 3 - b_zmin;
USED_K = concat(nBe + nTe > 0 ? [KS] : [], nKe > 0 ? [KK] : [], nIe > 0 ? [KI] : []);
BIND_SPLIT = dach && len([for (k = USED_K) if (b_SX(k) > usable || b_SY(k) > usable) 1]) > 0;
t_bi = max(sc(150), 2.0, BIND_SPLIT ? clipd + 0.8 : 0);
pw_x = t_bi + 2 * spiel + 2 * 1.2;
pw_y = w_c + 2 * spiel + 2 * 1.2;
function hwmax(k) = max(hw(k, y_rf), hw(k, y_rb)) - 0.2;
voff = t_tx + 0.5;
function dach_SX(k) = 2 * hwmax(k);
function dach_SY(k) = Lsl(k) + voff;
DACH_SPLIT = dach && len([for (k = concat(USED_K, nTe > 0 ? [KT] : [])) if (dach_SX(k) > usable || dach_SY(k) > usable) 1]) > 0;
t_r  = max(sc(100), 2.0, DACH_SPLIT ? clipd + 0.8 : 0);
d_pk = t_r - 0.7;
h_tn = d_pk - 0.3;
SW_SPLIT = D > usable || z_u + h_par > usable;
t_e  = max(sc(200), 2.4, SW_SPLIT ? clipd + 0.8 : 0);

// =====================================================================
//  Geometrie-Grundlagen: Profil, Sweep, lokale Rahmen
// =====================================================================
function prof_pts(typ) = typ == "T" ? concat([[0, 0], [0, H_f]],
        [for (i = [0 : n_r - 1]) each [[Y(i) + d_r / 2, Z(i)], [Y(i) + d_r / 2, Z(i) + h_r / 2], [Y(i + 1), Z(i) + h_r / 2], [Y(i + 1), Z(i + 1)]]],
        [[D, z_u], [D, 0]])
    : concat([[0, 0], [0, H_f]], [for (i = [1 : n_r]) each [[Y(i), Z(i - 1)], [Y(i), Z(i)]]], [[D, z_u], [D, 0]]);
module prof(typ) polygon(prof_pts(typ));
module cav2d(typ) {
    intersection() { offset(delta = -t_w) prof(typ); translate([t_f, -5]) square([D - 2 * t_f, z_u + 10]); }
    translate([t_f, -1]) square([D - 2 * t_f, t_w + 1 + e]);
}
// lokaler Rahmen am Modul: x = entlang der Front, y = nach hinten, z = oben
module at(k, u, y) {
    if (k[0] == "S") translate([u, y, 0]) children();
    else if (k[0] == "K") translate([0, -k[2], 0]) rotate(-u) translate([0, k[2] + y, 0]) children();
    else translate([0, k[2], 0]) rotate(u) translate([0, y - k[2], 0]) children();
}
module rot_u(k, u) {
    if (k[0] == "S") translate([u, 0, 0]) children();
    else if (k[0] == "K") translate([0, -k[2], 0]) rotate(-u) translate([0, k[2], 0]) children();
    else translate([0, k[2], 0]) rotate(u) translate([0, -k[2], 0]) children();
}
// Profil (y, z) entlang des Moduls ziehen
module sweep(k) {
    if (k[0] == "S") rotate([90, 0, 90]) linear_extrude(k[1], convexity = cvx) children();
    else if (k[0] == "K") translate([0, -k[2], 0]) rotate(90 - k[1]) rotate_extrude(angle = k[1], $fn = 360, convexity = cvx) translate([k[2], 0]) children();
    else translate([0, k[2], 0]) rotate(270) rotate_extrude(angle = k[1], $fn = 360, convexity = cvx) translate([k[2], 0]) mirror([1, 0]) children();
}
module sweep_sub(k, u0, u1) rot_u(k, u0) sweep([k[0], u1 - u0, k[2]]) children();
module slab(typ) rotate([90, 0, 90]) linear_extrude(t_w, convexity = cvx) prof(typ);
// Innenrippen mit Aussparungen (45°-Giebel = stützfrei), oben bleibt ein Steg unter jeder Stufe
m_h = max(t_w, 3);
z_h0 = clipd + 2;
module rib_holes2d() {
    for (i = [0 : n_r - 1]) let(a = Y(i) + m_h, b = Y(i + 1) - m_h, top = Z(i) - t_w - m_h, w = b - a)
        if (w > 4 && top - w / 2 > z_h0 + 3) polygon([[a, z_h0], [b, z_h0], [b, top - w / 2], [(a + b) / 2, top], [a, top - w / 2]]);
    let(a = Y(n_r) + m_h, b = D - t_f - m_h, top = z_u - t_w - m_h, w = b - a)
        if (w > 4 && top - w / 2 > z_h0 + 3) polygon([[a, z_h0], [b, z_h0], [b, top - w / 2], [(a + b) / 2, top], [a, top - w / 2]]);
}
module rib(typ) rotate([90, 0, 90]) linear_extrude(t_w, convexity = cvx) difference() { prof(typ); rib_holes2d(); }

// =====================================================================
//  Tribünenkörper
// =====================================================================
module rb_pad() translate([0, -(cw1 / 2 + spiel + min_wand), 0]) cube([cL / 2 + spiel + min_wand + 0.3, cw1 + 2 * (spiel + min_wand), clipd + 0.4]);
module ew_hole() rotate([0, 90, 0]) translate([0, 0, -1]) linear_extrude(t_w + 2.5) rotate(45) square(p_e + 2 * spiel, center = true);
function PO(L) = let(a = c_in + w_po / 2, n = max(1, ceil((L - 2 * a) / max(sc(1800), 12)))) [for (j = [0 : n]) a + j * (L - 2 * a) / n];
function nch_f(rho, a, n) = n > 360 ? n : let(dp = a / n, Lc = 2 * rho * sin(dp / 2), sg = rho * (1 - cos(dp / 2)))
    (Lc <= usable && sg <= 0.3 * t_f) ? n : nch_f(rho, a, n + 1);
function nch(k, yg) = nch_f(rho_of(k, yg), k[1], 1);
function chords(k, yg) = let(rho = rho_of(k, yg), dl = deg(c_e / rho), n = nch(k, yg))
    [for (j = [0 : n - 1]) let(a0 = dl + j * (k[1] - 2 * dl) / n, a1 = dl + (j + 1) * (k[1] - 2 * dl) / n) [lp(k, a0, yg), lp(k, a1, yg)]];
function chord_len(k, yg) = let(c = chords(k, yg)[0]) norm(c[1] - c[0]);
function rail_posts(k, yg) = k[0] == "S" ? [for (sx = PO(k[1] - 2 * c_e)) [c_e + sx, yg, 0]]
    : [for (c = chords(k, yg)) let(L = norm(c[1] - c[0]), d = (c[1] - c[0]) / L, a = atan2(d[1], d[0])) for (sx = PO(L)) concat(c[0] + sx * d, [a])];
module rail_slots(k, yg, ztop) for (q = rail_posts(k, yg)) translate([q[0], q[1], ztop - p_l]) rotate(q[2])
    translate([-(w_po + 2 * spiel) / 2, -(t_g + 2 * spiel) / 2, 0]) cube([w_po + 2 * spiel, t_g + 2 * spiel, p_l + 1]);

// Sitze in der Kurve: Anzahl / Randwinkel je Reihe
function di(k, i) = deg(max(0.3, g_s / 2) / rho_of(k, y_back(i) - d_s / 2));
function n_i(k, i) = let(rmin = k[0] == "K" ? k[2] + y_back(i) - d_s : k[2] - y_back(i) - l_top, a = k[1] - 2 * di(k, i))
    max(1, floor(rmin * a * PI / 180 / p));
function phi_b(k, i, j) = di(k, i) + j * (k[1] - 2 * di(k, i)) / n_i(k, i);

module seat_pegs(k) {
    if (k[0] == "S") for (i = [0 : n_r - 1], j = pegj(n_sb)) translate([j * p - p_s / 2, y_peg(i) - p_s / 2, Z(i) - e]) cube([p_s, p_s, t_bs - 0.1 + e]);
    else for (i = [0 : n_r - 1], j = pegj(n_i(k, i))) at(k, phi_b(k, i, j), y_peg(i)) translate([-p_s / 2, -p_s / 2, Z(i) - e]) cube([p_s, p_s, t_bs - 0.1 + e]);
}
module door2d(w, h) polygon([[-w / 2, 0], [w / 2, 0], [w / 2, h], [0, h + w / 2], [-w / 2, h]]);
module doors(L) {
    n = max(1, round(L / sc(5000)));
    w = min(sc(1600), L / n * 0.4); h = min(sc(2200), z_u * 0.55 - w / 2);
    for (j = [0 : n - 1]) translate([L * (j + 0.5) / n, D + 1, 0]) rotate([90, 0, 0]) translate([0, -1]) linear_extrude(t_f - 1.0 + 1) door2d(w, h + 1);
}
module bande_holes(L) for (x = wb_px(L_wb)) translate([(L - L_wb) / 2 + x, -1, z_wb + h_wb / 2]) rotate([-90, 0, 0])
    linear_extrude(t_f + 1.5) rotate(45) square(p_d + 2 * spiel, center = true);
// Stufenkanten (Treppe, Farbe B)
w_n = max(sc(60), 0.8);
t_n = 0.6;
NOS = concat([for (i = [1 : n_r]) [Y(i), Z(i)]], [for (i = [0 : n_r - 1]) [Y(i) + d_r / 2, Z(i) + h_r / 2]]);
module nosing(k) sweep(k) for (q = NOS) translate([q[0], q[1] - t_n]) square([w_n, t_n + 1]);

module body_raw(k, typ) {
    L = k[1];
    difference() {
        union() {
            difference() { sweep(k) prof(typ); sweep(k) cav2d(typ); }
            at(k, 0, 0) slab(typ);
            at(k, L, 0) translate([-t_w, 0, 0]) slab(typ);
            for (u = ribs(k)) at(k, u, 0) translate([-t_w / 2, 0, 0]) rib(typ);
            for (ys = YS) sweep(k) intersection() { prof(typ); translate([ys - gap - t_w, -1]) square([2 * (gap + t_w), z_u + 10]); }
            for (ys = YS, u = seam_clips(k, ys)) at(k, u, ys) translate([-(mw + 0.5), -spw / 2, 0]) cube([2 * (mw + 0.5), spw, clipd + 0.4]);
            for (yr = RBY) { at(k, 0, yr) rb_pad(); at(k, L, yr) rotate(180) rb_pad(); }
            if (dach) for (u = binders(k)) at(k, u, y_c) translate([-pw_x / 2, -pw_y / 2, 0]) cube([pw_x, pw_y, z_u - e]);
            if (typ == "B") seat_pegs(k);
        }
        for (ys = YS, u = seam_clips(k, ys)) at(k, u, ys) clip_cut(90, false, 0);
        for (yr = RBY) { at(k, 0, yr) rb_slot(); at(k, L, yr) rotate(180) rb_slot(); }
        for (q = EWP) { at(k, 0, q[0]) translate([0, 0, q[1]]) ew_hole(); at(k, L, q[0]) rotate(180) translate([0, 0, q[1]]) ew_hole(); }
        rail_slots(k, t_f / 2, H_f);
        rail_slots(k, D - t_f / 2, z_u);
        if (dach) for (u = binders(k)) at(k, u, y_c) translate([-(t_bi + 2 * spiel) / 2, -(w_c + 2 * spiel) / 2, z_u - p_bl]) cube([t_bi + 2 * spiel, w_c + 2 * spiel, p_bl + 1]);
        if (k[0] == "S" && typ == "B") { if (banden && len(WL) > 0) bande_holes(L); if (eingaenge) doors(L); }
    }
}
module body(k, typ, fp) {
    if (typ == "T" && fp == "B") intersection() { sweep(k) prof(typ); nosing(k); }
    else if (typ == "T" && fp == "A") difference() { body_raw(k, typ); nosing(k); }
    else if (fp == "alle" || fp == "A") body_raw(k, typ);
}
module band_mask(k, b) sweep(k) translate([b == 0 ? -5 : YA(b) + gap, -5])
    square([(b == NB - 1 ? D + 5 : YB(b) - gap) - (b == 0 ? -5 : YA(b) + gap), z_u + 50]);
module body_print(k, typ, stk, fp) for (b = [0 : NB - 1]) if (stk == 0 || stk == b + 1)
    translate(stk == 0 ? [0, b * (usable + 10), 0] : [0, 0, 0]) {
        if (k[0] == "S") translate([0, b == 0 ? 0 : -YA(b) - gap, 0]) intersection() { body(k, typ, fp); band_mask(k, b); }
        else place_fit(band_pts(k, b)) intersection() { body(k, typ, fp); band_mask(k, b); }
    }

// =====================================================================
//  Sitze
// =====================================================================
module sitz_seite2d() {   // (y, z): y = 0 Rückseite unten, Sitz zeigt nach -y
    polygon([[-d_ped, 0], [0, 0], [0, z_pan], [-d_s, z_pan], [-d_s, z_pan - 0.01], [-d_ped, z_pan - (d_s - d_ped)]]);
    translate([-d_s, z_pan]) square([d_s, t_pan]);
    H = t_pan + h_bk;
    polygon([[0, z_pan], [-t_bk, z_pan], [-t_bk + H * tan(lean), z_pan + H], [H * tan(lean), z_pan + H]]);
}
module sitz_front2d() let(z1 = z_pan - (w_s - w_p) / 2, top = z_pan + t_pan + h_bk + 1)
    polygon([[-w_p / 2, 0], [w_p / 2, 0], [w_p / 2, z1], [w_s / 2, z_pan], [w_s / 2, top], [-w_s / 2, top], [-w_s / 2, z_pan], [-w_p / 2, z1]]);
module sitz3d() intersection() {   // x quer (mittig), y nach hinten (0 = Rückseite), z ab Leiste
    rotate([90, 0, 90]) linear_extrude(w_s + 2, center = true) sitz_seite2d();
    rotate([90, 0, 0]) linear_extrude(4 * d_s, center = true) sitz_front2d();
}
module strip_s() {   // Block-Sitzreihe: x = 0..W_sb, y = 0 an der Sitzrückseite, z = 0 auf der Stufe
    L = n_sb * p;
    difference() {
        union() {
            translate([c_e, -d_base, 0]) cube([L - 2 * c_e, d_base, t_bs]);
            for (j = [0 : n_sb - 1]) translate([(j + 0.5) * p, 0, t_bs - e]) sitz3d();
        }
        for (j = pegj(n_sb)) translate([j * p - p_s / 2 - spiel, -d_base / 2 - p_s / 2 - spiel, -1]) cube([p_s + 2 * spiel, p_s + 2 * spiel, t_bs + 2]);
    }
}
module strip_c(k, i) {   // im Modul-Rahmen
    n = n_i(k, i);
    difference() {
        union() {
            sweep_sub(k, phi_b(k, i, 0), phi_b(k, i, n)) translate([y_back(i) - d_base, Z(i)]) square([d_base, t_bs]);
            for (j = [0 : n - 1]) at(k, (phi_b(k, i, j) + phi_b(k, i, j + 1)) / 2, y_back(i)) translate([0, 0, Z(i) + t_bs - e]) sitz3d();
        }
        for (j = pegj(n)) at(k, phi_b(k, i, j), y_peg(i)) translate([-p_s / 2 - spiel, -p_s / 2 - spiel, Z(i) - 1]) cube([p_s + 2 * spiel, p_s + 2 * spiel, t_bs + 2]);
    }
}
function strip_pts(k, i) = [for (u = [0 : 12], y = [y_back(i) - d_s - 0.5, y_back(i) + l_top + 0.5]) lp(k, phi_b(k, i, 0) + u * (phi_b(k, i, n_i(k, i)) - phi_b(k, i, 0)) / 12, y)];
module strip_c_print(k, i) if (i >= 0 && i < n_r) place_fit(strip_pts(k, i)) translate([0, 0, -Z(i)]) strip_c(k, i);
module seats_world(k) {
    if (k[0] == "S") for (i = [0 : n_r - 1]) color(fhex(rowc(i))) translate([0, y_back(i), Z(i)]) strip_s();
    else for (i = [0 : n_r - 1]) color(fhex(rowc(i))) strip_c(k, i);
}

// =====================================================================
//  Geländer (flach gedruckt: Pfosten + Handlauf = A, Glas = B)
// =====================================================================
module panel2d(L, fp) {   // x = Länge, y = Höhe über dem Boden (Zapfen < 0)
    if (inc(fp, "A")) {
        for (sx = PO(L)) translate([sx - w_po / 2, -p_l + 0.4]) square([w_po, h_g + p_l - 0.4]);
        translate([0, h_g - h_hr]) square([L, h_hr]);
        translate([0, g_b]) square([L, h_br]);
    }
    if (inc(fp, "B")) difference() {
        translate([0, g_b + h_br]) square([L, h_g - h_hr - g_b - h_br]);
        for (sx = PO(L)) translate([sx - w_po / 2, -1]) square([w_po, h_g + 2]);
    }
}
// Glas steckt im Falz: unten (Druckbett) ist die Öffnung um rb_g größer, oben hält eine Lippe des Rahmens;
// die Scheibe hat oben einen Bund in Öffnungsgröße (bündig) und wird von unten eingedrückt (Presssitz einsatz_spiel)
rb_g = min(0.6, w_po * 0.25); lp_g = min(0.6, t_g * 0.4);
module glas2d(L, o) intersection() { offset(delta = o) panel2d(L, "B"); translate([0, -p_l]) square([L, h_g + p_l]); }
module panel3d(L, fp) {
    if (inc(fp, "A")) {
        linear_extrude(t_g - lp_g + e, convexity = cvx) difference() { panel2d(L, "A"); offset(delta = rb_g) panel2d(L, "B"); }
        translate([0, 0, t_g - lp_g]) linear_extrude(lp_g, convexity = cvx) panel2d(L, "A");
    }
    if (inc(fp, "B")) {
        linear_extrude(t_g - lp_g, convexity = cvx) glas2d(L, rb_g - einsatz_spiel);
        translate([0, 0, t_g - lp_g - e]) linear_extrude(lp_g + e, convexity = cvx) glas2d(L, -einsatz_spiel);
    }
}
module panel_print(L, fp) translate([0, p_l, 0]) panel3d(L, fp);
module panel_world(L, fp) translate([0, t_g / 2, 0]) rotate([90, 0, 0]) panel3d(L, fp);
module rails_world(k, yg, ztop) {
    if (k[0] == "S") translate([c_e, yg, ztop]) { color(fhex(farbe_gelaender)) panel_world(k[1] - 2 * c_e, "A"); color(fhex(farbe_glas)) panel_world(k[1] - 2 * c_e, "B"); }
    else for (c = chords(k, yg)) let(L = norm(c[1] - c[0]), a = atan2(c[1][1] - c[0][1], c[1][0] - c[0][0]))
        translate([c[0][0], c[0][1], ztop]) rotate(a) { color(fhex(farbe_gelaender)) panel_world(L, "A"); color(fhex(farbe_glas)) panel_world(L, "B"); }
}

// =====================================================================
//  Werbebanden (mit der Schauseite nach unten gedruckt, Schrift = Einleger)
// =====================================================================
module bande_text2d(txt, L) translate([L / 2, h_wb / 2]) mirror([1, 0])
    resize([min(L * 0.86, len(txt) * h_wb * 0.55 * 0.72), 0]) text(txt, size = h_wb * 0.55, font = schrift, halign = "center", valign = "center");
module bande_print(txt, L, fp) {
    if (inc(fp, "A")) difference() {
        union() {
            cube([L, h_wb, t_wb]);
            for (x = wb_px(L)) translate([x, h_wb / 2, t_wb - e]) linear_extrude(l_d + e) rotate(45) square(p_d, center = true);
        }
        translate([0, 0, -1]) linear_extrude(1 + t_tx) bande_text2d(txt, L);
        // Rahmenfuge
        translate([0, 0, -1]) linear_extrude(1.4) difference() { translate([0.9, 0.9]) square([L - 1.8, h_wb - 1.8]); translate([1.5, 1.5]) square([L - 3, h_wb - 3]); }
    }
    if (inc(fp, "B")) linear_extrude(t_tx) bande_text2d(txt, L);
}
module bande_world(L, txt) translate([(L + L_wb) / 2, -t_wb, z_wb]) rotate([0, 180, 0]) rotate([-90, 0, 0]) {
    color(fhex(farbe_bande)) bande_print(txt, L_wb, "A");
    color(fhex(farbe_bande_text)) bande_print(txt, L_wb, "B");
}

// =====================================================================
//  Seitenwände (flach gedruckt, Zapfen oben)
// =====================================================================
function ew_poly() = [[0, 0], [0, H_f + h_par], [Y(n_r), z_u + h_par], [D, z_u + h_par], [D, 0]];
l_e = t_w + 1.0;
function sw_x(side, x) = side == "links" ? x : D - x;
function xmin_sw(z) = z <= H_f + h_par ? 0 : (z - H_f - h_par) * Y(n_r) / (z_u - H_f);
sw_tz = (H_f + h_par) * 0.5;
sw_th = min(H_f * 0.45, (H_f + h_par) * 0.4);
module sw_text2d() translate([D / 2, sw_tz]) mirror([1, 0])
    resize([min(D * 0.7, len(seiten_text) * sw_th * 0.72), 0]) text(seiten_text, size = sw_th, font = schrift, halign = "center", valign = "center");
module sw_plate(side, fp) {
    P = [for (q = ew_poly()) [sw_x(side, q[0]), q[1]]];
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(t_e) polygon(P);
            for (q = EWP) translate([sw_x(side, q[0]), q[1], t_e - e]) linear_extrude(l_e + e) rotate(45) square(p_e, center = true);
        }
        translate([0, 0, -1]) linear_extrude(1.4) difference() { offset(delta = -1.2) polygon(P); offset(delta = -1.7) polygon(P); }
        if (seiten_text != "") translate([0, 0, -1]) linear_extrude(1 + t_tx) sw_text2d();
    }
    if (inc(fp, "B") && seiten_text != "") linear_extrude(t_tx) sw_text2d();
}
function sw_S(side) = let(hh = max(2 * mw, cL + 2) + 3) [for (z = [0 : 1 : z_u + h_par - hh]) let(x0 = xmin_sw(z + hh) + 2.2, x1 = D - 2.2)
    side == "links" ? [x0, z + 0.5, x1, z + hh] : [D - x1, z + 0.5, D - x0, z + hh]];
function sw_kp(side) = seiten_text == "" ? [] : [[D / 2 - D * 0.36, sw_tz - sw_th * 0.7, D / 2 + D * 0.36, sw_tz + sw_th * 0.7]];
function info_sw(side) = let(SX = D, SY = z_u + h_par,
    xs = SX > usable ? seams_at(SX, [for (q = EWP) let(x = sw_x(side, q[0])) [x - p_e - spw / 2 - 1, x + p_e + spw / 2 + 1]], mw) : [],
    ys = SY > usable ? seams_at(SY, [[EWP[0][1] - p_e - spw / 2 - 1, EWP[0][1] + p_e + spw / 2 + 1]], mw) : [])
    [SX, SY, xs, ys, sw_kp(side), false, 0, sw_S(side), sw_S(side)];
module sw_world(side) {
    M = side == "links" ? [[0, 0, 1, -t_e], [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 1]] : [[0, 0, -1, t_e], [-1, 0, 0, D], [0, 1, 0, 0], [0, 0, 0, 1]];
    multmatrix(M) { color(fhex(farbe_seitenwand)) sw_plate(side, "A"); color(fhex(farbe_seiten_text)) sw_plate(side, "B"); }
}

// =====================================================================
//  Dach: Binder (flach gedruckt) + Dachfläche + Zielflagge
// =====================================================================
function tn_y() = [y_c, y_tip + l_tn];
module binder2d(k) {   // (y, z) wie im Modul
    polygon([[y_c - w_c / 2, b_zmin], [y_c + w_c / 2, b_zmin], [y_c + w_c / 2, zr(k, y_c + w_c / 2) - 0.5], [y_c - w_c / 2, zr(k, y_c - w_c / 2) - 0.5]]);
    M = bind_M(k);
    for (i = [1 : len(M) - 1]) let(m = M[i]) if (i <= 2) sbar(m[0], m[1], m[2]); else bar(m[0], m[1], m[2]);
    for (y = tn_y()) let(a = y - l_tn / 2, b = y + l_tn / 2)
        polygon([[a, zr(k, a) - w_m / 2], [b, zr(k, b) - w_m / 2], [b, zr(k, b) + h_tn], [a, zr(k, a) + h_tn]]);
}
function bind_Mp(k) = [for (m = bind_M(k)) [m[0] - [b_ymin, b_zmin], m[1] - [b_ymin, b_zmin], m[2]]];
function info_binder(k) = let(SX = b_SX(k), SY = b_SY(k),
    xs = SX > usable ? seams_at(SX, concat([[y_c - b_ymin - w_c / 2 - spw / 2 - 1, y_c - b_ymin + w_c / 2 + spw / 2 + 1]],
                                            [for (y = tn_y()) [y - b_ymin - l_tn / 2 - spw / 2 - 1, y - b_ymin + l_tn / 2 + spw / 2 + 1]]), mw) : [],
    ys = SY > usable ? seams_at(SY, [[min(zr(k, y_tip), zr(k, y_bk)) - 2 * w_m - 1 - b_zmin, SY + 1]], mw) : [])
    [SX, SY, xs, ys, [], false, 0, pads(bind_Mp(k), xs, ys)];
module binder_print(k) linear_extrude(t_bi) { translate([-b_ymin, -b_zmin]) binder2d(k); for (r = info_binder(k)[7]) rect2(r); }
module binder_world(k) for (u = binders(k)) at(k, u, 0) rotate([90, 0, 90]) translate([0, 0, -t_bi / 2]) linear_extrude(t_bi, convexity = cvx) binder2d(k);

// Dachfläche: Plattenkoordinaten u (quer, mittig), v (von vorn nach hinten), w (oben)
function facet_M(k) = let(
    S = k[0] == "S",
    b = S ? [0, 1] : k[0] == "K" ? [sin(k[1] / 2), cos(k[1] / 2)] : [sin(k[1] / 2), -cos(k[1] / 2)],
    l = S ? [1, 0] : k[0] == "K" ? [cos(k[1] / 2), -sin(k[1] / 2)] : [cos(k[1] / 2), sin(k[1] / 2)],
    O = S ? [k[1] / 2, y_rf] : (k[0] == "K" ? [0, -k[2]] : [0, k[2]]) + fr_t(k, y_rf) * b,
    dt = fr_t(k, y_rb) - fr_t(k, y_rf), dz = z_back - z_front, L = norm([dt, dz]),
    ev = [dt * b[0] / L, dt * b[1] / L, dz / L], eu = [l[0], l[1], 0], en = cross(eu, ev))
    [[eu[0], ev[0], en[0], O[0]], [eu[1], ev[1], en[1], O[1]], [eu[2], ev[2], en[2], z_front], [0, 0, 0, 1]];
function pl_uv(k, ub, y) = let(tf = fr_t(k, y_rf), tb = fr_t(k, y_rb))
    k[0] == "S" ? [ub - k[1] / 2, (y - tf) / (tb - tf) * Lsl(k)]
    : let(psi = ub - k[1] / 2, rho = rho_of(k, y), t = rho * cos(psi)) [rho * sin(psi), (t - tf) / (tb - tf) * Lsl(k)];
function trap_hw(k, v) = let(a = hw(k, y_rf) - 0.2, b = hw(k, y_rb) - 0.2) a + (b - a) * v / Lsl(k);
function boss_g(k) = let(M = facet_M(k)) atan2(-M[2][1], M[2][2]);
module dach_text3d(k) let(hf = hw(k, y_rf) - 0.2, ts = h_fa * 0.62)
    translate([0, 0, t_r + h_fa / 2]) rotate([90, 0, 0]) linear_extrude(t_tx)
        resize([min(2 * hf * 0.8, len(dach_text) * ts * 0.72), 0]) text(dach_text, size = ts, font = schrift, halign = "center", valign = "center");
// Kurven: Plattenränder senkrecht (Welt) zuschneiden, damit benachbarte Flächen nicht überlappen
function vdir(k) = let(M = facet_M(k)) [0, M[2][1], M[2][2]];
module halfspace(P0, P1, d, outward) {
    e2 = (P1 - P0) / norm(P1 - P0); n0 = cross(e2, d); n = (outward ? 1 : -1) * n0 / norm(n0); B = 2000;
    multmatrix([[n[0], e2[0], d[0], P0[0]], [n[1], e2[1], d[1], P0[1]], [n[2], e2[2], d[2], P0[2]], [0, 0, 0, 1]]) translate([-B, -B, -B]) cube([B, 2 * B, 2 * B]);
}
module trim(k) {
    if (k[0] == "S") children();
    else let(hf = hw(k, y_rf) - 0.2, hb = hw(k, y_rb) - 0.2, L = Lsl(k), d = vdir(k) / norm(vdir(k)))
        intersection() { children(); halfspace([hf, 0, 0], [hb, L, 0], d, true); halfspace([-hf, 0, 0], [-hb, L, 0], d, false); }
}
module facet_plate(k, fp, txt, flag) trim(k) facet_plate0(k, fp, txt, flag);
module facet_plate0(k, fp, txt, flag) {
    hf = hw(k, y_rf) - 0.2; hb = hw(k, y_rb) - 0.2; L = Lsl(k);
    TR = [[-hf, 0], [hf, 0], [hb, L], [-hb, L]];
    g = boss_g(k);
    if (inc(fp, "A")) difference() {
        union() {
            linear_extrude(t_r) polygon(TR);
            intersection() {
                linear_extrude(t_r + h_sn) polygon(TR);
                n = max(1, floor(2 * hb / max(sc(1000), 6)));
                for (j = [1 : n - 1]) translate([-hb + j * 2 * hb / n - w_sn / 2, 0, 0]) cube([w_sn, L, t_r + h_sn]);
            }
            translate([-hf, 0, 0]) cube([2 * hf, t_fa, t_r + h_fa]);
            hull() { translate([-hb, L - t_fa, 0]) cube([2 * hb, t_fa, t_r + h_fa * 0.35]); }
            if (flag) intersection() {
                translate([0, L - d_boss, 0]) rotate([g, 0, 0]) translate([0, 0, -2]) cylinder(d = d_boss, h = h_boss + t_r + 2, $fn = 24);
                translate([-50, -50, 0]) cube([100, L + 100, 100]);
            }
        }
        for (ub = binders(k)) let(P1 = pl_uv(k, ub, tn_y()[0]), P2 = pl_uv(k, ub, tn_y()[1]), a = atan2(P2[1] - P1[1], P2[0] - P1[0]))
            for (P = [P1, P2]) translate([P[0], P[1], -e]) rotate(a) translate([-(l_tn * 1.06 + 0.6) / 2, -(t_bi + 0.6) / 2, 0]) cube([l_tn * 1.06 + 0.6, t_bi + 0.6, d_pk + e]);
        if (flag) translate([0, L - d_boss, 0]) rotate([g, 0, 0]) translate([0, 0, 0.6]) cylinder(d = stift_d + 0.15, h = h_boss + t_r + 5, $fn = 16);
    }
    if (inc(fp, "B") && txt) dach_text3d(k);
}
function dach_S(k) = let(hh = max(2 * mw, cL + 2) + 3, L = Lsl(k), H = hwmax(k))
    [for (v = [0 : 1 : L - hh]) let(h0 = min(trap_hw(k, v), trap_hw(k, v + hh)) - 0.6) [H - h0, v + voff, H + h0, v + voff + hh]];
function dach_kp(k) = concat([for (ub = binders(k), y = tn_y()) let(q = pl_uv(k, ub, y)) [q[0] + hwmax(k) - l_tn, q[1] + voff - l_tn, q[0] + hwmax(k) + l_tn, q[1] + voff + l_tn]],
    [[hwmax(k) - d_boss, Lsl(k) + voff - 2 * d_boss - 1, hwmax(k) + d_boss, Lsl(k) + voff + 1]]);
function info_dach(k) = let(SX = dach_SX(k), SY = dach_SY(k), xs = SX > usable ? seams_at(SX, [], mw) : [],
    ys = SY > usable ? seams_at(SY, [[0, voff + t_fa + spw / 2 + 1], [SY - t_fa - spw / 2 - 1 - 2 * d_boss, SY + 1]], mw) : [])
    [SX, SY, xs, ys, dach_kp(k), false, 0, dach_S(k), dach_S(k)];
module dach_print(k, fp, txt, flag) translate([hwmax(k), voff, 0]) facet_plate(k, fp, txt, flag);
module roof_world(k, t) {
    flag = fahnen && t != "T";
    txt = t == "B" && dach_text != "";
    color(fhex(farbe_stahl)) binder_world(k);
    multmatrix(facet_M(k)) { color(fhex(farbe_dach)) facet_plate(k, "A", txt, flag); color(fhex(farbe_dach_text)) facet_plate(k, "B", txt, flag); }
    if (flag) let(M = facet_M(k), B0 = M * [0, Lsl(k) - d_boss, 0, 1], top = [B0[0], B0[1], B0[2]] + [0, 0, (h_boss + t_r) / cos(boss_g(k))])
        translate(top + [0, 0, 0.3]) rotate(fahnen_winkel) rotate([90, 0, 0]) translate([-s_sl / 2, 0, -s_sl / 2]) {
            color(fhex(farbe_fahne_1)) fahne_print("A"); color(fhex(farbe_fahne_2)) fahne_print("B"); }
}

// Zielflagge mit Mast-Hülse: Hülse entlang y, Flagge flach (z = 0..t_fl)
nfx = max(2, round(f_w / (f_h / 4)));
module checker_b() for (i = [0 : nfx - 1], j = [0 : 3]) if ((i + j) % 2 == 1)
    translate([s_sl + i * f_w / nfx + 0.06, h_pole - f_h + j * f_h / 4 + 0.06, 0]) cube([f_w / nfx - 0.12, f_h / 4 - 0.12, t_fl]);
module fahne_print(fp) {
    if (inc(fp, "A")) difference() {
        union() { cube([s_sl, h_pole, s_sl]); translate([s_sl - 0.3, h_pole - f_h, 0]) cube([f_w + 0.3, f_h, t_fl]); }
        translate([0, 0, -1]) linear_extrude(t_fl + 2) projection() checker_b();
        translate([s_sl / 2, -1, s_sl / 2]) rotate([-90, 0, 0]) linear_extrude(h_pole + 2) rotate(-90) teardrop((stift_d + 2 * stift_spiel) / 2);
    }
    if (inc(fp, "B")) checker_b();
}

// =====================================================================
//  Aufbau
// =====================================================================
function adv(st, t, g) = let(k = kind_of(t), ep = lp(k, k[1], 0), dh = k[0] == "S" ? 0 : (k[0] == "K" ? -k[1] : k[1]), ew = rotp(ep, st[2]), hh = st[2] + dh)
    [st[0] + ew[0] + g * cos(hh), st[1] + ew[1] + g * sin(hh), hh];
function chain(g, i = 0, st = [0, 0, 0]) = i >= len(EL) ? [st] : concat([st], chain(g, i + 1, adv(st, EL[i], g)));
function bnr(i) = len([for (j = [0 : 1 : i - 1]) if (EL[j] == "B") 1]);
function btxt(i) = len(WL) == 0 ? -1 : WL[bnr(i) % len(WL)];

module element(t, wi, ex) {   // ex = [Sitze, Geländer, Banden, Dach]
    k = kind_of(t); typ = typ_of(t);
    color(fhex(farbe_beton)) body(k, typ, "alle");
    if (typ == "T") color(fhex(farbe_stufenkante)) sweep(k) for (q = NOS) translate([q[0], q[1] - t_n + 0.03]) square([w_n, t_n]);
    if (typ == "B") translate([0, 0, ex[0]]) seats_world(k);
    translate([0, 0, ex[1]]) { rails_world(k, t_f / 2, H_f); rails_world(k, D - t_f / 2, z_u); }
    if (t == "B" && banden && wi >= 0) translate([0, -ex[2], 0]) bande_world(k[1], WRB[wi]);
    if (dach) translate([0, 0, ex[3]]) roof_world(k, t);
}
module tribuene(ex = 0) {
    C = chain(ex > 0 ? max(sc(1200), 10) : 0);
    E = ex > 0 ? [max(sc(1500), 12), max(sc(2500), 18), max(sc(1500), 12), max(sc(3000), 25)] : [0, 0, 0, 0];
    for (i = [0 : len(EL) - 1]) translate([C[i][0], C[i][1], 0]) rotate(C[i][2]) element(EL[i], btxt(i), E);
    translate([C[0][0], C[0][1], 0]) rotate(C[0][2]) translate([-E[0], 0, 0]) sw_world("links");
    n = len(EL) - 1; k = kind_of(EL[n]);
    translate([C[n][0], C[n][1], 0]) rotate(C[n][2]) at(k, k[1], 0) translate([E[0], 0, 0]) sw_world("rechts");
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFOS = concat(
    [["seitenwand_links", info_sw("links"), 1], ["seitenwand_rechts", info_sw("rechts"), 1]],
    dach && nBe + nTe > 0 ? [["binder_block", info_binder(KS), nBe * len(binders(KS)) + nTe * len(binders(KT))]] : [],
    dach && nKe > 0 ? [["binder_kurve_aussen", info_binder(KK), nKe * 2]] : [],
    dach && nIe > 0 ? [["binder_kurve_innen", info_binder(KI), nIe * 2]] : [],
    dach && nBe > 0 ? [["dach_block", info_dach(KS), nBe]] : [],
    dach && nTe > 0 ? [["dach_treppe", info_dach(KT), nTe]] : [],
    dach && nKe > 0 ? [["dach_kurve_aussen", info_dach(KK), nKe]] : [],
    dach && nIe > 0 ? [["dach_kurve_innen", info_dach(KI), nIe]] : []);
function np_of(n) = let(f = [for (i = INFOS) if (i[0] == n) n_pieces(i[1])]) len(f) > 0 ? f[0] : 1;
SEAMCL = lsum([for (t = EL) let(k = kind_of(t)) lsum([for (ys = YS) len(seam_clips(k, ys))])]);
CLIPS = (len(EL) - 1) * len(RBY) + SEAMCL + lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
cpp = floor((usable + 3) / (cL + 3)) * floor((usable + 3) / (cw1 + 3));
SEATS = nBe * n_sb * n_r + nKe * lsum([for (i = [0 : n_r - 1]) n_i(KK, i)]) + nIe * lsum([for (i = [0 : n_r - 1]) n_i(KI, i)]);

echo(str("Tribüne 1:", den, " | ", n_r, " Reihen | Tiefe ", r2(D), " mm | Höhe Umgang ", r2(z_u), " mm",
         dach ? str(" | Dach vorn ", r2(z_front + t_r), " mm") : "", " | Sitzplätze gesamt ", SEATS));
echo(str("Block: ", n_x, " Unterblock/Unterblöcke je B à ", n_sb, " Sitze (", r2(W_sb), " mm) | Treppe ", r2(W_T), " mm | Körper in der Tiefe: ", NB, " Stück(e)",
         NB > 1 ? str(" (Nähte bei ", [for (y = YS) r2(y)], " mm)") : ""));
echo(str("Kurve außen: ", nsegK, " Segment(e) à ", r2(KK[1]), "° | Kurve innen: ", I_OK ? str(nsegI, " Segment(e) à ", r2(KI[1]), "°") : "nicht möglich (Radius zu klein)"));
echo(str("Anordnung: ", anordnung, " -> ", len(EL), " Module: ", nBe, "x Block, ", nTe, "x Treppe, ", nKe, "x Kurve außen, ", nIe, "x Kurve innen"));
if (z_u > druckhoehe) echo(str("WARNUNG: Körperhöhe ", r2(z_u), " mm > Druckhöhe ", druckhoehe, " mm – weniger Reihen oder kleineren Maßstab wählen."));
if (!I_OK && cnt(CH, "I") > 0) echo("WARNUNG: Kurve innen braucht kurve_radius_m > Tribünentiefe – I wird ignoriert.");
if (y_back(0) - d_s < Y(0) - d_v + 0.5) echo("WARNUNG: Reihentiefe zu klein für die Sitze.");
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
if (dach && fahnen) echo(str("Fahnen: Stift Ø ", stift_d, " mm, je ", r2(h_boss + t_r + h_pole - 1), " mm lang"));
echo(str("Verbinder-Clips gesamt: ", CLIPS, " (Modulstöße ", (len(EL) - 1) * len(RBY), ")", CLIPS > cpp ? str(" -> ", ceil(CLIPS / cpp), " Clip-Platten") : ""));

module druck(t, n, fp, f, m) if (m > 0) echo(str("DRUCK|", t, "|", n, "|", fp, "|", f, "|", m));
druck("block", NB, "alle", farbe_beton, nBe);
druck("treppe", NB, "A", farbe_beton, nTe); druck("treppe", NB, "B", farbe_stufenkante, nTe);
druck("kurve_aussen", NB, "alle", farbe_beton, nKe);
druck("kurve_innen", NB, "alle", farbe_beton, nIe);
for (c = uniq([for (i = [0 : n_r - 1]) rowc(i)])) druck("sitze_block", 1, "alle", c, nBe * len([for (i = [0 : n_r - 1]) if (rowc(i) == c) 1]));
for (i = [0 : n_r - 1]) { druck(str("sitze_kurve_aussen_", i + 1), 1, "alle", rowc(i), nKe); druck(str("sitze_kurve_innen_", i + 1), 1, "alle", rowc(i), nIe); }
for (fp = [["A", farbe_gelaender], ["B", farbe_glas]]) {
    druck("gelaender_block", 1, fp[0], fp[1], 2 * nBe);
    druck("gelaender_treppe", 1, fp[0], fp[1], 2 * nTe);
    druck("gelaender_kurve_aussen_vorne", 1, fp[0], fp[1], nKe * nch(KK, t_f / 2));
    druck("gelaender_kurve_aussen_hinten", 1, fp[0], fp[1], nKe * nch(KK, D - t_f / 2));
    druck("gelaender_kurve_innen_vorne", 1, fp[0], fp[1], nIe * nch(KI, t_f / 2));
    druck("gelaender_kurve_innen_hinten", 1, fp[0], fp[1], nIe * nch(KI, D - t_f / 2));
}
if (banden) for (j = WL) let(m = len([for (i = [0 : len(EL) - 1]) if (EL[i] == "B" && btxt(i) == j) 1])) {
    druck(str("bande_", j + 1), 1, "A", farbe_bande, m); druck(str("bande_", j + 1), 1, "B", farbe_bande_text, m); }
for (sd = ["links", "rechts"]) {
    if (seiten_text == "") druck(str("seitenwand_", sd), np_of(str("seitenwand_", sd)), "alle", farbe_seitenwand, 1);
    else { druck(str("seitenwand_", sd), np_of(str("seitenwand_", sd)), "A", farbe_seitenwand, 1);
           druck(str("seitenwand_", sd), np_of(str("seitenwand_", sd)), "B", farbe_seiten_text, 1); }
}
if (dach) {
    druck("binder_block", np_of("binder_block"), "alle", farbe_stahl, nBe * len(binders(KS)) + nTe * len(binders(KT)));
    druck("binder_kurve_aussen", np_of("binder_kurve_aussen"), "alle", farbe_stahl, nKe * 2);
    druck("binder_kurve_innen", np_of("binder_kurve_innen"), "alle", farbe_stahl, nIe * 2);
    if (dach_text != "") { druck("dach_block", np_of("dach_block"), "A", farbe_dach, nBe); druck("dach_block", np_of("dach_block"), "B", farbe_dach_text, nBe); }
    else druck("dach_block", np_of("dach_block"), "alle", farbe_dach, nBe);
    druck("dach_treppe", np_of("dach_treppe"), "alle", farbe_dach, nTe);
    druck("dach_kurve_aussen", np_of("dach_kurve_aussen"), "alle", farbe_dach, nKe);
    druck("dach_kurve_innen", np_of("dach_kurve_innen"), "alle", farbe_dach, nIe);
    if (fahnen) { druck("fahne", 1, "A", farbe_fahne_1, nBe + nKe + nIe); druck("fahne", 1, "B", farbe_fahne_2, nBe + nKe + nIe); }
}
druck("verbinder", ceil(max(CLIPS, 4) / cpp), "alle", farbe_clips, 1);
for (f = FARBEN) echo(str("FARBE|", f[0], "|", f[1]));

if (teil == "aufbau") tribuene();
else if (teil == "explosion") tribuene(1);
else if (teil == "block") body_print(KS, "B", stueck, farbteil);
else if (teil == "treppe") body_print(KT, "T", stueck, farbteil);
else if (teil == "kurve_aussen") body_print(KK, "B", stueck, farbteil);
else if (teil == "kurve_innen") body_print(KI, "B", stueck, farbteil);
else if (teil == "sitze_block") translate([0, d_s + 1, 0]) strip_s();
else if (starts(teil, "sitze_kurve_aussen_")) strip_c_print(KK, sint(teil, 19) - 1);
else if (starts(teil, "sitze_kurve_innen_")) strip_c_print(KI, sint(teil, 18) - 1);
else if (teil == "gelaender_block") panel_print(KS[1] - 2 * c_e, farbteil);
else if (teil == "gelaender_treppe") panel_print(KT[1] - 2 * c_e, farbteil);
else if (teil == "gelaender_kurve_aussen_vorne") panel_print(chord_len(KK, t_f / 2), farbteil);
else if (teil == "gelaender_kurve_aussen_hinten") panel_print(chord_len(KK, D - t_f / 2), farbteil);
else if (teil == "gelaender_kurve_innen_vorne") panel_print(chord_len(KI, t_f / 2), farbteil);
else if (teil == "gelaender_kurve_innen_hinten") panel_print(chord_len(KI, D - t_f / 2), farbteil);
else if (starts(teil, "bande_")) { j = sint(teil, 6) - 1; if (j >= 0 && j < 4) bande_print(WRB[j], L_wb, farbteil); }
else if (teil == "seitenwand_links") split_out(info_sw("links"), stueck) sw_plate("links", farbteil);
else if (teil == "seitenwand_rechts") split_out(info_sw("rechts"), stueck) sw_plate("rechts", farbteil);
else if (teil == "binder_block") split_out(info_binder(KS), stueck) binder_print(KS);
else if (teil == "binder_kurve_aussen") split_out(info_binder(KK), stueck) binder_print(KK);
else if (teil == "binder_kurve_innen") split_out(info_binder(KI), stueck) binder_print(KI);
else if (teil == "dach_block") split_out(info_dach(KS), stueck) dach_print(KS, farbteil, dach_text != "", fahnen);
else if (teil == "dach_treppe") split_out(info_dach(KT), stueck) dach_print(KT, farbteil, false, false);
else if (teil == "dach_kurve_aussen") split_out(info_dach(KK), stueck) dach_print(KK, farbteil, false, fahnen);
else if (teil == "dach_kurve_innen") split_out(info_dach(KI), stueck) dach_print(KI, farbteil, false, fahnen);
else if (teil == "fahne") fahne_print(farbteil);
else if (teil == "verbinder") {
    n = verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4);
    px = floor((usable + 3) / (cL + 3)); py = floor((usable + 3) / (cw1 + 3));
    npl = ceil(n / (px * py));
    for (pl = [0 : npl - 1]) if (stueck == 0 || stueck == pl + 1)
        translate(stueck == 0 ? [pl * (usable + 10), 0, 0] : [0, 0, 0])
        for (i = [pl * px * py : min(n, (pl + 1) * px * py) - 1]) let(j = i - pl * px * py)
            translate([(j % px) * (cL + 3), floor(j / px) * (cw1 + 3), 0]) clip();
}
