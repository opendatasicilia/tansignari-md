---
title: "Estrarre dati dalle issue di un repository GitHub"
linkTitle: "Estrarre dati dalle issue di un repository GitHub"
date: 2022-04-19
description: >
  Come estrarre dati dalle issue di un repository GitHub usando l'utility gh
tags:
  - git
  - script
  - github
  - jq
  - api
  - jsonl
issue: [210]
chefs: ["Totò Fiandaca"]
guide: ["Andrea Borruso"]
---

---

Alcune volte è utile conosce il numero di issue _aperte/chiuse_ di un repository **GitHub**, anche solo per capire lo stato di salute di un progetto. L'interrogazione è possibile farla direttamnete nel repository tramite il _**browser**_, ma per ottenere statistiche su più mesi o anni, oppure, su più etichette: **open/closed/regression** ecc..., occorre utilizzare strumenti più adatti come, per esempio, le [API di GitHub](https://docs.github.com/en/enterprise-server@3.4/rest/guides/getting-started-with-the-rest-api).

## Caso d'uso

Ottenere un file CSV con i dati (data e numero issue) delle issue di QGIS per tutti i mesi del 2021 e 2022, lo script che fa questo lavoro è:

```bash
#!/bin/bash

if [ -f ./toto.jsonl ]; then
    rm ./toto.jsonl
fi

for i in 2021-01-31 2021-02-28 2021-03-31 2021-04-30 2021-05-31 2021-06-30 2021-07-31 2021-08-31 2021-09-30 2021-10-31 2021-11-30 2021-12-31 2022-01-31 2022-02-28 2022-03-31; do
  gh api -X GET search/issues -f q='repo:qgis/QGIS type:issue created:<'"$i"' state:open label:bug' | jq -c '{data:"'"$i"'",count:.total_count}' >> ./toto.jsonl
done
```

in output un file `jsonl`

```
{"data":"2021-01-31","count":693}
{"data":"2021-02-28","count":720}
{"data":"2021-03-31","count":749}
{"data":"2021-04-30","count":775}
{"data":"2021-05-31","count":795}
{"data":"2021-06-30","count":826}
{"data":"2021-07-31","count":864}
{"data":"2021-08-31","count":900}
{"data":"2021-09-30","count":935}
{"data":"2021-10-31","count":975}
{"data":"2021-11-30","count":1022}
{"data":"2021-12-31","count":1055}
{"data":"2022-01-31","count":1095}
{"data":"2022-02-28","count":1151}
{"data":"2022-03-31","count":1249}
{"data":"2022-01-31","count":1095}
{"data":"2022-02-28","count":1151}
{"data":"2022-03-31","count":1249}
```

leggibile con `VisiData`, `Miller` ecc.

## API GitHub

```
gh api -X GET search/issues -f q='repo:qgis/QGIS type:issue created:<'"$i"' state:open label:bug'
```

dove:

- _repo_: indicare il nome del progetto;
- _type_: indicare il tipo, in questo caso sono le issue;
- _created_: per indicare date di creazione issue;
- _state_: per indicare lo stato dell'issue, open, closed
- _label_: indicare una etichetta dell'issue, bug, regression, expression, feature request, 3D ecc...

## Utility nativa

Per installare l'utility nativa (in qualsiasi sistema operativo) segui link https://github.com/cli/cli/releases/tag/v2.8.0; una volta installata occorre attivare l'[autenticazione](https://cli.github.com/manual/gh_auth_login) (si fa una volta).

## Per GNU/Linux Ubuntu

```
# scarica la versione attuale v2.8.0
wget https://github.com/cli/cli/releases/download/v2.8.0/gh_2.8.0_linux_amd64.tar.gz
# unzippa
tar xvf gh_2.8.0_linux_amd64.tar.gz
# copia il file binario dentro /usr/local/bin/
sudo cp gh_2.8.0_linux_amd64/bin/gh /usr/local/bin/
# copia il manuale
sudo cp -r gh_2.8.0_linux_amd64/share/man/man1/* /usr/share/man/man1/
```

## Autenticazione

digitare nella shell:

- `gh auth login`
- selezionare sempre la prima opzione;
- copiare il codice che ci suggerisce e incollarlo nel browser:

![](https://user-images.githubusercontent.com/7631137/164034808-3742e581-4cf0-4a40-b09a-6ee5af121c21.png)

## Riferimenti utili

- [**git**](https://it.wikipedia.org/wiki/Git_(software))
- [**API**](https://docs.github.com/en/enterprise-server@3.4/rest/guides/getting-started-with-the-rest-api)
- [Repository QGIS](https://github.com/qgis/QGIS/issues)
