// =====================================================================
//  CONTAINERBRÜCKE  –  Ship-to-Shore-Kran als zerlegbarer Bausatz
//  parametrisch, alle gängigen Maßstäbe, FDM-optimiert (stützfrei),
//  Teile über dem Druckbett werden automatisch geteilt (Clips)
//  Stecksystem kompatibel zu rennbahn_deko.scad
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)                                       Anzahl
//    portalrahmen     A-förmiger Seitenrahmen (Beine+Mast)      2x
//    konsole          Trägerkonsole (trägt die Brückenträger)    4x
//    traeger_links / traeger_rechts    Brückenträger            je 1x
//    ausleger_links / ausleger_rechts  klappbarer Ausleger      je 1x
//    mastriegel       Verbindung der Mastspitzen                 1x
//    endriegel        Verbindung der Trägerenden (landseitig)    1x
//    spitzenriegel    Verbindung der Auslegerspitzen             1x
//    katze            Laufkatze (fährt auf den Trägern)          1x
//    kabine           Fahrerkabine unter der Katze               1x
//    spreader         Spreader, passt auf container_40ft.scad    1x
//    maschinenhaus    Maschinenhaus auf dem Rückausleger         1x
//    fahrwerk         Fahrwerk je Bein                           4x
//    schiene          Kranschiene (Rennbahn-Clips an den Enden)  2x
//    verbinder        Clips für geteilte Teile
//
//  BEWEGLICH
//    * Laufkatze gleitet auf den Trägern bis zur Auslegerspitze.
//    * Spreader hängt an 4 Fäden (Löcher in Katze und Spreader).
//    * Ausleger klappt hoch (Gelenk mit Filament-Stift). Waagerecht
//      liegt er auf einem Anschlag, hochgeklappt hält ein Raststift.
//    * Fahrwerke rollen auf den Schienen.
//    * Abspannungen (Mast -> Ausleger/Träger) als Faden.
//
//  MONTAGE
//    1. Fahrwerke auf die Schienen, Portalrahmen hineinstecken.
//    2. Je zwei Konsolen mit dem Zapfen durch jeden Portalrahmen stecken.
//    3. Mastriegel durch die Mastspitzen stecken.
//    4. Brückenträger in die Kerben der Konsolen setzen
//       (Kreuzverbindung), Endriegel durchstecken.
//    5. Ausleger mit Stift an die Träger hängen, Spitzenriegel stecken.
//    6. Maschinenhaus und Katze auflegen, Kabine unter die Katze,
//       Spreader an Fäden hängen.
//
//  DRUCK: alle Teile druckfertig und stützfrei ausgerichtet.
//    Fachwerke flach, Löcher senkrecht. Geteilte Teile: stueck = 1..n
//    (an jeder Naht sitzt eine massive Stoßplatte mit Clip-Tasche).
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 87; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, portalrahmen:Portalrahmen, konsole:Trägerkonsole, traeger_links:Brückenträger links, traeger_rechts:Brückenträger rechts, ausleger_links:Ausleger links, ausleger_rechts:Ausleger rechts, mastriegel:Mastriegel, endriegel:Endriegel, spitzenriegel:Spitzenriegel, katze:Laufkatze, kabine:Kabine, spreader:Spreader, maschinenhaus:Maschinenhaus, fahrwerk:Fahrwerk, schiene:Kranschiene, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;

/* [Vorschau] */
// Position der Katze (0 = landseitig ... 1 = Auslegerspitze)
katze_pos = 0.8;
// Spreaderhöhe (0 = am Boden ... 1 = ganz oben)
spreader_hoehe = 0.55;
ausleger_hoch = false;
container_zeigen = true;

/* [Containerbrücke (Vorbild in Metern)] */
spurweite_m = 16.0;
// Abstand der beiden Portalrahmen
portal_breite_m = 16.5;
// Abstand der Brückenträger (muss > 12,2 m für 40-Fuß-Container sein)
traeger_abstand_m = 13.8;
traeger_unterkante_m = 24.0;
traeger_hoehe_m = 3.0;
// Ausladung wasserseitig ab Schiene
ausleger_m = 30.0;
// Rückausleger landseitig ab Schiene
rueckausleger_m = 10.0;
// Masthöhe über Trägeroberkante
mast_hoehe_m = 12.0;
portalriegel_m = 11.0;
// Winkel des hochgeklappten Auslegers
hochklappwinkel = 80; // [45:85]
schienen_laenge_m = 30.0;

/* [Druck & Passung] */
druckbett = 220;
rand = 5;
min_wand = 1.2;
spiel = 0.15;
// Stift-Ø (1.75 = Filament)
stift_d = 1.75;
stift_spiel = 0.2;

// =====================================================================
//  Grundlagen
// =====================================================================
$fa = 3; $fs = 0.3;
e   = 0.01;
den = massstab == 0 ? eigener_massstab : massstab;
s   = 1 / den;
function sc(mm, mn = 0) = max(mm * s, mn);
function r2(x) = round(x * 100) / 100;
usable = druckbett - 2 * rand;
gap = 0.1;
cl  = 0.4;

function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] : d <= 20 ? [16, 6, 10, 3.2] : d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] : d <= 50 ? [10, 4, 7, 2] : [8, 3.2, 5.6, 1.6];
CT = conn_tab(den);
cL = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];
deck  = 0.8;
clipd = ch + spiel + deck;
mw    = cw1 / 2 + spiel + min_wand;          // halbe Breite einer Clip-Zone
spw   = cL + 3;                              // Stoßplattenbreite quer zur Naht
hole_d = stift_d + 2 * stift_spiel;
th_d  = max(sc(60), 1.0);                    // Fadenloch

// =====================================================================
//  Maße  (x = Kaikante/Fahrtrichtung, y = land(-) -> wasser(+), z = oben)
// =====================================================================
G   = sc(spurweite_m * 1000, 60);
P   = sc(portal_breite_m * 1000, 60);
ls  = max(sc(1300), 6);                      // Beinbreite (in der Rahmenebene)
t_s = max(sc(900), 4, clipd + 0.4);          // Portalrahmen-Dicke
t_g = max(sc(800), 3.5, clipd + 0.4);        // Träger/Ausleger-Dicke
wk  = max(sc(300), 1.6);                     // Katze: Wand neben dem Träger
Bx  = min(sc(traeger_abstand_m * 1000), P - t_s - t_g - 2 * wk - 2 * max(sc(200), 1));
hgd = max(sc(traeger_hoehe_m * 1000), 10);
zg0 = sc(traeger_unterkante_m * 1000, 40);
zg1 = zg0 + hgd;
dw  = max(sc(250), 1.2);                     // Fachwerkstab
cdg = max(sc(450), 1.8);                     // Gurt

// Fahrwerk
fw_wr = sc(450, 2);  fw_ww = max(sc(250), 2);
fw_z0 = 2 * fw_wr + 0.4;
hbg   = max(sc(1500), fw_z0 + 3);
tn    = min(max(sc(500), 2), hbg - fw_z0 - 0.8);
fw_l  = max(sc(5000), 8 * fw_wr + 6);
fw_b2 = max(fw_ww / 2 + 1.2, ls * 0.3 + spiel + 1.2);

