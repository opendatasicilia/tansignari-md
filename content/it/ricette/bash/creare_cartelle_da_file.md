---
title: "Suddividere i file in cartelle"
linkTitle: "Suddividere i file in cartelle"
date: 2020-01-30
description: >
  Come suddividere gruppi di file in cartelle specifiche.
tags:
  - bash
  - CSV/TSV
  - uniq
  - sed
  - Regex
  - Script
issue: [172]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso","Totò Fiandaca"]
---

---

## Introduzione

A partire da una cartella che contiene circa [6000 file SVG](https://t.co/fe7gXfW1VH?amp=1): i nomi dei file hanno un prefisso ( es: `google`, `apple` ecc...) seguito da un trattino `-` e da una successiva descrizione (`google-translate.svg`, `google-street-view.svg`, `apple-safari.svg`, `apple-keyboard-option.svg` ecc...), come creare tante cartelle quante sono i prefissi e con stesso nome, e copiarci dentro tutti i file che hanno quel prefisso.

![](https://user-images.githubusercontent.com/7631137/103694488-53d62380-4f9b-11eb-861e-e949bce6e405.png)

![](https://user-images.githubusercontent.com/7631137/103694738-c0512280-4f9b-11eb-9c28-c949917b8c7a.png)

## Script bash

```bash
#!/bin/bash
set x

# lista i file *.svg, estrae il prefisso, prendi i valori univoci e crea file 
ls *.svg | sed -E 's/^(\w+).+$/\1/g' | uniq >prefisso.csv

# cicla per creare le cartelle e copiare i file
for i in $(cat prefisso.csv);do
	mkdir -p $i
	cp $i*.svg ./$i
done
```

Note:

- in `sed` l'opzione `-E` è obbligatoria per usare regex complessi, per i gruppi
- in `sed`, `\1` richiama il primo gruppo


## Riferimenti

- [**Impara X in Y minuti**](https://learnxinyminutes.com/docs/it-it/bash-it/)
- [**bash**](https://it.wikipedia.org/wiki/Bash)
- [**sed**](https://www.gnu.org/software/sed/manual/sed.html)
- [**Uniq**](https://www.geeksforgeeks.org/uniq-command-in-linux-with-examples/)
- [**dati**](https://t.co/fe7gXfW1VH?amp=1)

