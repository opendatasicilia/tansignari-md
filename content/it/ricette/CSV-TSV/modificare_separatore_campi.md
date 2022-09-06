---
title: "Modificare separatore di campo e rimuovere virgolette ridondanti in un CSV"
linkTitle: "Modificare delimiter e rimuovere virgolette"
date: 2022-04-22
description: >
  Ecco come modificare il separatore di campo e rimuovere eventuali virgolette ridondanti in un file di dati CSV utilizzando la utility [_Miller_](https://github.com/johnkerl/miller)
tags:
  - csv
  - tsv
  - csv-tsv
  - miller
  - riga di comando
issue: [211]
chefs: ["Dennis Angemi"]
guide: ["Andrea Borruso"]
---

---

I file in formato `CSV` sono i più usati per la condivisione di dati strutturati. In generale consistono in file di testo in cui i campi del dataset sono _separati da virgole_ così come lo stesso acronimo in inglese suggerisce (_Comma Separated Values_).

Di seguito un banalissimo esempio di file CSV
```
Codice comune,Comune
086001,Agira
```

Alle volte, come in [questo dataset](https://demo.istat.it/bil2019/dati/Enna.zip) di ISTAT,  è possibile che:
- il carattere che funge da _separatore di campo_ non sia la virgola `,` ma il punto e virgola `;`
- il contenuto (di quella che in uno spreadsheet sarebbe una _cella_) sia racchiuso da virgolette `"`

Ecco le prime righe del dataset precedentemente citato:
```
"Codice comune";"Comune";"Popolazione al 1° gennaio - Maschi";"Popolazione al 1° gennaio - Femmine";"Popolazione al 1° gennaio - Totale";"Nati - Maschi";"Nati - Femmine";"Nati - Totale";"Morti - Maschi";"Morti - Femmine";"Morti - Totale";"Saldo naturale - Maschi";"Saldo naturale - Femmine";"Saldo naturale - Totale";"Iscritti da altri comuni - Maschi";"Iscritti da altri comuni - Femmine";"Iscritti da altri comuni - Totale";"Iscritti dall'estero - Maschi";"Iscritti dall'estero - Femmine";"Iscritti dall'estero - Totale";"Altri iscritti - Maschi";"Altri iscritti - Femmine";"Altri iscritti - Totale";"Cancellati per altri comuni - Maschi";"Cancellati per altri comuni - Femmine";"Cancellati per altri comuni - Totale";"Cancellati per l'estero - Maschi";"Cancellati per l'estero - Femmine";"Cancellati per l'estero - Totale";"Altri cancellati - Maschi";"Altri cancellati - Femmine";"Altri cancellati - Totale";"Saldo migratorio estero - Maschi";"Saldo migratorio estero - Femmine";"Saldo migratorio estero - Totale";"Unità in più/meno dovute a variazioni territoriali - Maschi";"Unità in più/meno dovute a variazioni territoriali - Femmine";"Unità in più/meno dovute a variazioni territoriali - Totale";"Aggiustamento statistico censuario totale - Maschi";"Aggiustamento statistico censuario totale - Femmine";"Aggiustamento statistico censuario totale - Totale";"Popolazione al 31 dicembre da censimento - Maschi";"Popolazione al 31 dicembre da censimento - Femmine";"Popolazione al 31 dicembre da censimento - Totale";"Popolazione residente in famiglia da censimento - Maschi";"Popolazione residente in famiglia da censimento - Femmine";"Popolazione residente in famiglia da censimento - Totale";"Popolazione residente in convivenza al 31 dicembre da trattamento statistico dell'informazione di fonte anagrafica - Maschi";"Popolazione residente in convivenza al 31 dicembre da trattamento statistico dell'informazione di fonte anagrafica - Femmine";"Popolazione residente in convivenza al 31 dicembre da trattamento statistico dell'informazione di fonte anagrafica - Totale";"Numero di famiglie al 31 dicembre da censimento";"Numero di convivenze al 31 dicembre da trattamento statistico dell'informazione di fonte anagrafica";"Numero medio di componenti per famiglia al 31 dicembre da censimento"
"086001";"Agira";3951;4061;8012;26;28;54;44;56;100;-18;-28;-46;23;28;51;15;10;25;0;0;0;62;35;97;10;13;23;5;3;8;5;-3;2;0;0;0;0;2;2;3894;4022;7916;3883;4015;7898;11;7;18;;3;
```

Generalmente non è necessario utilizzare le virgolette `"` se non sono presenti caratteri speciali (e.g. _newline character_) o virgole che non hanno lo scopo di delimitare i campi. Pertanto, immaginando che il file sul quale stiamo lavorando sia denominato `input.csv`, è possibile utilizzare la utility [_Miller_](https://github.com/johnkerl/miller) per ottenere un "vero" `CSV` a partire dall'esempio di istat. Sarà sufficiente lanciare il seguente comando da terminale

```bash
mlr -I --csv --ifs ";" cat input.csv
```

per ottenere in output un file come questo
```
Codice comune,Comune,Popolazione al 1° gennaio - Maschi,Popolazione al 1° gennaio - Femmine,Popolazione al 1° gennaio - Totale,Nati - Maschi,Nati - Femmine,Nati - Totale,Morti - Maschi,Morti - Femmine,Morti - Totale,Saldo naturale - Maschi,Saldo naturale - Femmine,Saldo naturale - Totale,Iscritti da altri comuni - Maschi,Iscritti da altri comuni - Femmine,Iscritti da altri comuni - Totale,Iscritti dall'estero - Maschi,Iscritti dall'estero - Femmine,Iscritti dall'estero - Totale,Altri iscritti - Maschi,Altri iscritti - Femmine,Altri iscritti - Totale,Cancellati per altri comuni - Maschi,Cancellati per altri comuni - Femmine,Cancellati per altri comuni - Totale,Cancellati per l'estero - Maschi,Cancellati per l'estero - Femmine,Cancellati per l'estero - Totale,Altri cancellati - Maschi,Altri cancellati - Femmine,Altri cancellati - Totale,Saldo migratorio estero - Maschi,Saldo migratorio estero - Femmine,Saldo migratorio estero - Totale,Unità in più/meno dovute a variazioni territoriali - Maschi,Unità in più/meno dovute a variazioni territoriali - Femmine,Unità in più/meno dovute a variazioni territoriali - Totale,Aggiustamento statistico censuario totale - Maschi,Aggiustamento statistico censuario totale - Femmine,Aggiustamento statistico censuario totale - Totale,Popolazione al 31 dicembre da censimento - Maschi,Popolazione al 31 dicembre da censimento - Femmine,Popolazione al 31 dicembre da censimento - Totale,Popolazione residente in famiglia da censimento - Maschi,Popolazione residente in famiglia da censimento - Femmine,Popolazione residente in famiglia da censimento - Totale,Popolazione residente in convivenza al 31 dicembre da trattamento statistico dell'informazione di fonte anagrafica - Maschi,Popolazione residente in convivenza al 31 dicembre da trattamento statistico dell'informazione di fonte anagrafica - Femmine,Popolazione residente in convivenza al 31 dicembre da trattamento statistico dell'informazione di fonte anagrafica - Totale,Numero di famiglie al 31 dicembre da censimento,Numero di convivenze al 31 dicembre da trattamento statistico dell'informazione di fonte anagrafica,Numero medio di componenti per famiglia al 31 dicembre da censimento
086001,Agira,3951,4061,8012,26,28,54,44,56,100,-18,-28,-46,23,28,51,15,10,25,0,0,0,62,35,97,10,13,23,5,3,8,5,-3,2,0,0,0,0,2,2,3894,4022,7916,3883,4015,7898,11,7,18,,3,
```

### Note
- `-I` determina la sovrascrittura del file indicato come argomento (`input.csv`)
- `--csv` indica il formato del file di input
- `--ifs ";"` si utilizza per indicare il _delimiter_ con il quale il file è stato concepito (in questo caso si tratta del punto e virgola `;`)
- `cat` è un _verbo_ che si utilizza per _stampare a schermo_ il contenuto di un file. 

## Riferimenti

- **Miller** : <https://github.com/johnkerl/miller>
- Dataset **ISTAT** bilancio demografico, provincia di Enna, anno 2019 : <https://demo.istat.it/bil2019/dati/Enna.zip>
