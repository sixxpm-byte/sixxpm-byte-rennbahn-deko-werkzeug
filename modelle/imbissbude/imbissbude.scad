// =====================================================================
//  IMBISSBUDE  –  zerlegbarer Deko-Bausatz für Rennbahnen
//  parametrisch, alle gängigen Maßstäbe, FDM-optimiert (stützfrei)
//  passt zum Stecksystem von rennbahn_deko.scad
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    basis        Bodenplatte mit Pflaster, Wandnut, Küchenzeile     1x
//    wand_vorne   Verkaufswand mit Fenster, Scharnier, Konsolen        1x
//    wand_hinten  Rückwand mit Lüftungsgitter                          1x
//    wand_links / wand_rechts   Seitenwände (Tür / Fenster)            je 1x
//    dach         Dach mit Blende, Nut und Schildlöchern               1x
//    theke        Verkaufstheke (sitzt auf der Fensterbrüstung)        1x
//    klappe       Verkaufsklappe, beweglich (Stift = Filament)         1x
//    stuetzen     2 Klappenstützen                                     1x
//    schild       Dachschild mit eigenem Text (2-farbig möglich)       1x
//    zubehoer     Stehtische, Mülltonne, Gasflaschen, Getränkekisten
//    verbinder    Clips für geteilte Teile / Anschluss an die Strecke
//
//  MONTAGE
//    1. Wände in die Nut der Bodenplatte stellen (vorne/hinten außen,
//       Seitenwände dazwischen).
//    2. Theke durch das Fenster schieben und auf die Brüstung setzen.
//    3. Dach aufsetzen – es hält alle Wände.
//    4. Schild in die Dachlöcher stecken.
//    5. Klappe an die Scharnieraugen halten, Filament (Ø stift_d)
//       seitlich durchschieben. Stützen in Theke und Klappe stecken.
//
//  DRUCK  (alle Teile werden druckfertig ausgerichtet exportiert)
//    Wände liegend (Außenseite oben), Dach kopfüber, Tisch kopfüber,
//    Klappe mit Außenseite auf dem Bett. Keine Stützen nötig.
//    Zu große Teile werden automatisch geteilt (stueck = 1..n),
//    die Konsole nennt die Anzahl der Stücke und Clips.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, basis:Bodenplatte, wand_vorne:Wand vorne, wand_hinten:Wand hinten, wand_links:Wand links, wand_rechts:Wand rechts, dach:Dach, theke:Theke, klappe:Verkaufsklappe, stuetzen:Klappenstützen, schild:Dachschild, zubehoer:Zubehör, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Schild: A = Tafel, B = Schrift und Rand
farbteil = "alle"; // [alle, A, B]
// Klappenwinkel in der Vorschau (0 = Stützenwinkel)
klappe_vorschau = 0; // [0:110]

/* [Imbissbude] */
breite_m = 3.0;
tiefe_m  = 2.2;
hoehe_m  = 2.4;
fassade  = "holz"; // [holz:Holzverschalung, blech:Trapezblech, glatt:Glatt]
tuer     = "links"; // [links, rechts]
innenausstattung = true;
speisekarten = true;
pflaster = true;
schild_text = "IMBISS";
schild_hoehe_m = 0.6;
schild_font = "Liberation Sans:style=Bold";

/* [Verkaufsklappe] */
// Öffnungswinkel, für den die Stützen gebaut werden (0 = automatisch)
klappe_winkel = 0; // [0:110]
scharniere = 2; // [1:4]
// Stift-Ø (1.75 = Filament, kleiner = Draht)
stift_d = 1.75;
scharnier_spiel = 0.2;

/* [Zubehör] */
stehtische = 2;   // [0:6]
muelltonnen = 1;  // [0:4]
gasflaschen = 2;  // [0:6]
kistenstapel = 1; // [0:4]
// Clips auf der Clip-Platte (0 = so viele wie benötigt)
verbinder_anzahl = 0;

/* [Verbindung & Druck] */
// Taschen in der Bodenplatte für das Rennbahn-Stecksystem
rennbahn_taschen = true;
magnete = false;
magnet_d = 6;
magnet_h = 2;
druckbett = 200;
rand = 5;
spiel = 0.15;

// =====================================================================
//  Grundlagen
// =====================================================================
$fa = 3; $fs = 0.3;
e   = 0.01;
den = massstab == 0 ? eigener_massstab : massstab;
s   = 1 / den;
function sc(mm, mn = 0) = max(mm * s, mn);
function r2(x) = round(x * 100) / 100;
function inc(fp, g) = fp == "alle" || fp == g;
usable = druckbett - 2 * rand;
gap = 0.1;

// Verbinder (identisch mit rennbahn_deko.scad)
function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] : d <= 20 ? [16, 6, 10, 3.2] : d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] : d <= 50 ? [10, 4, 7, 2] : [8, 3.2, 5.6, 1.6];
CT = conn_tab(den);
cL = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];
deck  = 0.8;
clipd = ch + spiel + deck;          // Mindestdicke für eine Clip-Tasche

// ---------------------------------------------------------------------
//  Hauptmaße
// ---------------------------------------------------------------------
W = sc(breite_m * 1000, 20);
D = sc(tiefe_m * 1000, 16);
H = sc(hoehe_m * 1000, 18);
g = max(sc(60), 1.2);                                   // Nuttiefe
gdp = fassade == "glatt" ? 0 : max(min(sc(12), 0.6), 0.3);
f_pitch = fassade == "holz" ? max(sc(140), 1.5) : fassade == "blech" ? max(sc(280), 2.5) : 0;
f_gw    = fassade == "holz" ? max(sc(15), 0.4) : f_pitch * 0.45;
wall_split = W > usable || H + 2 * g > usable || D > usable;
t  = max(sc(60), 1.6, wall_split ? clipd + gdp : 0);   // Wandstärke

