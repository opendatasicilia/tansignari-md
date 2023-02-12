---
title: "Da enne righe ad una usando Miller"
linkTitle: "Da enne righe ad una usando Miller"
date: 2023-02-12
description: >
  Come ottenere una sola riga a partire da un file txt con enne righe
tags:
  - bash
  - csv
  - Miller
issue: [245]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso", "Totò Fiandaca"]
---

---

## Caso d'uso

File csv con enne righe:

```
CL_AGR_CL_AGR_SUP
AATT
EDIFC_CR_EDF_ME_SR
EDIFC_CR_EDF_ME
EDIFC_CR_EDF_IS
BOSCO_BOSCO_SUP_SR
BOSCO
AC_VEI_AC_VEI_SUP_SR
AR_STR_AR_STR_SUP_SR
EDI_MIN_CR_EDF_ME_SR
EDI_MIN_CR_EDF_ME
EDI_MIN_CR_EDF_IS
ELE_CP
AC_VEI
```
come ottenere una sola riga, vedi sotto (separatore un spazio):

```
CL_AGR_CL_AGR_SUP AATT EDIFC_CR_EDF_ME_SR EDIFC_CR_EDF_ME EDIFC_CR_EDF_IS BOSCO_BOSCO_SUP_SR BOSCO AC_VEI_AC_VEI_SUP_SR AR_STR_AR_STR_SUP_SR EDI_MIN_CR_EDF_ME_SR EDI_MIN_CR_EDF_ME EDI_MIN_CR_EDF_IS ELE_CP AC_VEI
```

usando Miller?

## Soluzione

```
mlr --csv -N nest --ivar " " -f 1 unica_linea.txt
```

dove:
- `-N` imposta il 'senza intestazione' sia in input che in output
- `nest`: Esplode i valori di campo specificati in campi/record separati o li inverte
- `--ivar`: implode i valori;
- `" "`: separatore valori, uno spazio
- `-f` richiama il numero del campo, in questo caso il primo

## Dati

- [unica_linea.txt](https://github.com/opendatasicilia/tansignari/files/10716428/unica_linea.txt)

## Riferimenti utili

- Miller (mlr): <https://miller.readthedocs.io/>
- I flag https://miller.readthedocs.io/en/latest/reference-main-flag-list/index.html
- Verbo Nest: <https://miller.readthedocs.io/en/latest/reference-verbs/#nest>

