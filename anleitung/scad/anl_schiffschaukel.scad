include <../../modelle/schiffschaukel/schiffschaukel.scad>
include <anl_common.scad>
// Bauschritt-Szene Schiffschaukel.  schritt = Bauschritt; detail 1 = Arretierung, nur_haus = Kassenhäuschen
schritt = 99;
detail = 0;
nur_haus = 0;
function X(g) = g == schritt ? 1 : 0;
ad  = max(M(1.5), 12);
pd_ = max(M(0.12), 1.4);
module f(c) color(fhex(c)) render(convexity = 6) children();
stufe_a = schritt >= 7 ? winkel_schritt : 0;
module schiff_teile(s) {
    // 3: Rumpfkern + Bordwände (+ 4 Masten)
    f(farbe_sitze) rumpfkern();
    for (sy = [-1, 1]) translate([0, sy * X(3) * ad, 0]) { f(farbe_rumpf) rotate(sy > 0 ? 0 : 180) bordwand_welt("A"); f(farbe_zierleiste) rotate(sy > 0 ? 0 : 180) bordwand_welt("B"); }
    if (X(3)) for (sy = [-1, 1]) pfeil([0, sy * (Bs / 2 + ad * 0.9), zb(Rg, 0)], [0, sy * (Bs / 2 + ad * 0.15), zb(Rg, 0)], pd_);
    if (s >= 4) translate([0, 0, X(4) * ad]) {
        for (i = [0 : len(MASTEN) - 1]) { f(farbe_mast) mast_welt(i, "A"); f(farbe_segel) mast_welt(i, "B"); if (MASTEN[i][3]) f(farbe_flagge) mast_welt(i, "C"); }
        translate([X(4) * ad * 0.5, 0, 0]) f(farbe_mast) bugspriet_welt();
    }
    if (X(4)) pfeil([0, 0, zb(Rf, 0) + MASTEN[0][1] + ad * 1.6], [0, 0, zb(Rf, 0) + MASTEN[0][1] + ad * 1.05], pd_);
    // 5: Dübel
    if (s >= 5) for (sy = [-1, 1], x = X_DW) translate([0, X(5) * ad * 1.6, 0]) f(farbe_sitze) duebel_welt(sy * x, len([for (d = X_DA) if (abs(d - x) < 0.01) 1]) > 0);
}
module szene(s) {
    f(farbe_boden) bodenplatte_welt();
    if (X(1) && split) for (y = [-YP * 0.6, 0, YP * 0.6]) translate([0, y, -ad * 0.6]) f(farbe_boden) clip();
    for (z = zaun_seiten()) translate([0, 0, X(1) * ad]) f(farbe_zaun) zaun_welt(z);
    translate([0, 0, X(1) * ad]) f(farbe_zaun) tor_welt();
    // 2: A-Böcke, Plattformen, Achszapfen
    if (s >= 2) for (sy = [-1, 1]) {
        translate([0, 0, X(2) * ad]) f(farbe_gestell) abock_welt(sy);
        translate([0, 0, X(2) * ad * 1.8]) f(farbe_gestell) plattform_welt(sy);
        translate([0, -sy * X(2) * ad, 0]) f(farbe_gestell) achszapfen_welt(sy);
    }
    // 3–5: Schiff (zum Bauen neben der Anlage), 5: Arme + Dübel, ab 6 eingebaut
    if (s >= 3 && s <= 4) translate([0, -YP - Bs * 1.2 - ad, 0]) schiff_teile(s);
    if (s >= 5) schwing(stufe_a) {
        schiff_teile(s);
        for (sy = [-1, 1]) translate([0, sy * X(5) * ad * 0.8, 0]) f(farbe_gestell) arm_welt(sy);
    }
    // 6: Rampen
    if (s >= 6) for (sy = [-1, 1]) translate([0, sy * X(6) * ad, 0]) f(farbe_rampe) rampe_welt(sy);
    // 7: Arretier-Stift, Laterne
    if (s >= 7) for (sy = [-1, 1]) rotate(sy > 0 ? 0 : 180) color("#e8e2d0") translate([0, Y_a0 - 0.3 + X(7) * ad, H - r_ix]) rotate([-90, 0, 0]) cylinder(d = stift_d, h = l_st + 0.6, $fn = 16);
    if (s >= 7) { f(farbe_stein) laterne_welt(); translate([0, 0, X(7) * ad]) f(farbe_laterne) laternenkopf_welt(); }
}
if (detail == 1) {
    // Arretierung: Lagerkopf mit Knotenblech, Arm mit Rastbogen (Stufe +1), Filament-Stift
    translate([0, 0, -H]) {
        f(farbe_gestell) intersection() { abock_welt(1); translate([-r_rb * 1.8, 0, H - r_rb * 1.6]) cube([r_rb * 3.6, 500, r_rb * 2.8]); }
        schwing(winkel_schritt) f("silber") intersection() { arm_welt(1); translate([0, 0, H]) rotate([0, -winkel_schritt, 0]) translate([-r_rb * 1.8, 0, -r_rb * 1.6]) cube([r_rb * 3.6, 500, r_rb * 2.8]); }
        color("#e8e2d0") translate([0, Y_a0 - ad * 1.2, H - r_ix]) rotate([-90, 0, 0]) cylinder(d = stift_d, h = l_st + 0.6, $fn = 16);
        pfeil([0, Y_a0 - ad * 2.2, H - r_ix], [0, Y_a0 - ad * 1.3, H - r_ix], pd_);
    }
}
else if (nur_haus == 1) {
    color(fhex(farbe_haus_boden)) haus_boden();
    translate([0, 0, ad]) for (k = ["vorne", "hinten", "links", "rechts"]) { color(fhex(farbe_haus_wand)) wand_welt(k, "A"); color(fhex(farbe_haus_kanten)) wand_welt(k, "B"); }
    translate([0, 0, ad * 2]) { color(fhex(farbe_haus_dach)) haus_dach("A"); color(fhex(farbe_haus_kanten)) haus_dach("B"); }
    translate([0, 0, ad * 3]) { color(fhex(farbe_schild_A)) schild_welt("A"); color(fhex(farbe_schild_B)) schild_welt("B"); }
}
else szene(schritt);