// Querträger (Kreuzverbindung mit den Brückenträgern)
t_c = ls * 0.55;
h_c = max(sc(2500), 10);
dh  = min(h_c * 0.35, hgd * 0.3);
zc1 = zg0 + dh; zc0 = zc1 - h_c;
zt0 = zc0 + h_c * 0.12; zt1 = zc0 + h_c * 0.55;          // Zapfenbereich
X1  = P / 2 + t_s / 2;

// Portalrahmen
z_k  = zg1 + max(sc(800), 4);                // Oberkante senkrechte Beine
h_t  = max(sc(1200), 5);                     // Riegel auf Höhe z_k
y_a  = G / 2 - G * 0.3;                      // Mastspitze
z_a  = zg1 + sc(mast_hoehe_m * 1000, 30);
wa   = ls * 0.8;                             // Mastbein
z_pr = sc(portalriegel_m * 1000, 20);
h_pr = max(sc(1500), 6);
t_m  = max(sc(600), 3);  h_m = max(sc(1300), 6);          // Mastriegel
r_ap = max(h_m * 0.75, t_m + 2 * min_wand + 2 * th_d);

// Träger / Ausleger / Gelenk
y_b  = -G / 2 - sc(rueckausleger_m * 1000, 20);
r_l  = max(hgd * 0.28, 2 * hole_d + 2.4);
Rg   = r_l + cl;
y_h  = G / 2 + max(sc(1500), Rg + t_c);
z_pin = zg1 - r_l;
r_k  = r_l * 0.58;                           // Raststift-Radius
beta = 200;                                  // Rastloch am Träger (Winkel)
y_o  = G / 2 + sc(ausleger_m * 1000, 40);
h_tip = hgd * 0.55;
t_e  = max(sc(600), 3, clipd + 0.4);         // End-/Spitzenriegel
y_e  = y_b + max(sc(700), t_e + 2);
y_sp = y_o - max(sc(1000), t_e + 3);
TH_UP = hochklappwinkel;

// Katze, Kabine, Spreader, Maschinenhaus
k_x  = Bx / 2 + t_g / 2 + wk;                // halbe Katzenbreite
L_k  = max(sc(6000), 20);
cab_l = max(4, min(sc(2500), L_k / 2 - sc(2438) / 2 - max(sc(300), 1)));
dch  = max(sc(400), 1.5);
tkb  = max(sc(700), dch + 1.6, clipd + dch);
h_mk = max(sc(2200), 6);
xs_r = min(sc(5500), Bx / 2 - t_g / 2 - cl - 1.5);
ys_r = max(sc(900), 3);
cab_w = min(sc(2500), (Bx / 2 - t_g / 2 - cl) * 2 - 2); cab_h = min(hgd * 0.9, sc(2800));
sp_L = sc(12192); sp_W = sc(2438); sp_t = max(sc(600), 2.4); sp_b = max(sc(400), 1.8);
cast_x = sp_L / 2 - sc(178) / 2; cast_y = sp_W / 2 - sc(162) / 2;
mh_len = max(sc(7000), 20); mh_h = max(sc(4000), 12);
y_kmin = y_b + mh_len + L_k / 2 + 1;
y_kmax = y_sp - t_e / 2 - L_k / 2 - 1;

// Schiene
bh = max(sc(300), 2.5); rail_h = max(sc(150), 1.2); rail_w = max(sc(100), 1.0);
beam_w = max(2 * fw_b2 + sc(400), 2 * mw + 2);
rail_top = bh + rail_h;

// =====================================================================
//  Hilfen
// =====================================================================
module bar(p, q, w) hull() { translate(p) circle(d = w, $fn = 12); translate(q) circle(d = w, $fn = 12); }
module sbar(p, q, w) hull() { translate(p) square(w, center = true); translate(q) square(w, center = true); }
module box3(x0, y0, z0, x1, y1, z1) translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);
module rect2(r) translate([r[0], r[1]]) square([r[2] - r[0], r[3] - r[1]]);
module bowtie_2d() polygon([[-cL / 2, -cw1 / 2], [0, -cw0 / 2], [cL / 2, -cw1 / 2], [cL / 2, cw1 / 2], [0, cw0 / 2], [-cL / 2, cw1 / 2]]);
module clip() linear_extrude(ch) bowtie_2d();
module clip_cut(rot, top, zt2) {
    rotate([0, 0, rot]) {
        if (top) translate([0, 0, zt2 - ch - spiel]) linear_extrude(ch + spiel + 1) offset(delta = spiel) bowtie_2d();
        else {
            translate([0, 0, -1]) linear_extrude(ch + spiel + 1) offset(delta = spiel) bowtie_2d();
            translate([0, 0, -1]) linear_extrude(1.3) offset(delta = spiel + 0.3) bowtie_2d();
        }
    }
}
module rb_slot() {
    w0 = cw0 / 2 + spiel; w1 = cw1 / 2 + spiel; l = cL / 2 + spiel;
    pts = [[-1, -w0], [0, -w0], [l, -w1], [l, w1], [0, w0], [-1, w0]];
    translate([0, 0, -e]) linear_extrude(ch + spiel + e) polygon(pts);
    translate([0, 0, -e]) linear_extrude(0.3 + e) offset(delta = 0.3) polygon(pts);
}
function rot2(p, c, a) = [c[0] + (p[0] - c[0]) * cos(a) - (p[1] - c[1]) * sin(a), c[1] + (p[0] - c[0]) * sin(a) + (p[1] - c[1]) * cos(a)];

// ---------------------------------------------------------------------
//  Teilung (wie hafenkran.scad): Clips nur in Stoßplatten / tragenden
//  Flächen (solids), nicht in Sperrflächen (keep)
//  info = [SX, SY, Nähte x, Nähte y, keep, von oben?, Oberkante, solids]
// ---------------------------------------------------------------------
function band_a(l, i) = i == 0 ? 0 : l[i - 1];
function band_b(l, i, S) = i >= len(l) ? S : l[i];
function rect_hit(r, k) = !(r[2] <= k[0] || r[0] >= k[2] || r[3] <= k[1] || r[1] >= k[3]);
function free(r, kp) = len([for (k = kp) if (rect_hit(r, k)) 1]) == 0;
function inside(r, S) = len(S) == 0 || len([for (q = S) if (r[0] >= q[0] - 0.01 && r[1] >= q[1] - 0.01 && r[2] <= q[2] + 0.01 && r[3] <= q[3] + 0.01) 1]) > 0;
function okc(r, kp, S) = free(r, kp) && inside(r, S);
function pick(l, sep, last = -1e9, i = 0) = i >= len(l) ? [] :
    l[i] - last >= sep ? concat([l[i]], pick(l, sep, l[i], i + 1)) : pick(l, sep, last, i + 1);
function qsort(l) = len(l) <= 1 ? l : let(p = l[floor(len(l) / 2)])
    concat(qsort([for (x = l) if (x < p) x]), [for (x = l) if (x == p) x], qsort([for (x = l) if (x > p) x]));
