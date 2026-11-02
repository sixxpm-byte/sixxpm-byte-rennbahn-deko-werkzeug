// =====================================================================
//  HAFENKRAN  –  Portal-Wippdrehkran als zerlegbarer Bausatz
//  Maßstäbe 1:43 und 1:87, FDM-optimiert (stützfrei),
//  Teile über dem Druckbett werden automatisch geteilt (Clips)
//  Stecksystem kompatibel zu rennbahn_deko.scad
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  TEILE  (teil = ...)
//    portal_seite   Portal-Seitenrahmen (Fachwerk, flach)        2x
//    portal_quer    Portal-Querträger (Fachwerk, flach)          2x
//    plattform      Portalplattform mit Drehkranz                1x
//    fahrwerk       Fahrwerk mit Rädern                          4x
//    drehbuehne     Oberwagen: Maschinenhaus, Führerhaus,
//                   Gegengewicht, Zahnstangen-Lager              1x
//    turm           Turm-/Bockseite (Fachwerk, flach)            2x
//    traverse       Querverbindung der Turmseiten                1x
//    ausleger       Wippausleger (Fachwerk, flach gedruckt)      1x
//    wippstange     Zahnstange mit Rastlöchern                   2x
//    hakenflasche   Haken                                        1x
//    zapfen         Königszapfen (Drehachse)                     1x
//    schiene        Kranschiene mit Balken (Clips an den Enden)  2x
//    verbinder      Clips für geteilte Teile
//
//  BEWEGLICH
//    * Oberwagen dreht auf dem Königszapfen.
//    * Ausleger kippt am Turm (Stift = Filament).
//    * Wippwinkel über die Zahnstangen: Stift durch das gewünschte
//      Loch stecken – die Lochabstände werden exakt für die Winkel in
//      "wippwinkel" berechnet.
//    * Haken hängt an einem Faden (durch das Loch im Auslegerkopf).
//
//  MONTAGE
//    1. Fahrwerke auf die Schienen, Seitenrahmen in die Fahrwerke.
//    2. Querträger mit ihren Zapfen durch die Seitenrahmen stecken.
//    3. Plattform aufsetzen (Laschen greifen in die Löcher).
//    4. Zapfen von unten fest in die Drehbühne drücken, Drehbühne
//       mit Zapfen in die Plattform setzen.
//    5. Turmseiten in die Drehbühne stecken, Traverse einschieben.
//    6. Ausleger mit Stift am Turm lagern, Zahnstangen mit Stift am
//       Ausleger einhängen und mit je einem Stift im Lager fixieren.
//
//  DRUCK: alle Teile werden druckfertig ausgerichtet ausgegeben.
//    Fachwerke flach, Drehbühne aufrecht, alle Löcher senkrecht
//    oder als Tropfen. Lange, schmale Teile liegen diagonal, wenn sie
//    so ungeteilt aufs Bett passen. Geteilte Teile: stueck = 1..n.
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [43:1/43 Drift-RC und Slotcar, 87:1/87 H0]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosionsansicht, portal_seite:Portal-Seitenrahmen, portal_quer:Portal-Querträger, plattform:Portalplattform, fahrwerk:Fahrwerk, drehbuehne:Drehbühne, turm:Turmseite, traverse:Traverse, ausleger:Ausleger, wippstange:Zahnstange, hakenflasche:Haken, zapfen:Königszapfen, schiene:Kranschiene, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;

/* [Vorschau] */
// Wippstufe in der Vorschau (1 = flach ... n = steil)
vorschau_stufe = 3;
// Drehwinkel des Oberwagens
drehung = 30; // [0:360]
// Hakenhöhe über Schiene in der Vorschau (Anteil der Auslegerhöhe)
haken_hoehe = 0.45;

/* [Kran (Vorbild in Metern)] */
spurweite_m = 6.0;
radstand_m = 6.0;
// lichte Höhe unter dem Portal
portal_hoehe_m = 6.0;
ausleger_m = 18.0;
turm_hoehe_m = 6.5;
haus_laenge_m = 4.0;
haus_breite_m = 4.2;
haus_hoehe_m = 3.2;
// Auslegerwinkel der Raststufen (Grad)
wippwinkel = [15, 30, 45, 60, 72];
schienen_laenge_m = 14.0;

/* [Farben] */
farbe_stahl   = "rot";       // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_hell    = "weiss";     // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_dunkel  = "anthrazit"; // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_schiene = "grau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_zapfen  = "silber";    // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_haken   = "gelb";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]
farbe_clips   = "grau";      // [rot, gelb, blau, hellblau, gruen, dunkelgruen, weiss, schwarz, grau, silber, gold, orange, lila, rosa, tuerkis, braun, holz, creme, anthrazit, cyan, pink, violett, neongruen]

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
cl  = 0.4;                                   // Laufspiel bewegter Teile

function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] : d <= 20 ? [16, 6, 10, 3.2] : d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] : d <= 50 ? [10, 4, 7, 2] : [8, 3.2, 5.6, 1.6];
CT = conn_tab(den);
cL = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];
deck  = 0.8;
clipd = ch + spiel + deck;
clipw = cw1 + 2 * (spiel + min_wand);        // Mindestbreite für eine Clip-Tasche
hole_d = stift_d + 2 * stift_spiel;
FARBEN = [["rot", "#c62828"], ["gelb", "#f9c80e"], ["blau", "#1e5bb8"], ["gruen", "#2e9d4f"], ["weiss", "#f4f4f4"],
          ["schwarz", "#222222"], ["grau", "#8a8f94"], ["silber", "#c0c4c8"], ["gold", "#d4a017"], ["orange", "#ef7d1a"],
          ["lila", "#7b3fa0"], ["rosa", "#f27fb2"], ["tuerkis", "#1fb5b0"], ["braun", "#7a4b2a"], ["holz", "#c19a6b"], ["creme", "#f3e3c3"],
          ["anthrazit", "#3a3f45"], ["cyan", "#12b5e8"], ["pink", "#e43d8f"], ["violett", "#8e3fc2"], ["neongruen", "#2ad957"],
          ["hellblau", "#5aa2dc"], ["dunkelgruen", "#1f6b3a"]];
