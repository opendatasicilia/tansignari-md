---
title: "Estrarre le tabelle dei domini di campo da un FileGDB"
linkTitle: "Estrarre domini da FileGDB"
date: 2023-01-17
description: >
  Come estrarre le tabelle dei domini di campo da un FileGDB usando ogr2ogr
tags:
  - bash
  - ogr2ogr
  - ogr
  - database
  - filegdb
  - Miller
  - jq
issue: [236]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Dato un FileGDB [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) (pesa circa 5 GB con oltre 300 tabelle, relazioni e domini), che contiene semplici tabelle e tabelle con attributi geometrici e domini di campo. Queste ultime però non sono presenti direttamente come tabelle nel gdb ma sono impostate come domini e quindi non c'è modo di esportarle se non dopo averle convertite in tabelle, ma è un lavoro manuale e ripretitivo (sono oltre 200).

## Soluzione

```
ogrinfo -json DBGT_10K_22_V01.gdb | jq -r '.domains|keys[]' | while IFS="" read -r domain;do ogrinfo -json DBGT_10K_22_V01.gdb | jq -r '.domains.'"$domain"'.codedValues' | mlr --j2c reshape -r '.' -o k,v >"$domain".csv;done
```

dove:
- `-json` : è il formato di output di GDAL, necessita **>= GDAL 3.7**
- `ogrinfo -json DBGT_10K_22_V01.gdb` : estrae dal database un unico file _json_ con tutte le info (_dbgt10k_fc_domain.json_);
- `jq -r '.domains|keys[]'` : estrae, dall'output del precedente comando, solo i nomi dei domini di campo;
- `while IFS="" read -r domain;do ogrinfo -json DBGT_10K_22_V01.gdb` : crea un ciclo, e per ogni nome del dominio estrae l'elenco chiave valore presenti nel database;
- `jq -r '.domains.'"$domain"'.codedValues' ` : estrae i domini di campo di tipo codedValues;
- `mlr --j2c reshape -r '.' -o k,v` : converte dal formato json a csv e sistema le colonne k e v

script bash:

```sh
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# occorre  >=GDAL 3.7
# lista_demain.csv:
# ogrinfo -json DBGT_10K_22_V01.gdb | jq -r '.domains|keys[]'
# file json con le info su un FileGDB:
# ogrinfo -json DBGT_10K_22_V01.gdb

# crea cartella per i dati, se non esiste
mkdir -p "$folder"/data

# rimuovi i file csv, se esistono
find "$folder"/data -type f -name '*.csv' -delete
# ciclo
while IFS="" read -r domain; do
  jq -r '.domains.'"$domain"'.codedValues' dbgt10k_fc_domain.json |
  mlr --j2c reshape -r '.' -o k,v >"$folder"/data/"$domain".csv
done <lista_demain.csv
```

## Dati

[download](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) file pesante +5 GB

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- jq: <https://stedolan.github.io/jq/>
- Miller (mlr): <https://miller.readthedocs.io/>

