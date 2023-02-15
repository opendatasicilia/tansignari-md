---
title: "Come sostituire una stringa con l'output di un comando"
linkTitle: "Sostituire stringa con output comando"
date: 2022-05-19
description: >
  Ecco come sostituire una stringa di un file di testo con l'output di un comando in bash.
tags:
  - bash
  - perl
issue: [247]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

## Use case
Se hai un file markdown (sia esso `metadata.md`) così fatto:
```md
## 👥 Contributors
{{{contributors}}}
```

e vuoi sostituire la stringa "{{{contributors}}}" con l'output multiline di un comando in bash, puoi usare `perl` in questo modo:
```bash
perl -i -p -e 's/{{{contributors}}}/'"$(comando)"'/g' metadata.md
```

## Esempio
Se l'output multiline a cui siamo interessati si ottiene con il comando
```bash
cat datapackage.yaml | yq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat
```
che produce
```md
| Name | Role | Email |
| --- | --- | --- |
| Tizio | author | tizio@test.it |
| Caio | maintainer | caio@test.it |
```
possiamo salvarlo in una variabile e usare `perl` come indicato sopra
```bash
#!/bin/bash

out=$(cat datapackage.yaml | yq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat)

perl -i -p -e 's/{{{contributors}}}/'"$out"'/g' metadata.md
```

Nel mio caso, si ottiene una cosa del tipo
```md
## 👥 Contributors
| Name | Role | Email |
| --- | --- | --- |
| Tizio | author | tizio@test.it |
| Caio | maintainer | caio@test.it |
```

## Soluzione alternativa
Puoi anche utilizzare `sed` creando un file temporaneo
```bash
<datapackage.yaml yq '[.contributors[] | {Name: .title, Role: .role, Email: .email}]' | mlr --j2m cat >temp.txt

sed -i -e '/{{{contributors}}}/r temp.txt' -e '//d' metadata.md

# if file exists, delete it
if [ -f temp.txt ]; then
    rm temp.txt
fi
```
