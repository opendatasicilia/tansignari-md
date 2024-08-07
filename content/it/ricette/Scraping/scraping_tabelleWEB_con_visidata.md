---
title: "Come ottenere una tabella da una pagina web, usando solo VisiData"
linkTitle: "Come ottenere una tabella (o più tabelle) da una pagina web, usando solo VisiData"
date: 2019-11-15
description: >
 Come ottenere una tabella (o più tabelle) da una pagina web, usando solo [VisiData](https://www.visidata.org/).
tags:
  - VisiData
  - bash
  - html
  - web
  - scraping
issue: [164]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso","Totò Fiandaca"]
---

---

**Caso d'uso:** Scaricare la tabella della popolazione regioni italiane dalla pagina web https://www.tuttitalia.it/regioni/popolazione/

![](https://user-images.githubusercontent.com/7631137/99191863-eca4ab80-276f-11eb-8e09-f335a8d30598.png)

## Script Bash

```bash
vd "https://www.tuttitalia.it/regioni/popolazione/" +:table_0::
```

dove:

- `+:table_0::` per scegliere quale tabella, delle tante possibili in una pagina aprire. La `0` è la prima. La sintassi completa opzionale è `+:<sheet>:<row>:<col>`
- se hai una pagina multitabella e vuoi vedere l'elenco di tutte, basta non indicarne alcuna. Ad esempio 

```
vd "https://en.wikipedia.org/wiki/Olympic_medal"
```

Questa la issue dove è stato chiesto di introdurre questa modalità https://github.com/saulpw/visidata/issues/214#issue-383997505

## Tabella in output

In output otterrò una tabella con campi inutili dovuti alla presenza di link:

![](https://user-images.githubusercontent.com/7631137/99196414-85492480-278c-11eb-8c18-33803619af6a.png)

## Riferimenti utili

- [VisiData](https://www.visidata.org/)
