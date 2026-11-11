include <planierraupe.scad>
// Kollisionsszene: obj = Bauteil, d0 = Stellung (Index in POSE), ii = Seite.  Rendern mit -D teil="none".
obj = ""; d0 = 0; ii = 0;
SY = [1, -1];
POSE = [[0, 0], [10, 15], [10, 0], [0, 15]];   // [Schild, Ripper]
a = POSE[d0][0]; b = POSE[d0][1];
if (obj == "unterwagen") unterwagen_welt();
if (obj == "kette") kette_welt(SY[ii]);
if (obj == "kotfluegel") kotfluegel_welt(SY[ii]);
if (obj == "rahmen") rahmen_welt();
if (obj == "kabine") kabine_welt("alle");
if (obj == "schildrahmen") in_schild(a) schildrahmen_welt();
if (obj == "schild") in_schild(a) schild_welt();
if (obj == "zh") zyl_zw(HZ_p, lug_s(a), SY[ii] * Y_hz, "alle", ZH, false, false);
if (obj == "ripper") in_ripper(b) ripper_welt();
if (obj == "zr") zyl_zw(RZ_p, lug_r(b), 0, "alle", ZR, false, false);
