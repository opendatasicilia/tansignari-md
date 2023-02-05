---
title: "Estrarre le chiavi e i valori utilizzate di un dominio di campo"
linkTitle: "Estrarre le chiavi e i valori di un dominio di campo utilizzate"
date: 2023-01-27
description: >
  Come estrarre le chiavi e i valori di un dominio di campo utilizzate in un database.
  - bash
  - json
  - Miller
  - filegdb
issue: [239]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Dato un FileGDB [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) (pesa circa 5 GB con oltre 300 tabelle, relazioni e domini), che contiene semplici tabelle e tabelle con attributi geometrici e domini di campo. I domini di campo possono essere caratterizzati da 'n' record, ma spesso non sono tutti utilizzati, esempio: il dominio che segue

| k   | v                               |
| --- | ------------------------------- |
| 01  | aree percorse da incendi        |
| 02  | tagliate                        |
| 03  | rimboschimenti e nuovi impianti |
| 04  | viali tagliafuoco               |
| 95  | altro                           |
| 91  | Non conosciuto                  |
| 93  | Non definito                    |
| 94  | Non applicabile                 |

ha 8 record, ma quanti di questi sono stati utilizzati nel database ?

Con `ogr2ogr` è possibile "risolvere" i domini usando il seguente costrutto:

```
ogr2ogr -f "CSV" DBGT_10K_22_V01.gdb -resolveDomains
```
ottenendo una tabella simile a quella di sotto (per ogni layer presente nel database):

![image](https://user-images.githubusercontent.com/7631137/215165038-0f15cba4-bec1-4c09-98b1-60899e729a74.png)

in pratica i campi con dominio vengono esplosi in due colonne:
1. la colonna associata al dominio visualizza la chiave;
2. la colonna `nomeCampo_resolved` visualizza la decodifica ovvero il valore;

l'obiettivo è ottenere i domini di campo con i record utilizzati.

## Soluzione

in questa soluzione è estratto solo la chiave (id) della coppia chiave-valore

```sh
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

# NOTA BENE: uso Miller 6

# crea cartella di output
mkdir -p ./output

# if file exists, delete it
if [ -f ./output/toto.jsonl ]; then
  rm ./output/toto.jsonl
fi

# per ogni CSV
for i in ./*.csv; do
  # estrai nome
  filename=$(basename "$i" .csv)
  # estrai prima riga e per ogni coppia chiave-valore, se la chiave termina con "resolved", estrai il nome campo
  mlr --c2n head -n 1 then put -q 'for (k,v in $*) { if (k =~ "^.+resolved$") {print k}}' ${i} | while IFS= read -r line; do
    # rimuovi "_resolved" dal nome campo
    field=$(echo "$line" | sed 's/_resolved//')
    # e per ogni campo estratto, estrai da ogni CSV corrispondente i valori univoci del campo e aggiungi a output nome file e nome campo; il tutto in formato JSONL
    mlr --icsv --ojsonl cut -f "$field" then uniq -a then label id then put '$campo="'"$field"'";$file="'"$filename"'"' ${i} >>./output/toto.jsonl
  done
done
# converte da jsonl in csv
mlr --j2c sort -f campo -t id ./output/toto.jsonl >./output/toto.csv
```

output:

![](https://user-images.githubusercontent.com/7631137/216811657-120e268f-32c8-47cf-b045-23f64e888146.png)

dove:

- `id` è il valore della chiave
- `campo` è attributo tabella associato al dominio
- `file` è il nome del layer

per estrarre la chiave e il valore:

```sh
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

# NOTA BENE: uso Miller 6

# crea cartella di output
mkdir -p ./output

# if file exists, delete it
if [ -f ./output/toto.jsonl ]; then
  rm ./output/toto.jsonl
fi

# per ogni CSV
for i in ./*.csv; do
  # estrai nome
  filename=$(basename "$i" .csv)
  # estrai prima riga e per ogni coppia chiave-valore, se la chiave termina con "resolved", estrai il nome campo
  mlr --c2n head -n 1 then put -q 'for (k,v in $*) { if (k =~ "^.+resolved$") {print k}}' ${i} | while IFS= read -r line; do
    # rimuovi "_resolved" dal nome campo
    fieldk=$(echo "$line" | sed 's/_resolved//')
    # lascia inalterato il nome campo
    fieldv=$(echo "$line")
    # e per ogni campo estratto, estrai da ogni CSV corrispondente i valori univoci del campo e aggiungi a output nome file e nome campo; il tutto in formato JSONL
    mlr --icsv --ojsonl cut -f "$fieldk" then uniq -a then label idk then put '$campo="'"$fieldk"'";$file="'"$filename"'"' ${i} >>./output/toto.jsonl
    mlr --icsv --ojsonl cut -f "$fieldv" then uniq -a then label idv then put '$campov="'"$fieldv"'";$file="'"$filename"'"' ${i} >>./output/totov.jsonl
  done
done

mlr --j2c sort -f campo -t idk then cat -n ./output/toto.jsonl >./output/toto.csv
mlr --j2c sort -f campov -t idv then cat -n ./output/totov.jsonl >./output/totov.csv

# elimina i campi non utili
mlr --csv --implicit-csv-header --headerless-csv-output cut -x -f 4 ./output/toto.csv >./output/toto1.csv
mlr --csv --implicit-csv-header --headerless-csv-output cut -x -f 1,3 ./output/totov.csv >./output/totov1.csv

# affianca i due output
paste -d, ./output/toto1.csv ./output/totov1.csv >./output/toto_all1.csv

# sistema ordine campi
mlr --csv --fs "," reorder -f n,idk,idkv,campo,file ./output/toto_all1.csv >./output/lista_finale.csv

# cancella i file csv non più utili
rm ./output/toto1.csv
rm ./output/totov1.csv
rm /output/toto_all1.csv
```

![](https://user-images.githubusercontent.com/7631137/215317822-f77c9397-6ecb-4405-b715-828388975b1a.png)

dove:

- `n`: numero progressivo
- `id`: chiave della coppia chiave-valore utilizzato;
- `idv`: valore della coppia chiave-valore utilizzato;
- `campo` attributo associato al dominio;
- `file` nome del layer

## Dati

- [download](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) file pesante +5 GB
- [dati di esempio](https://github.com/opendatasicilia/tansignari/files/10522430/esempio.zip)

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- Miller (mlr): <http://johnkerl.org/miller/doc/reference.html>
- paste: <https://linuxize.com/post/paste-command-in-linux/>

