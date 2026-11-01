// =====================================================================
//  Zerlegbarer 40-Fuß-ISO-Container (Standard oder High Cube)
//  Parametrischer Maßstab, bewegliche Flügeltüren (Scharnier mit Stift)
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  BAUTEILE (je eine STL über "part" exportieren):
//    floor       Boden mit Längsträgern, Querträgern, Eckbeschlägen (1x)
//    roof        Dach mit Obergurten und Eckbeschlägen               (1x)
//    side_wall   Seitenwand, Trapezsicken                            (2x)
//    front_wall  Stirnwand mit vorderen Eckpfosten                   (1x)
//    rear_frame  Türrahmen hinten mit Scharnier-Laschen              (1x)
//    door_left / door_right  Türflügel                               (je 1x)
//    pin         Scharnierstift (alternativ 1,75-mm-Filament)        (2x)
//    plate       alle Teile in Druckorientierung
//
//  MONTAGE:
//    1. Stirnwand und Türrahmen mit ihren Zapfen in den Boden stecken.
//    2. Seitenwände in die Nuten des Bodens stellen.
//    3. Türflügel an die Laschen halten, Stift von oben einschieben
//       (Länge siehe Konsole, liegt unten auf dem Boden auf).
//    4. Dach aufsetzen – es hält Wände, Pfosten und Stifte fest.
//
//  DRUCKORIENTIERUNG (in part="plate" bereits so gedreht):
//    Boden kopfüber, Dach normal, Seitenwände/Türen innen nach unten,
//    Stirnwand stehend, Türrahmen mit Innenseite nach unten.
// =====================================================================

/* [Maßstab & Typ] */
// Maßstab 1:x  (z. B. 160 = N, 120 = TT, 87 = H0, 50, 43, 32)
scale_denominator = 87;
// High Cube (9'6") statt Standard (8'6")
high_cube = false;

/* [Ansicht] */
part = "assembly"; // [assembly, exploded, plate, floor, roof, side_wall, front_wall, rear_frame, door_left, door_right, pin]
// Öffnungswinkel der Türen in der Vorschau (0 = zu, max. ca. 180)
door_angle_left = 110;   // [0:180]
door_angle_right = 35;   // [0:180]
// Abstand der Teile in der Explosionsansicht (mm)
explode = 12;

/* [Druck & Passung] */
// Mindest-Wandstärke (mm), gilt unabhängig vom Maßstab
min_wall = 1.2;
// Spiel für Steckverbindungen und Scharnier (mm)
clearance = 0.2;
// Scharnierstift-Durchmesser (1.75 = Filamentstück)
pin_d = 1.75;
// Scharniere pro Tür (bei kleinen Maßstäben ggf. 3)
n_hinges = 4; // [2:6]
// Druckbett-Kantenlänge für Warnhinweis (mm)
bed_size = 250;

/* [Details] */
details = true;
gooseneck_tunnel = true;
container_color = "#2F5F8F";

$fn = 40;

// =====================================================================
//  Abgeleitete Maße
// =====================================================================
s   = 1 / scale_denominator;
function sc(mm, mn = 0) = max(mm * s, mn);
e   = 0.01;
clr = clearance;

L = 12192 * s;                          // 40 ft
W =  2438 * s;                          //  8 ft
H = (high_cube ? 2896 : 2591) * s;      //  9'6" / 8'6"

fh     = sc(160, 2.5);    // Bodenrahmen-Höhe
rh     = sc(130, 2.0);    // Dachrahmen-Höhe
post   = sc(150, 2.4);    // Eckpfosten-Querschnitt
cd     = sc(36, 0.4);     // Sickentiefe Wände
wt     = min_wall;        // Blechstärke Wände
tg     = min(fh, rh) * 0.5;               // Nuttiefe
ps     = post * 0.5;                      // Zapfen-Querschnitt
rail_w = max(sc(162), cd + wt + clr + min_wall);
cl = sc(178); cw = sc(162); ch = sc(118); // Eckbeschlag ISO 1161

