include <../../modelle/kettenkarussell/kettenkarussell.scad>
include <anl_common.scad>
schritt = 99;
nur_haus = 0;
function X(g, v = 1) = g == schritt ? v : 0;
module haus(s0) {
    if (schritt >= s0) color(fhex(farbe_haus_boden)) haus_boden();
    if (schritt >= s0 + 1) translate([0, 0, X(s0 + 1, 25)]) color(fhex(farbe_haus_wand)) for (k = ["vorne", "hinten", "links", "rechts"]) wand_welt(k);
    if (schritt >= s0 + 2) translate([0, 0, X(s0 + 2, 30)]) color(fhex(farbe_haus_dach)) haus_dach();
    if (schritt >= s0 + 3) translate([0, 0, X(s0 + 3, 20)]) { color(fhex(farbe_schild_A)) schild_welt("A"); color(fhex(farbe_schild_B)) schild_welt("B"); }
    if (schritt >= s0 + 1 && schritt <= s0 + 3) translate([W_h / 2, D_h / 2, H_h + 34]) pfeil([0, 0, 22], [0, 0, 4], 2.4);
}
rot = 10;
TOPZ = z_rb + 40;
if (nur_haus == 1) haus(10);
else {
    if (schritt >= 1) color(fhex(farbe_mastfuss)) mastfuss();
    if (schritt >= 2) {
        color(fhex(farbe_blende)) blende_welt();
        translate([0, 0, X(2, 40)]) color(fhex(farbe_podest)) podest();
        if (schritt == 2) for (a = [30, 150, 270]) translate(concat(pol(R_di * 0.6, a), [0])) pfeil([0, 0, h_p + 95], [0, 0, h_p + 50], 3);
    }
    if (schritt >= 3) for (a = TR_ANG) rotate(a) translate([X(3, 30), 0, 0]) {
        color(fhex(farbe_treppe)) translate([R_di + max(sc(60), 1.5), 0, 0]) treppe();
        if (schritt == 3) pfeil([R_di + 60, 0, h_p], [R_di + 25, 0, h_p], 3);
    }
    if (schritt >= 4) { translate([0, 0, X(4, 60)]) color(fhex(farbe_mast)) mast_voll(); if (schritt == 4) pfeil([0, 0, z_rb + 120], [0, 0, z_rb + 75], 3); }
    rotate([0, 0, rot]) {
        if (schritt >= 5) { translate([0, 0, X(5, 30)]) color(fhex(farbe_stern)) stern_welt(); if (schritt == 5) pfeil([0, 0, z_a + 70], [0, 0, z_a + 35], 3); }
        if (schritt >= 6) for (k = [0 : n_s - 1]) translate([0, 0, X(6, 35)]) color(fhex(alt(k, farbe_dach_1, farbe_dach_2))) dach_welt(k);
        if (schritt == 6) for (k = [0 : 4 : n_s - 1]) rotate(PH[k]) pfeil([R_p * 0.6, 0, z_rb + 75], [R_p * 0.6, 0, z_rb + 40], 2.6);
        if (schritt >= 7) for (k = [0 : n_s - 1]) translate([0, 0, -X(7, 20)]) color(fhex(alt(k, farbe_volant_1, farbe_volant_2))) volant_welt(k);
        if (schritt == 7) for (k = [0 : 4 : n_s - 1]) rotate(PH[k]) pfeil([R_ri - i_v, 0, z_rb - 45], [R_ri - i_v, 0, z_rb - 18], 2.4);
        if (schritt >= 8) { translate([0, 0, X(8, 35)]) { color(fhex(farbe_laterne)) laterne_welt("A"); color(fhex(farbe_wimpel)) laterne_welt("B"); }
                            if (schritt == 8) pfeil([0, 0, z_rb + h_r + 110], [0, 0, z_rb + h_r + 60], 3); }
        if (schritt >= 9) for (k = [0 : n_s - 1]) schaukel(k, 0, X(9, 15));
    }
    if (schritt >= 10) translate([R_dc + 3 * m_h, -R_dc - HBY * 0.2, 0]) haus(10);
}
