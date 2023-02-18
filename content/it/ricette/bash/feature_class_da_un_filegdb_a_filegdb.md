---
title: "Feature class da un FileGDB ad un altro"
linkTitle: "Importare/esportare un insieme di feature class da un FileGDB ad un altro"
date: 2023-02-12
description: >
  Come importare/esportare un insieme di feature class da un FileGDB ad un altro usando ogr2ogr.
tags:
  - bash
  - ogr2ogr
  - filegdb
  - jq
  - miller
issue: [244]
chefs: ["Totò Fiandaca"]
guide: ["Totò Fiandaca"]
---

---

## Caso d'uso

Questo [FileGDB ](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401)è molto pesante (~ 5 GB) e @aborruso non vuole scaricarlo. (contiene oltre 300 tabelle)
In questa issue una possibile soluzione per alleggerire il file (ridotto a 61 tabelle) e permettere a @aborruso di scaricarlo e fare dei test:

```
ogr2ogr -f "OpenFileGDB" -progress x_Andy_only_Polygon.gdb "D:\GitHub\ESRI_FileGeodatabase_GDAL\dati\DBGT_10K_22_V01.gdb" AC_CIC_AC_CIC_SUP_SR AR_VRD_AR_VRD_SUP EDIFC_CR_EDF_IS AR_STR_AR_STR_SUP_SR CANALE_CANALE_BSU  AB_CDA_AB_CDA_SUP_SR OP_POR_OPPR_SUP EDI_MIN_CR_EDF_IS F_NTER_F_NTER_SU EDIFC_CR_EDF_ME_SR CL_AGR_CL_AGR_SUP TRALIC_TRAL_BAS EDI_MIN_CR_EDF_ME AB_CDA_AB_CDA_SUP MAN_TR_MAN_TR_SUP  OP_REG_OP_REG_SUP MN_IND_MN_IND_SUP SD_FER_SD_FER_SUP_SR AR_VMS_AR_VMS_SUP MN_MAU_MN_MAU_SUP CV_AES_CV_AES_EXT_SR FOR_PC_FOR_PC_SUP_SR AR_STR PS_INC AC_PED_AC_PED_SUP_SR SV_AER EDI_MIN_CR_EDF_ME_SR ASTA_F_ASTA_F_BSU CV_AES AATT AC_CIC FOR_PC_FOR_PC_SUP MU_SOS_MSOS_SUP EDIFC_CR_EDF_ME A_PVEG SC_DIS AC_VEI_AC_VEI_SUP_SR MN_CON_MN_CON_SUP_SR ARGINE_ARGN_SUP_SR A_TRAS AR_VMS_AR_VMS_SUP_SR CT_MET BOSCO_BOSCO_SUP_SR DIGA_DIGA_SUP_SR ZONA_R PONTE OP_REG_OP_REG_SUP_SR GALLER ATTR_SP DIGA_DIGA_SUP AC_PED ELE_CP SD_FER MN_CON PE_UINS AC_VEI INVASO BOSCO ARGINE_ARGN_SUP SP_ACQ DRE_SUP_PLG  -lco FEATURE_DATASET=sardegna
```

in maiuscolo la lista delle sole feature class poligonali e con almeno 1 oggetto: otteniamo un peso di ~1.30 GB

## Soluzione

Ma come ho ottenuto la lista delle sole feature class polygonali e che hanno almeno un oggetto?

ecco come:

1. estraggo le info dal FileGDB:
```
ogrinfo -so -json DBGT_10K_22_V01.gdb >out.json
```

2. estraggo solo i poligoni che hanno almeno 1 oggetto:
```
<out.json jq  -c '.layers[]|{name:.name,nro:.featureCount,geom_type:(if (.geometryFields|length) > 0 then .geometryFields[].type else "none" end) }' |  mlr --ijsonl --ocsv unsparsify then filter '$geom_type=~"^.{0,}Polygon.{0,}$"' then filter '$nro>0'
```

per maggiori info leggi ricetta: [estrarre_nomi_organizzare_layer_da_filegdb](https://tansignari.opendatasicilia.it/ricette/bash/estrarre_nomi_organizzare_layer_da_filegdb/)


![image](https://user-images.githubusercontent.com/7631137/218315750-87094b4e-f06d-460b-94bb-1a9a42cee5ba.png)

## Dati

- [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401)
- [out.json - output moderno ogrinfo](https://github.com/opendatasicilia/tansignari/files/10679184/out.zip)

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- ogrinfo: <https://gdal.org/programs/ogrinfo.html>
- Miller (mlr): <https://miller.readthedocs.io/>
- jq: <https://stedolan.github.io/jq/>