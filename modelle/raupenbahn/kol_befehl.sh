#!/bin/bash
# Kollisionsprüfung Raupenbahn: Baugruppen exportieren und prüfen (Maßstab als 1. Argument, Standard 43)
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/raupenbahn_$m
werkzeuge/kol_export.sh modelle/raupenbahn/kol_raupenbahn.scad $o $m \
  car0=car,12,0 car1=car,12,1 car2=car,12,2 car3=car,12,3 arm0=arm,12,0 arm1=arm,12,1 arm2=arm,12,2 arm3=arm,12,3 \
  rotor=rotor,12 kz=kz mb=mb,12 podest=podest bahn=bahn weg=weg saeulen=saeulen dach=dach blenden=blenden ns=ns \
  schild=schild zaun=zaun treppe=treppe deko=deko
python3 werkzeuge/kollision.py $o modelle/raupenbahn/kol_paare.txt
