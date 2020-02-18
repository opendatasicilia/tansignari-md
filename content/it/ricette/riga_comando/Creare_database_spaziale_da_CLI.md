---
title: "Creare database spaziale da riga di comando"
linkTitle: "Creare database spaziale da riga di comando"
date: 2019-03-07
description: >
  Crea un database SpatiaLite con geotabella partendo da un file CSV con coordinate.
tags:
  - database
  - riga di comando
  - bash
  - csv
  - SpatiaLite
  - SQLite
issue: [15]
autori: ["Totò Fiandaca"]
chef: "Andrea Borruso"
---

- issue correlata: [#15](https://github.com/opendatasicilia/tansignari/issues/15)
- autore: [_Totò Fiandaca_](https://github.com/pigreco)

---

## Dataset

* [01_demanio.csv](https://gist.github.com/aborruso/503df6c6477c341431e23bc51bc37149/raw/7aac29415b99512758acffd05fa463081f011484/01_demanio.csv)

## Procedimento

Salvare lo script bash con nome `geometry.sh` e poi, da riga di comando, dargli i permessi di esecuzione con `chmod +x geometry.sh` e poi lanciarlo con `./geometry.sh`

## Script Bash

```Bash
#!/bin/bash

sqlite3 nomeDb.sqlite <<EOF

.load /usr/local/lib/mod_spatialite.so
.mode csv 01_demanio
.import 01_demanio.csv opendemanio

SELECT InitSpatialMetaData(1);

SELECT  AddGeometryColumn ('opendemanio','geometry',3857,'POINT','XY');

UPDATE opendemanio SET geometry =
MakePoint(CAST(X AS float),CAST(Y AS float),3857);

EOF
```

## Cosa fa questo script

Crea un database spatialite con geotabella partendo da un file CSV con coordinate.
