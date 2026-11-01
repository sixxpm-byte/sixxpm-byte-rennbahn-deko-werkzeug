include <../../modelle/turntables/turntables.scad>
include <anl_common.scad>
schritt = 99;
nur_haus = 0;
function X(g, v = 1) = g == schritt ? v : 0;
module teller(ex) achse_rahmen() rotate([0, 0, drehung]) translate([0, 0, ex]) {
    color(fhex(farbe_vinyl)) scheibe("A", [0, R_s + 5, 0, 360, 0]);
    color(fhex(farbe_label_1)) scheibe("B", [0, R_s + 5, 0, 360, 0]);
    color(fhex(farbe_label_2)) scheibe("C", [0, R_s + 5, 0, 360, 0]);
    color(fhex(farbe_chrom)) scheibe("D", [0, R_s + 5, 0, 360, 0]);
}
module kreuze(ex, gond, exg) achse_rahmen() rotate([0, 0, drehung]) for (k = [0 : 3]) translate(concat(pol(r_x, XA[k]), [t_s + h_sh])) rotate([0, 0, kreuz_drehung + k * 17]) {
    if (!gond) translate([0, 0, ex]) { color(fhex(farbe_vinyl)) kreuz("A"); color(fhex(farbe_gold)) kreuz("B"); if (ex > 0) pfeil([0, 0, ex + 2], [0, 0, 4], 2); }
    if (gond) for (j = [0 : 3]) translate([arm_r * cos(j * 90), arm_r * sin(j * 90), t_x + h_ed + 0.05 + exg]) rotate([0, 0, gondel_drehung + j * 90 + 55]) {
        color(fhex(GF[(k + j) % 4])) gondel("A"); color(fhex(farbe_chrom)) gondel("B");
    }
    if (gond && exg > 0) for (j = [0 : 3]) translate([arm_r * cos(j * 90), arm_r * sin(j * 90), t_x]) pfeil([0, 0, exg + g_hh * 0.4], [0, 0, g_hh * 0.6 + 2], 1.6);
}
module wand(k) {
    color(fhex(farbe_vinyl)) rueckwand_welt(k, "A"); color(fhex(farbe_eq_1)) rueckwand_welt(k, "B");
    color(fhex(farbe_eq_2)) rueckwand_welt(k, "C"); color(fhex(farbe_eq_3)) rueckwand_welt(k, "D"); color(fhex(farbe_wandrahmen)) rueckwand_welt(k, "E");
}
module haus(s0) {   // Schritte s0 .. s0+3
    if (schritt >= s0) color(fhex(farbe_haus_boden)) haus_boden();
    if (schritt >= s0 + 1) translate([0, 0, X(s0 + 1, 25)]) for (k = ["vorne", "hinten", "links", "rechts"]) { color(fhex(farbe_haus_wand)) wand_welt(k, "A"); color(fhex(farbe_haus_kanten)) wand_welt(k, "B"); }
    if (schritt >= s0 + 2) translate([0, 0, X(s0 + 2, 30)]) { color(fhex(farbe_haus_dach)) haus_dach("A"); color(fhex(farbe_haus_kanten)) haus_dach("B"); }
    if (schritt >= s0 + 3) translate([0, 0, X(s0 + 3, 20)]) { color(fhex(farbe_schild_A)) schild_welt("A"); color(fhex(farbe_schild_B)) schild_welt("B"); }
    if (schritt >= s0 + 1 && schritt <= s0 + 3) translate([W_h / 2, D_h / 2, H_h + 34]) pfeil([0, 0, 22], [0, 0, 4], 2.4);
}
if (nur_haus == 1) haus(11);
else {
    if (schritt >= 1) color(fhex(farbe_boden)) bodenkreuz_welt();
    if (schritt >= 2) {
        color(fhex(farbe_blende)) blenden_welt("A"); color(fhex(farbe_licht)) blenden_welt("B");
        translate([0, 0, X(2, 45)]) color(fhex(farbe_deck)) deck_welt();
        if (schritt == 2) for (a = [0, 120, 240]) translate(concat(pol((R_w + R_di) / 2, a), [0])) pfeil([0, 0, H_p + 40], [0, 0, H_p + 6], 3);
    }
    if (schritt >= 3) for (k = STK) rotate(sidec(k)) translate([X(3, 30), 0, 0]) {
        color(fhex(farbe_blende)) stufe_lokal("A"); color(fhex(farbe_licht)) stufe_lokal("B");
        if (schritt == 3) pfeil([R_di + 3 * d_st + 30, 0, H_p * 0.6], [R_di + 3 * d_st + 6, 0, H_p * 0.6], 2.4);
    }
    if (schritt >= 4) {
        teller(X(4, 45));
        if (schritt == 4) achse_rahmen() pfeil([R_s * 0.45, 0, 70], [R_s * 0.45, 0, 20], 3);
    }
    if (schritt >= 5) kreuze(X(5, 25), false, 0);
    if (schritt >= 6) kreuze(0, true, X(6, 22));
    if (schritt >= 7) achse_rahmen() turm_welt(X(7, 7));
    if (schritt >= 8) for (k = WK) translate(X(8, 30) * concat(pol(1, sidec(k)), [0])) {
        wand(k); color(fhex(farbe_stahl)) stuetze_welt(k);
        if (schritt == 8) side_frame(k, r_rw + 45) pfeil([0, 0, H_rw * 0.5], [-24, 0, H_rw * 0.5], 2.4);
    }
    if (schritt >= 9) {
        for (k = WK) translate([0, 0, X(9, 20)]) color(fhex(farbe_markise)) markise_welt(k);
        translate(X(9, 40) * concat(pol(1, sidec(K_SCHILD)), [0])) vinylschild_welt();
        if (schritt == 9) side_frame(K_SCHILD, r_rw + 70) pfeil([0, 0, H_p + H_rw], [-30, 0, H_p + H_rw], 3);
    }
    if (schritt >= 10) {
        translate([0, 0, X(10, 30)]) { for (k = MK) lichtmast_welt(k); for (k = ZK) zaun_welt(k); for (k = FK) mischpult_welt(k); color(fhex(farbe_chrom)) tonarm_welt(); }
        if (schritt == 10) for (k = concat(MK, ZK, FK, [TK])) side_frame(k, (k == TK ? r_ta : R_di)) pfeil([0, 0, H_p + 55], [0, 0, H_p + 30], 2);
    }
    if (schritt >= 11) translate([HX, HY, 0]) haus(11);
}
