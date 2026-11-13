include <gabelstapler.scad>
// Kollisionsszene: Baugruppen in Weltkoordinaten (Aufbau-Stellung, Gabelträger in Hubstufe gabel_stufe)
obj = ""; d0 = 0; ii = 0;
if (obj == "fahrgestell") fahrgestell_welt("alle");
if (obj == "kabine") kabine_welt("alle");
if (obj == "glaskern") kern_welt("alle");
if (obj == "mast") mast_welt("alle");
if (obj == "traeger") traeger_welt(HC(gabel_stufe), "alle");
if (obj == "gabel") gabel_welt(ii == 0 ? 1 : -1, HC(gabel_stufe), "alle");
if (obj == "kotfluegel") kf_welt(ii == 0 ? 1 : -1, "alle");
if (obj == "rad") rad_welt(ii < 2, ii % 2 == 0 ? 1 : -1, "alle");
if (obj == "rundumleuchte") rl_welt("alle");
if (obj == "neigezylinder") nz_welt(ii == 0 ? Y_MZ : -Y_MZ, "alle");
if (obj == "ansaugrohr") ar_welt("alle");
