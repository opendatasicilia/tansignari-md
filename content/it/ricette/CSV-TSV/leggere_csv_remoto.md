---
title: "Leggere un CSV da Google sheet e spazializzare i punti in QGIS"
linkTitle: "Leggere un CSV da Google sheet e spazializzare i punti in QGIS"
date: 2020-05-16
description: >
  Leggere un CSV da Google sheet e spazializzare i punti in base alle coordinate in QGIS.
tags:
  - csv
  - gsheet
  - GDAL/OGR
  - QGIS
issue: [142]
autori: ["gimmybruce"]
chefs: ["Andrea Borruso"]
---

---

## Caso d'uso

Leggere un CSV (remoto) di Google Sheet

A partire da questo CSV presente in gsheet ( https://docs.google.com/spreadsheets/d/e/2PACX-1vT89Gvg-StE8M0zapI3A-WYRR1EbrnbUMZSi4QGFpJy5P4aM5r1HJ3I3Ro_OJceWZBygmFbLZVMJok6/pub?gid=1205794028&single=true&output=csv) è possibile leggerlo con **ogr** così:


```
ogrinfo CSV:"/vsicurl/https://docs.google.com/spreadsheets/d/e/2PACX-1vT89Gvg-StE8M0zapI3A-WYRR1EbrnbUMZSi4QGFpJy5P4aM5r1HJ3I3Ro_OJceWZBygmFbLZVMJok6/pub?gid=1205794028&single=true&output=csv"
```

In questo modo è possibile vedere il nome del layer, che è `pub?gid=1205794028&single=true&output=csv`. 

Per vedere altre informazioni:

```
ogrinfo CSV:"/vsicurl/https://docs.google.com/spreadsheets/d/e/2PACX-1vT89Gvg-StE8M0zapI3A-WYRR1EbrnbUMZSi4QGFpJy5P4aM5r1HJ3I3Ro_OJceWZBygmFbLZVMJok6/pub?gid=1205794028&single=true&output=csv" "pub?gid=1205794028&single=true&output=csv"
```

Se il CSV ha due campi con le coordinate (es. LAT, LON):

```
ogrinfo CSV:"/vsicurl/https://docs.google.com/spreadsheets/d/e/2PACX-1vT89Gvg-StE8M0zapI3A-WYRR1EbrnbUMZSi4QGFpJy5P4aM5r1HJ3I3Ro_OJceWZBygmFbLZVMJok6/pub?gid=1205794028&single=true&output=csv" "pub?gid=1205794028&single=true&output=csv" -oo X_POSSIBLE_NAMES=LON -oo Y_POSSIBLE_NAMES=LAT
```

Ora, se volessi leggerlo in QGIS, potrei realizzare un file di testo (.vrt) e trascinarlo o caricarlo all'interno del software.
Ecco due possibilità:

1) lasciando il nome originario del file (ossia `pub?gid=1205794028&single=true&output=csv`)

```
<OGRVRTDataSource>
    <OGRVRTLayer name="pub?gid=1205794028&amp;single=true&amp;output=csv">
    <SrcDataSource relativeToVRT="0">CSV:/vsicurl/https://docs.google.com/spreadsheets/d/e/2PACX-1vT89Gvg-StE8M0zapI3A-WYRR1EbrnbUMZSi4QGFpJy5P4aM5r1HJ3I3Ro_OJceWZBygmFbLZVMJok6/pub?gid=1205794028&amp;single=true&amp;output=csv</SrcDataSource>
    <GeometryType>wkbPoint</GeometryType>
    <LayerSRS>WGS84</LayerSRS>
    <Field name="ID" type="Integer" />
    <Field name="comune" type="String" />
    <Field name="localita" type="String" />
    <GeometryField encoding="PointFromColumns" x="LON" y="LAT"/>
  </OGRVRTLayer>
</OGRVRTDataSource> 
```



2) scegliendo un nome diverso per il layer

```
<OGRVRTDataSource>
  <OGRVRTLayer name="esempionome">
    <SrcDataSource relativeToVRT="0">CSV:/vsicurl_streaming/https://docs.google.com/spreadsheets/d/e/2PACX-1vTwuYdMYS7vKJnTETwycLEGPFG2pwhxIlPMeChXuluRLjApQwhzEy_gUgsw_9lVRrAmGhAHWEj9LDV7/pub?gid=0&amp;single=true&amp;output=csv</SrcDataSource>
    <SrcLayer>pub?gid=0&amp;single=true&amp;output=csv</SrcLayer>
    <GeometryType>wkbPoint</GeometryType>
    <LayerSRS>WGS84</LayerSRS>
    <Field name="ID" type="Integer" />
    <Field name="comune" type="String" />
    <Field name="localita" type="String" />
    <GeometryField encoding="PointFromColumns" x="LON" y="LAT"/>
  </OGRVRTLayer>
</OGRVRTDataSource>
```


In tutti e due i casi riesco a spazializzare i punti ma nel caso 2 non leggo in tabella eventuali valori di altre colonne aggiuntive a LAT e LON. Appena possibile riprenderò e magari aggionerò la ricetta. 
