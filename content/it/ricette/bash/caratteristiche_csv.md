---
title: "Caratteristiche di un CSV"
linkTitle: "Caratteristiche di un CSV"
date: 2020-12-18
description: >
  Come conoscere rapidamente le caratteristiche di un CSV.
  - bash
  - csv/tsv
  - script
issue: [201]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Alcune volte nasce l'esigenza di conoscere rapidamente, e senza dovere necessariamente aprire l'intero file, le caratteristiche di un file CSV, come il numero di righe, il numero di campi oppure ispezionare solo le prime o ultine 10 righe; questo è tanto più utile quanto più è grande il file. Immaginate un file csv con milioni di righe e decine di campi. 

## Soluzioni

### heat/tail

per visualizzare le prime o ultime 10 righe usando la bash di linux

```
<calabria.txt head
```

```
<calabria.txt tail
```

![](https://user-images.githubusercontent.com/7631137/154495722-e24749d3-b384-440f-b678-6eb6b8320e87.png)

### miller

per conoscere il numero di righe e colonne usando Miller

```
mlr --c2p --barred --ifs ";" tail -n 1 then put '$righe=NR;$colonne=NF-1' then cut -f righe,colonne Calabria.txt
```

output:

```
+---------+---------+
| righe   | colonne |
+---------+---------+
| 2985700 | 5       |
+---------+---------+
```

### Riferimenti utili

- [**Impara X in Y minuti**](https://learnxinyminutes.com/docs/it-it/bash-it/)
- [**bash**](https://it.wikipedia.org/wiki/Bash)
- [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)

### Approfondimenti

- [a riga di comando](https://arigadicomando.it/dati/esplora/) by [onData](https://www.getrevue.co/profile/ondata)