function fhex(n) = let(f = [for (p = FARBEN) if (p[0] == n) p[1]]) len(f) > 0 ? f[0] : n;

// =====================================================================
//  Maße
// =====================================================================
// ---- Portal ----
Gy  = sc(spurweite_m * 1000, 40);
Rx  = sc(radstand_m * 1000, 40);
lx  = max(sc(700), 5, Rx > usable || Gy > usable ? clipw + 0.6 : 0);   // Beinquerschnitt
ly  = lx;
hg  = max(sc(1200), 7);                      // Portalträger
fl  = max(sc(250), 1.6, Rx > usable || Gy > usable ? clipw + 0.6 : 0);   // Gurt
dw  = max(sc(200), 1.2);                     // Fachwerkstab
fw_wr = sc(300, 2);                          // Radradius
fw_ww = max(sc(200), 2);                     // Radbreite
fw_z0 = 2 * fw_wr + 0.4;                     // Unterkante Fahrwerkskasten
hbg = max(sc(1000), fw_z0 + 3);              // Fahrwerkshöhe
zt  = max(sc(portal_hoehe_m * 1000), hbg + 5) + hg;
tn  = min(max(sc(400), 2), hbg - fw_z0 - 0.8);   // Zapfen in Fahrwerk
fw_l  = max(sc(2200), 4 * fw_wr + 4);
fw_b2 = max(fw_ww / 2 + 1.2, ly / 2 + spiel + 1.2);   // halbe Fahrwerksbreite
tq  = lx * 0.55;                             // Querträgerdicke
tpl = max(sc(300), 2.5, Rx > usable || Gy > usable ? clipd + 0.6 : 0);
tab_w = max(sc(400), 2.5);
tab_h = tpl * 0.6;
d_pin = max(sc(600), 4);                     // Königszapfen
r_ring = min(Rx, Gy) * 0.36;
w_ring = max(sc(300), 1.6);
h_ring = max(sc(150), 1.0);
z_os   = zt + tpl + h_ring;                  // Unterkante Oberwagen

// ---- Oberwagen (lokal: Drehachse z, Ausleger zeigt nach +x) ----
tbs  = max(sc(400), 3, 0.6 * 0 + 0);
w_j  = max(sc(1200), 6);                     // Auslegerbreite
tt   = max(sc(300), 3);                      // Turmseitendicke
yT   = w_j / 2 + cl + tt / 2;                // Mitte Turmseite
lw_t = max(sc(400), 3);                      // Turmbein
x_p  = sc(2600);                             // Drehpunkt Ausleger (x)
Ht   = sc(turm_hoehe_m * 1000, 20);
z_p  = tbs + Ht;
x_t0 = x_p - sc(3000);                       // hinterer Turmfuß
tr   = max(sc(250), 2.4);                    // Zahnstange Dicke
rack_est   = sc(ausleger_m * 1000) * 0.62 + sc(350);              // grobe Abschätzung der Länge
rack_split = rack_est > usable && !diag_ok(rack_est, sc(350) + sc(80) + 2);   // diagonal aufs Bett, wenn es passt
rw   = max(sc(350), hole_d + 2.4, rack_split ? clipw + 0.6 : 0);   // Zahnstange Breite
lt   = max(sc(150), 1.5);                    // Lagerlasche
y_r  = yT + tt / 2 + cl + tr / 2;            // Ebene der Zahnstange
W_h  = max(sc(haus_breite_m * 1000), 2 * (y_r + tr / 2 + cl + lt + 1));
L_h  = sc(haus_laenge_m * 1000, 12);
H_h  = sc(haus_hoehe_m * 1000, 9);
x_h1 = x_t0 - lw_t / 2 - sc(250, 1);
x_h0 = x_h1 - L_h;
cw_l = sc(1200, 4); cw_h = H_h * 0.75;
xb0  = x_h0 - cw_l;
tn_t = tbs * 0.6;                            // Turmzapfen-Tiefe
rbp  = hole_d / 2 + max(sc(150), 1.6);       // Lagerauge

// ---- Ausleger (lokal: s entlang, n quer) ----
L_j = sc(ausleger_m * 1000, 60);
h_m = max(sc(1400), 8);
h_f = h_m * 0.8;
h_h = max(sc(700), 5);
cd  = max(sc(300), 1.6);
spw = cL + 3;                                // Stoßplatte an Teilungsnähten
fe  = max(h_f / 2, rbp + 0.5);
s1  = L_j * 0.15; s2 = L_j * 0.85;
pj  = h_m;
function hj(q) = q <= 0 ? h_f : q < s1 ? h_f + (h_m - h_f) * q / s1 : q <= s2 ? h_m : h_m + (h_h - h_m) * (q - s2) / (L_j - s2);
sJ  = L_j * 0.38;
rj  = hole_d / 2 + max(sc(120), 1.4);
nJ  = -hj(sJ) / 2 - rj * 0.4;                // Zahnstangen-Anlenkpunkt
j_ymin = min(-h_f / 2, nJ - rj, -fe) - 0.5;
j_ymax = max(h_f / 2, h_m / 2, fe) + 0.5;
jib_SX = L_j + h_h / 2 + fe + 1; jib_SY = j_ymax - j_ymin;
jib_split = jib_SX > usable && !diag_ok(jib_SX, jib_SY);   // knapp zu lang: diagonal statt mit einem Clip geteilt

// ---- Wippwerk (Zahnstange) ----
// Zahnstangenbock vor/unter dem Drehpunkt -> gleichmäßige Lochabstände
x_k  = x_p + Ht * 0.6 * cos(-70);
hk0  = z_p + Ht * 0.6 * sin(-70) - tbs;
function Jp(th) = [x_p + sJ * cos(th) - nJ * sin(th), z_p + sJ * sin(th) + nJ * cos(th)];
function dist(a, b) = norm(a - b);
function dmax_of(zk) = max([for (t = wippwinkel) dist(Jp(t), [x_k, zk])]);
function drop_of(zk) = max([for (t = wippwinkel) let(J = Jp(t), K = [x_k, zk], d = dist(J, K), ph = atan2(J[1] - K[1], J[0] - K[0]))
                            (dmax_of(zk) - d + rw) * sin(ph)]);
