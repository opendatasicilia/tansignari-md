---
title: "Estrarre dati da un file json"
linkTitle: "Estrarre dati da un file json usando ogr2ogr"
date: 2023-01-18
description: >
  Come e  estrarre dati da un file json usando ogr2ogr.
tags:
  - bash
  - json
  - jq
  - Miller
  - filegdb
issue: [237]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Dato un FileGDB [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) (pesa circa 5 GB con oltre 300 tabelle, relazioni e domini), che contiene semplici tabelle e tabelle con attributi geometrici e domini di campo. Estrarre i domini di campo e creare una lista dei domini associati ai vari layer.

## Soluzione

```
 <dbgt10k_fc_domain.json jq '.layers[]|{name:.name,fields:.fields[].domainName}' | mlr --j2c unsparsify then filter '!is_null($fields)' then sort -f name,fields then nest --ivar "," -f fields
 ```
 output:

 ![](https://user-images.githubusercontent.com/7631137/213261147-57d108ed-f2aa-4cce-a775-895108c31089.png)

dove:
- `jq`, estrae prima il nodo `layers`, e poi dall'output costruisco una nuova struttura composta dal nome del layer e dal nodo `fields` contenuto nei layer;
- `Miller` trasforma il precedente output JSON in CSV, e filtro soltanto i record per i quali c'è un field associato, ordina per `name` e `fields` (campi creati) e infine implode i nomi dei field, li unisce, separandoli tramite `,` e raggruppandoli per nome di layer sorgente.

una riga per ogni dominio:

```
<dbgt10k_fc_domain.json jq '.layers[]|{name:.name,fields:.fields[].domainName}' | mlr --j2c unsparsify then filter '!is_null($fields)' then sort -f name,fields
```

![](https://user-images.githubusercontent.com/7631137/213261431-2c2e62a7-547a-42de-9f3a-52eda67b1392.png)

script bash:

```sh
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# dbgt10k_fc_domain.json ottenuto: 'ogrinfo -json DBGT_10K_22_V01.gdb'
# lista_demain.csv ottenuto da: 'ogrinfo -json DBGT_10K_22_V01.gdb | jq -r '.domains|keys[]''

# crea cartella per i dati, se non esiste
mkdir -p "$folder"/data

# rimuovi i file csv, se esistono
find "$folder"/data -type f -name '*.csv' -delete

while IFS="" read -r domain; do
  jq -r '.domains.'"$domain"'.codedValues' dbgt10k_fc_domain.json |
  mlr --j2c reshape -r '.' -o k,v >"$folder"/data/"$domain".csv
done <lista_demain.csv
```

## Dati

- [download](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) file pesante +5 GB
- [dbgt10k_fc_domain.json](https://github.com/opendatasicilia/tansignari/files/10609275/dbgt10k_fc_domain.zip)

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- jq: <https://stedolan.github.io/jq/>
- Miller (mlr): <https://miller.readthedocs.io/>

