---
title: "Trova e sostituisci parole di un campo specifico"
linkTitle: "Trova sostituisci campo specifico"
date: 2022-02-22
description: >
  Come sostituire le parole di un campo specifico di un file CSV
tags:
  - csv
  - tsv
  - csv-tsv
  - miller
  - riga di comando
issue: [204]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

Immaginiamo di avere un file CSV e di voler operare una sostituzione che interessi **solo** un campo. 

| Titolo              | Autore           |
|---------------------|------------------|
| Divini Commedia     | Dante Alighieri  |
| Il fu Mattia Pascal | Luigi Pirandello |
| Random Title        | Giacomo Divini   |

Potremmo, ad esempio, voler sostituire la parola `Divini` con la parola `Divina` presente nel campo `Titolo` senza intaccare le occorrenze presenti nel campo `Autore` (in cui è presente un autore il cui cognome è `Divini`).

```
Titolo,Autore
Divini Commedia,Dante Alighieri
Il fu Mattia Pascal,Luigi Pirandello
Random title, Giacomo Divini
```

È possibile utilizzare la utility _miller_  e lanciare 

```bash
mlr --csv put '$Titolo=sub($Titolo,"Divini","Divina")' file.csv
```

per ottenere

| Titolo              | Autore           |
|---------------------|------------------|
| Divina Commedia     | Dante Alighieri  |
| Il fu Mattia Pascal | Luigi Pirandello |
| Random Title        | Giacomo Divini   |

rawfile:

```
Titolo,Autore
Divina Commedia,Dante Alighieri
Il fu Mattia Pascal,Luigi Pirandello
Random title, Giacomo Divini
```

Il comando sopra riportato restituisce in output un file CSV con le modifiche richieste. La funzione invocata è `sub` che richiede tre argomenti separati da una virgola: il nome del campo, la stringa da cercare, la stringa desiderata. Si noti che:

- `sub` è in grado di sostituire solo la prima occorrenza di una cella; se si desidera modificare tutte le occorrenze di una cella, si deve utilizzare la funzione `gsub`;
- se il nome del campo è costituito da più parole separate da uno spazio è necessario utilizzare la sintassi con le paretesi graffe `${nome campo}`.

Per maggiori informazioni si visiti [arigadicomando - Fare un trova e sostituisci per campo](https://arigadicomando.it/miller/ricette/#fare-un-trova-e-sostituisci-per-campo)

## Riferimenti

- **Miller** : <https://github.com/johnkerl/miller>
