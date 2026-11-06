# Rennbahn-Deko – Werkzeuge

Gemeinsame Bibliothek, Export-, Prüf- und Anleitungs-Werkzeuge für die 3D-druckbaren
Deko-Bausätze (Sturmkind DR!FT, neue Modelle in 1:43 und 1:87, ältere zusätzlich 1:10 … 1:64). Konventionen: `doku/KONVENTIONEN.md`.

## Ordner

| Ordner | Inhalt |
|---|---|
| `lib/` | `deko_grundlagen.scad` (Maßstab, Clips, Farben), `deko_hilfen.scad` (Teilung, Polar-Teilung, Ausgabe), `deko_ornamente.scad`, `deko_kasse.scad`, `deko_zubehoer.scad`, `deko_container.scad` (Container-Bausatz 20/40 Fuß, Steck-Bausatz ohne Kleber, optional mit Magnettaschen) |
| `modelle/<name>/` | `<name>.scad` = Einzeldatei für Customizer/Verkauf; neue Modelle zusätzlich `<name>_src.scad` (mit `include`), `LIESMICH.txt`, Kollisions-Szene |
| `werkzeuge/` | `inline.py`, `farb_export.py`, `pruefen.py`, `kol_export.sh`, `kollision.py`, `kontaktbogen.py`, `packen.py` |
| `anleitung/` | Lego-Anleitungen: `bauen.py`, `m_<name>.py` (Texte/Schritte), `scad/anl_<name>.scad` (Bauschritt-Szenen) |
| `ausgabe/` | wird erzeugt (STL, Zip, PDF) – nicht im Repo |

## Einrichten

```
# OpenSCAD 2021.01 (Linux: apt install openscad), dazu xvfb und poppler-utils für Bilder/PDF-Vorschau
pip install -r requirements.txt
```

## Häufige Befehle (im Repo-Hauptordner)

```
python3 werkzeuge/inline.py modelle/raupenbahn/raupenbahn_src.scad modelle/raupenbahn/raupenbahn.scad
python3 werkzeuge/farb_export.py modelle/raupenbahn/raupenbahn.scad 43 ausgabe/raupenbahn/STL_1-43
python3 werkzeuge/farb_export.py modelle/raupenbahn/raupenbahn.scad 43 ausgabe/raupenbahn/STL_1-43 --nur kuppel,mittelbau_wand
python3 werkzeuge/pruefen.py ausgabe/raupenbahn/STL_1-43
modelle/raupenbahn/kol_befehl.sh 43
python3 anleitung/bauen.py raupenbahn
python3 werkzeuge/packen.py raupenbahn
```
