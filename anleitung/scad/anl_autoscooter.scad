include <../../modelle/autoscooter/autoscooter.scad>
include <anl_common.scad>
schritt = 99;
detail = 0;           // 1 = Podest-Unterseite mit Clips, 2 = Stromstange in den Wagen, 3 = Dach-Unterseite mit Clips
function X(g, v = 1) = g == schritt ? v : 0;
ad = max(sc(1500), 14);
la = ad * 0.8;
pd_ = max(sc(80), 1.2);
module ab(p, h) pfeil([p[0], p[1], p[2] + h + la + 2], [p[0], p[1], p[2] + h + 2], pd_);

// Lage der Clips an den Nähten eines geteilten Teils: [x, y, Drehung]
function clip_pos(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7]) concat(
    [for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) for (y = clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp, S, SY, SEP(info))) [xs[k], y, 0]],
    [for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) for (x = clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp, S, SX, SEP(info))) [x, ys[k], 90]]);

module podest_c() { color(fhex(farbe_podest)) podest_welt("A"); color(fhex(farbe_umgang)) podest_welt("B"); }
module bande_c(b) { color(fhex(farbe_bande_1)) bande_welt(b, "A"); color(fhex(farbe_bande_2)) bande_welt(b, "B"); }
module saeule_c(c) translate([c[0], c[1], H_p - h_pg]) { color(fhex(farbe_saeule)) saeule("A"); color(fhex(farbe_licht)) saeule("B"); }
module dach_l() { color(fhex(farbe_dach)) dach_lokal("A"); color(fhex(farbe_dachrand)) dach_lokal("B"); color(fhex(farbe_licht)) dach_lokal("C"); }
module front_c() { color(fhex(farbe_front_A)) prunkfront_welt("A"); color(fhex(farbe_front_B)) prunkfront_welt("B");
                   color(fhex(farbe_front_C)) prunkfront_welt("C"); color(fhex(farbe_front_D)) prunkfront_welt("D"); }
module haube_c() { color(fhex(farbe_automat)) greifer_haube("A"); color(fhex(farbe_glas), 0.55) greifer_haube("B"); color(fhex(farbe_saeule)) greifer_haube("C"); }
module greifer_c(ex = 0) {
    color(fhex(farbe_automat)) greifer_unten("A"); color(fhex(farbe_automat_2)) greifer_unten("B"); color(fhex(farbe_preise)) greifer_unten("C");
    translate([0, g_y0, g_h1 + ex]) haube_c();
}
module boxer_c() { color(fhex(farbe_boxer)) boxer("A"); color(fhex(farbe_licht)) boxer("B"); color(fhex(farbe_automat_2)) boxer("C"); }
module kasse_c(ex1 = 0, ex2 = 0, dach = true) {
    color(fhex(farbe_kasse_boden)) kasse_boden();
    for (k = ["vorne", "hinten", "links", "rechts"]) translate([0, 0, ex1]) {
        color(fhex(farbe_kasse_wand)) wand_welt(k, "A"); color(fhex(farbe_kasse_rahmen)) wand_welt(k, "B"); color(fhex(farbe_kasse_dekor)) wand_welt(k, "C");
    }
    if (dach) translate([0, 0, ex2]) { color(fhex(farbe_kasse_dach)) kasse_dach(); color(fhex(farbe_schild_A)) schild_welt("A"); color(fhex(farbe_schild_B)) schild_welt("B"); }
}
// render(): sonst färbt die OpenCSG-Vorschau Inlays falsch (wie im Modell)
module wohnwagen_c() { color(fhex(farbe_wohnwagen)) render() wohnwagen("A"); color(fhex(farbe_fenster)) render() wohnwagen("B");
                       color(fhex(farbe_zierstreifen)) render() wohnwagen("C"); color(fhex(farbe_fahrgestell)) render() wohnwagen("D"); }
module packwagen_c() { color(fhex(farbe_packwagen)) render() packwagen("A"); color(fhex(farbe_fenster)) render() packwagen("B");
                       color(fhex(farbe_zierstreifen)) render() packwagen("C"); color(fhex(farbe_fahrgestell)) render() packwagen("D"); }
x_pw = L_ww + L_db - sc(150, 1.5) - x_cpl / 2;   // Lage des Packwagens im Gespann