// Bodenplatte
m_s = max(sc(400), 4); m_f = max(sc(900), 6); m_b = max(sc(400), 4);
BX = W + 2 * m_s; BY = D + m_f + m_b;
hb = max(sc(150), g + clipd, magnete ? magnet_h + 0.2 + deck : 0);
pp = pflaster ? max(sc(500), 4) : 0;                    // Pflasterraster

// Dach
ov_s = max(sc(200), 2); ov_f = max(sc(600), 4); ov_b = max(sc(150), 2);
tf = max(sc(50), 1.0);  fb = max(sc(180), 1.2);
RX = W + 2 * ov_s; RY = D + ov_f + ov_b;
roof_split = RX > usable || RY > usable;
rt = max(sc(150), g + deck + 0.4, roof_split ? clipd : 0);
z_r0 = hb + H;                                          // Dachunterseite

// Verkaufsfenster & Theke
post_min = max(sc(400), 4);
ww  = min(sc(2000), W - 2 * post_min);
wx0 = (W - ww) / 2; wx1 = wx0 + ww;
v_s = sc(1050, 4);                                      // Brüstung
c_out = max(sc(400), 4); c_in = max(sc(250), 3);
cx0 = wx0 + spiel; cx1 = wx1 - spiel; cw = cx1 - cx0;
theke_split = cw > usable || c_out + t + c_in > usable;
tc = max(sc(60), 2.0, theke_split ? clipd + 0.4 : 0);
gd_c = tc * 0.5;
v_cb = v_s - gd_c; v_ct = v_cb + tc;

// Scharnier & Klappe
sp_h   = scharnier_spiel;
hole_d = stift_d + 2 * sp_h;
kr     = max(hole_d / 2 + 0.8, sc(45));
a_y    = sqrt(2) * kr + sp_h;                           // Achse vor der Wand
ov_k   = max(sc(60), 0.6);
v_t    = min(sc(2100), H - 0.4 - kr - ov_k);            // Fensteroberkante
axis_v = v_t + ov_k;
AX_Y = -a_y; AX_Z = hb + axis_v;
fw  = ww + 2 * ov_k; fx0 = wx0 - ov_k;
L_k = axis_v - v_ct - 0.3;
flap_split = fw > usable || L_k + kr > usable;
tk  = max(sc(40), 1.2, flap_split ? clipd : 0);
Rn  = sqrt(a_y * a_y + kr * kr) + sp_h;
kseg = 2 * scharniere + 1;
segl = fw / kseg;

// Maximaler Öffnungswinkel (Klappe darf die Dachblende nicht berühren)
function fascia_ok(a) =
    let(dd = ((ov_f - tf) - a_y - kr * cos(a)) / sin(a),
        zz = AX_Z + kr * sin(a) - dd * cos(a))
    dd > L_k || zz < z_r0 - fb - 0.3;
a_max = max(concat([30], [for (a = [30 : 1 : 115]) if (fascia_ok(a)) a]));
a_d   = klappe_winkel > 0 ? min(klappe_winkel, a_max) : min(75, a_max - 3);
a_v   = klappe_vorschau > 0 ? min(klappe_vorschau, a_max) : a_d;

// Stützen
yb_l = -kr + tk;                    // Innenseite Klappe (lokal)
hbst = max(sc(40), 1.6);            // Aufnahme-Höhe
lp   = max(sc(30), 1.2);            // Zapfenlänge
sr   = max(sc(50), 1.6);            // Stützenquerschnitt
sq   = max(sr * 0.6, 1.0);          // Zapfenquerschnitt
bs   = sq + 2 * spiel + 2 * max(0.8, sc(20));
y1   = -0.6 * c_out;
ybt  = yb_l + hbst;
d_p  = min(0.88 * L_k, max(0.35 * L_k, (-a_y + ybt * cos(a_d) + 0.6 * c_out) / sin(a_d)));
xp   = [wx0 + 0.15 * ww, wx1 - 0.15 * ww];
function rotx(p, a) = [p[0], p[1] * cos(a) + p[2] * sin(a), -p[1] * sin(a) + p[2] * cos(a)];
function P1(x) = [x, y1, hb + v_ct];
function P2(x) = [x, AX_Y, AX_Z] + rotx([0, ybt, -d_p], a_d);
PV = P2(0) - P1(0);
Lr = norm(PV);
PU = PV / Lr;

// Schild
sw = min(W * 0.85, sc(2600));
sh = sc(schild_hoehe_m * 1000, 6);
sign_split = sw > usable;
st = max(sc(60), 1.6, sign_split ? clipd : 0);
pw = max(sc(100), 2.0);
pl = min(rt - 0.6, max(sc(100), 1.5));
y_s = max(sc(400), t + st + 1);
xs0 = (W - sw) / 2;
spx = [0.15 * sw, 0.85 * sw];
s_bd = max(sc(40), 0.8);
s_te = max(sc(15), 0.4);
s_ts = min(sh * 0.55, (sw - 4 * s_bd) / max(1, len(schild_text) * 0.68));

