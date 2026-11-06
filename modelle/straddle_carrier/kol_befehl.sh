#!/bin/bash
# Kollisionsprüfung Straddle Carrier (Maßstab als 1. Argument, Standard 43)
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/straddle_carrier_$m
python3 werkzeuge/inline.py modelle/straddle_carrier/straddle_carrier_src.scad modelle/straddle_carrier/straddle_carrier.scad > /dev/null
bash werkzeuge/kol_export.sh modelle/straddle_carrier/kol_straddle_carrier.scad $o $m \
  fw_l=fw_l fw_r=fw_r ob_l=ob_l ob_r=ob_r rad0=rad,0,0 rad1=rad,0,1 rad2=rad,0,2 rad3=rad,0,3 \
  ib0=innenbein,0,0 ib1=innenbein,0,1 ib2=innenbein,0,2 ib3=innenbein,0,3 qt0=qt,0,0 qt1=qt,0,1 mt=mt \
  rahmen=rahmen arm0=arm,0,0 arm1=arm,0,1 arm40_0=arm,0,2 arm40_1=arm,0,3 kopf0=kopf,0,0 kopf1=kopf,0,1 kopf40_0=kopf,0,2 kopf40_1=kopf,0,3 kabine=kabine motor=motor gitter=gitter container=container container40=container40
python3 werkzeuge/kollision.py $o modelle/straddle_carrier/kol_paare.txt