// --- Scharnier / Tür ---
hole_d = pin_d + 2 * clr;
kr     = max(hole_d / 2 + 0.8, sc(45));   // Scharnierauge-Radius
dt     = min_wall;                        // Türblech
dtot   = dt + cd;                         // Tür inkl. Sicken
ua     = max(dtot + 0.2, kr);             // Achse vor Tür-Innenseite
va     = kr;                              // Achse vom Seitenrand
gap    = clr + 0.1;                       // Spalt Rahmen <-> Tür
bar_d  = sc(42, 0.8);                     // Verschlussstange
pkg    = max(dtot + bar_d + 0.2, ua + kr);// Bautiefe Tür
x_f    = L - gap - pkg;                   // Rückseite Türrahmen
xa     = x_f + gap + ua;                  // Scharnierachse X
rpy    = max(post, 2 * kr + 0.6);         // hinterer Pfosten (Y)
dz0    = fh + clr;
dz1    = H - rh - clr;
dh     = dz1 - dz0;                       // Türhöhe
seg    = min(max(sc(150), 2.0), dh / (3 * n_hinges) - clr);
bmax   = W / 2 - clr / 2 - va;            // Türbreite ab Achse
bwt    = bmax + va;                       // Türbreite gesamt
R_door = ua + gap - clr;                  // Freischnitt Türkante
Rn     = sqrt(pow(ua + gap, 2) + kr * kr) + clr; // Aussparung für Laschen
pin_len = H - rh - fh - 2 * clr;

function lug_ranges(i) =
    let(zc = dh * (i + 0.5) / n_hinges)
    [[zc - 1.5 * seg - clr, zc - 0.5 * seg - clr],
     [zc + 0.5 * seg + clr, zc + 1.5 * seg + clr]];

// Trapezsicken-Profil: s entlang Wand, t = Tiefe (0 = außen)
function corr_pts(len, pr, d, t) =
    let(n = max(1, round(len / pr)), p = len / n)
    concat([[0, 0]],
           [for (k = [0 : n - 1]) each
               [[k*p + 0.13*p, 0], [k*p + 0.37*p, d],
                [k*p + 0.63*p, d], [k*p + 0.87*p, 0]]],
           [[len, 0], [len, d + t], [0, d + t]]);

module mirror_w(doit) {
    if (doit) translate([0, W, 0]) mirror([0, 1, 0]) children();
    else children();
}

// =====================================================================
//  Gemeinsame Aussparungen Boden/Dach
// =====================================================================
module joints(z0) {
    // Nuten Seitenwände
    for (m = [false, true]) mirror_w(m)
        translate([post, cd - clr, z0]) cube([x_f - 2 * post, wt + 2 * clr, tg + e]);
    // Nut Stirnwand
    translate([cd - clr, post, z0]) cube([wt + 2 * clr, W - 2 * post, tg + e]);
    // Zapfenlöcher vorne / hinten
    for (m = [false, true]) mirror_w(m) {
        translate([post / 2 - ps / 2 - clr, post / 2 - ps / 2 - clr, z0])
            cube([ps + 2 * clr, ps + 2 * clr, tg + e]);
        translate([x_f - post / 2 - ps / 2 - clr, rpy / 2 - ps / 2 - clr, z0])
            cube([ps + 2 * clr, ps + 2 * clr, tg + e]);
    }
}

module casting_holes(top = false) {
    sw = sc(78); sh = sc(63); ow = sc(124); hd = sc(25, 0.4);
    zc = top ? H - min(ch, rh) / 2 : min(ch, fh) / 2;
    if (details && sh >= 0.5)
        for (cx = [0, 1], cy = [0, 1]) {
            px = cx ? L - cl / 2 : cl / 2;
            py = cy ? W - cw / 2 : cw / 2;
            translate([px, cy ? W : 0, zc]) cube([sw, 2 * hd, sh], center = true);
            translate([cx ? L : 0, py, zc]) cube([2 * hd, sh, sh], center = true);
            translate([px, py, top ? H : 0])
                scale([ow, sh, 1]) cylinder(d = 1, h = 2 * hd, center = true, $fn = 24);
        }
}

