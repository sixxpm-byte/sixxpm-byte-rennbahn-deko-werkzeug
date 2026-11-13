include <../../modelle/gabelstapler/gabelstapler.scad>
include <anl_common.scad>
// Bauschritt-Szene Gabelstapler.  schritt = Bauschritt (99 = fertig), detail: 1 = Neigezylinder am Mastkopf
schritt = 99;
detail = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(1.2), 12);                       // Abhebeweg im Schritt
pd_ = max(M(0.08), 1.2);                     // Pfeildicke
module b(g) color(fhex(fcol(g))) render(convexity = 8) children();

module stapler_s(s) {
    for (g = ["A", "B", "C"]) b(g) fahrgestell_welt(g);
    if (s >= 1) for (v = [true, false], sy = [-1, 1]) let(x = v ? X_VA : X_HA, R = v ? R_V : R_H, yi = v ? Y_VI : Y_HI)
        rein([0, sy * ad, 0], X(1), [x, sy * (yi + 1), R], pd_) {
            b("B") rad_welt(v, sy, "B");
            translate([0, sy * X(1) * ad * 0.6, 0]) b("A") rad_welt(v, sy, "A");
        }
    if (s >= 2) for (sy = [-1, 1]) rein([0, sy * ad, 0], X(2), [X_VA - R_KI * 0.7, sy * Y_KFA, Z_KT], pd_) { b("A") kf_welt(sy, "A"); b("B") kf_welt(sy, "B"); }
    if (s >= 3) {
        rein([0, 0, ad], X(3), [(X_GMIN + X_GMAX) / 2, 0, Z_GT], pd_) b("D") kern_welt("D");
        translate([0, 0, X(3) * ad * 2]) { b("B") kabine_welt("B"); b("C") rl_welt("C"); }
        rein([0, 0, ad], X(3), [X_AR, Y_AR, Z_AR], pd_) b("B") ar_welt("B");
    }
    if (s >= 4) rein([ad, 0, 0], X(4), [X_M1, 0, Z_M1 * 0.4], pd_) b("B") mast_welt("B");
    if (s >= 5) for (sy = [-1, 1]) rein([0, 0, ad], X(5), [X_PE, sy * Y_MZ, Z_EY + t_ey], pd_) b("B") nz_welt(sy * Y_MZ, "B");
    if (s >= 6) {
        rein([ad, 0, 0], X(6), [X_C1, 0, HC(1) + H_CT * 0.5], pd_) b("B") traeger_welt(HC(1), "B");
        for (sy = [-1, 1]) translate([X(6) * ad * 1.8, 0, X(6) * ad * 0.5]) b("B") gabel_welt(sy, HC(1), "B");
    }
}
if (detail == 1) translate([-X_PE, -Y_MZ, -Z_M1]) {
    b("B") mast_welt("B"); b("B") kabine_welt("B");
    translate([0, 0, ad * 0.6]) b("B") nz_welt(Y_MZ, "B");
    pfeil([X_PE, Y_MZ, Z_EY + t_ey + ad * 1.3], [X_PE, Y_MZ, Z_EY + t_ey + ad * 0.7], pd_);
}
else stapler_s(schritt);
