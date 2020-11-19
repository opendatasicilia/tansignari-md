---
title: "Realizzare un Outer Join tra due tabelle"
linkTitle: "Outer Join tra due tabelle"
date: 2020-05-18
description: >
  Realizzare un Outer Join tra due file TSV senza intestazione.
tags:
  - riga di comando
  - Miller
  - CSV/TSV
  - Join
issue: [165]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Realizzare un [Outer Join](https://it.wikipedia.org/wiki/Join_(SQL)) tra due file TSV senza intestazione.

In input:  primo file `uno.tsv`
```
1	a
2	a
3	b
4	a
```
secondo file `due.tsv`
```
1
4
```

Il comando per ottenere in output un altro file come Outer Join
```
mlr --tsv --implicit-csv-header join --np  --ul  -j 1 -f uno.tsv then unsparsify due.tsv | tail -n +2
```

dove:


- `--implicit-csv-header` per assegnare un header numerico ai due TSV senza header, un header implicito (1 2 ...)
- `--np --ul` per impostare un output con tutto ciò che non si accoppia in left JOIN;
- `-j 1` per usare la prima colonna dei due file, per fare JOIN.


## Riferimenti utili

- [Outer Join](https://it.wikipedia.org/wiki/Join_(SQL))
- [Miller](https://github.com/johnkerl/miller)

