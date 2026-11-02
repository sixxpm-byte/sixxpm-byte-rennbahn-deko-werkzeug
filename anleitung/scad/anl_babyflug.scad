include <../../modelle/babyflug/babyflug.scad>
include <anl_common.scad>
schritt = 99;
detail = 0;           // 1 = Podest-Unterseite mit Clips, 2 = Arm mit Achsstift
function X(g, v = 1) = g == schritt ? v : 0;
ad = max(sc(1500), 14);
la = ad * 0.8;
pd_ = max(sc(80), 1.2);
module ab(p, h) pfeil([p[0], p[1], p[2] + h + la + 2], [p[0], p[1], p[2] + h + 2], pd_);
module pfeil_blau(p, q, d = 2) {   // Eingang
    v = q - p; L = norm(v);
    color("#1f5fa8") translate(p) {
        b = acos(v[2] / L); c = atan2(v[1], v[0]);
        rotate([0, b, c]) { cylinder(d = d, h = L - 3 * d, $fn = 16); translate([0, 0, L - 3 * d]) cylinder(d1 = 2.6 * d, d2 = 0, h = 3 * d, $fn = 20); }
    }
}

// ---- Baugruppen mit Farben (render(): sonst färbt die Vorschau Inlays falsch) ----
module podest_c() { color(fhex(farbe_podest)) render() podest_welt("A"); color(fhex(farbe_licht)) render() podest_welt("B"); }
module mast_c() { color(fhex(farbe_mast_1)) mast("A"); color(fhex(farbe_mast_2)) mast("B"); color(fhex(farbe_mast_3)) mast("C"); color(fhex(farbe_mastlicht)) mast("D"); }
module stift_c(l) color("#e8e2d0") rotate([90, 0, 0]) cylinder(d = stift_d, h = l, center = true, $fn = 16);
module arm_c(k, th, ex = 0, mit_jet = false, exj = 0) rotate(k * aa) translate([r_piv, 0, z_piv + ex]) rotate([0, -th, 0]) {
    color(fhex(farbe_arm)) rotate([90, 0, 0]) translate([0, 0, -w_arm / 2]) arm();
    stift_c(L_pin);
    if (mit_jet) translate([L_arm, 0, y_m]) rotate([0, th_n, 0]) translate([0, 0, exj]) rotate([0, 0, 90]) {
        color(fhex(GF[k % 4])) render() jet("A"); color(fhex(farbe_chrom)) render() jet("B"); color(fhex(farbe_jet_akzent)) render() jet("C");
    }
}
module ufo_c(ex = 0) {
    color(fhex(farbe_ufo)) render() ufo_unten("A"); color(fhex(farbe_ufo_licht)) render() ufo_unten("B");
    translate([0, 0, ex]) { color(fhex(farbe_ufo)) render() ufo_oben("A"); color(fhex(farbe_ufo_licht)) render() ufo_oben("B"); color(fhex(farbe_kuppel)) ufo_oben("C"); }
}
module kasse_c(s) {   // Kassenwagen lokal, Schritte 14–16
    color(fhex(farbe_kasse_boden)) kasse_boden();
    color(fhex(farbe_kasse_boden)) translate([-X(14, ad), 0, 0]) treppe_welt();
    if (s >= 15) for (k = ["vorne", "hinten", "links", "rechts"]) translate([0, 0, X(15, ad)]) {
        color(fhex(farbe_kasse_wand)) render() wand_welt(k, "A"); color(fhex(farbe_kasse_rahmen)) render() wand_welt(k, "B"); color(fhex(farbe_kasse_dekor)) render() wand_welt(k, "C");
    }
    if (s >= 16) translate([0, 0, X(16, ad)]) {
        color(fhex(farbe_kasse_dach)) kasse_dach();
        color(fhex(farbe_schild_A)) schild_welt("A"); color(fhex(farbe_schild_B)) schild_welt("B");
    }
}
module leuchtmast_c(ex = 0) {
    color(fhex(farbe_kasse_boden)) leuchtmast_fuss();
    translate([0, t_lm / 2, h_lf + ex]) rotate([90, 0, 0]) {
        color(fhex(farbe_leuchtmast)) leuchtmast("A"); color(fhex(farbe_birnen)) leuchtmast("B"); color(fhex(farbe_schrift)) leuchtmast("C");
    }
}

