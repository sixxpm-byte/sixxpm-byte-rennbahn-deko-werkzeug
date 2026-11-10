include <kettenbagger.scad>
// Kollisionsszene: obj = Bauteil, d0 = Stellung (Index in POSE), ii = Seite.  Rendern mit -D teil="none".
obj = ""; d0 = 0; ii = 0;
SY = [1, -1];
POSE = [[28, -100, -25], [0, -125, -48], [50, -50, 45], [25, -140, 20]];   // [Ausleger, Stiel, Löffel]
t = POSE[d0][0]; p = POSE[d0][1]; c = POSE[d0][2];
if (obj == "unterwagen") unterwagen_welt();
if (obj == "kette") kette_welt(SY[ii]);
if (obj == "oberwagen") oberwagen_welt("alle");
if (obj == "kabine") kabine_welt("alle");
if (obj == "handlauf") handlauf_welt(ii);
if (obj == "spiegel") spiegel_welt(ii);
if (obj == "ausl") in_ausleger(t) haelfte_lokal(0, SY[ii]);
if (obj == "stiel") in_ausleger(t) in_stiel(p) haelfte_lokal(1, SY[ii]);
if (obj == "loeffel") in_ausleger(t) in_stiel(p) in_loeffel(c) loeffel_lokal();
if (obj == "hebel") in_ausleger(t) in_stiel(p) lasche_zw(I_p, J_st(c), ii == 0 ? Y_hb : -Y_hb - t_gs, t_gs, r_pr, r_h);
if (obj == "koppel") in_ausleger(t) in_stiel(p) lasche_zw(J_st(c), Q_st(c), ii == 0 ? Y_kp : -Y_kp - t_gs, t_gs, r_pr, r_pr);
if (obj == "zh") zyl_zw(CF_p, F_p + rot2(A_p, t), SY[ii] * Y_hz, "alle", ZH, true, true);
if (obj == "zs") in_ausleger(t) zyl_zw(S1_p, T_p + rot2(R_p, p), 0, "alle", ZS, false, false);
if (obj == "zl") in_ausleger(t) in_stiel(p) zyl_zw(C1_p, J_st(c), 0, "alle", ZL, false, false);