mi = cL / 2 + 1.5;
function cand(a, b, tot, S, ax, at) = let(ma = a <= 0 ? mw : mi, mb = b >= tot ? mw : mi)
    qsort(concat([for (v = [a + ma : 0.5 : b - mb]) v],
    [for (q = S) if (q[ax] <= at && q[ax + 2] >= at) let(c = (q[1 - ax] + q[3 - ax]) / 2) if (c >= a + ma && c <= b - mb) c]));
function clips_v(sx, a, b, kp, S, tot) = let(
    ok = [for (y = cand(a, b, tot, S, 0, sx)) if (okc([sx - cL / 2 - 1, y - mw, sx + cL / 2 + 1, y + mw], kp, S)) y])
    pick(ok, max(16, 2 * mw + 2));
function clips_h(sy, a, b, kp, S, tot) = let(
    ok = [for (x = cand(a, b, tot, S, 1, sy)) if (okc([x - mw, sy - cL / 2 - 1, x + mw, sy + cL / 2 + 1], kp, S)) x])
    pick(ok, max(16, 2 * mw + 2));
function lsum(l, i = 0) = i >= len(l) ? 0 : l[i] + lsum(l, i + 1);
function n_pieces(info) = (len(info[2]) + 1) * (len(info[3]) + 1);
function seam_clips(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7])
    concat([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp, S, SY))],
           [for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp, S, SX))]);
function clip_count(info) = lsum(seam_clips(info));
function crosses(S, ax, at, a, b) = len(S) == 0 || len([for (q = S) if (q[ax] < at && q[ax + 2] > at && q[3 - ax] > a && q[1 - ax] < b) 1]) > 0;
function zero_seams(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7])
    len([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) let(a = band_a(ys, iy), b = band_b(ys, iy, SY))
         if (crosses(S, 0, xs[k], a, b) && len(clips_v(xs[k], a, b, kp, S, SY)) == 0) 1]) +
    len([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) let(a = band_a(xs, ix), b = band_b(xs, ix, SX))
         if (crosses(S, 1, ys[k], a, b) && len(clips_h(ys[k], a, b, kp, S, SX)) == 0) 1]);

module split_out(info, stk) {
    SX = info[0]; SY = info[1]; xs = info[2]; ys = info[3]; kp = info[4]; top = info[5]; zt2 = info[6]; S = info[7];
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
                intersection() { children(); translate([bx0, by0, -500]) cube([bx1 - bx0, by1 - by0, 1000]); }
                if (ix > 0)      for (y = clips_v(xa, ya, yb, kp, S, SY)) translate([xa, y, 0]) clip_cut(0, top, zt2);
                if (ix < nx - 1) for (y = clips_v(xb, ya, yb, kp, S, SY)) translate([xb, y, 0]) clip_cut(0, top, zt2);
                if (iy > 0)      for (x = clips_h(ya, xa, xb, kp, S, SX)) translate([x, ya, 0]) clip_cut(90, top, zt2);
                if (iy < ny - 1) for (x = clips_h(yb, xa, xb, kp, S, SX)) translate([x, yb, 0]) clip_cut(90, top, zt2);
            }
    }
}

// Nahtlage wählen: nahe am Ziel, aber außerhalb verbotener Intervalle
function bad_at(v, bads) = len([for (b = bads) if (v > b[0] && v < b[1]) 1]) > 0;
function seam_pick(t, bads, lo, hi, k = 0) =
    k > 4000 ? t :
    let(d = (k % 2 == 0 ? 1 : -1) * floor((k + 1) / 2) * 0.5, v = t + d)
    (v > lo && v < hi && !bad_at(v, bads)) ? v : seam_pick(t, bads, lo, hi, k + 1);
function seams_at(S, bads, margin) = let(n = max(1, ceil(S / usable)))
    [for (k = [1 : 1 : n - 1]) seam_pick(k * S / n, bads, margin, S - margin)];

// Stoßplatten: wo eine Naht einen Hauptstab kreuzt (Stäbe als [p, q, w])
function pads(M, xs, ys) = concat(
    [for (m = M, x = xs) let(p = m[0], q = m[1]) if ((p[0] - x) * (q[0] - x) < 0)
        let(t = (x - p[0]) / (q[0] - p[0]), c = p + t * (q - p), h = max(m[2] / 2 / max(0.2, abs(cos(atan2(q[1] - p[1], q[0] - p[0])))), mw + 0.5))
        [x - spw / 2, c[1] - h, x + spw / 2, c[1] + h]],
    [for (m = M, y = ys) let(p = m[0], q = m[1]) if ((p[1] - y) * (q[1] - y) < 0)
        let(t = (y - p[1]) / (q[1] - p[1]), c = p + t * (q - p), h = max(m[2] / 2 / max(0.2, abs(sin(atan2(q[1] - p[1], q[0] - p[0])))), mw + 0.5))
        [c[0] - h, y - spw / 2, c[0] + h, y + spw / 2]]);
function shift_r(rs, ox, oy) = [for (r = rs) [r[0] + ox, r[1] + oy, r[2] + ox, r[3] + oy]];

module gitter_2d(a0, a1, zb, ztop, w) {
    n = max(2, round((a1 - a0) / max(ztop - zb, 1)));
    for (k = [0 : n - 1]) {
        xa = a0 + k * (a1 - a0) / n; xb = a0 + (k + 1) * (a1 - a0) / n;
        if (k % 2 == 0) bar([xa, zb], [xb, ztop], w); else bar([xa, ztop], [xb, zb], w);
    }
}

// =====================================================================
//  PORTALRAHMEN  (2D in y, z; Dicke t_s in x)
// =====================================================================
PA = [y_a, z_a];
z_mid = (z_pr + h_pr / 2 + z_k - h_t) / 2;   // Zwischenriegel
w_mid = max(cdg * 1.5, sc(700));
PR_M = [   // Hauptstäbe [p, q, w]
    [[-G / 2, hbg], [-G / 2, z_k], ls], [[G / 2, hbg], [G / 2, z_k], ls],
    [[-G / 2, z_k - h_t / 2], [G / 2, z_k - h_t / 2], h_t],
    [[-G / 2, z_pr + h_pr / 2 - cdg / 2], [G / 2, z_pr + h_pr / 2 - cdg / 2], cdg],
    [[-G / 2, z_pr - h_pr / 2 + cdg / 2], [G / 2, z_pr - h_pr / 2 + cdg / 2], cdg],
    [[-G / 2, z_k - wa / 2], PA, wa], [[G / 2, z_k - wa / 2], PA, wa],
    [[-G / 2, z_mid], [G / 2, z_mid], w_mid]];
