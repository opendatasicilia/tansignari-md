---
title: "Creare tabella PIVOT con SQL"
linkTitle: "Creare tabella PIVOT con SQL"
date: 2019-03-07
description: >
 Creare tabella PIVOT con SQL nel sito [data.world](https://data.world/).
tags:
  - SQL
  - PIVOT
  - data.world
  - query
  - CSV
issue: [141]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

Una tabella **PIVOT** è uno strumento analitico e di reporting necessario alla creazione di tabelle riassuntive. Uno dei fini principali di queste tabelle è l'organizzazione di dati complessi tramite una scelta opportuna dei campi e degli elementi che devono comporla.[Wikipedia](https://it.wikipedia.org/wiki/Tabella_pivot)

Per creare una tabella PIVOT è stato usato il sito `data.world`, importato un file CSV sorgente [dpc-covid19-ita-province.csv](https://github.com/pcm-dpc/COVID-19/blob/master/dati-province/dpc-covid19-ita-province.csv) e tramite la seguente query:


```sql
WITH andamentoProvince AS (
    SELECT CAST(dpc_covid19_ita_province.codice_provincia as STRING),
                dpc_covid19_ita_province.denominazione_provincia ,
                "data"||CAST(DATE_FORMAT(CAST(data AS DATE), "yyyyMMdd") as STRING) AS datee,
                dpc_covid19_ita_province.totale_casi FROM dpc_covid19_ita_province
                WHERE dpc_covid19_ita_province.denominazione_provincia  NOT LIKE "In fase di%"
    ORDER BY data
)
SELECT *
  FROM andamentoProvince
PIVOT (MAX(totale_casi) FOR datee IN ("data20200224","data20200225","data20200226","data20200227","data20200228","data20200229","data20200301","data20200302","data20200303","data20200304","data20200305","data20200306","data20200307","data20200308","data20200309","data20200310","data20200311","data20200312","data20200313","data20200314","data20200315","data20200316","data20200317","data20200318","data20200319","data20200320","data20200321","data20200322","data20200323","data20200324","data20200325","data20200326","data20200327","data20200328","data20200329","data20200330","data20200331","data20200401","data20200402","data20200403","data20200404","data20200405","data20200406","data20200407","data20200408","data20200409","data20200410","data20200411","data20200412","data20200413","data20200414","data20200415","data20200416","data20200417","data20200418","data20200419","data20200420","data20200421","data20200422"));
```

ottengo una tabella **PIVOT**, l'output è sempre un **CSV**.

[qui query](https://data.world/pigrecoinfinito/covid-19enna/workspace/query?queryid=bd60195e-21d8-4104-98db-6fdc5c36cab1) su data.world

La tabella **PIVOT** ha 107 righe (le province italiane) e come campi le date di censimento, dal 2020-02-24 al 2020-04-23, il valore dei campi è popolato dal `MAX(totale_casi)`.

## Riferimenti

- **PCM-DPC** : <https://github.com/pcm-dpc/COVID-19>
- **data.world**: <https://data.world/>
- **PIVOT** : https://docs.data.world/documentation/sql/concepts/advanced/PIVOT.html
- **DATE_FORMAT** : https://docs.data.world/documentation/sql/reference/functions/date_format.html

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- [**Blog post su Pigrecoinfinito**](https://pigrecoinfinito.com/2020/04/24/qgis-creare-un-atlas-inconsueto/) **QGIS creare un atlas inconsueto**
