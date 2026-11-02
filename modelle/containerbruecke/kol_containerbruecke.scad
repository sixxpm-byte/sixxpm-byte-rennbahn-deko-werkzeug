// Kollisionsszene Containerbrücke: Baugruppen in Weltkoordinaten
// obj, d0 = Katzenposition in % (0 landseitig … 100 Auslegerspitze), ii = 1: Ausleger hochgeklappt
include <containerbruecke.scad>
obj = ""; d0 = 0; ii = 0;
yk_ = y_kmin + (y_kmax - y_kmin) * d0 / 100;
a_  = ii == 1 ? TH_UP : 0;
z_sp_top = sc(2896) + 1 + (zg0 - sc(300) - sp_t - max(sc(500), 1.5) - sc(2896) - 2);   // Spreader ganz oben
module rt() translate([0, 0, rail_top]) children();
if (obj == "schiene") for (sy = [-1, 1]) for (i = [0 : SCHN - 1]) translate([-SCHL / 2 + i * SCHS, sy * G / 2, 0]) schiene_seg(SCHS);
if (obj == "fahrwerk") rt() for (sx = [-1, 1], sy = [-1, 1]) translate([sx * P / 2, sy * G / 2, 0]) fahrwerk();
if (obj == "portal") rt() for (sx = [-1, 1]) portalrahmen_welt(sx);
if (obj == "konsolen") rt() for (sx = [-1, 1], sy = [-1, 1]) konsole_welt(sx, sy);
if (obj == "mastriegel") rt() mastriegel_welt();
if (obj == "traeger") rt() { for (sx = [-1, 1]) traeger_welt(sx); endriegel_welt(); }
if (obj == "ausleger") rt() { for (sx = [-1, 1]) ausleger_welt(sx, a_); spitzenriegel_welt(a_); }
if (obj == "maschinenhaus") rt() translate([0, y_b, zg1 - dch]) maschinenhaus();
if (obj == "katze") rt() { translate([0, yk_, zg1 - dch]) katze(); translate([0, yk_ + cab_y0, zg1 - dch]) kabine(); }
if (obj == "spreader") rt() translate([0, yk_, z_sp_top]) spreader();