function zk_fit(zk, n = 0) = n > 4 ? zk : let(need = drop_of(zk) - (zk - tbs - 0.8))
                             need > 0 ? zk_fit(zk + need, n + 1) : zk;
z_k  = zk_fit(tbs + hk0);
K    = [x_k, z_k];
xb1  = max(x_p + lw_t / 2 + sc(500, 2), x_k + rbp * 2.2 + sc(200, 1));
DI   = [for (t = wippwinkel) dist(Jp(t), K)];
DMAX = max(DI);
rack_len = DMAX + rw;
function mindiff(l) = min([for (i = [0 : len(l) - 1], j = [0 : len(l) - 1]) if (i < j) abs(l[i] - l[j])]);

// ---- Haken & Schienen ----
hk_w = max(sc(800), 5); hk_h = max(sc(700), 5); hk_t = max(sc(250), 1.6);
rb_w = 2 * fw_b2;                            // Fahrwerksbreite
bh   = max(sc(300), 2.5);                    // Kranbahnbalken
rail_h = max(sc(150), 1.2); rail_w = max(sc(100), 1.0);
beam_w = max(rb_w + sc(400), clipw + 2);
rail_top = bh + rail_h;

// =====================================================================
//  Hilfen
// =====================================================================
// Lange, schmale Teile: diagonal aufs Bett legen statt teilen
function diag_ok(SX, SY) = (SX + SY) / sqrt(2) <= usable;
module diag_druck(SX, SY) if (SX > usable && diag_ok(SX, SY)) translate([SY / sqrt(2), 0, 0]) rotate([0, 0, 45]) children(); else children();
module bar(p, q, w) hull() { translate(p) circle(d = w, $fn = 12); translate(q) circle(d = w, $fn = 12); }
module box3(x0, y0, z0, x1, y1, z1) translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);
module teardrop(r) { hull() { circle(r = r); translate([r * sqrt(2) - 0.01, 0]) square(0.02, center = true); } }
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

// ---------------------------------------------------------------------
//  Automatische Teilung: Clips nur in "solids" und nicht in "keep"
//  info = [SX, SY, Nähte x, Nähte y, keep, von oben?, Oberkante, solids]
// ---------------------------------------------------------------------
function band_a(l, i) = i == 0 ? 0 : l[i - 1];
function band_b(l, i, S) = i >= len(l) ? S : l[i];
function rect_hit(r, k) = !(r[2] <= k[0] || r[0] >= k[2] || r[3] <= k[1] || r[1] >= k[3]);
function free(r, kp) = len([for (k = kp) if (rect_hit(r, k)) 1]) == 0;
function inside(r, S) = len(S) == 0 || len([for (q = S) if (r[0] >= q[0] && r[1] >= q[1] && r[2] <= q[2] && r[3] <= q[3]) 1]) > 0;
function okc(r, kp, S) = free(r, kp) && inside(r, S);
function pick(l, sep, last = -1e9, i = 0) = i >= len(l) ? [] :
    l[i] - last >= sep ? concat([l[i]], pick(l, sep, l[i], i + 1)) : pick(l, sep, last, i + 1);
function qsort(l) = len(l) <= 1 ? l : let(p = l[floor(len(l) / 2)])
    concat(qsort([for (x = l) if (x < p) x]), [for (x = l) if (x == p) x], qsort([for (x = l) if (x > p) x]));
// Kandidaten: Raster + Mitten der tragenden Flächen
// Randabstand: an Teilkanten nur halbe Clipbreite, an inneren Nähten Platz für querende Clips
mw = cw1 / 2 + spiel + min_wand; mi = cL / 2 + 1.5;
function cand(a, b, tot, S, ax, at) = let(ma = a <= 0 ? mw : mi, mb = b >= tot ? mw : mi)
    qsort(concat([for (v = [a + ma : 0.5 : b - mb]) v],
    [for (q = S) if (q[ax] <= at && q[ax + 2] >= at) let(c = (q[1 - ax] + q[3 - ax]) / 2) if (c >= a + ma && c <= b - mb) c]));
function clips_v(sx, a, b, kp, S, tot) = let(
    ok = [for (y = cand(a, b, tot, S, 0, sx)) if (okc([sx - cL / 2 - 1, y - cw1 / 2 - spiel - min_wand, sx + cL / 2 + 1, y + cw1 / 2 + spiel + min_wand], kp, S)) y])
    pick(ok, max(20, 3 * cw1));
function clips_h(sy, a, b, kp, S, tot) = let(
    ok = [for (x = cand(a, b, tot, S, 1, sy)) if (okc([x - cw1 / 2 - spiel - min_wand, sy - cL / 2 - 1, x + cw1 / 2 + spiel + min_wand, sy + cL / 2 + 1], kp, S)) x])
    pick(ok, max(20, 3 * cw1));
function seams(S, p = 0, off = 0, lo = 0, hi = 1e9) = let(n = max(1, ceil(S / usable)))
    [for (k = [1 : 1 : n - 1]) let(x = k * S / n, xs = p > 0 ? round((x - off) / p) * p + off : x) min(hi, max(lo, xs))];
function lsum(l, i = 0) = i >= len(l) ? 0 : l[i] + lsum(l, i + 1);
function n_pieces(info) = (len(info[2]) + 1) * (len(info[3]) + 1);
function seam_clips(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4], S = info[7])
    concat([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp, S, SY))],
           [for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp, S, SX))]);
function clip_count(info) = lsum(seam_clips(info));
// Naht braucht nur dann Clips, wenn tragendes Material sie kreuzt
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

// =====================================================================
//  PORTAL
// =====================================================================
X1 = Rx / 2 + lx / 2;
gx0 = -Rx / 2 + lx / 2; gx1 = Rx / 2 - lx / 2;
mz0 = zt - hg * 0.7; mz1 = zt - hg * 0.3;    // Zapfenloch Querträger

