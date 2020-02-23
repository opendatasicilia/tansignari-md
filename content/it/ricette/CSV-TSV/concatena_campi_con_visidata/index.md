---
title: "Concatenare campi con Visidata"
linkTitle: "Concatenare campi con Visidata"
date: 2020-02-23
description: >
  Concatenare campi usando un separatore diverso dal _tab_.
tags:
- Visidata
- csv
- tsv
- csv-tsv
- bash
- python
issue: [128]
autori: ["Totò Fiandaca"]
chefs: ["Andrea Borruso"]
---

---

## Introduzione

Alcune volte è utile concatenare più campi in modo da crearne uno. Questa operazione è molto semplice e rapida da realizzarsi con **Visidata** in due modi diversi; il primo utilizzando il _foglio delle colonne_, il secondo usando le _espressioni Python_. Di seguito vedemo entrambi i modi.

## Foglio delle colonne

Per visualizzare con **Visidata** un file csv basta avviare la **bash** di linux e:

`vd nomefile.csv`

subito dopo digitare:

`shift+c`

che visualizzarea una tabella dove le righe rappresentano le colonne del file csv;

selezionare, usando il tasto `s` le righe da concatenare e digitare `&`

![](./concatenare.gif)

## Espressioni Python

Visualizzo il file con:

`vd nomefile.csv`

![](./concatenare2.gif)

l'espressione python usata è:

```
tag_0 + ';' + tag_1 + ';' + tag_2 + ';' + tag_3
```

dove è possibile scegliere il separatore, in questo caso `;`

## Riferimenti utili

1. [Visidata](http://visidata.org/man/)
2. [Guida Visidata ITA](https://github.com/ondata/guidaVisiData/blob/master/testo/README.md)