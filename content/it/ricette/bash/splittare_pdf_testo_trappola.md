---
title: "Dividere un PDF usando un testo trappola"
linkTitle: "Splittare un PDF usando un testo trappola"
date: 2024-03-24
description: >
  Dividere un file PDF usando un testo trappola presente nella stampe.
tags:
  - bash
  - regex
  - Miller
  - csv
  - ciclo
  - grep
  - PDF
issue: [259]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Dividere un file PDF generato da un atlante di QGIS usando un testo trappola opportunamente creato.

Il testo è : `ANDREA:testo_variabile`

dove:

- `ANDREA`: è una stringa fissa;
- `testo_variabile`: è appunto un testo variabile (senza spazi o caratteri speciali)
- in output: tutte le pagine del PDF che hanno stesso `testo_variabile` devono confluire in un unico PDF e quindi ottenere enne PDF multipagina.

## Soluzione

```sh
#!/bin/bash

set -x
set -e
set -u
set -o pipefail

# if out exists, remove it
if [ ! -f out.txt ]; then
  pdfgrep -n -o "ANDREA:[^ ]*" input.pdf >out.txt
fi

mlr --icsv --ojsonl --implicit-csv-header --ifs ":" label p,trappola,file then nest --ivar " " -f p out.txt >out.jsonl

while read -r line; do
  pagine=$(echo "$line" | jq -r .p)
  file=$(echo "$line" | jq -r .file)

  eval pdftk input.pdf cat $pagine output "$file".pdf
done <out.jsonl
```

## Approfondimenti

1. estrarre un elenco di pagine con quel testo trappola, e poi usare quell'elenco per estrarre le varie parti; A riga di comando è utile **_pdfgrep_**. Un comando "tipo" è

`pdfgrep -n -o "ANDREA:[^ ]*" input.pdf >out.txt`

In output qualcosa come quello di sotto, in cui il numero iniziale è il numero di pagina:

```
1:ANDREA:Reggio_di_Calabria
2:ANDREA:Reggio_di_Calabria
3:ANDREA:Catania
4:ANDREA:Catania
5:ANDREA:Catania
```

2. Poi si potrebbe creare un jsonline, che è comodo per i loop per riga. Perché il jsonline è un formato in cui ogni linea è un oggetto json; usando miller:

```sh
mlr --icsv --ojsonl --implicit-csv-header --ifs ":" label p,trappola,file then nest --ivar " " -f p out.txt >out.jsonl
```

Che in output dà:

```
{"p": "1 2", "trappola": "ANDREA", "file": "Reggio_di_Calabria"}
{"p": "3 4 5", "trappola": "ANDREA", "file": "Catania"}
```

Ora abbiamo i dati per "stampare" i PDF a partire dalle relative pagine del PDF di input. Un tool è _**pdftk**_ e il comando per stampare le pagine 1 e 2 (dell'esempio) in nuovo file è:

- `pdftk input.pdf cat 1 2 output Reggio_di_Calabria.pdf`
- `pdftk input.pdf cat 3 4 5 output Catania.pdf`

Non resta che inserire tutto in un loop di bash.

NB: per PDF di alta qualità e numero elevato di pagine, lo script può impiegare anche ore.

## Riferimenti utili

- Miller (mlr): <https://miller.readthedocs.io/>
- pdfgrep: <https://pdfgrep.org/>
- pdftk: <https://wiki.ubuntu-it.org/Ufficio/Pdftk>
- jq: <https://jqlang.github.io/jq/>
- QGIS: <https://www.qgis.org/it/site/>
