---
title: "Google Sheets | Importadata file csv con separatore semicolon"
linkTitle: "IMPORTDATA semicolon (;)"
date: 2019-08-29
description: >
  Come importare da remoto un file csv in google sheet che usa il **semicolon** (**;**) come separatore di campo.
tags:
  - csv
  - gsheet
issue: [89]
chefs: ["Gianni Vitrano"]
guide: ["Gianni Vitrano"]
---

---

Come importare da remoto un file csv  in google sheet che usa il **semicolon** (**;**) come separatore di campo?

Di default google sheet con **IMPORTDATA**  importa i dati di un **url** specificato in formato .csv (valori **separati da virgole**) o .tsv (valori **delimitati da tabulazioni**).

quindi per importare un file  basta posizionarsi in cella qualsiasi e scrivere:

**IMPORTDATA("url")**

url - L'url da cui recuperare i dati in formato .csv o .tsv, incluso il protocollo (ad es. http://)

**IMPORTDATA("http://www.census.gov/2010census/csv/pop_change.csv")**

Ma se nel file che vogliamo importare è stato usato **semicolon** (**;**) come separatore di campo... come in questo [caso](https://opendata.comune.palermo.it/ws.php?id=1905&fmt=csv) ?

Con la sintassi di base...

`=IMPORTDATA("https://opendata.comune.palermo.it/ws.php?id=1905&fmt=csv")`

... otteniamo questo risultato

![](https://user-images.githubusercontent.com/20488693/63928050-32803180-ca4f-11e9-84ea-56568ff8decb.png)

Per far caricare correttamente il file occorre specificare nella formula che il separatore di campo è **semicolon** (**;**)

Qui la nuova sintassi della formula:

**IMPORTDATA("url", ";")**

`=IMPORTDATA("https://opendata.comune.palermo.it/ws.php?id=1905&fmt=csv", ";")`

![](https://user-images.githubusercontent.com/20488693/63928548-074a1200-ca50-11e9-8043-ef01818d5b9e.png)

 Ps. Impostazioni internazionali: **Regno Unito** e *usate sempre nomi di funzioni inglesi* **fleggato**

![](https://user-images.githubusercontent.com/20488693/63932951-91967400-ca58-11e9-9185-5914cfcbe341.png)

### Con Impostazioni internazionali: Italia

**IMPORTDATA("url"; ";")**

`=IMPORTDATA("https://opendata.comune.palermo.it/ws.php?id=1907&fmt=csv"; ";")`

Fatto... :-)

Nella [documentazione ufficiale](https://support.google.com/docs/answer/3093335?hl=it) non è riportata alcuna informazione sull'argomento.

Ps: con la stessa logica si possono importare file con altri tipi di separatori.



