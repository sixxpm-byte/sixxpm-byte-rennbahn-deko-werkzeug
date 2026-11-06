// Kollisionsszene Freifallturm: Baugruppen in Weltkoordinaten (wie anlage(), ohne Explosion)
// obj, d0 = Höhe des Sitzrings in % (0 unten … 100 oben)
include <freifallturm_src.scad>
obj = ""; d0 = 0; ii = 0;
if (obj == "podest") podest_welt("alle");
if (obj == "treppe") treppe_welt();
if (obj == "mast") for (i = [0 : n_sek - 1]) mast_welt(i, "alle");
if (obj == "gondel") translate([0, 0, z_g0 + d0 / 100 * (z_g1 - z_g0)]) gondel("alle");
if (obj == "kopf") kopf_welt("alle");
if (obj == "zaun") for (k = ZAUN_K) zaun_welt(k);
if (obj == "portal") portal_welt("alle");
if (obj == "kasse") translate([X_KA, Y_KA, H_p]) { kasse(); translate([-B_ka / 2 - max(sc(250), 2), -T_ka / 2 - max(sc(250), 2), H_ka]) kasse_dach(); }
// Farbteile einzeln (Steckteile): ii = 0 A, 1 B, 2 C
if (obj == "gp") gondel(["A", "B", "C"][ii]);
if (obj == "kp") kopf(["A", "B", "C"][ii]);
