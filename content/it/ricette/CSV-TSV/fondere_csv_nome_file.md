---
title: "Creare un unico file CSV e campo nome file"
linkTitle: "Creare un unico file CSV e campo nome file"
date: 2021-08-14
description: >
  Creare un unico file CSV e aggiungere un campo con il nome del file di provenienza.
tags:
  - csv/tsv
  - Miller
  - 
issue: [185]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Cartella con molti file CSV (`xxxxx.csv`) con identica struttura:

ID | nome | cognome
---|------|--------
1  |Totò  | pigreco
2  |Andy  | rossi

## comando da usare

```bash
mlr --csv put -S '$file=FILENAME' *.csv >output.csv
```

## output

ID | nome | cognome | file
---|------|---------|-----
1  |Totò  | pigreco | xxxxx
2  |Andy  | rossi   | xxxxx
3  |Tony  | gallo   | yyyyy
4  |Rosy  | roy     | yyyyy

## riferimenti

- **Miller** : <https://github.com/johnkerl/miller>

