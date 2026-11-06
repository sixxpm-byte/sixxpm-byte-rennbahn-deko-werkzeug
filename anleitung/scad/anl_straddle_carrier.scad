include <../../modelle/straddle_carrier/straddle_carrier.scad>
include <anl_common.scad>
// Bauschritt-Szene Straddle Carrier.  schritt = Bauschritt, detail: 1 = Teleskoparm in den Kopfträger,
// 2 = Magnete ins Containerdach; ansicht: 1 = Container-Bausatz (Schritte 1/2), 2 = 40 Fuß verclipsen
schritt = 99;
detail = 0;
ansicht = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(1.5), 14);                       // Abhebeweg im Schritt
pd_ = max(M(0.1), 1.4);                      // Pfeildicke
module c2(fa, fb) { color(fhex(fa)) render() children(0); color(fhex(fb)) render() children(1); }

module unterteil(s) {
    for (sy = [-1, 1]) color(fhex(farbe_gelb)) render() fahrwerk_welt(sy);
    for (sx = [-1, 1], sy = [-1, 1]) rein([0, sy * ad, 0], X(1), [sx * XL, sy * (y_a + s_r + B_w + 1), z_ax], pd_)
        { color(fhex(farbe_reifen)) render() rad_welt(sx, sy, "A"); translate([0, sy * X(1) * ad * 0.6, 0]) color(fhex(farbe_felge)) render() rad_welt(sx, sy, "B"); }
    if (s >= 2) rein([0, ad, 0], X(2), [(K_X0 + MO_X1) / 2, y_k0 + K_T + 1, (K_Z0 + K_Z1) / 2], pd_) {
        color(fhex(farbe_gelb)) render() kabine_welt("A"); translate([0, 0, -X(2) * ad * 0.7]) color(fhex(farbe_glas)) render() kabine_welt("B");
        color(fhex(farbe_gelb)) render() motor_welt(); translate([0, X(2) * ad * 0.5, 0]) color(fhex(farbe_gitter)) render() motor_gitter_welt();
    }
    if (s >= 3) for (sx = [-1, 1], sy = [-1, 1]) rein([0, 0, ad], X(3), [sx * XL, sy * (y_ib + t_ib / 2), Z_f1 + L_ib - l_in], pd_)
        { color(fhex(farbe_innenbein)) render() innenbein_welt(sx, sy, "A"); translate([0, 0, X(3) * ad * 0.5]) color(fhex(farbe_stange)) render() innenbein_welt(sx, sy, "B"); }
}
// Oberteil: Oberrahmen mit Trägern (Schritt 4), Spreader (Schritt 5)
module oberteil(s) {
    for (sy = [-1, 1]) rein([0, sy * ad, 0], X(4), [0, sy * (y_a + 1), H - HO / 2], pd_) color(fhex(farbe_gelb)) render() oberrahmen_welt(sy);
    for (r = [0, 180]) rotate([0, 0, r]) { color(fhex(farbe_gelb)) render() quertraeger_welt("A"); translate([X(4) * ad * 0.5, 0, 0]) color(fhex(farbe_leuchte)) render() quertraeger_welt("B"); }
    color(fhex(farbe_gelb)) render() mitteltraeger_welt();
    if (s >= 5) rein([0, 0, -ad], X(5), [0, 0, z_r1 + 1], pd_) {
        color(fhex(farbe_spreader)) render() spreader_rahmen_welt();
        for (r = [0, 180]) rotate([0, 0, r]) translate([X(5) * ad, 0, 0]) { color(fhex(farbe_spreader)) render() spreader_arm_welt(); color(fhex(farbe_kopf)) render() kopftraeger_welt(); }
        if (s == 5) for (r = [0, 180]) rotate([0, 0, r]) pfeil([x_kt + eb_x + ad * 1.1, 0, (Z_hub + z_bt) / 2], [x_kt + eb_x + ad * 0.25, 0, (Z_hub + z_bt) / 2], pd_);
    }
}
// Container-Bausatz (lokal): Schritt 1 Boden + Stirnseiten, 2 Seitenwände + Dach
module container_c(s, Lc = L_c20) {
    color(fhex(farbe_beschlag)) render() ct_boden(Lc);
    rein([-ad, 0, 0], X(1), [-2, W_ct / 2, H_ct / 2], pd_) c2(farbe_container, farbe_beschlag) { ct_stirn(Lc, "A"); ct_stirn(Lc, "B"); }
    rein([ad, 0, 0], X(1), [Lc + 2, W_ct / 2, H_ct / 2], pd_) c2(farbe_container, farbe_beschlag) { ct_stirn(Lc, "A", true); ct_stirn(Lc, "B", true); }
    if (s >= 2) {
        rein([0, -ad, 0], X(2), [Lc / 2, -2, H_ct / 2], pd_) color(fhex(farbe_container)) render() ct_seite(Lc);
        rein([0, ad, 0], X(2), [Lc / 2, W_ct + 2, H_ct / 2], pd_) translate([Lc, W_ct, 0]) rotate([0, 0, 180]) color(fhex(farbe_container)) render() ct_seite(Lc);
        rein([0, 0, ad], X(2), [Lc / 2, W_ct / 2, H_ct + 2], pd_) c2(farbe_container, farbe_beschlag) { ct_dach(Lc, "A"); ct_dach(Lc, "B"); }
    }
}
if (ansicht == 1) container_c(schritt);
else if (ansicht == 2) {   // 40 Fuß: Boden und Dach in Druckorientierung (Teile mit Clip-Taschen)
    for (nm = ["boden", "dach"]) translate([0, nm == "boden" ? 0 : W_ct + 20, 0])
        color(fhex(nm == "boden" ? farbe_beschlag : farbe_container)) render() ct_druck(L_c40, nm, "alle", 0);
}
else if (detail == 2) {
    // Containerdach kopfüber (Innenseite oben), Magnete schweben über den Taschen
    c2(farbe_container, farbe_beschlag) { ct_druck(L_c20, "dach", "A", 0); ct_druck(L_c20, "dach", "B", 0); }
    if (magnete) for (p = ct_mag_pos(L_c20)) translate([p[0], W_ct - p[1], H_ct - ct_mag_z0 + ad * 0.7]) {
        color("#9aa0a6") cylinder(d = magnet_d, h = magnet_h, $fn = 48);
        pfeil([0, 0, magnet_h + ad * 0.9], [0, 0, magnet_h + ad * 0.15], pd_);
    }
}
else if (detail == 1) {
    // Teleskoparm-Ende schwebt über der Schwalbenschwanz-Aufnahme des Kopfträgers
    color(fhex(farbe_kopf)) render() kopftraeger_welt();
    translate([0, 0, ad * 1.2]) color(fhex(farbe_spreader)) render() intersection() { spreader_arm_welt(); translate([xk - 8 * n_d, -W_kt, 0]) cube([9 * n_d + 1, 2 * W_kt, 2 * H]); }
    pfeil([xk - 4 * n_d, yb0 - 2 * n_d, z_bt + ad * 1.1], [xk - 4 * n_d, yb0 - 2 * n_d, z_bt + ad * 0.2], pd_);
}
else if (schritt <= 3) unterteil(schritt);
else if (schritt <= 5) oberteil(schritt);
else {
    unterteil(99);
    translate([0, 0, X(6) * ad * 1.6]) oberteil(99);
    if (X(6) > 0) for (sx = [-1, 1], sy = [-1, 1]) pfeil([sx * XL, sy * (y_ib + t_ib / 2), Z_ob0 + ad * 1.4], [sx * XL, sy * (y_ib + t_ib / 2), Z_ob0 + ad * 0.3], pd_);
    if (schritt >= 7) translate([0, 0, -X(7) * ad]) container_welt(L_c20);
    if (X(7) > 0) pfeil([0, W_ct / 2 + 4, Z_hub - ad - 2], [0, W_ct / 2 + 4, Z_hub - 2], pd_);
}