module gitter_2d(a0, a1, zb, ztop, w) {      // Warren-Fachwerk zwischen zwei Gurten
    n = max(2, round((a1 - a0) / max(ztop - zb, 1)));
    for (k = [0 : n - 1]) {
        xa = a0 + k * (a1 - a0) / n; xb = a0 + (k + 1) * (a1 - a0) / n;
        if (k % 2 == 0) bar([xa, zb], [xb, ztop], w); else bar([xa, ztop], [xb, zb], w);
    }
}
module seite_2d() {
    difference() {
        union() {
            for (sx = [-1, 1]) {
                translate([sx * Rx / 2 - lx / 2, hbg]) square([lx, zt - hbg]);
                translate([sx * Rx / 2 - lx * 0.3, hbg - tn]) square([lx * 0.6, tn + e]);
                translate([sx * Rx / 2 - tab_w / 2, zt - e]) square([tab_w, tab_h]);
            }
            translate([-X1, zt - fl]) square([2 * X1, fl]);
            translate([-X1, zt - hg]) square([2 * X1, fl]);
            gitter_2d(gx0, gx1, zt - hg + fl / 2, zt - fl / 2, dw);
            kb = min(hg, (gx1 - gx0) * 0.18);
            for (sx = [-1, 1]) bar([sx * gx1, zt - hg - kb], [sx * (gx1 - kb), zt - hg + fl / 2], dw * 1.6);
        }
        for (sx = [-1, 1]) translate([sx * Rx / 2 - tq / 2 - spiel, mz0 - spiel]) square([tq + 2 * spiel, mz1 - mz0 + 2 * spiel]);
    }
}
// Leiter am Bein (Relief)
module seite_welt(sy) {
    translate([0, sy * Gy / 2 + ly / 2, 0]) rotate([90, 0, 0]) linear_extrude(ly) seite_2d();
}
ps_zmin = hbg - tn;
module seite_druck() linear_extrude(ly) translate([X1, -ps_zmin]) seite_2d();
function info_seite() = let(SX = 2 * X1, SY = zt + tab_h - ps_zmin, o = -ps_zmin,
    S = concat([for (sx = [-1, 1]) [sx * Rx / 2 - lx / 2 + X1, hbg + o, sx * Rx / 2 + lx / 2 + X1, zt + o]],
               [[0, zt - fl + o, SX, zt + o], [0, zt - hg + o, SX, zt - hg + fl + o]]),
    kp = [for (sx = [-1, 1]) [sx * Rx / 2 - tq / 2 - 1 + X1, mz0 + o - 1, sx * Rx / 2 + tq / 2 + 1 + X1, mz1 + o + 1]])
    [SX, SY, seams(SX), seams(SY), kp, false, 0, S];

// Querträger (lokal u = Welt-y)
QU0 = Gy / 2 - ly / 2 - spiel; QU1 = Gy / 2 + ly / 2;
module quer_2d() {
    translate([-QU0, zt - fl]) square([2 * QU0, fl]);
    translate([-QU0, zt - hg]) square([2 * QU0, fl]);
    for (sx = [-1, 1]) translate([sx > 0 ? QU0 - lx * 0.4 : -QU0, zt - hg]) square([lx * 0.4, hg]);
    gitter_2d(-QU0 + lx * 0.4, QU0 - lx * 0.4, zt - hg + fl / 2, zt - fl / 2, dw);
    for (sx = [-1, 1]) translate([sx > 0 ? QU0 - e : -QU1, mz0]) square([QU1 - QU0 + e, mz1 - mz0]);
    translate([-tab_w / 2, zt - e]) square([tab_w, tab_h]);
}
module quer_welt(sx) translate([sx * Rx / 2 - tq / 2, 0, 0]) rotate([90, 0, 90]) linear_extrude(tq) quer_2d();
module quer_druck() linear_extrude(tq) translate([QU1, -(zt - hg)]) quer_2d();
function info_quer() = let(SX = 2 * QU1, SY = hg + tab_h,
    S = [[QU1 - QU0, hg - fl, QU1 + QU0, hg], [QU1 - QU0, 0, QU1 + QU0, fl]])
    [SX, SY, seams(SX), seams(SY), [], false, 0, S];

// Plattform
module plattform_welt() {
    difference() {
        union() {
            box3(-X1, -Gy / 2 - ly / 2, zt, X1, Gy / 2 + ly / 2, zt + tpl);
            translate([0, 0, zt + tpl - e]) difference() {
                cylinder(r = r_ring + w_ring / 2, h = h_ring + e, $fn = 96);
                translate([0, 0, -1]) cylinder(r = r_ring - w_ring / 2, h = h_ring + 2, $fn = 96);
            }
        }
        translate([0, 0, zt - 1]) cylinder(d = d_pin + 0.5, h = tpl + 2);
        for (sx = [-1, 1], sy = [-1, 1])
            box3(sx * Rx / 2 - tab_w / 2 - spiel, sy * Gy / 2 - ly / 2 - spiel, zt - 1, sx * Rx / 2 + tab_w / 2 + spiel, sy * Gy / 2 + ly / 2 + spiel, zt + tab_h + 0.2);
        for (sx = [-1, 1])
            box3(sx * Rx / 2 - tq / 2 - spiel, -tab_w / 2 - spiel, zt - 1, sx * Rx / 2 + tq / 2 + spiel, tab_w / 2 + spiel, zt + tab_h + 0.2);
    }
}
module plattform_druck() translate([X1, Gy / 2 + ly / 2, -zt]) plattform_welt();
function info_plattform() = let(SX = 2 * X1, SY = Gy + ly, ox = X1, oy = Gy / 2 + ly / 2, m = 1.5,
    kp = concat([[ox - d_pin / 2 - m, oy - d_pin / 2 - m, ox + d_pin / 2 + m, oy + d_pin / 2 + m]],
                [for (sx = [-1, 1], sy = [-1, 1]) [ox + sx * Rx / 2 - tab_w / 2 - m, oy + sy * Gy / 2 - ly / 2 - m, ox + sx * Rx / 2 + tab_w / 2 + m, oy + sy * Gy / 2 + ly / 2 + m]],
                [for (sx = [-1, 1]) [ox + sx * Rx / 2 - tq / 2 - m, oy - tab_w / 2 - m, ox + sx * Rx / 2 + tq / 2 + m, oy + tab_w / 2 + m]]))
    [SX, SY, seams(SX), seams(SY), kp, false, 0, []];

