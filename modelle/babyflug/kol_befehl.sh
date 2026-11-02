#!/bin/bash
# Kollisionsprüfung Babyflug: Baugruppen exportieren und prüfen (Maßstab als 1. Argument, Standard 43)
# Arme/Jets in Ruhestellung (arm_min) und Flughöhe (arm_max), je zwei Nachbarn.
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/babyflug_$m
lo=-20; hi=25   # = arm_min, arm_max im Modell
bash werkzeuge/kol_export.sh modelle/babyflug/kol_babyflug.scad $o $m \
  arm_lo0=arm,$lo,0 arm_lo1=arm,$lo,1 arm_hi0=arm,$hi,0 arm_hi1=arm,$hi,1 \
  jet_lo0=jet,$lo,0 jet_lo1=jet,$lo,1 jet_hi0=jet,$hi,0 jet_hi1=jet,$hi,1 \
  podest=podest boden=boden saeule=saeule kopf_unten=kopf_unten kopf_oben=kopf_oben krone=krone dach=dach ufo=ufo \
  masten=masten gelaender=gelaender leuchtmast=leuchtmast kasse=kasse
python3 werkzeuge/kollision.py $o modelle/babyflug/kol_paare.txt
