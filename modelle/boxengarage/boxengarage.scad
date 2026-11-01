// =====================================================================
//  BOXENGARAGE  –  modularer Deko-Bausatz für Rennbahnen
//  beliebig viele Boxen nebeneinander, parametrisch, alle Maßstäbe,
//  FDM-optimiert (stützfrei), Stecksystem wie rennbahn_deko.scad
//  OpenSCAD >= 2021.01
// =====================================================================
//
//  MODULSYSTEM  (n Boxen)
//    boden          Bodenplatte mit Vorplatz und Markierung      n x
//    rueckwand      Rückwand mit Tür und Fenstern                n x
//    torblende      Fassade über dem Tor (Teamname, Boxnummer)   n x
//    tor            Rolltor, verschiebbar, versenkt sich         n x
//    dach           Dachplatte                                   n x
//    gelaender      Dachgeländer (optional)                      n x
//    trennwand      Wand zwischen zwei Boxen                 (n-1) x
//    endwand_links / endwand_rechts   Gebäudeabschluss          je 1 x
//
//  Die Bodenplatten werden seitlich mit Clips verbunden. Trennwände
//  stehen genau auf der Fuge zweier Platten (je halbe Nut) – so wächst
//  die Reihe Box für Box. Die Endwände reichen außen bis zum Boden und
//  über das Dach (Attika).
//
//  MONTAGE
//    1. Bodenplatten verclipsen.
//    2. Endwände und Trennwände in die Fugen-Nuten stellen.
//    3. Rückwände, Rolltore und Torblenden von oben in die senkrechten
//       Nuten der Wände schieben.
//    4. Dächer auflegen (halten alles zusammen), Geländer einstecken.
//    Das Rolltor gleitet nach oben hinter die Blende und bleibt durch
//    zwei Federzungen in jeder Höhe stehen.
//
//  DRUCK  –  alle Teile druckfertig und stützfrei ausgerichtet:
//    Platten flach, Wände liegend, Dach kopfüber, Endwände mit der
//    Außenseite nach unten. Zu große Teile werden automatisch mit
//    Clip-Taschen geteilt (stueck = 1..n, Konsole zeigt die Anzahl).
// =====================================================================

/* [Maßstab] */
// Maßstab 1/x
massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]
eigener_massstab = 50;

/* [Ausgabe] */
teil = "aufbau"; // [aufbau:Aufbau (Vorschau), explosion:Explosion (1 Box), boden:Bodenplatte, trennwand:Trennwand, endwand_links:Endwand links, endwand_rechts:Endwand rechts, rueckwand:Rückwand, torblende:Torblende, tor:Rolltor, dach:Dach, gelaender:Dachgeländer, zubehoer:Zubehör, verbinder:Verbinder-Clips]
// Geteilte Teile: 0 = alle Stücke, 1..n = einzelnes Stück
stueck = 0;
// Mehrfarbig: A = Grundfarbe, B = Markierung / Schrift / Fenster
farbteil = "alle"; // [alle, A, B]

/* [Boxengarage] */
// Anzahl Boxen (Vorschau und Stückliste)
anzahl_boxen = 3; // [1:12]
breite_m = 5.5;
tiefe_m = 6.5;
vorplatz_m = 1.0;
tor_hoehe_m = 3.5;
// Tor verschwindet ganz hinter der Blende (zweigeschossige Fassade)
tor_versenkbar = true;
team_text = "RACING";
box_nummer = 1;
schrift = "Liberation Sans:style=Bold";
dach_gelaender = true;
bodenmarkierung = true;
fenster = true;

/* [Rolltor] */
// Öffnung je Box in der Vorschau (0 = zu, 1 = offen)
tor_offen = [1, 0.45, 0];
// Federzungen halten das Tor in jeder Höhe
tor_federn = true;
// Anpressung der Federzungen (mm)
tor_klemmung = 0.25;

/* [Zubehör] */
werkzeugwagen = 2;    // [0:8]
werkbaenke = 1;       // [0:4]
reifenstapel = 2;     // [0:8]
wagenheber = 1;       // [0:4]
unterstellboecke = 4; // [0:8]
tankanlagen = 1;      // [0:4]
oelfaesser = 2;       // [0:8]
feuerloescher = 2;    // [0:8]
datenstationen = 1;   // [0:4]
// Clips auf der Clip-Platte (0 = Bedarf laut Stückliste)
verbinder_anzahl = 0;

/* [Verbindung & Druck] */
rennbahn_taschen = true;
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

function conn_tab(d) =
    d <= 12 ? [20, 7, 12, 4] : d <= 20 ? [16, 6, 10, 3.2] : d <= 26 ? [14, 5, 9, 3] :
    d <= 36 ? [12, 4.5, 8, 2.5] : d <= 50 ? [10, 4, 7, 2] : [8, 3.2, 5.6, 1.6];
CT = conn_tab(den);
cL = CT[0]; cw0 = CT[1]; cw1 = CT[2]; ch = CT[3];
deck  = 0.8;
clipd = ch + spiel + deck;

// =====================================================================
//  Maße (Box 0 zentriert bei x = 0, Front bei y = 0, Boden bei z = 0)
// =====================================================================
B  = sc(breite_m * 1000, 30);        // Rastermaß einer Box
T  = sc(tiefe_m * 1000, 30);         // Gebäudetiefe
A  = max(sc(vorplatz_m * 1000), 0);  // Vorplatz
ho = sc(tor_hoehe_m * 1000, 12);     // Toröffnung
g   = max(sc(60), 1.2);              // Nuttiefe Boden/Dach
gdt = max(sc(60), 1.0);              // Nuttiefe in den Wänden
hb  = max(sc(150), g + clipd);       // Bodenplatte
ovd = max(sc(100), 1.0);
hd  = ho + ovd;                      // Torblatt-Höhe
Hg  = tor_versenkbar ? hb + ho + hd + max(sc(150), 1.0) : hb + ho + max(sc(1500), 6);
lift_max = Hg - 0.3 - hb - hd;
Hf  = Hg - hb - ho;                  // sichtbare Blendenhöhe