pr_ymin = -G / 2 - ls / 2; pr_ymax = G / 2 + ls / 2;
pr_zmin = hbg - tn;        pr_zmax = z_a + r_ap;
PR_BADZ = [[zt0 - spw, zt1 + spw], [z_pr - h_pr / 2 - spw, z_pr + h_pr / 2 + spw], [z_k - h_t - spw, z_k + spw], [z_a - r_ap - spw, 1e9], [-1e9, hbg + spw], [z_mid - w_mid / 2 - spw, z_mid + w_mid / 2 + spw]];
PR_BADY = [[-G / 2 - ls / 2 - 1, -G / 2 + ls / 2 + spw], [G / 2 - ls / 2 - spw, G / 2 + ls / 2 + 1], [y_a - r_ap - spw, y_a + r_ap + spw]];
pr_xs = [for (v = seams_at(pr_ymax - pr_ymin, [for (b = PR_BADY) [b[0] - pr_ymin, b[1] - pr_ymin]], spw)) v + pr_ymin];
pr_ys = [for (v = seams_at(pr_zmax - pr_zmin, [for (b = PR_BADZ) [b[0] - pr_zmin, b[1] - pr_zmin]], spw)) v + pr_zmin];
PR_PADS = pads(PR_M, pr_xs, pr_ys);

module portalrahmen_2d() {
    difference() {
        union() {
            for (m = PR_M) sbar(m[0], m[1], m[2]);
            // Fachwerk im Portalriegel und im Mast
            gitter_2d(-G / 2 + ls / 2, G / 2 - ls / 2, z_pr - h_pr / 2 + cdg / 2, z_pr + h_pr / 2 - cdg / 2, dw);
            for (sy = [-1, 1]) bar([sy * (G / 2 - ls / 2), z_pr - h_pr / 2 - h_pr], [sy * (G / 2 - ls / 2 - h_pr), z_pr - h_pr / 2], dw * 1.6);
            for (sy = [-1, 1]) bar([sy * (G / 2 - ls / 2), z_k - h_t], [sy * (G / 2 - ls / 2 - (G - ls) * 0.3), z_pr + h_pr / 2 - cdg / 2], dw * 1.4);
            for (f = [0.35, 0.65]) let(zq = z_k + f * (z_a - z_k))
                bar([-G / 2 + (y_a + G / 2) * f, zq], [G / 2 + (y_a - G / 2) * f, zq], dw * 1.3);
            bar([-G / 2, z_k], [G / 2 + (y_a - G / 2) * 0.35, z_k + 0.35 * (z_a - z_k)], dw * 1.2);
            translate(PA) circle(r = r_ap);
            for (sy = [-1, 1]) translate([sy * G / 2 - ls * 0.3, hbg - tn]) square([ls * 0.6, tn + e]);
            for (r = PR_PADS) rect2(r);
        }
        // Zapfenlöcher Querträger und Mastriegel, Fadenlöcher
        for (sy = [-1, 1]) translate([sy * G / 2 - t_c / 2 - spiel, zt0 - spiel]) square([t_c + 2 * spiel, zt1 - zt0 + 2 * spiel]);
        translate([y_a - t_m / 2 - spiel, z_a - h_m * 0.3 - spiel]) square([t_m + 2 * spiel, h_m * 0.6 + 2 * spiel]);
        for (sy = [-1, 1]) translate([y_a + sy * (t_m / 2 + min_wand + th_d / 2 + 0.3), z_a + h_m * 0.1]) circle(d = th_d);
    }
}
module portalrahmen_welt(sx) translate([sx * P / 2 - t_s / 2, 0, 0]) rotate([90, 0, 90]) linear_extrude(t_s) portalrahmen_2d();
module portalrahmen_druck() linear_extrude(t_s) translate([-pr_ymin, -pr_zmin]) portalrahmen_2d();
function info_portalrahmen() = let(ox = -pr_ymin, oy = -pr_zmin,
    kp = concat([for (sy = [-1, 1]) [sy * G / 2 - t_c / 2 - 1 + ox, zt0 - 1 + oy, sy * G / 2 + t_c / 2 + 1 + ox, zt1 + 1 + oy]],
                [[y_a - r_ap + ox, z_a - r_ap + oy, y_a + r_ap + ox, z_a + r_ap + oy]]))
    [pr_ymax - pr_ymin, pr_zmax - pr_zmin, [for (v = pr_xs) v + ox], [for (v = pr_ys) v + oy], kp, false, 0, shift_r(PR_PADS, ox, oy)];

// =====================================================================
//  KONSOLEN  (2D in x, z; Dicke t_c in y) – tragen die Brückenträger
//  Kurze Kragträger vom Portalrahmen zum Träger, Mitte bleibt frei für
//  Spreader und Container. Kreuzverbindung (Kerbe) mit dem Träger.
// =====================================================================
x_in  = Bx / 2 - t_g / 2 - spiel - min_wand * 1.5;     // Innenkante
x_out = P / 2 - t_s / 2 - spiel;                      // Anlage am Rahmen
module konsole_2d() {   // rechte Seite (x > 0)
    difference() {
        union() {
            hull() {
                translate([x_in, zc1 - dh - cdg * 2]) square([e, dh + cdg * 2]);
                translate([x_out - e, zc0]) square([e, h_c]);
            }
            translate([x_out - e, zt0]) square([t_s + spiel + e, zt1 - zt0]);           // Zapfen durch den Rahmen
        }
        translate([Bx / 2 - t_g / 2 - spiel, zg0]) square([t_g + 2 * spiel, h_c]);      // Kerbe für den Träger
    }
}
module konsole_welt(sx, sy) translate([0, sy * G / 2 + t_c / 2, 0]) rotate([90, 0, 0]) linear_extrude(t_c)
    if (sx > 0) konsole_2d(); else mirror([1, 0]) konsole_2d();
module konsole_druck() linear_extrude(t_c) translate([-x_in, -zc0]) konsole_2d();
function info_konsole() = let(SX = P / 2 + t_s / 2 - x_in) [SX, h_c, [], [], [], false, 0, []];

