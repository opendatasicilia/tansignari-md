---
title: "Aggiornare attributo di uno shapefile che dipende dal nome dello strato"
linkTitle: "Aggiornare attributo di uno shapefile che dipende dal nome dello strato"
date: 2022-05-06
description: >
 Aggiornare attributo di uno shapefile il cui nome dipende dal nome dello stesso strato.
tags:
  - script
  - bash
  - SQLite
  - SQL
  - gdal/ogr
  - find
  - sed
issue: [212]
chefs: ["Totò Fiandaca"]
guide: ["Totò Fiandaca"]
---

---

## caso d'uso

Aggiornare un attributo di uno shapefile è abbastanza semplice e si può risolvere in molti modi, aggiornare un attributo che cambia sempre, al cambiare del nome dello shapefile è una cosa molto più difficile: in questo esempio risolveremo il caso in cui il nome dell'attributo dipende dal nome dello shapefile.

Il legame tra nome shapefile e nome attributo è il seguente:

Nome strato/shapefile: (senza spazi):

## ST XX TE YY CL ZZ ABC

- `ABC` può essere `PLG`, `ARC` o `PNT`
- esempio: ST01TE01CL01PLG 
- XX varia in 01, 02, 03.... 10,11...
- YY varia in 01,02,03....
- ZZ varia in 01,02,03...

nome attributo da aggiornare: (senza spazi):

## A XX YY ZZ 95

- esempio: A01010195
- XX varia in 01, 02, 03.... 10,11...
- YY varia in 01,02,03....
- ZZ varia in 01,02,03...

![image](https://user-images.githubusercontent.com/7631137/167091914-9db7ee6e-a694-4bcc-aa0d-330d046e0015.png)

nome strato             | nome attributo | vecchio valore | nuovo valore
----------------------|------------------|----------------:|---------------:
ST01TE01CL01PLG   | A01010195       |  2011               |   2021
ST12TE03CL05PLG   | A12030595       |  2011               |   2021

![image](https://user-images.githubusercontent.com/7631137/167095462-bef658a1-5ab4-4e40-9586-b5806a574da9.png)

## Valore da aggiornare

il valore del campo da aggiornare è sempre `2011` e va aggiornato a `2021`

## esempio applicativo

- se il nome dello shapefile si chiamasse `ST01TE01CL01PLG` il campo da aggiornare sarebbe questo `A01010195`
- se il nome dello shapefile si chiamasse `ST01TE01CL01ARC` il campo da aggiornare sarebbe questo `A01010195`
- se il nome dello shapefile si chiamasse `ST01TE01CL01PNT` il campo da aggiornare sarebbe questo `A01010195`

dove:
XX = 01
YY = 01
ZZ = 01

- se il nome dello shapefile si chiamasse `ST11TE04CL14PNT` il campo da aggiornare sarebbe questo `A11041495`

dove:
XX = 11
YY = 04
ZZ = 14

## script bash

```bash
#!/bin/bash

set -x

# crea un file con i percorsi relativi dello shapefile
find . -name *.shp >pathSHP.csv

for file in $(cat pathSHP.csv)
do
    # crea variabile ed estrae solo il nome dello shapefile
    nomeSHP=`echo $file | sed -E 's/^.\/.+\/(.+).shp$/\1/'`
    # crea variabile ed estrae il nome dell attributo da aggiornare
    campo=`echo $file | sed 's/ST/A/' | sed 's/TE//' | sed 's/CL//' | sed 's/...\.shp/95/' | sed -E 's/^.+\/(.+)$/\1/'`
    # aggiorna gli shapefile
    ogrinfo -dialect SQLite -sql "UPDATE ${nomeSHP} SET $campo='2021'  WHERE $campo='2011'" $file
done
```

per utilizzare lo script bash occorre installare:

- find
- GDAL

## Riferimenti

- **GDAL/OGR**: <https://gdal.org/programs/ogrinfo.html>
- **QGIS**: <https://www.qgis.org/it/site/https://www.qgis.org/it/site/>
- **GeoPortale Sardegna**: <https://www.sardegnageoportale.it/index.php?xsl=2425&amp;s=325563&amp;v=2&amp;c=14414&amp;t=1&amp;tb=14401>

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- Blog post su Pigrecoinfinito : <https://pigrecoinfinito.com/2022/05/16/aggiornare-attributo-di-uno-shapefile-che-dipende-dal-nome-dello-stesso-strato/>