// Seitenwände: Tür und Fenster
tuer_wand    = tuer == "links" ? "links" : "rechts";
fenster_wand = tuer == "links" ? "rechts" : "links";
LS = D - 2 * t;
dw  = min(sc(800), LS * 0.4); dh = min(sc(2000), H - sc(250));
du0 = (tuer_wand == "links" ? 0.3 : 0.7) * LS - dw / 2;
fw2 = min(sc(800), LS * 0.4); fh2 = min(sc(700), H * 0.3);
fv0 = min(sc(1100), H - fh2 - sc(300)); fu0 = LS / 2 - fw2 / 2;

// Fassaden-Details
dm   = max(sc(15), 0.3);            // Relief
fwid = max(sc(60), 0.8);            // Rahmenbreite

// =====================================================================
//  Hilfsgeometrie
// =====================================================================
module teardrop(r) { hull() { circle(r = r); translate([r * sqrt(2) - 0.01, 0]) square(0.02, center = true); } }
module bowtie_2d() {
    polygon([[-cL / 2, -cw1 / 2], [0, -cw0 / 2], [cL / 2, -cw1 / 2],
             [cL / 2, cw1 / 2], [0, cw0 / 2], [-cL / 2, cw1 / 2]]);
}
module clip() linear_extrude(ch) bowtie_2d();
module clip_cut(rot, top, zt) {
    rotate([0, 0, rot]) {
        if (top) translate([0, 0, zt - ch - spiel]) linear_extrude(ch + spiel + 1) offset(delta = spiel) bowtie_2d();
        else {
            translate([0, 0, -1]) linear_extrude(ch + spiel + 1) offset(delta = spiel) bowtie_2d();
            translate([0, 0, -1]) linear_extrude(1.3) offset(delta = spiel + 0.3) bowtie_2d();
        }
    }
}
// Rennbahn-Tasche (schmal an der Kante)
module rb_slot() {
    w0 = cw0 / 2 + spiel; w1 = cw1 / 2 + spiel; l = cL / 2 + spiel;
    translate([0, 0, -e]) linear_extrude(ch + spiel + e) polygon([[-1, -w0], [0, -w0], [l, -w1], [l, w1], [0, w0], [-1, w0]]);
    translate([0, 0, -e]) linear_extrude(0.3 + e) offset(delta = 0.3) polygon([[-1, -w0], [0, -w0], [l, -w1], [l, w1], [0, w0], [-1, w0]]);
}
module align(u) rotate([0, acos(u[2]), atan2(u[1], u[0])]) children();
module ring_2d() {
    difference() {
        offset(delta = spiel) square([W, D]);
        translate([t, t]) offset(delta = -spiel) square([W - 2 * t, D - 2 * t]);
    }
}

// =====================================================================
//  Automatische Teilung mit Clips
// =====================================================================
function band_a(l, i) = i == 0 ? 0 : l[i - 1];
function band_b(l, i, S) = i >= len(l) ? S : l[i];
function rect_hit(r, k) = !(r[2] <= k[0] || r[0] >= k[2] || r[3] <= k[1] || r[1] >= k[3]);
function free(r, kp) = len([for (k = kp) if (rect_hit(r, k)) 1]) == 0;
function pick(l, sep, last = -1e9, i = 0) = i >= len(l) ? [] :
    l[i] - last >= sep ? concat([l[i]], pick(l, sep, l[i], i + 1)) : pick(l, sep, last, i + 1);
function clips_v(sx, a, b, kp) = let(m = cL / 2 + 1.5,
    ok = [for (y = [a + m : cw1 + 1 : b - m])
          if (free([sx - cL / 2 - 1, y - cw1 / 2 - 1, sx + cL / 2 + 1, y + cw1 / 2 + 1], kp)) y])
    pick(ok, max(25, 3 * cw1));
function clips_h(sy, a, b, kp) = let(m = cL / 2 + 1.5,
    ok = [for (x = [a + m : cw1 + 1 : b - m])
          if (free([x - cw1 / 2 - 1, sy - cL / 2 - 1, x + cw1 / 2 + 1, sy + cL / 2 + 1], kp)) x])
    pick(ok, max(25, 3 * cw1));
function seams(S, p) = let(n = max(1, ceil(S / usable)))
    [for (k = [1 : 1 : n - 1]) p > 0 ? round(k * S / n / p) * p : k * S / n];
function lsum(l, i = 0) = i >= len(l) ? 0 : l[i] + lsum(l, i + 1);
function zero_seams(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4])
    len([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) if (len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp)) == 0) 1]) +
    len([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) if (len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp)) == 0) 1]);
function n_pieces(info) = (len(info[2]) + 1) * (len(info[3]) + 1);
function clip_count(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4])
    lsum([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp))]) +
    lsum([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp))]);

// info = [SX, SY, Nähte x, Nähte y, Sperrflächen, Taschen von oben?, Oberkante]
module split_out(info, stk) {
    SX = info[0]; SY = info[1]; xs = info[2]; ys = info[3]; kp = info[4]; top = info[5]; zt = info[6];
    nx = len(xs) + 1; ny = len(ys) + 1;
    if (nx * ny == 1) children();
    else for (ix = [0 : nx - 1], iy = [0 : ny - 1]) {
        idx = iy * nx + ix + 1;
        xa = band_a(xs, ix); xb = band_b(xs, ix, SX);
        ya = band_a(ys, iy); yb = band_b(ys, iy, SY);
        bx0 = ix == 0 ? -500 : xa + gap;  bx1 = ix == nx - 1 ? SX + 500 : xb - gap;
        by0 = iy == 0 ? -500 : ya + gap;  by1 = iy == ny - 1 ? SY + 500 : yb - gap;
        if (stk == 0 || stk == idx)
            translate(stk == 0 ? [ix * 8, iy * 8, 0] : [-xa, -ya, 0])
            difference() {
                intersection() {
                    children();
                    translate([bx0, by0, -500]) cube([bx1 - bx0, by1 - by0, 1000]);
                }
                if (ix > 0)      for (y = clips_v(xa, ya, yb, kp)) translate([xa, y, 0]) clip_cut(0, top, zt);
                if (ix < nx - 1) for (y = clips_v(xb, ya, yb, kp)) translate([xb, y, 0]) clip_cut(0, top, zt);
                if (iy > 0)      for (x = clips_h(ya, xa, xb, kp)) translate([x, ya, 0]) clip_cut(90, top, zt);
                if (iy < ny - 1) for (x = clips_h(yb, xa, xb, kp)) translate([x, yb, 0]) clip_cut(90, top, zt);
            }
    }
}

