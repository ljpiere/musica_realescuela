# Discoteca del Abuelo

Catálogo web de la colección musical registrada en el programa DOS "Sistema Integrado de Información Musical" (Clipper/dBase, Ibagué 1996), cuyos archivos originales están en `app_base_win98/`.

- `tools/export_dbf.py` — lee los `.DBF` (codificación CP850, omite registros borrados) y genera `docs/catalogo.json`.
- `docs/` — sitio estático para GitHub Pages.

## Actualizar datos
    python tools/export_dbf.py

## Publicar
El workflow `.github/workflows/pages.yml` publica `docs/` en cada push a `main` que toque esa carpeta (o manualmente desde Actions).
Una sola vez: GitHub → Settings → Pages → Source: **GitHub Actions**.

URL: https://ljpiere.github.io/musica_realescuela/

## Ver en local
    cd docs && python -m http.server
