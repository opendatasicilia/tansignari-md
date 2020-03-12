---
title: "Come usare un CSV remoto come source in QGIS, forzando il tipo di campo?"
linkTitle: "Come usare un CSV remoto come source in QGIS"
date: 2020-03-12
description: >
  Come usare un CSV remoto come source in QGIS, forzando il tipo di campo.
tags:
- QGIS
- GDAL/OGR
- CSV
- virtuallayerOGR
issue: [133]
autori: ["Totò Fiandaca"]
chefs: ["Andrea Borruso"]
---

---

## Introduzione

Alcune volte è necessario utilizzare dei file **CSV** remoti e leggerli attraverso vari strumenti, in questo caso con **QGIS**. I file **CSV** sono file testuali separati da un delimitatore. In generale i campi del **CSV** non hanno definito la tipologia dei campi e quindi sono letti come se fossero tutto testo. Vediamo come ovviare a questo problema.

## File CSV RAW 


Uso questo [CSV](https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-regioni/dpc-covid19-ita-regioni.csv) remoto, presente su repo GitHub, in QGIS tramite protocollo HTTPS ma i campi risultano tutti testuali, come posso forzare il tipo di campo??

---

## Riferimenti

- [GDAL](https://gdal.org/)
- [Virtual File Format](https://gdal.org/drivers/vector/vrt.html#virtual-file-format)
