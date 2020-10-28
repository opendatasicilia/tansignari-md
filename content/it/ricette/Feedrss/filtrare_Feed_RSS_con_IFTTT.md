---
title: "IFTTT: filtrare un feed RSS tramite una lista di parole"
linkTitle: "Filtrare RSS con IFTTT"
date: 2020-10-28
description: >
  Il nuovo IFTTT consente di scrivere degli script javascript per modificare il comportamento delle applet. Ecco un esempio.
tags:
  - RSS
  - IFTTT
  - Telegram
issue: [162]
chefs: ["Andrea Borruso"]
guide: ["Andrea Borruso"]
---

---

Il nuovo **IFTTT** consente di utilizzare dei filtri, scrivendo del codice javascript. Qui la guida ufficiale con un esempio correlato:<br>
<https://help.ifttt.com/hc/en-us/articles/360052451954#Searchingforakeywordandskippinganaction>

Se si vuole ad esempio fare in modo che - a partire da un feed RSS - vengano postate in un canale **Telegram** soltanto quelle notizie che contengono nel titolo almeno una delle parole chiave contenute in una lista, si può utilizzare un filtro come quello sottostante (è in javascript):


```javascript
let substrings = ["dati", "dato","tabella","file","statistica","tabelle"];

let testo = Feed.newFeedItem.EntryTitle;
if (new RegExp(substrings.join("|")).test(testo.toLowerCase())) {
    // do nothing
} else {
    Telegram.sendMessage.skip()
}
```

Se la parola chiave non è presente nel titolo (`Feed.newFeedItem.EntryTitle`), sarà "saltato" l'invio al canale (`Telegram.sendMessage.skip()`)

I filtri si inseriscano tra la sorgente e la destinazione.

![](https://i.imgur.com/V4KAwHV.png)
