include <../../modelle/reachstacker/reachstacker.scad>
include <anl_common.scad>
// Bauschritt-Szene Reach Stacker.  schritt = Bauschritt, ansicht: 0 Maschine, 1 Container allein,
// 2 40-Fuß-Boden und -Dach mit Clips (Unterseite), detail: 1 = Bolzen im Ausleger-Lager
schritt = 99;
ansicht = 0;
detail = 0;
function X(g, v = 1) = g == schritt ? 1 : 0;
ad  = max(M(1.5), 14);                       // Abhebeweg im Schritt
pd_ = max(M(0.1), 1.4);                      // Pfeildicke
K0  = kopf_welt(0);
module c2(fa, fb) { color(fhex(fa)) render() children(0); color(fhex(fb)) render() children(1); }
module stift_y(x, z, L) color("#e8e2d0") translate([x, 0, z]) rotate([90, 0, 0]) cylinder(d = stift_d, h = L, center = true, $fn = 16);

module maschine(s) {
    c2(farbe_gelb, farbe_rahmen) { fahrgestell_welt("A"); fahrgestell_welt("B"); }
    translate([0, 0, X(1) * ad * 0.6]) color(fhex(farbe_auspuff)) render() fahrgestell_welt("C");
    if (s >= 1) for (i = [0 : 3]) let(sy = i % 2 == 0 ? 1 : -1, x = i < 2 ? x_f : x_r)
        rein([0, sy * ad, 0], X(1), [x, sy * (M(breite_m / 2) + 2), z_ax], pd_) {
            color(fhex(farbe_reifen)) render() rad_welt(i, "A"); translate([0, sy * X(1) * ad * 0.6, 0]) color(fhex(farbe_felge)) render() rad_welt(i, "B"); }
    if (s >= 2) for (sy = [-1, 1]) {
        rein([0, sy * ad, 0], X(2), [x_p0, sy * (y_kf + 2), Z_pl], pd_) color(fhex(farbe_gelb)) render() kotfluegel_welt(sy);
        rein([0, 0, ad], X(2), [X_g + L_g / 2, sy * Y_g, Z_dk + H_g], pd_) color(fhex(farbe_gelaender)) gelaender_welt(sy);
    }
    if (s >= 3) rein([0, 0, ad], X(3), [(K_X[0] + K_X[1]) / 2, 0, K_Z[1]], pd_) {
        translate([0, 0, X(3) * ad * 0.8]) color(fhex(farbe_kabine)) render() kabine_welt("A"); color(fhex(farbe_glas)) render() kabine_welt("B"); }
    if (s >= 4) translate([0, 0, X(4) * ad]) {
        ausleger_rahmen() color(fhex(farbe_ausleger)) render() aussen_lokal();
        if (s >= 5) ausleger_rahmen() translate([u_ir + X(5) * ad * 1.5, 0, 0]) c2(farbe_ausleger, farbe_kopf) { innen_lokal("A"); innen_lokal("B"); }
    }
    if (s >= 4) stift_y(P_x, P_z, L_stift[0]);
    if (s == 4) pfeil([P_x, 0, P_z + ad * 1.6], [P_x, 0, P_z + ad * 0.3], pd_);
    if (s == 5) let(p = rot_aw([u1 + L_ex + ad * 1.5, wb_o + H_o / 2])) pfeil([p[0], 0, p[1]], [p[0] - ad * 1.2 * cos(a_w), 0, p[1] - ad * 1.2 * sin(a_w)], pd_);
    if (s >= 6) for (sy = [-1, 1]) rein([0, sy * ad, 0], X(6), [Q0[0], sy * (yc + 2), Q0[1]], pd_)
        { color(fhex(farbe_zylinder)) render() zylinder_welt(sy, "A"); color(fhex(farbe_stange)) render() zylinder_welt(sy, "B"); }
    if (s >= 6) { stift_y(Q0[0], Q0[1], L_stift[1]); stift_y(Q1[0], Q1[1], L_stift[2]); }
    if (s >= 7) rein([0, 0, -ad], X(7), [K0[0], 0, K0[1] - d_n - h_bh], pd_) {
        translate([K0[0], 0, K0[1]]) color(fhex(farbe_haenger)) render() haenger();
        stift_y(K0[0], K0[1], L_stift[3]);
    }
    if (s >= 8) translate([K0[0], 0, K0[1] - d_n - h_bh - h_sd - X(8) * ad]) {
        c2(farbe_spreader, farbe_streifen) { spreader_rahmen("A"); spreader_rahmen("B"); }
        for (r = [0, 180]) rotate([0, 0, r]) translate([0, -X(8) * ad, 0]) color(fhex(farbe_arm)) render() spreader_arm();
        if (s == 8) { pfeil([0, 0, -ad * 0.2], [0, 0, ad * 0.8], pd_); for (r = [0, 180]) rotate([0, 0, r]) pfeil([0, -L_f / 2 - ad * 1.6, ARM[3]], [0, -L_f / 2 - ad * 0.6, ARM[3]], pd_); }
    }
    if (s >= 11) translate([K0[0], 0, K0[1] - d_n - h_bh - h_sd + ARM[3] - eb_h - H_ct - X(11) * ad])
        rotate([0, 0, 90]) translate([-L_c20 / 2, -W_ct / 2, 0]) container_c(99);
    if (s == 11) pfeil([K0[0] + W_ct / 2 + 3, 0, K0[1] - d_n - h_bh - h_sd - eb_h - ad], [K0[0] + W_ct / 2 + 3, 0, K0[1] - d_n - h_bh - h_sd - eb_h - 2], pd_);
}
// Container-Bausatz (lokal), Schritte 9/10
// Steck-Container: Schritt 9 Boden + Rahmen mit Wänden (Wand von innen in den Rahmen), 10 Seitenwände + Dach
module container_c(s, Lc = L_c20) {
    color(fhex(farbe_beschlag)) render() ct_boden(Lc);
    for (t = [false, true]) rein([0, 0, ad], X(9), [t ? Lc + 2 : -2, W_ct / 2, H_ct + 2], pd_) {
        translate([(t ? 1 : -1) * X(9) * ad * 0.9, 0, 0]) color(fhex(farbe_beschlag)) render() ct_rahmen(Lc, t);
        color(fhex(farbe_container)) render() ct_wand_steck(Lc, t);
    }
    if (s >= 10) {
        rein([0, 0, ad], X(10), [Lc / 2, -2, H_ct + 2], pd_) color(fhex(farbe_container)) render() ct_seite(Lc);
        rein([0, 0, ad], X(10), [Lc / 2, W_ct + 2, H_ct + 2], pd_) translate([Lc, W_ct, 0]) rotate([0, 0, 180]) color(fhex(farbe_container)) render() ct_seite(Lc);
        rein([0, 0, ad * 2], X(10), [Lc / 2, W_ct / 2, H_ct + ad + 2], pd_) color(fhex(farbe_container)) render() ct_dach_steck(Lc);
    }
}
if (ansicht == 1) container_c(schritt);
else if (ansicht == 2) {   // 40 Fuß: Boden und Dach in Druckorientierung, Clips eingedrückt
    for (nm = ["boden", "dach"]) translate([0, nm == "boden" ? 0 : W_ct + 20, 0]) {
        color(fhex(nm == "boden" ? farbe_beschlag : farbe_container)) render()
            if (nm == "boden") translate([0, W_ct, z_f]) rotate([180, 0, 0]) ct_druck(L_c40, nm, "alle", 0);   // Unterseite mit Clip-Taschen oben
            else ct_druck(L_c40, nm, "alle", 0);
    }
}
else if (detail == 1) {
    translate([-P_x, 0, -P_z]) { color(fhex(farbe_gelb)) render() fahrgestell_welt("A"); ausleger_rahmen() color(fhex(farbe_ausleger)) render() aussen_lokal(); }
    translate([0, L_stift[0] / 2 + ad, 0]) rotate([90, 0, 0]) color("#e8e2d0") cylinder(d = stift_d, h = L_stift[0], $fn = 16);
    pfeil([0, L_stift[0] + ad * 1.2, 0], [0, L_stift[0] / 2 + ad * 0.4 + L_stift[0] / 2, 0], pd_);
}
else maschine(schritt);
