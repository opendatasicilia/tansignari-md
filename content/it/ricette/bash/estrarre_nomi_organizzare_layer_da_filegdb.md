---
title: "Estrarre i nomi dei layer presenti in un filegdb"
linkTitle: "Estrarre i nomi dei layer presenti in un filegdb e suddividerli per tipologia"
date: 2023-01-18
description: >
  Come estrarre i nomi dei layer presenti in un filegdb e suddividerli per geometry type.
  - bash
  - json
  - jq
  - Miller
  - filegdb
issue: [242]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Dato un FileGDB [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) (pesa circa 5 GB con oltre 300 tabelle, relazioni e domini), che contiene semplici tabelle e tabelle con attributi geometrici e domini di campo. Estrarre i nomi dei layer e suddividerli per tipologia, in particolare usando la geometry type, sotto un esempio:

Con `ogrinfo` è possibile estrarre - da un FileGDB - la lista dei layer presenti (sotto output classico):

```
ogrinfo -so DBGT_10K_22_V01.gdb
```

```
INFO: Open of `DBGT_10K_22_V01.gdb'
      using driver `OpenFileGDB' successful.
Layer: SP_ACQ_SP_ACQ_NOM_T (None)
Layer: ARGINE (None)
Layer: GZ_FER_GZ_FER_TY (None)
Layer: INVASO_INVASO_NOM_T (None)
Layer: GZ_CIC_GZ_CIC_TY (None)
Layer: CS_MAR_CS_MAR_LIN_CS_MAR_NOM_T (None)
Layer: ND_GAS_ND_GAS_TY (None)
Layer: SV_FER_SV_FER_FUN (None)
Layer: SV_FER_SV_FER_NOM_T (None)
...
Group SARDEGNA_DBGT:
  Layer: CANALE_CANALE_BSU_L (3D Measured Multi Line String)
  Layer: AR_VRD_AR_VRD_SUP_L (3D Measured Multi Line String)
  Layer: CANALE_CANALE_PER (3D Measured Multi Line String)
  Layer: AC_CIC_AC_CIC_SUP_SR (3D Multi Polygon)
  Layer: AR_VRD_AR_VRD_SUP (3D Multi Polygon)
  ...
Group SIMBOLOGIA:
  Layer: SIMBOLOGIA_ARC (3D Measured Multi Line String)
  Layer: SIMBOLOGIA_PLG (3D Measured Multi Polygon)
  Layer: SIMBOLOGIA_PTS (3D Measured Point)
```
dalla lista si nota che ci sono quattro tipologie di oggetti:

1. None;
2. Line;
3. Point;
4. Polygon.

## Soluzione classica

usando il classico output di `ogrinfo`:

```sh
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

# lista.txt:
# ogrinfo -so "D:\GitHub\ESRI_FileGeodatabase_GDAL\dati\DBGT_10K_22_V01.gdb"

# crea cartella di output
mkdir -p ./output2

# per ogni oggetto
for i in None Line Point Polygon; do
<lista.txt grep $i | sed -E 's/ {0,}//' | sed -E 's/Layer: (.+) \(.+$/\1/'>output2/classe_$i.txt
done
```
output:

sono quattro file txt, uno per ogni geometry type:
1. classe_None.txt;
2. classe_Line.txt;
3. classe_Point.txt;
4. classe_Polygon.txt.

dove:
- `sed -E 's/ {0,}//'`, cancella eventuali spazi iniziali;
- `sed -E 's/Layer: (.+) \(.+$/\1/'` elimina la parte iniziale e finale della stringa di output classico (Layer: AR_VRD_AR_VRD_SUP_L (3D Measured Multi Line String), mantenendo solo il nome effettivo del layer.

## Soluzione moderna

usando il nuovo formato di output di `ogrinfo`, ovvero `json`:

```
<out.json jq  -c '.layers[]|{name:.name,geom_type:(if (.geometryFields|length) > 0 then .geometryFields[].type else "none" end) }' |  mlr --ijsonl --ocsv unsparsify
```
estrae la lista del layer:

![](https://user-images.githubusercontent.com/7631137/217541999-d5831906-7df9-46b8-aa75-d2ee2ede699f.png)

dove:
- `jq  -c '.layers[]|{name:.name,geom_type:(if (.geometryFields|length) > 0 then .geometryFields[].type else "none" end) }'` estrae la lista dei layer e verifica se la lunghezza del campo `geometryFields` è >0, in caso contrario assegna valore `none`;
- `mlr --ijsonl --ocsv unsparsify` converte da jsonl a csv e sistema bene l'output.

per ottenere i quattro file, uno per ogni geometry_type:

```sh
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

# out.json:
# ogrinfo -so -json "D:\GitHub\ESRI_FileGeodatabase_GDAL\dati\DBGT_10K_22_V01.gdb"

# crea cartella di output
mkdir -p ./output2

# per ogni oggetto
for i in none Line Point Polygon; do
<out.json jq  -c '.layers[]|{name:.name,geom_type:(if (.geometryFields|length) > 0 then .geometryFields[].type else "none" end) }' |  mlr --ijsonl --ocsv unsparsify then filter '$geom_type=~"^.{0,}'"$i"'.{0,}$"'>output2/classe_$i.txt
done
```

## Dati

- [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) file pesante +5 GB
- [lista.txt - output classico ogrinfo](https://github.com/opendatasicilia/tansignari/files/10668761/lista.txt)
- [out.json - output moderno ogrinfo](https://github.com/opendatasicilia/tansignari/files/10679184/out.zip)

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- jq: <https://stedolan.github.io/jq/>
- Miller (mlr): <https://miller.readthedocs.io/>
- [piccolo gioiello eterogeneità dati](https://arigadicomando.it/miller/eterogeneita_record/)

