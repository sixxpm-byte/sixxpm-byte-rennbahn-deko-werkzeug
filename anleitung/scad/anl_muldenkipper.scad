include <../../modelle/muldenkipper/muldenkipper.scad>
include <anl_common.scad>
// Bauschritt-Szene Muldenkipper.  schritt = Bauschritt, winkel = Kippwinkel der Mulde,
// detail: 1 = Kipplager mit Bolzen
schritt = 99;
winkel = 0;
detail = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(2.0), 14);                       // Abhebeweg im Schritt
pd_ = max(M(0.12), 1.4);                     // Pfeildicke
module f(c) color(fhex(c)) render(convexity = 6) children();
module stift_y(p, L) color("#e8e2d0") translate([p[0], 0, p[1]]) rotate([90, 0, 0]) cylinder(d = stift_d, h = L, center = true, $fn = 16);

module maschine(s) {
    a = s >= 8 ? winkel : 0;
    f(farbe_gelb) rahmen_koerper();
    // 1: Vorbau auf die Längsträger, Grill und Leuchten, Rückleuchten
    rein([ad, 0, 0], X(1), [X_j, 0, Z_db + 2], pd_) {
        f(farbe_gelb) vorbau_koerper();
        translate([X(1) * ad * 0.8, 0, 0]) { f(farbe_grill) grill_welt(); for (sy = [-1, 1]) f(farbe_leuchte) leuchte_welt(sy); }
    }
    for (sy = [-1, 1]) rein([-ad * 0.7, 0, 0], X(1), [X_r0, sy * y_rl, z_rl], pd_) f(farbe_ruecklicht) rueckleuchte_welt(sy);
    // 2: Achszapfen und Räder
    if (s >= 2) for (i = [0 : 3]) let(sy = i % 2 == 0 ? 1 : -1) translate([0, sy * X(2) * ad * 0.4, 0]) f(farbe_gelb) achszapfen_welt(i);
    if (s >= 2) for (i = [0 : 3]) let(sy = i % 2 == 0 ? 1 : -1, x = i < 2 ? X_fa : 0, yi = i < 2 ? y_fi + B_w : y_hi + B_zw)
        rein([0, sy * ad, 0], X(2), [x, sy * (yi + 2), z_ax], pd_) {
            f(farbe_reifen) rad_welt(i, "A"); translate([0, sy * X(2) * ad * 0.6, 0]) f(farbe_felge) rad_welt(i, "B"); }
    // 3: Oberdeck, Kabine
    if (s >= 3) rein([0, 0, ad], X(3), [K(6.5), -K(1.5), Z_dk], pd_) f(farbe_gelb) oberdeck_welt();
    if (s >= 3) rein([0, 0, ad * 1.6], X(3), [(K_X[0] + K_X[1]) / 2, (K_Y[0] + K_Y[1]) / 2, K_Z[1]], pd_) {
        translate([0, 0, X(3) * ad * 0.8]) f(farbe_kabine) kabine_welt("A"); f(farbe_glas) kabine_welt("B"); }
    // 4: Geländer, Spiegel, Auspuff
    if (s >= 4) rein([0, 0, ad], X(4), [X_gv, -K(1.0), Z_dk + H_g], pd_) {
        for (g = GEL) f(farbe_gelaender) gelaender_welt(g);
        for (sy = [-1, 1]) f(farbe_spiegel) spiegel_welt(sy);
        for (i = [0 : 1]) f(farbe_auspuff) auspuff_welt(i);
    }
    // 5: Treppe, Leitern
    if (s >= 5) rein([ad, 0, 0], X(5), [X_st[1], 0, (Z_bu + Z_dk) / 2], pd_) f(farbe_gelb) treppe_welt();
    if (s >= 5) for (sy = [-1, 1]) rein([0, 0, -ad * 0.8], X(5), [X_le, sy * Y_le, Z_le0], pd_) f(farbe_gelaender) leiter_welt(sy);
    // 6: Zylinder unten
    if (s >= 6) for (sy = [-1, 1]) rein([0, sy * ad, 0], X(6), [F_zy[0], sy * (y_e0 + 2), F_zy[1]], pd_) {
        f(farbe_zylinder) zylinder_welt(sy, "A", a); f(farbe_stange) zylinder_welt(sy, "B", a); }
    if (s >= 6) stift_y(F_zy, L_bolz[2]);
    // 7: Muldenträger + Mulde mit Kipplager
    if (s >= 7) translate([0, 0, X(7) * ad * 1.4]) kipp(a) {
        for (sy = [-1, 1]) translate([0, 0, -X(7) * ad * 0.7]) f(farbe_gelb) muldentraeger_welt(sy);
        f(farbe_mulde) mulde_welt();
        // 8: Schutzdach
        if (s >= 8) rein([0, 0, ad], X(8), [(x_fb + X_c1) / 2, 0, Z_c1], pd_) { f(farbe_mulde) schutzdach_welt("A"); f(farbe_dachkante) schutzdach_welt("B"); }
    }
    if (s == 7) pfeil([K(0), 0, Z_c1 + ad * 2.2], [K(0), 0, Z_c1 + ad * 1.0], pd_);
    if (s >= 7) stift_y(P_pv, L_bolz[0]);
    if (s >= 8) stift_y(rotP(B_zy, a), L_bolz[1]);
}
if (detail == 1) {
    // Kipplager: Rahmenende, Muldenträger, Bolzen herausgezogen
    translate([-P_pv[0], 0, -P_pv[1]]) intersection() {
        union() { f(farbe_gelb) rahmen_koerper(); for (sy = [-1, 1]) f(farbe_gelb) muldentraeger_welt(sy); }
        translate([X_r0 - 5, -50, Z_rb]) cube([K(3.5), 100, K(2.6)]);
    }
    translate([0, L_bolz[0] / 2 + ad, 0]) rotate([90, 0, 0]) color("#e8e2d0") cylinder(d = stift_d, h = L_bolz[0], $fn = 16);
    pfeil([0, L_bolz[0] + ad * 1.2, 0], [0, L_bolz[0] + ad * 0.3, 0], pd_);
}
else maschine(schritt);
