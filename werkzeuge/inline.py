#!/usr/bin/env python3
"""inline.py – macht aus einer Quelle mit `include <../../lib/...>` eine einzelne
.scad-Datei (für Customizer / Cults3D / Thingiverse).

  python3 werkzeuge/inline.py modelle/raupenbahn/raupenbahn_src.scad modelle/raupenbahn/raupenbahn.scad
"""
import os, re, sys

INC = re.compile(r'^\s*include\s*<([^>]+)>\s*$')

def inline(path, seen=()):
    out = []
    for line in open(path, encoding="utf-8").read().split("\n"):
        m = INC.match(line)
        if m:
            p = os.path.normpath(os.path.join(os.path.dirname(path), m.group(1)))
            if os.path.exists(p) and "/lib/" in p.replace("\\", "/"):
                if p in seen: continue
                out.append(inline(p, seen + (p,)).rstrip("\n"))
                continue
        out.append(line)
    return "\n".join(out)

if __name__ == "__main__":
    if len(sys.argv) != 3: sys.exit(__doc__)
    txt = inline(os.path.abspath(sys.argv[1]))
    open(sys.argv[2], "w", encoding="utf-8").write(txt)
    print(sys.argv[2], len(txt.split("\n")), "Zeilen")
