---
title: "Suddividere una colonna di file csv"
linkTitle: "Split colonna"
date: 2022-06-24
description: >
  Come suddividere una colonna di file csv in base al contenuto
tags:
  - csv
  - split
  - visidata
issue: [219]  
chefs: ["Gianni Vitrano"]
guide: ["Andrea Borruso"]
---

---
Come si può sudividere velocemente in più *colonne* una **colonna** che in ogni cella, il più delle volte ha un elenco puntato?

Esempio:

![](clip_01.png)

Obbiettivo: Ottenere **N** *colonne* dalla **colonna X**

| Criterio A            | Criterio B            | Criterio C          | Criterio D         | Criterio E | Criterio F              | Criterio G           |
|-----------------------|-----------------------|---------------------|--------------------|------------|-------------------------|----------------------|
|  età e/o dimensioni   |  forma e portamento   |  valore ecologico   |                    |            |                         |                      |
|  età e/o dimensioni   |                       |                     | rarità botanica    |            |                         |                      |
|  età e/o dimensioni   |                       |                     |                    |            |                         |                      |
|  età e/o dimensioni   |                       |  valore ecologico   |                    |            |                         |                      |
|  età e/o dimensioni   |                       |                     |                    |            |                         |                      |
|  età e/o dimensioni   |                       |                     |                    |            |                         |                      |

Usare il classico **Split** o **Converti il testo in colonne** rende il tutto molto complicato e non sempre il risultato finale è garantito

# Soluzione 1 Visidata

Utilizzando [Visidata](https://www.visidata.org/) e le espressioni regolari, **[esempio di regex](https://regex101.com/r/ZKPWol/1)** si ricavano le nuove colonne in pochi istanti.
Basta aprire il file, spostarsi sulla colonna da **splittare** pigiare i tasti **shift** + **.** im modo da ottenere il comando  `:` ed inserire la stringa *regex*  `[a-z]\)` e pigare **invio**

![](clip_02.png)

e come per *magia* in pochi istanti la nostra colonna, e il suo contenuto, viene suddivisa in **N** 

In questo caso [Visidata](https://www.visidata.org/) ho usato come separatore per le colonne la regola `[a-z]\)`, ovvero, ho usato i simboli dalla **a** alla **z** che sono seguiti dal simbolo **)**

![](clip_03.png)

Domanda: Se non so usare [Visidata](https://www.visidata.org/) e le *regex*, c'è un altra soluzione?
Risposta: Impara ad utilizzarli, ti rendono la vita più semplice... 😊 

# Soluzione 2 EmEditor

Per chi è poco pratico di [Visidata](https://www.visidata.org/) e regex può usare [EmEditor](https://www.emeditor.com/) un ottimo strumento per manipolare file csv e non solo.

Apriamo il file con [EmEditor](https://www.emeditor.com/), il contenuto della nostra colonna è un po' **sporco**, l'elenco puntato non sempre è scritto tutto nello stesso modo,
troviamo:

- a) oppure a )
- b) oppure	b )
- c) oppure	c )
- d) oppure	d )
- e) oppure	e )
- f) oppure	f )
- g) oppure	g )

![](clip_04.png)

Come prima cosa dobbiamo sostititure questi elenchi con un simbolo **univoco**

![](clip_05.png)

Con una semplice operazione *batch* di **cerca e sosttituisci** sostituiamo tutti i simboli degli elenchi con il simbolo **+** (o altro simbolo)

![](clip_06.png)

Adesso basta selezionare la colonna che si vuole *suddividere* e pigiare il tasto destro del mouse e selezionre **Dividi colonne**

![](clip_07.png)

Si aprirà un popup che permette di selezionare diverse opzioni e il **separatore** da utilizzare

![](clip_08.png)

Adesso non resta che pigiare **invio** e anche [EmEditor](https://www.emeditor.com/) aggiungerà le varie colonne 😊

![](clip_09.png)

Ps: Anche in [EmEditor](https://www.emeditor.com/) si possono usare le regex, ma non sono riuscito ad usarle per definire il **separatore** 😊

## Riferimenti utili
- [Guida VisiData | Lavorare sulle colonne](https://ondata.github.io/guidaVisiData/lavorareColonne/#nuove-colonne-come-risultato-di-splitting)
- [regex](https://regex101.com/r/ZKPWol/1)
- [EmEditor](https://www.emeditor.com/)