// Fahrwerk (lokal: Mitte unter dem Bein, Rad-Aufstand z = 0)
// Räder zwischen zwei Seitenschilden, stehen auf der Schiene; aufrecht druckbar
module fahrwerk() {
    difference() {
        union() {
            for (sy = [-1, 1]) box3(-fw_l / 2, sy > 0 ? fw_ww / 2 - e : -fw_b2, 0, fw_l / 2, sy > 0 ? fw_b2 : -fw_ww / 2 + e, hbg);
            box3(-fw_l / 2, -fw_b2, fw_z0, fw_l / 2, fw_b2, hbg);
            // Räder: unten 45° zulaufend und flach auf z = 0 (sonst hängt die untere Radhälfte frei)
            for (sx = [-1, 1]) translate([sx * fw_l / 4, 0, fw_wr]) rotate([90, 0, 0]) linear_extrude(fw_ww + 2 * e, center = true)
                intersection() { rotate(-90) teardrop(fw_wr); translate([-fw_wr, -fw_wr]) square([2 * fw_wr, 2 * fw_wr]); }
        }
        box3(-lx * 0.3 - spiel, -ly / 2 - spiel, hbg - tn - 0.2, lx * 0.3 + spiel, ly / 2 + spiel, hbg + 1);
        // Bogenausschnitt zwischen den Rädern (Optik)
        // oben 45° zugespitzt (Ellipse + Tangenten), stützfrei
        for (sy = [-1, 1]) let(ba = fw_l / 4 - fw_wr * 0.6, bb = fw_z0 * 0.7) translate([0, sy * fw_b2, 0]) rotate([90, 0, 0])
            linear_extrude(2 * (fw_b2 - fw_ww / 2 - 0.8), center = true) hull() {
                scale([ba, bb]) circle(r = 1, $fn = 32);
                translate([0, sqrt(ba * ba + bb * bb)]) square(0.02, center = true);
            }
    }
}

// =====================================================================
//  OBERWAGEN  (lokal, z = 0 Unterkante Drehbühne)
// =====================================================================
cab_w = max(sc(1500), 8); cab_l = max(sc(1800), 9); cab_h = max(sc(2400), 10);
cab_y0 = y_r + tr / 2 + cl + lt + max(sc(200), 1.0);
cab_y1 = max(W_h / 2, cab_y0 + cab_w);
// Schlitze für die Zahnstangen-Enden im Maschinenhaus
module rack_slot() {
    for (sy = [-1, 1]) translate([0, sy * y_r + tr / 2 + cl, 0]) rotate([90, 0, 0]) linear_extrude(tr + 2 * cl)
        offset(r = rw / 2 + cl) hull() {
            translate(K) circle(r = 0.01);
            for (t = wippwinkel) let(J = Jp(t), d = dist(J, K), u = (J - K) / d) translate(K - u * (DMAX - d + rw)) circle(r = 0.01);
        }
}
module drehbuehne() {
    difference() {
        union() {
            box3(xb0, -W_h / 2, 0, xb1, W_h / 2, tbs);                                  // Grundplatte
            box3(x_h0, -W_h / 2 + sc(150, 0.8), tbs - e, x_h1, W_h / 2 - sc(150, 0.8), tbs + H_h);   // Maschinenhaus
            hull() {   // Dachrand, unten 45° angefast (stützfrei)
                box3(x_h0, -W_h / 2 + sc(150, 0.8), tbs + H_h - sc(100, 0.5), x_h1, W_h / 2 - sc(150, 0.8), tbs + H_h - sc(100, 0.5) + e);
                box3(x_h0 - sc(100, 0.5), -W_h / 2 + sc(100, 0.5), tbs + H_h, x_h1 + sc(100, 0.5), W_h / 2 - sc(100, 0.5), tbs + H_h + max(sc(120), 0.8));
            }
            box3(xb0, -W_h * 0.45, tbs - e, x_h0 + e, W_h * 0.45, tbs + cw_h);          // Gegengewicht
            // Führerhaus mit schräger Front
            box3(x_t0 - lw_t / 2, cab_y0, 0, x_p + sc(300), cab_y1, tbs);              // Bühne unter dem Führerhaus
            translate([0, 0, tbs - e]) hull() {
                box3(x_t0 - lw_t / 2 + sc(200), cab_y0, 0, x_p - sc(400), cab_y1, cab_h);
                box3(x_t0 - lw_t / 2 + sc(200), cab_y0, 0, x_p + sc(100), cab_y1, cab_h * 0.55);
            }
            // Lagerlaschen der Zahnstangen
            for (sy = [-1, 1], o = [-1, 1]) translate([0, sy * y_r + o * (tr / 2 + cl + lt / 2), 0])
                rotate([90, 0, 0]) linear_extrude(lt, center = true) hull() {
                    translate(K) circle(r = rbp);
                    translate([x_k - rbp * 2.2, tbs - 1]) square([rbp * 4.4, 1]);
                }
        }
        // Löcher der Laschen (Tropfen, Spitze nach oben)
        for (sy = [-1, 1]) translate([0, sy * y_r, 0]) rotate([90, 0, 0])
            linear_extrude(tr + 2 * cl + 2 * lt + 2, center = true) translate(K) rotate(90) teardrop(hole_d / 2);
        rack_slot();
        // Königszapfen (fest) und Turmzapfen-Löcher
        translate([0, 0, -1]) cylinder(d = d_pin + 0.05, h = tbs * 0.7 + 1);
        for (sy = [-1, 1]) turm_fuesse(sy, spiel, -1);
        // Fenster und Tür (Vertiefungen)
        wv = min(max(sc(30), 0.4), sc(150, 0.8) * 0.8);
        for (sy = [-1, 1], k = [0, 1]) translate([x_h0 + L_h * (0.2 + 0.45 * k), sy > 0 ? W_h / 2 - sc(150, 0.8) - wv : -(W_h / 2 - sc(150, 0.8)) - 1, tbs + H_h * 0.45])
            cube([L_h * 0.25, wv + 1, H_h * 0.3]);
        translate([x_t0 - lw_t / 2 + sc(500), cab_y1 - wv, tbs + cab_h * 0.6]) cube([sc(900), wv + 1, cab_h * 0.3]);
    }
}
// Turmfüße als Zapfen (sy = Seite)
module turm_fuesse(sy, sp, zoff) {
    for (xf = [x_t0, x_p]) translate([xf - lw_t * 0.35 - sp, sy * yT - tt / 2 - sp, tbs - tn_t - 0.2])
        cube([lw_t * 0.7 + 2 * sp, tt + 2 * sp, tn_t + 1]);
}
function info_drehbuehne() = let(SX = xb1 - xb0, SY = W_h / 2 + cab_y1, ox = -xb0, oy = W_h / 2, m = 1.5,
    kp = concat([[ox - d_pin / 2 - m, oy - d_pin / 2 - m, ox + d_pin / 2 + m, oy + d_pin / 2 + m]],
                [for (sy = [-1, 1], xf = [x_t0, x_p]) [ox + xf - lw_t / 2 - m, oy + sy * yT - tt / 2 - m, ox + xf + lw_t / 2 + m, oy + sy * yT + tt / 2 + m]]))
    [SX, SY, seams(SX), seams(SY), kp, false, 0, []];
