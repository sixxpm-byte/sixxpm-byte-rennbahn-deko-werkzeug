#!/bin/bash
# Kollisionsprüfung Muldenkipper (Maßstab als 1. Argument, Standard 43)
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/muldenkipper_$m
python3 werkzeuge/inline.py modelle/muldenkipper/muldenkipper_src.scad modelle/muldenkipper/muldenkipper.scad > /dev/null
bash werkzeuge/kol_export.sh modelle/muldenkipper/kol_muldenkipper.scad $o $m \
  rahmen=rahmen vorbau=vorbau grill=grill leuchte0=leuchte,0,0 leuchte1=leuchte,0,1 deck=deck kabine=kabine \
  gel0=gel,0,0 gel1=gel,0,1 gel2=gel,0,2 gel3=gel,0,3 treppe=treppe leiter0=leiter,0,0 leiter1=leiter,0,1 \
  rad0=rad,0,0 rad1=rad,0,1 rad2=rad,0,2 rad3=rad,0,3 spiegel0=spiegel,0,0 spiegel1=spiegel,0,1 \
  auspuff0=auspuff,0,0 auspuff1=auspuff,0,1 rl0=rl,0,0 rl1=rl,0,1 az0=az,0,0 az1=az,0,1 az2=az,0,2 az3=az,0,3 \
  mulde=mulde,0 dach=dach,0 mt0=mt,0,0 mt1=mt,0,1 zyl0=zyl,0,0 zyl1=zyl,0,1 \
  mulde45=mulde,45 dach45=dach,45 mt45_0=mt,45,0 mt45_1=mt,45,1 zyl45_0=zyl,45,0 zyl45_1=zyl,45,1
python3 werkzeuge/kollision.py $o modelle/muldenkipper/kol_paare.txt
