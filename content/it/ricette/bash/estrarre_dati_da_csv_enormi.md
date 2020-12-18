---
title: "Estrarre dati da CSV enormi"
linkTitle: "Estrarre dati da CSV enormi"
date: 2020-12-18
description: >
  Estrarre dati da un CSV enorme, esempio il file [CSV ISTAT](https://esploradati.censimentopopolazione.istat.it/databrowser/#/it/censtest/BULKDOWNLOAD) da oltre 3 milioni di righe.
tags:
  - bash
  - xsv
  - script
issue: [171]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

L'[ISTAT](https://esploradati.censimentopopolazione.istat.it/databrowser/#/it/censtest/BULKDOWNLOAD) ha pubblicato nuovi dataset e tra questi c'è quello della `popolazione residente per sesso ed età` (2018 e 2019) che persa oltre 640 MB ed ha oltre 3 milioni di righe. Vediamo come estrarre velocemente i dati che ci servono, per esempio la popolazione residente per regione geografica: ripartizione geografica, regioni, province e comuni.

### Script

Un file di tali dimensioni è impossibile da gestire con programmi con interfaccia grafica, occorre necessariamente utilizzare la riga di comando. Un tool particolarmente indicato è [xsv](https://github.com/BurntSushi/xsv), semplice da usare, infatti questo script estrae un csv (con circa 16.000 righe) con i dati minimi per rispondere al quesito:


```bash
xsv search -d "|" -s ETA1 '^TOTAL$' Caratteristiche\ demografiche\ e\ cittadinanza\ -\ intero\ ds.csv \
| xsv search -s CITTADINANZA '^TOTAL$' \
| xsv search -s Sesso '^totale$' \
| xsv search -s 'Tipo dato' '^popolazione residente$' >./output.csv
```
dove:
- `-d` imposta il separatore di campi;
- `-s` imposta i campi da cercare;

il file CSV risultante è filtrato per valori, per filtrarlo anche per campi occorre aggiungere:

```bash
xsv select ITTER107,Territorio,TIME,Value
```

restituisce solo i campi elencati dopo il `select`;

oppure, se volessimo ottenere direttamente i 4 CSV (ripartizione geografica, regioni, province e comuni), basta lanciare questo script:

```bash
#!/bin/bash

# estrae le ripartizioni geografiche per il 2019
xsv search -d "|" -s ETA1 '^TOTAL$' Caratteristiche\ demografiche\ e\ cittadinanza\ -\ intero\ ds.csv \
 | xsv search -s CITTADINANZA '^TOTAL$' \
 | xsv search -s Sesso '^totale$'  \
 | xsv search -s 'Tipo dato' '^popolazione residente$' \
 | xsv search -s 'ITTER107' '^IT.$'  \
 | xsv search -s 'TIME' '2019' \
 | xsv select ITTER107,Territorio,TIME,Value>./pop_res_ISTAT19_rip.csv

# estrae le regioni per il 2019
 xsv search -d "|" -s ETA1 '^TOTAL$' Caratteristiche\ demografiche\ e\ cittadinanza\ -\ intero\ ds.csv \
 | xsv search -s CITTADINANZA '^TOTAL$' \
 | xsv search -s Sesso '^totale$'  \
 | xsv search -s 'Tipo dato' '^popolazione residente$' \
 | xsv search -s 'ITTER107' '^IT..$'  \
 | xsv search -s 'TIME' '2019' \
 | xsv select ITTER107,Territorio,TIME,Value>./pop_res_ISTAT19_reg.csv

# estrae le province per il 2019
xsv search -d "|" -s ETA1 '^TOTAL$' Caratteristiche\ demografiche\ e\ cittadinanza\ -\ intero\ ds.csv \
 | xsv search -s CITTADINANZA '^TOTAL$' \
 | xsv search -s Sesso '^totale$'  \
 | xsv search -s 'Tipo dato' '^popolazione residente$' \
 | xsv search -s 'ITTER107' '^IT...$'  \
 | xsv search -s 'TIME' '2019' \
 | xsv select ITTER107,Territorio,TIME,Value>./pop_res_ISTAT19_prov.csv

# estrae i comuni per il 2019
 xsv search -d "|" -s ETA1 '^TOTAL$' Caratteristiche\ demografiche\ e\ cittadinanza\ -\ intero\ ds.csv \
 | xsv search -s CITTADINANZA '^TOTAL$' \
 | xsv search -s Sesso '^totale$'  \
 | xsv search -s 'Tipo dato' '^popolazione residente$' \
 | xsv search -s 'ITTER107' '^\d.*'  \
 | xsv search -s 'TIME' '2019' \
 | xsv select ITTER107,Territorio,TIME,Value>./pop_res_ISTAT19_com.csv
```

### Output

- file CSV ripartizioni geografiche ISTAT

ID|ITTER107|Territorio|TIME|Value
--|--------|----------|----|----:
1|ITC|Nord-ovest|2019|15988679
2|ITD|Nord-est|2019|11627537
3|ITE|Centro|2019|11831092
4|ITF|Sud|2019|13707269
5|ITG|Isole|2019|6486911

### Riferimenti utili

- [xsv](https://github.com/BurntSushi/xsv)
- [CSV ISTAT](https://esploradati.censimentopopolazione.istat.it/databrowser/#/it/censtest/BULKDOWNLOAD)
- [Filtrare un file CSV da 24 milioni di righe in pochi secondi](https://medium.com/mai-piu-senza/filtrare-un-file-csv-da-24-milioni-di-righe-in-pochi-secondi-531527dbf84)
