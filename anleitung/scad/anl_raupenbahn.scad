include <../../modelle/raupenbahn/raupenbahn.scad>
include <anl_common.scad>
schritt = 99;
nur_haus = 0;
detail = 0;           // 1 = Podest von unten mit Clips, 2 = Gelenk Ausleger/Rotor
ohne_dach = 0;        // 1 = Dach, Säulen, Blenden ausblenden
function X(g, v = 1) = g == schritt ? v : 0;
D0 = 5;               // Rotorstellung in den Bildern
function th(i) = D0 + i * pw;
AR = [0, 5, 10, 15];  // Ausleger/Wagen mit Pfeil

// ---------------------------------------------------------------- Baugruppen
module podest_c() { color(fhex(farbe_podest)) podest_welt("A"); color(fhex(farbe_podest_rand)) linear_extrude(H_p) difference() { poly(R_p); poly(R_p - t_pw); } }
module bahn_c()   { color(fhex(farbe_bahn)) bahn_welt("A"); color(fhex(farbe_schiene)) bahn_welt("B"); }
module weg_c()    { color(fhex(farbe_podest)) weg_welt("A"); color(fhex(farbe_podest_rand)) weg_welt("B"); }
module wagen_c(i, ex_s) car_frame(th(i)) {
    color(fhex(farbe_wagen)) wagen("A"); color(fhex(farbe_wagen_zier)) wagen("B"); color(fhex(farbe_krone)) wagen("C");
    translate([0, 0, ex_s]) color(fhex(farbe_sitz)) sitz();
}
module verdeck_c(i) car_frame(th(i)) let(kopf = raupenkopf && i == 0) {
    color(fhex(farbe_verdeck)) verdeck_welt("A", kopf); color(fhex(farbe_verdeck_ring)) verdeck_welt("B", kopf);
    if (kopf) { color(fhex(farbe_augen)) verdeck_welt("C", true); color(fhex(farbe_pupillen)) verdeck_welt("D", true); }
}
module arkaden_c() { color(fhex(farbe_mittelbau)) mb_waende("A"); color(fhex(farbe_mittelbau_rahmen)) mb_waende("B"); color(fhex(farbe_mittelbau_motiv)) mb_waende("C"); }
module dach_c() { color(fhex(farbe_dach)) dach_welt("A"); color(fhex(farbe_punkte_1)) dach_welt("B"); color(fhex(farbe_punkte_2)) dach_welt("C"); }
module blenden_c() { color(fhex(farbe_blende)) blenden_welt("A"); color(fhex(farbe_blende_rahmen)) blenden_welt("B"); color(fhex(farbe_sonne)) blenden_welt("C"); color(fhex(farbe_licht)) blenden_welt("D"); }
module schild_c() { color(fhex(farbe_schild)) rs_welt("A"); color(fhex(farbe_schrift)) rs_welt("B"); color(fhex(farbe_noten)) rs_welt("C"); color(fhex(farbe_gold)) rs_welt("D"); }
module haus(s0) {   // Schritte s0 .. s0+3
    if (schritt >= s0) color(fhex(farbe_haus_boden)) haus_boden();
    if (schritt >= s0 + 1) translate([0, 0, X(s0 + 1, 25)]) for (k = ["vorne", "hinten", "links", "rechts"]) { color(fhex(farbe_haus_wand)) wand_welt(k, "A"); color(fhex(farbe_haus_kanten)) wand_welt(k, "B"); }
    if (schritt >= s0 + 2) translate([0, 0, X(s0 + 2, 30)]) { color(fhex(farbe_haus_dach)) haus_dach("A"); color(fhex(farbe_haus_kanten)) haus_dach("B"); }
    if (schritt >= s0 + 3) translate([0, 0, X(s0 + 3, 20)]) { color(fhex(farbe_schild_A)) schild_welt("A"); color(fhex(farbe_schild_B)) schild_welt("B"); }
    if (schritt >= s0 + 1 && schritt <= s0 + 3) translate([W_h / 2, D_h / 2, H_h + 34]) pfeil([0, 0, 22], [0, 0, 4], 2.4);
}
function ring_pts(r, n, a0 = 0) = [for (k = [0 : n - 1]) pol(r, a0 + k * 360 / n)];
module drops(r, z, h, n = 4, a0 = 20, d = 3) for (p = ring_pts(r, n, a0)) pfeil([p[0], p[1], z + h], [p[0], p[1], z + 4], d);

