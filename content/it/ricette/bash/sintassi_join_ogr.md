---
title: "Come scrivere una JOIN tabellare con ogr"
linkTitle: "Sintassi per JOIN tabellare usando ogr2ogr"
date: 2022-07-03
description: >
  Come realizzare una JOIN tabellare usando l'utility da riga di comando ogr2ogr
tags:
  - bash
  - ogr2ogr
  - ogr
  - join
issue: [218]
chefs: ["Totò Fiandaca"]
guide: ["Totò Fiandaca"]
---

---

## Caso d'uso

Dati due `shapefile` con un campo correlato (`id`), realizzare una JOIN tabellare tra i due file.

esempio shapefile:

![](https://user-images.githubusercontent.com/7631137/175516439-07b58219-0ab2-41fa-8933-9207698aaad6.png)

## Esempio

```
ogr2ogr -sql \ 
"SELECT t1.*, t2.valore \ 
FROM test1 t1 JOIN './test2.shp'.test2 t2 ON t1.id=t2.id" \ 
./testkk.shp ./test1.shp
```

dove:

1. `test1` è il primo shapefile;
2. `test2` è il secondo shapefile;
3. `testkk` è il risultato della JOIN tabellare.


![](https://user-images.githubusercontent.com/7631137/175116887-e0820132-ba91-4624-ab76-d156e7e3526a.png)

## Dati

[download](https://github.com/opendatasicilia/tansignari/files/8947840/andrea.zip)

## Riferimenti utili

- [ogr2ogr](https://gdal.org/programs/ogr2ogr.html)