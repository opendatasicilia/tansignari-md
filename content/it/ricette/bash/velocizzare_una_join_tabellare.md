---
title: "Velocizzare una JOIN tabellare usando ogr2ogr"
linkTitle: "In che modo velocizzare una JOIN tabellare usando ogr2ogr"
date: 2022-07-03
description: >
  Come velocizzare una JOIN tabellare usando ogr2ogr o altri utility
tags:
  - bash
  - ogr2ogr
  - ogr
  - join
  - csv
  - dbf
  - mapshaper
  - shapefile
issue: [235]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Il seguente costrutto permette di fare una join tabellare tra uno **shapefile** e una tabella **dbf**; entrambi i file hanno meno di 3000 record, ma la join impiega **oltre 40 secondi** in ambiente linux wsl (Ubuntu 20.04) o su OSGeo4W Shell:

```
time ogr2ogr -progress -sql "select s.AC_VEI_SED AS AC_VEI_SED, s.ClassREF AS ClassREF, t.ZON_IN_TY AS ZON_IN_TY, t.ID AS ID, t.FONTE AS FONTE, t.LIVELLO AS LIVELLO from butta15a_Dissolve1 s left join './id15a_to_ZON_IN_12113_t.dbf'.id15a_to_ZON_IN_12113_t t on s.FIRST_SubR = t.SubRegID" ./shape_join4.shp ./butta15a_Dissolve1.shp
```

lanciata da una cartella qualsiasi di Windows.

## Soluzione in ambiente WSL

Il kernel linux sotto wsl, è ottimizzato per girare nelle cartelle linux di wsl, quindi occorre creare (`mkdir -p tmp`) una cartella `tmp` nella `home` (`cd ~`) e spostarci dentro i file e rilanciare da qui lo script di sopra:

![](https://user-images.githubusercontent.com/7631137/212560260-c136374c-b467-4a04-9426-87a8e2edcc1f.png)

impiega meno di 4 secondi!!!

## Soluzione con mapshaper

ogr2ogr non è veloce per fare le join soprattutto se uno dei file è un `dbf`, quindi proviamo a convertire il file in `csv`:

```
ogr2ogr -f "CSV" id15a_to_ZON_IN_12113_t.csv id15a_to_ZON_IN_12113_t.dbf
```
e poi con `mapshaper`:

```
mapshaper butta15a_Dissolve1.shp -join id15a_to_ZON_IN_12113_t.csv keys=FIRST_SubR,SubRegID string-fields=FIRST_SubR,SubRegID -o out.shp
```

il risultato è incredibilmente veloce:

![](https://user-images.githubusercontent.com/7631137/212561598-889c9500-8352-45cc-81a2-51b47081c405.png)

meno di un secondo!!!

## Dati

[download](https://github.com/opendatasicilia/tansignari/files/10420778/dati_test2.zip)

## Riferimenti utili

- [ogr2ogr](https://gdal.org/programs/ogr2ogr.html)
- [JOINs](https://gdal.org/user/ogr_sql_dialect.html#joins)
- [mapshaper](https://github.com/mbloch/mapshaper/wiki/Command-Reference)
