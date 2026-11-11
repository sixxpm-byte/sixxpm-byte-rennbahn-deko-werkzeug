include <../../modelle/planierraupe/planierraupe.scad>
include <anl_common.scad>
// Bauschritt-Szene Planierraupe.  schritt = Bauschritt; detail 1 = Zylinder (Rohr + Stange)
schritt = 99;
detail = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(1.6), 12);
pd_ = max(M(0.12), 1.4);
a0 = 0; b0 = 10;                                           // Stellung Schild / Ripper
module f(c) color(fhex(c)) render(convexity = 8) children();
module bolz(P, L, on, dy = 0) if (on) color("#e8e2d0") translate([P[0], dy + L / 2 + ad * 0.9, P[1]]) rotate([90, 0, 0]) cylinder(d = stift_d, h = L, $fn = 16);
module zylh(s, a) { f(farbe_zylinder) zyl_zw(HZ_p, lug_s(a), s * Y_hz, "A", ZH, false, false); f(farbe_stange) zyl_zw(HZ_p, lug_s(a), s * Y_hz, "B", ZH, false, false); }
module zylr(b) { f(farbe_zylinder) zyl_zw(RZ_p, lug_r(b), 0, "A", ZR, false, false); f(farbe_stange) zyl_zw(RZ_p, lug_r(b), 0, "B", ZR, false, false); }
module maschine(s) {
    f(farbe_unterwagen) unterwagen_welt();
    // 1: Schildrahmen liegt, Ketten von außen auf Zungen und Schwenkzapfen
    in_schild(a0) f(farbe_gelb) schildrahmen_welt();
    for (sy = [-1, 1]) rein([0, sy * ad * 1.6, 0], X(1), [0, sy * (Y_k0 + B_k), r_k], pd_) f(farbe_kette) kette_welt(sy);
    // 2: Kotflügel seitlich in die Taschen des Unterwagens
    if (s >= 2) for (sy = [-1, 1]) rein([0, sy * ad * 1.6, 0], X(2), [(X_f[0] + X_f[1]) / 2, sy * Y_f[1], zc_f], pd_) f(farbe_gelb) kotfluegel_welt(sy);
    // 3: Aufbau auf die Zapfen, Glaskern in die Kabine, Kabine auf den Boden
    if (s >= 3) translate([0, 0, X(3) * ad]) {
        f(farbe_gelb) rahmen_welt();
        translate([0, 0, X(3) * ad * 0.9]) { f(farbe_kabine) kabine_welt("A"); translate([0, 0, -X(3) * ad * 0.45]) f(farbe_glas) kabine_welt("B"); }
    }
    if (X(3)) pfeil([K(0.5), 0, Z_hr + ad * 2.3], [K(0.5), 0, Z_hr + ad * 1.2], pd_);
    // 4: Schild auf die Zapfen des Querträgers
    if (s >= 4) in_schild(a0) rein([ad, 0, 0], X(4), [x_b, 0, H_s / 2], pd_) f(farbe_gelb) schild_welt();
    // 5: Hubzylinder: Rohr am Lagerbock, Stange in der Gabel
    if (s >= 5) for (sy = [-1, 1]) {
        translate([0, sy * X(5) * ad * 0.8, X(5) * ad * 0.6]) zylh(sy, a0);
        bolz(HZ_p, BOLZ[0][1], X(5), sy > 0 ? Y_b + t_lg : -(Y_b + t_lg) - ad * 1.8);
        bolz(lug_s(a0) + [0, X(5) * ad * 0.6], BOLZ[1][1], X(5), sy > 0 ? Y_hz + g_fs + t_c : -(Y_hz + g_fs + t_c) - ad * 1.8);
    }
    // 6: Aufreißer in die Schlitze, Bolzen; Ripperzylinder
    if (s >= 6) {
        rein([-ad, 0, 0], X(6), [X_rp[0], 0, Z_rp[1]], pd_) in_ripper(b0) f(farbe_gelb) ripper_welt();
        translate([-X(6) * ad * 0.5, 0, X(6) * ad * 0.8]) zylr(b0);
        bolz(R_p, BOLZ[2][1], X(6), Y_u); bolz(RZ_p, BOLZ[3][1], X(6), Y_rb); bolz(lug_r(b0) + [-X(6) * ad * 0.5, X(6) * ad * 0.8], BOLZ[4][1], X(6), hs + spiel + t_r);
    }
}
if (detail == 1) {
    // Hubzylinder: Rohr und Stange auseinandergezogen, Augen flach
    f(farbe_zylinder) zyl_rohr(ZH, false);
    translate([ZH[0] + ad * 0.4, 0, hz - hs]) f(farbe_stange) zyl_stange(ZH, 0, false);
    pfeil([ZH[0] + ad * 0.3, 0, hz + 2 * r_o], [ZH[0] - r_e, 0, hz + 2 * r_o], pd_ * 0.8);
}
else if (schritt < 99) maschine(schritt);
