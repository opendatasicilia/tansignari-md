---
title: "QGIS formattare le distanze chilometriche progressive"
linkTitle: "QGIS formattare le distanze chilometriche progressive"
date: 2019-07-21
description: >
 Formattare le distanze chilometriche progressive utilizzando una espressione nell'etichetta di QGIS.
tags:
  - QGIS
  - HfcQGIS
issue: [59]
autori: ["Agostino Ficco"]
chef: "Totò Fiandaca"
---

* autore: _[Agostino Ficco](https://twitter.com/)_
* issue: [#59](https://github.com/opendatasicilia/tansignari/issues/59) fornitore ricetta *[Totò Fiandaca](https://twitter.com/totofiandaca?lang=it)*
* ingredienti: [QGIS](https://qgis.org/it/site/), [Calcolatore di campi](http://hfcqgis.opendatasicilia.it/it/latest/index.html), [CASE](http://hfcqgis.opendatasicilia.it/it/latest/gr_funzioni/condizioni/case.html)

---

**Caso d'uso:** Vettore lineare (strade), la tabella attributi ha un campo **prog** che rappresenta le `distanze progressive` espresse in metri, in questa ricetta popoleremo - usando il calcolatore di campi di QGIS - un nuovo campo (prog_km) con le `distanze chilometriche progressive` in stile autostrade ovvero: da questi numeri interi 6320, 11, 743, 25931 espressi in metri, in questo formato 6+320, 0+011, 0+742, 25+931 che diventano testuale.

## espressione

```
CASE
WHEN  "prog" <10  THEN '0+00' ||"prog"
WHEN  "prog" <100  THEN '0+0' ||"prog"
WHEN  "prog" <1000  THEN '0+' ||"prog"
WHEN  "prog" <10000  THEN left( "prog",1)||'+'|| right( "prog" ,3)
WHEN  "prog" <100000  THEN left( "prog",2)||'+'|| right( "prog" ,3)
WHEN  "prog" <1000000  THEN left( "prog",3)||'+'|| right( "prog" ,3)
ELSE 'valore oltre 1000 km'
END
```

## risultato

id|prog|prog_km
--|----|----
1|6320|6+320
2|11|0+011
3|743|0+743
4|25931|25+931
5|8|0+008
6|105000|105+000

---

## Chi ha cucinato questa ricetta o ne ha tratto ispirazione

- [Esempio 28 #HfcQGIS](http://hfcqgis.opendatasicilia.it/it/latest/esempi/distanze_progressive_chilometriche.html)
