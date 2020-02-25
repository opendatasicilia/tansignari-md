---
title: "Riferimento a gruppi, caratteri speciali"
linkTitle: "Riferimento a gruppi, caratteri speciali"
date: 2020-02-25
description: >
 Caratteri speciali usati per fare riferimento ai gruppi in un **regex**.
tags:
  - regex
  - python
  - visidata
issue: [129]
autori: ["Totò Fiandaca"]
chefs: ["Andrea Borruso"]
---

---

## Introduzione

Le espressioni regolari si trovano in molti ambienti e software diversi, vediamo quanti modi esistono per fare il trova e sostituisci tramite l'uso dei gruppi, ovvero l'uso delle parentesi tonde.

**Caso d'uso**:

Supponiamo di avere un campo, di un file CSV, popolato con

```
/qgis/QGIS/pull/53256
```

dove varia solo il numero finale.

Per ottenere questo:

```
[53256](https://github.com/qgis/QGIS/pull/53256)
```

ho usato, in **Visidata**, questa stringa regex:

```
(.+\/)(.+)/[$2](https://github.com/qgis/QGIS/pull/$2)
```
ma non funziona perché sto usando il carattere generico `$`. Visidata è scritto in Python e quindi occorre usare il carattere  speciale `\` e quindi:

```
(.+\/)(.+)/[\2](https://github.com/qgis/QGIS/pull/\2)
```
![](https://camo.githubusercontent.com/dcbddd1840231415c5bc60e532df02fb42d3b141/68747470733a2f2f692e696d6775722e636f6d2f494f4d306e334d2e676966)
## Riassumendo

- `$` generico
- `\` python

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- [Blog Post](https://pigrecoinfinito.com/2020/02/25/qgis-e-i-changelog-3-12-scraping-da-repo-github/) su Pigrecoinfinito by Totò Fiandaca
---

## Riferimenti utili

1. [Visidata](http://visidata.org/man/)
2. [Regex101](https://regex101.com/r/V0N1Oh/4)
