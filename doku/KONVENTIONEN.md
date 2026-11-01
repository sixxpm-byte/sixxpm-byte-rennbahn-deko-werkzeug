# Konventionen der Rennbahn-Deko-Reihe

Gilt für jedes neue Modell. Ziel: alle Bausätze sehen gleich aus, drucken gleich, werden gleich exportiert, geprüft und verpackt.

## 1. Datei-Aufbau eines Modells

Quelle: `modelle/<name>/<name>_src.scad` (mit `include`), ausgeliefert wird die Einzeldatei `modelle/<name>/<name>.scad`, erzeugt mit `werkzeuge/inline.py`.

Reihenfolge in der Quelle:

1. Kopfkommentar: Titel, TEILE-Liste (`teil = ...` mit Kurzbeschreibung und Stückzahl), BEWEGLICH, MONTAGE (Kurzfassung).
2. Customizer-Abschnitte, genau so benannt:
   - `/* [Maßstab] */` mit dieser Zeile (unverändert übernehmen):
     `massstab = 43; // [10:1/10 RC-Car, 18:1/18 Modellauto, 24:1/24 Slotcar, 28:1/28 Mini-RC, 32:1/32 Slotcar, 43:1/43 Drift-RC und Slotcar, 64:1/64 Diecast, 87:1/87 H0, 0:eigener Maßstab]`
     und `eigener_massstab = 50;`
   - `/* [Ausgabe] */`: `teil = "aufbau"; // [aufbau:…, explosion:…, <teil>:<Name>, …, verbinder:Verbinder-Clips]`, `stueck = 0;`, `farbteil = "alle"; // [alle, A, B, C, D]`
   - `/* [Vorschau] */` (Stellungen beweglicher Teile, `kassenhaus_zeigen`)
   - `/* [<Modell> (Vorbild in Metern)] */`
   - optional `/* [Kasse (Vorbild in Metern)] */` (Parameter siehe Abschnitt 7)
   - `/* [Farben] */`: je Bauteil `farbe_xxx = "rot"; // [<Farbliste wie in raupenbahn_src.scad>]`
   - `/* [Druck & Passung] */`: `rennbahn_taschen = true; druckbett = 220; rand = 5; min_wand = 1.2; spiel = 0.15; verbinder_anzahl = 0;`
3. `include <../../lib/deko_grundlagen.scad>`, danach die Maße des Modells.
4. optional `include <../../lib/deko_kasse.scad>` (nach den Maßen).
5. `include <../../lib/deko_hilfen.scad>`, optional `include <../../lib/deko_ornamente.scad>`.
6. Module der Bauteile, Zusammenbau `<modell>(ex)`, Info und Ausgabe (INFOS, Echo-Zeilen, `druck(...)`, `farben_echo();`, Dispatch nach `teil`).

## 2. Maße und Maßstab

- Vorbild in Metern, umgerechnet mit `M(m, min_mm)`; Millimeter-Werte mit `sc(mm, min_mm)`.
- Mindestmaße: Wände `min_wand` (1,2 mm), Relief `dmr = max(sc(20), 0.3)`, feine Striche mindestens 0,8–1,0 mm.
- Muss bei 1:10 bis 1:87 laufen. Kontrolle: Echo bei allen Maßstäben, keine `WARNUNG`-Zeilen.

## 3. Teilung und Clips

- Nutzbare Bettfläche `usable = druckbett - 2*rand` (210 mm).
- Rechteckige Teile: `info = [SX, SY, xs, ys, keep, top, zt, S, Belegung, sep]`, Nähte mit `seams_at(...)`, Ausgabe mit `split_out(info, stueck) <teil>_druck();`. Feste Bereiche für Clips über `S` (z. B. `pads(...)` für Stäbe).
- Runde Teile: `polar_pieces(Ri, Ro, Basiswinkel)`, Druck mit `pp_druck(P, stueck, R, zb, zt, flip)`, Clips mit `pp_clips(...)` (filtern mit `near(...)`).
- Geteilte Teile müssen mindestens `b_cl` dick sein (Clip-Tasche plus Deckschicht).
- Clips (Schwalbenschwanz) sitzen immer auf der Druckbett-Seite (`clip_cut(rot, false, 0)`). Bei hohlen Teilen kommen Bosse unter die Tasche (`r_cb`).
- Stecktaschen zur Rennbahn: `rb_slot()` an Bodenplatten-Rändern (wenn `rennbahn_taschen`).
- `verbinder`: `verbinder_platten(max(CLIPS, 4), stueck)`.

## 4. Farben und Export

