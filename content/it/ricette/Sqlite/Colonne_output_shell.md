---
title: "Come visualizzare a colonne l'output di una query nella shell"
linkTitle: "Come visualizzare a colonne l'output di una query nella shell"
date: 2019-11-19
description: >
    Come visualizzare a colonne l'output di una query nella shell.
tags:
  - bash
  - shell
  - SQLite
  - query
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## formato output di default

```
$ sqlite3 ./4116_test_v2.sqlite
-- Loading resources from /home/pigreco/.sqliterc
SQLite version 3.22.0 2018-01-22 18:45:57
Enter ".help" for usage hints.
sqlite> SELECT load_extension('/usr/local/lib/mod_spatialite.so');

sqlite> SELECT gid, st_length(GEOMETRY) AS len
   ...> from nero
   ...> limit 5;
281340.0|268.850190059588
281341.0|224.420872131294
281364.0|121.766580768523
281366.0|246.644988665897
281369.0|151.774185200148
```
## formato output con colonne e intestazioni campi
```
$ sqlite3 -column -header ./4116_test_v2.sqlite
-- Loading resources from /home/pigreco/.sqliterc
SQLite version 3.22.0 2018-01-22 18:45:57
Enter ".help" for usage hints.
sqlite> SELECT load_extension('/usr/local/lib/mod_spatialite.so');
load_extension('/usr/local/lib/mod_spatialite.so')
--------------------------------------------------

sqlite> SELECT gid, st_length(GEOMETRY) AS len
   ...> from nero
   ...> limit 5;
gid         len
----------  ----------------
281340.0    268.850190059588
281341.0    224.420872131294
281364.0    121.766580768523
281366.0    246.644988665897
281369.0    151.774185200148
```

in questo secondo caso ho aggiunto, nella prima riga, le opzioni: `-column` `-header`

## Riferimenti utili

- [**Shell**](https://it.wikipedia.org/wiki/Shell_(informatica))
- [**Bash**](https://it.wikipedia.org/wiki/Bash)
- [**SQLite**](https://www.sqlite.org/index.html)
