include <../../modelle/umschlagbagger/umschlagbagger.scad>
include <anl_common.scad>
// Bauschritt-Szene Umschlagbagger.  schritt = Bauschritt; detail 1 = Kabinen-Hubwerk, 2 = Greifer
schritt = 99;
detail = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(1.6), 12);
pd_ = max(M(0.12), 1.4);
t0 = 45; p0 = -75; st0 = 2; th0 = STUFEN[st0];
module f(c) color(fhex(c)) render(convexity = 8) children();
function WA(q) = F_p + rot2(q, t0);                       // aus dem Ausleger-Rahmen
function WS(q) = WA(T_p + rot2(q, p0));                   // aus dem Stiel-Rahmen
module bolz(P, L, on, y = 0) if (on) color("#e8e2d0") translate([P[0], y + L / 2 + ad * 0.9, P[1]]) rotate([90, 0, 0]) cylinder(d = stift_d, h = L, $fn = 16);
module zyl2(P, Q, yc, Z, pa, pb) { f(farbe_zylinder) zyl_zw(P, Q, yc, "A", Z, pa, pb); f(farbe_stange) zyl_zw(P, Q, yc, "B", Z, pa, pb); }
module ausl(dy = 0) for (s = [-1, 1]) translate([0, s * dy, 0]) f(farbe_gelb) haelfte_lokal(0, s);
module stl(dy = 0) for (s = [-1, 1]) translate([0, s * dy, 0]) f(farbe_gelb) haelfte_lokal(1, s);
module maschine(s) {
    // 1: Fahrgestell, Pratzen, Achsen, Räder
    f(farbe_fahrgestell) fahrgestell_welt();
    for (sx = [-1, 1], q = [-1, 1]) rein([0, 0, -ad * 0.8], X(1), [sx * X_st, q * Y_st, Z_u0], pd_) f(farbe_fahrgestell) stuetze_welt(sx, q);
    for (sx = [-1, 1]) f(farbe_fahrgestell) achse_welt(sx * X_ax);
    for (i = [0 : 3]) let(sy = i % 2 == 0 ? 1 : -1, x = (i < 2 ? 1 : -1) * X_ax) {
        rein([0, sy * ad, 0], X(1), [x, sy * (y_ri + B_zw), z_ax], pd_) f(farbe_reifen) rad_welt(i, "A");
        rein([0, sy * ad * 1.7, 0], X(1), [x, sy * (y_ri + B_zw), z_ax], pd_) f(farbe_felge) rad_welt(i, "B");
    }
    // 2: Oberwagen, Handläufe
    if (s >= 2) translate([0, 0, X(2) * ad]) {
        f(farbe_gelb) oberwagen_welt();
        for (i = [0, 1]) translate([0, 0, X(2) * ad * 0.7]) f(farbe_anbau) handlauf_welt(i);
    }
    if (X(2)) pfeil([X_h * 0.6, 0, Z_mh + ad * 2.4], [X_h * 0.6, 0, Z_mh + ad * 1.3], pd_);
    // 3: Hubarme, 4: Träger und Kabine
    if (s >= 3) {
        for (k = [0, 1], sy = [-1, 1]) translate([0, sy * X(3) * ad * 0.6, 0]) f(farbe_hubwerk) hubarm_welt(k, th0, sy);
        bolz(A1, BOLZ[7][1], X(3), y_c); bolz(A2, BOLZ[7][1], X(3), y_c); bolz(LK(st0), BOLZ[8][1], X(3), y_c);
    }
    if (s >= 4) translate([0, 0, X(4) * ad * 0.8]) in_traeger(th0) {
        f(farbe_hubwerk) traeger_lokal();
        translate([0, 0, X(4) * ad * 0.8]) { f(farbe_kabine) kabine_lokal("A"); translate([0, 0, -X(4) * ad * 0.4]) f(farbe_glas) kabine_lokal("B"); }
    }
    if (s >= 4) { bolz(C1(th0), BOLZ[9][1], X(4), y_c); bolz(C1(th0) + OFF, BOLZ[9][1], X(4), y_c); }
    // 7: Ausleger und Hubzylinder
    if (s >= 7) {
        translate([X(7) * ad, 0, X(7) * ad * 0.6]) in_ausleger(t0) ausl();
        for (sy = [-1, 1]) translate([0, sy * X(7) * ad * 1.2, 0]) zyl2(CF_p, WA(A_p), y_b + sy * Y_hz, ZH, true, true);
        bolz(F_p, BOLZ[0][1], X(7), y_b); bolz(CF_p, BOLZ[1][1], X(7), y_b); bolz(WA(A_p) + [X(7) * ad, X(7) * ad * 0.6], BOLZ[2][1], X(7), y_b);
    }
    // 8: Stiel und Stielzylinder
    if (s >= 8) in_ausleger(t0) {
        translate([X(8) * ad, 0, 0]) in_stiel(p0) stl();
        translate([0, 0, X(8) * ad * 0.7]) zyl2(S1_p, T_p + rot2(R_p, p0), 0, ZS, false, false);
    }
    if (s >= 8) { bolz(WA(S1_p), BOLZ[3][1], X(8), y_b); bolz(WA(T_p), BOLZ[4][1], X(8), y_b); bolz(WS(R_p), BOLZ[5][1], X(8), y_b); }
    // 9: Greifer
    if (s >= 9) {
        translate([0, 0, -X(9) * ad]) in_greifer(t0, p0, 0) greifer_lokal(0);
        bolz(WS(G_p) + [0, -X(9) * ad], BOLZ[6][1], X(9), y_b);
    }
}
if (detail == 1) {
    // Kabinen-Hubwerk: Turm mit Rastlöchern, Hubarme, Rastbolzen (Schnitt neben der Kabine)
    intersection() {
        union() {
            f(farbe_gelb) oberwagen_welt();
            for (k = [0, 1], sy = [-1, 1]) f(farbe_hubwerk) hubarm_welt(k, th0, sy);
            in_traeger(th0) f(farbe_hubwerk) traeger_lokal();
            bolz(LK(st0), BOLZ[8][1], 1, y_c);
        }
        translate([BX[0] - 1, y_c - w_t / 2 - 2 * t_gs - 1, Z_o1 - 1]) cube([L_a + K(1.2), K(3), K(2.6)]);
    }
}
else if (detail == 2) {
    // Greifer: Kopf, Schalen auseinandergezogen
    greifer_lokal(ad * 0.8);
}
else if (schritt == 5) {
    // Hälften von Ausleger und Stiel mit Dübeln (liegend)
    rotate([-90, 0, 0]) { ausl(ad * 0.7); for (i = [0, 1]) f("holz") duebel_lokal(0, i);
        translate([K(1.0), 0, -K(2.6)]) { stl(ad * 0.7); for (i = [0, 1]) f("holz") duebel_lokal(1, i); } }
}
else if (schritt == 6) {
    // Zylinder: Kolbenstange ins Rohr schieben
    Zs = [ZH, ZH, ZS];
    for (i = [0 : 2]) translate([0, i * (2 * r_e + 6), 0]) { f(farbe_zylinder) zyl_rohr(Zs[i], false); translate([ad * 1.5, 0, hz - hs]) f(farbe_stange) zyl_stange(Zs[i], Zs[i][0], false); }
    pfeil([ZH[0] + ad * 1.6, -r_e - 4, hz], [ZH[0] + ad * 0.5, -r_e - 4, hz], pd_);
}
else maschine(schritt);