// =====================================================================
//  BRÜCKENTRÄGER & AUSLEGER  (2D in y, z; Dicke t_g in x)
//  Gelenk als Halbüberlappung: Träger-Auge in der unteren, Ausleger-Auge
//  in der oberen Hälfte (lokal) – beide druckbar ohne Stützen.
// =====================================================================
PIN = [y_h, z_pin];
function gnodes(a, b, p) = let(n = max(1, round((b - a) / p))) [for (k = [0 : n]) a + k * (b - a) / n];
// ---- Träger ----
g_y1 = y_h - Rg;                             // Ende Vollquerschnitt
TR_M = [[[y_b, zg1 - cdg / 2], [g_y1, zg1 - cdg / 2], cdg], [[y_b, zg0 + cdg / 2], [g_y1, zg0 + cdg / 2], cdg]];
tr_bad = [[-G / 2 - t_c - spw - y_b, -G / 2 + t_c + spw - y_b], [G / 2 - t_c - spw - y_b, 1e9], [-1e9, y_e + t_e + spw - y_b]];
tr_xs = [for (v = seams_at(y_h + r_l - y_b, tr_bad, spw)) v + y_b];
TR_PADS = [for (x = tr_xs) [x - spw / 2, zg0, x + spw / 2, zg1]];          // Stoßplatten volle Höhe
module traeger_voll_2d() {
    difference() {
        union() {
            translate([y_b, zg0]) square([y_h - y_b, cdg]);
            translate([y_b, zg1 - cdg]) square([y_h - y_b, cdg]);
            translate([y_b, zg0]) square([max(sc(1000), t_e + 2 * min_wand + 2), hgd]);      // Endschott
            nd = gnodes(y_b + max(sc(1000), 4), g_y1 - hgd * 0.6, hgd);
            for (i = [0 : len(nd) - 2]) bar([nd[i], i % 2 == 0 ? zg0 + cdg / 2 : zg1 - cdg / 2], [nd[i + 1], i % 2 == 0 ? zg1 - cdg / 2 : zg0 + cdg / 2], dw);
            for (q = nd) bar([q, zg0 + cdg / 2], [q, zg1 - cdg / 2], dw * 0.9);
            for (sy = [-1, 1]) translate([sy * G / 2 - t_c / 2 - max(sc(500), 2), zg0]) square([t_c + 2 * max(sc(500), 2), hgd]);   // Knotenbleche über den Querträgern
            translate([g_y1 - hgd * 0.6, zg0]) square([hgd * 0.6 + Rg, hgd]);                     // Gelenkbereich massiv
            for (r = TR_PADS) rect2(r);
        }
        // Gelenkzone (nur das halbe Auge bleibt) und Schwenkraum des Auslegers
        translate(PIN) circle(r = Rg);
        translate([y_h, zg0 - 1]) square([Rg + 1, hgd + 2]);
        for (a = [0 : 4 : TH_UP + 4]) offset(delta = cl) intersection() {
            rotate_ausleger_root(a);
            translate([y_h - 3 * hgd, zg0 - hgd]) square([3 * hgd, 3 * hgd]);
        }
        // Kerben für die Querträger
        for (sy = [-1, 1]) translate([sy * G / 2 - t_c / 2 - spiel, zg0 - 1]) square([t_c + 2 * spiel, dh + spiel + 1]);
        // Endriegel-Loch und Fadenloch
        translate([y_e - t_e / 2 - spiel, zg0 + hgd * 0.3 - spiel]) square([t_e + 2 * spiel, hgd * 0.4 + 2 * spiel]);
        translate([y_b + max(sc(400), 1.5), zg1 - cdg - th_d]) circle(d = th_d);
    }
}
// Ausleger-Wurzel (voller Querschnitt außerhalb Rg), um a gedreht
module rotate_ausleger_root(a) translate(PIN) rotate(a) translate(-PIN) difference() {
    intersection() { ausleger_voll_2d(); translate(PIN) circle(r = 2.5 * hgd); }
    translate(PIN) circle(r = Rg - 0.01);
}
module traeger_lokal() {
    linear_extrude(t_g) traeger_voll_2d();
    linear_extrude(t_g / 2) difference() {          // Gelenkauge (untere Hälfte)
        hull() { translate(PIN) circle(r = r_l); translate([y_h - Rg - 0.5, z_pin - r_l]) square([0.5, 2 * r_l]); }
        translate(PIN) circle(d = hole_d);
        for (a = [0 : 4 : TH_UP + 4]) offset(delta = cl) intersection() {
            rotate_ausleger_root(a);
            translate([y_h - 3 * hgd, zg0 - hgd]) square([3 * hgd, 3 * hgd]);
        }
        translate(rot2(PIN + [r_k, 0], PIN, beta)) circle(d = hole_d);
    }
}
// ---- Ausleger ----
function a_bot(y) = y < y_h + (y_o - y_h) * 0.4 ? zg0 : zg0 + (hgd - h_tip) * (y - y_h - (y_o - y_h) * 0.4) / ((y_o - y_h) * 0.6);
AU_M = [[[y_h + Rg, zg1 - cdg / 2], [y_o, zg1 - cdg / 2], cdg], [[y_h + Rg, zg0 + cdg / 2], [y_h + (y_o - y_h) * 0.4, zg0 + cdg / 2], cdg],
        [[y_h + (y_o - y_h) * 0.4, zg0 + cdg / 2], [y_o, a_bot(y_o) + cdg / 2], cdg]];
au_bad = [[-1e9, Rg + hgd + spw], [y_sp - t_e - spw - y_h, 1e9]];
au_xs = [for (v = seams_at(y_o + 1 - (y_h - r_l), [for (b = au_bad) [b[0] + r_l, b[1] + r_l]], spw)) v + y_h - r_l];
AU_PADS = [for (x = au_xs) [x - spw / 2, a_bot(x), x + spw / 2, zg1]];
module ausleger_voll_2d() {
    difference() {
        union() {
            polygon([[y_h + cl / 2, zg1 - cdg], [y_o, zg1 - cdg], [y_o, zg1], [y_h + cl / 2, zg1]]);
            polygon([[y_h + cl / 2, zg0], [y_h + (y_o - y_h) * 0.4, zg0], [y_o, a_bot(y_o)], [y_o, a_bot(y_o) + cdg],
                     [y_h + (y_o - y_h) * 0.4, zg0 + cdg], [y_h + cl / 2, zg0 + cdg]]);
            translate([y_h + cl / 2, zg0]) square([hgd * 0.8, hgd]);                            // Wurzel massiv
            translate([y_o - max(sc(1500), t_e + 4), a_bot(y_o)]) square([max(sc(1500), t_e + 4), zg1 - a_bot(y_o)]);   // Spitze
            nd = gnodes(y_h + hgd * 0.8, y_o - max(sc(1500), t_e + 4), hgd);
            for (i = [0 : len(nd) - 2]) bar([nd[i], i % 2 == 0 ? a_bot(nd[i]) + cdg / 2 : zg1 - cdg / 2], [nd[i + 1], i % 2 == 0 ? zg1 - cdg / 2 : a_bot(nd[i + 1]) + cdg / 2], dw);
            for (q = nd) bar([q, a_bot(q) + cdg / 2], [q, zg1 - cdg / 2], dw * 0.9);
            for (r = AU_PADS) rect2(r);
        }
        translate([y_sp - t_e / 2 - spiel, zg1 - h_tip * 0.75 - spiel]) square([t_e + 2 * spiel, h_tip * 0.5 + 2 * spiel]);
        translate([y_o - max(sc(400), 1.5), zg1 - cdg - th_d]) circle(d = th_d);
    }
}
module ausleger_lokal() {
    linear_extrude(t_g) difference() { ausleger_voll_2d(); translate(PIN) circle(r = Rg); }
    translate([0, 0, t_g / 2]) linear_extrude(t_g / 2) difference() {    // Gelenkauge (obere Hälfte)
        hull() { translate(PIN) circle(r = r_l); translate([y_h + Rg, z_pin - r_l]) square([0.5, 2 * r_l]); }
        translate(PIN) circle(d = hole_d);
        for (a = [beta, beta - TH_UP]) translate(rot2(PIN + [r_k, 0], PIN, a)) circle(d = hole_d);
    }
}
// Welt-Platzierung (sx = -1 links, +1 rechts)
module traeger_welt(sx) {
    if (sx < 0) translate([-Bx / 2 - t_g / 2, 0, 0]) rotate([90, 0, 90]) traeger_lokal();
    else translate([Bx / 2 + t_g / 2, 0, 0]) mirror([1, 0, 0]) rotate([90, 0, 90]) traeger_lokal();
}
module ausleger_welt(sx, a = 0) translate([0, y_h, z_pin]) rotate([a, 0, 0]) translate([0, -y_h, -z_pin]) {
    if (sx < 0) translate([-Bx / 2 - t_g / 2, 0, 0]) rotate([90, 0, 90]) ausleger_lokal();
    else translate([Bx / 2 + t_g / 2, 0, 0]) mirror([1, 0, 0]) rotate([90, 0, 90]) ausleger_lokal();
}
// Druck: Auge der unteren Hälfte liegt auf dem Bett
tr_oy = -zg0;
module traeger_druck() translate([-y_b, tr_oy, 0]) traeger_lokal();
module ausleger_druck() translate([-(y_h - r_l), -zg0 + 0, t_g]) mirror([0, 0, 1]) ausleger_lokal();
function info_traeger() = let(ox = -y_b, oy = tr_oy,
    kp = concat([for (sy = [-1, 1]) [sy * G / 2 - t_c - 1 + ox, -1, sy * G / 2 + t_c + 1 + ox, dh + 2]],
                [[y_e - t_e - 1 + ox, -1, y_e + t_e + 1 + ox, hgd + 1], [y_h - Rg - hgd + ox, -1, 1e9, hgd + 1]]))
    [y_h + r_l - y_b, hgd, [for (v = tr_xs) v + ox], [], kp, false, 0, shift_r(TR_PADS, ox, oy)];
