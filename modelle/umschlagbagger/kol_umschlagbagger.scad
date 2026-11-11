include <umschlagbagger.scad>
// Kollisionsszene: obj = Bauteil, d0 = Stellung (Index in POSE), ii = Seite/Index.  Rendern mit -D teil="none".
obj = ""; d0 = 0; ii = 0;
SY = [1, -1];
POSE = [[45, -75, 2], [25, -130, 0], [70, -60, 3], [70, -130, 1]];   // [Ausleger, Stiel, Kabinenstufe]
t = POSE[d0][0]; p = POSE[d0][1]; th = STUFEN[POSE[d0][2]];
if (obj == "fahrgestell") fahrgestell_welt();
if (obj == "stuetze") stuetze_welt(ii < 2 ? 1 : -1, ii % 2 == 0 ? 1 : -1);
if (obj == "achse") achse_welt(SY[ii] * X_ax);
if (obj == "rad") rad_welt(ii, "alle");
if (obj == "oberwagen") oberwagen_welt();
if (obj == "handlauf") handlauf_welt(ii);
if (obj == "armu") hubarm_welt(0, th, SY[ii]);
if (obj == "armo") hubarm_welt(1, th, SY[ii]);
if (obj == "traeger") in_traeger(th) traeger_lokal();
if (obj == "kabine") in_traeger(th) kabine_lokal("alle");
if (obj == "ausl") in_ausleger(t) haelfte_lokal(0, SY[ii]);
if (obj == "stiel") in_ausleger(t) in_stiel(p) haelfte_lokal(1, SY[ii]);
if (obj == "zh") zyl_zw(CF_p, F_p + rot2(A_p, t), y_b + SY[ii] * Y_hz, "alle", ZH, true, true);
if (obj == "zs") in_ausleger(t) zyl_zw(S1_p, T_p + rot2(R_p, p), 0, "alle", ZS, false, false);
if (obj == "kopf") in_greifer(t, p, 0) greiferkopf_lokal();
if (obj == "schale") in_greifer(t, p, 0) schale_lokal(ii);
