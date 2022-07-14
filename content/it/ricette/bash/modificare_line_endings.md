---
title: "Modificare line endings (EOL)'"
linkTitle: "Modificare line endings'"
date: 2022-07-14
description: >
  Come modificare i caratteri di fine riga (EOL or line endings) di un file
tags:
  - csv
  - riga di comando
  - bash
  - eol
issue: [215]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

A volte, quando si creano file a partire da [script `bash`](https://tansignari.opendatasicilia.it/ricette/bash/), può capitare di osservare strani simboli nel nome dei file di output
![image](https://user-images.githubusercontent.com/77018886/178977928-8fca30d2-a990-4d63-8df0-31df45b4dbef.png)

Questo è dovuto al differente modo in cui i sistemi operativi gestiscono i caratteri di fine riga o _line endings_ (CR vs LF) e si può facilmente ovviare al problema agendo da [CLI](https://tansignari.opendatasicilia.it/ricette/riga_comando/) o dall'editor con il quale lavoriamo.

### CLI
Se si vogliono modificare i caratteri di fine riga da [riga di comando](https://tansignari.opendatasicilia.it/ricette/riga_comando/) sarà necessario utilizzare [`dos2unix`](https://manned.org/dos2unix). Ad esempio, per modificare i _line endings_ e renderli compatibili con linux sarà sufficiente lanciare 

```bash
dos2unix filename
```

### Editor
Praticamente tutti gli editor ti consentono di modificare i caratteri in questione. Se usi [Visual Studio Code](https://code.visualstudio.com/), ad esempio, basterà fare click su `LF` o `CRLF` dalla barra in basso a destra.

## Riferimenti

- **dos2unix** : <https://manned.org/dos2unix>
- **Visual Studio Code** : <https://code.visualstudio.com/>
