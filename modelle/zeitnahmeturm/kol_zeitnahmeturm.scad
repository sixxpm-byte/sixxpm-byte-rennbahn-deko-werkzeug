include <zeitnahmeturm.scad>
obj = ""; d0 = 0; ii = 0;
if (obj == "platte") bodenplatte();
if (obj == "wand") wand_welt(d0, SIDES[ii]);
if (obj == "d1") decke1();
if (obj == "d2") decke2();
if (obj == "kanzel") kanzel_welt(ii);
if (obj == "dach") dach();
if (obj == "schild") schild_welt();
if (obj == "fahne") fahne_welt();
if (obj == "pult") pult_welt();
if (obj == "lauf") lauf_welt(ii);
if (obj == "podest") podest_welt(ii);
if (obj == "stuetze") stuetze_welt(ii);
