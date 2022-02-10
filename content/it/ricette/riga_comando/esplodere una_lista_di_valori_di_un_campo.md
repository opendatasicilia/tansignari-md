---
title: "Esplodere una lista di valori di un campo, e poi raggruppare per questi valori"
linkTitle: "Esplodere una lista di valori di un campo, e poi raggruppare per questi valori"
date: 2022-02-10
description: >
  Come esplodere una lista di valori di un campo, e poi raggruppare per questi valori.
tags:
  - riga di comando
  - Miller
  - CSV/TSV
issue: [198]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Per ogni espressione ci sono vari `tag`, ma più espressioni possono avere lo stesso `tag`, esempio:

| expression    | tag                 |
|---------------|---------------------|
| $vertex_y     | current, coordinate |
| $vertex_index | current             |
| $vertex_x     | current, coordinate |

con Miller, come posso creare un CSV, a partire dall'esempio di sopra, con due colonne: `tags` e `expressions`: dove in tags c'è, appunto, il tag e nella colonna expressions tutte le espressioni che usano quel tag:

| tags       | expressions                 |
|------------|-----------------------------|
| current    | $vertex_y,$vertex_index,... |
| coordinate | $vertex_x,$vertex_y,...     |
| ...        | ...                         |

## soluzione

con Miller:

```
mlr --csv nest  --evar "," -f tags then nest --ivar "," -f name  tags_expressions.csv >out.csv
```

## Riferimenti utili

- [Miller](https://github.com/johnkerl/miller)
- https://github.com/qgis/QGIS/tree/master/resources/function_help/json

