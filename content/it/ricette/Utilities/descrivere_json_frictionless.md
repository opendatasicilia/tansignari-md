---
title: "Come descrivere un .json con frictionless"
linkTitle: "Descrivere json con fricionless"
date: 2023-02-08
description: >
  Con frictionless è possibile descrivere anche un file json; farlo non è immediato come per un csv. 
tags:
  - json
  - frictionless
  - validation
issue: [224]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

Se hai un file `data.csv` che vuoi metadatare, puoi installare l'utility [frictionless](https://framework.frictionlessdata.io/) lanciando da terminale

```bash
pip install frictionless
```

per poi dare

```bash
frictionless describe data.csv
```

In output otterrai un file `yaml` che puoi usare per descrivere i campi del file e validare quest'ultimo. Se vuoi saperne di più puoi dare un'occhiata a [questa sezione di arigadicomando.it](https://arigadicomando.it/frictionless/).

Se però provi a lanciare lo stesso comando `describe` su un file `.json`, ad esempio `glossary.json` ([download](https://raw.githubusercontent.com/indecis-it/data/main/data/glossary.json))
```bash
frictionless describe glossary.json
```

ottieni questo errore

```bash
[resource-error] The data resource has an error: cannot retrieve metadata "glossary.json" because "" 
```

Puoi risolvere il problema semplicemente aggiungendo l'opzione `--path` in questo modo

```bash
frictionless describe --path glossary.json
```

### Riferimenti
- [Frictionless data](https://frictionlessdata.io/)
- https://arigadicomando.it/frictionless/ricette/#validare-un-file-json
