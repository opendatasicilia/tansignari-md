---
title: "Come sviluppare un nuovo sito con Gatsby e Wordpress?"
linkTitle: "Come sviluppare un nuovo sito con Gatsby e Wordpress?"
date: 2024-09-13
description: >
  Utilizzeremo WordPress come backend, per sfruttare al meglio le sue capacità come CMS, collegandolo a Gatsby tramite GraphQL
tags:
  - ssg
  - gatsby
  - website
issue: [263]
chefs: ["Dennis Angemi", "Gabriele Scalici"]
guide: ["Gabriele Scalici"]
---

---

## Parte 1

Per prima cosa settiamo l'environment in cui andremo ad utilizzare node e gatsby per lo sviluppo.

### 1. Installiamo Node e Gatsby

Il metodo che consiglio per installare Node è utilizzando [nvm](https://github.com/nvm-sh/nvm#installing-and-updating), un version manager per Node. In questo modo possiamo cambiare versione all'occorrenza, o scaricare altre versioni. Altrimenti si può anche scaricare direttamente dal [sito ufficiale](https://nodejs.org/en/). Per questa guida utilizzeremo Node v16.13.1 'Gallium' (LTS).

Per assicurarci che Node sia installato basterà lanciare il comando `node -v` dal terminale.

Una volta installato Node, avremo anche accesso a **npm**, il package manager predefinito di Node, con cui gestiremo il progetto, e installeremo vari pacchetti e librerie che ci semplificheranno la vita, tramite il comando `npm install <nomepacchetto>`.

Utilizzando la flag `-g` possiamo installare un pacchetto globalmente, in modo tale da poterlo utilizzare sulla nostra macchina al di là del progetto su cui stiamo lavorando. Tutti gli altri pacchetti installati non globalmente, si troveranno nella cartella `/node_modules`.

Ad esempio, installiamo [Gatsby command line tool (CLI)](https://www.gatsbyjs.com/docs/reference/gatsby-cli/) globalmente con **npm**:
```sh
npm install -g gatsby-cli
```

### 2. Inizializziamo

- Cloniamo il repository con il comando:  
```sh
git clone https://github.com/opendatasicilia/opendatasicilia.it.git
```

- All'interno della cartella appena creata, lanciamo `npm init -y` che setterà il nostro progetto e creerà il file _package.json_, al cui interno terremo conto di tutte le dipendenze e metadata del progetto.

- Adesso possiamo installare le dipendenze principali che ci aiuteranno ad avviare il progetto, tramite il comando:  
```sh
npm install gatsby react react-dom
```

### 3. Struttura del progetto
Gatsby è un framework _magico_, che integra strumenti come [React](https://reactjs.org/), [GraphQL](https://graphql.org/) e [Webpack](https://webpack.js.org/), per facilitare lo sviluppo di pagine web e ottimizzarne i contenuti. Esistono alcune [convenzioni che vanno rispettate](https://www.gatsbyjs.com/docs/reference/gatsby-project-structure/) per sfruttare a pieno le sue capacità. Una di queste è la struttura delle cartelle, e alcuni files essenziali che andremo a modificare in seguito.  

> #### /src/pages

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

> #### /src/components
All'interno di questa cartella creeremo dei componenti riutilizzabili che hanno una specifica funzione. I componenti non sono nient'altro che funzioni che possiamo esportare e importare in diverse pagine, magari modificandone i parametri, e quindi i risultati. Ad esempio come un frullatore è un componente, può ricevere arance e fare un succo d'arancia, o mirtilli per il succo al mirtillo. A seconda di cosa ci serve prendiamo il frullatore e lo mettiamo in una pagina particolare, così da poterne riutilizzare le funzionalità. Il nome della cartella è una convenzione che viene principalmente da [React](https://reactjs.org/docs/components-and-props.html), su cui Gatbsy è basato.

> #### /src/templates
Qui andremo a creare delle strutture di design predefinite (ma customizzabili) per ogni tipo di contenuto che vogliamo mostrare in maniera coerente e ripetibile. Ad esempio, potremo creare un template per ogni articolo di _blog_, un template per ogni tipo di _evento_ e così via.

> #### .gitignore
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

### 4. Conclusione
Adesso siamo pronti a sviluppare la nostra applicazione con Gatsby.js! Vedremo piu avanti come collegarlo, nel nostro caso, ad una installazione preesistente di Wordpress.

---

## Parte 2: Gatsby e Wordpress
Per questo progetto, utilizzeremo WordPress come backend, per sfruttare al meglio le sue capacità come CMS, collegandolo a Gatsby tramite GraphQL. WordPress ha già di suo delle fantastiche REST API che si possono chiamare da qualsiasi frontend, ma può anche essere abilitato ad utilizzare GraphQL. Essenzialmente GraphQL utilizza dei nodi gerarchici, tramite i quali è possibile effettuare query molto specifiche, senza bisogno di dover configurarle dal lato del server. Detto in parole povere è molto piu efficiente e leggero, e spesso è accoppiato da interfacce grafiche che facilitano la struttura delle query desiderate. Proprio perchè le query devono essere specifiche, potrebbe rivelarsi meno flessibile delle REST API in alcuni ambiti. Tuttavia, Gatsby ci facilita la vita anche in quello, incorporando delle funzioni che facilitano l'accesso ai filtri tramite variabili, come vedremo in seguito.

A differenza di un normale portale WordPress, in cui il frontend è spesso sviluppato in PHP e ogni richiesta corrisponde ad una chiamata ad un database, essendo Gatsby un generatore di contenuti statici, effettua tutte le chiamate al database una sola volta in fase di build, e ulteriori volte solo quando un contenuto del database ha subito variazioni. Questo lo rende adatto a tutti quei portali in cui gli aggiornamenti non sono immediati (come ad esempio blogs, portfolios etc).

### 1. Wordpress
Installare i seguenti plugins:
- [WPGraphQL](https://wordpress.org/plugins/wp-graphql/)
- [WpGatsby](https://wordpress.org/plugins/wp-gatsby/)

Possiamo notare che la IDE è stata attivata, dando già un'occhiata ai tipi di contenuti che le nuove query possono restituirci facilmente. All'interno dei settaggi per il plugin possiamo prendere nota dell'URL endpoint che utilizzeremo per le query, di default è solitamente `https://dominio.com/graphql`

### 2. Gatsby
Gatsby ha dei veri e propri "plugins" che si possono installare e configurare, ciò ci semplifica davvero molto il lavoro, accelerando lo sviluppo dell'applicazione che stiamo progettando.
Ritornando al nostro progetto, aggiungiamo qualche utile libreria tramite npm:
```bash
npm install gatsby-source-wordpress
```
Aggiungiamo il plugin al file `gatsby-config.js` che abbiamo creato precedentemente.
```js
module.exports = {
  plugins: [
    {
      resolve: "gatsby-source-wordpress",
      options: {
        url: "https://dominio.com/graphql",
      },
    },
  ],
};
```

Se adesso reinseriamo il comando `gatsby develop` sul nostro terminale, vedremo che la console si è popolata di nuovi contenuti. Quelli sono i contenuti di WordPress che vengono scaricati da Gatsby e resi statici.  

Gatsby offre una comoda IDE per esplorare le query che vogliamo fetchare tramite GraphQL, accessibile all'indirizzo `http://localhost:8000/___graphql`  

In questo modo, spulciando le spunte sulla sinistra possiamo vedere ad esempio che possiamo cercare tutti i titoli e date dei post creati nell'anno 2019 con la seguente query:  

```js
query MyQuery {
  allWpPost(filter: {date: {gt: "2018", lt: "2020"}}) {
    nodes {
      title
      date
    }
  }
}
```
Piu informazioni sui filtri sono disponibili a questo [indirizzo](https://www.gatsbyjs.com/docs/graphql-reference/#complete-list-of-possible-operators)

### 3. In pratica

Adesso possiamo modificare la nostra home (index.js) cercando di tirarci, ad esempio, tutti i titoli e slug degli ultimi 10 post del blog.  
```js
query{
  allWpPost(limit: 10){
    nodes {
      title
      slug
    }
  }
}
```

Inseriamo la query e un semplice loop all'interno della home page:
```js
import React from "react"
import { graphql } from "gatsby"

// Questa è la nostra query
export const query = graphql`
  query{
    allWpPost(limit: 10){
      nodes {
        title
        slug
      }
    }
  }
`
// Questo è il component Home (la nostra homepage)
export default function Home({data}){
  
  // Dichiariamo l'array che vogliamo
  const posts = data.allWpPost.nodes
  
  return(
    <div>
      {
      // Per ogni post crea una div con un link
        posts.map(post => (
          <div>
            <a href={post.slug}>
              {post.title}
            </a>
          </div>
        ))
      }
    </div>
  )
}
```

- Nelle prime righe importiamo le librerie necessarie (graphql e React)
- Definiamo la query che ci interessa (che possiamo anche copiare dalla IDE)
- Creiamo una funzione che prende i dati dalla query e crea un loop per ogni risultato.

Il metodo [.map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map) è una specie di forEach: per ogni elemento contenuto all'interno di un array (nel nostro caso posts) seleziona una variabile arbitraria (post) e per ogni post restituisce una funzione. Nel nostro caso la funzione è una `<div>` che al suo interno contiene un link che porta allo slug del post, e ha come titolo il titolo del post.  
Questa sintassi, un pò a metà tra HTML e Javascript, si chiama JSX. Quando vogliamo utilizzare javascript all'interno dell'html lo facciamo aprendo parentesi graffe { } e inserendo il codice javascript all'interno.

Come si può notare, tutta la query viene inserita all'interno dell'oggetto "data", e da lì i vari nodi si comportano come veri e propri oggetti JSON.  

### In caso di equivoci
Ogni tanto può capitare di perdersi tra le query e non capire bene in quale nodo siamo finiti 😰  
In questo caso è molto utile utilizzare all'interno del codice HTML, l'utility `JSON.stringify` in questo modo:

```js
<pre>{JSON.stringify(data, null, 4)}</pre>
```
che praticamente restituisce l'oggetto genitore che stiamo cercando di chiamare, lo formatta in maniera carina e con indentazione, e ci salva la giornata 😀

---

## Parte 3: Generiamo pagine dinamicamente
Dopo essere riusciti a chiamare le prime query e popolare la nostra homepage con dei contenuti, è arrivato il momento di creare una pagina per ogni blog post, categoria, evento, o qualsiasi altra entità presente sul nostro CMS.

Per riuscire in questo intento dobbiamo stabilire un template "contenitore" per ogni entità, e decidere quali proprietà dell'entità vogliamo mostrare. In questo esempio creeremo una pagina per ogni articolo del blog, mostrandone il titolo, e il contenuto in HTML.

Creiamo un nuovo template in `/src/templates/post.js` con il seguente contenuto:

> /src/templates/post.js

```js
import React from "react"
import { graphql } from "gatsby"

export default function Post({ data }) {
    const post = data.allWpPost.nodes[0]
    return (
        <div>
            <h2>{post.title}</h2>
            <div dangerouslySetInnerHTML={{ __html: post.content }} />
        </div>
    )
}
export const query = graphql`
    query($slug: String!){
        allWpPost(filter: { slug: { eq: $slug } }) {
            nodes {
                slug
                title
                content
            }
        }
    }
`
```
Il contenuto del template è molto simile a quello che abbiamo scritto sulla home (index.js), ma ci sono delle differenze chiave. Prima di tutto, in questo caso non c'è un loop, ma andiamo a selezionare l'index [0] dell'array perchè in realtà vogliamo mostrare un singolo post alla volta.

All'interno della nostra query c'è anche una variabile `$slug` corrispondente ad una stringa, e questa variabile va a filtrare la nostra query, in modo che il post visualizzato sia equivalente (eq) al valore della variabile `$slug`

Ma da dove arriva questa variabile, esattamente?

La risposta si trova nel file `gatsby-node.js`, il file piu importante che andremo a creare per la generazione di nodi e contenuti dinamici.

> ./gatsby-node.js
```js
const path = require(`path`)

exports.createPages = ({ graphql, actions }) => {
    const { createPage } = actions;

    const posts = graphql(`
        query {
            allWpPost{
                nodes {
                    slug
                }
            }
        }
    `)
    .then(result => {
        result.data.allWpPost.nodes.forEach(node => {
            createPage({
                path: `/${node.slug}`,
                component: path.resolve(`./src/templates/post.js`),
                context: {
                    slug: node.slug
                },
            });
        })
    })
 
    return Promise.all([posts])
};
```

In questo file la *magia* di Gatsby ci permette di fare una query e prendere tutti gli slugs presenti su allWpPost (il nodo relativo a tutti i post su WordPress), e per ogni slug creare una pagina con un determinato path (in questo caso potrebbe essere anche `/blog/${node.slug}`, "montarne" il contenuto su un determinato template, e passare la variabile $slug al componente tramite context. Ecco svelato l'arcano! Infine, una promessa di contenuto viene restituita dalla funzione.

In javascript una promessa non è debito, il metodo `.then` viene eseguito se e solo se la promessa viene mantenuta (cioè se l'esito della query è positivo). E' un modo flessibile per utilizzare modalità asincrone nella gestione dei flussi dati, ogni qual volta che c'è memoria di mezzo, input/output o semplicemente qualche lag, è importante gestire il tutto con una promessa asincrona.

Questo procedimento permette di generare una pagina per ogni articolo di post, su un indirizzo stabilito nel parametro path (es. `https://tuosito.com/blog/nome-articolo-slug`).

Adesso, se riproviamo a lanciare `gatsby develop`, la nostra nuova funzione scaricherà tutti gli slug e contenuti che trova su WordPress, montando ciascuna pagina ad un indirizzo statico definito (il path), dal cui template possiamo filtrare i contenuti a nostro piacimento. Per modificare il layout dei blog post, basterà semplicemente modificare il file `/src/templates/post.js`

Bello, vero? 😀

### Funziona, ma si vede male, non siamo piu negli anni '90!

Adesso che abbiamo accesso ad un minimo di contenuti, possiamo cominciare a dare una stilizzata al tutto, nella prossima parte.

---

## Parte 4: Styling e Layout
In questa guida cominceremo a dare una forma omogenea al nostro progetto, creando il nostro primo componente riutilizzabile: Layout.js

Questo componente è molto utile perchè fa da contenitore per tutti gli altri componenti che vogliamo canalizzare. Una specie di wrapper "genitore" che contenga tutti gli altri componenti "figli". E' molto utile perchè ad esempio possiamo stabilire un'header, un footer, eventuali scripts che vanno caricati in ogni pagina etc. E' essenzialmente il nostro "tema".

### 1. Il primo Component

Creando un nuovo file `./src/components/Layout.js` andremo ad inserire una semplice logica canalizzante.
> ./src/components/Layout.js
```js
import React from 'react'

export default function Layout({children}){
    return(
        <div>
            {children}
        </div>
    )
}
```
Praticamente questa funzione Layout, prende degli argomenti, e li restituisce all'interno di una sua div.

Questo significa che adesso possiamo "wrappare" le nostre pagine, e i nostri templates, all'interno di questo nuovo componente, che funzionerà come un aggregatore, una volta che inseriremo piu elementi al suo interno.

Ad esempio, la nostra homepage potrà essere "wrappata" dal nostro nuovo componente sostituendo il tag `<div>` con il nostro nuovo `<Layout>` in questo modo:
> ./src/pages/index.js
```js
import React from "react"
import { graphql } from "gatsby"
import Layout from "../components/Layout"

export const query = graphql`
  query{
    allWpPost(limit: 10){
      nodes {
        title
        slug
      }
    }
  }
`

export default function Index({data}){
  const posts = data.allWpPost.nodes
  return(
    <Layout>
      {
        posts.map(post => (
          <div>
            <a href={post.slug}>
              {post.title}
            </a>
          </div>
        ))
      }
    </Layout>
  )
}
```

Notare l'import all'inizio del file, stiamo importando un nuovo componente e lo stiamo usando all'interno di altre pagine (il famoso frullatore).

### 2. Now do it with style
Un package molto utile su React e simili è [react-helmet](https://github.com/nfl/react-helmet).
Installiamolo con il comando: 
```bash
npm install gatsby-plugin-react-helmet react-helmet
```
Avendo anche installato un nuovo plugin per gatsby, questo andrà inserito all'interno del `gatsby-config.js` file seguendo [queste istruzioni](https://www.gatsbyjs.com/plugins/gatsby-plugin-react-helmet/)

[React-helmet](https://www.npmjs.com/package/react-helmet) ci consente di "iniettare" tags all'interno del tag `<head>` di ogni pagina, permettendoci di farlo sia in maniera statica, che in maniera dinamica.

In questo caso, possiamo usare il componente `<Helmet>` anche per caricare `.css` esterni, in questo caso potremmo utilizzarlo per importare bootstrap in maniera "tradizionale".

Adesso il nostro Layout.js potrebbe essere ad esempio:
> ./src/components/Layout.js
```js
import React from 'react'
import { Helmet } from 'react-helmet'

export default function Layout({children}){
    return(
        <>
            <Helmet>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"/> 
            </Helmet>
            <div className="container mt-5">
                {children}
            </div>
        </>
    )
}
```
Ed ecco Bootstrap sul nostro tema!  

Da notare: in JSX si usa `className` al posto di `class`, e cosa sono quei tag vuoti? React può restituire solo un componente alla volta a partire dalle sue funzioni, per questo si usano quei tag vuoti, chiamati [Fragments](https://reactjs.org/docs/fragments.html). Se React ci scopre a mandare piu di un figlio dalla stessa funzione non la prende bene, quindi vengono usati spesso se una funzione ritorna piu children. Helmet può essere usato anche con tutti gli altri metatags, vedremo piu avanti come "iniettare" titoli dinamici, opengraph etc.

### 3. Header e Footer
Possiamo creare altri 2 componenti: Header.js e Footer.js da includere all'interno del nostro Layout.js  
I contenuti di Header e Footer sono solitamente statici, possiamo prenderli direttamente da WordPress tramite query.

{work in progress...}

Alla fine, possiamo includere i nuovi componenti all'interno del Layout.js, semplicemente importandoli e inserendoli all'interno del fragment.
> ./src/components/Layout.js
```js
import React from 'react'
import { Helmet } from 'react-helmet'
import Header from './Header'
import Footer from './Footer'

export default function Layout({children}){
    return(
        <>
            <Helmet>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"/> 
            </Helmet>
            <Header/>
            <div className="container mt-5">
                {children}
            </div>
            <Footer/>
        </>
    )
}
```

Da ora in poi possiamo modificare il nostro template usando le classi native di bootstrap, e/o creando un nostro foglio di stile personalizzato.

---

_Originally posted by [@gabacode](https://github.com/gabacode) on [GitHub](https://github.com/opendatasicilia/opendatasicilia.it/discussions/categories/racconta)_