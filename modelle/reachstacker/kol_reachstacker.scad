include <reachstacker.scad>
// Kollisionsszene: Baugruppen in Weltkoordinaten (Aufbau-Stellung, 20-Fuß-Container am Spreader)
obj = ""; d0 = 0; ii = 0;
K = kopf_welt(auszug);
module am_spreader() translate([K[0], 0, K[1] - d_n - h_bh - h_sd]) rotate([0, 0, spreader_drehung]) children();
module am_container() am_spreader() translate([0, 0, ARM[3] - eb_h - H_ct]) rotate([0, 0, 90]) translate([-L_c20 / 2, -W_ct / 2, 0]) children();
if (obj == "fahrgestell") fahrgestell_welt("alle");
if (obj == "kabine") kabine_welt("alle");
if (obj == "rad") rad_welt(ii, "alle");
if (obj == "kotfluegel") kotfluegel_welt(ii == 0 ? 1 : -1);
if (obj == "gelaender") gelaender_welt(ii == 0 ? 1 : -1);
if (obj == "aussen") ausleger_rahmen() aussen_lokal();
if (obj == "innen") ausleger_rahmen() translate([u_ir + auszug * HUB, 0, 0]) innen_lokal("alle");
if (obj == "zylinder") zylinder_welt(ii == 0 ? 1 : -1, "alle");
if (obj == "haenger") translate([K[0], 0, K[1]]) haenger();
if (obj == "rahmen") am_spreader() spreader_rahmen("alle");
if (obj == "arm") am_spreader() rotate([0, 0, ii * 180]) translate([0, -spreader_auszug * E40, 0]) spreader_arm();
if (obj == "c_boden") am_container() ct_boden(L_c20);
if (obj == "c_dach") am_container() ct_dach(L_c20, "alle");
if (obj == "c_seite") am_container() if (ii == 0) ct_seite(L_c20); else translate([L_c20, W_ct, 0]) rotate([0, 0, 180]) ct_seite(L_c20);
if (obj == "c_stirn") am_container() ct_stirn(L_c20, "alle");
if (obj == "c_tuer") am_container() ct_stirn(L_c20, "alle", true);
