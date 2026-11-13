// =====================================================================
//  deko_rad.scad  –  Bibliothek der Rennbahn-Deko-Reihe
//  Einzelrad für Baumaschinen: Reifen mit Pfeilprofil (A) und Steck-Felge (B).
//  Gedruckt mit senkrechter Achse, Innenseite auf dem Bett, stützfrei.
//  Erwartet im Modell: spiel, einsatz_spiel und (nach deko_grundlagen) M(), inc().
//    R_w Reifenradius, B_w Breite, R_fe Felgenradius, d_rz Radzapfen (Raute, Diagonale),
//    t_nb Tiefe des Nabenlochs (von der Innenseite), r_nabe > 0: Nabenradius (sonst M(0.32))
//    g_zw > 0: Zwillingsrad – zwei Reifen mit V-Rille (Luft g_zw) auf einer durchgehenden
//    Felge, Gesamtbreite 2*B_w + g_zw (Innenreifen auf dem Bett)
// =====================================================================
module reifen_rad(fp, R_w, B_w, R_fe, d_rz, t_nb, g_zw = 0, r_nabe = 0) {
    lip_h = max(M(0.03), 0.4); lip_w = max(M(0.08), 0.8); lip_t = lip_h + lip_w;   // Innenrand: senkrecht, dann 45°-Konus
    c_t = min(M(0.28), 0.4 * B_w); n_p = 18; g_d = max(M(0.11), 0.8);   // Schulterfase, bei schmalen Reifen begrenzt
    zw = g_zw > 0; c_v = min(M(0.12), 0.45 * B_w); H2 = zw ? 2 * B_w + g_zw : B_w;
    prof = zw ? [[R_fe - lip_w, 0], [R_w - 0.7 * c_t, 0], [R_w, c_t], [R_w, B_w - c_v], [R_w - c_v, B_w], [R_w - c_v, B_w + g_zw],
                 [R_w, B_w + g_zw + c_v], [R_w, H2 - c_t], [R_w - c_t, H2], [R_fe, H2], [R_fe, lip_t], [R_fe - lip_w, lip_h]]
              : [[R_fe - lip_w, 0], [R_w - 0.7 * c_t, 0], [R_w, c_t], [R_w, B_w - c_t], [R_w - c_t, B_w], [R_fe, B_w], [R_fe, lip_t], [R_fe - lip_w, lip_h]];
    if (inc(fp, "A")) difference() {
        rotate_extrude($fn = 96, convexity = 6) polygon(prof);
        // Stollen: je Reifenhälfte schräge Rillen, in der Mitte zum V verbunden (keine Überhänge)
        for (t0 = zw ? [0, B_w + g_zw] : [0], hf = [0, 1]) translate([0, 0, t0 + hf * B_w / 2 - (hf == 0 ? 0.01 : 0)])
            linear_extrude(B_w / 2 + 0.01, twist = hf == 0 ? 9 : -9, slices = 6, convexity = 6)
            rotate(hf == 0 ? 0 : -9) for (k = [0 : n_p - 1]) rotate(k * 360 / n_p)
                translate([R_w - g_d, -R_w * PI / n_p * 0.42]) square([g_d + 2, R_w * 2 * PI / n_p * 0.42]);
    }
    if (inc(fp, "B")) let(r_f = R_fe - einsatz_spiel, w_fl = max(M(0.08), 0.8), r_hb = r_nabe > 0 ? max(r_nabe, d_rz / 2 + 1.2) : max(M(0.32), d_rz / 2 + 1.2), rec = M(0.14)) difference() {
        union() {
            rotate_extrude($fn = 96, convexity = 4) polygon([[0, 0], [R_fe - lip_w - einsatz_spiel, 0], [R_fe - lip_w - einsatz_spiel, lip_h], [r_f, lip_t], [r_f, H2 - rec], [0, H2 - rec]]);
            difference() { translate([0, 0, lip_t]) cylinder(r = r_f, h = H2 - M(0.03) - lip_t, $fn = 96); translate([0, 0, -1]) cylinder(r = r_f - w_fl, h = H2 + 2, $fn = 96); }
            let(z0 = r_nabe > 0 ? lip_t : 0) translate([0, 0, z0]) cylinder(r = r_hb, h = H2 - M(0.05) - z0, $fn = 48);   // mit r_nabe: erst über dem Innenrand
            cylinder(r = r_hb * 0.55, h = H2 - M(0.01), $fn = 32);
            for (k = [0 : 11]) let(z0 = r_nabe > 0 ? lip_t : 0) rotate(k * 30) translate([(r_hb + r_f - w_fl) / 2, 0, z0]) cylinder(r = max(M(0.04), 0.5), h = H2 - rec + max(M(0.04), 0.4) - z0, $fn = 10);   // mit r_nabe: erst über dem Innenrand
        }
        translate([0, 0, -1]) cylinder(d = d_rz + spiel, h = t_nb + 1, $fn = 32);
    }
}
