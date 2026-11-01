#!/bin/bash
# Kollisionsprüfung Zeitnahmeturm (Maßstab als 1. Argument, Standard 43)
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/zeitnahmeturm_$m
werkzeuge/kol_export.sh modelle/zeitnahmeturm/kol_zeitnahmeturm.scad $o $m \
  platte=platte d1=d1 d2=d2 dach=dach schild=schild fahne=fahne pult=pult eg_vorne=wand,0,0 eg_links=wand,0,1 eg_rechts=wand,0,2 eg_hinten=wand,0,3 og_vorne=wand,1,0 og_links=wand,1,1 og_rechts=wand,1,2 og_hinten=wand,1,3 k0=kanzel,0,0 k1=kanzel,0,1 k2=kanzel,0,2 k3=kanzel,0,3 lauf0=lauf,0,0 lauf1=lauf,0,1 lauf2=lauf,0,2 lauf3=lauf,0,3 pod0=podest,0,0 pod1=podest,0,1 pod2=podest,0,2 pod3=podest,0,3 st0=stuetze,0,0 st1=stuetze,0,1 st2=stuetze,0,2 st3=stuetze,0,3
python3 werkzeuge/kollision.py $o modelle/zeitnahmeturm/kol_paare.txt
