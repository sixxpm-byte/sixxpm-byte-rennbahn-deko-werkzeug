#!/bin/bash
# Kollisionsprüfung Reach Stacker (Maßstab als 1. Argument, Standard 43)
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/reachstacker_$m
bash werkzeuge/kol_export.sh modelle/reachstacker/kol_reachstacker.scad $o $m \
  fahrgestell=fahrgestell kabine=kabine rad0=rad,0,0 rad1=rad,0,1 rad2=rad,0,2 rad3=rad,0,3 kf_l=kotfluegel,0,0 kf_r=kotfluegel,0,1 \
  gel_l=gelaender,0,0 gel_r=gelaender,0,1 aussen=aussen innen=innen zyl_l=zylinder,0,0 zyl_r=zylinder,0,1 haenger=haenger rahmen=rahmen \
  arm0=arm,0,0 arm1=arm,0,1 c_boden=c_boden c_dach=c_dach c_seite0=c_seite,0,0 c_seite1=c_seite,0,1 c_stirn=c_stirn c_tuer=c_tuer c_srahmen=c_srahmen c_trahmen=c_trahmen
python3 werkzeuge/kollision.py $o modelle/reachstacker/kol_paare.txt
