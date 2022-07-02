---
title: "Come realizzare una multi-join"
linkTitle: "Come fare una JOIN Tabellare con 70 shapefile"
date: 2022-07-02
description: >
  A partire da 70 shapefile idendici, come unirli orizzontalmente e aggiungere lo stesso attributo.
tags:
  - riga di comando
  - Miller
  - ogr2ogr
  - Join
  - python
  - geopandas
  - merge
issue: [220]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso","Giovanni Pirrotta"]
---

---

## Caso d'uso

È un caso reale in cui si hanno molti shapefile identici, risultato di qualche analisi particolare, e dove un attributo vari al variare dell'analisi stessa, mantenendo la stessa geometria, e occorresse unire tutti gli shapefile in modo che la geometria rimanesse senza duplicati ma che gli attributi siano pari almeno al numero di shapefile da unire.

shapefile tipo:

![](https://user-images.githubusercontent.com/7631137/175516439-07b58219-0ab2-41fa-8933-9207698aaad6.png)

shapefile unito, obiettivo della ricetta:

![](https://user-images.githubusercontent.com/7631137/175517063-24639d31-fa3b-4440-9af6-32b2669e55e9.png)


## prima soluzione bash

Un probabile approccio potrebbe essere quello di convertire gli shapefile (dal shp002 al shp70) in semplice tabella CSV e fare un merge orizzontale tra tutti i file, infine, _fare una sola JOIN tabellare tra il primo shp001 e il tabellone risultante dal merge precedente_. [tratto da: quattrochiacchiereinquattro by Andrea Borruso]:

```bash
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

# crea i CSV e ordina i CSV per ID
for i in *.shp; do
  name=$(basename "$i" .shp)
  ogr2ogr -f CSV -sql 'select id,value from '"$name"'' "$name".csv "$name".shp
  mlr -I --csv sort -n id then cut -f value then rename value,value_"$name" "$name".csv
done

# unisci i CSV in un unico CSV
paste -d "," shp*.csv > all.csv

# estrai il primo shp e convertilo in CSV
primoShape=$(find ./ -iname "*.shp" -type f | head -n 1)
tmp=$(basename "$primoShape" .shp)
ogr2ogr -f CSV  tmp.csv "$tmp".shp

# estrai da questo ultimo soltanto la colonna id
mlr -I --csv cut -f id then sort -n id tmp.csv

# crea il file finale
paste -d "," tmp.csv all.csv > finale.csv
```

ecco un esempio di output

| id  | value_shp001 | value_shp002 | value_shp003 | value_shp004 |
| --- | -----------: | -----------: | -----------: | -----------: |
| 1   | 23           | 10           | 254          | 50           |
| 2   | 34           | 25           | 32           | 41           |
| 3   | 100          | 150          | 541          | 47           |

## seconda soluzione bash

un altro approccio è quello di fare un normale _merge verticale_ con tutti gli shapefile, successivamente convertirlo in file CSV ed infine trasformare il tabellone da wide a long:

```bash
#!/bin/bash

# unisci in verticale gli shape
ogrmerge.py -overwrite_ds -single -src_layer_field_name layer -o merged.shp shp*.shp

# converti lo shape in  CSV
ogr2ogr -f CSV merged.csv merged.shp

# converti il CSV da wide a long
mlr -I --csv reshape -s layer,value merged.csv
```

ecco un esempio di output

| id  | value_shp001 | value_shp002 | value_shp003 | value_shp004 |
| --- | -----------: | -----------: | -----------: | -----------: |
| 1   | 23           | 10           | 254          | 50           |
| 2   | 34           | 25           | 32           | 41           |
| 3   | 100          | 150          | 541          | 47           |

## terza soluzione python

altro approccio è quello tramite Python e in particolare Geopandas:

```py
import glob
import geopandas as gpd

files = glob.glob("../data/andrea/*.shp")
files.sort()
gdf = gpd.read_file(files[0])
gdf.rename(columns={'value':f'value_shp001'}, inplace=True)

for f in files[1:]:
    name = f[f.rfind('/')+1:-4]
    gdf2 = gpd.read_file(f)
    new_column = f'value_{name}'
    gdf2.rename(columns={'value': new_column}, inplace=True)
    gdf = gdf.merge(gdf2[['id',new_column]], on='id')
```

![](https://user-images.githubusercontent.com/2639616/175574183-87b861d6-7857-4a85-a7c5-6a142749d666.png)

## dati

[download](https://github.com/opendatasicilia/tansignari/files/8974633/andrea.zip)

## Riferimenti utili

- [ogr2ogr](https://gdal.org/programs/ogr2ogr.html)
- [ogrmerge.py](https://gdal.org/programs/ogrmerge.html)
- [Miller](https://github.com/johnkerl/miller)
- [Geopandas](https://geopandas.org/en/stable)

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- [blog post su Pigrecoinfinito]()
