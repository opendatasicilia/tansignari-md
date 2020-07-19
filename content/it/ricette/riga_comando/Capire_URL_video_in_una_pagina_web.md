---
title: "Capire url di origine di video VIMEO in pagina web"
linkTitle: "Capire url di origine di video VIMEO in pagina web"
date: 2020-05-18
description: >
  L'obiettivo è capire gli URL di origine di video VIMEO dentro una pagina [web](https://sites.google.com/regione.veneto.it/progetto-vela/formazione/lavorare-smart)
tags:
  - sorgente
  - riga di comando
  - link
  - url
issue: [149]
autori: ["Totò Fiandaca","Ciro Spataro"]
guide: ["Ciro Spataro"]
---

---

## Titolo

Come faccio a capire l'url di origine dei video VIMEO in questa pagina:
https://sites.google.com/regione.veneto.it/progetto-vela/formazione/lavorare-smart

Ho creato un issue: https://github.com/opendatasicilia/tansignari/issues/149# e Andrea Borruso e Totò Fiandaca mi hanno fornito supporto per capire.

## Procedimento

- aprire il sito (ad esempio con un browser);
- aprire la vista codice con `CTRL` + `U`;
- cercare dentro al codice.
Se si cerca "vimeo", si trova.

È poco comprensibile la struttura, ma l'URL si vede ed è copiabile.

Ad esempio:
https://www.google.com/url?q=https%3A%2F%2Fplayer.vimeo.com%2Fvideo%2F347700231&sa=D&sntz=1&usg=AFQjCNHgiHEnE1IQ3IPvx143oW_AvUUF2g

che contiene l'URL https://player.vimeo.com/video/347700231 che è quello cercato sin dall'inizio.

È un pò più leggibile se lo si fa dalla console di sviluppo del browser:
- F12 per aprirla;
- poi (**in Chrome**) vai nel tab Elements;
- in questo `CTRL` + `F` e cerca vimeo.
In questo modo è più leggibile e si vede la struttura, è un `div` che contiene un `iframe`. Dentro l'`iframe` si vede l'URL.


## Un ulteriore aiuto da Totò Fiandaca (un altra procedura)

Usando la shell di linux basterebbe scrivere questo comando per avere subito un file csv con i link

```Bash
curl "https://sites.google.com/regione.veneto.it/progetto-vela/formazione/lavorare-smart" | scrape -be "//div[iframe]"  | xq -r '.html.body.div[]."@data-url"' >vivaAndy.csv

```

Totò Fiandaca in questo [brevissimo video](https://www.loom.com/share/50c7264d37294f95b133ff1f3e9870d3) illustra la procedura.
