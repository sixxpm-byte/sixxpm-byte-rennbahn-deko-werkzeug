// gemeinsame Hilfen für die Anleitungsbilder
module pfeil(p, q, d = 2) {
    v = q - p; L = norm(v);
    if (L > 0.01) color("#e2231a") translate(p) {
        b = acos(v[2] / L); c = atan2(v[1], v[0]);
        rotate([0, b, c]) { cylinder(d = d, h = max(0.01, L - 3 * d), $fn = 16); translate([0, 0, L - 3 * d]) cylinder(d1 = 2.6 * d, d2 = 0, h = 3 * d, $fn = 20); }
    }
}
// Teil im Schritt verschieben (ex = 0/1) und Pfeil von der verschobenen Lage zur Endlage
module rein(v, ex, a = [0, 0, 0], d = 2) {
    translate(ex * v) children();
    if (ex > 0) pfeil(a + v * 0.85, a + v * 0.2, d);
}
