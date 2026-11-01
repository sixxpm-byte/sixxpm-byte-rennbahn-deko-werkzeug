include <../../modelle/hafenkran/hafenkran.scad>
include <anl_common.scad>
schritt = 99;
function X(g, v = 1) = g == schritt ? v : 0;
rot = drehung; th = TH;
for (sy = [-1, 1]) for (i = [0 : SCHN - 1]) if (schritt >= 1) translate([-SCHL / 2 + i * SCHS + (i > 0 ? X(1, 25) : 0), sy * Gy / 2, 0]) color(C_BETON) schiene_seg(SCHS);
if (schritt == 1) for (sy = [-1, 1]) pfeil([-SCHL / 2 + SCHS + 40, sy * Gy / 2, 12], [-SCHL / 2 + SCHS + 28, sy * Gy / 2, 12], 3);
translate([0, 0, rail_top]) {
    if (schritt >= 2) for (sx = [-1, 1], sy = [-1, 1]) color(C_DUNKEL) translate([sx * Rx / 2, sy * Gy / 2, X(2, 30)]) fahrwerk();
    if (schritt >= 3) color(C_STAHL) for (sy = [-1, 1]) translate([0, 0, X(3, 40)]) seite_welt(sy);
    if (schritt >= 4) color(C_STAHL) for (sx = [-1, 1]) translate([sx * X(4, 50), 0, 0]) quer_welt(sx);
    if (schritt >= 5) color(C_HELL) translate([0, 0, X(5, 50)]) plattform_welt();
    if (schritt >= 6) color("#888") translate([0, 0, z_os - l_pin + tbs * 0.7 + X(6, 60)]) zapfen();
    if (schritt == 2) for (sx = [-1, 1], sy = [-1, 1]) pfeil([sx * Rx / 2, sy * Gy / 2, 60], [sx * Rx / 2, sy * Gy / 2, 35], 3);
    if (schritt == 3) for (sy = [-1, 1]) pfeil([0, sy * Gy / 2, z_os + 80], [0, sy * Gy / 2, z_os + 45], 3.5);
    if (schritt == 4) for (sx = [-1, 1]) pfeil([sx * (Rx / 2 + 95), 0, z_os * 0.6], [sx * (Rx / 2 + 55), 0, z_os * 0.6], 3.5);
    if (schritt == 5) pfeil([0, 0, z_os + 110], [0, 0, z_os + 60], 4);
    translate([0, 0, z_os]) rotate([0, 0, rot]) {
        if (schritt >= 6) color(C_HELL) translate([0, 0, X(6, 60)]) drehbuehne();
        if (schritt == 6) pfeil([0, 0, 170], [0, 0, 110], 4);
        if (schritt >= 7) { color(C_STAHL) for (sy = [-1, 1]) translate([0, 0, X(7, 60)]) turm_welt(sy); color(C_DUNKEL) translate([0, 0, X(7, 80)]) traverse_welt(); }
        if (schritt == 7) pfeil([rear_x(tr_z), 0, tr_z + 160], [rear_x(tr_z), 0, tr_z + 100], 4);
        if (schritt >= 8) color(C_STAHL) translate([x_p, 0, z_p + X(8, 60)]) rotate([0, -th, 0]) ausleger_lokal();
        if (schritt == 8) pfeil([x_p + 60, 0, z_p + 130], [x_p + 60, 0, z_p + 70], 4);
        if (schritt >= 9) let(J = Jp(th), d = dist(J, K), ph = atan2(J[1] - K[1], J[0] - K[0]))
            color(C_DUNKEL) for (sy = [-1, 1]) translate([J[0], sy * (y_r + X(9, 40)) + tr / 2, J[1]]) rotate([90, 0, 0]) rotate([0, 0, ph + 180]) linear_extrude(tr) wippstange_2d();
        if (schritt == 9) let(J = Jp(th)) for (sy = [-1, 1]) pfeil([J[0], sy * (y_r + 70), J[1]], [J[0], sy * (y_r + 25), J[1]], 3);
        if (schritt >= 10) let(tip = [x_p + (L_j + h_h * 0.15) * cos(th), z_p + (L_j + h_h * 0.15) * sin(th)], zh = tip[1] * haken_hoehe) {
            color("#222") translate([tip[0], 0, zh + hk_h * 0.45]) cylinder(d = 0.6, h = tip[1] - zh - hk_h * 0.45);
            color("#f1c40f") translate([tip[0], hk_t / 2, zh]) rotate([90, 0, 0]) linear_extrude(hk_t) haken_2d();
        }
    }
}
