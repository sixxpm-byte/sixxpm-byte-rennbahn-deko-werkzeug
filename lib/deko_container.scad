// =====================================================================
//  deko_container.scad – Container-Bausatz 20/40 Fuß (ISO) für die Rennbahn-Deko-Reihe
//  Teile: boden, dach (A Dachblech, B Obergurte + Eckbeschläge), seite 2x, stirn, tuer;
//  40 Fuß bei 1:43 mit Clips geteilt (CLIPS).  Druck: ct_druck(Lc, name, farbteil, stueck),
//  Welt/Vorschau: ct_welt(Lc, ex) lokal (x 0..Lc, y 0..W_ct, z 0..H_ct; Türen bei x = Lc).
//
//  Einbinden NACH deko_grundlagen.scad, VOR deko_hilfen.scad; vorher im Modell festlegen:
//    container_20_m, container_40_m, container_breite_m, container_hoehe_m, zapfen_spiel,
//    farbe_container, farbe_beschlag,
//    ct_mag (Magnettaschen im Dach an/aus), ct_mag_d, ct_mag_h (Tasche in mm),
//    ct_mag_n (1 = mittig, 2 = bei 1/4 und 3/4 der Breite), ct_mag_haut (Dachhaut über dem Magnet),
//    ct_zweifarbig (true: Dach, Stirn und Tür mit Farbteil B = Dachrahmen/Eckpfosten/Obergurte in
//    farbe_beschlag – nur für Mehrfarbdruck in einem Durchgang, B ist nicht gesteckt;
//    false: diese Teile einfarbig, dann druck(..., "alle", farbe_container, ...)),
//    ct_steck (true: Steck-Bausatz, ersetzt ct_zweifarbig – siehe unten; braucht einsatz_spiel)
//  Die Magnettaschen sitzen von innen im Dachblech, ct_mag_x von jeder Stirnseite.
//
//  STECK-BAUSATZ (ct_steck = true) – jede Farbe ein eigenes Teil, alles hält ohne Kleber:
//    boden (Beschlagfarbe, aufrecht, Rauten-Zapfen oben auf den Eckbeschlägen),
//    stirnrahmen / tuerrahmen (Beschlagfarbe: zwei Eckpfosten mit oberen Eckbeschlägen und
//      Koni-Bohrung, Obergurt; außen unten gedruckt), stirn / tuer (Containerfarbe, von innen
//      in den Falz des Rahmens gedrückt), seite 2x, dach (Containerfarbe, an den Ecken
//      ausgespart, Rauten-Zapfen unten).  Lastweg beim Anheben am Dach: Dach -> Zapfen ->
//      Obergurte -> Pfosten -> Zapfen -> Boden (Presssitz mit einsatz_spiel).
// =====================================================================
// Container (lokal: x längs ab Stirnwand, y quer, z = 0 Unterkante)
L_c20 = M(container_20_m); L_c40 = M(container_40_m);
W_ct  = M(container_breite_m); H_ct = M(container_hoehe_m);
d_tw  = max(M(0.12), 1.8);                // Zapfen unter den Kopfträgern
h_tw  = max(M(0.15), 2.0);
r_zl  = d_tw / 2 + zapfen_spiel;          // Bohrung im Eckbeschlag
in_x  = max(M((container_20_m - 5.853) / 2), r_zl + 1.1);   // Zapfenmitte ab Stirnseite
in_y  = max(M((container_breite_m - 2.259) / 2), r_zl + 1.1);
cx_e  = max(M(0.178), in_x + r_zl + 0.8); // Eckbeschlag / Eckpfosten
cy_e  = max(M(0.162), in_y + r_zl + 0.8);
h_eb  = max(M(0.118), 1.2);
cd    = max(M(0.036), 0.4);               // Sickentiefe
p_sk  = M(0.278);                         // Sickenteilung
t_cw  = min_wand;
rb    = max(M(0.1), 1.2);                 // Rahmen (Längs-/Stirnträger)
h_ur  = max(M(0.16), 1.6);
h_or  = max(M(0.1), 1.0);
dt    = max(M(0.04), 0.6);                // Tür zurückgesetzt

