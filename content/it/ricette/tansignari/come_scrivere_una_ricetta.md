---
title: "Come scrivere una ricetta"
linkTitle: "Come scrivere ricetta"
date: 2022-07-30
description: >
  Come scrivere una ricetta su T'ansignari dopo aver risolto un problema.
tags:
  - ricetta
  - vs code
  - tansignari
issue: [120]
chefs: ["Totò Fiandaca","Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

## Introduzione

Dopo aver posto una **domanda** (tramite issue in [opendatasicilia/tansignari](https://github.com/opendatasicilia/tansignari/issues)) e aver ricevuto una *buona risposta*, si consiglia di scrivere una _ricetta_ che sintetizzi il **problema** e le possibili **soluzioni**. La *ricetta* va scritta in formato `.md` ovvero `Markdown`; se non sai di cosa si tratta, non preoccuparti! Dai un'occhiata a [questa guida](https://www.markdownguide.org/). Cominciamo!

1. Apri il tuo editor di testo preferito
2. Crea un nuovo file a cui dare l'estensione `.md` (e.g. `ciao_mondo.md`)

Adesso siamo prontə per cominciare a scrivere la ricetta

## Front Matter
Le primissime righe del file contenente la ricetta sono dedicate al *Front Matter*: una serie di informazioni codificate in linguaggio `YAML`. Ancora una volta, non preoccuparti se non hai mai sentito parlare di questo formato; ti basterà semplicemente copiare e incollare il template fornito qui sotto e modificare le informazioni secondo le tue necessità

```yaml
---
title: "Come rimuovere righe con 'Totale'"
linkTitle: "Rimuovere righe con 'Totale'"
date: 2022-05-19
description: >
  Rimuovere da un CSV fastidiose righe contenenti il 'Totale'
tags:
  - csv
  - miller
  - istat
issue: [213]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso","Totò Fiandaca","Gabriele Scalici"]
---

---
```

I dati così inseriti saranno compilati in questo modo:

![frontmatter](https://user-images.githubusercontent.com/77018886/181913764-a1c52256-af6e-4f1a-90e6-32f1941ea182.JPG)

Di seguito alcune linee guida

### `title`
Si tratta del titolo della ricetta. Consigliamo di evitare titoli troppo lunghi; maggiori informazioni potranno essere inserite nella `description` o nel corpo della ricetta.

### `date`
Data da inserire nel formato `YYYY-MM-DD`.

### `description`
È la sezione in cui poter aggiungere informazioni alle poche parole del titolo.

### `tags`
È un elenco puntato di tag. Se non sai quale inserire, dai un'occhiata a [questa pagina](https://tansignari.opendatasicilia.it/tags/) in cui sono raccolti tutti i tag utilizzati almeno una volta in T'ansignari.

### `issue`
È l'id dell'issue che hai aperto in [opendatasicilia/tansignari](https://github.com/opendatasicilia/tansignari/issues) per porre la tua domanda. Come capire qual è l'id della tua issue? Basta aprirla e osservare il numero che segue l'hashtag `#` di fianco al titolo della issue. Vediamo un esempio

![issue](https://user-images.githubusercontent.com/77018886/181913730-440af89f-93c9-4f29-bf06-92e89dbb6d73.jpg)

In questo caso la issue di riferimento è la numero `213`, quindi nel *front matter* della ricetta sarà sufficiente scrivere 
```
issue: [213]
```

### `chefs`
È il nome di chi ha posto la domanda e scrive la ricetta.

### `guide`
È il nome di chi ha fornito una buona risposta alla tua domanda. Nel caso in cui ci fossero più risposte utili, potrai indicare più nomi separati da virgole in questo modo
```
guide: ["Andrea Borruso","Totò Fiandaca","Gabriele Scalici"]
```

## Corpo della ricetta
Siamo prontə per il nucleo della ricetta. Scrivila in formato `.md` subito sotto i caratteri `---` contenuti nel *front matter* e sentiti libero/a di inserire immagini, tabelle, riferimenti esterni. Se vuoi vedere qualche esempio, puoi aprire uno dei file `.md` contenuti in [questa cartella](https://github.com/opendatasicilia/tansignari-md/tree/master/content/it/ricette/CSV-TSV).

## Pubblicazione
Adesso la tua ricetta è pronta! Dovrai solo pubblicarla in T'ansignari. Puoi farlo in molti modi, di seguito ne suggeriamo uno abbastanza intuitivo che non presuppone una conoscenza approfondita di Git.

1. [Accedi](https://github.com/login) a [GitHub](https://github.com/) o [registrati](https://github.com/signup) se non hai un account;
2. Apri il repository [opendatasicilia/tansignari-md](https://github.com/opendatasicilia/tansignari-md);
3. Carica la tua ricetta in una delle cartelle contenute in [content/it/ricette](https://github.com/opendatasicilia/tansignari-md/tree/master/content/it/ricette) sulla base della categoria che vuoi assengarle. Puoi fare click su `Add file` e scegliere se creare un nuovo file (*Create new file*) o caricare un file esistente (*Upload file*);
4. Completare la procedura di caricamento (*commit*) assegnando un titolo, una descrizione e facendo click su *Create a new branch for this commit and start a pull request*;
5. Fai click sul tasto verde e fai la stessa cosa anche nella pagina che si aprirà.

![pull](https://user-images.githubusercontent.com/77018886/181913746-6fc91765-e582-4583-9a32-3ee5830d869d.JPG)

La tua ricettà verrà revisionata dai membri della community di [Open Data Sicilia](https://opendatasicilia.it) e sarà presto online! Grazie mille per il tuo tempo ;)