ov_f = max(sc(600), 3); ov_b = max(sc(200), 2);
par  = max(sc(250), 1.0);            // Attika der Endwände
roof_split = B > usable || T + ov_f + ov_b > usable;
rt = max(sc(200), g + 1.2, roof_split ? clipd : 0);

dm_rec = max(sc(20), 0.4);           // Fenster-Vertiefung
re     = max(sc(15), 0.4);           // Relief
r0     = max(sc(50), 0.8);           // Rücksprung Blende/Rückwand
web    = max(sc(40), 0.8);
panel_split = B > usable;
tfz = max(sc(80), 1.6, (panel_split || Hf + g > usable) ? clipd + dm_rec : 0);
ps  = max(sc(100), 1.0);             // Lamellenteilung Tor
sg  = max(sc(15), 0.3);
td  = max(sc(50), 1.2, (panel_split || hd > usable) ? clipd + 0.4 : 0);
sdp = min(max(sc(10), 0.3), td * 0.3);
tbw = max(sc(120), 1.6, (panel_split || Hg - hb + 2 * g > usable) ? clipd + re : 0);
wall_split = Hg + rt + par > usable || T > usable;
tw  = max(sc(250), 2 * gdt + 1.2, wall_split ? clipd : 0);

// Nut-Lagen (y)
yf0 = r0; yf1 = r0 + tfz;                   // Blende
yd  = yf1 + spiel + web + spiel;            // Torblatt
yb1 = T - r0; yb0 = yb1 - tbw;              // Rückwand
// Paneele zwischen den Wänden
xp0 = -B / 2 + tw / 2 - gdt + spiel;
xp1 = -xp0;
PW  = xp1 - xp0;
xi  = B / 2 - tw / 2;                       // Innenfläche der Wände

// Clips an der Plattenfuge
nj = max(2, round((A + T) / max(30, 4 * cw1)));
YJ = [for (k = [0 : nj - 1]) -A + (k + 0.5) * (A + T) / nj];
roof_clip = ov_f >= cw1 + 2 * spiel + 2;

// Geländer
hr   = sc(1100, 6);
gpw  = max(sc(60), 1.0);
grh  = max(sc(50), 0.8);
gt   = max(sc(50), 1.2);
gpl  = min(rt - 0.6, max(sc(100), 1.5));
gLen = B - gap - 2 * max(sc(100), 1);
gnp  = max(2, round(gLen / sc(1500, 12)) + 1);
gux  = [for (k = [0 : gnp - 1]) k * (gLen - gpw) / (gnp - 1)];
gy   = -ov_f + max(sc(150), 1.0) + gt;      // Geländerebene (Rückseite)
gx0  = -gLen / 2;

// =====================================================================
//  Hilfsgeometrie
// =====================================================================
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
module rb_slot() {
    w0 = cw0 / 2 + spiel; w1 = cw1 / 2 + spiel; l = cL / 2 + spiel;
    pts = [[-1, -w0], [0, -w0], [l, -w1], [l, w1], [0, w0], [-1, w0]];
    translate([0, 0, -e]) linear_extrude(ch + spiel + e) polygon(pts);
    translate([0, 0, -e]) linear_extrude(0.3 + e) offset(delta = 0.3) polygon(pts);
}
module box3(x0, y0, z0, x1, y1, z1) translate([x0, y0, z0]) cube([x1 - x0, y1 - y0, z1 - z0]);
module fit_text(txt, w, h) {
    sz = min(h, w / max(1, len(txt) * 0.68));
    text(txt, size = sz, font = schrift, halign = "center", valign = "center");
}

// =====================================================================
//  Automatische Teilung mit Clips (wie imbissbude.scad)
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
function n_pieces(info) = (len(info[2]) + 1) * (len(info[3]) + 1);
function clip_count(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4])
    lsum([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp))]) +
    lsum([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp))]);
