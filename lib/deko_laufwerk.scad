// =====================================================================
//  deko_laufwerk.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Raupenlaufwerk: Kettenband mit Stollen, Laufwerksrahmen, Leit-/Turasrad,
//  Lauf- und Stützrollen als Relief auf der Außenseite.  Das Teil wird liegend auf
//  der Innenseite gedruckt (Innenseite = Druckbett, Relief oben) – stützfrei.
//  Erwartet im Modell (nach deko_grundlagen):
//    c_k   halber Abstand der Umlenkachsen (mm)      r_k   Umlenkradius (mm)
//    B_k   Kettenbreite (mm)                          Y_k0  Innenseite der linken Kette (mm)
//    h_gr  Stollenhöhe, t_sh Bodenplatten-Band, d_rf Relieftiefe (mm)
//  Optional vorab: lw_rollen (Laufrollen, Standard 6), lw_stuetz (Stützrollen, 2),
//    lw_zaehne (Turas hinten mit Zähnen, Standard false).
//  lw_h_nabe: Überstand der Radnaben außen (Freiraum für Anbauteile einplanen).
//  lw_koerper() liefert die LINKE Kette in Welt-Koordinaten (x = Fahrtrichtung,
//  y = Y_k0 .. Y_k0 + B_k, z = 0 Boden); die rechte Kette ist das gleiche Teil, um 180°
//  um z gedreht (Taschen des Modells also symmetrisch in x anlegen).
// =====================================================================
lw_n_r = is_undef(lw_rollen) ? 6 : lw_rollen;
lw_n_s = is_undef(lw_stuetz) ? 2 : lw_stuetz;
lw_zh  = is_undef(lw_zaehne) ? false : lw_zaehne;
lw_h_nabe = max(M(0.04), 0.5);              // Radnaben stehen so weit über die Außenseite
module lw_xz(y0, y1) translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 8) children();
module lw_ci(p, r) translate(p) circle(r = r, $fn = 40);
module lw_umriss_2d() hull() { lw_ci([-c_k, r_k], r_k); lw_ci([c_k, r_k], r_k); }
// Band mit Stollen (Bodenplatten) rundum
module lw_band_2d() {
    lw_umriss_2d();
    n = max(8, round(2 * c_k / max(M(0.22), 1.6))); p = 2 * c_k / n; w = p * 0.45;
    for (i = [0 : n]) for (z = [0, 2 * r_k]) translate([-c_k + i * p, z]) square([w, 2 * h_gr], center = true);
    m = max(4, round(PI * r_k / p));
    for (s = [-1, 1], i = [1 : m - 1]) translate([s * c_k, r_k]) rotate(s * (i * 180 / m) - 90) translate([r_k, 0]) square([2 * h_gr, w], center = true);
}
// Laufwerksrahmen, Räder und Rollen (innerhalb des Bandes)
module lw_relief_2d() {
    r_w = r_k - t_sh - max(M(0.03), 0.4);
    hull() { lw_ci([-c_k * 0.8, r_k], r_k * 0.42); lw_ci([c_k * 0.8, r_k], r_k * 0.42); }
    lw_ci([c_k, r_k], r_w);                                     // Leitrad vorne
    if (lw_zh) {                                                // Turas hinten mit Zähnen
        nz = max(8, round(2 * PI * r_w / max(M(0.2), 1.2)));
        lw_ci([-c_k, r_k], r_w - max(M(0.05), 0.5));
        for (i = [0 : nz - 1]) translate([-c_k, r_k]) rotate(i * 360 / nz) translate([r_w - max(M(0.05), 0.5), 0]) square([2 * max(M(0.05), 0.5), max(M(0.06), 0.6)], center = true);
    } else lw_ci([-c_k, r_k], r_w);
    r_r = max(M(0.13), 1.0);
    for (i = [0 : lw_n_r]) lw_ci([-c_k * 0.78 + i * c_k * 1.56 / lw_n_r, t_sh + r_r + max(M(0.01), 0.1)], r_r);
    for (i = [0 : lw_n_s - 1]) lw_ci([-c_k * 0.35 + i * c_k * 0.7 / max(1, lw_n_s - 1), 2 * r_k - t_sh - r_r * 0.8 - max(M(0.01), 0.1)], r_r * 0.8);
}
// Körper der linken Kette (Welt)
module lw_koerper() union() {
    lw_xz(Y_k0, Y_k0 + B_k - d_rf) lw_band_2d();
    lw_xz(Y_k0 + B_k - d_rf - 0.01, Y_k0 + B_k) { difference() { lw_band_2d(); offset(delta = -t_sh) lw_umriss_2d(); } lw_relief_2d(); }
    for (s = [-1, 1]) translate([s * c_k, Y_k0 + B_k - 0.01, r_k]) rotate([-90, 0, 0]) cylinder(r1 = r_k * 0.3, r2 = r_k * 0.22, h = lw_h_nabe, $fn = 24);
}
