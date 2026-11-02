#!/bin/bash
# Kollisionsprüfung Freifallturm: Baugruppen exportieren und prüfen (Maßstab als 1. Argument, Standard 43)
# Sitzring unten / Mitte / oben.
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/freifallturm_$m
bash werkzeuge/kol_export.sh modelle/freifallturm/kol_freifallturm.scad $o $m \
  podest=podest treppe=treppe mast=mast kopf=kopf zaun=zaun portal=portal kasse=kasse \
  gondel0=gondel,0 gondel50=gondel,50 gondel100=gondel,100
python3 werkzeuge/kollision.py $o modelle/freifallturm/kol_paare.txt
