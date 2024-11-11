---
title: "Importare file csv in un gpkg mantenendo i datatype degli attributi"
linkTitle: "Importare file csv in un gpkg mantenendo i datatype degli attributi"
date: 2024-11-11
description: >
  Importare file csv in un GeoPackage mantenendo i datatype degli attributi.
tags:
  - csv/tsv
  - GDAL
  - gpkg
  - QGIS
issue: [264]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Ho un file CSV con vari attributi (Integer, String ecc...), come importarlo in un GeoPackage mantenendo inalterato il tipo di dato.

Sia per GDAL che per QGIS occorre creare un file ausiliario con estensione `CSVT`, file che deve avere stesso nome e _deve stare nella stessa cartella del file di partenza_. Il file .CSVT è un file di testo di una riga con estensione .CSVT e contiene informazioni sui tipi di dati delle colonne del file CSV a cui corrisponde. I CSVT consentono all'utente di definire i seguenti tipi di dati: Integer, Real, String, Date (AAAA-MM-GG), Time (HH:MM:SS+nn) e DateTime (AAAA-MM-GG HH:MM:SS+nn).

## GDAL

```
ogr2ogr -overwrite -f GPKG nome_file.gpkg nome_file_csv.csv
```

## QGIS

Caricare il file CSV in QGIS usando l'apposito comando `Importa testo delimitato`, successivamente tasto destro sul layer csv, esporta in GeoPackage.

## Riferimenti utili

1. [GDAL](https://gdal.org/en/latest/index.html)
2. [QGIS](https://www.qgis.org/it/site/)
