// =====================================================================
//  deko_hydraulik.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Teleskopische Hydraulikzylinder (Rohr + Kolbenstange), liegend stützfrei gedruckt,
//  und Bolzen-Maße.  Erwartet im Modell: stift_d, zylinder_spiel, einsatz_spiel und
//  (nach deko_grundlagen) M().  Optional vorab: zyl_r_s_m, zyl_r_o_m (Vorbild-Radien in m),
//  zyl_r_s_min (kleinster Stangenradius, mm) und zyl_wand_min (kleinste Rohrwand, mm).
//  Ein Zylinder wird durch Z = [L_min, L_max] (Augenabstand eingefahren/ausgefahren)
//  beschrieben; ov(Z) ist die Überdeckung der Stange im Rohr bei L_max (>= ov_min halten).
// =====================================================================
r_h   = (stift_d + 0.25) / 2;               // Bolzenloch lose
r_pr  = stift_d / 2 + einsatz_spiel;        // Bolzenloch stramm
r_e   = max(M(0.17), r_h + 1.0);            // Augenradius
r_s   = max(M(is_undef(zyl_r_s_m) ? 0.065 : zyl_r_s_m), is_undef(zyl_r_s_min) ? 1.2 : zyl_r_s_min);   // Kolbenstange
hs    = 0.62 * r_s;                         // Stange: oben und unten abgeflacht
r_b   = r_s + zylinder_spiel;
r_o   = max(M(is_undef(zyl_r_o_m) ? 0.14 : zyl_r_o_m), r_b + (is_undef(zyl_wand_min) ? 1.0 : zyl_wand_min));   // Rohr
hz    = 0.9 * r_o;                          // Rohrachse über dem Bett
x_b0  = r_e + max(M(0.05), 0.8);            // Boden der Bohrung
g_tz  = max(M(0.06), 0.8);
ov_min = max(5 * r_s, M(0.3));
function ov(Z) = (Z[0] - r_e - g_tz) - (x_b0 + Z[1] - Z[0]);
module rohr_2d() intersection() { hull() { translate([0, hz]) circle(r = r_o, $fn = 40); translate([-0.56 * r_o, 0]) square([1.12 * r_o, 0.01]); } translate([-r_o - 1, 0]) square([2 * r_o + 2, 2 * r_o + 2]); }
module stange_2d(o) intersection() { translate([0, hs]) circle(r = r_s + o, $fn = 32); translate([-r_s - o - 1, -o]) square([2 * (r_s + o) + 2, 2 * hs + 2 * o]); }
// lokal = Druck: Achse x ab dem Rohr-Auge, Augen flach auf dem Bett (Auge des Rohrs 2*hz dick, der Stange 2*hs)
module zyl_rohr(Z, press) let(L_tb = Z[0] - r_e - g_tz) difference() {
    union() {
        cylinder(r = r_e, h = 2 * hz, $fn = 32);
        translate([r_e - 0.4, 0, 0]) rotate([90, 0, 90]) linear_extrude(L_tb - r_e + 0.4) rohr_2d();
    }
    translate([0, 0, -1]) cylinder(r = press ? r_pr : r_h, h = 2 * hz + 2, $fn = 24);
    // Bohrung: Stangenprofil mit Luft, Decke als 45°-Giebel (stützfrei)
    translate([x_b0, 0, hz - hs]) rotate([90, 0, 90]) linear_extrude(L_tb) let(o = zylinder_spiel, wt = sqrt(pow(r_s + o, 2) - pow(hs + o, 2)))
        hull() { stange_2d(o); translate([-0.01, 2 * hs + o + wt * 1.1]) square(0.02); }
}
module zyl_stange(Z, L, press) difference() {
    union() {
        translate([L, 0, 0]) cylinder(r = r_e, h = 2 * hs, $fn = 32);
        translate([x_b0 + L - Z[0], 0, 0]) rotate([90, 0, 90]) linear_extrude(Z[0] - x_b0 - r_e + 0.4) stange_2d(0);
    }
    translate([L, 0, -1]) cylinder(r = press ? r_pr : r_h, h = 2 * hs + 2, $fn = 24);
}
module zylinder_druck(fp, Z, pa, pb) {
    if (inc(fp, "A")) zyl_rohr(Z, pa);
    if (inc(fp, "B")) translate([0, 2 * r_e + 3, 0]) zyl_stange(Z, Z[0], pb);
}
// zwischen zwei Punkten einer x-z-Schwenkebene (P = Rohr-Auge, Q = Stangen-Auge), Mitte bei y = yc
module zyl_zw(P, Q, yc, fp, Z, pa, pb) let(L = norm(Q - P), d = (Q - P) / L) {
    if (inc(fp, "A")) multmatrix([[d[0], d[1], 0, P[0]], [0, 0, 1, yc - hz], [d[1], -d[0], 0, P[1]], [0, 0, 0, 1]]) zyl_rohr(Z, pa);
    if (inc(fp, "B")) multmatrix([[d[0], d[1], 0, P[0]], [0, 0, 1, yc - hs], [d[1], -d[0], 0, P[1]], [0, 0, 0, 1]]) zyl_stange(Z, L, pb);
}
