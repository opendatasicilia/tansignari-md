---
title: "Acchiappare il primo carattere, presente più volte, in una stringa"
linkTitle: "Acchiappare il primo carattere, presente più volte, in una stringa"
date: 2022-10-20
description: >
 Acchiappare il primo carattere, ripetuto più volte all'interno di una stringa.
tags:
  - regex
  - Greedy
  - Lazy
issue: [231]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Alcune volte nasce l'esigenza di selezionare una porzione di testo in corrispondenza della prima occorrenza di un carattere che si presenta più volte all'interno della stringa stessa; esempio:

```
PR.CS|12|CS
PR.CS|1|CrS
PR.CS|35|Ce
```
come ottenere il risultato di sotto?
```
PR.CS12|CS
PR.CS1|CrS
PR.CS35|Ce
```
ovvero, individuare ed eliminare il primo `|` di ogni stringa.

## Soluzioni

### principiante

```
(.+)(\|)(.+)(\|)(.+)
```
dove si suddivide, l'intera stringa, in gruppi.

link regex101: <https://regex101.com/r/bJHx2s/1>

### esperto

```
^(.+?)(\|)(.+)$
```

dove si utilizza il concetto di regex `lazy` e/o `greedy` : <https://stackoverflow.com/a/2301298/757714>; nel caso in esame:

```
^(.+?)(\|)
```
individua la porzione di testo prima del carattere `|` e

```
(.+)$
```
individua la porzione di testo dopo il carattere `|` 

per il trova e sostituisci basta scrivere:`$1$3` che è la concatenazione del primo e terzo gruppo, tralasciando il secondo gruppo che contiene, appunto, il primo `|`.

## Siti utili

- **regex101**, per testare espressioni regolari e imparare a usarle [https://regex101.com/](https://regex101.com/)