// =====================================================================
//  BODEN
// =====================================================================
module floor_part() {
    plate_t = max(min_wall, 0.4 * fh);
    rec  = fh - plate_t;
    x0 = cl; x1 = min(L - cl, x_f - post);
    tun_l = 3150 * s; tun_w = 1029 * s;
    cm_w = sc(45, 0.8);
    cm_sp = sc(430, 3);
    difference() {
        union() {
            difference() {
                cube([L, W, fh]);
                if (rec > 0.6)
                    translate([x0, rail_w, -e]) cube([x1 - x0, W - 2 * rail_w, rec + e]);
            }
            if (rec > 0.6) {
                n = floor((x1 - x0) / cm_sp);
                for (k = [1 : n]) {
                    x = x0 + (x1 - x0) * k / (n + 1);
                    difference() {
                        translate([x - cm_w / 2, rail_w - e, rec * 0.3])
                            cube([cm_w, W - 2 * rail_w + 2 * e, rec * 0.7 + e]);
                        if (gooseneck_tunnel && x < tun_l)
                            translate([x - cm_w, W / 2 - tun_w / 2, -1]) cube([2 * cm_w, tun_w, fh]);
                    }
                }
                if (gooseneck_tunnel)
                    for (yy = [W / 2 - tun_w / 2 - cm_w, W / 2 + tun_w / 2])
                        translate([x0 - e, yy, rec * 0.3]) cube([tun_l - x0, cm_w, rec * 0.7 + e]);
            }
        }
        joints(fh - tg);
        casting_holes(false);
    }
}

// =====================================================================
//  DACH
// =====================================================================
module roof_part() {
    rr  = sc(12, 0.25);              // Dachfläche unter Obergurt
    rcd = sc(20, 0.3);               // Dachsicken
    rt  = max(sc(100), cd + wt + clr + min_wall);
    top = H - rr;
    xr0 = cl; xr1 = x_f - post;
    difference() {
        union() {
            translate([0, 0, H - rh]) cube([L, W, top - rcd - (H - rh)]);
            for (y = [0, W - rt]) translate([0, y, H - rh]) cube([L, rt, rh]);
            translate([0, 0, H - rh]) cube([cl, W, rh]);
            translate([xr1, 0, H - rh]) cube([L - xr1, W, rh]);
            // Quersicken
            translate([0, W - rt + e, 0]) rotate([90, 0, 0])
                linear_extrude(W - 2 * rt + 2 * e)
                    polygon([for (p = corr_pts(xr1 - xr0, sc(300), rcd, 0.05))
                             [xr0 + p[0], top - p[1]]]);
        }
        joints(H - rh - e);
        casting_holes(true);
    }
}

// =====================================================================
//  SEITENWAND (links, y ~ 0; rechte Wand = identisches Teil gedreht)
// =====================================================================
sw_x0 = post + clr;
sw_x1 = x_f - post - clr;

module side_wall() {
    zt = H - rh;
    translate([sw_x0, 0, fh]) linear_extrude(zt - fh - clr)
        polygon(corr_pts(sw_x1 - sw_x0, sc(278), cd, wt));
    translate([sw_x0, cd, fh - (tg - clr)]) cube([sw_x1 - sw_x0, wt, tg - clr + e]);
    translate([sw_x0, cd, zt - clr - e])    cube([sw_x1 - sw_x0, wt, tg + e]);
}

// =====================================================================
//  STIRNWAND mit vorderen Eckpfosten
// =====================================================================
module front_wall() {
    zt = H - rh;
    for (y = [0, W - post]) {
        translate([0, y, fh]) cube([post, post, zt - fh]);
        translate([post / 2 - ps / 2, y + post / 2 - ps / 2, fh - (tg - clr)])
            cube([ps, ps, tg - clr + e]);
        translate([post / 2 - ps / 2, y + post / 2 - ps / 2, zt - e])
            cube([ps, ps, tg - clr + e]);
    }
    translate([0, 0, fh]) linear_extrude(zt - fh - clr)
        polygon([for (p = corr_pts(W - 2 * post + 2 * e, sc(278), cd, wt))
                 [p[1], post - e + p[0]]]);
    translate([cd, post, fh - (tg - clr)]) cube([wt, W - 2 * post, tg - clr + e]);
    translate([cd, post, zt - clr - e])    cube([wt, W - 2 * post, tg + e]);
}

