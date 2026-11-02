// Kollisionsprüfung Autoscooter: jedes Bauteil einzeln in Weltkoordinaten (obj, ii)
include <autoscooter.scad>
obj = ""; d0 = 0; ii = 0;
if (obj == "platte") podest_welt();
if (obj == "treppe") treppe_welt(ii);
if (obj == "bande") bande_welt(BANDEN[ii]);
if (obj == "saeule") translate([SAEULEN[ii][0], SAEULEN[ii][1], H_p - h_pg]) saeule();
if (obj == "dach") dach_welt();
if (obj == "front") prunkfront_welt();
if (obj == "wagen") let(p = wagen_pos(ii)) translate([p[0], p[1], H_p]) rotate(p[2]) wagen();
if (obj == "kboden") translate([KX, KY, H_p]) kasse_boden();
if (obj == "kwand") translate([KX, KY, H_p]) wand_welt(["vorne", "hinten", "links", "rechts"][ii]);
if (obj == "kdach") translate([KX, KY, H_p]) kasse_dach();
if (obj == "kschild") translate([KX, KY, H_p]) schild_welt("alle");
if (obj == "greifer_u") translate([GRX, GRY, H_p]) greifer_unten();
if (obj == "greifer_h") translate([GRX, GRY + g_y0, H_p + g_h1]) greifer_haube();
if (obj == "boxer") translate([BXX, BXY, H_p]) boxer();
if (obj == "wohnwagen") wohnwagen();
if (obj == "deichsel") translate([L_ww, B_ww / 2, z_db]) deichsel();
if (obj == "packwagen") translate([L_ww + L_db - sc(150, 1.5) - x_cpl / 2, B_ww / 2 - B_lk / 2, 0]) packwagen();
