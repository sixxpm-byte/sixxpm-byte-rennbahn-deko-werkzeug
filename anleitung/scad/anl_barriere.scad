include <../../modelle/barriere_zaun/barriere_zaun.scad>
include <anl_common.scad>
schritt = 99;
function X(g, v = 1) = g == schritt ? v : 0;
n = anzahl;
for (i = [0 : n - 1]) translate([i * PE + (i > 0 ? X(1, 20) * i : 0), 0, 0]) {
    color(C_BETON) barriere_roh();
    if (schritt == 1 && i > 0) pfeil([-g_el / 2 + 16, y_p, H * 0.5], [-g_el / 2 + 3, y_p, H * 0.5], 1.8);
    for (j = [0 : m_pe]) {
        px = j * PP - g_el / 2;
        art = j == 0 ? (i == 0 ? "ende_l" : "fuge") : j == m_pe ? (i == n - 1 ? "ende_r" : "none") : "mitte";
        if (schritt >= 2) translate([0, 0, X(2, 30)]) {
            if (art == "fuge" || art == "mitte") color(C_STAHL) pfosten_welt(art, px);
            if (art == "ende_l") color(C_STAHL) pfosten_welt("ende", px + 0);
            if (art == "ende_r") color(C_STAHL) translate([px, 0, 0]) mirror([1, 0, 0]) translate([-px, 0, 0]) pfosten_welt("ende", px);
        }
        if (schritt == 2 && art != "none") pfeil([px, y_p - 14, H + 100], [px, y_p - 14, H + 70], 2);
        if (schritt >= 3 && j < m_pe) translate([0, -X(3, 25), 0]) color(C_DRAHT) zaunfeld_welt(px);
        if (schritt == 3 && j < m_pe) pfeil([px + PP / 2, y_p - 40, H + 30], [px + PP / 2, y_p - 18, H + 30], 2);
    }
}