// Magnettaschen im Dach (von innen, unsichtbar): Mitte ct_mag_x ab Stirnseite, Boss frei von Eckpfosten/Obergurt
ct_mag_x  = cx_e + spiel + ct_mag_d / 2 + min_wand;
ct_mag_z0 = H_ct - ct_mag_haut - ct_mag_h;          // Unterkante Magnet (= Boss-Unterkante)
function ct_mag_ys() = ct_mag_n == 2 ? [W_ct / 4, 3 * W_ct / 4] : [W_ct / 2];
function ct_mag_pos(Lc) = [for (x = [ct_mag_x, Lc - ct_mag_x], y = ct_mag_ys()) [x, y]];
ct_p_r = 12; ct_t_r = 1.2;                           // Rippen im Boden
// Steck-Bausatz: Rahmenlippe außen, Falz, Rauten-Zapfen
ct_es  = ct_steck ? einsatz_spiel : 0;
ct_lip = ct_steck ? max(M(0.05), 0.8) : 0;           // Wand liegt um ct_lip hinter der Außenkante des Rahmens
ct_rb  = max(M(0.03), 0.6);                          // Falz: Wand greift so weit hinter Pfosten und Obergurt
ct_dp  = min(max(M(0.12), 2.2), cx_e - 1.2, cy_e - ct_rb - 1.2);   // Rauten-Zapfen (Diagonale)
ct_yp  = (cy_e - ct_rb) / 2;                         // Zapfenmitte im Pfosten (quer)
ct_lp  = max(M(0.15), 2.5);                          // Zapfen Boden -> Pfosten

// =====================================================================
//  Container-Bausatz (lokal: x 0..Lc, y 0..W_ct, z 0..H_ct; Türen bei x = Lc)
//  boden (kopfüber), dach (kopfüber), seite 2x (innen unten), stirn und
//  tuer (außen unten).  Wände stecken mit Federn in Nuten von Boden und Dach.
// =====================================================================
g_n  = max(M(0.04), 0.8);                 // Nuttiefe
t_tg = max(0.8, t_cw - 0.4);              // Federdicke
z_f  = h_ur;                              // Bodenoberkante
t_fl = max(M(0.06), g_n + 0.8);           // Bodenplatte
tr   = max(h_or, g_n + 0.8, t_cw);        // Dachdicke
hc   = max(h_eb, h_tw + 1.0);             // obere Eckbeschläge (unter dem Dach)
h_tb = max(M(0.12), 1.2);                 // Obergurt Stirn/Tür
z_wo = H_ct - tr;                         // Wand-Oberkante
z_e1 = H_ct - hc - h_tb;                  // Stirnblech/Türen oben
rib_h = b_cl;                             // Schott unter dem Dach (Clips)
y_s0 = cd + t_cw - t_tg;                  // Feder der Seitenwand (innen)
y_cs = cd + t_cw + spiel + 1;             // Clip-Bereich ab hier
bw_t = max(M(0.05), 0.8);
ct_lr = min(max(M(0.1), 1.5), H_ct - tr - (z_e1 + ct_rb) - 0.4);   // Zapfen Dach -> Obergurt
function ct_xp(Lc, tuer) = tuer ? Lc - cx_e / 2 : cx_e / 2;
module raute_2d(d) rotate(45) square(d / sqrt(2), center = true);     // Ecken in x und y (liegend druckbar)
module ct_stift(h) let(c = min(0.4, ct_dp * 0.2)) {
    linear_extrude(h - c) offset(delta = -ct_es) raute_2d(ct_dp);
    translate([0, 0, h - c - 0.01]) linear_extrude(c + 0.01, scale = 0.6) offset(delta = -ct_es) raute_2d(ct_dp);
}
function ct_xs(Lc) = Lc > usable ? seams_at(Lc, [], mw) : [];
function ct_S(xs) = [for (sx = xs) [sx - spw / 2, y_cs, sx + spw / 2, W_ct - y_cs]];
function info_boden(Lc) = [Lc, W_ct, ct_xs(Lc), [], [], false, z_f, ct_S(ct_xs(Lc))];
function info_dach(Lc) = [Lc, W_ct, ct_xs(Lc), [], [], true, tr + rib_h, ct_S(ct_xs(Lc))];
function info_seite(Lc) = let(Lw = Lc - 2 * cx_e - 2 * spiel, xa = cx_e + spiel)
    [Lw, z_wo - z_f + 2 * g_n, Lw > usable ? seams_at(Lw, [[Lc / 2 - xa - 15, Lc / 2 - xa + 15]], 10) : [], [], [[-1e4, -1e4, 1e4, 1e4]], false, 0, []];
