---
title: "Come rimuovere righe con 'Totale'"
linkTitle: "Rimuovere righe con 'Totale'"
date: 2022-05-19
description: >
  Rimuovere da un CSV fastidiose righe contenenti il 'Totale'
tags:
  - csv
  - tsv
  - csv-tsv
  - miller
  - riga di comando
  - visidata
  - pandas
  - python
  - istat
issue: [213]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

Alcuni file CSV pubblicati da ISTAT (come [questo](https://demo.istat.it/pop2018/dati/Enna.zip)) contengono delle fastidiose righe con il 'Totale' (ad esempio della popolazione in un determinato comune in un determinato anno).

Osservando l'head del file sopra linkato
```
Popolazione residente al 1° Gennaio 2018 per età sesso e stato civile
"Provincia:","Enna","Codice Provincia:","086"
"Codice comune","Denominazione","Età","Maschi celibi","Maschi coniugati","Maschi divorziati","Maschi vedovi","Maschi uniti civilmente","Maschi già in unione civile (per scioglimento)","Maschi già in unione civile (per decesso del partner)","Totale Maschi","Femmine nubili","Femmine coniugate","Femmine divorziate","Femmine vedove","Femmine unite civilmente","Femmine già in unione civile (per scioglimento)","Femmine già in unione civile (per decesso del partner)","Totale Femmine"
"086001","Agira",0,40,0,0,0,,,,40,20,0,0,0,,,,20
"086001","Agira",1,38,0,0,0,,,,38,38,0,0,0,,,,38
"086001","Agira",2,38,0,0,0,,,,38,27,0,0,0,,,,27
```
notiamo che è necessario rimuovere anche le prime due righe. Di seguito si descrivono le "diverse strade" che è possibile percorrere per ottenere il risultato desiderato.

### Metodo 1 (bash)
Rimuoviamo le prime due righe con
```bash
<Enna.csv tail -n +3
```
e otteniamo un file simile a questo

|Codice comune|Denominazione|Età   |Maschi celibi|Maschi coniugati|Maschi divorziati|Maschi vedovi|Maschi uniti civilmente|Maschi già in unione civile (per scioglimento)|Maschi già in unione civile (per decesso del partner)|Totale Maschi|Femmine nubili|Femmine coniugate|Femmine divorziate|Femmine vedove|Femmine unite civilmente|Femmine già in unione civile (per scioglimento)|Femmine già in unione civile (per decesso del partner)|Totale Femmine|
|-------------|-------------|------|-------------|----------------|-----------------|-------------|-----------------------|----------------------------------------------|-----------------------------------------------------|-------------|--------------|-----------------|------------------|--------------|------------------------|-----------------------------------------------|------------------------------------------------------|--------------|
|086001       |Agira        |0     |40           |0               |0                |0            |                       |                                              |                                                     |40           |20            |0                |0                 |0             |                        |                                               |                                                      |20            |
|086001       |Agira        |1     |38           |0               |0                |0            |                       |                                              |                                                     |38           |38            |0                |0                 |0             |                        |                                               |                                                      |38            |
|....         |...          |...   |...          |...             |...              |...          |...                    |...                                           |...                                                  |...          |...           |...              |...               |...           |...                     |...                                            |...                                                   |...           |
|086001       |Agira        |Totale|1871         |2051            |26               |106          |                       |                                              |                                                     |4054         |1547          |2042             |44                |535           |                        |                                               |                                                      |4168          |

Procediamo adesso alla rimozione della riga contente il 'Totale' usando `grep`; includiamo anche il comando precedente tramite il *pipe* (`|`) per rimuovere sia le prime due righe che le righe con il 'Totale'

```bash
<Enna.csv grep -v ',Tota' | tail -n +3 > output.csv
```

### Metodo 2 (bash)
È possibile utilizzare la utility [*miller*](https://github.com/johnkerl/miller) per filtrare i valori della colonna `Età` come di seguito illustrato
```bash
# salta le prime tre righe
<Enna.csv tail -n +3  | \
# estrai ciò che non contiene "Totale" in Età (-x restituisce tutto ciò che non soddisfa il filtro)
mlr  --csv filter -x '$Età=="Totale"'
```

### Metodo 3 (python)
Sfruttiamo *python* e [*pandas*](https://pandas.pydata.org)
    
```python
import pandas as pd
df = pd.read_csv('Enna.csv', header=2)
df2 = df.drop(df[df['Età'] == "Totale"].index)
df2.to_csv('Enna_clean.csv', index=False)
```

### Metodo 4 (visidata)
Alternativa con [VisiData](https://ondata.github.io/guidaVisiData/)

```
# salta le prime tre righe e apri file con VisiData
<Enna.csv tail -n +3  | vd -f csv
```

all'interno di VisiData:
1. posizionati nella colonna `Eta` usando i tasti freccia;
2. digita da tastiera `|`
3. scrivi semplicemente `Tota` e pigia invio (hai selezionato tutte le righe che contengono, in Eta, un testo Tota)
4. digita `g` e poi `d` per eliminare le righe selezionate
5. infine, digita `ctrl +s` per salvare

## Riferimenti

- **Miller** : <https://github.com/johnkerl/miller>
- **Pandas** : <https://pandas.pydata.org>
- **Visidata**: <https://www.visidata.org/>
