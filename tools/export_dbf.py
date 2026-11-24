"""Exporta los DBF de app_base_win98 a docs/catalogo.json para la web."""
import json, struct, pathlib
ROOT = pathlib.Path(__file__).resolve().parent.parent
SRC = ROOT / "app_base_win98"
COLECCIONES = {  # archivo -> nombre visible
    "DISCOS.DBF": "Discos", "CASSETTE.DBF": "Cassettes", "CINTAS.DBF": "Cintas",
    "BOLEROS.DBF": "Boleros", "CARIBE.DBF": "Caribe",
}
def leer(path):
    b = path.read_bytes()
    n, hl, rl = struct.unpack("<IHH", b[4:12])
    campos, off = [], 1
    for i in range(32, hl - 1, 32):
        if b[i] == 0x0D: break
        nombre = b[i:i+11].split(b"\0")[0].decode("ascii"); ln = b[i+16]
        campos.append((nombre, off, ln)); off += ln
    for r in range(n):
        rec = b[hl + r*rl: hl + (r+1)*rl]
        if not rec or rec[0:1] == b"*": continue  # borrado
        yield {k: rec[o:o+l].decode("cp850").strip() for k, o, l in campos}
out = []
for archivo, col in COLECCIONES.items():
    for d in leer(SRC / archivo):
        t = d.get("TITULO", "")
        if len(t.strip("/}.-* ")) == 0: continue
        out.append([col, t, d.get("INTERPRETE",""), d.get("AUTOR",""),
                    d.get("ORQUESTA",""), d.get("CODIGO") or d.get("CASETE","")])
(ROOT/"docs"/"catalogo.json").write_text(
    json.dumps({"campos": ["coleccion","titulo","interprete","autor","orquesta","codigo"],
                "filas": out}, ensure_ascii=False, separators=(",",":")), encoding="utf-8")
print(len(out), "registros")