// =====================================================================
//  TÜRRAHMEN hinten mit Scharnierlaschen
// =====================================================================
module hinge_lug_2d() {
    difference() {
        hull() {
            circle(r = kr);
            translate([-(ua + gap) - 0.3, -kr]) square([0.3, 2 * kr]);
        }
        circle(d = hole_d);
    }
}

module rear_frame() {
    zt = H - rh;
    hb = sc(150, 1.6);
    for (m = [false, true]) mirror_w(m) {
        translate([x_f - post, 0, fh]) cube([post, rpy, zt - fh]);
        translate([x_f - post / 2 - ps / 2, rpy / 2 - ps / 2, fh - (tg - clr)])
            cube([ps, ps, tg - clr + e]);
        translate([x_f - post / 2 - ps / 2, rpy / 2 - ps / 2, zt - e])
            cube([ps, ps, tg - clr + e]);
        for (i = [0 : n_hinges - 1], zr = lug_ranges(i))
            translate([xa, va, dz0 + zr[0]]) linear_extrude(zr[1] - zr[0]) hinge_lug_2d();
    }
    // Querriegel oben/unten (verdeckt hinter den Türen)
    translate([x_f - post, rpy - e, zt - hb]) cube([post, W - 2 * rpy + 2 * e, hb]);
    translate([x_f - post, rpy - e, fh])      cube([post, W - 2 * rpy + 2 * e, hb]);
}

// =====================================================================
//  TÜRFLÜGEL  (lokal: x = nach außen, y = zur Mitte, Achse im Ursprung)
// =====================================================================
module door_panel() {
    a0 = -ua; a1 = -ua + dt; a2 = -ua + dtot;
    fb = sc(60, 0.8);
    nr = 5;
    fh_in = dh - 2 * fb;
    // Grundblech
    translate([a0, -va, 0]) cube([dt, bwt, dh]);
    // umlaufender Rahmen
    translate([a1 - e, -va, 0]) difference() {
        cube([cd + e, bwt, dh]);
        translate([-1, fb, fb]) cube([cd + 2, bwt - 2 * fb, fh_in]);
    }
    // horizontale Sicken
    for (k = [0 : nr - 1])
        translate([a1 - e, -va + fb, fb + fh_in * (2 * k + 1) / (2 * nr + 1)])
            cube([cd + e, bwt - 2 * fb, fh_in / (2 * nr + 1)]);
    // Verschlussstangen mit Führungen, Hebel, Nocken
    if (details) {
        bz0 = fb * 0.5; bz1 = dh - fb * 0.5;
        brh = sc(60, 0.6);
        for (bp = [max(-va + 0.25 * bwt, Rn + bar_d + 0.3), -va + 0.78 * bwt]) {
            translate([a1 - e, bp - bar_d * 0.3, bz0]) cube([cd + e, bar_d * 0.6, bz1 - bz0]);
            translate([a2 + bar_d / 2 - 0.05, bp, bz0]) cylinder(d = bar_d, h = bz1 - bz0, $fn = 16);
            for (zz = [bz0, dh * 0.3, dh * 0.62, bz1 - brh])
                translate([a1 - e, bp - bar_d * 0.9, zz]) cube([cd + bar_d + 0.1, bar_d * 1.8, brh]);
            // Hebel zeigt zum Scharnier (bleibt innerhalb der Türbreite)
            translate([a2, bp - 4 * bar_d, dh * 0.33]) cube([bar_d * 0.8, 4 * bar_d, max(bar_d * 0.7, 0.6)]);
        }
    }
}

module door_keep() {
    union() {
        translate([-50, 0, -1]) cube([100, 1000, dh + 2]);
        translate([0, 0, -1]) cylinder(r = R_door, h = dh + 2);
    }
}

module door_local() {
    difference() {
        union() {
            intersection() {
                difference() {
                    door_panel();
                    for (i = [0 : n_hinges - 1], zr = lug_ranges(i))
                        translate([0, 0, zr[0] - clr]) cylinder(r = Rn, h = zr[1] - zr[0] + 2 * clr);
                }
                door_keep();
            }
            intersection() {
                for (i = [0 : n_hinges - 1])
                    translate([0, 0, dh * (i + 0.5) / n_hinges - seg / 2])
                        linear_extrude(seg) hull() {
                            circle(r = kr);
                            translate([-ua, 0]) square([dt, kr + 1]);
                        }
                door_keep();
            }
        }
        translate([0, 0, -1]) cylinder(d = hole_d, h = dh + 2);
    }
}

