include <../../modelle/hafenkran/hafenkran.scad>
include <anl_common.scad>
schritt = 99;
detail = 0;           // 1 = Drehbühne von unten mit Clips
function X(g, v = 1) = g == schritt ? v : 0;
rot = drehung; th = TH;
ad  = max(sc(1500), 14);                     // Hubweg der Teile im Bauschritt (maßstabsabhängig)
pd_ = max(sc(100), 1.5);                     // Pfeildicke
module ab(p, h) pfeil([p[0], p[1], p[2] + h + ad * 0.8], [p[0], p[1], p[2] + h + 1], pd_);
// Lage der Clips an den Nähten eines geteilten Teils: [x, y, Drehung]
function clip_pos(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7]) concat(
    [for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) for (y = clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp, S, SY)) [xs[k], y, 0]],
    [for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) for (x = clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp, S, SX)) [x, ys[k], 90]]);

if (detail == 1) {   // Drehbühne umgedreht, Clips über den Taschen der Unterseite
    CP = clip_pos(info_drehbuehne());
    rotate([180, 0, 0]) { color(C_HELL) drehbuehne_druck(); for (c = CP) translate([c[0], c[1], -ad * 0.5 - ch]) rotate(c[2]) color(fhex(farbe_clips)) clip(); }
    for (c = CP) pfeil([c[0], -c[1], ad * 0.5 - 0.5], [c[0], -c[1], 1], pd_);
} else {
    for (sy = [-1, 1]) for (i = [0 : SCHN - 1]) translate([-SCHL / 2 + i * SCHS + (i > 0 ? X(1, ad) : 0), sy * Gy / 2, 0]) color(C_BETON) schiene_seg(SCHS);
    if (schritt == 1 && SCHN > 1) for (sy = [-1, 1]) pfeil([-SCHL / 2 + SCHS + ad * 1.6, sy * Gy / 2, bh], [-SCHL / 2 + SCHS + ad * 1.1, sy * Gy / 2, bh], pd_);
    translate([0, 0, rail_top]) {
        if (schritt >= 2) for (sx = [-1, 1], sy = [-1, 1]) color(C_DUNKEL) translate([sx * Rx / 2, sy * Gy / 2, X(2, ad)]) fahrwerk();
        if (schritt == 2) for (sx = [-1, 1], sy = [-1, 1]) ab([sx * Rx / 2, sy * Gy / 2, hbg], ad);
        if (schritt >= 3) color(C_STAHL) for (sy = [-1, 1]) translate([0, 0, X(3, ad)]) seite_welt(sy);
        if (schritt == 3) for (sy = [-1, 1]) ab([0, sy * Gy / 2, zt + tab_h], ad);
        if (schritt >= 4) color(C_STAHL) for (sx = [-1, 1]) translate([sx * X(4, ad), 0, 0]) quer_welt(sx);
        if (schritt == 4) for (sx = [-1, 1]) pfeil([sx * (Rx / 2 + ad * 1.9), 0, zt - hg / 2], [sx * (Rx / 2 + ad * 1.1), 0, zt - hg / 2], pd_);
        if (schritt >= 5) color(C_HELL) translate([0, 0, X(5, ad)]) plattform_welt();
        if (schritt == 5) ab([0, 0, zt + tpl + h_ring], ad);
        if (schritt >= 6) color(fhex(farbe_zapfen)) translate([0, 0, z_os - l_pin + tbs * 0.7 + X(6, ad)]) zapfen();
        translate([0, 0, z_os]) rotate([0, 0, rot]) {
            if (schritt >= 6) color(C_HELL) translate([0, 0, X(6, ad)]) drehbuehne();
            if (schritt == 6) ab([0, 0, tbs + H_h], ad);
            if (schritt >= 7) { color(C_STAHL) for (sy = [-1, 1]) translate([0, 0, X(7, ad)]) turm_welt(sy); color(C_DUNKEL) translate([0, 0, X(7, ad * 1.4)]) traverse_welt(); }
            if (schritt == 7) ab([x_p, 0, z_p + rbp], ad);
            if (schritt >= 8) color(C_STAHL) translate([x_p, 0, z_p + X(8, ad)]) rotate([0, -th, 0]) ausleger_lokal();
            if (schritt == 8) ab([x_p + ad, 0, z_p + h_m], ad);
            if (schritt >= 9) let(J = Jp(th), ph = atan2(J[1] - K[1], J[0] - K[0]))
                color(C_DUNKEL) for (sy = [-1, 1]) translate([J[0], sy * (y_r + X(9, ad)) + tr / 2, J[1]]) rotate([90, 0, 0]) rotate([0, 0, ph + 180]) linear_extrude(tr) wippstange_2d();
            if (schritt == 9) let(J = Jp(th)) for (sy = [-1, 1]) pfeil([J[0], sy * (y_r + ad * 1.8), J[1]], [J[0], sy * (y_r + ad * 0.6), J[1]], pd_);
            if (schritt >= 10) let(tip = [x_p + (L_j + h_h * 0.15) * cos(th), z_p + (L_j + h_h * 0.15) * sin(th)], zh = tip[1] * haken_hoehe) {
                color("#222") translate([tip[0], 0, zh + hk_h * 0.45]) cylinder(d = max(sc(25), 0.4), h = tip[1] - zh - hk_h * 0.45);
                color(fhex(farbe_haken)) translate([tip[0], hk_t / 2, zh]) rotate([90, 0, 0]) linear_extrude(hk_t) haken_2d();
            }
        }
    }
}