// =====================================================================
//  BODENPLATTE
// =====================================================================
rb_pos = [[-m_s, D / 2, 0], [W + m_s, D / 2, 180], [W / 2, -m_f, 90], [W / 2, D + m_b, -90]];
mag_pos = [[W * 0.25, D * 0.3], [W * 0.75, D * 0.3], [W * 0.25, D * 0.7], [W * 0.75, D * 0.7]];

module kueche() {
    kd = min(sc(600), LS * 0.35); kh = sc(900, 3); kl = (W - 2 * t) * 0.6;
    kx0 = tuer == "links" ? W - t - spiel - 0.3 - kl : t + spiel + 0.3;
    ky1 = D - t - spiel - 0.3; ky0 = ky1 - kd;
    bd  = max(sc(150), 0.6);
    difference() {
        translate([kx0, ky0, hb - e]) cube([kl, kd, kh + e]);
        for (i = [0, 1]) translate([kx0 + kl * (0.08 + i * 0.22), ky0 + kd * 0.2, hb + kh - bd]) cube([kl * 0.18, kd * 0.6, bd + 1]);
    }
    translate([kx0 + kl * 0.55, ky0 + kd * 0.15, hb + kh - e]) cube([kl * 0.38, kd * 0.7, max(sc(20), 0.4)]);
}

module basis_welt() {
    pd = max(sc(10), 0.3); pwd = max(sc(15), 0.35);
    difference() {
        translate([-m_s, -m_f, 0]) cube([BX, BY, hb]);
        translate([0, 0, hb - g]) linear_extrude(g + 1) ring_2d();
        if (pflaster) translate([-m_s, -m_f, hb - pd]) {
            for (k = [1 : 1 : floor(BX / pp)]) translate([k * pp - pwd / 2, -1, 0]) cube([pwd, BY + 2, pd + 1]);
            for (k = [1 : 1 : floor(BY / pp)]) translate([-1, k * pp - pwd / 2, 0]) cube([BX + 2, pwd, pd + 1]);
        }
        if (rennbahn_taschen) for (p = rb_pos) translate([p[0], p[1], 0]) rotate([0, 0, p[2]]) rb_slot();
        if (magnete) for (p = mag_pos) translate([p[0], p[1], -e]) cylinder(d = magnet_d + 0.2, h = magnet_h + 0.2 + e, $fn = 32);
    }
    if (innenausstattung) kueche();
}
module basis_druck() translate([m_s, m_f, 0]) basis_welt();
function info_basis() = let(
    kp = concat(
        rennbahn_taschen ? [[-1, m_f + D / 2 - cw1, cL, m_f + D / 2 + cw1], [BX - cL, m_f + D / 2 - cw1, BX + 1, m_f + D / 2 + cw1],
                            [m_s + W / 2 - cw1, -1, m_s + W / 2 + cw1, cL], [m_s + W / 2 - cw1, BY - cL, m_s + W / 2 + cw1, BY + 1]] : [],
        magnete ? [for (p = mag_pos) [p[0] + m_s - magnet_d, p[1] + m_f - magnet_d, p[0] + m_s + magnet_d, p[1] + m_f + magnet_d]] : []))
    [BX, BY, seams(BX, pp), seams(BY, pp), kp, false, 0];

// =====================================================================
//  WÄNDE  (lokal: u = Länge, v = Höhe ab Boden, w = Dicke, außen = t)
// =====================================================================
function wlen(k) = (k == "vorne" || k == "hinten") ? W : LS;
function openings(k) =
    k == "vorne" ? [[wx0, v_s, wx1, v_t]] :
    k == fenster_wand ? [[fu0, fv0, fu0 + fw2, fv0 + fh2]] : [];

module raised(u0, v0, u1, v1, h = dm) translate([u0, v0, t - e]) cube([u1 - u0, v1 - v0, h + e]);

module wand_scharnier() {
    difference() {
        for (i = [0 : 2 : kseg - 1])
            translate([fx0 + i * segl + sp_h / 2, 0, 0]) rotate([90, 0, 90]) linear_extrude(segl - sp_h) hull() {
                translate([axis_v, t + a_y]) circle(r = kr);
                translate([axis_v - kr, t - e]) square([2 * kr, e]);
            }
        translate([fx0 - 1, 0, 0]) rotate([90, 0, 90]) linear_extrude(fw + 2)
            translate([axis_v, t + a_y]) rotate(90) teardrop(hole_d / 2);
    }
}