module drehbuehne_druck() translate([-xb0, W_h / 2, 0]) drehbuehne();

// ---- Turmseite (2D in x, z) ----
t_lv = [0.33, 0.66];                         // Riegel-Höhen
tr_z = tbs + Ht * 0.42;                      // Traverse
function rear_x(z) = x_t0 + (x_p - x_t0) * (z - tbs) / Ht;
tvq = max(sc(300), 2.5);                     // Traversen-Querschnitt
module turm_2d() {
    difference() {
        union() {
            translate([x_p - lw_t / 2, tbs]) square([lw_t, Ht]);                     // vorderes Bein
            bar([x_t0, tbs + lw_t / 2], [x_p, z_p], lw_t);                            // hinteres Bein
            translate([x_t0 - lw_t / 2, tbs]) square([lw_t, lw_t]);
            for (f = t_lv) bar([rear_x(tbs + f * Ht), tbs + f * Ht], [x_p, tbs + f * Ht], dw * 1.5);
            bar([x_t0, tbs + lw_t / 2], [x_p, tbs + t_lv[0] * Ht], dw * 1.3);
            bar([rear_x(tbs + t_lv[0] * Ht), tbs + t_lv[0] * Ht], [x_p, tbs + t_lv[1] * Ht], dw * 1.3);
            translate([x_p, z_p]) circle(r = rbp);
            translate([rear_x(tr_z), tr_z]) square(tvq + 2 * spiel + 2 * max(1.2, sc(100)), center = true);
            for (xf = [x_t0, x_p]) translate([xf - lw_t * 0.35, tbs - tn_t]) square([lw_t * 0.7, tn_t + e]);
        }
        translate([x_p, z_p]) circle(d = hole_d);
        translate([rear_x(tr_z), tr_z]) square(tvq + 2 * spiel, center = true);
    }
}
t_xmin = x_t0 - lw_t / 2; t_zmin = tbs - tn_t;
module turm_welt(sy) translate([0, sy * yT + tt / 2, 0]) rotate([90, 0, 0]) linear_extrude(tt) turm_2d();
module turm_druck() linear_extrude(tt) translate([-t_xmin, -t_zmin]) turm_2d();
function info_turm() = let(SX = x_p + rbp - t_xmin, SY = z_p + rbp - t_zmin,
    S = [[x_p - lw_t / 2 - t_xmin, tbs - t_zmin, x_p + lw_t / 2 - t_xmin, z_p - rbp - t_zmin]],
    kp = [[rear_x(tr_z) - tvq - t_xmin, tr_z - tvq - t_zmin, rear_x(tr_z) + tvq - t_xmin, tr_z + tvq - t_zmin]])
    [SX, SY, seams(SX), seams(SY), kp, false, 0, S];

// Traverse (verbindet die Turmseiten, Zapfen durch beide Seiten)
module traverse() {
    l_in = 2 * (yT - tt / 2) - 2 * spiel;
    translate([-tvq / 2, -l_in / 2, -tvq / 2]) cube([tvq, l_in, tvq]);
    for (sy = [-1, 1]) translate([-tvq / 2, sy > 0 ? l_in / 2 - e : -l_in / 2 - tt - spiel, -tvq / 2]) cube([tvq, tt + spiel + e, tvq]);
}
module traverse_welt() translate([rear_x(tr_z), 0, tr_z]) traverse();

// =====================================================================
//  AUSLEGER  (2D in s, n; Breite w_j)
// =====================================================================
j_seams_s = jib_split ? [for (x = seams(L_j + h_h / 2 + fe + 1, pj, fe + 0.5)) x - fe - 0.5] : [];
function top_c(q) = hj(q) / 2 - cd / 2;
function bot_c(q) = -hj(q) / 2 + cd / 2;
sh_p = [-fe, 0, s1, s2, L_j];
module gurt(sign) {
    pts = [for (q = sh_p) [q, sign * hj(q) / 2]];
    pts2 = [for (i = [len(sh_p) - 1 : -1 : 0]) [sh_p[i], sign * (hj(sh_p[i]) / 2 - cd)]];
    polygon(concat(pts, pts2));
}
nodes = [for (k = [1 : 1 : floor((L_j - h_h) / pj)]) k * pj];
module ausleger_2d() {
    difference() {
        union() {
            gurt(1); gurt(-1);
            // Fußstück und Kopf
            hull() { circle(r = fe); translate([fe * 0.5, -hj(0) / 2]) square([e, hj(0)]); }
            translate([L_j - h_h, -h_h / 2]) square([h_h, h_h]);
            translate([L_j, 0]) circle(r = h_h / 2);
            // Fachwerk
            nl = concat([fe], nodes, [L_j - h_h]);
            for (i = [0 : len(nl) - 2]) {
                a = nl[i]; b = nl[i + 1];
                bar([a, i % 2 == 0 ? bot_c(a) : top_c(a)], [b, i % 2 == 0 ? top_c(b) : bot_c(b)], dw);
            }
            for (q = nodes) bar([q, bot_c(q)], [q, top_c(q)], dw * 0.9);
            for (q = j_seams_s) translate([q - spw / 2, -hj(q) / 2]) square([spw, hj(q)]);   // Stoßplatte
            // Anlenkpunkt der Zahnstangen
            hull() { translate([sJ, nJ]) circle(r = rj); translate([sJ - rj * 1.5, bot_c(sJ) - cd / 2]) square([rj * 3, cd]); }
        }
        circle(d = hole_d);
        translate([sJ, nJ]) circle(d = hole_d);
        translate([L_j + h_h * 0.15, 0]) circle(d = max(sc(60), 1.0));   // Seilloch
    }
}
module ausleger_lokal() translate([0, w_j / 2, 0]) rotate([90, 0, 0]) linear_extrude(w_j) ausleger_2d();
module ausleger_druck() diag_druck(jib_SX, jib_SY) linear_extrude(w_j) translate([fe + 0.5, -j_ymin]) ausleger_2d();
function info_ausleger() = let(SX = L_j + h_h / 2 + fe + 1, SY = j_ymax - j_ymin, ox = fe + 0.5, oy = -j_ymin,
    S = [for (q = j_seams_s) [q - spw / 2 + ox, -hj(q) / 2 + oy, q + spw / 2 + ox, hj(q) / 2 + oy]],
    kp = [[sJ - rj * 2 + ox, -1, sJ + rj * 2 + ox, SY + 1]])
    [SX, SY, [for (q = j_seams_s) q + ox], [], kp, false, 0, S];

