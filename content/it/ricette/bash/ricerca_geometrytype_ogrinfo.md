---
title: "Ricerca di geometry type con ogrinfo"
linkTitle: "Ricercare geometry type diverse da MultiPolygon usando ogrinfo"
date: 2023-02-05
description: >
  Come ricercare geometry type diverse da MultiPolygon usando ogrinfo.
tags:
  - bash
  - ogrinfo
  - ogr
  - filegdb
issue: [241]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso", "Totò Fiandaca"]
---

---

## Caso d'uso

Per una verifica, sto cercando nel layer `EDIFC_CR_EDF_ME_SR` (~500k row), presente nel FileGDB `DBGT_10K_22_V01.gdb`, la presenza di GeometryType differenti da MULTIPOLYGON, quindi utilizzo questo costrutto:

```
ogrinfo DBGT_10K_22_V01.gdb -dialect SQLite -sql "SELECT * FROM EDIFC_CR_EDF_ME_SR WHERE ST_GeometryType(SHAPE)!='MULTIPOLYGON'"
```

ma ottengo uno strano risultato:

```
Had to open data source read-only.
INFO: Open of `DBGT_10K_22_V01.gdb'
      using driver `OpenFileGDB' successful.

Layer name: SELECT
Geometry: Multi Polygon
Feature Count: 0
Layer SRS WKT:
PROJCRS["RDN2008 / UTM zone 32N",
    BASEGEOGCRS["RDN2008",
        DATUM["Rete Dinamica Nazionale 2008",
            ELLIPSOID["GRS 1980",6378137,298.257222101,
                LENGTHUNIT["metre",1]]],
        PRIMEM["Greenwich",0,
            ANGLEUNIT["degree",0.0174532925199433]],
        ID["EPSG",6706]],
    CONVERSION["UTM zone 32N",
        METHOD["Transverse Mercator",
            ID["EPSG",9807]],
        PARAMETER["Latitude of natural origin",0,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8801]],
        PARAMETER["Longitude of natural origin",9,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8802]],
        PARAMETER["Scale factor at natural origin",0.9996,
            SCALEUNIT["unity",1],
            ID["EPSG",8805]],
        PARAMETER["False easting",500000,
            LENGTHUNIT["metre",1],
            ID["EPSG",8806]],
        PARAMETER["False northing",0,
            LENGTHUNIT["metre",1],
            ID["EPSG",8807]]],
    CS[Cartesian,2],
        AXIS["(E)",east,
            ORDER[1],
            LENGTHUNIT["metre",1]],
        AXIS["(N)",north,
            ORDER[2],
            LENGTHUNIT["metre",1]],
    USAGE[
        SCOPE["GIS."],
        AREA["Italy - onshore and offshore - west of 12°E."],
        BBOX[36.53,5.94,47.04,12]],
    ID["EPSG",7791]]
Data axis to CRS axis mapping: 1,2
Geometry Column = Shape
ClassREF: String (0.0)
SubRegID: String (0.0)
CR_EDF_POR: String (0.0)
Shape_Length: Real (0.0)
Shape_Area: Real (0.0)
```

intanto, leggo `Layer name: SELECT` e poi COUNT 0.

Ma se lancio:

`ogrinfo -al DBGT_10K_22_V01.gdb EDIFC_CR_EDF_ME_SR | grep MultiSurface`

ottengo 75 record.

![image](https://user-images.githubusercontent.com/7631137/216839925-9ba80b59-4598-4faa-bb37-d377485551bc.png)

## Soluzione

La soluzione trovata è tramite ogrinfo e il seguente costrutto:

```
ogrinfo -sql "select count(*) from EDIFC_CR_EDF_ME_SR where OGR_Geometry LIKE 'MULTISURFACE'" x_Andy_only_Polygon2.gdb EDIFC_CR_EDF_ME_SR
```

![](https://user-images.githubusercontent.com/7631137/218672739-e3d4a04d-4a09-40c1-a589-12ac123a8b1b.png)

Non è stata utilizzata una query spaziale ma una semplice ricerca del termine `'MULTISURFACE'`

dove:
- `count(*)` conta il numero di occorrenze;
- `OGR_Geometry` campo speciale, rappresenta il tipo di geometria restituito da OGRGeometry::getGeometryName() e può essere utilizzato per distinguere i vari tipi di geometria.

## Dati

- [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401)

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- ogrinfo: <https://gdal.org/programs/ogrinfo.html>
- OGR_Geometry: <https://gdal.org/user/ogr_sql_dialect.html#ogr-geometry>
