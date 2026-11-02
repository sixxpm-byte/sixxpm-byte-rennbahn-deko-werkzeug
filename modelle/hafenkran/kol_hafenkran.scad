// Kollisionsszene Hafenkran: Baugruppen in Weltkoordinaten (obj, ii = Wippstufe 1..n)
include <hafenkran.scad>
obj = ""; d0 = 0; ii = 1;
th_i = wippwinkel[max(1, min(len(wippwinkel), ii)) - 1];
module ow() translate([0, 0, rail_top + z_os]) rotate([0, 0, drehung]) children();
if (obj == "schiene") for (sy = [-1, 1]) for (i = [0 : SCHN - 1]) translate([-SCHL / 2 + i * SCHS, sy * Gy / 2, 0]) schiene_seg(SCHS);
if (obj == "fahrwerk") translate([0, 0, rail_top]) for (sx = [-1, 1], sy = [-1, 1]) translate([sx * Rx / 2, sy * Gy / 2, 0]) fahrwerk();
if (obj == "seite") translate([0, 0, rail_top]) for (sy = [-1, 1]) seite_welt(sy);
if (obj == "quer") translate([0, 0, rail_top]) for (sx = [-1, 1]) quer_welt(sx);
if (obj == "plattform") translate([0, 0, rail_top]) plattform_welt();
if (obj == "zapfen") translate([0, 0, rail_top + z_os - l_pin + tbs * 0.7]) zapfen();
if (obj == "drehbuehne") ow() drehbuehne();
if (obj == "turm") ow() for (sy = [-1, 1]) turm_welt(sy);
if (obj == "traverse") ow() traverse_welt();
if (obj == "ausleger") ow() translate([x_p, 0, z_p]) rotate([0, -th_i, 0]) ausleger_lokal();
if (obj == "zahnstange") ow() let(J = Jp(th_i), ph = atan2(J[1] - K[1], J[0] - K[0]))
    for (sy = [-1, 1]) translate([J[0], sy * y_r + tr / 2, J[1]]) rotate([90, 0, 0]) rotate([0, 0, ph + 180]) linear_extrude(tr) wippstange_2d();
