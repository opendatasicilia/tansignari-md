---
title: "Come duplicare le righe e appenderle nello stesso file CSV"
linkTitle: "Duplicare e appendere righe nello stesso file CSV"
date: 2020-11-27
description: >
  Come duplicare le righe e appenderle nello stesso file CSV.
tags:
  - csv/tsv
  - miller
issue: [167]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

A partire da un file CSV cosi strutturato:

```
a,b,c,d
1,2,3,4
5,6,7,8
```

ottenere un file CSV con le righe duplicate e accodate:

```
a,b,c,d
1,2,3,4
1,2,3,4
1,2,3,4
5,6,7,8
5,6,7,8
5,6,7,8
```

## Soluzione

```
mlr --csv repeat -n 3 ./input.csv
```

Sfrutto [Miller](https://miller.readthedocs.io/en/latest/index.html), dove:

`-n` è il numero di volte

## Riferimenti utili

1. [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)
