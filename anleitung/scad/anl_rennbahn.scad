include <../../modelle/rennbahn_deko/rennbahn_deko.scad>
include <anl_common.scad>
schritt = 99;
function X(g, v = 1) = g == schritt ? v : 0;
Lg = sc(12000); Rk = sc(9000); Lt = sc(4400);
if (schritt >= 1) {
    strecke("leitplanke", Lg / 2, 1, $kurve = false, $sd = 1);
    translate([Lg / 2 + X(1, 40), 0, 0]) strecke("leitplanke", Lg / 2, 1, $kurve = false, $sd = 1);
    if (schritt == 1) pfeil([Lg / 2 + 34, 0, 18], [Lg / 2 + 8, 0, 18], 2.4);
}
if (schritt >= 2) {
    translate([Lg + X(2, 40), Rk, 0]) rotate([0, 0, -90]) strecke("leitplanke", Rk * PI / 2, 2, $kurve = true, $R = Rk, $sd = 1);
    if (schritt == 2) pfeil([Lg + 34, 0, 18], [Lg + 8, 0, 18], 2.4);
}
if (schritt >= 3) {
    translate([-Lt - X(3, 40), 0, 0]) strecke("reifenstapel", Lt, 1, $kurve = false, $sd = 1);
    if (schritt == 3) pfeil([-34, 0, 25], [-8, 0, 25], 2.4);
}
if (schritt >= 4) { translate([0, sc(1800), X(4, 30)]) strecke("curb", Lg, 2, $kurve = false, $sd = 1); if (schritt == 4) pfeil([Lg / 2, sc(1800), 40], [Lg / 2, sc(1800), 12], 2.4); }
if (schritt >= 5) { translate([0, sc(9500), X(5, 30)]) strecke("betonwand", Lg, 2, $kurve = false, $sd = -1); if (schritt == 5) pfeil([Lg / 2, sc(9500), 60], [Lg / 2, sc(9500), 32], 2.4); }
if (schritt >= 6) for (i = [0 : 4]) translate([sc(1500) + i * sc(2200), sc(4800) + (i % 2) * sc(1400), X(6, 25)]) pylone_vorschau();