module cbox(a, b) translate(a) cube(b - a);
module ct_ring(Lc, zb, h, w, o) translate([-o, -o, zb - o]) difference() {
    cube([Lc + 2 * o, W_ct + 2 * o, h + 2 * o]);
    translate([w, w, -1]) cube([Lc - 2 * w + 2 * o, W_ct - 2 * w + 2 * o, h + 2 * o + 2]);
}
module eck_oval(Lc, zc, h) if (h >= 2) for (x = [0, Lc - cx_e], y = [0, W_ct - cy_e]) {
    translate([x + cx_e / 2, y == 0 ? -1 : W_ct - 0.5, zc]) rotate([-90, 0, 0]) linear_extrude(1.5) hull() for (d = [-1, 1]) translate([d * cx_e * 0.18, 0]) circle(d = h * 0.45, $fn = 16);
    translate([x == 0 ? -1 : Lc - 0.5, y + cy_e / 2, zc]) rotate([0, 90, 0]) linear_extrude(1.5) circle(d = h * 0.45, $fn = 16);
}
// Nuten (Welt), z von zn - tiefe .. zn + 1 (oben offen) bzw. umgekehrt
module ct_nuten(Lc, zn, unten) let(z0 = unten ? zn - g_n - 0.2 : zn - 1, h = g_n + 1.2) {
    for (sy = [0, 1]) translate([cx_e, sy == 0 ? y_s0 - spiel : W_ct - cd - t_cw - spiel, z0]) cube([Lc - 2 * cx_e, t_tg + 2 * spiel, h]);
    if (unten && !ct_steck) {
        translate([-1, cy_e, z0]) cube([cd + t_cw + spiel + 1, W_ct - 2 * cy_e, h]);
        translate([Lc - dt - t_cw - spiel, cy_e, z0]) cube([dt + t_cw + spiel + 1, W_ct - 2 * cy_e, h]);
    }
    if (unten && ct_steck) {   // Quernuten hinter der Rahmenlippe
        translate([ct_lip - spiel, cy_e, z0]) cube([cd + t_cw + 2 * spiel, W_ct - 2 * cy_e, h]);
        translate([Lc - ct_lip - dt - t_cw - spiel, cy_e, z0]) cube([dt + t_cw + 2 * spiel, W_ct - 2 * cy_e, h]);
    }
}
// ---- Boden (einfarbig: Rahmen) ----
module ct_boden(Lc, xs = []) difference() {
    union() {
        ct_ring(Lc, 0, z_f, rb, 0);
        translate([rb - 0.01, rb - 0.01, z_f - t_fl]) cube([Lc - 2 * rb + 0.02, W_ct - 2 * rb + 0.02, t_fl]);
        for (x = [0, Lc - cx_e], y = [0, W_ct - cy_e]) translate([x, y, 0]) cube([cx_e, cy_e, z_f]);
        for (xx = [ct_p_r : ct_p_r : Lc - ct_p_r / 2]) translate([xx - ct_t_r / 2, rb - 0.01, 0]) cube([ct_t_r, W_ct - 2 * rb + 0.02, z_f]);
        for (sx = xs) translate([sx - spw / 2 - 1, rb - 0.01, 0]) cube([spw + 2, W_ct - 2 * rb + 0.02, z_f]);
        if (ct_steck) for (t = [false, true], y = [ct_yp, W_ct - ct_yp]) translate([ct_xp(Lc, t), y, z_f - 0.01]) ct_stift(ct_lp - 0.3 + 0.01);
    }
    ct_nuten(Lc, z_f, true);
}
// ---- Dach: A Dachblech, B Obergurte + Eckbeschläge ----
module ct_dach_b(Lc, o = 0) {
    ct_ring(Lc, H_ct - tr, tr, rb, o);
    for (x = [0, Lc - cx_e], y = [0, W_ct - cy_e]) translate([x - o, y - o, H_ct - hc - o]) cube([cx_e + 2 * o, cy_e + 2 * o, hc + 2 * o]);
}
module ct_dach(Lc, fp, xs = []) {
    module loecher() {
        ct_nuten(Lc, H_ct - tr, false);
        for (x = [in_x, Lc - in_x], y = [in_y, W_ct - in_y]) translate([x, y, H_ct - h_tw - 0.4]) {
            cylinder(r = r_zl, h = h_tw + 1, $fn = 24);
        }
    }
    if (inc(fp, "A")) difference() {
        union() {
            translate([rb, rb, H_ct - tr]) cube([Lc - 2 * rb, W_ct - 2 * rb, tr]);
            if (!ct_zweifarbig) ct_dach_b(Lc);
            for (sx = xs) translate([sx - spw / 2 - 1, y_cs - 1, H_ct - tr - rib_h]) cube([spw + 2, W_ct - 2 * y_cs + 2, rib_h + 0.01]);
            if (ct_mag && ct_mag_z0 < H_ct - tr) for (p = ct_mag_pos(Lc)) translate([p[0], p[1], ct_mag_z0]) cylinder(d = ct_mag_d + 2 * min_wand, h = H_ct - tr - ct_mag_z0 + 0.01, $fn = 48);
        }
        if (ct_zweifarbig) ct_dach_b(Lc, 0.02);
        loecher();
        if (ct_mag) for (p = ct_mag_pos(Lc)) translate([p[0], p[1], ct_mag_z0 - 1]) cylinder(d = ct_mag_d, h = ct_mag_h + 1, $fn = 48);
    }
    if (ct_zweifarbig && inc(fp, "B")) difference() { ct_dach_b(Lc); loecher(); }
}
// ---- Steck-Dach: Containerfarbe, Ecken für die Beschläge der Rahmen ausgespart, Zapfen in die Obergurte ----
module ct_dach_steck(Lc, xs = []) difference() {
    union() {
        translate([0, 0, H_ct - tr]) cube([Lc, W_ct, tr]);
        for (sx = xs) translate([sx - spw / 2 - 1, y_cs - 1, H_ct - tr - rib_h]) cube([spw + 2, W_ct - 2 * y_cs + 2, rib_h + 0.01]);
        if (ct_mag && ct_mag_z0 < H_ct - tr) for (p = ct_mag_pos(Lc)) translate([p[0], p[1], ct_mag_z0]) cylinder(d = ct_mag_d + 2 * min_wand, h = H_ct - tr - ct_mag_z0 + 0.01, $fn = 48);
        for (t = [false, true], y = [W_ct / 4, 3 * W_ct / 4]) translate([ct_xp(Lc, t), y, H_ct - tr + 0.01]) mirror([0, 0, 1]) ct_stift(ct_lr - 0.3 + 0.01);
    }
    for (x = [-1, Lc - cx_e - spiel], y = [-1, W_ct - cy_e - spiel]) translate([x, y, H_ct - tr - 1]) cube([cx_e + spiel + 1, cy_e + spiel + 1, tr + 2]);
    ct_nuten(Lc, H_ct - tr, false);
    if (ct_mag) for (p = ct_mag_pos(Lc)) translate([p[0], p[1], ct_mag_z0 - 1]) cylinder(d = ct_mag_d, h = ct_mag_h + 1, $fn = 48);
}
// ---- Steck-Rahmen (Beschlagfarbe): Eckpfosten mit oberen Eckbeschlägen + Obergurt, Falz von innen ----
module ct_rahmen(Lc, tuer) let(xo = tuer ? Lc - cx_e : 0, px0 = tuer ? xo - 1 : ct_lip, px1 = tuer ? Lc - ct_lip : cx_e + 1) difference() {
    union() {
        for (y = [0, W_ct - cy_e]) translate([xo, y, z_f]) cube([cx_e, cy_e, H_ct - z_f]);
        translate([xo, cy_e - 0.01, z_e1]) cube([cx_e, W_ct - 2 * cy_e + 0.02, H_ct - tr - z_e1]);
    }
    translate([px0, cy_e - ct_rb, z_f - 1]) cube([px1 - px0, W_ct - 2 * cy_e + 2 * ct_rb, z_e1 + ct_rb - z_f + 1]);   // Falz
    for (y = [in_y, W_ct - in_y]) translate([tuer ? Lc - in_x : in_x, y, H_ct - h_tw - 0.4])                       // Koni-Bohrung (liegend: Tropfen)
        linear_extrude(h_tw + 1) rotate(tuer ? 180 : 0) teardrop(r_zl, $fn = 24);
    for (y = [ct_yp, W_ct - ct_yp]) translate([ct_xp(Lc, tuer), y, z_f - 1]) linear_extrude(ct_lp + 1) raute_2d(ct_dp);
    for (y = [W_ct / 4, 3 * W_ct / 4]) translate([ct_xp(Lc, tuer), y, H_ct - tr - ct_lr]) linear_extrude(ct_lr + 1) raute_2d(ct_dp);
}
// ---- Steck-Wände: Stirnwand / Türen um ct_lip nach innen, Ränder im Falz ----
module ct_wand_steck(Lc, tuer) let(es = ct_es) {
    if (!tuer) {
        translate([ct_lip, 0, 0]) ct_stirn_a();
        for (y = [cy_e - ct_rb + es, W_ct - cy_e - 0.01]) translate([ct_lip, y, z_f]) cube([cd + t_cw, ct_rb - es + 0.01, z_e1 + ct_rb - es - z_f]);
        translate([ct_lip, cy_e - ct_rb + es, z_e1 - 0.01]) cube([cd + t_cw, W_ct - 2 * cy_e + 2 * ct_rb - 2 * es, ct_rb - es + 0.01]);
    } else {
        translate([-ct_lip, 0, 0]) ct_tuer_a(Lc);
        for (y = [cy_e - ct_rb + es, W_ct - cy_e - 0.01]) translate([Lc - ct_lip - dt - t_cw, y, z_f]) cube([dt + t_cw, ct_rb - es + 0.01, z_e1 + ct_rb - es - z_f]);
        translate([Lc - ct_lip - dt - t_cw, cy_e - ct_rb + es, z_e1 - 0.01]) cube([dt + t_cw, W_ct - 2 * cy_e + 2 * ct_rb - 2 * es, ct_rb - es + 0.01]);
    }
}
// ---- Seitenwand (y = 0; die zweite ist um 180° gedreht) ----
module ct_seite(Lc) {
    xa = cx_e + spiel; xb = Lc - cx_e - spiel;
    n = floor((Lc - 2 * cx_e) / p_sk); x0 = (Lc - n * p_sk) / 2;
    translate([0, 0, z_f]) linear_extrude(z_wo - z_f) {
        translate([xa, cd]) square([xb - xa, t_cw]);
        for (k = [0 : n - 1]) let(x = x0 + k * p_sk) polygon([[x + 0.1 * p_sk, cd + 0.01], [x + 0.25 * p_sk, 0], [x + 0.6 * p_sk, 0], [x + 0.75 * p_sk, cd + 0.01]]);
    }
    for (z = [z_f - g_n, z_wo - 0.01]) translate([xa, y_s0, z]) cube([xb - xa, t_tg, g_n + 0.01]);
}
// ---- Stirnwand (x = 0) und Türseite (x = Lc): B Pfosten + Obergurt ----
module ct_end_b(Lc, tuer, o = 0) let(xo = tuer ? Lc - cx_e : 0) {
    for (y = [0, W_ct - cy_e]) translate([xo - o, y - o, z_f - o]) cube([cx_e + 2 * o, cy_e + 2 * o, H_ct - hc - z_f + 2 * o]);
    translate([xo - o, -o, z_e1 - o]) cube([cx_e + 2 * o, W_ct + 2 * o, h_tb + 2 * o]);
    translate([xo - o, cy_e + spiel - o, H_ct - hc - 0.01 - o]) cube([cx_e + 2 * o, W_ct - 2 * cy_e - 2 * spiel + 2 * o, hc - tr + 0.01 + 2 * o]);
}
module ct_stirn_a() {
    m = floor((W_ct - 2 * cy_e) / p_sk); y0 = (W_ct - m * p_sk) / 2;
    translate([0, 0, z_f]) linear_extrude(z_e1 - z_f + 0.01) {
        translate([cd, cy_e]) square([t_cw, W_ct - 2 * cy_e]);
        // V-Täler: außen unten gedruckt, keine flachen Decken
        for (k = [0 : m - 1]) let(y = y0 + k * p_sk) polygon([[cd + 0.01, y], [cd + 0.01, y + p_sk], [0, y + p_sk - cd], [0, y + cd]]);
    }
    translate([0, cy_e + spiel, z_f - g_n]) cube([cd + t_cw, W_ct - 2 * cy_e - 2 * spiel, g_n + 0.01]);   // Feder bis außen (liegt beim Druck auf)
}
module ct_tuer_a(Lc) difference() {
    union() {
        translate([Lc - dt - t_cw, cy_e, z_f]) cube([t_cw, W_ct - 2 * cy_e, z_e1 - z_f + 0.01]);
        for (f = [0.15, 0.37, 0.63, 0.85]) translate([Lc - dt - 0.01, f * W_ct - bw_t / 2, z_f]) cube([dt + 0.01, bw_t, z_e1 - z_f + 0.01]);
        translate([Lc - dt - 0.01, W_ct / 2 - bw_t * 0.75, z_f]) cube([dt + 0.01, bw_t * 1.5, z_e1 - z_f + 0.01]);   // Dichtleiste in der Mitte
        for (y = [cy_e, W_ct - cy_e - max(M(0.12), 1.2)], f = [0.15, 0.38, 0.62, 0.85])
            translate([Lc - dt - 0.01, y, z_f + f * (z_e1 - z_f) - max(M(0.05), 0.5)]) cube([dt + 0.01, max(M(0.12), 1.2), max(M(0.1), 1.0)]);
        translate([Lc - dt - t_cw, cy_e + spiel, z_f - g_n]) cube([dt + t_cw, W_ct - 2 * cy_e - 2 * spiel, g_n + 0.01]);   // Schwelle bis außen
    }
    translate([Lc + 0.01 - 0.3, W_ct / 2 - 0.2, z_f + 0.5]) cube([0.3, 0.4, z_e1 - z_f - 1]);   // Fuge zwischen den Flügeln
}
module ct_stirn(Lc, fp, tuer = false) {
    if (!ct_zweifarbig) { if (inc(fp, "A")) { if (tuer) ct_tuer_a(Lc); else ct_stirn_a(); ct_end_b(Lc, tuer); } }
    else {
        if (inc(fp, "A")) difference() { if (tuer) ct_tuer_a(Lc); else ct_stirn_a(); ct_end_b(Lc, tuer, 0.02); }
        if (inc(fp, "B")) ct_end_b(Lc, tuer);
    }
}
// ---- Druck ----
module ct_druck(Lc, nm, fp, stk) {
    if (ct_steck && nm == "boden") split_out(info_boden(Lc), stk) ct_boden(Lc, ct_xs(Lc));   // aufrecht, Zapfen oben
    else if (ct_steck && nm == "dach") split_out(info_dach(Lc), stk) translate([0, W_ct, H_ct]) rotate([180, 0, 0]) ct_dach_steck(Lc, ct_xs(Lc));
    else if (ct_steck && nm == "stirn") multmatrix([[0, 1, 0, 0], [0, 0, 1, -(z_f - g_n)], [1, 0, 0, -ct_lip], [0, 0, 0, 1]]) ct_wand_steck(Lc, false);
    else if (ct_steck && nm == "tuer") multmatrix([[0, -1, 0, W_ct], [0, 0, 1, -(z_f - g_n)], [-1, 0, 0, Lc - ct_lip], [0, 0, 0, 1]]) ct_wand_steck(Lc, true);
    else if (nm == "stirnrahmen") multmatrix([[0, 1, 0, 0], [0, 0, 1, -z_f], [1, 0, 0, 0], [0, 0, 0, 1]]) ct_rahmen(Lc, false);
    else if (nm == "tuerrahmen") multmatrix([[0, -1, 0, W_ct], [0, 0, 1, -z_f], [-1, 0, 0, Lc], [0, 0, 0, 1]]) ct_rahmen(Lc, true);
    else if (nm == "boden") split_out(info_boden(Lc), stk) translate([0, W_ct, z_f]) rotate([180, 0, 0]) ct_boden(Lc, ct_xs(Lc));
    else if (nm == "dach") split_out(info_dach(Lc), stk) translate([0, W_ct, H_ct]) rotate([180, 0, 0]) ct_dach(Lc, fp, ct_xs(Lc));
    else if (nm == "seite") split_out(info_seite(Lc), stk)
        multmatrix([[1, 0, 0, -(cx_e + spiel)], [0, 0, 1, -(z_f - g_n)], [0, -1, 0, cd + t_cw], [0, 0, 0, 1]]) ct_seite(Lc);
    else if (nm == "stirn") multmatrix([[0, 1, 0, 0], [0, 0, 1, -(z_f - g_n)], [1, 0, 0, 0], [0, 0, 0, 1]]) ct_stirn(Lc, fp);
    else if (nm == "tuer") multmatrix([[0, -1, 0, W_ct], [0, 0, 1, -(z_f - g_n)], [-1, 0, 0, Lc], [0, 0, 0, 1]]) ct_stirn(Lc, fp, true);
}
// ---- Zusammenbau (lokal) ----
module ct_welt(Lc, ex = 0) if (ct_steck) {
    translate([0, 0, -ex]) vorschau_farbe(farbe_beschlag) ct_boden(Lc);
    translate([0, 0, ex]) vorschau_farbe(farbe_container) ct_dach_steck(Lc);
    translate([0, -ex, 0]) vorschau_farbe(farbe_container) ct_seite(Lc);
    translate([Lc, W_ct + ex, 0]) rotate([0, 0, 180]) vorschau_farbe(farbe_container) ct_seite(Lc);
    translate([-1.6 * ex, 0, 0]) vorschau_farbe(farbe_beschlag) ct_rahmen(Lc, false);
    translate([-0.6 * ex, 0, 0]) vorschau_farbe(farbe_container) ct_wand_steck(Lc, false);
    translate([1.6 * ex, 0, 0]) vorschau_farbe(farbe_beschlag) ct_rahmen(Lc, true);
    translate([0.6 * ex, 0, 0]) vorschau_farbe(farbe_container) ct_wand_steck(Lc, true);
} else {
    translate([0, 0, -ex]) vorschau_farbe(farbe_beschlag) ct_boden(Lc);
    translate([0, 0, ex]) { vorschau_farbe(farbe_container) ct_dach(Lc, "A"); vorschau_farbe(farbe_beschlag) ct_dach(Lc, "B"); }
    translate([0, -ex, 0]) vorschau_farbe(farbe_container) ct_seite(Lc);
    translate([Lc, W_ct + ex, 0]) rotate([0, 0, 180]) vorschau_farbe(farbe_container) ct_seite(Lc);
    translate([-ex, 0, 0]) { vorschau_farbe(farbe_container) ct_stirn(Lc, "A"); vorschau_farbe(farbe_beschlag) ct_stirn(Lc, "B"); }
    translate([ex, 0, 0]) { vorschau_farbe(farbe_container) ct_stirn(Lc, "A", true); vorschau_farbe(farbe_beschlag) ct_stirn(Lc, "B", true); }
}
CLIPS = clip_count(info_boden(L_c40)) * (len(ct_xs(L_c40)) > 0 ? 1 : 0) + clip_count(info_dach(L_c40)) * (len(ct_xs(L_c40)) > 0 ? 1 : 0)
      + clip_count(info_boden(L_c20)) * (len(ct_xs(L_c20)) > 0 ? 1 : 0) + clip_count(info_dach(L_c20)) * (len(ct_xs(L_c20)) > 0 ? 1 : 0);
