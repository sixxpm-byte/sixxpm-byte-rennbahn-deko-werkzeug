include <../../modelle/boxengarage/boxengarage.scad>
include <anl_common.scad>
schritt = 99;
function X(g, v = 1) = g == schritt ? v : 0;
n = N;
for (i = [0 : n - 1]) translate([i * B + (i > 0 ? X(1, 30) * i : 0), 0, 0]) {
    if (schritt >= 1) { color(C_BODEN) boden_welt("A"); if (bodenmarkierung) color(C_MARK) translate([0, 0, hb - mk + 0.02]) linear_extrude(mk) markierung_2d(); }
    if (schritt == 1 && i > 0) pfeil([-B / 2 + 22, T / 2, hb + 8], [-B / 2 + 4, T / 2, hb + 8], 3);
}
if (schritt >= 2) translate([0, 0, X(2, 60)]) color(C_WAND) {
    for (i = [0 : 1 : n - 2]) trennwand_welt((i + 0.5) * B);
    endwand_l_welt(-B / 2); endwand_r_welt((n - 0.5) * B);
}
if (schritt == 2) for (x = concat([-B / 2, (n - 0.5) * B], [for (i = [0 : 1 : n - 2]) (i + 0.5) * B])) pfeil([x, T / 2, Hg + 110], [x, T / 2, Hg + 70], 3.5);
lift = schritt >= 8 ? lift_max : lift_max * 0.35;
for (i = [0 : n - 1]) translate([i * B, 0, 0]) {
    if (schritt >= 3) { color(C_WAND) translate([0, 0, X(3, 70)]) rueckwand_welt(); if (schritt == 3) pfeil([0, yb0, Hg + 120], [0, yb0, Hg + 75], 3.5); }
    if (schritt >= 4) { color(C_TOR) translate([0, 0, X(4, 70)]) tor_welt(lift); if (schritt == 4) pfeil([0, yd, Hg + 120], [0, yd, Hg + 75], 3.5); }
    if (schritt >= 5) { translate([0, 0, X(5, 70)]) { color(C_BLENDE) blende_welt("A", box_nummer + i); color(C_SCHRIFT) blende_welt("B", box_nummer + i); }
                        if (schritt == 5) pfeil([0, yf1, Hg + 120], [0, yf1, Hg + 75], 3.5); }
    if (schritt >= 6) { color(C_DACH) translate([0, 0, X(6, 40)]) dach_welt(); if (schritt == 6) pfeil([0, T / 2, Hg + 90], [0, T / 2, Hg + 45], 3.5); }
    if (schritt >= 7 && dach_gelaender) color(C_GEL) translate([0, 0, X(7, 30)]) gelaender_welt();
}
if (schritt >= 8) for (i = [0 : n - 1]) translate([0, 0, X(8, 25)]) zubehoer_box(i, n);
