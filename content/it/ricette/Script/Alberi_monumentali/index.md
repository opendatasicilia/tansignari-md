---
title: "Alberi Monumentali"
linkTitle: "ALberi Monumentali"
date: 2020-07-29
description: >
 Come scaricare elenco degli alberi monumentali d'Italia ai sensi della Legge n. 10/2013 e del Decreto 23 ottobre 2014.
tags:
  - script
  - riga di comando
  - miller
  - CSV/TSV
  - pyexcel
issue: [155]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

L' elenco degli alberi monumentali d'Italia ai sensi della Legge n. 10/2013 e del Decreto 23 ottobre 2014 è stato _aggiornato al 24-07-2020_, in questa ricetta vedremo come scaricare i file `*.xls`, presenti nel [sito](https://www.politicheagricole.it/flex/cm/pages/ServeBLOB.php/L/IT/IDPagina/11260) del **Ministero delle politiche agricole alimentari e forestali** e creeremo un unico file CSV.

Le difficoltà presenti sono legati alla presenza di 21 file (da scaricare) in formato `xls`, uno per ogni regione e le Provincia Autonoma; le coordinate (DMS) hanno uno spazio che li rende inutilizzabili e la virgola al posto del punto decimale; per risolvere tutti questi problemi, basta laciare il seguente script bash per ottenere un unico file CSV pronto all'uso.

## Script bash

```bash
#/bin/bash

### requisiti ###
# miller https://github.com/johnkerl/miller
# scrape https://github.com/aborruso/scrape-cli
# pyexcel-cli https://github.com/pyexcel/pyexcel-cli
# pyexcel-xls https://github.com/pyexcel/pyexcel-xls
# yq https://github.com/kislyuk/yq
# parallel https://www.gnu.org/software/parallel/
### requisiti ###

set -x

mkdir -p ./rawdata
mkdir -p ./processing

# cancella file xls
rm ./rawdata/*.xls

# scrica i file xls
curl "https://www.politicheagricole.it/flex/cm/pages/ServeBLOB.php/L/IT/IDPagina/11260" |
  # estrai dati sui file XLS degli alberi
  scrape -be ".blob-element-download .viewLinkIMG" |
  # estrai proprietà href e text (URL e nome file)
  xq -r '.html.body.a[]|[."@href",."#text"]|@tsv' |
  # fai partire il download
  parallel --colsep '\t' wget {1} -O ./rawdata/{2}.xls

for i in ./rawdata/*.xls; do
  #crea una variabile da usare per estrarre nome e estensione
  filename=$(basename "$i")
  #estrai estensione
  extension="${filename##*.}"
  #estrai nome file
  filename="${filename%.*}"
  # converti file XLS in CSV
  pyexcel transcode --sheet-index 0 "$i" ./processing/"$filename".csv
done

# unisci i file, tenendo conto di eventuali campi in più e fai pulizia di eventuali spazi bianchi in più
mlr --csv unsparsify then clean-whitespace ./processing/*.csv >./alberi.csv

# dalle coordinate rimuovi spazi e sostituisci "," con "."
mlr -I --csv put '${LATITUDINE SU GIS}=gsub(${LATITUDINE SU GIS}," ","");${LONGITUDINE SU GIS}=gsub(${LONGITUDINE SU GIS}," ","");${LATITUDINE SU GIS}=gsub(${LATITUDINE SU GIS},",",".");${LONGITUDINE SU GIS}=gsub(${LONGITUDINE SU GIS},",",".")' ./alberi.csv
```

## Visualizzazione

![](qgis.jpg)

## Dati

1. file **CSV** : <https://github.com/opendatasicilia/tansignari/files/4995648/merge_fine.txt>
2. file **geojson** : <https://gist.github.com/pigreco/c9e5680d7db7e6e7c405f73dce2c3c47>
