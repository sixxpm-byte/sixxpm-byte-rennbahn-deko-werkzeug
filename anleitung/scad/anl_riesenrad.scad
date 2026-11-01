include <../../modelle/riesenrad/riesenrad.scad>
include <anl_common.scad>
schritt = 99;
nur_haus = 0;
function X(g, v = 1) = g == schritt ? v : 0;
phi = radstellung;
module haus(s0) {
    if (schritt >= s0) color("#bdc3c7") haus_boden();
    if (schritt >= s0 + 1) translate([0, 0, X(s0 + 1, 25)]) color("#f5deb3") for (k = ["vorne", "hinten", "links", "rechts"]) wand_welt(k);
    if (schritt >= s0 + 2) translate([0, 0, X(s0 + 2, 30)]) color("#c0392b") haus_dach();
    if (schritt >= s0 + 3) translate([0, 0, X(s0 + 3, 20)]) { color("#f1c40f") schild_welt("A"); color("#c0392b") schild_welt("B"); }
    if (schritt >= s0 + 1 && schritt <= s0 + 3) translate([W_h / 2, D_h / 2, H_h + 34]) pfeil([0, 0, 22], [0, 0, 4], 2.4);
}
module scheibe_ax(sy) { color("#ecf0f1") scheibe_welt(sy); color("#7f8c8d") rotate([0, 0, sy > 0 ? 0 : 180]) rotate([0, 0, 90]) achse_lokal(); }
WL = 9;   // ab hier steht das Rad im Rahmen
module wheel(base) {   // base = Lift des ganzen Rads
    translate([0, 0, base]) {
        translate([0, 0, z_hub]) rotate([0, -phi, 0]) {
            if (schritt >= 4) translate([0, X(4, 40), 0]) scheibe_ax(1);
            if (schritt >= 5) color("#555") for (t = TH) translate([R_o * cos(t), -W_in / 2 - t_r + 0.2 - X(5, 30), R_o * sin(t)]) rotate([0, 0, 90]) rotate([90 - t, 0, 0]) querstange_lokal();
            if (schritt >= 7) translate([0, -X(7, 45), 0]) scheibe_ax(-1);
        }
        if (schritt >= 6) for (k = [0 : n_g - 1]) translate(pivot(k, phi) + [0, -X(6, 35), 0]) gondel(G_COL[k % len(G_COL)]);
        if (schritt >= 8) color("#2c3e50") for (sy = [-1, 1]) translate([0, sy * X(8, 35), 0]) stuetze_welt(sy);
        if (schritt == 4) pfeil([0, 60, z_hub + R_o * 0.5], [0, 15, z_hub + R_o * 0.5], 4);
        if (schritt == 5) for (t = [TH[0], TH[3], TH[6], TH[9]]) pfeil([R_o * cos(t + phi), -75, z_hub + R_o * sin(t + phi)], [R_o * cos(t + phi), -35, z_hub + R_o * sin(t + phi)], 3);
        if (schritt == 6) for (k = [0, 3, 6, 9]) pfeil(pivot(k, phi) + [0, -80, -15], pivot(k, phi) + [0, -40, -15], 3);
        if (schritt == 7) pfeil([0, -95, z_hub + R_o * 0.5], [0, -45, z_hub + R_o * 0.5], 4);
        if (schritt == 8) for (sy = [-1, 1]) pfeil([0, sy * (y_o + 70), z_hub * 0.5], [0, sy * (y_o + 38), z_hub * 0.5], 4);
    }
}
if (nur_haus == 1) haus(10);
else {
    show_frame = schritt <= 3 || schritt >= WL;
    if (show_frame) {
        if (schritt >= 1) color("#95a5a6") grundrahmen();
        if (schritt >= 2) { translate([0, 0, z_b + X(2, 35)]) color("#d35400") einstieg(); if (schritt == 2) pfeil([0, 0, z_b + 90], [0, 0, z_b + 45], 4); }
        if (schritt >= 3) color("#2c3e50") for (sy = [-1, 1]) translate([0, 0, X(3, 40)]) strebe_welt(sy);
    }
    if (schritt >= 4) wheel(schritt == WL ? 80 : 0);
    if (schritt == WL) for (sx = [-1, 1]) pfeil([sx * R_o * 0.7, 0, z_hub + 60], [sx * R_o * 0.7, 0, z_hub + 15], 5);
    if (schritt >= 10) translate([X_b + m_h + 3, -Y_o - D_h * 0.3, 0]) haus(10);
}
