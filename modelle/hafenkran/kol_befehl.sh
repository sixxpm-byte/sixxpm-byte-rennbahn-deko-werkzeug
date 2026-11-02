#!/bin/bash
# Kollisionsprüfung Hafenkran: Baugruppen exportieren und prüfen (Maßstab als 1. Argument, Standard 43)
# Ausleger und Zahnstangen in allen 5 Wippstufen.
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/hafenkran_$m
bash werkzeuge/kol_export.sh modelle/hafenkran/kol_hafenkran.scad $o $m \
  schiene=schiene fahrwerk=fahrwerk seite=seite quer=quer plattform=plattform zapfen=zapfen \
  drehbuehne=drehbuehne turm=turm traverse=traverse \
  ausleger1=ausleger,0,1 ausleger2=ausleger,0,2 ausleger3=ausleger,0,3 ausleger4=ausleger,0,4 ausleger5=ausleger,0,5 \
  zahnstange1=zahnstange,0,1 zahnstange2=zahnstange,0,2 zahnstange3=zahnstange,0,3 zahnstange4=zahnstange,0,4 zahnstange5=zahnstange,0,5
python3 werkzeuge/kollision.py $o modelle/hafenkran/kol_paare.txt