// =====================================================================
//  ZAHNSTANGE  (2D: Loch J bei x = 0, Raster-Löcher bei DI)
// =====================================================================
tooth = max(sc(80), 0.6);
module wippstange_2d() {
    difference() {
        union() {
            hull() { circle(d = rw); translate([rack_len - rw / 2, 0]) circle(d = rw); }
            for (k = [0 : 1 : floor((rack_len - rw) / (2 * tooth)) - 1])
                translate([rw / 2 + k * 2 * tooth, rw / 2 - e]) polygon([[0, 0], [2 * tooth, 0], [tooth, tooth]]);
        }
        circle(d = hole_d);
        for (d = DI) translate([d, 0]) circle(d = hole_d);
    }
}
module wippstange_druck() diag_druck(rack_len + rw / 2, rw + tooth) linear_extrude(tr) translate([rw / 2, rw / 2]) wippstange_2d();
function info_wippstange() = let(SX = rack_len + rw / 2, SY = rw + tooth,
    kp = concat([[rw / 2 - hole_d, -1, rw / 2 + hole_d, SY + 1]], [for (d = DI) [d + rw / 2 - hole_d / 2 - 1, -1, d + rw / 2 + hole_d / 2 + 1, SY + 1]]))
    [SX, SY, SX > usable && !diag_ok(SX, SY) ? seams(SX) : [], [], kp, false, 0, []];

// =====================================================================
//  HAKEN, ZAPFEN, SCHIENE
// =====================================================================
module haken_2d() {
    difference() {
        union() {
            offset(r = hk_w * 0.1) offset(delta = -hk_w * 0.1) translate([-hk_w / 2, 0]) square([hk_w, hk_h * 0.55]);
            translate([0, -hk_h * 0.05]) square([hk_w * 0.18, hk_h * 0.12], center = true);
            translate([0, -hk_h * 0.3]) difference() {
                circle(r = hk_w * 0.3);
                circle(r = hk_w * 0.14);
                translate([0, -hk_w * 0.02]) square([hk_w, hk_w * 0.14]);
            }
        }
        translate([0, hk_h * 0.45]) circle(d = max(sc(60), 1.0));
        for (sx = [-1, 1]) translate([sx * hk_w * 0.22, hk_h * 0.25]) circle(r = hk_w * 0.14);
    }
}
module haken_druck() linear_extrude(hk_t) translate([hk_w / 2, hk_w * 0.62]) haken_2d();
l_pin = tpl + h_ring + tbs * 0.7 - 0.3;
module zapfen() { cylinder(d = d_pin, h = l_pin); }

module schiene_seg(L) {
    difference() {
        union() {
            box3(0, -beam_w / 2, 0, L, beam_w / 2, bh);
            translate([0, 0, bh - e]) rotate([90, 0, 90]) linear_extrude(L)
                polygon([[-rail_w * 0.9, 0], [rail_w * 0.9, 0], [rail_w * 0.25, rail_h * 0.25], [rail_w * 0.25, rail_h * 0.7 - rail_w * 0.25],
                         [rail_w / 2, rail_h * 0.7], [rail_w / 2, rail_h], [-rail_w / 2, rail_h], [-rail_w / 2, rail_h * 0.7],
                         [-rail_w * 0.25, rail_h * 0.7 - rail_w * 0.25], [-rail_w * 0.25, rail_h * 0.25]]);   // Kopf unten 45°
        }
        rb_slot();
        translate([L, 0, 0]) rotate([0, 0, 180]) rb_slot();
    }
}
SCHL = sc(schienen_laenge_m * 1000, 40);
SCHN = max(1, ceil(SCHL / usable));
SCHS = SCHL / SCHN;

// =====================================================================
//  Zusammenbau
// =====================================================================
C_STAHL = fhex(farbe_stahl); C_HELL = fhex(farbe_hell); C_DUNKEL = fhex(farbe_dunkel); C_BETON = fhex(farbe_schiene); C_SCHIENE = fhex(farbe_schiene);
stufe = max(1, min(len(wippwinkel), vorschau_stufe));
TH = wippwinkel[stufe - 1];