- Mehrfarbige Teile: `farbteil` A (Grundkörper), B, C, D (E). Farbbereiche dürfen sich **nicht** überlappen (Relief auf A, oder A ausschneiden).
- Je Teil und Farbe eine Echo-Zeile: `druck(teil, stücke, farbteil, farbe, menge);`, danach `farben_echo();`.
  - Verschiedene Stücke desselben Teils (z. B. Geländer jeder Seite) als `stücke = n, menge = 1`. `farb_export.py` fasst gleiche Geometrie automatisch zusammen.
- Export: `python3 werkzeuge/farb_export.py modelle/<n>/<n>.scad 43 ausgabe/<n>/STL_1-43` (ebenso 87). Erzeugt STL je Teil/Farbe, `Farbliste.txt` und eine farbige 3MF.
- Nur geänderte Teile neu rechnen: `--nur teil1,teil2` (den Rest liefert der Zwischenspeicher).

## 5. Druckregeln (stützfrei)

- Keine Überhänge über 45°. Brücken höchstens 15–20 mm, und zwar zwischen Rippen, die quer zur Brücke stehen.
- Große Körper hohl: unten offen mit Rippen (Podest kopfüber, Dach/Umgang aufrecht), Decke parallel zur Oberfläche.
- Zapfen nur nach oben. Auf der Bettseite gibt es nur Löcher, Taschen und Rillen. Zapfenkanten 45° fasen.
- Schauseiten mit Schrift oder Gesicht nach unten drucken (Farbeinleger in den ersten Schichten).
- Teile in der Druckausrichtung exportieren und auf z = 0 legen.

## 6. Vorschau-Fallen (OpenSCAD 2021.01)

- CSG-Baum zu groß (leeres Bild): viele Rippen oder Fugen mit `if (!$preview)` nur im Export abziehen.
- Farbfehler in der Vorschau: `convexity` an `linear_extrude`/`rotate_extrude`/`polyhedron` setzen, Polyeder-Flächen als Dreiecke, farbige Bänder als 2D-Operation statt 3D-`intersection`.
- Module nur direkt im Modulkörper definieren (nicht in `translate(){}`).
- `else if (...) let(...) if (...)` fängt das nächste `else` → Block `{ }` verwenden.

## 7. Kasse (optional, aus `lib/deko_kasse.scad`)

Parameter: `haus_stil, haus_breite_m (2.4), haus_tiefe_m (1.8), haus_hoehe_m (2.3), tuer, schild_text, kasse_text, schild_font` und die Farben `farbe_haus_boden/wand/kanten/dach, farbe_schild_A/B`.

INFOS-Einträge, DRUCK-Zeilen und Dispatch genau wie in `modelle/raupenbahn/raupenbahn_src.scad` (Suche nach `haus_`).

## 8. Prüfen

- Echo bei allen Maßstäben (10, 18, 24, 28, 32, 43, 64, 87).
- Kollisionen: Szene `kol_<n>.scad` (Parameter `obj`, `d0`, `ii`), `werkzeuge/kol_export.sh`, dann `werkzeuge/kollision.py <ordner> <paare.txt>`. Beispiel: `modelle/raupenbahn/kol_befehl.sh`.
- Export prüfen: `werkzeuge/pruefen.py ausgabe/<n>/STL_1-43` → Ergebnis „Probleme: 0“.

## 9. Ablauf je Modell (token-sparend)

1. Vorbild klären (Fotos), Entwurf als `_src.scad` mit der Bibliothek.
2. Echo aller Maßstäbe, ein Kontaktbogen mit 2–4 Vorschauen (`werkzeuge/kontaktbogen.py`), dann **Freigabe durch Dirk** – Änderungswünsche sammeln.
3. Erst nach der Freigabe: Kollisionsprüfung, `inline.py`, `farb_export.py` (1:43 und 1:87), `pruefen.py`.
4. Bilder: `<n>_aufbau.png`, `<n>_explosion.png`, ein Detailbild, `<n>_druckteile.png` (Kontaktbogen der STL).
5. Anleitung: `anleitung/m_<n>.py` + `anleitung/scad/anl_<n>.scad`, dann `python3 anleitung/bauen.py <n>`.
6. `modelle/<n>/LIESMICH.txt`, dann `python3 werkzeuge/packen.py <n>`.
7. Optional: Cults3D-Angebot (eigener Skill).

Sparregeln: Kontrollbilder als Kontaktbogen statt einzeln. Bei Änderungen nur betroffene Teile neu exportieren (`--nur`). Lange Läufe im Hintergrund mit einem einzigen Warte-Befehl abwarten. Ein Modell pro Sitzung.
