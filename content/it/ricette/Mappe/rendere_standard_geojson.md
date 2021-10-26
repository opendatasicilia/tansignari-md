---
title: "Come rendere standard un geojson esportato male"
linkTitle: "Come rendere standard un geojson esportato male"
date: 2021-10-24
description: >
  Come rendere standard un geojson esportato male, ovvero, con coordinate dei vertici a 15 cifre.
tags:
- GDAL/OGR
- CRS
- mappa
- geojson
issue: [193]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Un amico esporta, frettolosamente, un layer vettoriale in formato `geojson` senza configurarlo bene, ovvero, la precisione delle coordinate supera le 7 cifre consigliate dallo [standard](https://gdal.org/drivers/vector/geojson.html#layer-creation-options), vediamo come ovviare a questo problema e rendere il file standard.

esempio di file geojson non standard:

![](https://user-images.githubusercontent.com/7631137/138601168-615fdc70-68e9-4fa7-9af9-80170a5396f7.png)

come si nota dalla coordinata evidenziata, ci sono 15 cifre dopo la virgola, lo standard consiglia 7, ma per lavori in ambito GIS e per le coordinate lat e long bastano 6 cifre (siamo intorno ai 10 cm).

## soluzione

Lo standard `geojson` fissa alcune cose: una è il sistema di coordinate (EPSG:4326), l'altra la precisione (a 7 decimali).

Con `GDAL`  fisso il rispetto dello standard con:

```
 ogr2ogr -f GeoJSON output.geojson input.shp -lco RFC7946=YES
```

per modificare la precisione (per esempio a 5), usare:

```
 ogr2ogr -f GeoJSON output.geojson input.shp -lco RFC7946=YES -lco COORDINATE_PRECISION=5
```

**Nota bene**: nella documentazione [GDAL](https://gdal.org/drivers/vector/geojson.html), ogni formato ha la sua pagina. Per **GeoJSON** è https://gdal.org/drivers/vector/geojson.html

---

## Riferimenti utili

- [**GDAL**](https://gdal.org/)
- [geojson](https://en.wikipedia.org/wiki/GeoJSON)