module oberwagen(th, ex = 0) {
    color(C_HELL) drehbuehne();
    color(C_STAHL) { translate([0, -ex, ex]) turm_welt(-1); translate([0, ex, ex]) turm_welt(1); }
    color(C_DUNKEL) translate([0, 0, ex]) traverse_welt();
    color(C_STAHL) translate([x_p + ex, 0, z_p + 2 * ex]) rotate([0, -th, 0]) ausleger_lokal();
    // Zahnstangen
    J = Jp(th); d = dist(J, K); ph = atan2(J[1] - K[1], J[0] - K[0]);
    color(C_DUNKEL) if (ex == 0) for (sy = [-1, 1])
        translate([J[0], sy * y_r + tr / 2, J[1]]) rotate([90, 0, 0]) rotate([0, 0, ph + 180]) linear_extrude(tr) wippstange_2d();
    // Haken am Faden
    if (ex == 0) {
        tip = [x_p + (L_j + h_h * 0.15) * cos(th), z_p + (L_j + h_h * 0.15) * sin(th)];
        zh = z_os + 0 + (tip[1]) * haken_hoehe;
        color("#222") translate([tip[0], 0, zh + hk_h * 0.45]) cylinder(d = 0.3, h = tip[1] - zh - hk_h * 0.45);
        color(fhex(farbe_haken)) translate([tip[0], hk_t / 2, zh]) rotate([90, 0, 0]) linear_extrude(hk_t) haken_2d();
    }
}
module portal(ex = 0) {
    for (sx = [-1, 1], sy = [-1, 1]) color(C_DUNKEL) translate([sx * Rx / 2, sy * Gy / 2, -ex]) fahrwerk();
    color(C_STAHL) { seite_welt(-1); translate([0, 2 * ex, 0]) seite_welt(1); }
    color(C_STAHL) for (sx = [-1, 1]) translate([0, 0, ex]) quer_welt(sx);
    color(C_HELL) translate([0, 0, 2 * ex]) plattform_welt();
    color(fhex(farbe_zapfen)) translate([0, 0, z_os - l_pin + tbs * 0.7 + 3 * ex]) zapfen();
}
module kran(th, rot, ex = 0) {
    translate([0, 0, rail_top]) {
        portal(ex);
        translate([0, 0, z_os + 4 * ex]) rotate([0, 0, rot]) oberwagen(th, ex);
    }
    for (sy = [-1, 1]) for (i = [0 : SCHN - 1])
        translate([-SCHL / 2 + i * SCHS, sy * Gy / 2, -ex]) { color(C_BETON) schiene_seg(SCHS); }
}

// =====================================================================
//  Info & Ausgabe
// =====================================================================
INFOS = [["portal_seite", info_seite(), 2], ["portal_quer", info_quer(), 2], ["plattform", info_plattform(), 1],
         ["drehbuehne", info_drehbuehne(), 1], ["turm", info_turm(), 2], ["ausleger", info_ausleger(), 1],
         ["wippstange", info_wippstange(), 2]];
CLIPS = lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
function info_of(n) = [for (i = INFOS) if (i[0] == n) i[1]][0];
H_ges = rail_top + z_os + z_p + (L_j + h_h / 2) * sin(max(wippwinkel));

echo(str("Hafenkran 1:", den, " | Portal ", r2(Rx), " × ", r2(Gy), " mm, lichte Höhe ", r2(zt - hg), " mm | Ausleger ", r2(L_j), " mm | max. Höhe ", r2(H_ges), " mm"));
echo(str("Wippstufen ", wippwinkel, "° -> Lochabstände ", [for (d = DI) r2(d)], " mm (kleinster Abstand ", r2(mindiff(DI)), " mm)"));
if (mindiff(DI) < hole_d + 1.2) echo("WARNUNG: Zwei Wippwinkel liegen zu dicht – Löcher überlappen. Winkel weiter auseinander wählen.");
echo(str("Stifte (Ø ", stift_d, "): Auslegerlager ", r2(w_j + 2 * (cl + tt) + 1), " mm, Zahnstange am Ausleger ", r2(2 * y_r + tr + 1),
         " mm, 2x Lager ", r2(tr + 2 * (cl + lt) + 1), " mm"));
echo(str("Kranschiene: 2 Stränge à ", SCHN, " Segment(e) à ", r2(SCHS), " mm"));
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
echo(str("Verbinder-Clips für geteilte Teile: ", CLIPS, " (+ ", 2 * max(0, SCHN - 1), " für die Schienenstöße)"));

// Druckliste für farb_export.py / Anleitung: DRUCK|teil|stücke|farbteil|farbe|menge
module druck(t, n, fp, f, m) if (m > 0) echo(str("DRUCK|", t, "|", n, "|", fp, "|", f, "|", m));
NCL = max(CLIPS + 2 * max(0, SCHN - 1), 4);
druck("schiene", 1, "alle", farbe_schiene, 2 * SCHN);
druck("fahrwerk", 1, "alle", farbe_dunkel, 4);
druck("portal_seite", n_pieces(info_seite()), "alle", farbe_stahl, 2);
druck("portal_quer", n_pieces(info_quer()), "alle", farbe_stahl, 2);
druck("plattform", n_pieces(info_plattform()), "alle", farbe_hell, 1);
druck("zapfen", 1, "alle", farbe_zapfen, 1);
druck("drehbuehne", n_pieces(info_drehbuehne()), "alle", farbe_hell, 1);
druck("turm", n_pieces(info_turm()), "alle", farbe_stahl, 2);
druck("traverse", 1, "alle", farbe_dunkel, 1);
druck("ausleger", n_pieces(info_ausleger()), "alle", farbe_stahl, 1);
druck("wippstange", n_pieces(info_wippstange()), "alle", farbe_dunkel, 2);
druck("hakenflasche", 1, "alle", farbe_haken, 1);
if (NCL > 0) druck("verbinder", 1, "alle", farbe_clips, 1);
for (f = FARBEN) echo(str("FARBE|", f[0], "|", f[1]));

if (teil == "aufbau") kran(TH, drehung);
else if (teil == "explosion") kran(TH, 0, max(sc(1500), 10));
else if (teil == "portal_seite") split_out(info_seite(), stueck) seite_druck();
else if (teil == "portal_quer") split_out(info_quer(), stueck) quer_druck();
else if (teil == "plattform") split_out(info_plattform(), stueck) plattform_druck();
else if (teil == "fahrwerk") fahrwerk();
else if (teil == "drehbuehne") split_out(info_drehbuehne(), stueck) drehbuehne_druck();
else if (teil == "turm") split_out(info_turm(), stueck) turm_druck();
else if (teil == "traverse") translate([0, 0, tvq / 2]) rotate([0, 0, 90]) traverse();
else if (teil == "ausleger") split_out(info_ausleger(), stueck) ausleger_druck();
else if (teil == "wippstange") split_out(info_wippstange(), stueck) wippstange_druck();
else if (teil == "hakenflasche") haken_druck();
else if (teil == "zapfen") zapfen();
else if (teil == "schiene") schiene_seg(SCHS);
else if (teil == "verbinder") {
    n = NCL;
    nx = ceil(sqrt(n));
    for (i = [0 : n - 1]) translate([(i % nx) * (cL + 3), floor(i / nx) * (cw1 + 3), 0]) clip();
}
