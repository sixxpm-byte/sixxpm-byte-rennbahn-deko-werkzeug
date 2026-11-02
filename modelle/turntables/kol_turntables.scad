// Kollisionsszene Turntables: Baugruppen in Weltkoordinaten
// obj, d0 = Drehwinkel des Plattentellers, ii = Drehwinkel der Gondelkreuze (Gondeln drehen mit +2*ii)
include <turntables.scad>
obj = ""; d0 = 0; ii = 0;
if (obj == "bodenkreuz") bodenkreuz_welt();
if (obj == "deck") deck_welt();
if (obj == "blenden") blenden_welt("alle");
if (obj == "stufen") for (k = STK) rotate(sidec(k)) stufe_lokal("alle");
if (obj == "teller") achse_rahmen() rotate([0, 0, d0]) scheibe("alle", [0, R_s + 5, 0, 360, 0]);
if (obj == "kreuze") achse_rahmen() rotate([0, 0, d0]) for (k = [0 : 3]) translate(concat(pol(r_x, XA[k]), [t_s + h_sh])) rotate([0, 0, ii + k * 17]) {
    kreuz("alle");
    for (j = [0 : 3]) translate([arm_r * cos(j * 90), arm_r * sin(j * 90), t_x + h_ed + 0.05]) rotate([0, 0, 2 * ii + j * 90 + 55]) gondel("alle");
}
if (obj == "turm") achse_rahmen() turm_welt();
if (obj == "rueckwand") for (k = WK) { rueckwand_welt(k, "alle"); stuetze_welt(k); markise_welt(k); }
if (obj == "schild") vinylschild_welt();
if (obj == "masten") for (k = MK) lichtmast_welt(k);
if (obj == "zaeune") for (k = ZK) zaun_welt(k);
if (obj == "mischpulte") for (k = FK) mischpult_welt(k);
if (obj == "tonarm") tonarm_welt();
if (obj == "kasse") translate([HX, HY, 0]) kassenhaus();
