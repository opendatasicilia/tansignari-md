---
title: "Scaricare dati sulla popolazione residente dal sito ISTAT"
linkTitle: "Scaricare dati sulla popolazione residente dal sito ISTAT"
date: 2020-03-03
description: >
  Scaricare dati sulla popolazione residente per regione (e province) dal sito ISTAT.
tags:
  - csv
  - ISTAT
  - riga di comando
  - visidata
issue: [135]
autori: ["Totò Fiandaca"]
chefs: ["Andrea Borruso"]
---

---

## Introduzione

l'[ISTAT](https://www.istat.it/) mette a disposizione molti dataset, quello di questa ricetta riguarda la **Popolazione residente al 1° gennaio 2019** per ogni Regione (e provincia) italiana. L'interfaccia messa a disposizione dall'[I.STAT](http://dati.istat.it/Index.aspx) è molto complessa e lenta, quindi, spesso, è più veloce scaricare l'intero dataset e poi filtrarlo in locale con altri applicativi, per esempio **Visidata**.

Da questo link :  http://dati.istat.it/Index.aspx?DataSetCode=DCIS_POPRES1# scarico l'intero dataset

## Visidata

Ottenuto il file **CSV**, avviare **Visidata** e seguire questo video:

![](https://user-images.githubusercontent.com/30607/76792091-84f22700-67c2-11ea-908d-37820229cba2.gif)

la logica da seguire è quella di filtrare i campi che contengolo la voce `totale`  e infine filtrare per `regione`,  ottenendo la tabella seguente:

![](https://user-images.githubusercontent.com/7631137/76794253-e1efdc00-67c6-11ea-9f7e-dde3a87b91a8.png)

### step by step

1. dalla shell digita `vd nomefile.csv`;
2. sposta il cursore fino al campo `SESSO` e posiziona il cursore sulla voce `totale`, pigia `,` per selezionare;
3. con `shift+"` filtra le righe selezionate e crea nuovo foglio;
4. sposta il cursore su `Stato civile` e posiziona il cursore su `totale`, pigiare `,` per selezionare;
5. con `shift+"` filtra le righe selezionate e crea nuovo foglio;
6. sposta il cursore su `ETA1` e pigia `shift+f`;
7. pigia `gj` per andare all'ultima riga SUL VALORE `TOTALE`, pigia `invio` per ottenere un nuovo foglio con i `TOTALI`;
8. posiziona il cursore sulla prima colonna, pigia `|` e digita `^....$` per filtrare le Regioni (`^.....$` per le province).
9. per nascondere i campi non utili, pigiare `-` sul campo;
10. per salvare il foglio, pigiare `shift+s` e digita il nome del file.

## Riferimenti utili

1. [Link ISTAT](http://dati.istat.it/Index.aspx?DataSetCode=DCIS_POPRES1#)
2. [Visidata](http://visidata.org/man/)



