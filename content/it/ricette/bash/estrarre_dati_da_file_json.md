---
title: "Estrarre dati da file json"
linkTitle: "Come estrarre dati da un file in formato json"
date: 2023-01-18
description: >
  Come estrarre dati, e organizzarli in una tabella, da un file json.
tags:
  - bash
  - jq
  - json
  - Miller
  - filegdb
  - ogrinfo
issue: [237]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Dato un FileGDB [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) (pesa circa 5 GB con oltre 300 tabelle, relazioni e domini), che contiene semplici tabelle e tabelle con attributi geometrici e domini di campo. Il comando `ogrinfo -json DBGT_10K_22_V01.gdb` dà in output un file `json`: estrarre alcuni dati e strutturarli nel seguente modo:

feature_class  | lista_domainName
---------------|----------------
AC_VEI_AC_VEI_SUP_SR | H_AC_VEI_Sede, H_AC_VEI_Fondo, D_AC_VEI_Livello, H_AC_VEI_Zona

ovvero, nel primo campo il nome del layer/feature_class; nel secondo campo, la lista dei domini di campo collegati

## Soluzione

```
 <dbgt10k_fc_domain.json jq '.layers[]|{name:.name,fields:.fields[].domainName}' | mlr --j2c unsparsify then filter '!is_null($fields)' then sort -f feature_class,lista_domainName then nest --ivar "," -f fields
```

dove:

- `jq`, estrae prima il nodo _**layers**_, e poi dall'output costruisce una nuova struttura composta dal nome del _**layer**_ e dal nodo _**fields**_ contenuto nei _**layer**_;
- `Miller` trasforma il precedente output **JSON** in **CSV**, e filtra soltanto i record per i quali c'è un _**field**_ associato, ordina per _name_ (feature_class) e _fields_ (lista_domainName) (che sono i campi da creare) e infine implode i nomi dei _field_, li unisce, separandoli tramite `,` e raggruppandoli per nome di layer sorgente.

output:

![](https://user-images.githubusercontent.com/7631137/213261147-57d108ed-f2aa-4cce-a775-895108c31089.png)

per ottenere una riga per ogni dominio, occorre usare questo costrutto:

```
 <dbgt10k_fc_domain.json jq '.layers[]|{name:.name,fields:.fields[].domainName}' | mlr --j2c unsparsify then filter '!is_null($fields)' then sort -f feature_class,lista_domainName
 ```

![](https://user-images.githubusercontent.com/7631137/213261431-2c2e62a7-547a-42de-9f3a-52eda67b1392.png)

## Dati

- [download](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) file pesante +5 GB
- [dbgt10k_fc_domain](https://github.com/opendatasicilia/tansignari/files/10609275/dbgt10k_fc_domain.zip)

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- jq: <https://stedolan.github.io/jq/>
- Miller (mlr): <http://johnkerl.org/miller/doc/reference.html>

