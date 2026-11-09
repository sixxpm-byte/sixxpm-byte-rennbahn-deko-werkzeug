include <boxenmauer.scad>
// Kollisionsszene: obj = Bauteil, ii = Element/Seite.  Rendern mit -D teil="none".
obj = ""; d0 = 0; ii = 0;
if (obj == "mauer") translate([ii * L, 0, 0]) mauer_welt("alle");
if (obj == "zaun") translate([ii * L, 0, 0]) zaunfeld_welt();
if (obj == "podest") translate([X_k, 0, 0]) podest_welt();
if (obj == "treppe") translate([X_k, 0, 0]) treppe_welt();
if (obj == "pult") translate([X_k, 0, 0]) pult_welt();
if (obj == "monitore") translate([X_k, 0, 0]) monitore_welt("alle");
if (obj == "hocker") translate([X_k, 0, 0]) hocker_welt();
if (obj == "wand") translate([X_k, 0, 0]) seitenwand_welt(ii, "alle");
if (obj == "gelaender") translate([X_k, 0, 0]) gelaender_welt();
if (obj == "dach") translate([X_k, 0, 0]) dach_welt();
if (obj == "banner") translate([X_k, 0, 0]) banner_welt("alle");
