---
title: "Unire enne file CSV"
linkTitle: "Unire molti file CSV con stessa struttura"
date: 2021-05-15
description: >
  Unire molti file CSV con stessa struttura
tags:
  - bash
  - csv/tsv
  - miller
  - script
  - cat
issue: [180]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Avendo a disposizione 10 file CSV, ognuno cosi strutturato:

file CSV 1:

nome | campo1 | campo2 | campo3
-----|--------|--------|-------
A    | 10     | 25     | ciao
B    | 102    | 1000   | w andrea
H    | 10.4   | 32.33  | w miller
...  | ...    | ...    | ....

file CSV n-esimo:

nome | campo1 | campo2 | campo3
-----|--------|--------|-------
AA   | 101    | 25     | cucu
BA   | 102    | 1000   | w ODS
HA   | 104    | 32.33  | w VisiData
...  | ...    | ...    | ....

come unire (fare append, mergiare) i 10 file CSV per ottenerne uno solo:

```
cat *.csv >./out.csv
```

il comando di sopra unisce tutto, quindi anche le 10 righe di intestazione.

### Introduzione

`cat` non è un'applicazione "csv aware", ovvero non tiene conto delle specifiche del formato e quindi la prima riga è uguale alla 37. Lui di base stampa righe.

### Soluzione tramite loop

Estrarre la prima riga con `head -n 1` e metterla in un file, poi in for loop con `tail -n +2` estrarre da riga 2 in poi da tutti i csv, poi in append su quel file con l'intestazione. Oppure:

### Soluzione con Miller

Oppure usare una utility che tenga conto del formato (quindi sa che c'è una riga di intestazione), come `Miller`, il comando è:

```
mlr --csv cat ./*.csv >./output.csv
```

### Riferimenti utili

- [cat](https://it.wikipedia.org/wiki/Cat_(Unix))
- [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)
