---
title: "Aggiungere gli alias/label alle colonne calcolate"
linkTitle: "Come aggiungere gli alias/label alle colonne calcolate"
date: 2022-05-21
description: >
  Come aggiungere gli alias/label alle colonne calcolate di una query su un gsheet
tags:
  - gsheet
  - query
  - SQL
  - CSV
issue: [216]
chefs: ["Totò Fiandaca"]
guide: ["Dennis Angemi"]
---

---

## Caso d'uso

Se in una query aggiungessi delle colonne calcolate (`(H/125000)`), la relativa intestazione (della colonna H) non rifletterebbe correttamente il nome e quindi nascerebbe l'esigenza di rinominarla con una _**label**_; sotto il risultato di una query di esempio:

```
=query(raw!1:1000,"select A,D,(G/125000),(H/125000) ",-1)
```

![](https://user-images.githubusercontent.com/7631137/169658572-91eeac9f-7879-490f-bc2f-a81f5783a4cb.png)

## Soluzione

La soluzione trovata è la seguente:

```
=query(raw!1:1000,"select A,D,(G/125000),(H/125000) label (G/125000) 'Download', (H/125000) 'Upload' ",-1)
```

ovvero, scrivere in coda alla query `label` seguito dall'espressione utilizzata per popolare la colonna (`label (G/125000) 'Download'`); se ci fossero più colonne calcolate, scrivere una sola volta `Label` seguita dalle varie espressioni separate da `,` (`label (G/125000) 'Download', (H/125000) 'Upload'`).