module wand_details(k) {
    len = wlen(k);
    if (k == "vorne" || k == "hinten") {               // Eckleisten
        raised(0, 0, fwid * 1.3, H);
        raised(len - fwid * 1.3, 0, len, H);
    }
    if (k == "vorne") {
        // Fensterrahmen (unten liegt die Theke)
        raised(wx0 - fwid, v_s, wx0, v_t + fwid);
        raised(wx1, v_s, wx1 + fwid, v_t + fwid);
        raised(wx0 - fwid, v_t, wx1 + fwid, v_t + fwid);
        // Konsolen unter der Theke
        co = c_out * 0.8; ft = max(sc(50), 1.0);
        for (x = [cx0 + sc(150, 1), cx1 - sc(150, 1) - ft])
            translate([x, 0, 0]) rotate([90, 0, 90]) linear_extrude(ft)
                polygon([[v_cb, t - e], [v_cb, t + co], [v_cb - co, t - e]]);
        // Speisekarten
        if (speisekarten) {
            avail = wx0 - fwid - fwid * 1.3;
            bw = min(sc(350), avail * 0.75); bh = min(sc(500), bw * 1.5);
            for (uc = [fwid * 1.3 + avail / 2, W - fwid * 1.3 - avail / 2]) {
                vc = v_s + (v_t - v_s) * 0.55;
                raised(uc - bw / 2, vc - bh / 2, uc + bw / 2, vc + bh / 2, dm * 1.5);
                for (j = [1 : 4]) raised(uc - bw * 0.35, vc + bh / 2 - j * bh / 5 - dm / 2, uc + bw * 0.35, vc + bh / 2 - j * bh / 5 + dm / 2, dm * 2.5);
            }
        }
        wand_scharnier();
    }
    if (k == fenster_wand) {
        raised(fu0 - fwid, fv0 - fwid, fu0 + fw2 + fwid, fv0 + fh2 + fwid);
        raised(fu0 - fwid * 1.5, fv0 - fwid * 1.6, fu0 + fw2 + fwid * 1.5, fv0 - fwid * 0.6, dm * 3);
    }
    if (k == tuer_wand)                                 // Türgriff
        raised(du0 + dw - sc(150, 1.0), sc(1050), du0 + dw - sc(150, 1.0) + sc(40, 0.6), sc(1050) + sc(160, 1.4), dm * 2.5);
}

module wand_local(k) {
    len = wlen(k);
    difference() {
        union() {
            cube([len, H, t]);
            translate([0, -(g - spiel), 0]) cube([len, g - spiel + e, t]);
            translate([0, H - e, 0]) cube([len, g - spiel + e, t]);
        }
        if (f_pitch > 0) {
            trim = (k == "vorne" || k == "hinten") ? fwid * 1.3 + f_gw : 0;
            for (j = [1 : 1 : floor(len / f_pitch - 0.01)])
                if (j * f_pitch > trim && j * f_pitch < len - trim)
                    translate([j * f_pitch - f_gw / 2, 0, t - gdp]) cube([f_gw, H, gdp + 1]);
        }
        for (o = openings(k)) translate([o[0], o[1], -1]) cube([o[2] - o[0], o[3] - o[1], t + 2]);
        if (k == tuer_wand) {                           // Türfuge
            fg = max(sc(25), 0.4); fd = max(min(gdp + 0.2, t * 0.35), 0.3);
            translate([0, 0, t - fd]) difference() {
                translate([du0 - fg, -1, 0]) cube([dw + 2 * fg, dh + fg + 1, fd + 1]);
                translate([du0, -2, -1]) cube([dw, dh + 2, fd + 3]);
            }
        }
        if (k == "hinten") {                            // Lüftungsgitter
            sl = min(sc(600), W * 0.25); sh2 = max(sc(30), 0.5); sd = max(min(t * 0.4, sc(30)), 0.3);
            for (j = [0 : 4]) translate([W * 0.7 - sl / 2, H * 0.78 + j * sh2 * 2, t - sd]) cube([sl, sh2, sd + 1]);
        }
    }
    wand_details(k);
}

module wand_welt(k) {
    if (k == "vorne")       translate([0, t, hb]) rotate([90, 0, 0]) wand_local(k);
    else if (k == "hinten") translate([W, D - t, hb]) rotate([90, 0, 180]) wand_local(k);
    else if (k == "links")  translate([t, D - t, hb]) rotate([90, 0, -90]) wand_local(k);
    else                    translate([W - t, t, hb]) rotate([90, 0, 90]) wand_local(k);
}
module wand_druck(k) translate([0, g, 0]) wand_local(k);
function info_wand(k) = let(len = wlen(k), SY = H + 2 * g,
    kp = concat([for (o = openings(k)) [o[0] - 1, o[1] + g - 1, o[2] + 1, o[3] + g + 1]],
                [[-1, -1, len + 1, g + 1.5], [-1, H + g - 1.5, len + 1, SY + 1]]))
    [len, SY, seams(len, f_pitch), seams(SY, 0), kp, false, 0];

