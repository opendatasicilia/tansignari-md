---
title: "Ordinare elementi di un array"
linkTitle: "Ordinare elementi di un array alfanumerico"
date: 2022-01-13
description: >
 Ordinare numericamente gli elementi di un array alfanumerico.
tags:
  - script
  - bash
  - miller
  - CSV/TSV
  - array
issue: [196]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## caso d'uso

Lista numeri civici di una strada: ordinare la seguente lista `2,2/B,2/A,1,3` in modo da ottenere `1,2,2/A,2/B,3`, ovvero ordinarla numericamente anche se ha elementi alfanumerici.

## script bash

```bash
mlr --csv nest --explode --values --across-records -f scritta --nested-fs "-" then \
put -S '$totoN=regextract($scritta,"[0-9]+");$totoT=regextract($scritta,"[a-zA-Z]+")' then \
unsparsify then sort -f den_estesa -n totoN -f totoT then cut -r -x -f "toto+" then \
nest --implode --values --across-records --nested-fs "-" -f scritta  ordinare_scritta.csv
```

ragionamento:

lo script mette tutto in colonne splittando il campo `scritta` usando come delimitatore `-` e popolando due nuove colonne `totoN` (numeri) e `totoT` (testo) con la parte numerica e la parte testuale di ogni elemento; successivamente ordina usando i campi `den_estesa`, `totoN` e `totoT`, a questo punto elimina i campi in più (`toto+`) e poi torna indietro implodendo tutto.

nota: con Miller 5

esempio:

![](https://user-images.githubusercontent.com/7631137/149374235-c0791747-d962-4f67-8a7f-b3ddf1b1704b.png)

risultato:

![](https://user-images.githubusercontent.com/7631137/149384324-d59e6837-ac44-4d7a-8506-d31c339f10b0.png)

## Riferimenti utili

[**Miller**](https://github.com/johnkerl/miller)