module haupt(s) {
    podest_c();
    if (s >= 2) for (i = [0, 1]) translate([0, -X(2, ad), 0]) color(fhex(farbe_umgang)) treppe_welt(i);
    if (s == 2) for (i = [0, 1]) pfeil([GX[i], -st_d / 2 - ad * 0.9, H_p], [GX[i], -st_d / 2 - ad * 0.25, H_p], pd_);
    if (s >= 3) for (b = BANDEN) translate([0, 0, X(3, ad)]) bande_c(b);
    if (s == 3) for (r = BSLOTS) ab([(r[0] + r[2]) / 2, (r[1] + r[3]) / 2, H_p + h_bd], ad);
    if (s >= 4) for (c = SAEULEN) translate([0, 0, X(4, ad)]) saeule_c(c);
    if (s == 4) for (c = SAEULEN) ab([c[0], c[1], z_rb + h_pgt], ad);
    if (s >= 5) for (i = [0 : wagen_anzahl - 1]) wagen_welt(i, X(5, ad * 0.5));
    if (s == 5) for (i = [0 : 2 : wagen_anzahl - 1]) let(p = wagen_pos(i)) ab([p[0], p[1], H_p + h_tw], ad * 0.5);
    if (s >= 9) {
        translate([KX, KY, H_p + X(9, ad)]) kasse_c();
        translate([GRX, GRY, H_p + X(9, ad)]) greifer_c();
        translate([BXX, BXY, H_p + X(9, ad)]) boxer_c();
    }
    if (s == 9) for (p = [[KX + W_k / 2, KY + D_k / 2, z_rk + t_rk + h_rf], [GRX + g_w / 2, GRY + g_d / 2, g_h1 + g_h2 + g_h3], [BXX + b_w2 / 2, BXY + b_d / 2, b_h1 + b_h2]])
        ab([p[0], p[1], H_p + p[2]], ad);
    if (s >= 11) translate([0, 0, X(11, ad)]) translate([-ov_r, -ov_r, z_rb]) dach_l();
    if (s == 11) for (x = [W * 0.25, W * 0.75]) ab([x, D / 2, z_rb + t_d + h_rr], ad);
    if (s >= 12) translate([0, 0, X(12, ad)]) front_c();
    if (s == 12) for (x = PEGS_PF) ab([x - ov_r, 0, z_rb + t_d + h_cr], ad);
}

if (detail == 1) {          // Podest umgedreht, Clips über den Taschen
    CP = clip_pos(info_podest());
    rotate([180, 0, 0]) { podest_c(); for (c = CP) translate([c[0], c[1], -ad * 0.5 - ch]) rotate(c[2]) color(fhex(farbe_clips)) clip(); }
    for (c = CP) pfeil([c[0], -c[1], ad * 0.5 - 0.5], [c[0], -c[1], 1], pd_);
} else if (detail == 3) {   // Dach umgedreht, Clips über den Taschen
    CP = clip_pos(info_dach());
    rotate([180, 0, 0]) { dach_l(); for (c = CP) translate([c[0], c[1], -ad * 0.5 - ch]) rotate(c[2]) color(fhex(farbe_clips)) clip(); }
    for (c = CP) pfeil([c[0], -c[1], ad * 0.5 - 0.5], [c[0], -c[1], 1], pd_);
} else if (detail == 2) {   // Stromstange in den Halter
    color(fhex(WF[0])) wagen("A"); color(fhex(farbe_gummi)) wagen("B"); color(fhex(farbe_sitz)) wagen("C");
    color("#e8e2d0") translate([-L_c * 0.36, 0, h_tw - d_ph + ad * 0.6]) cylinder(d = stift_d, h = L_stange * 0.5, $fn = 12);
    pfeil([-L_c * 0.36 + d_tw, 0, h_tw + ad * 0.6], [-L_c * 0.36 + d_tw, 0, h_tw + 1], pd_);
} else if (schritt == 6 || schritt == 7) {
    kasse_c(X(6, ad), X(7, ad), schritt == 7);
    if (schritt == 6) for (p = [[W_k / 2, 0], [W_k / 2, D_k], [0, D_k / 2], [W_k, D_k / 2]]) ab([p[0], p[1], t_fk + H_k], ad);
    if (schritt == 7) ab([W_k / 2, D_k / 2, z_rk + t_rk + h_rf], ad);
} else if (schritt == 8) {
    greifer_c(ad * 0.6);
    ab([g_w / 2, g_y0 + g_dh / 2, g_h1 + g_h2 + g_h3], ad * 0.6);
} else if (schritt == 10) {  // Dach umgedreht verclipsen
    CP = clip_pos(info_dach());
    rotate([180, 0, 0]) { dach_l(); for (c = CP) translate([c[0], c[1], -ad * 0.5 - ch]) rotate(c[2]) color(fhex(farbe_clips)) clip(); }
    for (c = CP) pfeil([c[0], -c[1], ad * 0.5 - 0.5], [c[0], -c[1], 1], pd_);
} else if (schritt == 13) {
    wohnwagen_c();
    color(fhex(farbe_fahrgestell)) translate([L_ww + ad, B_ww / 2, z_db]) deichsel();
    pfeil([L_ww + L_db + ad * 0.9, B_ww / 2, z_db + t_db + 2], [L_ww + L_db + 2, B_ww / 2, z_db + t_db + 2], pd_);
} else if (schritt == 14) {
    translate([0, 0, ad]) { wohnwagen_c(); color(fhex(farbe_fahrgestell)) translate([L_ww, B_ww / 2, z_db]) deichsel(); }
    translate([x_pw, B_ww / 2 - B_lk / 2, 0]) packwagen_c();
    ab([L_ww + L_db - sc(150, 1.5), B_ww / 2, z_db], ad);
} else haupt(schritt);
