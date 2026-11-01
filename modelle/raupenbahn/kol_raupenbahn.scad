include <raupenbahn.scad>
obj = ""; d0 = 0; ii = 0;
if (obj == "car") let(th = d0 + ii * pw) car_frame(th) { wagen("alle"); sitz(); verdeck_welt("alle", raupenkopf && ii == 0); }
if (obj == "arm") arm_frame(d0 + ii * pw) ausleger_3d();
if (obj == "rotor") translate([0, 0, z_r0]) rotate(d0) rotor();
if (obj == "kz") translate([0, 0, z_f]) koenigszapfen();
if (obj == "mb") rotate(d0) { mb_boden(); mb_waende(); mb_deckel(); kuppel(); }
if (obj == "podest") podest_welt();
if (obj == "bahn") bahn_welt();
if (obj == "saeulen") saeulen_welt();
if (obj == "dach") dach_welt();
if (obj == "blenden") blenden_welt();
if (obj == "ns") ns_welt();
if (obj == "schild") rs_welt();
if (obj == "zaun") for (k = ZK) zaun_welt(k);
if (obj == "weg") weg_welt();
if (obj == "treppe") for (k = STK) treppe_welt(k);
if (obj == "deko") { kasse_platz() haus_boden(); for (p = PFL) translate(concat(p, [0])) pflanze(); }
