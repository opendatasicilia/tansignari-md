---
title: "Come trattare le interruzioni di riga in file CSV"
linkTitle: "trattare le interruzioni di riga in file CSV"
date: 2022-02-21
description: >
  Rimuovere fastidiosi ritorni a capo di un file CSV
tags:
  - csv
  - tsv
  - csv-tsv
  - miller
  - riga di comando
issue: [202]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

Quando si lavora con file `CSV` (magari convertiti da altri formati e.g. `xlsx`) non è difficile imbattersi in "problemi" di questo tipo

```
Titolo,Autore
"Divina
Commedia","Dante
Alighieri"
"Il fu
Mattia Pascal","Luigi 
Pirandello"
```

in cui i contenuti di quelle che in un foglio di calcolo sarebbero delle _celle_ presentano dei fastidiosi ritorni a capo.

Per ottenere in output un file come:

```
Titolo,Autore
Divina Commedia,Dante Alighieri
Il fu Mattia Pascal,Luigi Pirandello
```

è possibile utilizzare la utility _miller_  lanciando `mlr --csv -S put 'for (k in $*) {$[k] = gsub($[k], "\n", " ")}' then clean-whitespace file.csv`. Questo  comando è in grado di cercare il carattere speciale `\n` _newline_
e di sostituirlo con " ". In seguito `clean-whitespace` rimuoverà eventuali doppi spazi.

## Riferimenti

- **Miller** : <https://github.com/johnkerl/miller>
