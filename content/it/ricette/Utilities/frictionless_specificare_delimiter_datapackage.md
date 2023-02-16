---
title: "Come specificare il delimiter in un datapackage frictionless"
linkTitle: "specificare delimiter datapackage frictionless"
date: 2023-02-16
description: >
  Vediamo come specificare il separatore di campo di un file csv in un datapackage frictionless
tags:
  - csv
  - frictionless
  - metadata
  - alias
issue: [249]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

## Use case
Se hai un file csv (sia esso `data.csv`)
```
nome,altezza
pippo,150
```

e vuoi descriverlo come parte di un datapackage lanciando il comando di frictionless

```bash
frictionless describe --type "package" data.csv
```

otterrai in output

```yaml
resources:
  - name: data
    type: table
    path: data.csv
    scheme: file
    format: csv
    encoding: utf-8
    mediatype: text/csv
    schema:
      fields:
        - name: nome
          type: string
        - name: altezza
          type: integer
```

Essendo `data.csv` un file csv che ha la virgola (`,`) come separatore di campo, i metadati prodotti da frictionless non danno nessuna indicazione relativa al `delimiter`. Se invece si vuole forzarne comunque la scrittura, si può lanciare

```bash
frictionless describe --type "package" --dialect '{"csv": {"delimiter": ","}}' data.csv
```

che produce

```yaml
resources:
  - name: data
    type: table
    path: data.csv
    scheme: file
    format: csv
    encoding: utf-8
    mediatype: text/csv
    dialect:
      csv:
        delimiter: ','
    schema:
      fields:
        - name: nome
          type: string
        - name: altezza
          type: integer
```

Si noti che l'opzione `--dialect` accetta in questo caso un inline JSON object `'{"csv": {"delimiter": ","}}'`.

## Tip: alias
Ok, il comando
```bash
frictionless describe --type "package" --dialect '{"csv": {"delimiter": ","}}'
```
è perfetto ma è di una lunghezza imbarazzante. Se vogliamo usare lo stesso comando digitando meno caratteri sul terminale possiamo creare un `alias` in questo modo:

1. lancia `nano ~/.bashrc`
2. individua la porzione di testo dedicata agli alias (`# Alias definitions.`)
3. copia e incolla questo codice al di sotto della porzione individuata al punto precedente 
    ```bash
    alias fdcsv='frictionless describe --type "package" --dialect '\''{"csv": {"delimiter": ","}}'\'''
    ```
    puoi farlo selezionando il codice, per poi dare `CTRL+C` per copiare, recarti sul terminale e dare `CTRL+SHIFT+V` per incollare.
4. salva le modifiche con `CTRL+O` e poi `INVIO`
5. chiudi il file con `CTRL+X`
6. chiudi il terminale e riaprilo.

Adesso puoi ottenere lo stesso risultato di prima semplicemente lanciando
```bash
fdcsv data.csv
```

## Riferimenti
- [CSV Dialect | Frictionless standards](https://specs.frictionlessdata.io/csv-dialect/)
- [Nano editor di testo | Documentazione Ubuntu](https://wiki.ubuntu-it.org/Ufficio/EditorDiTesto/Nano)
