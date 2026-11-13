#!/bin/bash
# Kollisionsprüfung Gabelstapler (Maßstab als 1. Argument, Standard 43)
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/gabelstapler_$m
bash werkzeuge/kol_export.sh modelle/gabelstapler/kol_gabelstapler.scad $o $m \
  fahrgestell=fahrgestell kabine=kabine glaskern=glaskern mast=mast traeger=traeger gabel_l=gabel,0,0 gabel_r=gabel,0,1 \
  kf_l=kotfluegel,0,0 kf_r=kotfluegel,0,1 rad0=rad,0,0 rad1=rad,0,1 rad2=rad,0,2 rad3=rad,0,3 \
  rl=rundumleuchte nz_l=neigezylinder,0,0 nz_r=neigezylinder,0,1 ar=ansaugrohr
python3 werkzeuge/kollision.py $o modelle/gabelstapler/kol_paare.txt
