include <muldenkipper.scad>
// Kollisionsszene: Baugruppen in Weltkoordinaten.  d0 = Kippwinkel der Mulde (0 oder 45),
// ii = Seite/Nummer.  Rendern mit -D teil="none".
obj = ""; d0 = 0; ii = 0;
SY = [1, -1];
if (obj == "rahmen") rahmen_koerper();
if (obj == "vorbau") vorbau_koerper();
if (obj == "grill") grill_welt();
if (obj == "leuchte") leuchte_welt(SY[ii]);
if (obj == "deck") oberdeck_welt();
if (obj == "kabine") kabine_welt("alle");
if (obj == "gel") gelaender_welt(GEL[ii]);
if (obj == "treppe") treppe_welt();
if (obj == "leiter") leiter_welt(SY[ii]);
if (obj == "rad") rad_welt(ii, "alle");
if (obj == "spiegel") spiegel_welt(SY[ii]);
if (obj == "auspuff") auspuff_welt(ii);
if (obj == "rl") rueckleuchte_welt(SY[ii]);
if (obj == "mulde") kipp(d0) mulde_welt();
if (obj == "dach") kipp(d0) schutzdach_welt("alle");
if (obj == "mt") kipp(d0) muldentraeger_welt(SY[ii]);
if (obj == "zyl") zylinder_welt(SY[ii], "alle", d0);
if (obj == "az") achszapfen_welt(ii);
