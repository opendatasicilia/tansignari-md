---
title: "Istogramma zonale"
linkTitle: "Istogramma zonale"
date: 2024-01-12
description: >
  Dato un raster e un vettore poligonale, aggiungere in coda alla tabella degli attributi del vettore, campi contenenti i conteggi di ogni valore univoco presenti nel raster.
tags:
  - raster
  - vettore
  - statistiche
  - python
  - QGIS
issue: [258]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso", "Totò Fiandaca"]
---

Questa ricetta risolve un problema specifico ma facilmente generalizzabile per chi lavora spesso con _raster_ e _vettori_ e ha bisogno di estrarre statistiche o istogrammi zonali.

## Quesito

Dopo aver estratto da un DTM la pendenza: 

1. raster delle pendenze riclassificato con valori 1,2,3,4;
2. vettore poligonale che copre il raster;
3. QUESITO: che tool/procedura usare per calcolare una sorta di statistiche zonali? ovvero: al poligonale come aggiungere 4 attributi (pend_1, pend_2, pend_3 e pend_4) e popolarli con il conteggio dei relativi valori dei pixel che vi ricadono dentro (pend_1 = conteggio dei soli pixel con valore 1; pend_2 = conteggio dei soli pixel con valore 2 e cosi via);

sotto uno screenshot:

![image](https://github.com/opendatasicilia/tansignari/assets/7631137/8bb4800a-923d-475c-89da-b0547efa6bfb)

## Python

Soluzione brillante con python, occorre installare alcune librerie come `rasterio`, `geopandas` e `rasterstats` e poi lanciare lo script da bash: `python3 nomescript.py`

i dati di _input_ e _output_ sono definiti dentro lo script.

```py
import rasterio
import geopandas as gpd
from rasterstats import zonal_stats
import os

input_raster = 'testOneR.tif'
input_shapefile = 'zone.shp'
output_shapefile = 'output_shapefile.shp'

# Carica lo shapefile
gdf = gpd.read_file(input_shapefile)

# Loop per i valori dei pixel da 1 a 4
for value in range(1, 5):
    temp_raster_file = f'temp_raster_{value}.tif'
    
    # Crea un raster temporaneo per ogni valore
    with rasterio.open(input_raster) as src:
        data = src.read(1)
        data[data != value] = src.nodata
        profile = src.profile
        with rasterio.open(temp_raster_file, 'w', **profile) as dst:
            dst.write(data, 1)

    # Calcola le statistiche zonali
    stats = zonal_stats(input_shapefile, temp_raster_file, stats="count")
    gdf[f'pend_{value}'] = [stat['count'] if stat else None for stat in stats]

    # Rimuovi il file temporaneo
    os.remove(temp_raster_file)

# Salva il nuovo shapefile con le colonne aggiunte
gdf.to_file(output_shapefile)
```

## QGIS

per chi usasse solo _**QGIS**_, la soluzione immediata è un algoritmo presente nel core di _**QGIS**_ tra gli strumenti di _Processing_: [Istogramma zonale](https://docs.qgis.org/3.28/en/docs/user_manual/processing_algs/qgis/rasteranalysis.html#qgiszonalhistogram)

![image](https://github.com/opendatasicilia/tansignari/assets/7631137/47fb96a2-d052-4e45-85b2-eabcf4394604)

restituisce un altro shapefile con i 4 campi popolati:

![image](https://github.com/opendatasicilia/tansignari/assets/7631137/f03c8217-5a36-480c-a3d8-2d5ee34691ae)

## rio e zonalstasts

dopo aver installato le librerie python viste sopra, è possibile lanciare (sotto per bash) il seguente codice avendo cura di usare come vettore il formato `geojson`

```sh
rio zonalstats --categorical zone.geojson prefix Andrea_ -r testOneR.tif >out.geojson
```

![image](https://github.com/opendatasicilia/tansignari/assets/7631137/c3121c90-d85c-4b8b-bef0-81fe1a8c08cc)

## dati di esempio

[dati](https://github.com/opendatasicilia/tansignari/files/13907925/zonal.zip)

# RIFERIMENTI

- https://www.python.org/
- https://geopandas.org/en/stable/
- https://pythonhosted.org/rasterstats/cli.html?highlight=command#command-line-interface
- https://www.qgis.org/it/site/
- https://docs.qgis.org/3.28/en/docs/user_manual/processing_algs/qgis/rasteranalysis.html#qgiszonalhistogram
