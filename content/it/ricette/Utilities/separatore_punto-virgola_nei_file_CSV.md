---
title: "Modificare separatore di campo di un CSV"
linkTitle: "Modificare separatore di campo di un CSV"
date: 2020-04-27
description: >
  Fare diventare il punto e virgola ";" separatore di campi al posto della virgola "," in un file scaricato come formato CSV da Google Spreadsheet
tags:
  - csv
  - libreoffice
  - gsheet
  - script
issue: [82]
autori: ["Ciro Spataro"]
chefs: ["Gianni Vitrano","Andrea Borruso"]
---


## Introduzione

È utile ad esempio sapere come fare diventare il `;` separatore di campi al posto della ",", in un file scaricato in formato CSV da Google spreadsheet.

## libreoffice

Se usi **libreoffice**:
- salva in formato ODS da google sheet;
- apri il file ODS con libreoffice;
- fai salva con nome in CSV e scegli il ; come separatore.

Appena clicchi su salva si aprirà la tendina che ti permette di cambiare alcuni parametri. A questo punto bisogna selezionare il punto e virgola al posto della virgola.

![](https://user-images.githubusercontent.com/30607/62115840-6550d180-b2b9-11e9-8df5-cc8e67849972.png)

## Google sheet

Se vuoi lavorare dentro Google spreadsheets direttamente qui c'è uno [script](https://stackoverflow.com/questions/49248498/how-can-i-export-to-csv-with-pipe-delimiter) che puoi usare. Nello sheet Parameters dei sostituire il pipe | con il semicolon.



