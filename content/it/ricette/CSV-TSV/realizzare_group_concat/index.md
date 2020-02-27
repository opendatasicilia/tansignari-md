---
title: "Come realizzare un Group concat"
linkTitle: "Come realizzare un Group concat"
date: 2020-02-23
description: >
  Data una colonna (tags) che contiene più volte lo stesso valore, raggruppare per questa e concatenare i valori di un'altra (pr).
tags:
- Miller
- csv
- tsv
- csv-tsv
- bash
issue: [131]
autori: ["Totò Fiandaca"]
chefs: ["Andrea Borruso"]
---

---

## Introduzione

La funzione `group_concat` è molto usata nei database, è una funzione di aggregazione che consente di concatenare, in un’unica stringa, un gruppo di valori che normalmente si trovano su record differenti.

## Soluzione con Miller

```
mlr --csv cut -f tags,pr then nest --implode --values --across-records -f pr cha312_tags.csv >out.csv
```

dove:

- `cut -f tags,pr` per estrarre i due campi;
- `nest --implode --values --across-records -f pr` per implodere i valori, attraverso le righe della colonna `pr`.

![](./img1.jpg)

## Riferimenti utili

- [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)