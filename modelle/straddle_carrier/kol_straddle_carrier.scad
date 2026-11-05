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
if (obj == "arm") rotate([0, 0, (ii % 2) * 180]) translate([ii >= 2 ? E40 : 0, 0, 0]) spreader_arm_welt("alle");
if (obj == "kabine") kabine_welt("alle");
if (obj == "motor") motor_welt("alle");
if (obj == "container") container_welt(L_c20);
if (obj == "container40") container_welt(L_c40);
