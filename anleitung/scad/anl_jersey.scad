include <../../modelle/jersey_barrier/jersey_barrier.scad>
include <anl_common.scad>
schritt = 99;   // Schritt s zeigt Glieder 0..s-1, das letzte wird angesetzt
N = vorschau_anzahl + 2;
upto = min(N, schritt) - 1;
module kette_s(i) {
    typ = i == 0 ? "anfang" : i == N - 1 ? "ende" : "elem";
    k = VB == "gelenk" ? vorschau_knick : 0;
    ex = (i == upto && i > 0 && schritt <= N) ? 1 : 0;
    translate([ex * 25, 0, 0]) {
        if (typ == "anfang") elem_farbig(-1, false, true, $kurve = false);
        else if (typ == "ende") elem_farbig(1, true, false, $kurve = false);
        else elem_farbig(0);
    }
    if (ex) pfeil([22, 0, H + 6], [4, 0, H + 6], 1.6);
    if (i < upto) {
        P = typ == "elem" ? end_pose(L) : [L, 0, 0];
        exv = (i + 1 == upto && schritt <= N) ? 1 : 0;
        translate([P[0], P[1], 0]) rotate([0, 0, P[2]]) fuge(k) {
            translate([0, 0, -exv * 14]) { verbinder_welt(); if (exv) pfeil([0, 0, -10], [0, 0, -2], 1.2); }
            kette_s(i + 1);
        }
    }
}
kette_s(0);
