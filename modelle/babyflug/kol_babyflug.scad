// Kollisionsszene Babyflug: Baugruppen in Weltkoordinaten (obj, d0 = Armwinkel, ii = Arm-Nummer)
include <babyflug.scad>
obj = ""; d0 = 0; ii = 0;
module ob() rotate(drehung) children();
module am(k, th) ob() rotate(k * aa) translate([r_piv, 0, z_piv]) rotate([0, -th, 0]) children();
if (obj == "podest") podest_welt("alle");
if (obj == "boden") boden_welt();
if (obj == "saeule") translate([0, 0, z_fl]) saeule();
if (obj == "kopf_unten") ob() kopf_unten();
if (obj == "kopf_oben") ob() kopf_oben();
if (obj == "arm") am(ii, d0) rotate([90, 0, 0]) translate([0, 0, -w_arm / 2]) arm();
if (obj == "jet") am(ii, d0) translate([L_arm, 0, y_m]) rotate([0, th_n, 0]) rotate([0, 0, 90]) jet("alle");
if (obj == "krone") ob() translate([0, 0, z_kb]) krone("alle");
if (obj == "dach") ob() translate([0, 0, z_db]) dach("alle");
if (obj == "ufo") translate([0, 0, z_ur]) { ufo_unten("alle"); ufo_oben("alle"); }
if (obj == "masten") for (j = [0 : N_d - 1]) rotate(vtx(j)) translate([r_g / tc, 0, H_w - h_pg]) mast("alle");
if (obj == "gelaender") for (k = GK) side_frame(k, r_g) translate([0, 0, H_w]) rotate([90, 0, 90]) translate([0, 0, -t_g / 2]) gelaender();
if (obj == "leuchtmast") leuchtmast_welt();
if (obj == "kasse") rotate(A_KASSE) translate([R_t + sc(400, 3) + D_k + m_k, -W_k / 2, 0]) rotate(90) kassenwagen();
// Steck-Farbteile einzeln (lokal): d0 = Baugruppe, ii = Farbteil
FPS = ["A", "B", "C", "D"];
if (obj == "fp" && d0 == 0) jet(FPS[ii]);
if (obj == "fp" && d0 == 1) ufo_oben(FPS[ii]);
if (obj == "fp" && d0 == 2) mast(FPS[ii]);
