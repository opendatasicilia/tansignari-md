---
title: "Operatore IN fuori da ambiente SQL"
linkTitle: "Operatore IN fuori da ambiente SQL"
date: 2020-12-12
description: >
  Come realizzare l'operatore IN in un ambiente diverso dal SQL.
tags:
  - csv/tsv
  - miller
  - visidata
  - SQL
  - SQLite
  - regex
issue: [169]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Filtrare dei dati strutturati come i CSV usando l'operatore `IN`; in ambiente **SQLite** è facilissimo, ecco un esempio:

```sql
SELECT "id", "CODICE", "foglio", "prov", "cod_com"
FROM "nomeTabella"
WHERE "foglio" IN (20,21,22)
```
come fare usando la riga di comando (per esempio in **VisiData** o/e **Miller**)?

**input.csv:**

id|NUM_PART|foglio|prov|cod_com
--|------|--------|------|----
43|49|21|PA|Axxx
44|51|21|PA|Axxx
45|54|21|PA|Axxx
46|55|20|PA|Axxx
47|58|20|PA|Axxx
48|61|22|PA|Axxx
49|62|1|PA|Axxx
50|63|10|PA|Axxx
51|65|1|PA|Axxx
52|66|11|PA|Axxx
53|68|1|PA|Axxx

## Soluzione

- In [VisiData](https://www.visidata.org/): utilizzando i `regex` in questo modo:

posizionare il focus sulla colonna `foglio`, digitare `|` (che serve a selezionare tramite regex) e come regex: `(20|21|22)`; per ottenere il file con le sole righe selezionate digitare `"` e poi `Ctrl + s` per salvare il file.

![](https://user-images.githubusercontent.com/7631137/101989959-17691d80-3ca4-11eb-9881-28be29929d96.gif)

- con [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)

```
mlr --csv filter -S '$foglio=~"(20|21|22)"' test.csv >output.csv
```

 dove `-S` forza il dato come stringa

![](https://user-images.githubusercontent.com/7631137/101990055-b8f06f00-3ca4-11eb-8b01-487a0de004ed.gif)

**output.csv:**

id|NUM_PART|foglio|prov|cod_com
--|--------|------|----|-----
43|49|21|PA|Axxx
44|51|21|PA|Axxx
45|54|21|PA|Axxx
46|55|20|PA|Axxx
47|58|20|PA|Axxx
48|61|22|PA|Axxx


## Riferimenti utili

1. [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)
2. [VisiData ](https://www.visidata.org/)
3. [regex](https://it.wikipedia.org/wiki/Espressione_regolare)
