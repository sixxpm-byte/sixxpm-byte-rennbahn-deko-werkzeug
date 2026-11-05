include <../../modelle/straddle_carrier/straddle_carrier.scad>
include <anl_common.scad>
// Bauschritt-Szene Straddle Carrier.  schritt = Bauschritt, detail: 1 = Magnettasche im Kopfträger
schritt = 99;
detail = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(1.5), 14);                       // Abhebeweg im Schritt
pd_ = max(M(0.1), 1.4);                      // Pfeildicke
module c2(fa, fb) { color(fhex(fa)) render() children(0); color(fhex(fb)) render() children(1); }

module unterteil(s) {
    for (sy = [-1, 1]) color(fhex(farbe_gelb)) render() fahrwerk_welt(sy);
    for (sx = [-1, 1], sy = [-1, 1]) rein([0, sy * ad, 0], X(1), [sx * XL, sy * (y_a + s_r + B_w + 1), z_ax], pd_)
        c2(farbe_reifen, farbe_felge) { rad_welt(sx, sy, "A"); rad_welt(sx, sy, "B"); }
    if (s >= 2) rein([0, ad, 0], X(2), [(K_X0 + MO_X1) / 2, y_k0 + K_T + 1, (K_Z0 + K_Z1) / 2], pd_) {
        c2(farbe_gelb, farbe_glas) { kabine_welt("A"); kabine_welt("B"); }
        c2(farbe_gelb, farbe_gitter) { motor_welt("A"); motor_welt("B"); }
    }
    if (s >= 3) for (sx = [-1, 1], sy = [-1, 1]) rein([0, 0, ad], X(3), [sx * XL, sy * (y_ib + t_ib / 2), Z_f1 + L_ib - l_in], pd_)
        c2(farbe_innenbein, farbe_stange) { innenbein_welt(sx, sy, "A"); innenbein_welt(sx, sy, "B"); }
}
// Oberteil: Oberrahmen mit Trägern (Schritt 4), Spreader (Schritt 5)
module oberteil(s) {
    for (sy = [-1, 1]) rein([0, sy * ad, 0], X(4), [0, sy * (y_a + 1), H - HO / 2], pd_) color(fhex(farbe_gelb)) render() oberrahmen_welt(sy);
    for (r = [0, 180]) rotate([0, 0, r]) c2(farbe_gelb, farbe_leuchte) { quertraeger_welt("A"); quertraeger_welt("B"); }
    color(fhex(farbe_gelb)) render() mitteltraeger_welt();
    if (s >= 5) rein([0, 0, -ad], X(5), [0, 0, z_r1 + 1], pd_) {
        color(fhex(farbe_spreader)) render() spreader_rahmen_welt();
        for (r = [0, 180]) rotate([0, 0, r]) translate([X(5) * ad, 0, 0]) c2(farbe_kopf, farbe_spreader) { spreader_arm_welt("A"); spreader_arm_welt("B"); }
        if (s == 5) for (r = [0, 180]) rotate([0, 0, r]) pfeil([x_kt + eb_x + ad * 1.1, 0, (Z_hub + z_bt) / 2], [x_kt + eb_x + ad * 0.25, 0, (Z_hub + z_bt) / 2], pd_);
    }
}
if (detail == 1) {
    // Kopfträger in Druckausrichtung (Unterseite oben), Magnet schwebt über der Tasche
    color(fhex(farbe_kopf)) render() spreader_arm_druck("A");
    color(fhex(farbe_spreader)) render() spreader_arm_druck("B");
    if (magnete) for (y = Y_MG) translate([x_kt, -y, z_bt - Z_hub - h_mt + ad * 0.8]) {
        color("#9aa0a6") cylinder(d = magnet_d, h = magnet_h, $fn = 48);
        pfeil([0, 0, magnet_h + ad * 0.9], [0, 0, magnet_h + ad * 0.15], pd_);
    }
}
else if (schritt <= 3) unterteil(schritt);
else if (schritt <= 5) oberteil(schritt);
else {
    unterteil(99);
    translate([0, 0, X(6) * ad * 1.6]) oberteil(99);
    if (X(6) > 0) for (sx = [-1, 1], sy = [-1, 1]) pfeil([sx * XL, sy * (y_ib + t_ib / 2), Z_ob0 + ad * 1.4], [sx * XL, sy * (y_ib + t_ib / 2), Z_ob0 + ad * 0.3], pd_);
    if (schritt >= 7) translate([0, 0, -X(7) * ad]) container_vorschau(L_c20);
    if (X(7) > 0) pfeil([0, W_ct / 2 + 4, Z_hub - ad - 2], [0, W_ct / 2 + 4, Z_hub - 2], pd_);
}
