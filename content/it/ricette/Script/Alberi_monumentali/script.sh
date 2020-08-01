#!/bin/bash

### requisiti ###
# miller https://github.com/johnkerl/miller
# scrape https://github.com/aborruso/scrape-cli
# pyexcel-cli https://github.com/pyexcel/pyexcel-cli
# pyexcel-xls https://github.com/pyexcel/pyexcel-xls
# yq https://github.com/kislyuk/yq
# parallel https://www.gnu.org/software/parallel/
# ogr2ogr https://gdal.org/programs/ogr2ogr.html
### requisiti ###

set -x

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ./rawdata
mkdir -p ./processing

# cancella file
rm -r "$folder"/rawdata/*
rm -r "$folder"/processing/*

# scarica i file xls
curl "https://www.politicheagricole.it/flex/cm/pages/ServeBLOB.php/L/IT/IDPagina/11260" |
  # estrai dati sui file XLS degli alberi
  scrape -be ".blob-element-download .viewLinkIMG" |
  # estrai proprietà href e text (URL e nome file)
  xq -r '.html.body.a[]|[."@href",."#text"]|@tsv' |
  # fai partire il download
  parallel --colsep '\t' wget {1} -O ./rawdata/{2}.xls

# crea file CSV a partire dagli XLS scaricati
for i in "$folder"/rawdata/*.xls; do
  #crea una variabile da usare per estrarre nome e estensione
  filename=$(basename "$i")
  #estrai estensione
  extension="${filename##*.}"
  #estrai nome file
  filename="${filename%.*}"
  # converti file XLS in CSV
  pyexcel transcode --sheet-index 0 "$i" "$folder"/processing/"$filename".csv
done

# unisci i file CSV creati, tenendo conto di eventuali non omogeneità dello schema dati e fai pulizia di eventuali spazi bianchi in più
mlr --csv unsparsify then clean-whitespace "$folder"/processing/*.csv >"$folder"/alberi.csv

# dalle coordinate rimuovi spazi e sostituisci "," con "."
mlr -I --csv put '${LATITUDINE SU GIS}=gsub(${LATITUDINE SU GIS}," ","");${LONGITUDINE SU GIS}=gsub(${LONGITUDINE SU GIS}," ","");${LATITUDINE SU GIS}=gsub(${LATITUDINE SU GIS},",",".");${LONGITUDINE SU GIS}=gsub(${LONGITUDINE SU GIS},",",".")' "$folder"/alberi.csv

# crea colonne coordinate in formato 13d25'25, da usare successivamente per conversione in gradi decimali
mlr --csv put '$lat_dd=sub(${LATITUDINE SU GIS},"^([0-9]+)[^0-9]+([0-9]+)[^0-9]+([0-9]+\.?[0-9]*)[^0-9]*","\1d\2'\''\3");$lon_dd=sub(${LONGITUDINE SU GIS},"^([0-9]+)[^0-9]+([0-9]+)[^0-9]+([0-9]+\.?[0-9]*)[^0-9]*","\1d\2'\''\3")' "$folder"/alberi.csv >"$folder"/processing/alberi.csv

# estrai un file con le sole due colonne di coordinate create sopra
mlr --csv cut -f "lat_dd","lon_dd" "$folder"/processing/alberi.csv >"$folder"/processing/albLL.csv

# converti il file albLL.csv in un CSV separato da spazi senza intestazione
mlr --c2n cat "$folder"/processing/albLL.csv >"$folder"/processing/albLL.txt

# crea file con conversione coordinate del file albLL.txt da DDMMSS a decimal degrees
cs2cs -f '%.6f' +proj=latlong +datum=WGS84 +to +proj=latlong +datum=WGS84 "$folder"/processing/albLL.txt | tr " " "\t" >"$folder"/processing/albLLdd

# converti in CSV e aggiungi intestazione al file albLLdd
mlr -I --implicit-csv-header --t2c label y,x,z then cut -x -f z "$folder"/processing/albLLdd

# aggiungi campo ID al file con le coordinate in decimal degrees
mlr -I --csv cat -N id "$folder"/processing/albLLdd

# aggiungi campo ID al file degli alberi
mlr -I --csv cat -N id "$folder"/processing/alberi.csv

# aggiungi al file degli alberi le coordinate in decimal degrees, tramite JOIN con albLLdd
mlr --csv join -j id -f "$folder"/processing/alberi.csv then cut -x -f "lat_dd","lon_dd" "$folder"/processing/albLLdd >"$folder"/alberi.csv

# converti il file CSV degli alberi in GeoJSON
ogr2ogr -f geojson "$folder"/alberi.geojson "$folder"/alberi.csv -oo X_POSSIBLE_NAMES=x -oo Y_POSSIBLE_NAMES=y

# scarica limiti comunali ISTAT
curl -Lk "http://www.istat.it/storage/cartografia/confini_amministrativi/non_generalizzati/Limiti01012020.zip" >"$folder"/rawdata/Limiti01012020.zip

# unzippa i limiti comunali ISTAT
cd "$folder"/rawdata
unzip "$folder"/rawdata/Limiti01012020.zip

# riproietta limiti comunali ISTAT da EPSG 32632  a EPSG 4326
mapshaper "$folder"/rawdata/Limiti01012020/Com01012020/Com01012020_WGS84.shp -proj wgs84 -o "$folder"/processing/comuni.shp

# aggiungi codice ISTAT dei comuni al CSV degli alberi
mapshaper "$folder"/alberi.geojson -join "$folder"/processing/comuni.shp fields=PRO_COM_T -o "$folder"/alberiMonumentaliISTAT.csv