function zero_seams(info) = let(SX = info[0], SY = info[1], xs = info[2], ys = info[3], kp = info[4])
    len([for (k = [0 : 1 : len(xs) - 1], iy = [0 : len(ys)]) if (len(clips_v(xs[k], band_a(ys, iy), band_b(ys, iy, SY), kp)) == 0) 1]) +
    len([for (k = [0 : 1 : len(ys) - 1], ix = [0 : len(xs)]) if (len(clips_h(ys[k], band_a(xs, ix), band_b(xs, ix, SX), kp)) == 0) 1]);

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
                intersection() { children(); translate([bx0, by0, -500]) cube([bx1 - bx0, by1 - by0, 1000]); }
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
mk = max(sc(10), 0.4);               // Markierungstiefe
lw = max(sc(100), 1.0);              // Linienbreite
module markierung_2d() {
    if (A >= 3 * lw) translate([xp0 + gdt, -2 * lw]) square([PW - 2 * gdt, lw]);
    fx0 = -xi + sc(500, 2); fx1 = xi - sc(500, 2);
    fy0 = yd + td + sc(500, 2); fy1 = yb0 - sc(800, 3);
    if (fx1 - fx0 > 4 * lw && fy1 - fy0 > 4 * lw)
        difference() {
            translate([fx0, fy0]) square([fx1 - fx0, fy1 - fy0]);
            translate([fx0 + lw, fy0 + lw]) square([fx1 - fx0 - 2 * lw, fy1 - fy0 - 2 * lw]);
        }
}
module boden_roh() {
    difference() {
        box3(-B / 2 + gap / 2, -A, 0, B / 2 - gap / 2, T, hb);
        // halbe Nuten für die Wände an beiden Seiten
        box3(-B / 2 - 1, -spiel, hb - g, -B / 2 + tw / 2 + spiel, T + 1, hb + 1);
        box3(B / 2 - tw / 2 - spiel, -spiel, hb - g, B / 2 + 1, T + 1, hb + 1);
        // Nut für die Rückwand
        box3(-xi, yb0 - spiel, hb - g, xi, yb1 + spiel, hb + 1);
        // Clip-Taschen an den Plattenfugen
        for (sx = [-1, 1], y = YJ) translate([sx * B / 2, y, 0]) clip_cut(0, false, 0);
        if (rennbahn_taschen && A >= cw1 + 2) translate([0, -A, 0]) rotate([0, 0, 90]) rb_slot();
    }
}
module boden_welt(fp = "alle") {
    if (inc(fp, "A")) difference() {
        boden_roh();
        if (bodenmarkierung) translate([0, 0, hb - mk]) linear_extrude(mk + 1) markierung_2d();
    }
    if (fp == "B" && bodenmarkierung)
        intersection() { boden_roh(); translate([0, 0, hb - mk]) linear_extrude(mk) markierung_2d(); }
}
module boden_druck(fp) translate([B / 2, A, 0]) boden_welt(fp);
function info_boden() = let(SY = A + T,
    kp = concat([for (sx = [0, B], y = YJ) [sx - cL / 2 - 1, y + A - cw1 / 2 - 1, sx + cL / 2 + 1, y + A + cw1 / 2 + 1]],
                rennbahn_taschen ? [[B / 2 - cw1, -1, B / 2 + cw1, cL]] : []))
    [B, SY, seams(B, 0), seams(SY, 0), kp, false, 0];

// =====================================================================
//  WÄNDE  (lokal: a = Dicke ab Druckbett-Seite, y, z wie Welt)
// =====================================================================
zb = hb - g + spiel;                 // Unterkante Wand (Zapfen)
zt = Hg + g - spiel;                 // Oberkante Wand (Zapfen)
ze = Hg + rt + par;                  // Oberkante Endwand außen
// Fenster der Endwand (Obergeschoss)
ew_n  = max(1, floor(T / sc(2200, 18)));
ew_w  = min(sc(1200), T / ew_n * 0.6);
ew_z0 = hb + ho + (Hf - sc(1300)) / 2;
ew_h  = sc(1300);
ew_on = fenster && tor_versenkbar && Hf > sc(2200);
ew_rec = min(max(sc(30), 0.4), tw / 2 - 0.8);

module nuten(a0) {
    box3(a0, yf0 - spiel, hb + ho, a0 + gdt + 1, yf1 + spiel, 2000);
    box3(a0, yd - spiel, hb, a0 + gdt + 1, yd + td + spiel, 2000);
    box3(a0, yb0 - spiel, hb, a0 + gdt + 1, yb1 + spiel, 2000);
}
module wand_p(typ) {
    difference() {
        union() {
            if (typ == "trenn") box3(0, 0, zb, tw, T, zt);
            else {
                box3(tw / 2 - e, 0, zb, tw, T, zt);          // innere Hälfte
                box3(0, 0, 0, tw / 2, T, ze);                 // äußere Hälfte bis Boden/Attika
            }
        }
        if (typ == "trenn") nuten(-1);
        nuten(tw - gdt);
        if (typ == "end" && ew_on)
            for (k = [0 : ew_n - 1]) {
                yc = (k + 0.5) * T / ew_n;
                box3(-1, yc - ew_w / 2, ew_z0, ew_rec, yc + ew_w / 2, ew_z0 + ew_h);
            }
    }
}
// Platzierung: Trennwand bei x = xc, Endwand links bei x = xc (Mitte der Wand)
module trennwand_welt(xc) translate([xc - tw / 2, 0, 0]) wand_p("trenn");
module endwand_l_welt(xc) translate([xc - tw / 2, 0, 0]) wand_p("end");
module endwand_r_welt(xc) translate([xc + tw / 2, 0, 0]) mirror([1, 0, 0]) wand_p("end");
// Druck: (a, y, z) -> (z - zmin, T - y, a)
module wand_druck_p(typ) {
    zmin = typ == "trenn" ? zb : 0;
    translate([-zmin, T, 0]) rotate([0, -90, 180]) wand_p(typ);
}
function wp(r, zmin) = [r[2] - zmin, T - r[3], r[4] - zmin, T - r[1]];   // r = [a?, y0, z0, y1, z1]
function info_wand_p(typ) = let(zmin = typ == "trenn" ? zb : 0, zmax = typ == "trenn" ? zt : ze,
    m = spiel + 1,
    kp = concat(
        [wp([0, yf0 - m, hb + ho - 1, yf1 + m, 2000], zmin), wp([0, yd - m, hb - 1, yd + td + m, 2000], zmin),
         wp([0, yb0 - m, hb - 1, yb1 + m, 2000], zmin)],
        typ == "end" ? [[-1, -1, zb - zmin + 1.5, T + 1], [zt - zmin - 1.5, -1, zmax - zmin + 1, T + 1]] : [],
        typ == "end" && ew_on ? [for (k = [0 : ew_n - 1]) let(yc = (k + 0.5) * T / ew_n)
                                  wp([0, yc - ew_w / 2 - 1, ew_z0 - 1, yc + ew_w / 2 + 1, ew_z0 + ew_h + 1], zmin)] : []))
    [zmax - zmin, T, seams(zmax - zmin, 0), seams(T, 0), kp, false, 0];

