include <../../modelle/gartenhaus/gartenhaus.scad>
include <anl_common.scad>
schritt = 99;
detail = 0;           // 1 = Tür einfädeln, 2 = Seitenbalken in den Eckpfosten
function X(g, v = 1) = g == schritt ? v : 0;
ad = max(M(1.0), 9);                 // Hub der neuen Teile im Schritt
la = ad * 0.8;                       // Pfeillänge
pd_ = max(M(0.07), 1.2);             // Pfeildicke
module ab(p, h) pfeil([p[0], p[1], p[2] + h + la + 2], [p[0], p[1], p[2] + h + 2], pd_);   // Pfeil nach unten über dem gehobenen Teil

module platte_c() { color(fhex(farbe_platten)) bodenplatte("A"); translate([0, 0, schritt == 1 ? max(M(0.6), 6) : 0]) color(fhex(farbe_sockel)) bodenplatte("B"); }   // Schritt 1: Sockel schwebt über der Mulde
module wand_c(k) { color(fhex(farbe_wand)) wand_welt(k, "A"); color(fhex(farbe_holzwerk)) wand_welt(k, "B"); color(fhex(farbe_glas)) wand_welt(k, "C"); }
module tuer_c() { color(fhex(farbe_holzwerk)) tuer_welt("A"); color(fhex(farbe_griff)) tuer_welt("B"); }
module dach_c(h) { color(fhex(farbe_dach)) dach_welt(h, "A"); color(fhex(farbe_holzwerk)) dach_welt(h, "B"); }
module pfetten_c() color(fhex(farbe_holzwerk)) { pfette_welt(false); pfette_welt(true); }
pf_v = [0, M(0.6), ad * 0.45];       // Seitenbalken: von hinten oben einschwenken

if (detail == 1) {
    wand_c("vorne");
    translate([0, -M(0.5), lpb + 0.6]) tuer_c();
    let(x = u_ax, y = P - M(0.6)) {
        pfeil([x, y, z_f + dh + lpb], [x, y, z_f + dh + lpb + la * 0.6], pd_ * 0.7);
        pfeil([x - M(0.3), y, z_f + lpb * 2 + la * 0.6], [x - M(0.3), y, z_f + lpb * 2], pd_ * 0.7);
    }
} else if (detail == 2) {
    color(fhex(farbe_holzwerk)) portal_welt();
    translate(pf_v) pfetten_c();
    for (x = [wp * 0.75, B - wp * 0.75]) pfeil([x, t_p + pf_v[1] + lpf, z_f + H + pf_v[2]], [x, t_p + lpf * 0.3, z_f + H + 1], pd_);
} else {
    if (schritt >= 1) platte_c();
    if (schritt >= 2) for (k = ["vorne", "links"]) translate([0, 0, X(2, ad)]) wand_c(k);
    if (schritt == 2) { ab([B / 2, P, z_f + H_f], ad); ab([0, (P + D) / 2, z_f + H], ad); }
    if (schritt >= 3) for (k = ["rechts", "hinten"]) translate([0, 0, X(3, ad)]) wand_c(k);
    if (schritt == 3) { ab([B, (P + D) / 2, z_f + H], ad); ab([B / 2, D, z_f + H_f], ad); }
    if (schritt >= 4) translate([0, -X(4, M(0.6)), X(4, ad * 0.5)]) tuer_c();
    if (schritt == 4) ab([(du0 + du1) / 2, P - M(0.6), z_f + dh], ad * 0.5);
    if (schritt >= 5) translate([0, 0, X(5, ad)]) color(fhex(farbe_holzwerk)) portal_welt();
    if (schritt == 5) for (x = [wp / 2, B / 2, B - wp / 2]) ab([x, t_p / 2, z_f + (x == B / 2 ? H_f : H)], ad);
    if (schritt >= 6) translate(X(6) * pf_v) pfetten_c();
    if (schritt == 6) for (x = [wp * 0.75, B - wp * 0.75]) pfeil([x, t_p + pf_v[1] + lpf, z_f + H + pf_v[2]], [x, t_p + lpf * 0.3, z_f + H + 1], pd_);
    if (schritt >= 7) for (k = BK) translate([0, 0, X(7, ad * 0.7)]) color(fhex(farbe_bruestung)) wand_welt(k);
    if (schritt == 7) for (p = [[(x_b0 + x_e0) / 2, 0], [(x_e1 + x_b1) / 2, 0], [0, (t_p + P) / 2], [B, (t_p + P) / 2]]) ab([p[0], p[1], z_f + h_br], ad * 0.7);
    if (schritt >= 8) for (h = ["l", "r"]) translate([0, 0, X(8, ad * 1.4)]) dach_c(h);
    if (schritt == 8) for (x = [B * 0.2, B * 0.8], y = [D * 0.3, D * 0.7]) ab([x, y, z_f + vt(x) + t_r * 2], ad * 1.4);
    if (schritt >= 9) translate([0, 0, X(9, ad * 0.5)]) zubehoer_welt();
    if (schritt == 9) for (p = concat([[BANK[0], BANK[1], t_bp + M(0.85)], [STUHL[0], STUHL[1], z_f + M(0.85)]], [for (k = KUEBEL) [k[0], k[1], k[2] + M(0.75)]])) ab(p, ad * 0.5);
}
