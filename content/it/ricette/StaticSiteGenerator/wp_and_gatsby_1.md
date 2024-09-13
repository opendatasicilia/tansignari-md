---
title: "Come sviluppare un nuovo sito con Gatsby e Wordpress?"
linkTitle: "Come sviluppare un nuovo sito con Gatsby e Wordpress?"
date: 2024-09-13
description: >
  Sviluppiamo un nuovo sito con Gatsby e Wordpress
tags:
  - ssg
  - gatsby
  - website
issue: [263]
chefs: ["Dennis Angemi", "Gabriele Scalici"]
guide: ["Gabriele Scalici"]
---

---

Per prima cosa settiamo l'environment in cui andremo ad utilizzare node e gatsby per lo sviluppo.

## 1. Installiamo Node e Gatsby

Il metodo che consiglio per installare Node è utilizzando [nvm](https://github.com/nvm-sh/nvm#installing-and-updating), un version manager per Node. In questo modo possiamo cambiare versione all'occorrenza, o scaricare altre versioni. Altrimenti si può anche scaricare direttamente dal [sito ufficiale](https://nodejs.org/en/). Per questa guida utilizzeremo Node v16.13.1 'Gallium' (LTS).

Per assicurarci che Node sia installato basterà lanciare il comando `node -v` dal terminale.

Una volta installato Node, avremo anche accesso a **npm**, il package manager predefinito di Node, con cui gestiremo il progetto, e installeremo vari pacchetti e librerie che ci semplificheranno la vita, tramite il comando `npm install <nomepacchetto>`.

Utilizzando la flag `-g` possiamo installare un pacchetto globalmente, in modo tale da poterlo utilizzare sulla nostra macchina al di là del progetto su cui stiamo lavorando. Tutti gli altri pacchetti installati non globalmente, si troveranno nella cartella `/node_modules`.

Ad esempio, installiamo [Gatsby command line tool (CLI)](https://www.gatsbyjs.com/docs/reference/gatsby-cli/) globalmente con **npm**:
```sh
npm install -g gatsby-cli
```

## 2. Inizializziamo

- Cloniamo il repository con il comando:  
```sh
git clone https://github.com/opendatasicilia/opendatasicilia.it.git
```

- All'interno della cartella appena creata, lanciamo `npm init -y` che setterà il nostro progetto e creerà il file _package.json_, al cui interno terremo conto di tutte le dipendenze e metadata del progetto.

- Adesso possiamo installare le dipendenze principali che ci aiuteranno ad avviare il progetto, tramite il comando:  
```sh
npm install gatsby react react-dom
```

## 3. Struttura del progetto
Gatsby è un framework _magico_, che integra strumenti come [React](https://reactjs.org/), [GraphQL](https://graphql.org/) e [Webpack](https://webpack.js.org/), per facilitare lo sviluppo di pagine web e ottimizzarne i contenuti. Esistono alcune [convenzioni che vanno rispettate](https://www.gatsbyjs.com/docs/reference/gatsby-project-structure/) per sfruttare a pieno le sue capacità. Una di queste è la struttura delle cartelle, e alcuni files essenziali che andremo a modificare in seguito.  

> ### /src/pages

La cartella `/src` sarà quella che terrà tutto il codice sorgente della nostra applicazione, al suo interno possiamo creare altre cartelle a nostro piacimento, ma in ogni caso, la sottocartella `/pages` sarà quella in cui Gatsby andrà a cercare le nostre pagine. Questa è una bella rivoluzione già cominciata da [Next.js](https://nextjs.org/), altro framework molto potente.
Quindi prima di tutto creiamo la cartella `/src/pages` e magari inseriamo la nostra homepage all'interno: `src/pages/index.js`.

```js
import React from "react"
export default function Home() {
  return <h1>Hello Mondo!</h1>
}
```
Se andiamo adesso a lanciare il comando `gatsby develop` dal terminale, all'interno della cartella root del progetto, possiamo notare che il progetto viene renderizzato, e l'homepage mostrata all'indirizzo http://localhost:8000. Gatsby avrà creato altre due cartelle: .cache, e public, all'interno delle quali sono presenti tutti gli asset del progetto, minimizzati e ottimizzati per essere serviti in fase di sviluppo. Quando lanceremo l'app in produzione tramite `gatsby build` anche la cartella `./build` verrà creata con assets ottimizzati per ambito production.

Queste cartelle vanno incluse all'interno del file `.gitignore`, che andremo a creare, che comunicherà a git quali files e quali cartelle non andranno inseriti all'interno del repository.

> ### /src/components
All'interno di questa cartella creeremo dei componenti riutilizzabili che hanno una specifica funzione. I componenti non sono nient'altro che funzioni che possiamo esportare e importare in diverse pagine, magari modificandone i parametri, e quindi i risultati. Ad esempio come un frullatore è un componente, può ricevere arance e fare un succo d'arancia, o mirtilli per il succo al mirtillo. A seconda di cosa ci serve prendiamo il frullatore e lo mettiamo in una pagina particolare, così da poterne riutilizzare le funzionalità. Il nome della cartella è una convenzione che viene principalmente da [React](https://reactjs.org/docs/components-and-props.html), su cui Gatbsy è basato.

> ### /src/templates
Qui andremo a creare delle strutture di design predefinite (ma customizzabili) per ogni tipo di contenuto che vogliamo mostrare in maniera coerente e ripetibile. Ad esempio, potremo creare un template per ogni articolo di _blog_, un template per ogni tipo di _evento_ e così via.

> ### .gitignore
Aggiungiamo al .gitignore le cartelle che non vogliamo portarci sul repository.
```
node_modules
.cache
public
build
```

Altri due files fondamentali che andremo a creare nella root del progetto, sono _gatsby-config.js_ e _gatsby-node.js_, che ci aiuteranno a gestire la configurazione del progetto, e i nodi GraphQL che andremo a creare.

La struttura corrente del progetto a questo punto dovrebbe essere piu o meno questa:
```bash
├── .gitignore
├── gatsby-config.js
├── gatsby-node.js
├── package.json
├── package-lock.json
├── README.md
└── src
    └── pages
        └── index.js
```

## 4. Conclusione
Adesso siamo pronti a sviluppare la nostra applicazione con Gatsby.js! Vedremo piu avanti come collegarlo, nel nostro caso, ad una installazione preesistente di Wordpress.

---

_Originally posted by [@gabacode](https://github.com/gabacode) on [GitHub](https://github.com/opendatasicilia/opendatasicilia.it/discussions/categories/racconta)_