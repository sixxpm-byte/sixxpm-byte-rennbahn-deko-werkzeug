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
