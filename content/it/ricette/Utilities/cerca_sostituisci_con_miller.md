---
title: "Trova e sostituisci con Miller"
linkTitle: "Trova e sostituisci con Miller"
date: 2020-05-06
description: >
  Trova e sostituisci usando la riga di comando e Miller.
tags:
  - bash
  - Miller
  - csv
  - regex
issue: [146]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

I file CSV hanno spesso la necessita di essere ripuliti da errori, ripetizioni, caratteri speciali ecc.., in questa ricetta vedremo come travare e sostituire il testo per migliorare il nostro csv:

file di _**input.txt**_

| id  | field1 | filed2 |
| --- | ------ | ------ |
| 1   | A;     | B      |
| 2   | a      | b-k    |

usando **Miller**, il verbo [put](http://johnkerl.org/miller/doc/reference-verbs.html#put) e la fuzione [gsub](http://johnkerl.org/miller/doc/reference-dsl.html#gsub), che fa un trova e sostituisci globale usando regex in standard posix.2

```
mlr --csv put '$field1=gsub($field1,";","");$filed2=gsub($filed2,"-k","")' input.txt >output.csv
```

output:

| id  | field1 | filed2 |
| --- | ------ | ------ |
| 1   | A      | B      |
| 2   | a      | b      |


## Riferimenti utili

- [**Miller**](http://johnkerl.org/miller/doc/reference.html)
- [**bash**](https://it.wikipedia.org/wiki/Bash)

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- **Changelog 3.14** : <https://github.com/pigreco/changelog314>
