#!/usr/bin/env python3
"""angebot_pruefen.py – prüft den Angebotstext eines Modells (modelle/<n>/<n>_angebot.txt).

  python3 werkzeuge/angebot_pruefen.py modelle/reachstacker/reachstacker_angebot.txt

Aufbau der Datei (Abschnitte in dieser Reihenfolge, Überschrift allein in einer Zeile):
  TITEL             eine Zeile; „Carrera“ und „Sturmkind“ in den ersten 60 Zeichen
  KURZBESCHREIBUNG  1–3 Sätze (Deutsch, darunter Englisch); nennt „Modelleisenbahn“ / „model railway“ und
                    „druckbarer Steck-Bausatz mit Bauanleitung“ – ebenso die BESCHREIBUNG; Tags Modelleisenbahn, Bausatz
  BESCHREIBUNG      ausführlich, endet je Sprache mit dem Disclaimer (Markenhinweis, keine Verbindung
                    zu den Markeninhabern, freie Nachbildung, Kleinteile, Lizenz); Deutsch, dann
                    „--- English ---“ und Englisch
  DRUCKANWEISUNG    Druckhinweise (Düse, Schicht, Füllung, Ausrichtung, Stützen, Mehrfarbig), DE und EN
  TAGS              genau 20 Tags, durch Kommas ohne Leerzeichen, nur Buchstaben A–Z/a–z und Ziffern
Ergebnis: „Angebot-Hinweise: n“ (Ziel 0).
"""
import re, sys
ABSCHNITTE = ["TITEL", "KURZBESCHREIBUNG", "BESCHREIBUNG", "DRUCKANWEISUNG", "TAGS"]
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
de, _, en = beschr.partition("--- English ---")
for teil, sprache, woerter in [(de, "DE", [("marke", "Markenhinweis"), ("verbindung", "keine Verbindung zu Markeninhabern"), ("lizenz", "Lizenz"), ("kinder", "Kleinteile-Hinweis")]),
                               (en, "EN", [("trademark", "Markenhinweis"), ("connection", "keine Verbindung"), ("licen", "Lizenz"), ("children", "Kleinteile-Hinweis")])]:
    for wort, was in woerter:
        if wort not in teil.lower(): fehler.append(f"BESCHREIBUNG ({sprache}) ohne Disclaimer-Teil: {was}")
# Pflicht seit 11/2026: „Modelleisenbahn“ und der Hinweis „druckbarer Steck-Bausatz mit Bauanleitung“
kurz = "\n".join(teile.get("KURZBESCHREIBUNG", [])).lower()
for wo, text in [("KURZBESCHREIBUNG", kurz), ("BESCHREIBUNG (DE)", de.lower())]:
    if "modelleisenbahn" not in text: fehler.append(f"{wo} ohne das Wort „Modelleisenbahn“")
    if "bausatz" not in text: fehler.append(f"{wo} ohne „Bausatz“")
    if "anleitung" not in text: fehler.append(f"{wo} ohne Hinweis auf die Bauanleitung")
    if "steck" not in text or "druck" not in text: fehler.append(f"{wo} ohne „druckbar“/„gesteckt“")
for wo, text in [("KURZBESCHREIBUNG", kurz), ("BESCHREIBUNG (EN)", en.lower())]:
    if "model railway" not in text: fehler.append(f"{wo} ohne „model railway“")
    if "kit" not in text or "instructions" not in text: fehler.append(f"{wo} ohne „kit“/„instructions“ (englisch)")
druck = "\n".join(teile.get("DRUCKANWEISUNG", []))
if "--- English ---" not in druck: fehler.append("DRUCKANWEISUNG ohne englischen Teil („--- English ---“)")
for wort, was in [("düse", "Düse"), ("stütz", "Stützen"), ("füllung", "Füllung")]:
    if wort not in druck.lower(): fehler.append(f"DRUCKANWEISUNG ohne Angabe zu {was}")
tagzeile = "".join(teile.get("TAGS", [])).strip()
if " " in tagzeile: fehler.append("Leerzeichen in der Tag-Zeile")
tags = [t for t in "".join(teile.get("TAGS", [])).strip().split(",") if t != ""]
if len(tags) != 20: fehler.append(f"{len(tags)} Tags statt 20")
for t in tags:
    if not re.fullmatch(r"[A-Za-z0-9]+", t): fehler.append(f"Tag mit Leer-/Sonderzeichen: „{t}“")
if len(set(t.lower() for t in tags)) != len(tags): fehler.append("doppelte Tags")
for pflicht in ["Modelleisenbahn", "Bausatz"]:
    if pflicht.lower() not in [t.lower() for t in tags]: fehler.append(f"Pflicht-Tag „{pflicht}“ fehlt")
for f in fehler: print("HINWEIS", f)
print(f"{sys.argv[1]}: Titel {len(titel)} Zeichen, {len(tags)} Tags, Angebot-Hinweise: {len(fehler)}")
