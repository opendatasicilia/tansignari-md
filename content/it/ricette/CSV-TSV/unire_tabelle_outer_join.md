---
title: "Unione di tabelle senza perdita di dati"
linkTitle: "Unione di tabelle senza perdita di dati"
date: 2024-07-25
description: >
  Unire due tabelle con numero di righe diverse e senza perdere dati.
tags:
  - csv/tsv
  - join
  - visidata
  - duckdb
  - miller
issue: [262]
chefs: ["Totò Fiandaca"]
guide: ["Totò Fiandaca","Andrea Borruso"]
---

---

## Caso d'uso

Ho due tabelle con stessa struttura dati ma numero di righe diverse, devo fare una join tabellare usando due attributi per tabella, nella prima tabella _COMUNE_IST e Cls_LivI_03_ e nella seconda tabella _COMUNE_IST e Cls_LivI_08_, ma le corrispondenze delle righe non è detto che siano uguali e quindi non posso usare una _left join_ e neanche una _rigth join_ altrimenti perderei delle righe.

tabella 03

COMUNE_IST|Sup_03ha|Cls_LivI_03
----------|--------|--------
090002|6.167764657014888|5
090002|4418.695029356092|3
090002|476.4773446171668|2
090002|47.60749054979091|1
090003|2.986054141487481|5
090003|2040.7894682171927|3
090003|2560.784034003995|2
090003|143.04663460051736|1
090003|3.0119929195484842|0

tabella_08

COMUNE_IST|Sup_08ha|Cls_LivI_08
----------|--------|--------
090002|4375.534226015951|3
090002|490.3999413012836|2
090002|83.01346186282966|1
090003|0.012633751875882445|0
090003|541.9179878095715|1
090003|1823.7816133090548|3
090003|2370.0713866133647|2
090003|3.072883214239986|5
090003|11.76167918463312|4

come ottenere la tabella unione come quella di sotto?

COMUNE_IST|Cls_LivI_03|Sup_08ha|Sup_03ha
----------|-----------|---------|------
090002|3|4375.53422601595|4418.69502935609
090002|2|490.399941301284|476.477344617167
090002|1|83.0134618628297|47.6074905497909
090002|5||6.16776465701489
090003|1|541.917987809572|143.046634600517
090003|3|1823.78161330905|2040.78946821719
090003|2|2370.07138661336|2560.784034004
090003|5|3.07288321423999|2.98605414148748
090003|4|11.7616791846331|

## Soluzioni

### VisiData

In VisiData è possibile fare tutti i tipi di join tabellare e a noi serve la outer join, ecco i passaggi seguiti:

1. importare la prima tabella `vd tabella_03.csv`;
2. spostarsi nella colonna COMUNE_IST e pigiare `!`, poi spostarsi nella colonna Cls_LivI_03 e pigiare nuovamente ! per renderle colonne chiavi;
3. importare la seconda pigiando `o` e digitando il nome della tabella;
4. spostarsi nella colonna _COMUNE_IST_ e pigiare `!`, poi spostarsi nella colonna Cls_LivI_03 e pigiare nuovamente ! per renderle colonne chiavi;
5. aprire il foglio dei fogli digitando shift+s, selezionare, usando il tasto `s`, le due tabelle da joinare;
6. digitare `&` per accere al menu dei join, digitare `outer` e premere invio;
7. digitare `ctrl+s` per salvare il risultato.

più facile a farsi che a descriverlo!

### Miller

Ho rinominato il campo in entrambe le tabelle in _Cls_Liv_ e rinominato tabelle in A e B, il comando Miller da lanciare è:

```
mlr --csv join --ul --ur -j COMUNE_IST,Cls_Liv -f A.csv then unsparsify then sort -t COMUNE_IST B.csv >out.csv
```

Questo è insieme join left e right (`--ul --ur`) e quindi è un full outer.

| COMUNE_IST | Cls_Liv | Sup_03ha | Sup_08ha |
| --- | --- | --- | --- |
| 090002 | 3 | 4418.695029356092 | 4375.534226015951 |
| 090002 | 2 | 476.4773446171668 | 490.3999413012836 |
| 090002 | 1 | 47.60749054979091 | 83.01346186282966 |
| 090002 | 5 | 6.167764657014888 |  |
| 090003 | 0 | 3.0119929195484842 | 0.012633751875882445 |
| 090003 | 1 | 143.04663460051736 | 541.9179878095715 |
| 090003 | 3 | 2040.7894682171927 | 1823.7816133090548 |
| 090003 | 2 | 2560.784034003995 | 2370.0713866133647 |
| 090003 | 5 | 2.986054141487481 | 3.072883214239986 |
| 090003 | 4 |  | 11.76167918463312 |

NB: `sort -t` è valido per Miller > 6.0; 

### DuckDB

SQL standard

```bash
duckdb --csv -c "
SELECT
  A.*,
  B.* EXCLUDE(COMUNE_IST, Cls_Liv)
FROM
  'A.CSV' A
  FULL OUTER JOIN 'B.CSV' B ON A.COMUNE_IST = B.COMUNE_IST
  AND A.Cls_Liv = B.Cls_Liv
ORDER BY
  A.COMUNE_IST" >out.csv
```

## Riferimenti utili

1. [VisiData](https://ondata.github.io/guidaVisiData/installazione/)
2. [DuckDB](https://duckdb.org/)
