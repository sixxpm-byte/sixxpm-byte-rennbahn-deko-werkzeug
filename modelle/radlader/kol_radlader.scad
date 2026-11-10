include <radlader.scad>
// Kollisionsszene: obj = Bauteil, d0 = Stellung (Index in POSE, + 10 = Lenkung voll eingeschlagen), ii = Seite.  Rendern mit -D teil="none".
obj = ""; d0 = 0; ii = 0;
SY = [1, -1];
POSE = [[t_min, 0], [t_min, bmax(t_min)], [-10, -42], [36, -42], [36, bmax(36)], [10, bmax(10)]];   // [Hubarm, Schaufel]
t = POSE[d0 % 10][0]; b = POSE[d0 % 10][1]; kn = d0 >= 10 ? 35 : 0;
module beweglich(o, i) {
    if (o == "arm") in_arm(t) hubarm_lokal(SY[i]);
    if (o == "hebel") in_arm(t) flach_zw(Lp_p, Lb_a(b - t), i == 0 ? Y_hb : -Y_hb - t_gs, t_gs) kipphebel_2d();
    if (o == "koppel") in_arm(t) flach_zw(Lb_a(b - t), Q_a(b - t), -t_mi / 2, t_mi) koppel_2d();
    if (o == "rohr") in_arm(t) translate([Lp_p[0], SY[i] * (Y_hb + t_gs + 0.15), Lp_p[1]]) rotate([i == 0 ? -90 : 90, 0, 0]) querrohr();
    if (o == "schaufel") in_arm(t) in_schaufel(b - t) schaufel_lokal();
    if (o == "zh") zyl_zw(F_p, P_w(t), y_hz(SY[i]), "alle", ZH, false, false);
    if (o == "zk") zyl_zw(KF_p, Lt_w(t, b), y_zk, "alle", ZK, false, false);
}
module vorn_fest(o, i) {
    if (o == "vorderwagen") vorderwagen_welt();
    if (o == "knickbolzen") translate([0, 0, Z_b]) knickbolzen();
    if (o == "achse_v") achse_welt(X_va);
    if (o == "rad_v") rad_welt(X_va, SY[i], "alle");
    if (o == "kotfluegel") kotfluegel_welt(SY[i]);
    if (o == "leuchte_v") leuchte_welt(i);
}
if (obj == "hinterwagen") hinterwagen_welt();
if (obj == "aufbau") aufbau_welt();
if (obj == "grill") grill_welt();
if (obj == "kabine") kabine_welt("alle");
if (obj == "leiter") leiter_welt(SY[ii]);
if (obj == "handlauf") handlauf_welt(ii);
if (obj == "spiegel") spiegel_welt(ii);
if (obj == "leuchte_h") leuchte_welt(2 + ii);
if (obj == "achse_h") achse_welt(-X_va);
if (obj == "rad_h") rad_welt(-X_va, SY[ii], "alle");
vorn_fest(obj, ii);
beweglich(obj, ii);
// ganzer Vorderwagen in Stellung d0 (für die Prüfung gegen den Hinterwagen, auch eingelenkt)
if (obj == "vorn") rotate(kn) {
    for (o = ["vorderwagen", "achse_v"]) vorn_fest(o, 0);
    for (o = ["rad_v", "kotfluegel", "leuchte_v"], i = [0, 1]) vorn_fest(o, i);
    for (o = ["koppel", "schaufel", "zk"]) beweglich(o, 0);
    for (o = ["arm", "hebel", "rohr", "zh"], i = [0, 1]) beweglich(o, i);
}
