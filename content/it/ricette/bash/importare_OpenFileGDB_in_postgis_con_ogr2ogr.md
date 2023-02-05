---
title: "Come importare un OpenFileGDB in PostGIS usando ogr2ogr"
linkTitle: "Importare un gdb in un database PostGIS"
date: 2022-11-26
description: >
  Come importare un database gdb (ESRI) in un database PostgreSQL/PostGIS
tags:
  - bash
  - ogr2ogr
  - ogr
  - database
  - filegdb
issue: [232]
chefs: ["Totò Fiandaca"]
guide: ["Totò Fiandaca"]
---

---

## Caso d'uso

Dato un file [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) (pesa circa 5 GB con oltre 300 tabelle, relazioni e domini), che contiene semplici tabelle e tabelle con attributi geometrici (MultiPolygonZM, MultiLineStringZ e PointZM), come importarlo in un database **PostGIS** (PostGreSQL 14 con PostGIS 3.3.1) usando ogr2ogr all'interno della OSGeo4W Shell (con GDAL/OGR 3.6)

## Soluzione

```
ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=DBGT_10K_22_V01 user=postgres password=xxxxx" \
"E:\yyyyyyy\DBGT_10K_22_V01\DBGT_10K_22_V01.gdb" -overwrite -progress -skipfailures \
--config PG_USE_COPY YES --config OGR_ORGANIZE_POLYGONS SKIP
```

dove:
- `-overwrite` : sovrascrive
- `-progress` : visualizza la famosa progressione di GDAL 0...10...20...
- `-skipfailures` : continua dopo un errore, saltando la funzione fallita.
- `--config PG_USE_COPY YES` : velocizza notevolmente la copia
- `--config OGR_ORGANIZE_POLYGONS SKIP` : salta il controllo degli anelli interni ai poligoni velocizzando il processo

NB: questo costrutto importa tutte le tabelle, non distinguendo i vettori dalle semplici tabelle.

### Importare solo vettori

Per importare solo le geo-tabelle, occorre estrarre prima l'elenco dei nomi delle geo-tabelle e popi lanciare nella OSGeo Shell:

