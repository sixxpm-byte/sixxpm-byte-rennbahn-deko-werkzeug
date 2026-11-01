include <../../modelle/imbissbude/imbissbude.scad>
include <anl_common.scad>
schritt = 99;
function X(g, v = 1) = g == schritt ? v : 0;
a = schritt >= 8 ? a_d : (schritt == 7 ? 20 : a_d);
if (schritt >= 1) color(C_BASIS) basis_welt();
if (schritt >= 2) {
    color(C_WAND) { translate([-X(2, 25), 0, 0]) wand_welt("links"); translate([X(2, 25), 0, 0]) wand_welt("rechts"); }
    if (schritt == 2) { pfeil([-32, D / 2, hb + H * 0.6], [-8, D / 2, hb + H * 0.6], 2); pfeil([W + 32, D / 2, hb + H * 0.6], [W + 8, D / 2, hb + H * 0.6], 2); }
}
if (schritt >= 3) {
    color(C_WAND) { translate([0, -X(3, 25), 0]) wand_welt("vorne"); translate([0, X(3, 25), 0]) wand_welt("hinten"); }
    if (schritt == 3) { pfeil([W / 2, -32, hb + H * 0.85], [W / 2, -8, hb + H * 0.85], 2); pfeil([W / 2, D + 32, hb + H * 0.6], [W / 2, D + 8, hb + H * 0.6], 2); }
}
if (schritt >= 4) { color(C_THEKE) translate([0, -X(4, 25), 0]) theke_welt(); if (schritt == 4) pfeil([W / 2, -40, hb + H * 0.42], [W / 2, -15, hb + H * 0.42], 2); }
if (schritt >= 5) { color(C_DACH) translate([0, 0, X(5, 25)]) dach_welt(); if (schritt == 5) pfeil([W / 2, D / 2, z_r0 + 50], [W / 2, D / 2, z_r0 + 28], 2.4); }
if (schritt >= 6) { translate([0, 0, X(6, 18)]) { color(C_A) schild_welt("A"); color(C_B) schild_welt("B"); } if (schritt == 6) pfeil([W / 2, y_s, z_r0 + 45], [W / 2, y_s, z_r0 + 25], 2); }
if (schritt >= 7) {
    translate([0, -X(7, 20), 0]) color(C_KLAPPE) klappe_welt(a);
    if (schritt == 7) pfeil([-25, AX_Y - 20, AX_Z], [-5, AX_Y - 20, AX_Z], 1.6);
}
if (schritt >= 8) { color("#9aa0a6") for (x = xp) translate(P1(x)) align(PU) stuetze_local(); }
if (schritt >= 9) translate([0, 0, hb + X(9, 15)]) {
    if (stehtische > 0) for (i = [0 : stehtische - 1]) color("#7b5b3a") translate([W * 0.25 + W * 0.75 * (i + 0.5) / stehtische, -m_f * 0.6, 0]) stehtisch();
    if (muelltonnen > 0) for (i = [0 : muelltonnen - 1]) color("#2e6b3a") translate([-m_s + sc(290, 2) + 0.3 + i * sc(650, 6), -m_f + sc(365, 2.5) + 0.3, 0]) muelltonne();
    if (gasflaschen > 0) for (i = [0 : gasflaschen - 1]) color("#d4a017") translate([W * 0.85 - i * sc(380, 4.5), D + m_b * 0.5, 0]) gasflasche();
    if (kistenstapel > 0) for (i = [0 : kistenstapel - 1]) color("#1f4e9c") translate([W + m_s * 0.5, D * 0.6 - i * sc(450, 4), 0]) rotate([0, 0, 90]) kistenstapel();
}
