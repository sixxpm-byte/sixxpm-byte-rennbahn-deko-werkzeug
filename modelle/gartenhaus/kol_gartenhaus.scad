include <gartenhaus.scad>
obj = ""; d0 = 0; ii = 0;
if (obj == "platte") bodenplatte();
if (obj == "wand") wand_welt(WK[ii]);
if (obj == "br") wand_welt(BK[ii]);
if (obj == "tuer") translate([0, P + t_w, z_f]) rotate([90, 0, 0]) translate([u_ax, 0, t_w / 2]) rotate([0, d0, 0]) translate([-u_ax, 0, -t_w / 2]) translate([du0 + spiel, gv, t_w / 2 - t_d / 2]) tuer_lokal();
if (obj == "portal") portal_welt();
if (obj == "pfette") pfette_welt(ii == 1);
if (obj == "dach") dach_welt(ii == 0 ? "l" : "r");
if (obj == "zub") zubehoer_welt();
