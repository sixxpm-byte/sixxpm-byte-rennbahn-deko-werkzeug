include <../../modelle/container_40ft/container_40ft.scad>
include <anl_common.scad>
schritt = 99;
function X(g, v = 1) = g == schritt ? v : 0;
cc = container_color;
if (schritt >= 1) color("#3a3a3a") floor_part();
if (schritt >= 2) {
    color(cc) translate([-X(2, 30), 0, 0]) front_wall();
    color(cc) translate([X(2, 30), 0, 0]) rear_frame();
    if (schritt == 2) { pfeil([-40, W / 2, H * 0.6], [-12, W / 2, H * 0.6], 2); pfeil([L + 40, W / 2, H * 0.6], [L + 12, W / 2, H * 0.6], 2); }
}
if (schritt >= 3) {
    color(cc) translate([0, -X(3, 30), 0]) side_wall();
    color(cc) translate([0, X(3, 30), 0]) mirror_w(true) side_wall();
    if (schritt == 3) { pfeil([L / 2, -40, H * 0.6], [L / 2, -12, H * 0.6], 2.4); pfeil([L / 2, W + 40, H * 0.6], [L / 2, W + 12, H * 0.6], 2.4); }
}
if (schritt >= 4) {
    color(cc) { door_world(false, schritt == 4 ? 60 : 0); door_world(true, schritt == 4 ? 60 : 0); }
    color("silver") translate([0, 0, X(4, 25)]) { pin_world(false); pin_world(true); }
    if (schritt == 4) for (r = [false, true]) translate([L, r ? W : 0, 0]) pfeil([0, 0, H + 34], [0, 0, H + 12], 1.6);
}
if (schritt >= 5) { color(cc) translate([0, 0, X(5, 30)]) roof_part(); if (schritt == 5) pfeil([L / 2, W / 2, H + 50], [L / 2, W / 2, H + 32], 2.4); }
