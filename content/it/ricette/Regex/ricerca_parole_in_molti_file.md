---
title: "Ricerca di parole in molti file"
linkTitle: "Ricerca di parole all'interno di molti file"
date: 2021-08-14
description: >
 Migliaia di file *.json in varie cartelle, ricercare la presenza (all'ìnterno dei file) di alcune parole o caratteri come: ERR, [], null ecc...
tags:
  - regex
  - json
  - everything
  - ripgrep
  - shell
  - grep
issue: [184]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

## Introduzione

Ho migliaia di file `*.json` in varie cartelle e devo ricercare la presenza (all'ìnterno dei file) di alcune parole: `ERR`, `[]`, `null` ecc...

la struttura delle cartelle è:

`./rawdata/..../geo/`

dove i `....` sono i segnaposto di cartelle con nomi diversi ma con 4 caratteri (es: A123, E345)

esempio: 
- `D:\GitHub\pippo\rawdata\A015\geo`
- `D:\GitHub\pippo\rawdata\A311\geo`
- `D:\GitHub\pippo\rawdata\E418\geo`

come fare questa ricerca usando la shell di Linux?

per adesso utilizzo **_everything_** cartella per cartella (usando i filtri `D:\GitHub\pippo\rawdata\A015\geo\ content:ERR`) e siccome le cartelle sono oltre 50 cerco un modo veloce (ho provato a farlo con everything su tutte le cartelle `D:\GitHub\pippo\rawdata\` ma crasha o impiega un tempo infinito)

mentre il filtro `D:\GitHub\pippo\rawdata\*\geo\ content:ERR` non trova nulla.

## soluzioni

- con search Everything: (occhio al doppio `\` usato per fare l'escape al back slash)

```
regex:"D:\\GitHub\\pippo\\rawdata\\.+\\geo" ext:json content:ERR
```

per velocizzare la ricerca e se il caso lo prevede, utilizzare anche il filtro `size`

```
regex:"D:\\GitHub\\pippo\\rawdata\\.+\\geo" ext:json size:<=40 content:ERR
```

-  a riga di comando, per cercare contenuti uso sopratutto `ripgrep`. Entra nella cartella `pippo/rawdata` via shell e poi lancia

```
rg -l --no-ignore --hidden --type json ERR  | grep -Ei '/.{4}/geo'
```

## Siti utili

- **regex101**, per testare espressioni regolari e imparare a usarle [https://regex101.com/](https://regex101.com/)
- **search Everythin** : https://www.voidtools.com/downloads/
- **ripgrep** : https://github.com/BurntSushi/ripgrep
