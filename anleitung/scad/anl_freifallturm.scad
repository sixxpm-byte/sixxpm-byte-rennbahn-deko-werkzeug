include <../../modelle/freifallturm/freifallturm.scad>
include <anl_common.scad>
schritt = 99;
detail = 0;           // 1 = Podest-Unterseite mit Clips, 2 = Stift im Kragen des Sitzrings
function X(g, v = 1) = g == schritt ? v : 0;
ad = max(sc(1500), 14);                      // Abhebehöhe im Schritt
pd_ = max(sc(100), 1.4);                     // Pfeildicke
module ab(p, h, l = ad * 0.8) pfeil([p[0], p[1], p[2] + h + l + 2], [p[0], p[1], p[2] + h + 2], pd_);

// ---- Baugruppen mit Farben (render(): sonst färbt die Vorschau Inlays falsch) ----
module podest_c() { color(fhex(farbe_podest)) render() podest_welt("A"); color(fhex(farbe_linie)) render() podest_welt("B"); }
module mast_c(i, up = 0) { color(fhex(farbe_gurt)) render() mast_welt(i, "A", up); color(fhex(farbe_gitter)) render() mast_welt(i, "B", up); }
// Im eigenen Schritt schweben die gesteckten Farbteile (Sitzkranz, Dach, Wimpel) etwas über ihrem Sitz
module gondel_c() { color(fhex(farbe_ring)) render() gondel("A"); translate([0, 0, X(4, ad * 0.35)]) { color(fhex(farbe_sitz)) render() gondel("B"); color(fhex(farbe_buegel)) render() gondel("C"); } }
module kopf_c(up = 0) { color(fhex(farbe_kopf)) render() kopf_welt("A", up); color(fhex(farbe_licht)) render() kopf_welt("B", up); color(fhex(farbe_kopf_dach)) render() kopf_welt("C", up + X(5, ad * 0.25)); }
module portal_c(up = 0) { color(fhex(farbe_portal)) render() portal_welt("A", up); color(fhex(farbe_schrift)) render() portal_welt("B", up); color(fhex(farbe_birnen)) render() portal_welt("C", up); }
module stift_c() color("#e8e2d0") translate([0, 0, z_pin]) rotate([0, 90, 0]) cylinder(d = stift_d, h = bo + 2 * t_k + 4, center = true, $fn = 16);
u_ka = max(sc(250), 2);
module kasse_c(s) translate([X_KA, Y_KA, H_p]) {
    color(fhex(farbe_kasse)) translate([0, 0, X(8, ad)]) kasse();
    if (s >= 9) color(fhex(farbe_kasse_dach)) translate([-B_ka / 2 - u_ka, -T_ka / 2 - u_ka, H_ka + X(9, ad)]) kasse_dach();
}
zg_a = z_g0 + 0.75 * (z_g1 - z_g0);           // Sitzring-Höhe in den Bildern

// Clip-Lagen [x, y, Drehung] wie in split_out (lokal 0..P)
function clip_lagen(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7])
    concat([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)], y = clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp, S, SY)) [xs[k], y, 0]],
           [for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)], x = clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp, S, SX)) [x, ys[k], 90]]);
if (detail == 1) {   // Podest-Unterseite: Nähte mit eingedrückten Clips
    CLG = clip_lagen(INFO_P);
    rotate([180, 0, 0]) translate([-P / 2, -P / 2, 0]) {
        color(fhex(farbe_podest)) render() difference() {
            podest_lokal("A");
            for (x = INFO_P[2]) translate([x - gap, -1, -1]) cube([2 * gap, P + 2, H_p + 2]);
            for (y = INFO_P[3]) translate([-1, y - gap, -1]) cube([P + 2, 2 * gap, H_p + 2]);
            for (c = CLG) translate([c[0], c[1], 0]) clip_cut(c[2]);
        }
        color(fhex(farbe_clips)) for (c = CLG) translate([c[0], c[1], 0]) rotate(c[2]) clip();
    }
}
else if (detail == 2) {   // Kragen mit Stift
    color(fhex(farbe_ring)) render() gondel("A");
    stift_c();
    pfeil([bo / 2 + t_k + ad, 0, z_pin], [bo / 2 + t_k + 3, 0, z_pin], pd_);
}
else {
    if (schritt >= 1) podest_c();
    if (schritt >= 2) color(fhex(farbe_treppe)) translate([0, -X(2, ad), 0]) treppe_welt();
    if (schritt == 2) pfeil([0, -P / 2 - 2 * d_st - ad * 1.6, H_p / 2], [0, -P / 2 - 2 * d_st - 2, H_p / 2], pd_);
    if (schritt >= 3) for (i = [0 : n_sek - 1]) mast_c(i, X(3, ad * (1 + i)));
    if (schritt == 3) ab([w * 0.9, 0, H_p], 0, ad * 0.6);
    if (schritt >= 4) translate([0, 0, (schritt == 4 ? H_p + L_m + ad : zg_a)]) { gondel_c(); stift_c(); }
    if (schritt == 4) pfeil([R_r + 2, 0, H_p + L_m + ad], [R_r + 2, 0, zg_a + ad], pd_ * 1.4);
    if (schritt >= 5) kopf_c(X(5, ad));
    if (schritt == 5) ab([0, 0, H_p + L_m], h_kh + h_kd + h_fm);
    if (schritt >= 6) for (k = ZAUN_K) color(fhex(farbe_zaun)) render() zaun_welt(k, X(6, ad));
    if (schritt == 6) for (k = [0, 2, 4]) let(p = pol(R_z, zaun_rot(k))) ab([p[0], p[1], H_p], H_z);
    if (schritt >= 7) portal_c(X(7, ad));
    if (schritt == 7) for (sg = [-1, 1]) ab([sg * (B_po / 2 - b_pf / 2), Y_PO, H_p], H_po);
    if (schritt >= 8) kasse_c(schritt);
    if (schritt == 8) ab([X_KA, Y_KA, H_p], H_ka);
    if (schritt == 9) ab([X_KA, Y_KA, H_p], H_ka + sc(700, 6));
}