function info_ausleger() = let(ox = -(y_h - r_l), oy = -zg0,
    kp = [[-1, -1, Rg + hgd + r_l, hgd + 1], [y_sp - t_e - 1 + ox, -1, 1e9, hgd + 1]])
    [y_o - y_h + r_l, hgd, [for (v = au_xs) v + ox], [], kp, false, 0, shift_r(AU_PADS, ox, oy)];

// =====================================================================
//  RIEGEL  (Zapfen durch die Rahmen bzw. Träger)
// =====================================================================
module riegel(span_in, t_th, h, z_t0, z_t1, tdepth) {
    // span_in: lichte Weite; Zapfen der Länge tdepth an beiden Enden (Höhe z_t0..z_t1)
    difference() {
        translate([-span_in / 2, 0]) square([span_in, h]);
        if (span_in > 6 * h) for (k = [1 : 1 : floor(span_in / (1.6 * h)) - 1])
            translate([-span_in / 2 + k * span_in / floor(span_in / (1.6 * h)), h / 2]) scale([0.45 * h, 0.3 * h]) circle(r = 1, $fn = 24);
    }
    for (sx = [-1, 1]) translate([sx > 0 ? span_in / 2 - e : -span_in / 2 - tdepth, z_t0]) square([tdepth + e, z_t1 - z_t0]);
}
module mastriegel_2d() riegel(P - t_s - 2 * spiel, t_m, h_m, h_m * 0.2, h_m * 0.8, t_s + spiel);
module end_riegel_2d() riegel(Bx - t_g - 2 * spiel, t_e, hgd * 0.6, hgd * 0.1, hgd * 0.5, t_g + spiel);
module spitz_riegel_2d() riegel(Bx - t_g - 2 * spiel, t_e, h_tip * 0.8, h_tip * 0.05, h_tip * 0.55, t_g + spiel);
module riegel_welt(yc, z0, th) translate([0, yc + th / 2, z0]) rotate([90, 0, 0]) linear_extrude(th) children();
module mastriegel_welt() riegel_welt(y_a, z_a - h_m * 0.5, t_m) mastriegel_2d();
module endriegel_welt() riegel_welt(y_e, zg0 + hgd * 0.3 - hgd * 0.1, t_e) end_riegel_2d();
module spitzenriegel_welt(a = 0) translate([0, y_h, z_pin]) rotate([a, 0, 0]) translate([0, -y_h, -z_pin])
    riegel_welt(y_sp, zg1 - h_tip * 0.75 - h_tip * 0.05, t_e) spitz_riegel_2d();
function riegel_info(span, h) = let(SX = span) [SX, h, [for (v = seams_at(SX, [], spw)) v], [], [], false, 0, [[0, 0, SX, h]]];

// =====================================================================
//  LAUFKATZE, KABINE, SPREADER, MASCHINENHAUS
// =====================================================================
module katze() {   // lokal: Mitte, z = 0 Unterkante (liegt um dch tiefer als die Trägeroberkante)
    difference() {
        union() {
            box3(-k_x, -L_k / 2, 0, k_x, L_k / 2, tkb);
            box3(-k_x * 0.7, -L_k * 0.42, tkb - e, k_x * 0.7, L_k * 0.3, tkb + h_mk);           // Hubwerk
            box3(-k_x * 0.75, -L_k * 0.45, tkb + h_mk - e, k_x * 0.75, L_k * 0.33, tkb + h_mk + max(sc(150), 0.8));
            for (sx = [-1, 1], sy = [-1, 1]) translate([sx * (Bx / 2), sy * L_k * 0.35, tkb]) rotate([0, 90, 0])
                cylinder(r = min(tkb * 0.45, sc(450, 1)), h = t_g * 0.8, center = true);       // Laufrad-Andeutung
        }
        for (sx = [-1, 1]) box3(sx * Bx / 2 - t_g / 2 - cl, -L_k, -1, sx * Bx / 2 + t_g / 2 + cl, L_k, dch);
        for (sx = [-1, 1], sy = [-1, 1]) translate([sx * xs_r, sy * ys_r, -1]) cylinder(d = th_d, h = tkb + h_mk + 5);
        box3(-cab_w * 0.3 - spiel, cab_y0 + cab_l * 0.2 - spiel, -1, cab_w * 0.3 + spiel, cab_y0 + cab_l * 0.8 + spiel, tkb * 0.6);
    }
}
function info_katze() = let(SX = 2 * k_x, SY = L_k, ox = k_x, oy = L_k / 2,
    kp = concat([for (sx = [-1, 1]) [sx * Bx / 2 - t_g / 2 - cl - 1 + ox, -1, sx * Bx / 2 + t_g / 2 + cl + 1 + ox, SY + 1]],
                [for (sx = [-1, 1], sy = [-1, 1]) [sx * xs_r - 2 + ox, sy * ys_r - 2 + oy, sx * xs_r + 2 + ox, sy * ys_r + 2 + oy]],
                [[-cab_w * 0.3 - 1 + ox, cab_y0 + cab_l * 0.2 - 1 + oy, cab_w * 0.3 + 1 + ox, SY + 1]]))
    [SX, SY, [for (v = seams_at(SX, [for (k = kp) [k[0], k[2]]], mw)) v], [], kp, false, 0, []];
