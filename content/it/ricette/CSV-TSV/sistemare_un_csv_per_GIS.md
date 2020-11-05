---
title: "Come sistemare un CSV per farlo leggere ad un GIS"
linkTitle: "Come sistemare un CSV per farlo leggere ad un GIS"
date: 2020-05-16
description: >
  Come sistemare un file CSV per farlo leggere da un Software GIS.
tags:
  - csv
  - miller
  - sed
  - visidata
issue: [163]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

A partire da un file CSV cosi strutturato:

```
Layer,Text
ID_Punto,"127"
Coordinate,"1752571.62;5143346.69"
Quota,"1014.646"
ID_Punto,"126"
Coordinate,"1752553.60;5143363.05"
Quota,"1016.618"
```

ottenere un fil CSV facilmente leggibile da un Software GIS:

ID_Punto | Coordinate | Quota
-----------|-------------|---------
127 | 1752571.62;5143346.69 | 1014.646
126 | 1752553.60;5143363.05 | 1016.618

## Soluzione

```
<input.csv tail -n +2 | sed -r 's/ID_/\nID_/g;s/^(.+),(.+)$/\1 \2/;s/"//g' | mlr --x2c cat | vd -f csv
```

Sfrutto [Miller](https://miller.readthedocs.io/en/latest/index.html) che ha come formato di input e output l'XTAB, che è fatto così

```
ID_Punto   127
Coordinate 1752571.62;5143346.69
Quota      1014.646

ID_Punto   126
Coordinate 1752553.60;5143363.05
Quota      1016.618
```

Con il comando di sopra lo porto in XTAB e poi lo converto in CSV.

![](https://user-images.githubusercontent.com/7631137/98165220-c9fbd280-1ee5-11eb-925d-4c61b8354daa.png)

dove:

```
tail -n +2 : toglie intestazione;

sed -r 's/ID_/\nID_/g;s/^(.+),(.+)$/\1 \2/;s/"//g' : trova e sostituisci

 mlr --x2c cat : converte da XTAB a CSV

 vd -f csv : visualizzo con VisiData

```
## Riferimenti utili

1. [Visidata](http://visidata.org/man/)
2. [Guida Visidata ITA](https://github.com/ondata/guidaVisiData/blob/master/testo/README.md)
3. [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)
4. [sed](https://it.wikipedia.org/wiki/Sed_(Unix))