// ---------------------------------------------------------------- Details
if (detail == 1) {   // Podest umgedreht, Clips in den Taschen
    rotate([180, 0, 0]) translate([0, 0, -H_p]) {
        podest_c();
        for (c = CL_POD) translate([c[0], c[1], H_p - b_cp - X(1, 12)]) rotate(c[2]) color(fhex(farbe_clips)) translate([0, 0, -0.01]) mirror([0, 0, 0]) clip();
    }
    for (c = [CL_POD[0], CL_POD[1]]) pfeil([c[0], -c[1], b_cp + 22], [c[0], -c[1], b_cp + 4], 2);
} else if (detail == 2) {   // Gelenk: Querachse in der Mulde
    color(fhex(farbe_technik)) translate([0, 0, z_r0]) rotate(D0) rotor();
    for (i = [0 : 3]) color(fhex(farbe_technik)) translate([0, 0, i == 1 ? 14 : 0]) arm_frame(th(i)) ausleger_3d();
    let(p = pol(r_piv, th(1))) pfeil([p[0], p[1], z_piv + 34], [p[0], p[1], z_piv + 17], 2);
    color(fhex(farbe_technik)) translate([0, 0, z_f]) koenigszapfen();
} else if (nur_haus == 1) haus(15);
else {
    if (schritt >= 1) podest_c();
    if (schritt >= 2) translate([0, 0, X(2, 25)]) bahn_c();
    if (schritt == 2) drops(r_jc, z_f, 40, 4, 30);
    if (schritt >= 3) translate([0, 0, X(3, 30)]) weg_c();
    if (schritt == 3) drops((r_ow + R_p) / 2, z_f + 14, 40, 5, 10);
    if (schritt >= 4) {
        translate([0, 0, X(4, 30)]) color(fhex(farbe_technik)) translate([0, 0, z_f]) koenigszapfen();
        translate([0, 0, X(4, 60)]) color(fhex(farbe_technik)) translate([0, 0, z_r0]) rotate(D0) rotor();
        if (schritt == 4) pfeil([0, 0, z_r0 + 110], [0, 0, z_r0 + 70], 3);
    }
    if (schritt >= 5) for (i = [0 : N_w - 1]) translate([0, 0, X(5, 15)]) color(fhex(farbe_technik)) arm_frame(th(i)) ausleger_3d();
    if (schritt == 5) for (i = AR) let(p = pol(r_piv + 20, th(i))) pfeil([p[0], p[1], z_piv + 45], [p[0], p[1], z_piv + 18], 2.2);
    if (schritt >= 6) for (i = [0 : N_w - 1]) translate([0, 0, X(6, 22)]) wagen_c(i, X(6, 16));
    if (schritt == 6) for (i = AR) let(p = pol(r_c, th(i))) pfeil([p[0], p[1], z_piv + 75], [p[0], p[1], z_piv + 45], 2.2);
    if (schritt >= 7) rotate(D0) {
        translate([0, 0, X(7, 25)]) color(fhex(farbe_mittelbau_platte)) mb_boden();
        translate([0, 0, X(7, 55)]) arkaden_c();
    }
    if (schritt == 7) pfeil([0, 0, z_md + 85], [0, 0, z_md + 50], 3);
    if (schritt >= 8) rotate(D0) {
        translate([0, 0, X(8, 25)]) { color(fhex(farbe_mittelbau_platte)) mb_deckel("A"); color(fhex(farbe_licht)) mb_deckel("B"); }
        translate([0, 0, X(8, 50)]) { color(fhex(farbe_kuppel)) kuppel("A"); color(fhex(farbe_gold)) kuppel("B"); }
    }
    if (schritt == 8) pfeil([0, 0, z_k0 + H_k + 80], [0, 0, z_k0 + H_k + 40], 3);
    if (ohne_dach == 0 && schritt >= 9) translate([0, 0, X(9, 50)]) { color(fhex(farbe_saeule_1)) saeulen_welt("A"); color(fhex(farbe_saeule_2)) saeulen_welt("B"); color(fhex(farbe_saeule_3)) saeulen_welt("C"); }
    if (schritt == 9) for (j = [9, 11, 13]) let(p = PO[j]) pfeil([p[0], p[1], z_u + 70], [p[0], p[1], z_u + 52], 2.4);
    if (ohne_dach == 0 && schritt >= 10) translate([0, 0, X(10, 70)]) dach_c();
    if (schritt == 10) drops((R_ri + R_b1) / 2, z_u + H_b + t_bd + 50, 50, 3, 250);
    if (ohne_dach == 0 && schritt >= 11) translate([0, 0, X(11, 40)]) { blenden_c(); color(fhex(farbe_notenschluessel)) ns_welt(); }
    if (schritt == 11) for (k = [11, 12, 13]) let(p = pol(R_f, sidec(k))) pfeil([p[0], p[1], z_u + t_bd + h_f + 70], [p[0], p[1], z_u + t_bd + h_f + 45], 2.4);
    if (ohne_dach == 0 && schritt >= 12) translate([0, 0, X(12, 50)]) schild_c();
    if (schritt == 12) for (p = SGL) pfeil([p[0], p[1], z_sb + 50], [p[0], p[1], z_sb + 20], 2.4);
    if (schritt >= 13) {
        for (k = STK) color(fhex(farbe_treppe)) translate(X(13, 30) * concat(pol(1, sidec(k)), [0])) treppe_welt(k);
        for (k = ZK) translate([0, 0, X(13, 25)]) color(fhex(farbe_zaun)) zaun_welt(k);
        for (p = PFL) translate(concat(p, [0])) { color(fhex(farbe_kuebel)) pflanze("A"); color(fhex(farbe_pflanze)) pflanze("B"); }
    }
    if (schritt == 13) let(p = pol(R_pc + 50, sidec(FRONT))) pfeil([p[0], p[1], 8], [p[0] * 0.92, p[1] * 0.92, 8], 2.4);
    if (schritt >= 14) for (i = [0 : N_w - 1]) translate([0, 0, X(14, 40)]) verdeck_c(i);
    if (schritt == 14) for (i = AR) let(p = pol(r_c, th(i))) pfeil([p[0], p[1], z_piv + 110], [p[0], p[1], z_piv + 75], 2.2);
}