// ---- Hauptaufbau Schritt für Schritt ----
module haupt(s) {
    translate([0, 0, X(2, ad)]) podest_c();
    if (s == 2) for (k = [0, 4, 8, 12]) side_frame(k, (R_i + R_wo) / 2) ab([0, 0, H_w], ad);
    if (s >= 2) color(fhex(farbe_rasen)) boden_welt();
    if (s >= 3) color(fhex(farbe_saeule)) translate([0, 0, z_fl + X(3, ad)]) saeule();
    if (s == 3) ab([0, 0, z_sh + l_ax], ad);
    rotate(drehung) {
        if (s >= 4) color(fhex(farbe_kopf)) translate([0, 0, X(4, ad)]) kopf_unten();
        if (s == 4) ab([0, 0, z_piv], ad);
        if (s >= 5) for (k = [0 : N_a - 1]) arm_c(k, s == 5 ? 0 : arm_winkel, X(5, ad * 0.6), s >= 7, X(7, ad * 0.6));
        if (s == 5) for (k = [0 : 2 : N_a - 1]) rotate(k * aa) ab([r_piv, 0, z_piv + r_boss], ad * 0.6);
        if (s >= 6) color(fhex(farbe_kopf)) translate([0, 0, X(6, ad)]) kopf_oben();
        if (s == 6) ab([0, 0, z_kb + t_kf], ad);
        if (s == 7) for (k = [0 : 2 : N_a - 1]) rotate(k * aa) translate([r_piv, 0, z_piv]) rotate([0, -arm_winkel, 0])
            translate([L_arm, 0, y_m]) ab([0, 0, Hj], ad * 0.6);
        if (s >= 8) translate([0, 0, z_kb + X(8, ad)]) { color(fhex(farbe_krone)) render() krone("A"); color(fhex(farbe_gold)) render() krone("B"); }
        if (s == 8) ab([0, 0, z_kt], ad);
        if (s >= 9) translate([0, 0, z_db + X(9, ad)]) { color(fhex(farbe_dach)) render() dach("A"); color(fhex(farbe_gold)) render() dach("B"); }
        if (s == 9) ab([0, 0, z_da], ad);
        if (s >= 10) translate([0, 0, z_ur + X(10, ad)]) ufo_c(X(10, ad * 0.5));
        if (s == 10) ab([0, 0, z_ur + h_ub + h_uc + r_u * 0.42], ad * 1.5);
    }
    if (s >= 11) for (j = [0 : N_d - 1]) rotate(vtx(j)) translate([r_g / tc, 0, H_w - h_pg + X(11, ad)]) mast_c();
    if (s == 11) for (j = [0 : 2 : N_d - 1]) rotate(vtx(j)) ab([r_g / tc, 0, H_w + h_pole + d_bulb], ad);
    if (s >= 12) for (k = GK) color(fhex(farbe_gelaender)) side_frame(k, r_g) translate([0, 0, H_w + X(12, ad)]) rotate([90, 0, 90]) translate([0, 0, -t_g / 2]) gelaender();
    if (s == 12) for (k = [for (i = [0 : 3 : len(GK) - 1]) GK[i]]) side_frame(k, r_g) ab([0, 0, H_w + h_g], ad);
    if (s == 12) side_frame(eingang_seite, R_t) pfeil_blau([ad * 1.6, 0, H_w + 2], [ad * 0.2, 0, H_w + 2], pd_ * 1.3);
}

if (detail == 1) {          // Podest umgedreht, Clips über den Taschen
    rotate([180, 0, 0]) { podest_c(); for (c = RCLIPS) translate([c[0], c[1], -ad * 0.5 - ch]) rotate(c[2]) color(fhex(farbe_clips)) clip(); }
    for (c = RCLIPS) pfeil([c[0], -c[1], ad * 0.5 - 0.5], [c[0], -c[1], 1], pd_);
} else if (detail == 2) {   // Arm mit Achsstift
    color(fhex(farbe_arm)) rotate([90, 0, 0]) translate([0, 0, -w_arm / 2]) arm();
    translate([0, -ad * 0.5, 0]) stift_c(L_pin);
    pfeil([0, -ad * 0.5 - L_pin / 2 - ad * 0.6, 0], [0, -ad * 0.5 - L_pin / 2 - 1, 0], pd_);
} else if (schritt == 13) { leuchtmast_c(X(13, ad)); ab([0, 0, h_lf + h_lm + sc(600, 6)], ad); }
else if (schritt >= 14 && schritt <= 16) {
    kasse_c(schritt);
    if (schritt == 15) for (p = [[W_k / 2, 0], [W_k / 2, D_k], [0, D_k / 2], [W_k, D_k / 2]]) ab([p[0], p[1], h_fl_k + H_k], ad);
    if (schritt == 16) ab([W_k / 2, D_k / 2, z_rk + t_rk + h_rr], ad);
    if (schritt == 14) pfeil([-m_k - 3 * d_tr - ad * 0.9, D_k / 2, h_fl_k / 2], [-m_k - 3 * d_tr - ad * 0.25, D_k / 2, h_fl_k / 2], pd_);
} else haupt(schritt);
