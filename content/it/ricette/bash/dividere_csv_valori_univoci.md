---
title: "Dividere un CSV con valori univoci"
linkTitle: "Dividere un CSV con valori univoci di un suo campo"
date: 2020-12-15
description: >
  Dividere un file CSV utilizzando i valori univoci di un suo campo.
tags:
  - bash
  - csv/tsv
  - miller
  - script
issue: [170]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

[Il SOle 24 Ore](https://github.com/IlSole24ORE/QDV) mette a disposizone un CSV con i dati sulla **Qualità della Vita 2020**, è un file CSV unico dove il campo **INDICATORE** contiene il `Nome sintetico del fenomeno`; sono 90 i fenomeni osservati nelle 107 Province italiane, quindi il file CSV ha 9630 righe (107x90). Vediamo come ottenere 90 file CSV, uno per ogni fenomeno osservato.

### Soluzione con Miller

```
mlr --csv put '$INDICATORE=gsub($INDICATORE,"/","-")' input.csv | mlr  --csv  put -q 'tee > $INDICATORE.".csv", $*'
```

Note:

- prima rimuovo da `INDICATORE` il carattere `/` e lo sostituisco con `-`;
- poi sfrutto il verbo [tee](https://miller.readthedocs.io/en/latest/reference-verbs.html#tee) di Miller, che creerà dei file di output filtrando su valori di `INDICATORE` distinti.

in output i 90 file con nome file uguale al fenomeno osservato:

![](https://user-images.githubusercontent.com/7631137/102192919-b1ef7980-3ebb-11eb-8af6-8f88630555dc.png)

## Riferimenti utili

- [Repository Il SOle 24 ORE](https://github.com/IlSole24ORE/QDV)
- [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)