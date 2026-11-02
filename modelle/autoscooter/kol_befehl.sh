#!/bin/bash
# Kollisionsprüfung Autoscooter (Maßstab als 1. Argument, Standard 43)
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/autoscooter_$m
werkzeuge/kol_export.sh modelle/autoscooter/kol_autoscooter.scad $o $m \
  platte=platte treppe0=treppe,0,0 treppe1=treppe,0,1 bande0=bande,0,0 bande1=bande,0,1 bande2=bande,0,2 bande3=bande,0,3 bande4=bande,0,4 bande5=bande,0,5 bande6=bande,0,6 saeule0=saeule,0,0 saeule1=saeule,0,1 saeule2=saeule,0,2 saeule3=saeule,0,3 saeule4=saeule,0,4 saeule5=saeule,0,5 saeule6=saeule,0,6 saeule7=saeule,0,7 saeule8=saeule,0,8 saeule9=saeule,0,9 dach=dach front=front wagen0=wagen,0,0 wagen1=wagen,0,1 wagen2=wagen,0,2 wagen3=wagen,0,3 wagen4=wagen,0,4 wagen5=wagen,0,5 wagen6=wagen,0,6 wagen7=wagen,0,7 wagen8=wagen,0,8 wagen9=wagen,0,9 wagen10=wagen,0,10 wagen11=wagen,0,11 kboden=kboden kwand0=kwand,0,0 kwand1=kwand,0,1 kwand2=kwand,0,2 kwand3=kwand,0,3 kdach=kdach kschild=kschild greifer_u=greifer_u greifer_h=greifer_h boxer=boxer wohnwagen=wohnwagen deichsel=deichsel packwagen=packwagen
python3 werkzeuge/kollision.py $o modelle/autoscooter/kol_paare.txt
