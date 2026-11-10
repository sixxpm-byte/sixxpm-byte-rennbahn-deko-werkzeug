include <schiffschaukel.scad>
// Kollisionsszene: obj = Bauteil, d0 = Kippwinkel des Schiffs, ii = Seite/Nummer.  Rendern mit -D teil="none".
obj = ""; d0 = 0; ii = 0;
SY = [1, -1];
if (obj == "platte") bodenplatte_welt();
if (obj == "abock") abock_welt(SY[ii]);
if (obj == "plattform") plattform_welt(SY[ii]);
if (obj == "az") achszapfen_welt(SY[ii]);
if (obj == "rampe") rampe_welt(SY[ii]);
if (obj == "zaun") { for (z = zaun_seiten()) zaun_welt(z); tor_welt(); }
if (obj == "laterne") { laterne_welt(); laternenkopf_welt(); }
if (obj == "rumpf") schwing(d0) rumpfkern();
if (obj == "bw") schwing(d0) rotate(ii == 0 ? 0 : 180) bordwand_welt("alle");
if (obj == "arm") schwing(d0) arm_welt(SY[ii]);
if (obj == "masten") schwing(d0) { for (i = [0 : len(MASTEN) - 1]) mast_welt(i, "alle"); bugspriet_welt(); }
if (obj == "duebel") schwing(d0) for (s = [-1, 1], x = X_DW) duebel_welt(s * x, len([for (d = X_DA) if (abs(d - x) < 0.01) 1]) > 0);
