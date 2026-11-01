include <../../modelle/tribuene/tribuene.scad>
include <anl_common.scad>
schritt = 99;
detail = 0;      // 1 = Clip-Detail von unten
CC = chain(0);
nE = len(EL);
mid = floor(nE / 2);
DS = 45;
module F(i) translate([CC[i][0], CC[i][1], 0]) rotate(CC[i][2]) children();
function gm(i) = i == mid ? 1 : abs(i - mid) == 1 ? 2 : 3;
function dirv(i) = let(hd = i > mid ? CC[i][2] : CC[i + 1][2]) (i > mid ? 1 : -1) * [cos(hd), sin(hd), 0];
function jp(i) = let(j = i > mid ? i : i + 1) [CC[j][0], CC[j][1], 0];
function jh(i) = i > mid ? CC[i][2] : CC[i + 1][2];
module body_el(i) let(t = EL[i], k = kind_of(t)) {
    color(fhex(farbe_beton)) body(k, typ_of(t), "alle");
    if (typ_of(t) == "T") color(fhex(farbe_stufenkante)) sweep(k) for (q = NOS) translate([q[0], q[1] - t_n + 0.03]) square([w_n, t_n]);
}
module clips_at(i, ex) translate(jp(i)) rotate(jh(i)) for (yr = RBY) translate([0, yr, -ex * 18]) {
    color(fhex(farbe_clips)) translate([0, 0, 0.05]) clip();
    if (ex > 0) pfeil([0, 0, -6], [0, 0, 9], 1.6);
}
module step_bodies() for (i = [0 : nE - 1]) let(g = gm(i)) if (g <= schritt) let(ex = (g == schritt && i != mid) ? 1 : 0) {
    translate(ex * DS * dirv(i)) F(i) body_el(i);
    if (ex > 0) { pfeil(jp(i) + dirv(i) * DS * 0.95 + [0, 0, z_u + 14] + concat(rotp([0, D / 2], jh(i)), [0]), jp(i) + dirv(i) * DS * 0.2 + [0, 0, z_u + 14] + concat(rotp([0, D / 2], jh(i)), [0]), 3);
                  clips_at(i, 1); }
    else if (i != mid) clips_at(i, 0);
}
module seats_el(i) let(t = EL[i], k = kind_of(t)) if (typ_of(t) == "B") F(i) seats_world(k);
module rails_el(i) let(t = EL[i], k = kind_of(t)) F(i) { rails_world(k, t_f / 2, H_f); rails_world(k, D - t_f / 2, z_u); }
module bande_el(i, ex) let(t = EL[i], k = kind_of(t)) if (t == "B" && btxt(i) >= 0) F(i) {
    translate([0, -ex * 30, 0]) bande_world(k[1], WRB[btxt(i)]);
    if (ex > 0) pfeil([k[1] / 2, -27, H_f / 2], [k[1] / 2, -7, H_f / 2], 2.4);
}
module binder_el(i) let(k = kind_of(EL[i])) F(i) color(fhex(farbe_stahl)) binder_world(k);
module facet_el(i) let(t = EL[i], k = kind_of(t)) F(i) multmatrix(facet_M(k)) {
    color(fhex(farbe_dach)) facet_plate(k, "A", t == "B", t != "T"); color(fhex(farbe_dach_text)) facet_plate(k, "B", t == "B", t != "T"); }
module flag_el(i, ex) let(t = EL[i], k = kind_of(t)) if (t != "T") F(i)
    let(M = facet_M(k), B0 = M * [0, Lsl(k) - d_boss, 0, 1], top = [B0[0], B0[1], B0[2]] + [0, 0, (h_boss + t_r) / cos(boss_g(k))]) {
        translate(top + [0, 0, 0.3 + ex * 40]) rotate(fahnen_winkel) rotate([90, 0, 0]) translate([-s_sl / 2, 0, -s_sl / 2]) {
            color(fhex(farbe_fahne_1)) fahne_print("A"); color(fhex(farbe_fahne_2)) fahne_print("B"); }
        if (ex > 0) pfeil(top + [0, 0, 36], top + [0, 0, 8], 2.4);
    }
function mid_c(i) = let(t = EL[i], k = kind_of(t), p = lp(k, k[1] / 2, D / 2)) [p[0], p[1]];
module lift(g, h) let(ex = g == schritt ? 1 : 0) {
    translate([0, 0, ex * h]) children();
}
if (detail == 1) {   // Clip-Stoß: Teile umgedreht
    i = mid + 1;
    rotate([180, 0, 0]) translate(-jp(i)) {
        F(i - 1) body_el(i - 1);
        translate(dirv(i) * 14) F(i) body_el(i);
        clips_at(i, 1);
    }
} else {
    step_bodies();
    if (schritt >= 4) {
        ex = schritt == 4 ? 1 : 0;
        F(0) translate([-ex * 30, 0, 0]) sw_world("links");
        n = nE - 1; k = kind_of(EL[n]);
        F(n) at(k, k[1], 0) translate([ex * 30, 0, 0]) sw_world("rechts");
        if (ex > 0) {
            F(0) pfeil([-34, D / 2, z_u / 2], [-8, D / 2, z_u / 2], 3);
            F(n) at(k, k[1], 0) pfeil([34, D / 2, z_u / 2], [8, D / 2, z_u / 2], 3);
        }
    }
    if (schritt >= 5) for (i = [0 : nE - 1]) {
        lift(5, 30) seats_el(i);
        if (schritt == 5 && typ_of(EL[i]) == "B") let(c = mid_c(i)) F(i) translate([c[0], c[1], 0]) pfeil([0, 0, z_u + 34], [0, 0, z_u + 8], 3);
    }
    if (schritt >= 6) for (i = [0 : nE - 1]) {
        lift(6, 25) rails_el(i);
        bande_el(i, schritt == 6 ? 1 : 0);
    }
    if (schritt >= 7) for (i = [0 : nE - 1]) {
        lift(7, 45) binder_el(i);
        if (schritt == 7) let(k = kind_of(EL[i])) F(i) for (u = binders(k)) at(k, u, y_c) pfeil([0, 0, z_back + 40], [0, 0, z_back + 6], 2.6);
    }
    if (schritt >= 8) for (i = [0 : nE - 1]) {
        lift(8, 45) facet_el(i);
        if (schritt == 8) let(c = mid_c(i)) F(i) translate([c[0], c[1], 0]) pfeil([0, 0, z_front + 60], [0, 0, z_front + 25], 3);
    }
    if (schritt >= 9) for (i = [0 : nE - 1]) flag_el(i, schritt == 9 ? 1 : 0);
}
