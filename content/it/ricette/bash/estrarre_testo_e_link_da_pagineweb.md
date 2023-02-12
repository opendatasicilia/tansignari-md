---
title: "Estrarre testo e link da pagine web"
linkTitle: "Estrarre testo e link da pagine web e creare un file CSV"
date: 2022-09-28
description: >
  Come estrarre testo e link da pagine web e creare un file CSV.
tags:
  - bash
  - csv/tsv
  - miller
  - scrape
  - xq
  - XPATH
  - script
  - HTML
issue: [227]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso","Totò Fiandaca"]
---

---

## Caso d'uso

Pagina web come [questa](https://www.qgis.org/en/site/forusers/visualchangelog326/index.html), ci sono varie sezioni (1), (2) e (3)

![image](https://user-images.githubusercontent.com/7631137/192874979-484d2daf-3978-42ad-bd5e-496cdc689f92.png)

come estrarre la riga al punto (1) con link, e le righe (2) e (3)?

esempio a partire dallo scresnshot di sopra:

```
Feature: Horizontal table scroll with shift+wheel
(https://www.qgis.org/en/site/forusers/visualchangelog326/index.html#id12)

funded by the City of Canning
developed by Nyall Dawson (North Road Consulting)
```

e creare una tabella, perché nella pagina web ci sono molte feature

descrizione | link | funded by | developer by
-------------|-----|-------------|-------------
Feature: Horizontal table scroll with shift+wheel | https://www.qgis.org/en/site/forusers/visualchangelog326/index.html#id12 | the City of Canning | Nyall Dawson (North Road Consulting)

### Soluzione

Per questo tipo di task, occorre imparare a fare query **XPATH** o **CSS Selector**.

Poi occorre guardare la struttura della pagina, capire se c'è qualche elemento utile per distinguere la parte di tuo interesse da tutto il resto.

La parte di interesse è dentro un tag `section` con `id="notable-fixes"`.

La query **XPATH** per selezionare quella parte è `//section[@id="notable-fixes"]`, che vuol dire: trova un tag `section` ovunque nella pagina, ma che abbia come `id` il valore `notable-fixes`.
Queste query possono essere testare anche nel browser:

![image](https://user-images.githubusercontent.com/30607/194418291-328022d9-6f52-41f7-bfb8-46095c159771.png)

Un altro elemento interessante di questa struttura **HTML** è che per ogni user, c'è una sub sezione con id uguale al nome dell'user:

![image](https://user-images.githubusercontent.com/30607/194418892-c742d92c-fa45-45ee-9591-54aa851a7c63.png)

Sotto uno script bash, che per grandi linee fa questo:

- scarica la pagina;
- scarica l'elenco degli id degli user

```
bug-fixes-by-even-rouault
bug-fixes-by-alessandro-pasotti
bug-fixes-by-alex-bruy
bug-fixes-by-sandro-santilli
bug-fixes-by-nyall-dawson
```
- per ognuno di questi **id**:
  - estrae il nome dello user;
  - conta il numero di righe di ogni tabella;
  - estrare la frase sul chi ha finanziato;
  - crea una linea in formato JSON;

```JSON
{"nome":"Even Rouault   ","numeroRighe":"16","funded":"These bugfixes were funded byQGIS.ORG (through donations and sustaining memberships)"}
```

- e infine converte il tutto in **CSV**:

```
nome,numeroRighe,funded
Even Rouault,15,These bugfixes were funded byQGIS.ORG (through donations and sustaining memberships)
Alessandro Pasotti,18,These bugfixes were funded byQGIS.ORG (through donations and sustaining memberships)
Alex Bruy,11,These bugfixes were funded byQGIS.ORG (through donations and sustaining memberships)
Sandro Santilli,11,These bugfixes were funded byQGIS.ORG (through donations and sustaining memberships)
Nyall Dawson,38,These bugfixes were funded byQGIS.ORG (through donations and sustaining memberships)
```

Come tool uso **scrape** (per le query **XPATH**), **Miller**, e **xq**.


```bash
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

LINK="https://www.qgis.org/en/site/forusers/visualchangelog30/index.html
https://www.qgis.org/en/site/forusers/visualchangelog32/index.html
https://www.qgis.org/en/site/forusers/visualchangelog34/index.html
https://www.qgis.org/en/site/forusers/visualchangelog36/index.html
https://www.qgis.org/en/site/forusers/visualchangelog38/index.html
https://www.qgis.org/en/site/forusers/visualchangelog310/index.html
https://www.qgis.org/en/site/forusers/visualchangelog312/index.html
https://www.qgis.org/en/site/forusers/visualchangelog314/index.html
https://www.qgis.org/en/site/forusers/visualchangelog318/index.html
https://www.qgis.org/en/site/forusers/visualchangelog320/index.html
https://www.qgis.org/en/site/forusers/visualchangelog322/index.html
https://www.qgis.org/en/site/forusers/visualchangelog324/index.html
https://www.qgis.org/en/site/forusers/visualchangelog326/index.html
https://www.qgis.org/en/site/forusers/visualchangelog316/index.html"


# crea ciclo con le pagine web
for lista in $LINK
do
# scarica pagina
	curl -kL "$lista" >"$folder"/tmp.html
# estrae versione
    version=`echo "$lista" | sed -e 's/[^0-9]//g' | sed -e 's/^/QGIS/' | sed -e 's/QGIS3/QGIS3-/'`
	
# estrai le sezioni che contengono feture e non (purtroppo la 3.16 non inizia la sezione con feature)
	scrape <"$folder"/tmp.html -be '//section[contains(@id,"")]' | xq -r '.html.body.section[]."@id"' >"$folder"/toto-feature$version.txt
	if [ -f "$folder"/toto-featureQGIS3-16.txt ]; then
		mv toto-featureQGIS3-16.txt toto-featureQGIS3-16-pulito.txt
	else 
		<./toto-feature$version.txt grep -P '^feature-' >toto-feature$version-pulito.txt
	fi
	
	
# per ogni feature estrai dati
	while read id; do
		version=`echo "$lista" | sed -e 's/[^0-9]//g' | sed -e 's/^/QGIS /' | sed -e 's/QGIS 3/QGIS 3./'`
		feature=$(scrape <"$folder"/tmp.html -e '//section[@id="'"$id"'"]/h3/a[1]/text()' | sed -r 's/^.+by *//')
	#	argomento=$(scrape <"$folder"/tmp.html -e '//section[@id="'"$id"'"]/h2/a[1]/text()')
	 	developed=$(scrape <"$folder"/tmp.html -e '//section[@id="'"$id"'"]//p[contains(.,"developed b")]' | sed -r 's/.+(">)(.+)(<\/a><\/p>)/\2/g')
	 	funded=$(scrape <"$folder"/tmp.html -e '//section[@id="'"$id"'"]//p[contains(.,"funded b")]' | sed -r 's/.+(">)(.+)(<\/a><\/p>)/\2/g')
		data=`grep 'Release date:' "$folder"/tmp.html | sed -e 's/[^0-9-]//g'`
		echo '{"data":"'"$data"'","version":"'"$version"'","feature":"'"$feature"'","developed":"'"$developed"'","funded":"'"$funded"'"}' >>"$folder"/toto.jsonl
	done <"$folder"/toto-feature$version-pulito.txt
done
# ripulire il file jsonl dalla presenza di tab \t
sed -i 's/\t//g' "$folder"/toto.jsonl
# converte jsonl in csv e sistema bene le colonne
mlr --j2c clean-whitespace "$folder"/toto.jsonl >"$folder"/totoFeatureALL.csv
```

![image](https://user-images.githubusercontent.com/7631137/218302825-37f158e6-8d15-40d4-b574-633a54d7b62c.png)

## Riferimenti utili

- [scrape](https://github.com/aborruso/scrape-cli)
- [xq](https://github.com/kislyuk/yq)
- [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)