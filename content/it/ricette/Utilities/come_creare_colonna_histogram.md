---
title: "Come creare la colonna histogram"
linkTitle: "Come creare la colonna histogram"
date: 2020-05-11
description: >
  Come creare la colonna histogram in un CSV/TSV usando Miller.
tags:
  - bash
  - Miller
  - csv/tsv
issue: [148]
autori: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Dato un file CSV/TSV con un campo `count` (che rappresenta il numero delle volte in cui è presente il valore in `tags`), creare un campo `histogram` popolato con `*` che simuli un Istogramma dei valori `count`.

file di _**input.txt**_

| tags                  | count | percent |
| --------------------- | ----- | ------- |
| -                     | 34    | 28.81   |
| Processing            | 28    | 23.73   |
| Print Layouts         | 15    | 12.71   |
| Expressions           | 10    | 8.47    |
| Mesh                  | 5     | 4.24    |
| Forms                 | 3     | 2.54    |

usando **Miller** e il verbo [bar](http://johnkerl.org/miller/doc/reference-verbs.html#bar):

```
mlr --t2p --barred bar --auto -f count input.txt
```

- `barred` per avere un output ben sistemato come sotto;


output:

```
+-----------------------+-------------------------------------------------+---------+
| tags                  | count                                           | percent |
+-----------------------+-------------------------------------------------+---------+
| -                     | [1]***************************************#[34] | 28.81   |
| Processing            | [1]********************************........[34] | 23.73   |
| Print Layouts         | [1]****************........................[34] | 12.71   |
| Expressions           | [1]**********..............................[34] | 8.47    |
| Mesh                  | [1]****....................................[34] | 4.24    |
| Forms                 | [1]**......................................[34] | 2.54    |
+-----------------------+-------------------------------------------------+---------+
```

per non visualizzare i puntini e il cancelletto, usare:

```
mlr --t2p --barred bar --auto  -b " " -x " " -f count input.txt
```

ottenendo:

```
+---------------+-------------------------------------------------+---------+
| Value         | count                                           | percent |
+---------------+-------------------------------------------------+---------+
| -             | [1]*************************************** [34] | 28.81   |
| Processing    | [1]********************************        [34] | 23.73   |
| Print Layouts | [1]****************                        [34] | 12.71   |
| Expressions   | [1]**********                              [34] | 8.47    |
| Mesh          | [1]*******                                 [34] | 4.24    |
| Forms         | [1]***                                     [34] | 2.54    |
+---------------+-------------------------------------------------+---------+
```

per eliminare le parentesi quadre e il valore interno, e duplicare il campo `count`:

```
mlr --t2p --barred put '$histo=$count'  \
then bar -x " " -b " " --auto -f histo  \
then cut -x -f histogram \
then put '$histo=gsub($histo,"[^*]","")' input.txt
```

```
+---------------+-------+---------+-----------------------------------------+
| Value         | count | percent | histogram                               |
+---------------+-------+---------+-----------------------------------------+
| -             | 34    | 28.81   | *************************************** |
| Processing    | 28    | 23.73   | ********************************        |
| Print Layouts | 15    | 12.71   | ****************                        |
| Expressions   | 10    | 8.47    | **********                              |
| Mesh          | 7     | 5.93    | *******                                 |
| API           | 4     | 3.39    | ***                                     |
| Forms         | 4     | 3.39    | ***                                     |
+---------------+-------+---------+-----------------------------------------+
```

## Riferimenti utili

- [**Miller**](http://johnkerl.org/miller/doc/reference.html)
- [**bash**](https://it.wikipedia.org/wiki/Bash)

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- **Changelog 3.14** : <https://github.com/pigreco/changelog314>
