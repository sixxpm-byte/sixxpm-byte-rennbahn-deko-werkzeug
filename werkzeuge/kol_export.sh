#!/bin/bash
# kol_export.sh <kol_szene.scad> <ausgabeordner> <massstab> name=obj[,d0[,ii]] ...
# Exportiert Baugruppen in Weltkoordinaten als STL (Szene mit Parametern obj, d0, ii,
# Beispiel: modelle/raupenbahn/kol_raupenbahn.scad). Läuft parallel (Kerne).
scene=$1; out=$2; m=$3; shift 3; mkdir -p "$out"
job() { IFS=',' read o d i <<< "$2"; timeout 3600 xvfb-run -a openscad -o "$out/$1.stl" -D 'teil="none"' -D massstab=$m \
        -D "obj=\"$o\"" -D d0=${d:-0} -D ii=${i:-0} "$scene" > "$out/$1.log" 2>&1; echo "$1 fertig"; }
n=$(nproc); for spec in "$@"; do while [ $(jobs -r | wc -l) -ge $n ]; do sleep 1; done; job "${spec%%=*}" "${spec#*=}" & done; wait
