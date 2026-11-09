include <../../modelle/boxenmauer/boxenmauer.scad>
include <anl_common.scad>
// Bauschritt-Szene Boxenmauer.  schritt = Bauschritt; detail 1 = Glasscheibe in der Seitenwand
schritt = 99;
detail = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(1.5), 12);
pd_ = max(M(0.12), 1.4);
module f(c) color(fhex(c)) render(convexity = 6) children();
n_e = 2;
module szene(s) {
    // 1: Mauerelemente mit Clips, Zaun
    for (k = [0 : n_e - 1]) translate([k * L + (X(1) ? k * ad * 0.6 : 0), 0, 0]) {
        f(farbe_mauer) mauer_welt("A"); f(farbe_werbung) mauer_welt("B");
        rein([0, 0, ad * 1.2], X(1), [L / 2, Y_mc, H_w + H_f + l_tb], pd_) f(farbe_zaun) zaunfeld_welt();
    }
    if (X(1)) translate([L + ad * 0.3, Y_mc, -ad * 0.8]) { f(farbe_mauer) clip(); pfeil([0, 0, -ad * 0.2], [0, 0, ad * 0.5], pd_); }
    // 2: Podest mit Clips an die Mauer, Treppe
    if (s >= 2) translate([0, -X(2) * ad, 0]) {
        f(farbe_podest) podest_welt();
        rein([0, -ad * 0.8, 0], X(2), [(X_st[0] + X_st[1]) / 2, Y_s0, H_p], pd_) f(farbe_podest) treppe_welt();
    }
    if (X(2)) for (x = CLX) translate([x, Y_s1 - ad * 0.5, -ad * 0.6]) rotate(90) f(farbe_mauer) clip();
    if (X(2)) pfeil([L / 2, Y_s0 - ad * 0.6, H_p / 2], [L / 2, Y_s0 - ad * 0.1, H_p / 2], pd_);
    // 3: Pult, Monitore, Hocker
    if (s >= 3) {
        rein([0, 0, ad], X(3), [L / 2, y_pf, H_p + h_pu], pd_) f(farbe_pult) pult_welt();
        rein([0, 0, ad * 1.8], X(3), [L / 2, y_mo, H_p + h_pu + h_ms + h_mo], pd_) { f(farbe_pult) monitore_welt("A"); f(farbe_bildschirm) monitore_welt("B"); }
        rein([0, 0, ad], X(3), [L / 2, y_hk, H_p + h_hs], pd_) f(farbe_hocker) hocker_welt();
    }
    // 4: Seitenwände, Geländer
    if (s >= 4) {
        for (i = [0, 1]) rein([0, 0, ad], X(4), [i == 0 ? t_sw / 2 : L - t_sw / 2, y_wc, H_bb + l_rt], pd_) {
            f(farbe_seitenwand) seitenwand_welt(i, "A"); f(farbe_glas) seitenwand_welt(i, "B"); }
        rein([0, 0, ad], X(4), [L / 3, Y_s0, H_p + H_g], pd_) f(farbe_rahmen) gelaender_welt();
    }
    // 5: Dach, Banner
    if (s >= 5) rein([0, 0, ad * 1.2], X(5), [L / 2, (Y_s0 + Y_r1) / 2, H_r + t_ro], pd_) {
        f(farbe_dach) dach_welt();
        translate([0, 0, X(5) * ad * 0.8]) { f(farbe_banner) banner_welt("A"); f(farbe_schrift) banner_welt("B"); } }
}
if (detail == 1) {
    // Seitenwand flach mit herausgezogener Glasscheibe (von der Bettseite eingedrückt)
    rotate([90, 0, 0]) { f(farbe_seitenwand) seitenwand_lokal("A"); translate([0, 0, -ad * 0.8]) f(farbe_glas) seitenwand_lokal("B");
        let(f_ = wf()) pfeil([(f_[0] + f_[1]) / 2, (f_[2] + f_[3]) / 2, -ad * 0.7], [(f_[0] + f_[1]) / 2, (f_[2] + f_[3]) / 2, -ad * 0.15], pd_); }
}
else szene(schritt);
