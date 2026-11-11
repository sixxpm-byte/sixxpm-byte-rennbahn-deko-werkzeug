#!/bin/bash
# Kollisionsprüfung Planierraupe (Maßstab als 1. Argument, Standard 43): feste Teile + Schild/Ripper in 4 Stellungen
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/planierraupe_$m
python3 werkzeuge/inline.py modelle/planierraupe/planierraupe_src.scad modelle/planierraupe/planierraupe.scad > /dev/null
bash werkzeuge/kol_export.sh modelle/planierraupe/kol_planierraupe.scad $o $m \
  unterwagen=unterwagen kette0=kette,0,0 kette1=kette,0,1 kotfluegel0=kotfluegel,0,0 kotfluegel1=kotfluegel,0,1 rahmen=rahmen kabine=kabine schildrahmen_p0=schildrahmen,0 schild_p0=schild,0 zh0_p0=zh,0,0 zh1_p0=zh,0,1 ripper_p0=ripper,0 zr_p0=zr,0 schildrahmen_p1=schildrahmen,1 schild_p1=schild,1 zh0_p1=zh,1,0 zh1_p1=zh,1,1 ripper_p1=ripper,1 zr_p1=zr,1 schildrahmen_p2=schildrahmen,2 schild_p2=schild,2 zh0_p2=zh,2,0 zh1_p2=zh,2,1 ripper_p2=ripper,2 zr_p2=zr,2 schildrahmen_p3=schildrahmen,3 schild_p3=schild,3 zh0_p3=zh,3,0 zh1_p3=zh,3,1 ripper_p3=ripper,3 zr_p3=zr,3
python3 werkzeuge/kollision.py $o modelle/planierraupe/kol_paare.txt
