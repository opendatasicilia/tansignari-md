---
title: "Ordinare elementi di un array"
linkTitle: "Ordinare elementi di un array alfanumerico"
date: 2022-01-13
description: >
 Ordinare numericamente gli elementi di un array alfanumerico.
tags:
  - script
  - bash
  - miller
  - CSV/TSV
  - array
  - QGIS
  - field calc
issue: [196]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso" , "Giovanni Pirrotta" , "Totò Fiandaca"]
---

---

## caso d'uso

Lista numeri civici di una strada: ordinare la seguente lista `2,2/B,2/A,1,3` in modo da ottenere `1,2,2/A,2/B,3`, ovvero ordinarla numericamente anche se ha elementi alfanumerici.

## script bash

```bash
mlr --csv nest --explode --values --across-records -f scritta --nested-fs "-" then \
put -S '$totoN=regextract($scritta,"[0-9]+");$totoT=regextract($scritta,"[a-zA-Z]+")' then \
unsparsify then sort -f den_estesa -n totoN -f totoT then cut -r -x -f "toto+" then \
nest --implode --values --across-records --nested-fs "-" -f scritta  ordinare_scritta.csv
```

ragionamento:

lo script mette tutto in colonne splittando il campo `scritta` usando come delimitatore `-` e popolando due nuove colonne `totoN` (numeri) e `totoT` (testo) con la parte numerica e la parte testuale di ogni elemento; successivamente ordina usando i campi `den_estesa`, `totoN` e `totoT`, a questo punto elimina i campi in più (`toto+`) e poi torna indietro implodendo tutto.

nota: con Miller 5

esempio:

![](https://user-images.githubusercontent.com/7631137/149374235-c0791747-d962-4f67-8a7f-b3ddf1b1704b.png)

risultato:

![](https://user-images.githubusercontent.com/7631137/149384324-d59e6837-ac44-4d7a-8506-d31c339f10b0.png)

## script python

### prima versione

```py
import pandas as pd
df = pd.read_csv('ordinare_scritta.csv')
df['scritta']=df.scritta.map(lambda x: 
                             "-".join([item.replace('/0','') 
                             for item in [item[1:] if item[0]=='0' else item 
                             for item in sorted([t.zfill(2)+"/0" if t.isdigit() else t 
                             for t in [f'0{t}' if t.find('/')==1 else t 
                             for t in x.split('-')]], key=str)]]))   
df.to_csv('ordina_scritta_ok.csv',index=False)
```
### seconda versione

```py
import pandas as pd
df = pd.read_csv('ordinare_scritta.csv')
def ordina(x):
    tmp = x.split('-')
    a = [f"0{t}" if t.find('/')==1 else t for t in tmp]
    b = [t.zfill(2)+"/0" if t.isdigit() else t for t in a]
    tmp2=sorted(b, key=str)
    first_ord = [item[1:] if item[0]=='0' else item for item in tmp2]
    second_ord =  [item.replace('/0','') for item in first_ord]
    return "-".join(second_ord)
    
df['scritta']=df.scritta.map(ordina)   
df.to_csv('ordina_scritta_ok.csv',index=False)
```
## espressione di QGIS

```py
array_to_string(
array_foreach(
	array_sort(
		with_variable('lista',
			string_to_array('5/A-5-4-8-3-14-6-9-7-1-10-7/B-2-7/A' ,'-'),
			array_foreach(generate_series(0, array_length(@lista)-1),
			lpad(regexp_substr( (@lista[@element]),'(\\d+)'),3,'0')
			||'|'||
			if(regexp_substr((@lista[@element]),'([a-zA-Z/]+)') !='',
			   regexp_substr((@lista[@element]),'([a-zA-Z/]+)'),
			   '/A')
			||'|'||
			@lista[@element]))),
regexp_replace( @element,'^.+\\|(.+)$','\\1'))
)
```
![](https://user-images.githubusercontent.com/7631137/149572994-80c4adbb-9d90-4894-9b6d-19eb4b178cd4.png)

## Riferimenti utili

- [**Miller**](https://github.com/johnkerl/miller)
- [**Python**](https://www.python.org/)
- [**QGIS**](https://www.qgis.org/it/site/)