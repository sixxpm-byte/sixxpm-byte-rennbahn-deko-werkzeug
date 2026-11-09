#!/bin/bash
# Kollisionsprüfung Boxenmauer (Maßstab als 1. Argument, Standard 43)
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/boxenmauer_$m
python3 werkzeuge/inline.py modelle/boxenmauer/boxenmauer_src.scad modelle/boxenmauer/boxenmauer.scad > /dev/null
bash werkzeuge/kol_export.sh modelle/boxenmauer/kol_boxenmauer.scad $o $m \
  mauer0=mauer,0,0 mauer1=mauer,0,1 mauer2=mauer,0,2 zaun0=zaun,0,0 zaun1=zaun,0,1 zaun2=zaun,0,2 \
  podest=podest treppe=treppe pult=pult monitore=monitore hocker=hocker wand0=wand,0,0 wand1=wand,0,1 \
  gelaender=gelaender dach=dach banner=banner
python3 werkzeuge/kollision.py $o modelle/boxenmauer/kol_paare.txt
