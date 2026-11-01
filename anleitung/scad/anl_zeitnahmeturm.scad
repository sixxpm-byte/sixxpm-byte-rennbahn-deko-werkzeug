include <../../modelle/zeitnahmeturm/zeitnahmeturm.scad>
include <anl_common.scad>
schritt = 99;
detail = 0;           // 1 = Treppenlauf mit Zapfen vor der Wand
function X(g, v = 1) = g == schritt ? v : 0;
ad = max(M(1.2), 10);
la = ad * 0.8;
pd_ = max(M(0.08), 1.2);
module ab(p, h) pfeil([p[0], p[1], p[2] + h + la + 2], [p[0], p[1], p[2] + h + 2], pd_);
function h3(s) = concat(hv(s), [0]);
module rein_h(s, p, d) pfeil(p + h3(s) * (d + la), p + h3(s) * (d * 0.15), pd_);   // Pfeil zur Wand hin

module platte_c() { color(fhex(farbe_platz)) bodenplatte("A"); color(fhex(farbe_sockel)) bodenplatte("B"); }
module lauf_c(i) { color(fhex(farbe_treppe)) lauf_welt(i, "A"); color(fhex(farbe_gelaender)) lauf_welt(i, "B"); }
module podest_c(i) { color(fhex(farbe_treppe)) podest_welt(i, "A"); color(fhex(farbe_gelaender)) podest_welt(i, "B"); }
module dach_nur() { color(fhex(farbe_dach)) dach("A"); color(fhex(farbe_dachrand)) dach("B"); }
module schild_c() { color(fhex(farbe_schild)) schild_welt("A"); color(fhex(farbe_schrift)) schild_welt("B"); color(fhex(farbe_karo)) schild_welt("C"); }
module fahne_c() { color(fhex(farbe_mast)) fahne_welt("A"); color(fhex(farbe_fahne_1)) fahne_welt("B"); color(fhex(farbe_fahne_2)) fahne_welt("C"); }
function fmid(i) = let(f = FL[i], c = (f[1] + f[2]) / 2, p = wpt(f[0], c, g_f + sw / 2)) [p[0], p[1], (f[3] + f[4]) / 2 + f_r(f)];
function pmid(i) = let(r = PD[i][0]) [(r[0] + r[2]) / 2, (r[1] + r[3]) / 2, PD[i][1]];

if (detail == 1) {
    wand_c(0, "hinten");
    translate(h3("hinten") * ad * 0.7) lauf_c(1);
    let(f = FL[1]) for (q = f_pins(f)) let(c = f_c(f, q * f_run(f)), p = wpt("hinten", c, g_f + lp + ad * 0.7 + 1))
        pfeil([p[0], p[1] + la * 0.5, f_pz(f, q * f_run(f))], [p[0], D + g_f + 1, f_pz(f, q * f_run(f))], pd_ * 0.7);
} else {
    if (schritt >= 1) platte_c();
    if (schritt >= 2) translate([0, 0, X(2, ad)]) for (s = SIDES) wand_c(0, s);
    if (schritt == 2) for (p = [[W / 2, 0], [0, D / 2], [W, D / 2], [W / 2, D]]) ab([p[0], p[1], z_d1], ad);
    if (schritt >= 3) translate([0, 0, X(3, ad)]) decke1_c();
    if (schritt == 3) for (x = [W * 0.25, W * 0.75]) ab([x, D / 2, z1], ad);
    if (schritt >= 4) translate([0, 0, X(4, ad)]) for (s = SIDES) wand_c(1, s);
    if (schritt == 4) for (p = [[W / 2, 0], [0, D / 2], [W, D / 2], [W / 2, D]]) ab([p[0], p[1], z_d2], ad);
    if (schritt >= 5) translate([0, 0, X(5, ad)]) decke2_c();
    if (schritt == 5) for (x = [W * 0.25, W * 0.75]) ab([x, D / 2, z2], ad);
    if (schritt >= 6) translate([0, 0, X(6, ad)]) { for (k = [0 : 3]) kanzel_c(k); if (pult) color(fhex(farbe_pult)) pult_welt(); }
    if (schritt == 6) for (p = [[W / 2, -fk], [-fk, D / 2], [W + fk, D / 2], [W / 2, D + fk]]) ab([p[0], p[1], zr], ad);
    if (schritt >= 7) translate([0, 0, X(7, ad)]) dach_nur();
    if (schritt == 7) for (x = [W * 0.25, W * 0.75]) ab([x, D / 2, z_top], ad);
    if (schritt >= 8) translate([0, 0, X(8, ad * 0.7)]) { schild_c(); if (fahne) fahne_c(); }
    if (schritt == 8) { ab([W / 2, sch_y, z_top + sch_h], ad * 0.7); if (fahne) ab([fm_x, fm_y, z_top + fm_h], ad * 0.7); }
    if (schritt >= 9) for (i = [0 : 3]) translate([0, 0, X(9, ad)]) color(fhex(farbe_stuetzen)) stuetze_welt(i);
    if (schritt == 9) for (i = [0 : 3]) ab([PD[i][2][0], PD[i][2][1], PD[i][1] - tl], ad);
    for (i = [0 : 3]) let(n = 10 + i) {
        if (schritt >= n) translate(h3(FL[i][0]) * X(n, ad)) lauf_c(i);
        if (schritt >= n) translate(h3(PD[i][3]) * X(n, ad)) podest_c(i);
        if (schritt == n) { rein_h(FL[i][0], fmid(i) + [0, 0, h_g], ad); rein_h(PD[i][3], pmid(i) + [0, 0, h_g], ad); }
    }
}
