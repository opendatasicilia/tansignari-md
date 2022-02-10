---
title: "Estrarre prima e ultima riga di un json e creare unico file CSV"
linkTitle: "Estrarre prima e ultima riga di un json"
date: 2022-02-10
description: >
  Estrarre prima e ultima riga di un json e creare unico file CSV.
tags:
  - riga di comando
  - Miller
  - CSV/TSV
  - json
issue: [197]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Ho centinaia di file `json` cosi strutturati:

```json
{
  "name": "from_base64",
  "groups": ["Conversions"],
  "type": "function",
  "description": "Decodes a string in the Base64 encoding into a binary value.",
  "arguments": [{
    "arg": "string",
    "description": "the string to decode"
  }],
  "examples": [{
    "expression": "from_base64('UUdJUw==')",
    "returns": "'QGIS'"
  }],
  "tags": ["encoding", "base", "binary", "decodes"]
}
```

vorrei estrarre la prima e ultima riga:

```
"name": "from_base64"
"tags": ["encoding", "base", "binary", "decodes"]
```
 e creare un unico file CSV cosi strutturato:

name | tags
-------|---------
from_base64| encoding, base, binary, decodes
$scale|denominator, contexts, current, scale, canvas, map
...|.....

## soluzione

con Miller 6:

```
mlr --ijsonl --ocsv cut -f name,tags  then put '$tags=joinv($tags,",")'  input.json >out.csv
```

![](https://user-images.githubusercontent.com/7631137/153368885-715fdb38-933e-4a90-996f-e044a172bd99.png)

## Riferimenti utili

- [Miller](https://github.com/johnkerl/miller)
- https://github.com/qgis/QGIS/tree/master/resources/function_help/json

