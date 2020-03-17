---
title: "Creare file CSV con i link agli Stemmi delle regioni italiane"
linkTitle: "Creare file CSV con i link agli Stemmi delle regioni italiane"
date: 2020-03-13
description: >
 Creare file CSV con i link agli Stemmi delle regioni italiane, con due colonne: Regioni e link
tags:
  - scraping
  - web
  - html
  - XPATH
  - IMPORTXML
  - wikipedia
  - gsheet
issue: [134]
autori: ["Totò Fiandaca"]
chefs: ["Andrea Borruso"]
---

---

**Caso d'uso:** Scaricare i dati di questa tabella, in particolare i primi due campi (Regione e link immagine).

![](img_01.png)

## Usando gsheet

- Inserire le intestazioni nelle prime due colonne: `regioni` e `link_stemmi`

![](img_02.png)

- nella cella `A2` incollare il comando:

```
=IMPORTXML("https://it.wikipedia.org/wiki/Stemmi_delle_regioni_italiane";"//table[2]//td[1]")
```

- nella cella `B2` incollare il comando:

```
=IMPORTXML("https://it.wikipedia.org/wiki/Stemmi_delle_regioni_italiane";"//td/a/img/@src")
```

![](img_03.png)

- output

![](img_04.png)

## Esportare in CSV

Dal menu `File` → `Scarica` → `Valori separati da virgola`

![](img_05.png)

**NB:** per impostazioni `italiane` di gsheet, nel comando di sopra, occorre usare il `;` altrimenti per impostazioni internazionli `,`.

---

## Riferimenti utili

1. [IMPORTXML](https://support.google.com/docs/answer/3093342?hl=it)
2. [Wikipedia](https://it.wikipedia.org/wiki/Stemmi_delle_regioni_italiane)