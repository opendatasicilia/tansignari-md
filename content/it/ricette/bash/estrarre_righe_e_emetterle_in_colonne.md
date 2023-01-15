---
title: "Estrarre righe e metterle in colonne"
linkTitle: "Estrarre delle righe da un lungo testo e ordinarle in colonne"
date: 2020-12-15
description: >
  Come estrarre delle righe da un lungo testo e sistemarle in colonne diverse.
tags:
  - bash
  - csv/tsv
  - miller
  - script
issue: [234]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Caso d'uso

File testuale (il file è il risultato del comando `ogrinfo -al -so DBGT_10K_22_V01.gdb`) con migliaia di righe, come estrarre le sole righe che iniziano con 
- `Layer name`
- `Feature count`
- `Geometry`
e creare un file csv con la seguente struttura:

layer_name | feature_count | geometry
-------------|----------------|-----------
pippo | 123 | None
pluto  | 12345 | 3D Multi Polygon

### Soluzione con Miller

```
# estrai soltanto le righe che servono e le righe bianche
<cucu_dbgt.csv grep -P '^(Layer na.+|Geometry:.+|Feature Count:.+|.{0,1})$' | \
# converti output in CSV
mlr --x2c --ips : clean-whitespace >cucu_dbgt_a.csv
```

Il comando miller:

- `--x2c`, per fissare come formato di input l'XTAB e come output il CSV
- `--ips :`, per fissare come separatore di coppie chiave valore, in input, i `:`
- `clean-whitespace`, per rimuovere spazi ridondanti.

ottimo risultato:

![](https://user-images.githubusercontent.com/7631137/206661419-31b44f0e-d403-4a05-8d9e-669de081919b.png)

## Riferimenti utili

- [DGBT_10k_2022_V01.gdb](https://www.sardegnageoportale.it/index.php?xsl=2420&s=40&v=9&c=95645&es=6603&na=1&n=100&esp=1&tb=14401)
- [cucu_dbgt.csv](https://github.com/opendatasicilia/tansignari/files/10192656/cucu_dbgt.csv)
- [Miller](http://johnkerl.org/miller/doc/reference-verbs.html#nest)
