---
title: "Sanity check di un file CSV"
linkTitle: "Sanity check di un file CSV"
date: 2023-05-27
description: >
    Come effettuare un sanity check di un file CSV usando miller
tags:
  - csv
  - miller
  - standard
issue: [255]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

## Introduzione

A volte, quando si lavora con dei CSV, torna utile sapere se questi file **rispettano** le specifiche [`RFC 4180`](https://datatracker.ietf.org/doc/html/rfc4180) che definiscono lo **standard**.

Se hai installato [`miller`](https://miller.readthedocs.io/en/6.7.0/) e vuoi indagare la **conformità** allo standard di un CSV (denominato, ad esempio, `file.csv`) puoi semplicemente lanciare da riga di comando

```shell
mlr --csv check file.csv
```

Nel caso in cui il check fallisce, non è raro osservare messaggi di errore di questo tipo

```shell
mlr: CSV header/data length mismatch 4 != 1 at filename test.csv row 2.
```

Tuttavia capita di avere tra le mani un CSV non standard (non rispetta `RFC 4180`) che risulta comunque interpretabile come tale. Per lanciare un sanity check allora useremo il comando precedente sostituendo l'opzione `--csv` con `--csvlite`, come in questo esempio:

```shell
mlr --csvlite check file.csv
```

Se il file è sano, non otterremo nessun messaggio.

## Use case

Sia `file.csv` così fatto

```
id,command,duration,description
1,./launcher "./spawner ec 800000 885000 800000 5 0 best_individual" 25 100000 20 0.2 0.8 stats.csv,,lorem ipsum
2,./launcher "./spawner ec 1200000 1200000 1100000 8 0 best_individual" 25 10000 25 0.25 0.75 stats.csv,,lorem ipsum
3,./launcher "./spawner ec 1100000 1100000 1000000 8 0 best_individual" 25 10000 1 0.25 0.75 stats.csv,,lorem ipsum
4,./launcher "./spawner ec 8800 20000 20000 100 0 best_individual" 25 10000 1 0.25 0.75 stats.csv,,lorem ipsum
5,../../bin/launcher "../../bin/spawner ../../bin/ec 600000 100000 400000 20 0 best_individual" 5 10 10 0.25 0.75 stats.csv,,
6,../../bin/launcher "../../bin/spawner ../../bin/ec 50000 7000 9000 80 0 best_individual" 5 10 10 0.25 0.75 stats,,test
```

Lanciando 

```shell
mlr --csv check file.csv
```

si ottiene

```
mlr: CSV header/data length mismatch 4 != 1 at filename test.csv row 2.
```

il che vuol dire che `file.csv` **non** rispetta lo standard `RFC 4180`.

Questo file è comunque interpretabile come un CSV? Scopriamolo lanciando

```shell
mlr --csvlite check file.csv
```

Non otteniamo nessun errore. Possiamo continuare a lavorarci essendo consapevoli di questo dettaglio ;)

## Riferimenti
- [RFC 4180](https://datatracker.ietf.org/doc/html/rfc4180)
- [`miller`](https://miller.readthedocs.io/en/6.7.0/)
- [Formati file supportati da Miller](https://miller.readthedocs.io/en/6.7.0/file-formats/#csvtsvasvusvetc:~:text=Miller%27s%20%2D%2Dcsv%20flag%20supports%20RFC%2D4180%20CSV.)