// =====================================================================
//  PANEELE  (lokal: u = Breite, v = Höhe, w = Dicke, außen bei w = Dicke)
// =====================================================================
// ---------- Torblende ----------
bl_win = fenster && Hf > sc(2500);
bl_tv0 = bl_win ? Hf * 0.1 : Hf * 0.15;
bl_tv1 = bl_win ? Hf * 0.42 : Hf * 0.85;
bl_wv0 = Hf * 0.52; bl_wv1 = Hf * 0.86;
bl_n   = max(1, floor((PW - 2 * gdt) / sc(1600, 14)));
bl_mul = max(sc(120), 0.8);
function bl_panes() = let(w = (PW - 2 * gdt - (bl_n + 1) * bl_mul) / bl_n)
    [for (k = [0 : bl_n - 1]) [gdt + bl_mul + k * (w + bl_mul), bl_wv0, gdt + bl_mul + k * (w + bl_mul) + w, bl_wv1]];

module blende_local(fp, nr = box_nummer) {
    th = bl_tv1 - bl_tv0;
    nb = th;                                   // Nummernfeld (quadratisch)
    if (inc(fp, "A")) difference() {
        union() {
            cube([PW, Hf, tfz]);
            translate([gdt, Hf - e, 0]) cube([PW - 2 * gdt, g - spiel + e, tfz]);
        }
        if (bl_win) for (p = bl_panes()) translate([p[0], p[1], tfz - dm_rec]) cube([p[2] - p[0], p[3] - p[1], dm_rec + 1]);
    }
    if (fp == "B" && bl_win) for (p = bl_panes()) translate([p[0], p[1], tfz - dm_rec]) cube([p[2] - p[0], p[3] - p[1], dm_rec]);
    if (inc(fp, "B")) translate([0, 0, tfz - e]) linear_extrude(re + e) {
        // Boxnummer im Rahmen
        translate([gdt + nb * 0.1, bl_tv0]) difference() {
            square([nb, th]);
            translate([max(sc(40), 0.6), max(sc(40), 0.6)]) square([nb - 2 * max(sc(40), 0.6), th - 2 * max(sc(40), 0.6)]);
        }
        translate([gdt + nb * 0.6, bl_tv0 + th / 2]) fit_text(str(nr), nb * 0.75, th * 0.6);
        // Teamname
        tx0 = gdt + nb * 1.3; tx1 = PW - gdt - nb * 0.2;
        translate([(tx0 + tx1) / 2, bl_tv0 + th / 2]) fit_text(team_text, tx1 - tx0, th * 0.55);
    }
}
module blende_welt(fp = "alle", nr = box_nummer) translate([xp0, yf1, hb + ho]) rotate([90, 0, 0]) blende_local(fp, nr);
function info_blende() = let(SY = Hf + g - spiel,
    kp = concat([[-1, Hf - 1.5, PW + 1, SY + 1]], bl_win ? [for (p = bl_panes()) [p[0] - 1, p[1] - 1, p[2] + 1, p[3] + 1]] : []))
    [PW, SY, seams(PW, 0), seams(SY, 0), kp, false, 0];

// ---------- Rolltor ----------
tor_vf = [hd * 0.25, hd * 0.75];            // Federzungen
fz_ws = 0.75; fz_sw = 0.6; fz_r = (0.75 - 0.05 + tor_klemmung) / 2;
fz_l  = min(hd * 0.22, max(sc(400), 6));
tv_v0 = hd * 0.55; tv_h = max(sc(300), 1.2);
tv_n  = max(1, floor((PW - 2 * gdt) / sc(900, 8)));
module tor_local() {
    difference() {
        cube([PW, hd, td]);
        // Lamellen
        for (k = [1 : 1 : floor(hd / ps - 0.01)])
            if (k * ps - sg > max(sc(150), 1.0) && (k * ps + sg < tv_v0 || k * ps - sg > tv_v0 + tv_h))
                translate([gdt, k * ps - sg / 2, td - sdp]) cube([PW - 2 * gdt, sg, sdp + 1]);
        // Sichtfenster
        for (k = [0 : tv_n - 1]) let(w = (PW - 2 * gdt) / tv_n)
            translate([gdt + k * w + w * 0.2, tv_v0, td - min(dm_rec, td * 0.4)]) cube([w * 0.6, tv_h, dm_rec + 1]);
        // Schlitze der Federzungen
        if (tor_federn) for (v = tor_vf, u = [fz_ws, PW - fz_ws - fz_sw])
            translate([u, v - fz_l / 2, -1]) cube([fz_sw, fz_l, td + 2]);
    }
    // Bodenleiste und Griff
    translate([gdt, 0, td - e]) cube([PW - 2 * gdt, max(sc(150), 1.0), re + e]);
    translate([PW / 2 - max(sc(300), 2) / 2, max(sc(350), 2), td - e]) cube([max(sc(300), 2), max(sc(60), 0.6), re * 1.5 + e]);
    // Federnocken (stehen um tor_klemmung über die Kante)
    if (tor_federn) for (v = tor_vf) {
        translate([fz_r - tor_klemmung, v, 0]) cylinder(r = fz_r, h = td, $fn = 24);
        translate([PW - fz_r + tor_klemmung, v, 0]) cylinder(r = fz_r, h = td, $fn = 24);
    }
    // (Nocken bleiben auf dem Federsteg, ragen nicht in den Schlitz)
}
module tor_welt(lift = 0) translate([xp0, yd + td, hb + lift]) rotate([90, 0, 0]) tor_local();
function info_tor() = let(
    kp = concat([for (v = tor_vf) [-1, v - fz_l / 2 - 1, fz_ws + fz_sw + 1.5, v + fz_l / 2 + 1]],
                [for (v = tor_vf) [PW - fz_ws - fz_sw - 1.5, v - fz_l / 2 - 1, PW + 1, v + fz_l / 2 + 1]],
                [[-1, tv_v0 - 1, PW + 1, tv_v0 + tv_h + 1]]))
    [PW, hd, seams(PW, 0), seams(hd, ps), kp, false, 0];