// =====================================================================
//  DACH  (kopfüber gedruckt)
// =====================================================================
module dach_welt() {
    difference() {
        union() {
            translate([-ov_s, -ov_f, z_r0]) cube([RX, RY, rt]);
            translate([0, 0, z_r0 - fb]) linear_extrude(fb + e) difference() {
                translate([-ov_s, -ov_f]) square([RX, RY]);
                translate([-ov_s + tf, -ov_f + tf]) square([RX - 2 * tf, RY - 2 * tf]);
            }
        }
        translate([0, 0, z_r0 - e]) linear_extrude(g + e) ring_2d();
        for (x = spx) translate([xs0 + x - pw / 2 - spiel, y_s - st - spiel, z_r0 + rt - pl - 0.2])
            cube([pw + 2 * spiel, st + 2 * spiel, pl + 1]);
    }
}
module dach_druck() translate([ov_s, D + ov_b, z_r0 + rt]) rotate([180, 0, 0]) dach_welt();
function rp(r) = [r[0] + ov_s, D + ov_b - r[3], r[2] + ov_s, D + ov_b - r[1]];
function info_dach() = let(m = spiel + 1,
    kp = concat(
        [[-1, -1, RX + 1, tf + 1.5], [-1, RY - tf - 1.5, RX + 1, RY + 1], [-1, -1, tf + 1.5, RY + 1], [RX - tf - 1.5, -1, RX + 1, RY + 1]],
        [rp([-m, -m, W + m, t + m]), rp([-m, D - t - m, W + m, D + m]), rp([-m, -m, t + m, D + m]), rp([W - t - m, -m, W + m, D + m])],
        [for (x = spx) rp([xs0 + x - pw / 2 - m, y_s - st - m, xs0 + x + pw / 2 + m, y_s + m])]))
    [RX, RY, seams(RX, 0), seams(RY, 0), kp, true, rt];

// =====================================================================
//  THEKE, KLAPPE, STÜTZEN
// =====================================================================
module stuetzen_loecher() {
    hs = sq + 2 * spiel;
    for (x = xp) {
        translate(P2(x)) align(PU) translate([-hs / 2, -hs / 2, -0.5]) cube([hs, hs, lp + 0.7]);
        translate(P1(x)) align(PU) translate([-hs / 2, -hs / 2, -(lp + 0.2)]) cube([hs, hs, lp + 0.7]);
    }
}

module theke_welt() {
    difference() {
        translate([cx0, -c_out, hb + v_cb]) cube([cw, c_out + t + c_in, tc]);
        translate([cx0 - 1, -spiel, hb + v_cb - 1]) cube([cw + 2, t + 2 * spiel, gd_c + 1]);
        stuetzen_loecher();
    }
}
module theke_druck() translate([-cx0, c_out, -(hb + v_cb)]) theke_welt();
function info_theke() = let(SY = c_out + t + c_in,
    kp = concat([[-1, c_out - spiel - 1, cw + 1, c_out + t + spiel + 1]],
                [for (x = xp) [x - cx0 - sq - 2, y1 + c_out - sq - 2, x - cx0 + sq + 2, y1 + c_out + sq + 2]]))
    [cw, SY, seams(cw, 0), seams(SY, 0), kp, false, 0];

// Klappe lokal: Achse = x-Achse, hängt nach -z, Außenseite bei y = -kr
module klappe_local() {
    difference() {
        union() {
            difference() {
                translate([fx0, -kr, -L_k]) cube([fw, tk, L_k]);
                for (i = [0 : 2 : kseg - 1])
                    translate([fx0 + i * segl - sp_h, 0, 0]) rotate([0, 90, 0]) cylinder(r = Rn, h = segl + 2 * sp_h);
            }
            for (i = [1 : 2 : kseg - 1])
                translate([fx0 + i * segl + sp_h / 2, 0, 0]) rotate([90, 0, 90]) linear_extrude(segl - sp_h) hull() {
                    circle(r = kr);
                    translate([-kr, -kr]) square([e, 2 * kr]);
                }
            for (x = xp) translate([x - bs / 2, yb_l - e, -d_p - bs / 2]) cube([bs, hbst + e, bs]);
        }
        translate([fx0 - 1, 0, 0]) rotate([90, 0, 90]) linear_extrude(fw + 2) teardrop(hole_d / 2);
        rotate([a_d, 0, 0]) translate([0, -AX_Y, -AX_Z]) stuetzen_loecher();
    }
}
module klappe_welt(a) translate([0, AX_Y, AX_Z]) rotate([-a, 0, 0]) klappe_local();
module klappe_druck() translate([-fx0, kr, kr]) rotate([90, 0, 0]) klappe_local();
function info_klappe() = let(SY = L_k + kr,
    kp = concat([[-1, -1, fw + 1, kr + Rn + 1]],
                [for (x = xp) [x - fx0 - bs / 2 - 1, d_p + kr - bs / 2 - 1, x - fx0 + bs / 2 + 1, d_p + kr + bs / 2 + 1]]))
    [fw, SY, seams(fw, 0), seams(SY, 0), kp, true, tk];

// Stütze lokal: Achse +z von P1 (z = 0) bis P2 (z = Lr)
// Stützenkörper an den Enden gekürzt, damit die schräg anliegenden Kanten nicht eintauchen
N2 = rotx([0, 1, 0], a_d);
del1 = sr / sqrt(2) * tan(acos(min(1, abs(PU[2])))) + 0.1;
del2 = sr / sqrt(2) * tan(acos(min(1, abs(PU * N2)))) + 0.1;
module stuetze_local() {
    translate([-sq / 2, -sq / 2, -lp]) cube([sq, sq, lp + del1 + e]);
    translate([-sq / 2, -sr / 2, del1]) cube([sr, sr, Lr - del1 - del2]);
    translate([-sq / 2, -sq / 2, Lr - del2 - e]) cube([sq, sq, lp + del2 + e]);
}
module stuetzen_druck() for (i = [0, 1]) translate([Lr + lp, i * (sr + 3) + sr / 2, sq / 2]) rotate([0, -90, 0]) stuetze_local();

