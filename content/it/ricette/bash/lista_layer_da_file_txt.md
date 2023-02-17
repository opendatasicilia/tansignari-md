---
title: "Leggere lista dei layer da un file di testo"
linkTitle: "Leggere lista dei layer da un file di testo per un comando ogr in ambiente bacth"
date: 2023-02-12
description: >
  Come leggere una lista di layer da un file di testo per usarlo in un comando ogr in ambiente bacth.
tags:
  - bash
  - batch
  - ogr
  - filegdb
issue: [246]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso", "Andrea Giudiceandrea", "Totò Fiandaca"]
---

---

## Caso d'uso

Il seguente costrutto importa i layer `AC_CIC_AC_CIC_SUP_SR AR_VRD_AR_VRD_SUP EDIFC_CR_EDF_IS AR_STR_AR_STR_SUP_SR CANALE_CANALE_BSU ` da un FileGDB ad un altro:

```
ogr2ogr -f "OpenFileGDB" -progress x_Andy_only_Polygon.gdb "D:\GitHub\ESRI_FileGeodatabase_GDAL\dati\DBGT_10K_22_V01.gdb" AC_CIC_AC_CIC_SUP_SR AR_VRD_AR_VRD_SUP EDIFC_CR_EDF_IS AR_STR_AR_STR_SUP_SR CANALE_CANALE_BSU  -lco FEATURE_DATASET=sardegna
```

la lista dei layer da importare è l'output di un altro script che crea un file `lista_layer.txt`;
il seguente script:

```
ogr2ogr -f "OpenFileGDB" -progress x_Andy_only_Polygon_pesanti.gdb "D:\GitHub\ESRI_FileGeodatabase_GDAL\dati\DBGT_10K_22_V01.gdb" lista_layer.txt -lco FEATURE_DATASET=sardegna
```

dove al posto dell'elenco dei layer ho messo il file `lista_layer.txt`, ma c'è un errore:

![image](https://user-images.githubusercontent.com/7631137/218327305-85dcb050-659c-4b5b-9e74-1ef03cf0f5c8.png)


## Soluzione

occorre impostare una variabile come sotto:

`set /p lista2=<lista_layer.txt`

poi:

```
ogr2ogr -f "OpenFileGDB" -progress x_Andy_only_Polygon_pesanti.gdb "D:\GitHub\ESRI_FileGeodatabase_GDAL\dati\DBGT_10K_22_V01.gdb" %lista2% -lco FEATURE_DATASET=sardegna
```

funziona!!! 
![image](https://user-images.githubusercontent.com/7631137/218671295-b42959eb-2521-4893-93f6-da6d2a6f41e1.png)

## Dati

- [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401)

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- SE: <https://stackoverflow.com/questions/3068929/how-to-read-file-contents-into-a-variable-in-a-batch-file/3069068#3069068>

