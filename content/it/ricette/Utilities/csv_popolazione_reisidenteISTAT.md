---
title: "Scaricare dati sulla popolazione residente dal sito ISTAT"
linkTitle: "Scaricare dati sulla popolazione residente dal sito ISTAT"
date: 2020-03-03
description: >
  Scaricare dati sulla popolazione residente per regione dal sito ISTAT.
tags:
  - csv
  - ISTAT
  - visidata
issue: [135]
autori: ["Totò Fiandaca"]
chefs: ["Andrea Borruso"]
---

---

## Introduzione

l'ISTAT mette a disposizione molti dataset, quello di questa ricetta riguarda la Popolazione residente al 1° gennaio 2019. L'interfaccia messa a disposizione dall'[I.STAT](http://dati.istat.it/Index.aspx) è molto complessa e lenta e quindi spesso è più veloce scaricare l'intero dataset e poi filtrarlo in locale con altri applicativi. per esempio **Visidata**.

Da questo link :  http://dati.istat.it/Index.aspx?DataSetCode=DCIS_POPRES1# scarico l'intero dataset

## Visidata

Ottenuto il file **CSV**, avviare **Visidata** e seguire questo video:

![](https://user-images.githubusercontent.com/30607/76792091-84f22700-67c2-11ea-908d-37820229cba2.gif)

la logica da seguire è quella di filtra i campi che contengolo la voce `totale` che è quella che ci serve per creare la tabella seguente:

![](https://user-images.githubusercontent.com/7631137/76794253-e1efdc00-67c6-11ea-9f7e-dde3a87b91a8.png)

## Riferimenti utili

1. [Link ISTAT](http://dati.istat.it/Index.aspx?DataSetCode=DCIS_POPRES1#)
2. [Visidata](http://visidata.org/man/)