// =====================================================================
//  SCHILD
// =====================================================================
module schild_local(fp) {
    if (inc(fp, "A")) {
        cube([sw, sh, st]);
        for (x = spx) translate([x - pw / 2, -pl, 0]) cube([pw, pl + e, st]);
    }
    if (inc(fp, "B")) translate([0, 0, st - e]) linear_extrude(s_te + e) {
        difference() { square([sw, sh]); translate([s_bd, s_bd]) square([sw - 2 * s_bd, sh - 2 * s_bd]); }
        translate([sw / 2, sh / 2]) text(schild_text, size = s_ts, font = schild_font, halign = "center", valign = "center");
    }
}
module schild_welt(fp) translate([xs0, y_s, z_r0 + rt]) rotate([90, 0, 0]) schild_local(fp);
module schild_druck(fp) translate([0, pl, 0]) schild_local(fp);
function info_schild() = [sw, sh + pl, seams(sw, 0), seams(sh + pl, 0), [[-1, -1, sw + 1, pl + 1.5]], false, 0];

// =====================================================================
//  ZUBEHÖR (aufrecht modelliert)
// =====================================================================
module stehtisch() {
    Ht = sc(1100, 10); rT = sc(400, 3.5); tT = max(sc(30), 0.8);
    rC = max(sc(35), 0.9); rF = sc(250, 2.5); tF = max(sc(25), 0.8);
    cylinder(r = rF, h = tF);
    translate([0, 0, tF - e]) cylinder(r1 = rF, r2 = rC, h = rF - rC);
    cylinder(r = rC, h = Ht);
    translate([0, 0, Ht - tT]) cylinder(r = rT, h = tT);
}
module stehtisch_druck() translate([0, 0, sc(1100, 10)]) rotate([180, 0, 0]) stehtisch();

module muelltonne() {
    bw = sc(580, 4); bd = sc(730, 5); bh = sc(1000, 7); ol = max(sc(30), 0.4); lt = max(sc(40), 0.8); rw = sc(100, 1.0);
    hull() {
        translate([-bw * 0.46, -bd * 0.46, 0]) cube([bw * 0.92, bd * 0.92, e]);
        translate([-bw / 2, -bd / 2, bh - lt - ol]) cube([bw, bd, e]);
    }
    hull() {
        translate([-bw / 2, -bd / 2, bh - lt - ol]) cube([bw, bd, e]);
        translate([-bw / 2 - ol, -bd / 2 - ol, bh - lt]) cube([bw + 2 * ol, bd + 2 * ol, lt]);
    }
    translate([-bw / 2 - ol, bd / 2, bh - lt - sc(80, 0.8)]) cube([bw + 2 * ol, sc(60, 0.8), sc(80, 0.8)]);
    for (sx = [-1, 1]) intersection() {
        translate([sx * (bw / 2 - sc(40)) - sc(30, 0.4) / 2, bd * 0.4, rw]) rotate([0, 90, 0]) cylinder(r = rw, h = max(sc(60), 0.8), center = true);
        translate([-bw, -bd, 0]) cube([2 * bw, 2 * bd, bh]);
    }
}

module gasflasche() {
    r = sc(150, 2); h = sc(580, 6);
    cylinder(r = r * 0.9, h = h * 0.06);
    translate([0, 0, h * 0.05]) cylinder(r = r, h = h * 0.6);
    translate([0, 0, h * 0.65]) scale([1, 1, 0.55]) sphere(r = r);
    translate([0, 0, h * 0.7]) difference() {
        cylinder(r = r * 0.62, h = h * 0.3);
        translate([0, 0, -1]) cylinder(r = r * 0.62 - max(sc(10), 0.5), h = h);
        for (a = [0, 180]) rotate([0, 0, a]) translate([0, -r * 0.2, h * 0.17]) cube([r, r * 0.4, h * 0.08]);
    }
    translate([0, 0, h * 0.7]) cylinder(r = r * 0.2, h = h * 0.22);
}

module kistenstapel() {
    kw = sc(400, 3); kd = sc(300, 2.5); kh = sc(300, 2.5); n = 3;
    gr = max(sc(15), 0.3); hs = max(sc(40), 0.5);
    for (i = [0 : n - 1]) translate([0, 0, i * kh]) difference() {
        translate([-kw / 2, -kd / 2, 0]) cube([kw, kd, kh + (i < n - 1 ? e : 0)]);
        translate([-kw / 2 - 1, -kd / 2 - 1, kh - gr * 1.5]) difference() {
            cube([kw + 2, kd + 2, gr]);
            translate([1 + gr, 1 + gr, -1]) cube([kw - 2 * gr, kd - 2 * gr, gr + 2]);
        }
        for (sx = [-1, 1]) translate([sx * kw / 2 - hs / 2, -kd * 0.2, kh * 0.62]) cube([hs, kd * 0.4, kh * 0.14]);
        if (i == n - 1) translate([-kw / 2 + gr * 2, -kd / 2 + gr * 2, kh * 0.4]) cube([kw - 4 * gr, kd - 4 * gr, kh]);
    }
    bd = max(sc(65), 0.8); nx = max(1, floor((kw - 4 * gr) / (bd * 1.25))); ny = max(1, floor((kd - 4 * gr) / (bd * 1.25)));
    for (i = [0 : nx - 1], j = [0 : ny - 1])
        translate([-(nx - 1) / 2 * bd * 1.25 + i * bd * 1.25, -(ny - 1) / 2 * bd * 1.25 + j * bd * 1.25, (n - 1) * kh + kh * 0.4 - e])
            cylinder(d = bd, h = kh * 0.75, $fn = 12);
}