// Kabine sitzt am wasserseitigen Ende der Katze, außerhalb des Spreaders
cab_y0 = L_k / 2 - cab_l;                    // lokal in der Katze
module kabine() {   // lokal: Oberkante z = 0, hängt nach unten; Zapfen nach oben
    wv = max(sc(30), 0.4);
    difference() {
        box3(-cab_w / 2, 0, -cab_h, cab_w / 2, cab_l, 0);
        box3(-cab_w / 2 + min_wand, cab_l - wv, -cab_h * 0.75, cab_w / 2 - min_wand, cab_l + 1, -cab_h * 0.25);
        for (sx = [-1, 1]) box3(sx > 0 ? cab_w / 2 - wv : -cab_w / 2 - 1, cab_l * 0.15, -cab_h * 0.75, sx > 0 ? cab_w / 2 + 1 : -cab_w / 2 + wv, cab_l * 0.85, -cab_h * 0.25);
    }
    box3(-cab_w * 0.3, cab_l * 0.2, -e, cab_w * 0.3, cab_l * 0.8, tkb * 0.6 - 0.2);
}
SP_XS = seams_at(sp_L, [], spw);
module spreader_2d() {
    for (v = SP_XS) translate([v - sp_L / 2 - spw / 2, -sp_W / 2]) square([spw, sp_W]);   // Stoßplatten
    difference() {
        square([sp_L, sp_W], center = true);
        for (sx = [-1, 1]) translate([sx * sp_L / 4, 0]) square([sp_L / 2 - 3 * sp_b, sp_W - 2 * sp_b], center = true);
        for (sx = [-1, 1], sy = [-1, 1]) translate([sx * xs_r, sy * min(ys_r, sp_W / 2 - sp_b / 2)]) circle(d = th_d);
    }
}
module spreader() {   // lokal: Unterseite z = 0, Twistlocks nach unten (z < 0)
    linear_extrude(sp_t) spreader_2d();
    // Twistlocks: passen in die Eckbeschläge von container_40ft.scad (Lochtiefe max(sc(25), 0.4))
    tl_h = max(sc(25), 0.4) - 0.05;
    for (sx = [-1, 1], sy = [-1, 1]) translate([sx * cast_x, sy * cast_y, -tl_h])
        scale([max(sc(110), 0.9), max(sc(50), 0.6), 1]) cylinder(d = 1, h = tl_h + e, $fn = 24);
    box3(-sp_L * 0.08, -sp_W * 0.35, sp_t - e, sp_L * 0.08, sp_W * 0.35, sp_t + max(sc(500), 1.5));   // Kopfstück
}
function info_spreader() = let(SX = sp_L, SY = sp_W,
    S = [for (v = SP_XS) [v - spw / 2, 0, v + spw / 2, sp_W]],
    kp = [for (sx = [-1, 1], sy = [-1, 1]) [sx * xs_r + sp_L / 2 - 2, sy * min(ys_r, sp_W / 2 - sp_b / 2) + sp_W / 2 - 2, sx * xs_r + sp_L / 2 + 2, sy * min(ys_r, sp_W / 2 - sp_b / 2) + sp_W / 2 + 2]])
    [SX, SY, SP_XS, [], kp, false, 0, S];
module spreader_druck() translate([sp_L / 2, sp_W / 2, sp_t + max(sc(500), 1.5)]) rotate([180, 0, 0]) spreader();
module maschinenhaus() {   // lokal: Unterkante z = 0 (sitzt auf der Trägeroberkante, Kanäle dch)
    difference() {
        union() {
            box3(-k_x, 0, 0, k_x, mh_len, dch + max(sc(400), 1.6));
            box3(-k_x * 0.95, mh_len * 0.05, dch, k_x * 0.95, mh_len * 0.95, dch + mh_h);
            box3(-k_x, mh_len * 0.02, dch + mh_h - e, k_x, mh_len * 0.98, dch + mh_h + max(sc(150), 0.8));
        }
        for (sx = [-1, 1]) box3(sx * Bx / 2 - t_g / 2 - cl, -1, -1, sx * Bx / 2 + t_g / 2 + cl, mh_len + 1, dch);
        wv = max(sc(30), 0.4);
        for (sy = [0.25, 0.55]) for (sx = [-1, 1]) box3(sx > 0 ? k_x * 0.95 - wv : -k_x * 0.95 - 1, mh_len * sy, dch + mh_h * 0.45, sx > 0 ? k_x * 0.95 + 1 : -k_x * 0.95 + wv, mh_len * sy + mh_len * 0.18, dch + mh_h * 0.75);
    }
}
function info_maschinenhaus() = let(SX = 2 * k_x, SY = mh_len, ox = k_x,
    kp = [for (sx = [-1, 1]) [sx * Bx / 2 - t_g / 2 - cl - 1 + ox, -1, sx * Bx / 2 + t_g / 2 + cl + 1 + ox, SY + 1]])
    [SX, SY, seams_at(SX, [for (k = kp) [k[0], k[2]]], mw), seams_at(SY, [], mw), kp, false, 0, []];

// =====================================================================
//  FAHRWERK & SCHIENE
// =====================================================================
module fahrwerk() {   // lokal: Mitte unter dem Bein, Rad-Aufstand z = 0, Schiene entlang x
    nwh = 4;
    difference() {
        union() {
            for (sy = [-1, 1]) box3(-fw_l / 2, sy > 0 ? fw_ww / 2 - e : -fw_b2, 0, fw_l / 2, sy > 0 ? fw_b2 : -fw_ww / 2 + e, hbg);
            box3(-fw_l / 2, -fw_b2, fw_z0, fw_l / 2, fw_b2, hbg);
            for (i = [0 : nwh - 1]) translate([-fw_l / 2 + (i + 0.5) * fw_l / nwh, 0, fw_wr]) rotate([90, 0, 0]) cylinder(r = fw_wr, h = fw_ww + 2 * e, center = true);
        }
        box3(-t_s / 2 - spiel, -ls * 0.3 - spiel, hbg - tn - 0.2, t_s / 2 + spiel, ls * 0.3 + spiel, hbg + 1);
    }
}
module schiene_seg(L) {
    difference() {
        union() {
            box3(0, -beam_w / 2, 0, L, beam_w / 2, bh);
            translate([0, 0, bh - e]) rotate([90, 0, 90]) linear_extrude(L)
                polygon([[-rail_w * 0.9, 0], [rail_w * 0.9, 0], [rail_w * 0.25, rail_h * 0.25], [rail_w * 0.25, rail_h * 0.65],
                         [rail_w / 2, rail_h * 0.7], [rail_w / 2, rail_h], [-rail_w / 2, rail_h], [-rail_w / 2, rail_h * 0.7],
                         [-rail_w * 0.25, rail_h * 0.65], [-rail_w * 0.25, rail_h * 0.25]]);
        }
        rb_slot();
        translate([L, 0, 0]) rotate([0, 0, 180]) rb_slot();
    }
}
SCHL = sc(schienen_laenge_m * 1000, 60);
SCHN = max(1, ceil(SCHL / usable));
SCHS = SCHL / SCHN;

