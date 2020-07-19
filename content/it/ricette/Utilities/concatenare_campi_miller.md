---
title: "Concatenare campi con Miller"
linkTitle: "Concatenare campi con Miller"
date: 2020-05-06
description: >
  Come concatenare campi usando la riga di comando e Miller.
tags:
  - bash
  - Miller
  - csv
issue: [144]
autori: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Dato un file CSV con molti campi, concatenare (field1+field2+filed3 ...) alcuni campi in modo da ottenere un unico campo e snellire il file stesso.

file di _**input.txt**_

| id  | field1 | filed2 | tag:0 |
| --- | ------ | ------ | ----- |
| 1   | A      | B      | C     |
| 2   | a      | b      | c     |

usando **Miller** e il verbo [put](http://johnkerl.org/miller/doc/reference-verbs.html#put):

```
mlr --csv put -S '$nuovoCampo=$field1."-".$field1."-".${tag:0}' input.txt >output.csv
```

- S per trattare i campi come campi di testo;
- . è il classico operatore per concatenare;
- i nomi di campo sono tra graffe, perché qui contengono caratteri speciali (i :)

output:

| id  | field1 | filed2 | tag:0 | nuovoCampo |
| --- | ------ | ------ | ----- | ---------- |
| 1   | A      | B      | C     | A-B-C      |
| 2   | a      | b      | c     | a-b-c      |

per eliminare i campi non più utili, usare il verbo [cut](http://johnkerl.org/miller/doc/reference-verbs.html#cut):

```
mlr --csv cut -f field1,filed2,tag:0 output.csv >output2.csv
```

## Riferimenti utili

- [**Miller**](http://johnkerl.org/miller/doc/reference.html)
- [**bash**](https://it.wikipedia.org/wiki/Bash)

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- **Changelog 3.14** : <https://github.com/pigreco/changelog314>