// ---------- Rückwand ----------
rw_h   = Hg - hb;
rw_du  = PW * 0.72; rw_dw = min(sc(1000), PW * 0.25); rw_dh = min(sc(2100), ho * 0.85);
rw_win = fenster ? (tor_versenkbar
          ? [for (k = [0, 1]) [PW * (0.18 + k * 0.42), ho + sc(900), PW * (0.18 + k * 0.42) + min(sc(1600), PW * 0.3), ho + sc(900) + sc(1100)]]
          : [[PW * 0.15, sc(1100), PW * 0.15 + min(sc(1600), PW * 0.3), sc(1100) + sc(1000)]]) : [];
module rueckwand_local() {
    fgr = max(sc(25), 0.4);
    difference() {
        union() {
            cube([PW, rw_h, tbw]);
            translate([gdt, -(g - spiel), 0]) cube([PW - 2 * gdt, g - spiel + e, tbw]);
            translate([gdt, rw_h - e, 0]) cube([PW - 2 * gdt, g - spiel + e, tbw]);
        }
        for (o = rw_win) translate([o[0], o[1], -1]) cube([o[2] - o[0], o[3] - o[1], tbw + 2]);
        // Tür als Fuge
        translate([0, 0, tbw - min(re, tbw * 0.3)]) difference() {
            translate([rw_du - rw_dw / 2 - fgr, -1, 0]) cube([rw_dw + 2 * fgr, rw_dh + fgr + 1, 2]);
            translate([rw_du - rw_dw / 2, -2, -1]) cube([rw_dw, rw_dh + 2, 4]);
        }
    }
    // Fensterbänke und Türgriff
    for (o = rw_win) translate([o[0] - re, o[1] - max(sc(60), 0.6), tbw - e]) cube([o[2] - o[0] + 2 * re, max(sc(60), 0.6), re * 2 + e]);
    translate([rw_du + rw_dw / 2 - max(sc(150), 1), sc(1050), tbw - e]) cube([max(sc(40), 0.6), max(sc(160), 1.2), re * 2 + e]);
}
module rueckwand_welt() translate([xp1, yb0, hb]) rotate([90, 0, 180]) rueckwand_local();
module rueckwand_druck() translate([0, g - spiel, 0]) rueckwand_local();
function info_rueckwand() = let(SY = rw_h + 2 * (g - spiel), o = g - spiel,
    kp = concat([[-1, -1, PW + 1, o + 1.5], [-1, rw_h + o - 1.5, PW + 1, SY + 1]],
                [for (w = rw_win) [w[0] - 1, w[1] + o - 1, w[2] + 1, w[3] + o + 1]]))
    [PW, SY, seams(PW, 0), seams(SY, 0), kp, false, 0];

// =====================================================================
//  DACH  (kopfüber gedruckt) und GELÄNDER
// =====================================================================
module dach_welt() {
    difference() {
        box3(-B / 2 + gap / 2, -ov_f, Hg, B / 2 - gap / 2, T + ov_b, Hg + rt);
        box3(-B / 2 - 1, -spiel, Hg - 1, -B / 2 + tw / 2 + spiel, T + spiel, Hg + g);
        box3(B / 2 - tw / 2 - spiel, -spiel, Hg - 1, B / 2 + 1, T + spiel, Hg + g);
        box3(-xi, yf0 - spiel, Hg - 1, xi, yf1 + spiel, Hg + g);
        box3(-xi, yb0 - spiel, Hg - 1, xi, yb1 + spiel, Hg + g);
        if (dach_gelaender) for (u = gux)
            box3(gx0 + u - spiel, gy - gt - spiel, Hg + rt - gpl - 0.2, gx0 + u + gpw + spiel, gy + spiel, Hg + rt + 1);
        if (roof_clip) for (sx = [-1, 1]) translate([sx * B / 2, -ov_f / 2, Hg]) clip_cut(0, false, 0);
    }
}
module dach_druck() translate([B / 2, T + ov_b, Hg + rt]) rotate([180, 0, 0]) dach_welt();
function dp(r) = [r[0] + B / 2, T + ov_b - r[3], r[2] + B / 2, T + ov_b - r[1]];
function info_dach() = let(m = spiel + 1, SY = T + ov_f + ov_b,
    kp = concat(
        [dp([-B / 2 - 1, -m, -B / 2 + tw / 2 + m, T + m]), dp([B / 2 - tw / 2 - m, -m, B / 2 + 1, T + m]),
         dp([-xi - m, yf0 - m, xi + m, yf1 + m]), dp([-xi - m, yb0 - m, xi + m, yb1 + m])],
        dach_gelaender ? [for (u = gux) dp([gx0 + u - m, gy - gt - m, gx0 + u + gpw + m, gy + m])] : [],
        roof_clip ? [for (sx = [-1, 1]) dp([sx * B / 2 - cL, -ov_f / 2 - cw1, sx * B / 2 + cL, -ov_f / 2 + cw1])] : []))
    [B, SY, seams(B, 0), seams(SY, 0), kp, true, rt];

