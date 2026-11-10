include <../../modelle/kettenbagger/kettenbagger.scad>
include <anl_common.scad>
// Bauschritt-Szene Kettenbagger.  schritt = Bauschritt; detail 1 = Löffelgestänge
schritt = 99;
detail = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(1.6), 12);
pd_ = max(M(0.12), 1.4);
t0 = 28; p0 = -100; c0 = -25;
module f(c) color(fhex(c)) render(convexity = 8) children();
// Punkte in der Welt-Schwenkebene
function WA(q) = F_p + rot2(q, t0);                       // aus dem Ausleger-Rahmen
function WS(q) = WA(T_p + rot2(q, p0));                   // aus dem Stiel-Rahmen
module bolz(P, L, on) if (on) color("#e8e2d0") translate([P[0], L / 2 + ad * 0.9, P[1]]) rotate([90, 0, 0]) cylinder(d = stift_d, h = L, $fn = 16);
module zyl2(P, Q, yc, Z, pa, pb) { f(farbe_zylinder) zyl_zw(P, Q, yc, "A", Z, pa, pb); f(farbe_stange) zyl_zw(P, Q, yc, "B", Z, pa, pb); }
module ausl(dy = 0) for (s = [-1, 1]) translate([0, s * dy, 0]) f(farbe_gelb) haelfte_lokal(0, s);
module stl(dy = 0) for (s = [-1, 1]) translate([0, s * dy, 0]) f(farbe_gelb) haelfte_lokal(1, s);
module maschine(s) {
    // 1: Laufwerk
    f(farbe_unterwagen) unterwagen_welt();
    for (sy = [-1, 1]) rein([0, sy * ad, 0], X(1), [0, sy * (Y_k0 + B_k), r_k], pd_) f(farbe_kette) kette_welt(sy);
    // 2: Oberwagen, Kabine, Handläufe, Spiegel
    if (s >= 2) translate([0, 0, X(2) * ad]) {
        f(farbe_gelb) oberwagen_welt("A"); f(farbe_band) oberwagen_welt("B");
        translate([0, 0, X(2) * ad * 0.9]) { f(farbe_kabine) kabine_welt("A"); translate([0, 0, -X(2) * ad * 0.45]) f(farbe_glas) kabine_welt("B"); }
        for (i = [0, 1]) translate([0, 0, X(2) * ad * 0.7]) { f(farbe_anbau) handlauf_welt(i); f(farbe_anbau) spiegel_welt(i); }
    }
    if (X(2)) pfeil([X_h * 0.5, 0, Z_mh + ad * 2.4], [X_h * 0.5, 0, Z_mh + ad * 1.3], pd_);
    // 5: Ausleger und Hubzylinder
    if (s >= 5) {
        translate([X(5) * ad, 0, X(5) * ad * 0.6]) in_ausleger(t0) ausl();
        for (sy = [-1, 1]) translate([0, sy * X(5) * ad * 1.2, 0]) zyl2(CF_p, WA(A_p), sy * Y_hz, ZH, true, true);
        bolz(F_p, BOLZ[0][1], X(5)); bolz(CF_p, BOLZ[1][1], X(5)); bolz(WA(A_p) + [X(5) * ad, X(5) * ad * 0.6], BOLZ[2][1], X(5));
    }
    // 6: Stiel und Stielzylinder
    if (s >= 6) in_ausleger(t0) {
        translate([X(6) * ad, 0, 0]) in_stiel(p0) stl();
        translate([0, 0, X(6) * ad * 0.7]) zyl2(S1_p, T_p + rot2(R_p, p0), 0, ZS, false, false);
    }
    if (s >= 6) { bolz(WA(S1_p), BOLZ[3][1], X(6)); bolz(WA(T_p), BOLZ[4][1], X(6)); bolz(WS(R_p), BOLZ[5][1], X(6)); }
    // 7: Löffel, Gestänge, Löffelzylinder
    if (s >= 7) in_ausleger(t0) in_stiel(p0) {
        translate([X(7) * ad, 0, 0]) in_loeffel(c0) f(farbe_loeffel) loeffel_lokal();
        translate([0, 0, X(7) * ad * 0.7]) zyl2(C1_p, J_st(c0), 0, ZL, false, false);
        gestaenge_stiel(c0, X(7) * ad * 0.8);
    }
    if (s >= 7) for (q = [C1_p, B_p, I_p, J_st(c0), Q_st(c0)]) bolz(WS(q), BOLZ[8][1], X(7));
}
if (detail == 1) {
    // Löffelgestänge: Stielspitze, Umlenkhebel, Koppel, Kolbenstange, Löffel (auseinandergezogen)
    rotate([0, 60, 0]) translate([-B_p[0], 0, 0]) intersection() {
        union() { stl(); gestaenge_stiel(c0, ad * 0.5); translate([0, 0, 0]) in_loeffel(c0) f(farbe_loeffel) loeffel_lokal(); zyl2(C1_p, J_st(c0), 0, ZL, false, false); }
        translate([B_p[0] - K(1.6), -500, -500]) cube([K(4), 1000, 1000]);
    }
}
else if (schritt == 3) {
    // Hälften von Ausleger und Stiel mit Dübeln (liegend)
    rotate([-90, 0, 0]) { ausl(ad * 0.7); for (i = [0, 1]) f("holz") duebel_lokal(0, i);
        translate([K(1.2), 0, -K(2.4)]) { stl(ad * 0.7); for (i = [0, 1]) f("holz") duebel_lokal(1, i); } }
}
else if (schritt == 4) {
    // Zylinder: Kolbenstange ins Rohr schieben
    Zs = [ZH, ZH, ZS, ZL];
    for (i = [0 : 3]) translate([0, i * (2 * r_e + 6), 0]) { f(farbe_zylinder) zyl_rohr(Zs[i], false); translate([ad * 1.5, 0, hz - hs]) f(farbe_stange) zyl_stange(Zs[i], Zs[i][0], false); }
    pfeil([ZH[0] + ad * 1.6, -r_e - 4, hz], [ZH[0] + ad * 0.5, -r_e - 4, hz], pd_);
}
else maschine(schritt);
