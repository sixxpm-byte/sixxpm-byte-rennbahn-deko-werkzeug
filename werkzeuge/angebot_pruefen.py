#!/usr/bin/env python3
"""angebot_pruefen.py – prüft den Angebotstext eines Modells (modelle/<n>/<n>_angebot.txt).

  python3 werkzeuge/angebot_pruefen.py modelle/reachstacker/reachstacker_angebot.txt

Aufbau der Datei (Abschnitte in dieser Reihenfolge, Überschrift allein in einer Zeile):
  TITEL             eine Zeile; „Carrera“ und „Sturmkind“ in den ersten 60 Zeichen
  KURZBESCHREIBUNG  1–3 Sätze (Deutsch, darunter Englisch)
  BESCHREIBUNG      ausführlich (Deutsch, dann „--- English ---“ und Englisch)
  DISCLAIMER        Markenhinweis (keine Verbindung zu den Markeninhabern), Vorbild, Lizenz, Kleinteile
  TAGS              genau 20 Tags, durch Kommas getrennt, nur Buchstaben A–Z/a–z und Ziffern
Ergebnis: „Angebot-Hinweise: n“ (Ziel 0).
"""
import re, sys
ABSCHNITTE = ["TITEL", "KURZBESCHREIBUNG", "BESCHREIBUNG", "DISCLAIMER", "TAGS"]
txt = open(sys.argv[1], encoding="utf-8").read().split("\n")
teile, akt = {}, None
for z in txt:
    if z.strip() in ABSCHNITTE: akt = z.strip(); teile[akt] = []
    elif akt: teile[akt].append(z)
fehler = []
for a in ABSCHNITTE:
    if a not in teile or not "\n".join(teile[a]).strip(): fehler.append(f"Abschnitt {a} fehlt oder ist leer")
reihe = [z.strip() for z in txt if z.strip() in ABSCHNITTE]
if reihe != ABSCHNITTE: fehler.append(f"Reihenfolge der Abschnitte: {reihe}")
titel = "\n".join(teile.get("TITEL", [])).strip()
if "\n" in titel: fehler.append("TITEL muss eine Zeile sein")
for marke in ["Carrera", "Sturmkind"]:
    if marke.lower() not in titel[:60].lower(): fehler.append(f"„{marke}“ nicht in den ersten 60 Zeichen des Titels")
beschr = "\n".join(teile.get("BESCHREIBUNG", []))
if "--- English ---" not in beschr: fehler.append("BESCHREIBUNG ohne englischen Teil („--- English ---“)")
disc = "\n".join(teile.get("DISCLAIMER", [])).lower()
for wort, was in [("marke", "Markenhinweis"), ("verbindung", "keine Verbindung zu Markeninhabern"), ("lizenz", "Lizenz")]:
    if wort not in disc: fehler.append(f"DISCLAIMER ohne {was}")
tags = [t for t in "".join(teile.get("TAGS", [])).strip().split(",") if t != ""]
if len(tags) != 20: fehler.append(f"{len(tags)} Tags statt 20")
for t in tags:
    if not re.fullmatch(r"[A-Za-z0-9]+", t): fehler.append(f"Tag mit Leer-/Sonderzeichen: „{t}“")
if len(set(t.lower() for t in tags)) != len(tags): fehler.append("doppelte Tags")
for f in fehler: print("HINWEIS", f)
print(f"{sys.argv[1]}: Titel {len(titel)} Zeichen, {len(tags)} Tags, Angebot-Hinweise: {len(fehler)}")
