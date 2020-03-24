---
title: "Da coppie di coordinate a linee"
linkTitle: "Da coppie di coordinate a linee"
date: 2019-07-21
description: >
 Creare linee a partire da coppie di punti.
tags:
  - script
  - bash
  - GDAL/OGR
  - CSV
  - SQLite
  - geojson
issue: [46]
autori: ["Gianni Vitrano"]
chefs: ["Andrea Borruso","Totò Fiandaca"]
---

---

**Caso d'uso:** Creare linee a partire da coppie di punti e indentificativo linea

## script bash

```bash
ogr2ogr -f geojson -dialect sqlite -sql  \
"SELECT t.lineID,
MakeLine(MakePoint(CAST(t.longitude AS float),CAST(t.latitude AS float),4326)) AS geom
FROM (SELECT * FROM lineegb ORDER BY CAST(lineID AS integer),
CAST(point AS integer)) t GROUP BY 1" lineCTgb_asc.geojson lineegb.csv
```

## Dati

il file CSV `lineegb.csv` è scaricabile da [qui](https://github.com/opendatasicilia/tansignari/files/3098483/lineegb.zip)

---

## Riferimenti utili

- [**SQLite**](https://www.sqlite.org/index.html)
- [**GDAL/OGR**](https://www.gdal.org/ogr2ogr.html)

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- **Blog Pigrecoinfinito**: [DA COPPIE DI PUNTI A LINEE USANDO GDAL/OGR](https://pigrecoinfinito.wordpress.com/2019/04/20/da-coppie-di-punti-a-linee-usando-gdal-ogr/)
