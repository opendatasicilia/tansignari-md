---
title: "Come eliminare righe da un file CSV"
linkTitle: "Eliminare righe da un file CSV"
date: 2022-10-16
description: >
  Come eliminare righe da un file CSV usando le utility linux sed e/o grep.
tags:
  - bash
  - sed
  - grep
  - csv/tsv
issue: [229]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Per chi lavora con i dati alfanumerici, spesso, nasce l'esigenza di eliminare delle righe all'interno di file testuali. In questa ricetta utilizzeremo due utility linux molto utili e facili da usare: sed e grep.

## esempio

il file è `input.csv`

| data       | version   | feature                                                                 | developed         |
| ---------- | --------- | ----------------------------------------------------------------------- | ----------------- |
| 2020-06-19 | QGIS 3.14 | feature-WMS project validator                                           | Etienne Trimaille |
| 2021-10-22 | QGIS 3.22 | feature-Add a POST option to the FileDownloader processing algorithm    | Etienne Trimaille |
| 2021-10-22 | QGIS 3.22 | feature-Allow configuration of the max cache size from QGIS settings    | David Marteau     |
| 2021-10-22 | QGIS 3.22 | feature-Add version to QGIS Server CLI tools                            | Etienne Trimaille |  | 3Liz |
| 2022-06-17 | QGIS 3.26 | feature-Alternate periodic check strategy for detecting project updates | David Marteau     |
| 2018-10-26 | QGIS 3.4  | Flatpak                                                                 | Aleix Pol         |
| 2021-06-18 | QGIS 3.20 | feature-Layer notes                                                     | Nyall Dawson      |
| 2022-06-17 | QGIS 3.26 | feature-Static parent variable in aggregate expression functions        | David Signer      |
| 2020-02-21 | QGIS 3.12 | Edit Invalid Attributes on Copy/Paste to Another Layer                  | David Signer      |

eliminare le righe che NON iniziano, nel campo `feature`, con `feature-`

## soluzione con sed

```
<input.csv sed '/^feature-/!d'
```
in questo caso `!d` non fa cancellare le righe che corrispopndono alla ricerca, ovvero, che iniziano con `feature-`

## soluzione con grep

```
<input.csv grep -P '^feature-'
```

in questo caso conserva le righe che corrispondono alla ricerca.

dove:

`-P`, --perl-regexp</br>
Interpret  PATTERNS  as  Perl-compatible regular expressions (PCREs).  This option is experimental when
combined with the -z (--null-data) option, and grep -P may warn of unimplemented features.


## Riferimenti utili

- [**sed**](https://it.wikipedia.org/wiki/Sed_(Unix))
- [**grep**](https://it.wikipedia.org/wiki/Grep)
- [**bash**](https://it.wikipedia.org/wiki/Bash)
