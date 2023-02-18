---
title: "Validare formalmente un datapackage di frictionless"
linkTitle: "validare struttura datapackage frictionless"
date: 2022-05-19
description: >
  Come validare la struttura formale di un datapackage costruito secondo gli standard di frictionless data
tags:
  - frictionless
  - jq
  - json
issue: [250]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

## Introduzione
Gli standard di [frictionless data](https://specs.frictionlessdata.io/) permettono di generare un dapackage che descriva i dati di un dataset. È possibile validare i dati (secondo quanto definito nel datapckage) lanciando da terminale

```bash
frictionless validate datapackage.yaml --json
```

In questo modo frictionless validerà i file descritti nel datapackage solo se la struttura di quest'ultimo è valida, ovvero se non sono presenti errori di tipo [`package-error`](https://framework.frictionlessdata.io/docs/errors/metadata.html#package-error).

## Use case
Se si vuole validare solo la struttura del dapackage è possibile lanciare il comando sopra indicato e verificare che venga effettuata la validazione dei dati. 

Infatti, se il dapackage è valido (al netto della validità dei dati), otterremo in output una cosa del genere
```json
{
  "valid": false,
  "stats": {
    "tasks": 4,
    "warnings": 0,
    "errors": 3,
    "seconds": 0.022
  },
  "warnings": [],
  "errors": [],
  "tasks": [
    {
      "valid": false,
      "name": "contenuti",
      "type": "table",
      "place": "data/contenuti.csv",
      "labels": [],
      "stats": {
        "warnings": 0,
        "errors": 1,
        "seconds": 0.003
      }
    }
  ]
}
```

Se il datapackage non è valido, otterremo
```json
{
  "valid": false,
  "stats": {
    "tasks": 0,
    "warnings": 0,
    "errors": 1,
    "seconds": 0.075
  },
  "warnings": [],
  "errors": [
    {
      "type": "package-error",
      "title": "Package Error",
      "description": "A validation cannot be processed.",
      "message": "The data package has an error: cannot retrieve metadata \"datapackage.yaml\" because \"mapping values are not allowed here\n  in \"<file>\", line 156, column 9\"",
      "tags": [],
      "note": "cannot retrieve metadata \"datapackage.yaml\" because \"mapping values are not allowed here\n  in \"<file>\", line 156, column 9\""
    }
  ],
  "tasks": []
}
```

La differenza tra i due output sta nell'array `tasks`:
- nel primo caso (datapackage valido) l'array **non** è vuoto;
- nel secondo caso (datapackage non valido) l'array è vuoto.

Esiste una utility che permette di processare file json e che può aiutarci a comprendere quando un array è vuoto o meno: `jq`. Basterà infatti redirigere l'output della validazione di frictionless in jq lanciando

```bash
frictionless validate datapackage.yaml --pick-errors "package-error" --json | jq '.tasks | has(0)'
```
Se in output otteniamo:
- `false` allora l'array è vuoto e quindi il datapackage non è valido;
- `true` allora l'array non è vuoto e quindi il datapackage è valido.

### Osservazione
L'espressione di `jq` che consente di verificare l'esistenza di elementi all'interno di un array è `has(0)`.

## Riferimenti 
- [Standard di Frictionless Data](https://specs.frictionlessdata.io/)
- [jq](https://stedolan.github.io/jq/)
