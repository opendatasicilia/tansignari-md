---
title: "Determinare ID elementi corrispondenti ai valori risultanti della funzione di aggregazione max"
linkTitle: "ID elementi risultanti della funzione max"
date: 2022-09-05
description: >
 Determinare gli identificativi univoci (ID) degli elementi corrispondenti ai valori risultanti della funzione di aggregazione max.
tags:
  - SQL
  - SQLite
  - SpatiaLite
  - query
  - shapefile
  - mappe
issue: [225]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso", "Totò Fiandaca"]
---

---

## Caso d'uso

Immaginiamo di avere degli oggetti, per esempio dei poligono che rappresentano degli edifici, e di voler determinare i valori **massimi** di due attributi (LG, LN) corrispondenti a delle misurazioni fatte per ogni lato dell'oggetto:

![](https://user-images.githubusercontent.com/7631137/188593848-b12deff9-70ed-4e21-b897-a4eca6302fe5.png)

La determinazione dei valori massimi LG e LN per ogni poligono è abbastanza facile e immediata, sotto la query:

```sql
SELECT
  nome,
  max(LG) AS lg_max,
  max(LN) AS ln_max
FROM
  dataset_test
GROUP BY
  nome
  ```

il quesito diventa più interessante se volessimo determinare gli identificativi univoci dei punti in cui la misurazione risultasse la più alta: ed è questo il quesito della ricetta.

La soluzione proposta è la seguente query:

```sql
WITH calcolo_max AS (
  SELECT
    NOME,
    max(LG) AS lg_max,
    max(LN) AS ln_max
  FROM
    dataset_test
  GROUP BY
    NOME
) -- calcola i valori massimi dei due attributi
SELECT
  calcolo_maxdue.NOME,
  id_lg_max,
  lg_max,
  PK_UID AS id_ln_max,
  ln_max
 FROM
  (
    SELECT
      calcolo_max.NOME,
      lg_max,
      ln_max,
      PK_UID AS id_lg_max
    FROM
      calcolo_max
      JOIN dataset_test f ON calcolo_max.NOME = f.NOME
      AND calcolo_max.lg_max = f.LG
  ) calcolo_maxdue
  JOIN dataset_test f ON calcolo_maxdue.NOME = f.NOME
  AND calcolo_maxdue.ln_max = f.LN
```

Nel linguaggio umano la query di sopra fa:

Crea una tabella temporanea (_calcolo_max_) e la popola con i valori massimi dei due attributi (LG e LN), successivamente, la stessa tabella viene messa in JOIN due volte con la tabella di ingresso (_dataset_test_) con i relativi filtri (_calcolo_max.NOME = f.NOME AND calcolo_max.lg_max = f.LG, per il primo attributo e calcolo_maxdue.NOME = f.NOME AND calcolo_maxdue.ln_max = f.LN per il secondo attributo_) ovvero, deve cercare solo il `nome` e il valore massimo relativo.

Il risultato è quello atteso:

nome|lg_max|ln_max|id_lg_max|id_ln_max
----|------|-----|-----|--------   
4791|47.9|41.9|0|4
7307|45.0|38.4|16|8
7724|58.1|49.5|17|17

dove:

- `id_lg_max` è l'id del valore massimo dell'attributo `lg`
- `id_ln_max` è l'id del valore massimo dell'attributo `ln`

questo permetterà di localizzare, con precisione, quale degli enne punti è caratterizzato dal valore massimo.

![](https://user-images.githubusercontent.com/7631137/188599426-bbfeed08-dc84-424f-ad84-467d00b4b572.png)

**NB:** Se il valore massimo fosse presente in più punti, la query di sopra restituirebbe una riga per ogni valore massimo uguale.

## RIFERIMENTI

- **SpatiaLite**: <https://www.gaia-gis.it/fossil/libspatialite/index>
- **SQLite**: <https://sqlite.org/index.html>
