---
title: "Come applicare una funzione spaziale a un vettore importato"
linkTitle: "Applicare una funzione spaziale a un vettore importato"
date: 2023-09-02
description: >
  Come applicare una funzione spaziale a un vettore importato in duckDB.
tags:
  - riga di comando
  - duckdb
  - ogr2ogr
  - Join
issue: [256]
chefs: ["Totò Fiandaca"]
guide: ["Totò Fiandaca","Andrea Borruso"]
---

---

## Caso d'uso

Interrogare uno shapefile collegato a duckdb ed estrarre info anche tramite funzioni spaziali come ST_Centroid().

## soluzione

In **duckDB** la geometry di un vettore è convertita automaticamente nel formato _WKB_ e il nome della colonna geometrica sarà `wkb_geometry`, pertanto, per richiamare la geometry in una funzione spaziale occorre necessariamente convertirla usando la funzione `ST_GeomFromWKB()`, quindi la query deve essere così:

```sql
SELECT ST_Centroid(ST_GeomFromWKB(a.wkb_geometry)) AS centroid
FROM ST_Read("shapefile.shp") a;
```

**Nota bene**: _**duckDB**_ non supporta tutti le tipologie di geometrie, ma solo quelle 2D, per esempio non supporta (attualmente) tutti le tipologie con Z o M.


## dati

[download](https://github.com/opendatasicilia/tansignari/files/12504196/ProvCM01012023.zip)

## Riferimenti utili

- [ogr2ogr](https://gdal.org/programs/ogr2ogr.html)
- [duckdb](https://aborruso.github.io/posts/duckdb-intro-csv/)
- [WKB](https://www.ibm.com/docs/it/i/7.5?topic=formats-well-known-binary-wkb-format)