```
for %f in (CANALE_CANALE_BSU_L AR_VRD_AR_VRD_SUP_L CANALE_CANALE_PER AC_CIC_AC_CIC_SUP_SR AR_VRD_AR_VRD_SUP EDIFC_CR_EDF_IS MN_MAU_MN_MAU_SUP_P AR_STR_AR_STR_SUP_SR CANALE_CANALE_ASU_L CANALE_CANALE_BSU CANALE_CANALE_ASU AB_CDA_AB_CDA_SUP_SR F_NTER_F_NTER_SU_P CV_LIV_CV_LIV_LIN_SG ALVEO_A_ALVEO_A_SU_L OP_POR_OPPR_SUP EDI_MIN_CR_EDF_IS ALVEO_ALVEO_SUP_L F_NTER_F_NTER_SU MU_DIV_MU_DIV_SUP_L MU_SOS_MSOS_SUP_L EDIFC_CR_EDF_ME_SR ES_AMM_ES_AMM_PER ALVEO_A_ALVEO_A_SU CONDOT_CONDOT_CL_SG ACC_PC_ACC_PC_POS EL_TRV_EL_TRV_TRA_SG STATO_STATO_LIM EL_STR_EL_STR_TRA_SG MAN_TR_MAN_TR_SUP_L CL_AGR_CL_AGR_SUP TRALIC_TRAL_BAS EDI_MIN_CR_EDF_ME AB_CDA_AB_CDA_SUP AR_MAR_AR_MAR_SUP_SR AB_CDA_AB_CDA_SUP_SG EL_FER_EL_FER_TRA_SG STATO_STATO_LIM_SG SCR_CR_LINEAXSCR AR_VMS_AR_VMS_SUP_L MAN_TR_MAN_TR_SUP STATO_STATO_EXT SCARPT_SCARPT_SUP_L TRALIC_TRAL_BAS_P CL_AGR_CL_AGR_FIL SCR_CR_BOUNDXSCR CASCATA_CASCATA_SU ALVEO_ALVEO_SUP OP_REG_OP_REG_SUP MN_IND_MN_IND_SUP SD_FER_SD_FER_SUP_SR OP_POR_OPPR_SUP_L TP_STR_TP_STR_PER PT_QUO AR_VMS_AR_VMS_SUP MN_MAU_MN_MAU_SUP CV_AES_CV_AES_EXT_SR ASTA_F_ASTA_F_PER TR_COM FOR_PC_FOR_PC_SUP_SR RT_MET REGION AB_CDA_AB_CDA_SUP_L AR_STR RT_IDR TR_SAC ES_AMM_ES_AMM_TRA EL_ACQ_EL_ACQ_TRA_SG PS_INC AC_PED_AC_PED_SUP_SR GZ_TRV CAPOSD ACC_PC_ACC_PC_ACC LOC_SG AR_MAR SV_AER SCARPT_SCARPT_SUP EDI_MIN_CR_EDF_ME_SR FOR_PC_FOR_PC_SUP_L ASTA_F_ASTA_F_BSU ACC_INT EL_TRV CV_AES SV_POR GZ_VMS AATT TR_OLE SCR_CR_SFONDXSCR TR_GAS BI_IND AC_CIC FOR_PC_FOR_PC_SUP ALVEO_ALVEO_SUP_SR MU_SOS_MSOS_SUP DRE_SUP ALVEO_A_ALVEO_A_SU_SR ALBERO EDIFC_CR_EDF_ME DIGA_DIGA_SUP_L PROVIN A_PVEG GZ_MET Z_FOTO ND_OLE SC_DIS LIM_COM MN_IND_MN_IND_SUP_P AC_VEI_AC_VEI_SUP_SR EL_FUN_EL_FUN_TRA_SG EL_FUN EL_STR CS_MAR_CS_MAR_LIN_SG META MN_CON_MN_CON_SUP_SR PALO ARGINE_ARGN_SUP_SR CV_LIV SCR_CR_POINTXSCR CONDOT PAR_AR A_TRAS SCARPT_SCARPT_SUP_SG EL_FER SV_STR P_CCAT ND_ELE RT_CIC EL_MET_EL_MET_TRA_SG AT_NAV V_RETE EL_MET RT_TRV EL_CIC_EL_CIC_TRA_SG CASCATA_CASCATA_SU_L RT_ST1 AR_VMS_AR_VMS_SUP_SR ND_COM MU_DIV_MU_DIV_SUP COMUNE CT_MET ND_SAC BOSCO_BOSCO_SUP_SR EL_CIC ASTA_F_ASTA_F_ASU EL_VMS_EL_VMS_TRA_SG SP_ACQ_SP_ACQ_SUP_SG RT_VMS RT_FUN AF_ACQ P_FTGR DIGA_DIGA_SUP_SR ZONA_R P_FCAT OP_REG_OP_REG_SUP_L ACQ_IN EL_ACQ PONTE ASTA_F_ASTA_F_ASU_L CV_DIS ASTA_F_ASTA_F_BSU_L TR_ELE OP_REG_OP_REG_SUP_SR ARGINE_ARGN_SUP_L MN_ARR BRK_LN MN_INT TR_AAC UN_VOL GALLER ATTR_SP SED_AMM GZ_STR PT_BTM GHI_NV EL_FNE RT_ST2 TP_STR_TP_STR_TRA DIGA_DIGA_SUP AC_PED ELE_CP P_TRAR SV_ATR EL_VMS ND_IDR FIL_AL ND_AAC LN_BTM GZ_FUN EL_IDR_EL_IDR_TRA_SG SD_FER INVASO_INVASO_SUP_SG MN_CON RT_IDN CM_MON EL_IDR RT_FER EL_DIV PE_UINS SV_FER AC_VEI ND_GAS CS_MAR GZ_CIC INVASO BOSCO GZ_FER ARGINE_ARGN_SUP SP_ACQ DRE_SUP_PLG SIMBOLOGIA_ARC SIMBOLOGIA_PLG SIMBOLOGIA_PTS ) do (ogr2ogr -f "PostgreSQL" PG:"host=localhost port=5432 dbname=DBGT_10K_22_V01 user=postgres password=xxxxxx" "E:\yyyyyyy\DBGT_10K_22_V01\DBGT_10K_22_V01.gdb" %f -overwrite -progress -skipfailures --config PG_USE_COPY YES --config OGR_ORGANIZE_POLYGONS SKIP)
```

## Dati

[download](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) file pesante +5 GB

## Bonus

Per visualizzare tutte le tabelle presenti nel database PostGIS:

```
ogrinfo -ro -so -oo LIST_ALL_TABLES=YES PG:"dbname=DBGT_10K_22_V01 host='localhost' port='5432' user='postgres' password=xxxxx schemas=public"
```

## Riferimenti utili

- ogr2ogr: <https://gdal.org/programs/ogr2ogr.html>
- <https://gis.stackexchange.com/questions/83016/how-to-import-esri-geodatabase-format-gdb-into-postgis>
- <https://gis.stackexchange.com/questions/431106/importing-a-gdb-file-into-postgis-using-ogr2ogr>
- conversione domini: <https://gis.stackexchange.com/questions/107062/converting-file-geodatabase-with-coded-domains-to-postgresql-postgis>
- opzioni: <https://gdal.org/drivers/vector/pg.html#dataset-open-options>

