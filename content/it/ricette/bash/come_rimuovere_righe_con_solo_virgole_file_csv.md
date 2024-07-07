---
title: "Eliminare righe con sole virgole in file csv"
linkTitle: "Eliminare righe sole virgole csv"
date: 2024-07-04
description: >
  Eliminare da un file CSV le righe che contengono solo le virgole separatori di campi senza eliminare le virgole che separano i campi
tags:
  - csv
  - miller
issue: [261]
chefs: ["Paolo Mauri"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

In un file CSV sono presenti delle linee che non hanno dei dati contenuti ma che mantengono le virgole come separatori di campi:

```
2008,M,EH,F70,/,Si,9
2008,M,EH,F90,F81.3F93.2,Si,9
,,,,,,
2007,F,EH,R41.8,F90.0F81.9G40.3,Si,9
,,,,,,
2006,M,EH,F91,F80.9,Si,18
2006,M,EH,F81.9,Q25Q36 R41.8,Si,9
,,,,,,
,,,,,,
2005,M,EH,F43.25,F90.1,Si,9
,,,,,,
,,,,,,
,,,,,,
```

Per eliminare queste righe che sono senza dati ma con le virgole, si può usare [Miller](https://miller.readthedocs.io/en/6.12.0/installing-miller/) con questo comando:

```
mlr --csv -N skip-trivial-records input.csv >output.csv
```

Applicandolo all'esempio indicato sopra si ottiene

```
2008,M,EH,F70,/,Si,9
2008,M,EH,F90,F81.3F93.2,Si,9
2007,F,EH,R41.8,F90.0F81.9G40.3,Si,9
2006,M,EH,F91,F80.9,Si,18
2006,M,EH,F81.9,Q25Q36 R41.8,Si,9
2005,M,EH,F43.25,F90.1,Si,9
```
### Spiegazione del comando

* ```-N``` indica che il CSV non ha intestazioni
* ```--csv``` fissa formato di input e output
* ```skip-trivial-records``` rimuove le righe vuote

### Riferimenti utili

- [Miller](https://miller.readthedocs.io/en/latest/reference-verbs/#skip-trivial-records)
