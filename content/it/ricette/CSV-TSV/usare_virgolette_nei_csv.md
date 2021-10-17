---
title: "Come usare bene le virgolette nei file CSV"
linkTitle: "Come usare bene le virgolette nei file CSV"
date: 2021-10-17
description: >
  Le virgolette sono un carattere speciale per i CSV, quindi va fatto l'escape, raddoppiandole.
tags:
  - csv/tsv
  - QGIS
issue: [191]
chefs: ["Totò Fiandaca"]
guide: ["Totò Fiandaca","Andrea Borruso"]
---

---

## Caso d'uso

Ho un file CSV dove l'ultima colonna `info` è fatta così:

```
""name"=>"Lausanne","pos"=>"lausanne","conf"=>"FOSS4G 2006","year"=>"2006","logo"=>"images_flight/foss4g_2006.png""
```

non viene riconosciuto come CSV in QGIS:

![](https://user-images.githubusercontent.com/7631137/137617631-6b179f25-8e81-4f1a-9d68-904452b95f6e.png)

## Soluzione

Le virgolette sono un carattere speciale per i CSV, quindi occorre fare l'escape, raddoppiandole.

Quindi da così:

```
""name"=>"Trento","pos"=>"trento","conf"=>"Open Source Free Software GIS - GRASS users conference","year"=>"2002","logo"=>"null""
```

a:

```
"""name""=>""Trento"",""pos""=>""trento"",""conf""=>""Open Source Free Software GIS - GRASS users conference"",""year""=>""2002"",""logo""=>""null"""
```

## download

[qui](https://github.com/opendatasicilia/tansignari/files/7359030/foss4g.csv) file CSV di esempio

## Riferimenti utili

[QGIS](https://www.qgis.org/it/site/)