module gelaender_local() {
    for (u = gux) translate([u, -gpl, 0]) cube([gpw, hr + gpl, gt]);
    for (v = [hr - grh, hr * 0.5 - grh / 2, max(sc(100), 0.8)]) translate([0, v, 0]) cube([gLen, grh, gt]);
}
module gelaender_welt() translate([gx0, gy, Hg + rt]) rotate([90, 0, 0]) gelaender_local();
module gelaender_druck() translate([0, gpl, 0]) gelaender_local();

// =====================================================================
//  ZUBEHÖR (aufrecht, stützfrei)
// =====================================================================
module werkzeugwagen() {
    w = sc(800, 6); d = sc(500, 4); h = sc(1000, 7); wr = max(sc(60), 0.6); gr = max(sc(15), 0.3);
    for (sx = [-1, 1], sy = [-1, 1]) translate([sx * (w / 2 - wr * 1.5), sy * (d / 2 - wr * 1.5), 0]) cylinder(r = wr, h = 2 * wr + e, $fn = 16);
    difference() {
        box3(-w / 2, -d / 2, 2 * wr, w / 2, d / 2, h);
        for (k = [1 : 4]) box3(-w / 2 + gr * 2, -d / 2 - 1, 2 * wr + k * (h - 2 * wr) / 5.3, w / 2 - gr * 2, -d / 2 + gr, 2 * wr + k * (h - 2 * wr) / 5.3 + gr);
        box3(-w / 2 + gr * 2, -d / 2 + gr * 2, h - max(sc(40), 0.4), w / 2 - gr * 2, d / 2 - gr * 2, h + 1);
    }
    for (k = [0 : 4]) box3(-w * 0.2, -d / 2 - gr * 1.5, 2 * wr + (k + 0.6) * (h - 2 * wr) / 5.3, w * 0.2, -d / 2 + e, 2 * wr + (k + 0.6) * (h - 2 * wr) / 5.3 + gr * 1.5);
    box3(w / 2 - e, -d * 0.35, h * 0.75, w / 2 + max(sc(60), 0.8), d * 0.35, h * 0.95);
}
module werkbank() {
    w = sc(2000, 12); d = sc(700, 5); h = sc(900, 6); ol = max(sc(40), 0.5); tt = max(sc(50), 0.8); gr = max(sc(15), 0.3);
    difference() {
        box3(-w / 2, -d / 2, 0, w / 2, d / 2, h - tt - ol);
        for (k = [1 : 3], c = [0, 1]) box3(-w / 2 + gr * 2 + c * w / 2, -d / 2 - 1, k * (h - tt) / 4, -gr + c * w / 2, -d / 2 + gr, k * (h - tt) / 4 + gr);
    }
    hull() {
        box3(-w / 2, -d / 2, h - tt - ol, w / 2, d / 2, h - tt - ol + e);
        box3(-w / 2 - ol, -d / 2 - ol, h - tt, w / 2 + ol, d / 2 + ol, h);
    }
    box3(w * 0.3, -d / 2, h - e, w * 0.3 + sc(200, 1.5), -d / 2 + sc(150, 1.2), h + sc(150, 1.2));
    lb = max(sc(30), 1.0);
    difference() {
        box3(-w / 2, d / 2 - lb, h - e, w / 2, d / 2, h + sc(1000, 6));
        for (i = [1 : 1 : floor(w / sc(150, 1.5)) - 1], j = [1 : 1 : floor(sc(1000, 6) / sc(150, 1.5)) - 1])
            translate([-w / 2 + i * sc(150, 1.5), d / 2 - lb - 1, h + j * sc(150, 1.5)]) rotate([-90, 0, 0]) cylinder(d = max(sc(40), 0.5), h = lb * 0.6 + 1, $fn = 8);
    }
}
module reifen(r_o, wdt) {
    r_i = r_o * 0.6; rr = min(wdt, r_o - r_i) * 0.3;
    rotate_extrude($fn = 40) translate([r_i + rr, rr]) offset(r = rr, $fn = 12) square([r_o - r_i - 2 * rr, wdt - 2 * rr]);
    cylinder(r = r_i + e, h = wdt * 0.8);
}
module reifenstapel_m() {
    r = sc(330, 3); w = sc(330, 2.5);
    for (k = [0 : 3]) translate([0, 0, k * w * 0.98]) reifen(r, w);
    translate([0, 0, 3 * w * 0.98 + w * 0.8 - e]) cylinder(r = r * 0.2, h = max(sc(30), 0.4));
}
module wagenheber() {
    l = sc(800, 6); b = sc(300, 2.5); h = sc(150, 1.2); wr = h * 0.4;
    for (sx = [-1, 1], sy = [-1, 1]) translate([sx * (l / 2 - wr * 1.4), sy * (b / 2 - wr), 0]) cylinder(r = wr, h = 2 * wr + e, $fn = 16);
    box3(-l / 2, -b / 2, wr, l / 2, b / 2, wr + h);
    translate([l / 2 - sc(120, 1), 0, 0]) cylinder(r = sc(80, 0.8), h = wr + h * 1.8);
    hb_l = sc(800, 6); hq = max(sc(40), 0.8);
    translate([-l / 2, 0, wr + h / 2]) rotate([0, 45, 0]) translate([-hb_l, -hq / 2, -hq / 2]) cube([hb_l + hq, hq, hq]);
}
module unterstellbock() {
    a = sc(260, 2.5); hgt = sc(450, 3.5); tp = max(sc(70), 0.8);
    difference() {
        hull() { box3(-a / 2, -a / 2, 0, a / 2, a / 2, e); box3(-tp, -tp, hgt - e, tp, tp, hgt); }
        translate([0, 0, hgt]) rotate([90, 0, 0]) cylinder(r = tp * 0.7, h = 4 * tp, center = true, $fn = 4);
    }
}
module tankanlage() {
    w = sc(800, 6); d = sc(600, 4.5); h = sc(2000, 14); rr = sc(250, 2); rd = sc(120, 1.2);
    box3(-w / 2, -d / 2, 0, w / 2, d / 2, h);
    translate([0, -d / 2, h * 0.55]) hull() {
        rotate([90, 0, 0]) cylinder(r = rr, h = rd);
        translate([-rr, -rd, -rr - rd]) cube([2 * rr, rd, e]);
        translate([-rr, -e, -rr - rd]) cube([2 * rr, e, rr]);
    }
    box3(-w / 2, -d / 2 - max(sc(150), 1.2), 0, w / 2, d / 2 + max(sc(150), 1.2), max(sc(80), 0.8));
}
module oelfass() {
    r = sc(290, 2.5); h = sc(880, 6); rb = max(sc(10), 0.25);
    difference() {
        cylinder(r = r, h = h);
        translate([0, 0, h - max(sc(20), 0.3)]) cylinder(r = r - max(sc(25), 0.4), h = 1);
    }
    for (z = [h / 3, 2 * h / 3]) translate([0, 0, z - rb]) cylinder(r = r + rb, h = 2 * rb);
    translate([r * 0.5, 0, h - e]) cylinder(r = max(sc(30), 0.4), h = max(sc(20), 0.3));
}
module feuerloescher() {
    r = sc(80, 1.0); h = sc(500, 4);
    cylinder(r = r, h = h * 0.8);
    translate([0, 0, h * 0.8 - e]) cylinder(r1 = r, r2 = r * 0.4, h = h * 0.12);
    translate([0, 0, h * 0.9]) cylinder(r = r * 0.35, h = h * 0.1);
    box3(-r * 0.15, -r * 1.4, h * 0.88, r * 0.15, 0, h * 0.95);
}
module datenstation() {
    bw = sc(1000, 7); bt = max(sc(80), 0.8); bh = sc(600, 4.5); hp = sc(1500, 10); rp = max(sc(40), 0.8);
    cylinder(r = sc(300, 2.5), h = max(sc(40), 0.8));
    cylinder(r = rp, h = hp);
    hull() {
        box3(-bw / 2, -bt / 2, hp, bw / 2, bt / 2, hp + bh);
        box3(-rp, -bt / 2, hp - bw / 2 + rp, rp, bt / 2, hp - bw / 2 + rp + e);
    }
}
ZB = concat([for (i = [1 : 1 : werkzeugwagen]) 0], [for (i = [1 : 1 : werkbaenke]) 1], [for (i = [1 : 1 : reifenstapel]) 2],
            [for (i = [1 : 1 : wagenheber]) 3], [for (i = [1 : 1 : unterstellboecke]) 4], [for (i = [1 : 1 : tankanlagen]) 5],
            [for (i = [1 : 1 : oelfaesser]) 6], [for (i = [1 : 1 : feuerloescher]) 7], [for (i = [1 : 1 : datenstationen]) 8]);
