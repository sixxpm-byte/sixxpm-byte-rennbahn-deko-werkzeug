include <../../modelle/radlader/radlader.scad>
include <anl_common.scad>
// Bauschritt-Szene Radlader.  schritt = Bauschritt; detail 1 = Z-Kinematik
schritt = 99;
detail = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(1.4), 10);
pd_ = max(M(0.12), 1.4);
t0 = t_min + 0.3 * (t_max - t_min); b0 = 10; g0 = b0 - t0;
module f(c) color(fhex(c)) render(convexity = 8) children();
function WA(q) = A_p + rot2(q, t0);                       // aus dem Arm-Rahmen in die Welt
module bolz(P, L, on, dy = 0) if (on) color("#e8e2d0") translate([P[0], L / 2 + ad * 1.6 + dy, P[1]]) rotate([90, 0, 0]) cylinder(d = stift_d, h = L, $fn = 16);
module zyl2(P, Q, yc, Z) { f(farbe_zylinder) zyl_zw(P, Q, yc, "A", Z, false, false); f(farbe_stange) zyl_zw(P, Q, yc, "B", Z, false, false); }
module rad2(x, sy, d) { f(farbe_reifen) rad_welt(x, sy, "A", d); f(farbe_felge) rad_welt(x, sy, "B", d * 0.45); }
module hinten_s(s) {
    // 1: Hinterwagen, Aufbau, Grill, Achse, Räder
    f(farbe_rahmen) hinterwagen_welt();
    f(farbe_achse) achse_welt(-X_va);
    for (sy = [-1, 1]) rad2(-X_va, sy, X(1) * ad * 1.3);
    rein([0, 0, ad], X(1), [-K(3), 0, Z_hd], pd_) f(farbe_gelb) aufbau_welt();
    translate([-X(1) * ad * 0.9, 0, X(1) * ad]) f(farbe_grill) grill_welt();
    // 2: Kabine, Handläufe, Leitern, Spiegel, Scheinwerfer
    if (s >= 2) {
        rein([0, 0, ad * 1.1], X(2), [-K(1), 0, K_Z[1]], pd_) { f(farbe_kabine) kabine_welt("A"); translate([0, 0, -X(2) * ad * 0.5]) f(farbe_glas) kabine_welt("B"); }
        for (i = [0, 1]) translate([0, 0, X(2) * ad * 0.6]) f(farbe_anbau) handlauf_welt(i);
        for (sy = [-1, 1]) translate([0, 0, -X(2) * ad * 0.7]) f(farbe_anbau) leiter_welt(sy);
        for (i = [0, 1]) translate([0, 0, X(2) * ad * 1.6]) f(farbe_anbau) spiegel_welt(i);
        for (i = [2, 3]) translate([0, 0, X(2) * ad * 1.6]) f(farbe_leuchte) leuchte_welt(i);
    }
}
module vorne_s(s) {
    // 3: Vorderwagen, Achse, Räder, Kotflügel, Scheinwerfer
    f(farbe_rahmen) vorderwagen_welt();
    f(farbe_achse) achse_welt(X_va);
    for (sy = [-1, 1]) rad2(X_va, sy, X(3) * ad * 1.3);
    for (sy = [-1, 1]) translate([0, sy * X(3) * ad * 1.1, 0]) f(farbe_gelb) kotfluegel_welt(sy);
    for (i = [0, 1]) translate([0, (i == 0 ? 1 : -1) * X(3) * ad * 1.1, X(3) * ad * 0.6]) f(farbe_leuchte) leuchte_welt(i);
    // 5: Hubarme und Hubzylinder
    if (s >= 5) {
        for (sy = [-1, 1]) translate([0, sy * X(5) * ad * 1.5, 0]) in_arm(t0) f(farbe_gelb) hubarm_lokal(sy);
        for (sy = [-1, 1]) translate([0, sy * X(5) * ad * 0.7, 0]) zyl2(F_p, P_w(t0), y_hz(sy), ZH);
        bolz(A_p, BOLZ[0][1], X(5), ad); bolz(F_p, BOLZ[1][1], X(5)); bolz(P_w(t0), BOLZ[3][1], X(5), ad);
    }
    // 6: Kipphebel, Distanzrohre, Koppel
    if (s >= 6) { in_arm(t0) gestaenge(g0, X(6) * ad * 0.5); bolz(WA(Lp_p), BOLZ[4][1], X(6)); bolz(WA(Lb_a(g0)), BOLZ[6][1], X(6)); }
    // 7: Schaufel und Kippzylinder
    if (s >= 7) {
        translate([X(7) * ad * 1.2, 0, 0]) in_arm(t0) in_schaufel(g0) f(farbe_schaufel) schaufel_lokal();
        translate([0, 0, X(7) * ad * 0.8]) zyl2(KF_p, Lt_w(t0, b0), y_zk, ZK);
        bolz(WA(B_a) + [X(7) * ad * 1.2, 0], BOLZ[8][1], X(7)); bolz(WA(Q_a(g0)), BOLZ[7][1], X(7)); bolz(KF_p, BOLZ[2][1], X(7)); bolz(Lt_w(t0, b0), BOLZ[5][1], X(7));
    }
}
module maschine(s) {
    if (s <= 2 || s >= 8) hinten_s(s);
    if (s >= 3) translate([X(8) * ad * 1.6, 0, 0]) vorne_s(s);
    if (s >= 8) { translate([X(8) * ad * 1.6, 0, Z_b - X(8) * ad * 2.2]) f(farbe_achse) knickbolzen();
                  if (X(8)) { pfeil([ad * 1.6, 0, Z_b - ad * 0.9], [ad * 1.6, 0, Z_b - ad * 0.1], pd_); pfeil([ad * 1.4, 0, Z_bk + ad * 0.5], [ad * 0.2, 0, Z_bk + ad * 0.5], pd_); } }
}
if (detail == 1) {
    // Z-Kinematik: Kipphebel mit Distanzrohren, Koppel, Kippzylinder und Schaufel (auseinandergezogen)
    for (sy = [-1, 1]) translate([0, sy * ad * 1.2, 0]) in_arm(t0) f(farbe_gelb) hubarm_lokal(sy);
    in_arm(t0) gestaenge(g0, ad * 0.45);
    in_arm(t0) in_schaufel(g0) f(farbe_schaufel) schaufel_lokal();
    zyl2(KF_p, Lt_w(t0, b0), y_zk, ZK);
}
else if (schritt == 4) {
    // Zylinder: Kolbenstange ins Rohr schieben
    Zs = [ZH, ZH, ZK];
    for (i = [0 : 2]) translate([0, i * (2 * r_e + 6), 0]) { f(farbe_zylinder) zyl_rohr(Zs[i], false); translate([ad * 1.5, 0, hz - hs]) f(farbe_stange) zyl_stange(Zs[i], Zs[i][0], false); }
    pfeil([ZH[0] + ad * 1.6, -r_e - 4, hz], [ZH[0] + ad * 0.5, -r_e - 4, hz], pd_);
}
else maschine(schritt);
