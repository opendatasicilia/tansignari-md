---
title: "Eliminare tabelle da un FileGDB"
linkTitle: "Eliminare tabelle da un FileGDB usando ogrinfo"
date: 2023-02-15
description: >
  Come eliminare tabelle da un FileGDB usando ogrinfo.
tags:
  - bash
  - ogrinfo
  - ogr
  - filegdb
issue: [248]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso", "Totò Fiandaca"]
---

---

## Caso d'uso

Per eliminare una tabella da un FileGDB:

```
ogrinfo -dialect FileGDB -sql "DROP TABLE EDIFC_CR_EDF_IS" test_delete.gdb
```
ma se volessi eliminare una serie di tabelle?
qui trovo indicazioni utili per una sola tabella: https://gdal.org/user/ogr_sql_dialect.html#drop-table


## Soluzione

La soluzione più ovvia è quella di realizzare un loop, come segue:

in ambiente `bacth`:
```
FOR /F "delims=" %i IN (lista_tabelle_delete.txt) DO (ogrinfo -dialect FileGDB -sql "DROP TABLE %i" DBGT_10K_22_V01.gdb)
```

in ambiente `bash`:

```
FOR i IN (lista_tabelle_delete.txt) DO; (ogrinfo -dialect FileGDB -sql "DROP TABLE $i" DBGT_10K_22_V01.gdb) done
```
dove:
- `lista_tabelle_delete.txt` contiene una lista di tabelle del FileGDB da eliminare;

sotto uno screenshot del risultato, ovvero sono rimaste solo tabelle con geometria Poligonale.

![](https://user-images.githubusercontent.com/7631137/219076036-8de5b22b-f294-4f0f-9924-e3955c6fd7e7.png)


## Dati

- [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401)

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- ogrinfo: <https://gdal.org/programs/ogrinfo.html>