module zb_item(k) {
    if (k == 0) werkzeugwagen(); if (k == 1) werkbank(); if (k == 2) reifenstapel_m();
    if (k == 3) wagenheber(); if (k == 4) unterstellbock(); if (k == 5) tankanlage();
    if (k == 6) oelfass(); if (k == 7) feuerloescher(); if (k == 8) datenstation();
}
module zubehoer_druck() {
    dx = sc(2300, 16);
    nx = max(1, ceil(sqrt(len(ZB))));
    for (i = [0 : 1 : len(ZB) - 1]) translate([(i % nx) * dx, floor(i / nx) * dx, 0]) zb_item(ZB[i]);
}

// =====================================================================
//  Zusammenbau
// =====================================================================
C_BODEN = "#9c9a96"; C_MARK = "#f2c200"; C_WAND = "#e4e4e1"; C_BLENDE = "#1f4e9c"; C_SCHRIFT = "#f5f5f5";
C_TOR = "#b9bec4"; C_DACH = "#5c6066"; C_GEL = "#8a9096";

module box_modul(i, lift, ex = 0) {
    translate([i * B, 0, 0]) {
        color(C_BODEN) translate([0, 0, -ex]) boden_welt("A");
        if (bodenmarkierung) color(C_MARK) translate([0, 0, hb - mk + 0.02 - ex]) linear_extrude(mk) markierung_2d();
        color(C_WAND) translate([0, 1.4 * ex, 0]) rueckwand_welt();
        translate([0, -1.2 * ex, 0.6 * ex]) {
            color(C_BLENDE) blende_welt("A", box_nummer + i);
            color(C_SCHRIFT) blende_welt("B", box_nummer + i);
        }
        color(C_TOR) translate([0, -0.6 * ex, 0]) tor_welt(lift);
        color(C_DACH) translate([0, 0, 1.6 * ex]) dach_welt();
        if (dach_gelaender) color(C_GEL) translate([0, 0, 2.2 * ex]) gelaender_welt();
    }
}
module zubehoer_box(i, n) {
    // Zubehör reihum auf die Boxen verteilen
    yin0 = yd + td + 1; yin1 = yb0 - 1;
    pos = [[-xi * 0.55, yin1 - sc(450)], [xi * 0.35, yin1 - sc(450)], [-xi + sc(450), (yin0 + yin1) * 0.5], [xi - sc(450), (yin0 + yin1) * 0.45],
           [-xi * 0.2, (yin0 + yin1) * 0.55], [xi * 0.25, (yin0 + yin1) * 0.6], [-xi + sc(400), yin1 - sc(1200)], [xi - sc(300), yin0 + sc(400)], [xi - sc(700), yin0 + sc(1500)]];
    for (j = [0 : 1 : len(ZB) - 1]) if (j % n == i)
        let(k = ZB[j], p = pos[k])
        translate([i * B + p[0] + (floor(j / n) % 2) * sc(300), p[1] - (floor(j / n) % 3) * sc(500), hb])
            rotate([0, 0, k == 1 ? 180 : 0]) color(["#c0392b", "#596775", "#222222", "#d35400", "#c0392b", "#2e86c1", "#1e8449", "#e74c3c", "#34495e"][k]) zb_item(k);
}
module reihe(n) {
    for (i = [0 : n - 1]) box_modul(i, lift_max * min(1, max(0, tor_offen[i % len(tor_offen)])));
    color(C_WAND) {
        for (i = [0 : 1 : n - 2]) trennwand_welt((i + 0.5) * B);
        endwand_l_welt(-B / 2);
        endwand_r_welt((n - 0.5) * B);
    }
    for (i = [0 : n - 1]) zubehoer_box(i, n);
}

