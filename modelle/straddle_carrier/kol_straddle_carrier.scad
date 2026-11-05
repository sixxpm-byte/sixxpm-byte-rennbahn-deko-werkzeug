include <straddle_carrier.scad>
// Kollisionsszene: Baugruppen in Weltkoordinaten (Aufbau, 20-Fuß-Container am Spreader;
// ii = 1 beim Arm: 40-Fuß-Stellung).  Rendern mit -D teil="none".
obj = ""; d0 = 0; ii = 0;
SX = [1, -1, 1, -1]; SY = [1, 1, -1, -1];
module container_kol() translate([0, 0, Z_hub - H_ct]) difference() {
    translate([-L_c20 / 2, -W_ct / 2, 0]) cube([L_c20, W_ct, H_ct]);
    // Löcher der oberen Eckbeschläge für die Koni
    for (sx = [-1, 1], sy = [-1, 1]) translate([sx * x_kt, sy * (W_ct / 2 - in_y), H_ct - h_tw - 1]) cylinder(d = d_tw + 2 * zapfen_spiel, h = h_tw + 2, $fn = 24);
}
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
if (obj == "container") container_kol();
