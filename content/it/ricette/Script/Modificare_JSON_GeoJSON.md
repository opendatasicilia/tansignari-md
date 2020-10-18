---
title: "Modificare un JSON in GeoJSON"
linkTitle: "Modificare un JSON in GeoJSON"
date: 2019-04-21
description: >
 Modificare un insolito file JSON che contiene coordinate geografiche in un file GeoJSON leggibile da software GIS.
tags:
  - jq
  - QGIS
  - bash
  - JSON
  - GeoJSON
issue: [159]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

**Caso d'uso:** A partire da uno strano `JSON` con la seguente struttura:

```json
{
  "GEOMETRIA": [
    "{ \"type\": \"Polygon\", \"coordinates\": [ [ [15.2500005, 37.9353124], [15.2538586, 37.9353124], [15.2538586, 37.9384931], [15.2500005, 37.9384931], [15.2500005, 37.9353124] ] ] }"
  ]
}
```
creare un file `GeoJSON` fruibile con software GIS, come `QGIS` per esempio.

**L'idea di fondo**: osservare come è strutturato un file `GeoJSON` e ricrearlo partendo dai dati presenti nel file JSON.

## script bash

```bash
##!/bin/bash

set -x
# crea una cartella dentro la cartella principale
mkdir -p ./rawdata
# crea delle variabili
i1='{"type": "FeatureCollection","name":'
i2=',"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { }, "geometry":'
i3='}]}'
# elimina eventuali file
rm ./rawdata/out-*.json
# crea loop
for i in $(ls *.json); do
  # crea variabile e la popola con la parte geometrica del JSON
  geom=$(cat "$i" | jq -r '.[] | .[]' | sed -e "s/^\"//g" | sed -e "s/\"$//g")
  # effettua le sostituzioni e crea file file leggibile da software GIS
  echo -e "$i1 \"$i\"\n$i2$geom\n$i3" | jq . >./out-"$i"
done
```
## Risultato

```json
{
  "type": "FeatureCollection",
  "name": "ME-H405-1-1.json",
  "crs": {
    "type": "name",
    "properties": {
      "name": "urn:ogc:def:crs:OGC:1.3:CRS84"
    }
  },
  "features": [
    {
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Polygon",
        "coordinates": [
          [
            [
              15.2500005,
              37.9353124
            ],
            [
              15.2538586,
              37.9353124
            ],
            [
              15.2538586,
              37.9384931
            ],
            [
              15.2500005,
              37.9384931
            ],
            [
              15.2500005,
              37.9353124
            ]
          ]
        ]
      }
    }
  ]
}
```

## Dati

- file `JSON` scaricabili da [qui](https://github.com/opendatasicilia/tansignari/files/5397194/geo.zip)

## Riferimenti utili

- [**jq**](https://stedolan.github.io/jq/)
- [**geojson.io**](http://geojson.io/#map=2/20.0/0.0)
- [**QGIS**](https://qgis.org/it/site/)