// =====================================================================
//  Stückliste & Ausgabe
// =====================================================================
N = anzahl_boxen;
INFOS = [["boden", info_boden(), N], ["rueckwand", info_rueckwand(), N], ["torblende", info_blende(), N],
         ["tor", info_tor(), N], ["dach", info_dach(), N], ["trennwand", info_wand_p("trenn"), N - 1],
         ["endwand", info_wand_p("end"), 2]];
CLIPS_SPLIT = lsum([for (i = INFOS) clip_count(i[1]) * i[2]]);
CLIPS_FUGE  = (N - 1) * (len(YJ) + (roof_clip ? 1 : 0));
CLIPS = CLIPS_SPLIT + CLIPS_FUGE;
function info_of(n) = [for (i = INFOS) if (i[0] == n) i[1]][0];

echo(str("Boxengarage 1:", den, " | Box ", r2(B), " × ", r2(T + A), " mm, Höhe ", r2(Hg + rt + par), " mm | Reihe aus ", N, " Boxen: ", r2(N * B + tw), " mm breit"));
echo(str("Stückliste: ", N, "x Boden, ", N, "x Rückwand, ", N, "x Torblende, ", N, "x Tor, ", N, "x Dach",
         dach_gelaender ? str(", ", N, "x Geländer") : "", ", ", max(0, N - 1), "x Trennwand, 1x Endwand links, 1x Endwand rechts"));
echo(str("Tor: Hub ", r2(lift_max), " mm", tor_versenkbar ? " (versenkt komplett)" : " (teilweise)", " | Wandstärke ", r2(tw), " mm"));
for (i = INFOS) if (n_pieces(i[1]) > 1)
    echo(str("Teilung: ", i[0], " -> ", n_pieces(i[1]), " Stücke, ", clip_count(i[1]), " Clips je Teil",
             zero_seams(i[1]) > 0 ? str("  WARNUNG: ", zero_seams(i[1]), " Naht/Nähte ohne Clip – dort kleben") : ""));
if (gLen > usable) echo("Hinweis: Geländer länger als das Druckbett – diagonal drucken oder teilen.");
echo(str("Verbinder-Clips: ", CLIPS_FUGE, " für die Plattenfugen + ", CLIPS_SPLIT, " für geteilte Teile = ", CLIPS));

if (teil == "aufbau") reihe(N);
else if (teil == "explosion") {
    ex = max(sc(800), 12);
    box_modul(0, lift_max * 0.5, ex);
    color(C_WAND) { translate([-ex, 0, 0]) endwand_l_welt(-B / 2); translate([ex, 0, 0]) endwand_r_welt(B / 2); }
}
else if (teil == "boden") split_out(info_boden(), stueck) boden_druck(farbteil);
else if (teil == "trennwand") split_out(info_wand_p("trenn"), stueck) wand_druck_p("trenn");
else if (teil == "endwand_links") split_out(info_wand_p("end"), stueck) wand_druck_p("end");
else if (teil == "endwand_rechts") translate([0, T, 0]) mirror([0, 1, 0]) split_out(info_wand_p("end"), stueck) wand_druck_p("end");
else if (teil == "rueckwand") split_out(info_rueckwand(), stueck) rueckwand_druck();
else if (teil == "torblende") split_out(info_blende(), stueck) blende_local(farbteil);
else if (teil == "tor") split_out(info_tor(), stueck) tor_local();
else if (teil == "dach") split_out(info_dach(), stueck) dach_druck();
else if (teil == "gelaender") gelaender_druck();
else if (teil == "zubehoer") zubehoer_druck();
else if (teil == "verbinder") {
    n = verbinder_anzahl > 0 ? verbinder_anzahl : max(CLIPS, 4);
    nx = ceil(sqrt(n));
    for (i = [0 : n - 1]) translate([(i % nx) * (cL + 3), floor(i / nx) * (cw1 + 3), 0]) clip();
}
