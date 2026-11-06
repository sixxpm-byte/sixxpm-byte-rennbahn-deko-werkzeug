include <straddle_carrier.scad>
// Kollisionsszene: Baugruppen in Weltkoordinaten (Aufbau, 20-Fuß-Container am Spreader;
// ii = 1 beim Arm: 40-Fuß-Stellung).  Rendern mit -D teil="none".
obj = ""; d0 = 0; ii = 0;
SX = [1, -1, 1, -1]; SY = [1, 1, -1, -1];
if (obj == "fw_l") fahrwerk_welt(1);
if (obj == "fw_r") fahrwerk_welt(-1);
if (obj == "ob_l") oberrahmen_welt(1);
if (obj == "ob_r") oberrahmen_welt(-1);
if (obj == "rad") rad_welt(SX[ii], SY[ii], "alle");
if (obj == "innenbein") innenbein_welt(SX[ii], SY[ii], "alle");
if (obj == "qt") rotate([0, 0, ii * 180]) quertraeger_welt("alle");
if (obj == "mt") mitteltraeger_welt();
if (obj == "rahmen") spreader_rahmen_welt();
if (obj == "arm") rotate([0, 0, (ii % 2) * 180]) translate([ii >= 2 ? E40 : 0, 0, 0]) spreader_arm_welt();
if (obj == "kopf") rotate([0, 0, (ii % 2) * 180]) translate([ii >= 2 ? E40 : 0, 0, 0]) kopftraeger_welt();
if (obj == "kabine") kabine_welt("alle");
if (obj == "motor") motor_welt();
if (obj == "gitter") motor_gitter_welt();
if (obj == "container") container_welt(L_c20);
if (obj == "container40") container_welt(L_c40);
// Container-Bausatz einzeln (lokal): d0 = 0 → 20 Fuß, 1 → 40 Fuß; ii = Teil
if (obj == "ctp") let(Lc = d0 > 0 ? L_c40 : L_c20) {
    if (ii == 0) ct_boden(Lc);
    if (ii == 1) ct_dach_steck(Lc);
    if (ii == 2) ct_seite(Lc);
    if (ii == 3) translate([Lc, W_ct, 0]) rotate([0, 0, 180]) ct_seite(Lc);
    if (ii == 4) ct_rahmen(Lc, false);
    if (ii == 5) ct_rahmen(Lc, true);
    if (ii == 6) ct_wand_steck(Lc, false);
    if (ii == 7) ct_wand_steck(Lc, true);
}
