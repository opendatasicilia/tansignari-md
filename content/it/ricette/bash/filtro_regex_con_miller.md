---
title: "Filtro con espressione in Miller"
linkTitle: "Filtro con espressione in Miller"
date: 2023-02-11
description: >
  Filtro con espressione regolare in Miller.
tags:
  - bash
  - regex
  - Miller
  - csv
  - ciclo
issue: [243]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

Come applicare, in un filtro dentro l'utility Miller, una espressione regolare.

## Esempio

Supponendo di avere un file csv con enne record, per ogni record si presenta una delle parole `none`, `Polygon`, `Point` e `Line`, per filtrare i record che contengono queste parole, è molto utile usare un filtro con le espressioni regolari:

```
mlr --csv filter '$geom_type=~"^.{0,}Polygon.{0,}$"' out2.csv
```
questo filtro seleziona tutte le righe che nel campo `geom_type` è presente la parola `Polygon`

per gli altri casi:

```
mlr --csv filter '$geom_type=~"^.{0,}Pont.{0,}$"' out2.csv
mlr --csv filter '$geom_type=~"^.{0,}Line.{0,}$"' out2.csv
mlr --csv filter '$geom_type=~"^.{0,}none.{0,}$"' out2.csv
```
dove:
- `filter` è un verbo di Miller
- `$geom_type` richiamo l'attributo del file csv e che contiene i valori con cui filtrare;
- `=~"^.{0,}Pont.{0,}$"` espressione regolare, dove:
  - `^` parti dall'inizio del valore
  - `.{0,}` qualsiasi carattere, presente 0 o infinite volte, prima della parola in esame (è equivalente `.*`)
  - `$` fine valore
- `out2.csv` file di input 

per evitare di lanciare tre volte il comando, si potrebbe fare un ciclo:

```
for i in none Polygon Line Point;do
<out2.csv  mlr --csv filter '$geom_type=~"^.{0,}'"$i"'.{0,}$"' > classe_"$i".csv
done
```

## Dati

- [DBGT_10K_22_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401) file pesante +5 GB
- [out2.csv](https://github.com/opendatasicilia/tansignari/files/10713470/out2.csv)

## Riferimenti utili

- Miller (mlr): <https://miller.readthedocs.io/>
- [piccolo gioiello eterogeneità dati](https://arigadicomando.it/miller/eterogeneita_record/)