module zubehoer_druck() {
    dx = max(sc(900), 9);
    items = concat([for (i = [1 : 1 : stehtische]) 0], [for (i = [1 : 1 : muelltonnen]) 1],
                   [for (i = [1 : 1 : gasflaschen]) 2], [for (i = [1 : 1 : kistenstapel]) 3]);
    nx = max(1, ceil(sqrt(len(items))));
    for (i = [0 : 1 : len(items) - 1]) translate([(i % nx) * dx, floor(i / nx) * dx, 0]) {
        if (items[i] == 0) stehtisch_druck();
        if (items[i] == 1) muelltonne();
        if (items[i] == 2) gasflasche();
        if (items[i] == 3) kistenstapel();
    }
}

// =====================================================================
//  Zusammenbau
// =====================================================================
C_BASIS = "#a7a39b"; C_DACH = "#5b5f63"; C_THEKE = "#d8d2c4"; C_KUECHE = "#c9cdd2";
C_WAND  = fassade == "holz" ? "#b07a45" : fassade == "blech" ? "#3f6f9c" : "#e6dfcc";
C_KLAPPE = "#c0392b"; C_A = "#f4f1ea"; C_B = "#c0392b";

module bude(a, ex = 0) {
    color(C_BASIS) translate([0, 0, -ex]) basis_welt();
    color(C_WAND) {
        translate([0, -ex, 0]) wand_welt("vorne");
        translate([0, ex, 0])  wand_welt("hinten");
        translate([-ex, 0, 0]) wand_welt("links");
        translate([ex, 0, 0])  wand_welt("rechts");
    }
    color(C_DACH) translate([0, 0, 1.6 * ex]) dach_welt();
    translate([0, 0, 2.2 * ex]) { color(C_A) schild_welt("A"); color(C_B) schild_welt("B"); }
    color(C_THEKE) translate([0, -1.6 * ex, 0]) theke_welt();
    translate([0, -2.2 * ex, 0]) {
        color(C_KLAPPE) klappe_welt(a);
        if (abs(a - a_d) < 0.5) color("#9aa0a6") for (x = xp) translate(P1(x)) align(PU) stuetze_local();
    }
    if (ex == 0) translate([0, 0, hb]) {
        if (stehtische > 0) for (i = [0 : stehtische - 1])
            color("#7b5b3a") translate([W * 0.25 + W * 0.75 * (i + 0.5) / stehtische, -m_f * 0.6, 0]) stehtisch();
        if (muelltonnen > 0) for (i = [0 : muelltonnen - 1])
            color("#2e6b3a") translate([-m_s + sc(290, 2) + 0.3 + i * sc(650, 6), -m_f + sc(365, 2.5) + 0.3, 0]) muelltonne();
        if (gasflaschen > 0) for (i = [0 : gasflaschen - 1])
            color("#d4a017") translate([W * 0.85 - i * sc(380, 4.5), D + m_b * 0.5, 0]) gasflasche();
        if (kistenstapel > 0) for (i = [0 : kistenstapel - 1])
            color("#1f4e9c") translate([W + m_s * 0.5, D * 0.6 - i * sc(450, 4), 0]) rotate([0, 0, 90]) kistenstapel();
    }
}

// =====================================================================
//  Ausgabe & Info
// =====================================================================
INFOS = [["basis", info_basis()], ["wand_vorne", info_wand("vorne")], ["wand_hinten", info_wand("hinten")],
         ["wand_links", info_wand("links")], ["wand_rechts", info_wand("rechts")], ["dach", info_dach()],
         ["theke", info_theke()], ["klappe", info_klappe()], ["schild", info_schild()]];
CLIPS = lsum([for (i = INFOS) clip_count(i[1])]);
function info_of(n) = [for (i = INFOS) if (i[0] == n) i[1]][0];

echo(str("Imbissbude 1:", den, " | Außenmaß ", r2(W), " × ", r2(D), " mm, Höhe gesamt ", r2(z_r0 + rt + sh), " mm"));
echo(str("Bodenplatte ", r2(BX), " × ", r2(BY), " mm | Wandstärke ", r2(t), " mm"));
echo(str("Klappe: Stift Ø ", stift_d, " mm × ", r2(fw), " mm | Stützenwinkel ", a_d, "° (max. ", a_max, "°) | Stützenlänge ", r2(Lr), " mm"));
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
if (CLIPS > 0) echo(str("Verbinder-Clips gesamt: ", CLIPS, " (teil = verbinder)"));

if (teil == "aufbau") bude(a_v);
else if (teil == "explosion") bude(0, max(sc(600), 10));
else if (teil == "basis") split_out(info_of("basis"), stueck) basis_druck();
else if (teil == "dach") split_out(info_of("dach"), stueck) dach_druck();
else if (teil == "theke") split_out(info_of("theke"), stueck) theke_druck();
else if (teil == "klappe") split_out(info_of("klappe"), stueck) klappe_druck();
else if (teil == "schild") split_out(info_of("schild"), stueck) schild_druck(farbteil);
else if (teil == "stuetzen") stuetzen_druck();
else if (teil == "zubehoer") zubehoer_druck();
else if (teil == "verbinder") {
    n = verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4);
    nx = ceil(sqrt(n));
    for (i = [0 : n - 1]) translate([(i % nx) * (cL + 3), floor(i / nx) * (cw1 + 3), 0]) clip();
}
else for (k = ["vorne", "hinten", "links", "rechts"])
    if (teil == str("wand_", k)) split_out(info_of(teil), stueck) wand_druck(k);
