---
title: "Come spostare file da molte cartelle a una sola"
linkTitle: "Come spostare file da molte cartelle"
date: 2021-01-25
description: >
  Come spostare file da molte cartelle in una unica cartella di output usando regex.
tags:
  - bash
  - CSV
  - Regex
  - fd
issue: [175]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Introduzione

Alcune volte nasce l'esigenza di spostare o copiare molti file da cartelle diverse verso una unica cartella di destinazione, la ricerca dei file è realizzata usando regex.

il seguente comando risolve il problema:

```
fd "^.+([A-Z]+[0-9]+|[A-Z])-particelle.csv$" -x cp {} ./out
```

dove:
- `fd` comando per la ricerca file, simile a [find](https://www.gnu.org/software/findutils/)
- `^.+([A-Z]+[0-9]+|[A-Z])-particelle.csv$` regex per la ricerca dei file;
- `-x` esegue comandi in parallelo per ogni risultato della ricerca;
- `cp` copia;
- `{}` percorso completo;


## Riferimenti

- [**Impara X in Y minuti**](https://learnxinyminutes.com/docs/it-it/bash-it/)
- [**bash**](https://it.wikipedia.org/wiki/Bash)
- [**fd**](https://github.com/sharkdp/fd)
