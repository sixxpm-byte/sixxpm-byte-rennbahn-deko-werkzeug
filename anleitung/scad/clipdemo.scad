include <anl_common.scad>
cL = 10; cw0 = 4; cw1 = 7; ch = 2; sp = 0.15;
module bow(o = 0) offset(delta = o) polygon([[-cL / 2, -cw1 / 2], [0, -cw0 / 2], [cL / 2, -cw1 / 2], [cL / 2, cw1 / 2], [0, cw0 / 2], [-cL / 2, cw1 / 2]]);
module block(s) color("#aaa69d") difference() {
    translate([s > 0 ? 0.3 : -30.3, -12, 0]) cube([30, 24, 8]);
    translate([0, 0, 8 - ch - sp]) linear_extrude(ch + sp + 1) bow(sp);
}
block(1); block(-1);
color("#3c78c8") translate([0, 0, 24]) linear_extrude(ch) bow();
pfeil([0, 0, 22], [0, 0, 10], 1.2);
