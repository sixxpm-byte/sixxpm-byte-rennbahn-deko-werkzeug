// =====================================================================
//  deko_rad.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Einzelrad für Baumaschinen: Reifen mit Pfeilprofil (A) und Steck-Felge (B).
//  Gedruckt mit senkrechter Achse, Innenseite auf dem Bett, stützfrei.
//  Erwartet im Modell: spiel, einsatz_spiel und (nach deko_grundlagen) M(), inc().
//    R_w Reifenradius, B_w Breite, R_fe Felgenradius, d_rz Radzapfen (Raute, Diagonale),
//    t_nb Tiefe des Nabenlochs (von der Innenseite)
// =====================================================================
module reifen_rad(fp, R_w, B_w, R_fe, d_rz, t_nb) {
    lip_h = max(M(0.03), 0.4); lip_w = max(M(0.08), 0.8); lip_t = lip_h + lip_w;   // Innenrand: senkrecht, dann 45°-Konus
    c_t = M(0.28); n_p = 18; g_d = max(M(0.11), 0.8);
    prof = [[R_fe - lip_w, 0], [R_w - 0.7 * c_t, 0], [R_w, c_t], [R_w, B_w - c_t], [R_w - c_t, B_w], [R_fe, B_w], [R_fe, lip_t], [R_fe - lip_w, lip_h]];
    if (inc(fp, "A")) difference() {
        rotate_extrude($fn = 96, convexity = 6) polygon(prof);
        // Stollen: je Reifenhälfte schräge Rillen, in der Mitte zum V verbunden (keine Überhänge)
        for (hf = [0, 1]) translate([0, 0, hf * B_w / 2 - (hf == 0 ? 0.01 : 0)])
            linear_extrude(B_w / 2 + 0.01, twist = hf == 0 ? 9 : -9, slices = 6, convexity = 6)
            rotate(hf == 0 ? 0 : -9) for (k = [0 : n_p - 1]) rotate(k * 360 / n_p)
                translate([R_w - g_d, -R_w * PI / n_p * 0.42]) square([g_d + 2, R_w * 2 * PI / n_p * 0.42]);
    }
    if (inc(fp, "B")) let(r_f = R_fe - einsatz_spiel, w_fl = max(M(0.08), 0.8), r_hb = max(M(0.32), d_rz / 2 + 1.2), rec = M(0.14)) difference() {
        union() {
            rotate_extrude($fn = 96, convexity = 4) polygon([[0, 0], [R_fe - lip_w - einsatz_spiel, 0], [R_fe - lip_w - einsatz_spiel, lip_h], [r_f, lip_t], [r_f, B_w - rec], [0, B_w - rec]]);
            difference() { translate([0, 0, lip_t]) cylinder(r = r_f, h = B_w - M(0.03) - lip_t, $fn = 96); translate([0, 0, -1]) cylinder(r = r_f - w_fl, h = B_w + 2, $fn = 96); }
            cylinder(r = r_hb, h = B_w - M(0.05), $fn = 48);
            cylinder(r = r_hb * 0.55, h = B_w - M(0.01), $fn = 32);
            for (k = [0 : 11]) rotate(k * 30) translate([(r_hb + r_f - w_fl) / 2, 0, 0]) cylinder(r = max(M(0.04), 0.5), h = B_w - rec + max(M(0.04), 0.4), $fn = 10);
        }
        translate([0, 0, -1]) cylinder(d = d_rz + spiel, h = t_nb + 1, $fn = 32);
    }
}