module door_world(right = false, ang = 0) {
    mirror_w(right) translate([xa, va, dz0]) rotate([0, 0, -ang]) door_local();
}

module pin_world(right = false) {
    mirror_w(right) translate([xa, va, fh + clr]) cylinder(d = pin_d, h = pin_len, $fn = 16);
}

// =====================================================================
//  Druckorientierungen
// =====================================================================
module print_floor()      translate([0, W, fh]) rotate([180, 0, 0]) floor_part();
module print_roof()       translate([0, 0, -(H - rh)]) roof_part();
module print_side_wall()  translate([-sw_x0, -(fh - tg + clr), cd + wt]) rotate([-90, 0, 0]) side_wall();
module print_front_wall() translate([0, 0, -(fh - tg + clr)]) front_wall();
module print_rear_frame() translate([H - rh + tg - clr, 0, -(x_f - post)]) rotate([0, -90, 0]) rear_frame();
module print_door_left()  translate([dh, va, ua]) rotate([0, -90, 0]) door_local();
module print_door_right() translate([0, bwt, 0]) mirror([0, 1, 0]) print_door_left();
module print_pin()        rotate([0, 90, 0]) translate([-pin_d / 2, 0, 0]) cylinder(d = pin_d, h = pin_len, $fn = 16);

module plate() {
    g = 4;
    swh = (H - rh + tg - clr) - (fh - tg + clr);
    rfl = (H - rh + tg - clr) - (fh - tg + clr);
    print_floor();
    translate([0, W + g, 0]) print_roof();
    translate([0, 2 * (W + g), 0]) print_side_wall();
    translate([0, 2 * (W + g) + swh + g, 0]) print_side_wall();
    y4 = 2 * (W + g) + 2 * (swh + g);
    translate([0, y4, 0]) print_front_wall();
    translate([post + g, y4, 0]) print_rear_frame();
    translate([post + rfl + 2 * g, y4, 0]) print_door_left();
    translate([post + rfl + dh + 3 * g, y4, 0]) print_door_right();
}

// =====================================================================
//  Zusammenbau
// =====================================================================
module assembly(ex = 0) {
    color("#3a3a3a") translate([0, 0, -ex]) floor_part();
    color(container_color) {
        translate([0, 0, ex]) roof_part();
        translate([0, -ex, 0]) side_wall();
        translate([0, ex, 0]) mirror_w(true) side_wall();
        translate([-ex, 0, 0]) front_wall();
    }
    translate([ex, 0, 0]) {
        color(container_color) rear_frame();
        color(container_color) {
            door_world(false, door_angle_left);
            door_world(true, door_angle_right);
        }
        color("silver") { pin_world(false); pin_world(true); }
    }
}

// =====================================================================
//  Info
// =====================================================================
echo(str("Maßstab 1:", scale_denominator, high_cube ? " (High Cube)" : " (Standard)"));
echo(str("Außenmaß L x B x H = ", L, " x ", W, " x ", H, " mm"));
echo(str("Scharnierstift: Ø ", pin_d, " mm, Länge ", pin_len, " mm (2 Stück)"));
echo(str("Scharniersegment: ", seg, " mm, Türhöhe ", dh, " mm"));
if (L > bed_size)
    echo(str("WARNUNG: Boden/Dach/Seitenwand (", L, " mm) länger als Druckbett (", bed_size, " mm)!"));

if      (part == "assembly")   assembly(0);
else if (part == "exploded")   assembly(explode);
else if (part == "plate")      plate();
else if (part == "floor")      print_floor();
else if (part == "roof")       print_roof();
else if (part == "side_wall")  print_side_wall();
else if (part == "front_wall") print_front_wall();
else if (part == "rear_frame") print_rear_frame();
else if (part == "door_left")  print_door_left();
else if (part == "door_right") print_door_right();
else if (part == "pin")        print_pin();
