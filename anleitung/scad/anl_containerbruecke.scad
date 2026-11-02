include <../../modelle/containerbruecke/containerbruecke.scad>
include <anl_common.scad>
schritt = 99;
function X(g, v = 1) = g == schritt ? v : 0;
function K(v) = v * 43 / den;                 // Abstände wurden für 1:43 gewählt -> mit dem Maßstab umrechnen
AR = max(K(4.5), 2);
for (sy = [-1, 1]) for (i = [0 : SCHN - 1]) if (schritt >= 1) color(C_BETON) translate([-SCHL / 2 + i * SCHS + i * X(1, K(30)), sy * G / 2, 0]) schiene_seg(SCHS);
translate([0, 0, rail_top]) {
    if (schritt >= 2) for (sx = [-1, 1], sy = [-1, 1]) color(C_DUNKEL) translate([sx * P / 2, sy * G / 2, X(2, K(40))]) fahrwerk();
    if (schritt == 2) for (sx = [-1, 1], sy = [-1, 1]) pfeil([sx * P / 2, sy * G / 2, K(110)], [sx * P / 2, sy * G / 2, K(60)], AR);
    if (schritt >= 3) color(C_BLAU) for (sx = [-1, 1]) translate([0, 0, X(3, K(80))]) portalrahmen_welt(sx);
    if (schritt == 3) for (sx = [-1, 1]) pfeil([sx * P / 2, 0, z_a + K(250)], [sx * P / 2, 0, z_a + K(150)], AR * 1.5);
    if (schritt >= 4) color(C_BLAU) for (sx = [-1, 1], sy = [-1, 1]) translate([sx * X(4, K(80)), 0, 0]) konsole_welt(sx, sy);
    if (schritt == 4) for (sx = [-1, 1], sy = [-1, 1]) pfeil([sx * (P / 2 + K(170)), sy * G / 2, zg0], [sx * (P / 2 + K(90)), sy * G / 2, zg0], AR);
    if (schritt >= 5) { color(C_BLAU) translate([0, 0, X(5, K(100))]) mastriegel_welt(); if (schritt == 5) pfeil([0, y_a, z_a + K(260)], [0, y_a, z_a + K(140)], AR * 1.5); }
    if (schritt >= 6) translate([0, 0, X(6, K(120))]) { color(C_WEISS) for (sx = [-1, 1]) traeger_welt(sx); color(C_WEISS) endriegel_welt(); }
    if (schritt == 6) for (y = [y_b * 0.6, G * 0.6]) pfeil([0, y, zg1 + K(260)], [0, y, zg1 + K(140)], AR * 1.5);
    if (schritt >= 7) color(C_WEISS) translate([0, X(7, K(120)), 0]) { for (sx = [-1, 1]) ausleger_welt(sx, 0); spitzenriegel_welt(0); }
    if (schritt == 7) pfeil([0, y_h + K(300), zg1 + K(40)], [0, y_h + K(150), zg1 + K(40)], AR * 1.5);
    if (schritt >= 8) { color(C_WEISS) translate([0, y_b, zg1 - dch + X(8, K(90))]) maschinenhaus(); if (schritt == 8) pfeil([0, y_b, zg1 + K(250)], [0, y_b, zg1 + K(130)], AR * 1.5); }
    if (schritt >= 9) translate([0, 0, X(9, K(100))]) { color(fhex(farbe_katze)) translate([0, yk, zg1 - dch]) katze(); color(fhex(farbe_katze)) translate([0, yk + cab_y0, zg1 - dch]) kabine(); }
    if (schritt == 9) pfeil([0, yk, zg1 + K(300)], [0, yk, zg1 + K(160)], AR * 1.5);
    if (schritt >= 10) {
        z_sp = sc(2896) + 1 + (zg0 - sc(300) - sp_t - max(sc(500), 1.5) - sc(2896) - 2) * min(1, max(0, spreader_hoehe));
        color(C_DUNKEL) translate([0, yk, z_sp]) spreader();
        color("#222") for (sx = [-1, 1], sy = [-1, 1]) translate([sx * xs_r, yk + sy * ys_r, z_sp + sp_t]) cylinder(d = max(K(0.8), 0.5), h = zg1 - dch - z_sp - sp_t);
        color("#333") {
            hull() { translate([P / 2 - t_s, y_a + t_m / 2 + 1, z_a + h_m * 0.1]) sphere(d = max(K(0.8), 0.5)); translate([Bx / 2, y_o - sc(400), zg1 - cdg]) sphere(d = max(K(0.8), 0.5)); }
            hull() { translate([P / 2 - t_s, y_a - t_m / 2 - 1, z_a + h_m * 0.1]) sphere(d = max(K(0.8), 0.5)); translate([Bx / 2, y_b + sc(400), zg1 - cdg]) sphere(d = max(K(0.8), 0.5)); }
        }
    }
}
