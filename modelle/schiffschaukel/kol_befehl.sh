#!/bin/bash
# Kollisionsprüfung Schiffschaukel (Maßstab als 1. Argument, Standard 43): feste Teile + Schiff in 5 Raststellungen
cd "$(dirname "$0")/../.."; m=${1:-43}; o=ausgabe/kol/schiffschaukel_$m
python3 werkzeuge/inline.py modelle/schiffschaukel/schiffschaukel_src.scad modelle/schiffschaukel/schiffschaukel.scad > /dev/null
bash werkzeuge/kol_export.sh modelle/schiffschaukel/kol_schiffschaukel.scad $o $m \
  platte=platte abock0=abock,0,0 abock1=abock,0,1 pl0=plattform,0,0 pl1=plattform,0,1 az0=az,0,0 az1=az,0,1 \
  rampe0=rampe,0,0 rampe1=rampe,0,1 zaun=zaun laterne=laterne \
  rumpf_m40=rumpf,-40 bw0_m40=bw,-40,0 bw1_m40=bw,-40,1 arm0_m40=arm,-40,0 arm1_m40=arm,-40,1 masten_m40=masten,-40 duebel_m40=duebel,-40 rumpf_m20=rumpf,-20 bw0_m20=bw,-20,0 bw1_m20=bw,-20,1 arm0_m20=arm,-20,0 arm1_m20=arm,-20,1 masten_m20=masten,-20 duebel_m20=duebel,-20 rumpf_0=rumpf,0 bw0_0=bw,0,0 bw1_0=bw,0,1 arm0_0=arm,0,0 arm1_0=arm,0,1 masten_0=masten,0 duebel_0=duebel,0 rumpf_p20=rumpf,20 bw0_p20=bw,20,0 bw1_p20=bw,20,1 arm0_p20=arm,20,0 arm1_p20=arm,20,1 masten_p20=masten,20 duebel_p20=duebel,20 rumpf_p40=rumpf,40 bw0_p40=bw,40,0 bw1_p40=bw,40,1 arm0_p40=arm,40,0 arm1_p40=arm,40,1 masten_p40=masten,40 duebel_p40=duebel,40
python3 werkzeuge/kollision.py $o modelle/schiffschaukel/kol_paare.txt
