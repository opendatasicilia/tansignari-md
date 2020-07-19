---
title: "Come aggiungere un carattere ogni n caratteri"
linkTitle: "Come aggiungere un carattere ogni n caratteri"
date: 2020-01-30
description: >
  Come aggiungere un carattere ogni n caratteri in un testo molto lungo.
tags:
  - bash
  - CSV
  - fold
  - Miller
  - Perl
  - Regex
  - Script
issue: [139]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Introduzione

Ho un CSV con un campo popolato da testo abbastanza lungo e ho la necessità di aggiungere, per ogni riga, un carattere ogni N caratteri, l'ideale sarebbe introdurre il carattere in corrispondenza del primo spazio utile dopo gli N caratteri: una sosrta di `word wrap`.

esempio file di input `text.txt`

fid|DESCRIZIONE
---|----
1|"Calcari mal stratificati o massicci (rudstone e floatstone),grossolanamente bioclastici. Subordinatamente contengono orizzonti di calcari micritici a tessitura mudstone e wackestone e calcari oolitici; anche in questa litofacies sono frequenti i veli irregolari calcareo-marnosi di colore giallastro o verdastro."
2|"Calcari mal stratificati o massicci (rudstone e floatstone),grossolanamente bioclastici. Subordinatamente contengono orizzonti di calcari micritici a tessitura mudstone e wackestone e calcari oolitici; anche in questa litofacies sono frequenti i veli irregolari calcareo-marnosi di colore giallastro o verdastro."
3|"Calcari mal stratificati o massicci (rudstone e floatstone),grossolanamente bioclastici. Subordinatamente contengono orizzonti di calcari micritici a tessitura mudstone e wackestone e calcari oolitici; anche in questa litofacies sono frequenti i veli irregolari calcareo-marnosi di colore giallastro o verdastro."

### script

```bash
#!/bin/bash

set -x

mlr --csv cut -f DESCRIZIONE test.txt | fold -sw 50 | mlr --csv cat -n | perl -pe 's/\r\n/~/g;s/\n/*/g;s/~/\r\n/g' >testww.txt
```

dove:

 - `mlr --csv cut -f DESCRIZIONE test.txt`  estrae la colonna `DESCRIZIONE`;
 - `fold -sw 50` fa il **wordwrap** per ogni 50 caratteri;
 - `mlr --csv cat -n` stampa a video e aggiunge un contatore simile al `fid` del CSV di input;
 - `perl -pe 's/\r\n/~/g;s/\n/*/g;s/~/\r\n/g'` cerca gli `a capo` (\n) e sostituisce il carattere speciale `*`
 - `>testww.txt` salva tutto nel file.

file di output `textww.txt`

n|DESCRIZIONE
---|---
1|"Calcari mal stratificati o massicci (rudstone e *floatstone), grossolanamente bioclastici. *Subordinatamente contengono orizzonti di calcari *micritici a tessitura mudstone e wackestone e *calcari oolitici; anche in questa litofacies sono *frequenti i veli irregolari calcareo-marnosi di *colore giallastro o verdastro."
2|"Calcari mal stratificati o massicci (rudstone e *floatstone), grossolanamente bioclastici. *Subordinatamente contengono orizzonti di calcari *micritici a tessitura mudstone e wackestone e *calcari oolitici; anche in questa litofacies sono *frequenti i veli irregolari calcareo-marnosi di *colore giallastro o verdastro."
3|"Calcari mal stratificati o massicci (rudstone e *floatstone), grossolanamente bioclastici. *Subordinatamente contengono orizzonti di calcari *micritici a tessitura mudstone e wackestone e *calcari oolitici; anche in questa litofacies sono *frequenti i veli irregolari calcareo-marnosi di *colore giallastro o verdastro."

## Riferimenti

- [**Impara X in Y minuti**](https://learnxinyminutes.com/docs/it-it/bash-it/)
- [**bash**](https://it.wikipedia.org/wiki/Bash)
- [**Miller**](https://github.com/johnkerl/miller)
- [**Fold**](https://en.wikipedia.org/wiki/Fold_(Unix))

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- [**Blog post su Pigrecoinfinito**](https://pigrecoinfinito.com/2020/04/09/qgis-e-la-legenda-lunga-delle-carte-geologiche/)
