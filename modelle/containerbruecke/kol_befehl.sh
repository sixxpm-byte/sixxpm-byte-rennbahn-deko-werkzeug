#!/bin/bash
# Kollisionsprüfung Containerbrücke: Baugruppen exportieren und prüfen (Maßstab als 1. Argument, Standard 43)
# Katze landseitig / Mitte / Auslegerspitze, Spreader ganz oben, Ausleger unten und hochgeklappt.
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/containerbruecke_$m
bash werkzeuge/kol_export.sh modelle/containerbruecke/kol_containerbruecke.scad $o $m \
  schiene=schiene fahrwerk=fahrwerk portal=portal konsolen=konsolen mastriegel=mastriegel traeger=traeger maschinenhaus=maschinenhaus \
  ausleger=ausleger ausleger_hoch=ausleger,0,1 \
  katze0=katze,0 katze50=katze,50 katze100=katze,100 spreader0=spreader,0 spreader50=spreader,50 spreader100=spreader,100
python3 werkzeuge/kollision.py $o modelle/containerbruecke/kol_paare.txt
