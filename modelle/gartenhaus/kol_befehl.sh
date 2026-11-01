#!/bin/bash
# Kollisionsprüfung Gartenhaus: Baugruppen exportieren und prüfen (Maßstab als 1. Argument, Standard 43)
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/gartenhaus_$m
werkzeuge/kol_export.sh modelle/gartenhaus/kol_gartenhaus.scad $o $m \
  platte=platte vorne=wand,0,0 links=wand,0,1 rechts=wand,0,2 hinten=wand,0,3 tuer0=tuer,0 tuer90=tuer,90 \
  portal=portal pfl=pfette,0,0 pfr=pfette,0,1 brvl=br,0,0 brvr=br,0,1 brsl=br,0,2 brsr=br,0,3 dachl=dach,0,0 dachr=dach,0,1 zub=zub
python3 werkzeuge/kollision.py $o modelle/gartenhaus/kol_paare.txt
