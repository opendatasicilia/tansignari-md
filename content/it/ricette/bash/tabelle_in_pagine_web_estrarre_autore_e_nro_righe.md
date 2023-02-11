---
title: "Estrarre autore e numero righe da tabelle in pagine web"
linkTitle: "Estrarre autore e numero righe da tabelle in pagine web"
date: 2022-10-05
description: >
  Come estrarre autore e numero righe da tabelle presenti in pagine web.
tags:
  - bash
  - csv/tsv
  - miller
  - scrape
  - xq
  - XPATH
  - script
  - HTML
issue: [228]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

In queste pagine [web](https://www.qgis.org/en/site/forusers/visualchangelog326/index.html#notable-fixes) al paragrafo `Notable Fixes`, ci sono delle tabelle, una sotto l'altra, con varie righe e colonne; ogni tabella è caratterizzata da un numero di righe, da un autore e da chi ha finanziato la risoluzione dei bug, sotto un esempio:

![image](https://user-images.githubusercontent.com/7631137/194062758-3b54650d-8877-46ff-bc59-2e10e023489d.png)

come estrarre, per ogni tabella, il numero di righe, autore e finanziatore?

sotto un esempio di output

Bugs fixed by | These bugfixes were funded by | numero righe
---------------|------------------------------------|---------------
Even Rouault | QGIS.ORG (through donations and sustaining memberships) | 15
Alessandro Pasotti | QGIS.ORG (through donations and sustaining memberships) | 18

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

URL="https://www.qgis.org/en/site/forusers/visualchangelog326/index.html#notable-fixes"

# scarica pagina
curl -kL "$URL" >"$folder"/tmp.html

# estrai id persone
scrape <"$folder"/tmp.html -be '//section[@id="notable-fixes"]/section' | xq -r '.html.body.section[]."@id"' >"$folder"/toto-id.txt

if [ -f "$folder"/toto.jsonl ]; then
  rm "$folder"/toto.jsonl
fi

# per ogni utente estrai dati
while read id; do
  nome=$(scrape <"$folder"/tmp.html -e '//section[@id="'"$id"'"]/h3/a[1]/text()' | sed -r 's/^.+by *//')
  numeroRighe=$(scrape <"$folder"/tmp.html -be '//section[@id="'"$id"'"]/table/tbody/tr' | xq '.html.body.tr|length')
  funded=$(scrape <"$folder"/tmp.html -be '//section[@id="'"$id"'"]//p[contains(.,"funded")]' | xq -r '(.html.body.p."#text")+""+(.html.body.p.a."#text")')
  echo '{"nome":"'"$nome"'","numeroRighe":"'"$numeroRighe"'","funded":"'"$funded"'"}' >>"$folder"/toto.jsonl
done <"$folder"/toto-id.txt

mlr --j2c clean-whitespace "$folder"/toto.jsonl >"$folder"/toto.csv
```

per fare girare lo script su varie pagine web:

```sh
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# crea variabile con lista degli URL
LINK="https://www.qgis.org/en/site/forusers/visualchangelog36/index.html
https://www.qgis.org/en/site/forusers/visualchangelog38/index.html
https://www.qgis.org/en/site/forusers/visualchangelog310/index.html
https://www.qgis.org/en/site/forusers/visualchangelog312/index.html
https://www.qgis.org/en/site/forusers/visualchangelog314/index.html
https://www.qgis.org/en/site/forusers/visualchangelog316/index.html
https://www.qgis.org/en/site/forusers/visualchangelog318/index.html
https://www.qgis.org/en/site/forusers/visualchangelog320/index.html
https://www.qgis.org/en/site/forusers/visualchangelog322/index.html
https://www.qgis.org/en/site/forusers/visualchangelog324/index.html
https://www.qgis.org/en/site/forusers/visualchangelog326/index.html
https://www.qgis.org/en/site/forusers/visualchangelog328/index.html"

# crea ciclo con le pagine web

for lista in $LINK
do

# scarica pagina
	curl -kL "$lista" >"$folder"/tmp.html

# estrai id persone
	scrape <"$folder"/tmp.html -be '//section[@id="notable-fixes"]/section' | xq -r '.html.body.section[]."@id"' >"$folder"/toto-id.txt

# per ogni utente estrai dati
	while read id; do
		version=`echo "$lista" | sed -e 's/[^0-9]//g' | sed -e 's/^/QGIS /' | sed -e 's/QGIS 3/QGIS 3./'`
		developer=$(scrape <"$folder"/tmp.html -e '//section[@id="'"$id"'"]/h3/a[1]/text()' | sed -r 's/^.+by *//')
		nroBugsFixes=$(scrape <"$folder"/tmp.html -be '//section[@id="'"$id"'"]/table/tbody/tr' | xq '.html.body.tr|length')
		funded=$(scrape <"$folder"/tmp.html -be '//section[@id="'"$id"'"]//p[contains(.,"funded")]' | xq -r '(.html.body.p."#text")+""+(.html.body.p.a."#text")')
		data=`grep 'Release date:' "$folder"/tmp.html | sed -e 's/[^0-9-]//g'`
		echo '{"data":"'"$data"'","version":"'"$version"'","developer":"'"$developer"'","nroBugsFixes":"'"$nroBugsFixes"'","funded":"'"$funded"'"}' >>"$folder"/toto.jsonl
	done <"$folder"/toto-id.txt
	
	if [ -f "$folder"/toto-id.txt ]; then
	rm "$folder"/toto-id.txt
	fi
done

# ripulire il file jsonl dalla presenza di tab \t
sed -i 's/\t//g' "$folder"/toto.jsonl

# converte da jsonl a CSV
mlr --j2c clean-whitespace "$folder"/toto.jsonl >>"$folder"/toto.csv

# rimuove file non piu' utili
rm tmp.*
rm *.jsonl
```

![image](https://user-images.githubusercontent.com/7631137/218273445-61daedc7-727d-4e8e-8233-607968601567.png)

## Riferimenti utili

- [scrape](https://github.com/aborruso/scrape-cli)
- [xq](https://github.com/kislyuk/yq)
- [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)
