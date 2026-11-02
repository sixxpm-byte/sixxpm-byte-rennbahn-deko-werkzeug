#!/bin/bash
# Kollisionsprüfung Turntables: Baugruppen exportieren und prüfen (Maßstab als 1. Argument, Standard 43)
# Plattenteller/Gondelkreuze in 4 Drehstellungen (Neigung -> jede Seite einmal oben).
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/turntables_$m
bash werkzeuge/kol_export.sh modelle/turntables/kol_turntables.scad $o $m \
  bodenkreuz=bodenkreuz deck=deck blenden=blenden stufen=stufen teller=teller turm=turm rueckwand=rueckwand schild=schild \
  masten=masten zaeune=zaeune mischpulte=mischpulte tonarm=tonarm kasse=kasse \
  kreuze0=kreuze,0,0 kreuze90=kreuze,90,45 kreuze180=kreuze,180,0 kreuze270=kreuze,270,45
python3 werkzeuge/kollision.py $o modelle/turntables/kol_paare.txt
