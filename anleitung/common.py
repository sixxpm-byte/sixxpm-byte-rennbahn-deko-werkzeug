import os, sys
HIER = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HIER)
sys.path.insert(0, HIER)
from anl import *

def MOD(name):   # Einzeldatei des Modells
    return os.path.join(ROOT, "modelle", name, name + ".scad")

def ANL(name):   # Bauschritt-Szene
    return os.path.join(HIER, "scad", name + ".scad")

CLIP_PNG = os.path.join(HIER, "assets", "clipdemo.png")

def material(extra=()):
    return ["3D-Drucker mit mindestens 220 × 220 mm Druckbett",
            "PLA (oder PETG) in den Farben der Druckliste – mit AMS/MMU werden mehrfarbige Teile in einem Durchgang gedruckt",
            "Seitenschneider / Cutter zum Entgraten, feine Feile oder Schleifpapier",
            *extra,
            "Optional: ein Tropfen Sekundenkleber für dauerhafte Verbindungen"]

# stuetzen: Text zu geplanten Stützen (neue Regel: stützfrei, wo möglich; Stützen nur, wo sinnvoll)
def druck(extra=(), stuetzen=None):
    return ["Schichthöhe 0,2 mm (feine Teile 0,12–0,16 mm), Düse 0,4 mm",
            stuetzen or "KEINE Stützstrukturen – alle Teile sind so ausgerichtet, dass sie stützfrei drucken",
            "Füllung 15 %, 3 Wandlinien; Brücken-Einstellungen des Slicers aktiv lassen",
            "Teile genau so auf das Bett legen, wie sie exportiert wurden (siehe Bilder der Druckliste)",
            *extra]

SYSTEM_CLIP = ["Alle Bausätze der Rennbahn-Deko-Reihe nutzen dieselben Schwalbenschwanz-Clips.",
               "Teile, die größer als das Druckbett sind, werden automatisch geteilt. An den Nähten sitzen auf der Unterseite Taschen.",
               "Teile umdrehen, Clip in die Tasche über der Naht drücken – fertig. Die Clips passen auch an Leitplanken, Reifenstapel & Co."]

# bereich: Maßstäbe, die das Modell anbietet (neue Modelle: "1:43 und 1:87")
def hinweis(name, datei, extra="", mst=43, bereich="1:10 … 1:87"):
    return (f"Diese Anleitung zeigt den Maßstab 1:{mst}. Für andere Maßstäbe ({bereich}) in {datei} den Maßstab wählen – "
            f"die Konsole bzw. farb_export.py nennt dann die passenden Stückzahlen, die Bauschritte bleiben gleich. {extra}")

def R(scad, cam, defs=(), size=(1600, 1100)):
    return dict(scad=scad, cam=cam, defs=list(defs), size=size)