// =====================================================================
//  Zusammenbau
// =====================================================================
C_BLAU = "#1f5fa8"; C_WEISS = "#ecf0f1"; C_DUNKEL = "#2c3e50"; C_BETON = "#9e9e9e"; C_CONT = "#c0392b";
A_UP = ausleger_hoch ? TH_UP : 0;
yk = y_kmin + (y_kmax - y_kmin) * min(1, max(0, katze_pos));
module bruecke(ex = 0) {
    translate([0, 0, rail_top]) {
        for (sx = [-1, 1], sy = [-1, 1]) color(C_DUNKEL) translate([sx * P / 2, sy * G / 2, -ex]) fahrwerk();
        color(C_BLAU) for (sx = [-1, 1]) translate([sx * ex, 0, 0]) portalrahmen_welt(sx);
        color(C_BLAU) for (sx = [-1, 1], sy = [-1, 1]) translate([sx * ex * 0.5, sy * ex, ex * 0.5]) konsole_welt(sx, sy);
        color(C_BLAU) translate([0, 0, 2 * ex]) mastriegel_welt();
        translate([0, 0, 1.5 * ex]) {
            color(C_WEISS) for (sx = [-1, 1]) traeger_welt(sx);
            color(C_WEISS) endriegel_welt();
            color(C_WEISS) translate([0, ex, 0]) { for (sx = [-1, 1]) ausleger_welt(sx, A_UP); spitzenriegel_welt(A_UP); }
            color(C_WEISS) translate([0, y_b, zg1 - dch + ex]) maschinenhaus();
            if (ex == 0) {
                // Katze, Kabine, Spreader, Container
                color("#f1c40f") translate([0, yk, zg1 - dch]) katze();
                color("#f1c40f") translate([0, yk + cab_y0, zg1 - dch]) kabine();
                z_sp = sc(2896) + 1 + (zg0 - sc(300) - sp_t - max(sc(500), 1.5) - sc(2896) - 2) * min(1, max(0, spreader_hoehe));
                color(C_DUNKEL) translate([0, yk, z_sp]) spreader();
                color("#222") for (sx = [-1, 1], sy = [-1, 1]) translate([sx * xs_r, yk + sy * ys_r, z_sp + sp_t]) cylinder(d = 0.25, h = zg1 - dch - z_sp - sp_t);
                if (container_zeigen) color(C_CONT) translate([-sp_L / 2, yk - sp_W / 2, z_sp - sc(2591) - min(sc(150), 0.8) * 0]) cube([sp_L, sp_W, sc(2591)]);
                // Abspannungen
                color("#333") {
                    hull() { translate([P / 2 - t_s, y_a + t_m / 2 + 1, z_a + h_m * 0.1]) sphere(d = 0.3); translate([Bx / 2, y_o - sc(400), zg1 - cdg]) sphere(d = 0.3); }
                    hull() { translate([P / 2 - t_s, y_a - t_m / 2 - 1, z_a + h_m * 0.1]) sphere(d = 0.3); translate([Bx / 2, y_b + sc(400), zg1 - cdg]) sphere(d = 0.3); }
                }
            }
        }
    }
    for (sy = [-1, 1]) for (i = [0 : SCHN - 1]) color(C_BETON) translate([-SCHL / 2 + i * SCHS, sy * G / 2, -ex]) schiene_seg(SCHS);
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFOS = [["portalrahmen", info_portalrahmen(), 2], ["traeger", info_traeger(), 2],
         ["ausleger", info_ausleger(), 2], ["mastriegel", riegel_info(P + t_s, h_m), 1],
         ["endriegel", riegel_info(Bx + t_g, hgd * 0.6), 1], ["spitzenriegel", riegel_info(Bx + t_g, h_tip * 0.8), 1], ["katze", info_katze(), 1],
         ["spreader", info_spreader(), 1], ["maschinenhaus", info_maschinenhaus(), 1]];
CLIPS = lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
function info_of(n) = [for (i = INFOS) if (i[0] == n) i[1]][0];

echo(str("Containerbrücke 1:", den, " | Spur ", r2(G), " mm, Portal ", r2(P), " mm, Trägerunterkante ", r2(zg0), " mm, Masthöhe ", r2(rail_top + z_a + r_ap), " mm"));
echo(str("Ausladung ", r2(y_o - G / 2), " mm, Rückausleger ", r2(-G / 2 - y_b), " mm | Länge gesamt ", r2(y_o - y_b), " mm | Ausleger hoch: ", r2(rail_top + z_pin + (y_o - y_h) * sin(TH_UP)), " mm"));
echo(str("Trägerabstand ", r2(Bx), " mm, freie Weite zwischen den Konsolen ", r2(2 * x_in), " mm, Container ", r2(sc(12192)), " mm -> ", 2 * x_in - 2 * cl > sc(12192) ? "passt" : "PASST NICHT – traeger_abstand_m erhöhen"));
echo(str("Stifte (Ø ", stift_d, "): 2x Auslegergelenk ", r2(t_g + 1), " mm, 2x Raststift ", r2(t_g + 1), " mm | Fäden: 4x Spreader, Abspannungen"));
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
echo(str("Verbinder-Clips für geteilte Teile: ", CLIPS, " (+ ", 2 * max(0, SCHN - 1), " für die Schienenstöße)"));

if (teil == "aufbau") bruecke();
else if (teil == "explosion") bruecke(max(sc(3000), 15));
else if (teil == "portalrahmen") split_out(info_portalrahmen(), stueck) portalrahmen_druck();
else if (teil == "konsole") konsole_druck();
else if (teil == "traeger_links") split_out(info_traeger(), stueck) traeger_druck();
else if (teil == "traeger_rechts") translate([0, hgd, 0]) mirror([0, 1, 0]) split_out(info_traeger(), stueck) traeger_druck();
else if (teil == "ausleger_rechts") split_out(info_ausleger(), stueck) ausleger_druck();
else if (teil == "ausleger_links") translate([0, hgd, 0]) mirror([0, 1, 0]) split_out(info_ausleger(), stueck) ausleger_druck();
else if (teil == "mastriegel") split_out(riegel_info(P + t_s, h_m), stueck) linear_extrude(t_m) translate([X1, 0]) mastriegel_2d();
else if (teil == "endriegel") split_out(riegel_info(Bx + t_g, hgd * 0.6), stueck) linear_extrude(t_e) translate([Bx / 2 + t_g / 2, 0]) end_riegel_2d();
else if (teil == "spitzenriegel") split_out(riegel_info(Bx + t_g, h_tip * 0.8), stueck) linear_extrude(t_e) translate([Bx / 2 + t_g / 2, 0]) spitz_riegel_2d();
else if (teil == "katze") split_out(info_katze(), stueck) translate([k_x, L_k / 2, 0]) katze();
else if (teil == "kabine") translate([0, 0, cab_h]) kabine();
else if (teil == "spreader") split_out(info_spreader(), stueck) spreader_druck();
else if (teil == "maschinenhaus") split_out(info_maschinenhaus(), stueck) translate([k_x, 0, 0]) maschinenhaus();
else if (teil == "fahrwerk") fahrwerk();
else if (teil == "schiene") schiene_seg(SCHS);
else if (teil == "verbinder") {
    n = max(CLIPS + 2 * max(0, SCHN - 1), 4);
    nx = ceil(sqrt(n));
    for (i = [0 : n - 1]) translate([(i % nx) * (cL + 3), floor(i / nx) * (cw1 + 3), 0]) clip();
}
