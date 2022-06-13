---
title: "Creare una attività pianificata per automatizzare lo speedtest"
linkTitle: "Creare una attività pianificata per automatizzare lo speedtest"
date: 2020-05-06
description: >
  Come creare una attività pianificata per automatizzare la raccolta dati din uno speedtest con Ookla.
tags:
  - bash
  - batch
  - csv
  - script
  - git
  - scheduling
issue: [217]
chefs: ["Totò Fiandaca"]
guide: ["Totò Fiandaca"]
---

---

## Caso d'uso

Testare una connessione internet tramite l'esecuzione programmata di uno speedtest ogni 30 minuti.

Lo speedtest by Ookla fornisce anche un [APP Speedtest CLI](https://www.speedtest.net/apps/cli) che permette di avviare i test da riga di comando, senza dover ogni volta avviare un browser e lanciare la relativa APP.

Per installare la CLI sotto WSL con Ubuntu 20.04, basta lanciare da terminale:

```
sudo apt-get install curl
curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash
sudo apt-get install speedtest
```

## script bash

Il primo script per eseguire lo speedtest e memorizzare l'output è il segente:

```bash
#!/bin/bash

# crea variabili
data=`date +"%Y-%m-%dT%H:%M:%S%:z"`
valori=`speedtest -f csv`
# concatena
record=$data,$valori
# salva i record
echo $record >>/mnt/d/GitHub/speedtest-parabola/output/toto-migliorato.csv 2>&1
```

restituisce questo output, accodando i vari risultati dello speedtest:


datatime|server name|server id|latency|jitter|packet loss|download|upload|download bytes|upload bytes|share url|download server count
--------|-----------|---------|-------|------|-----------|--------|------|--------------|------------|---------|----------------------
2022-06-10T16:02:34+02:00|WeLink - Niscemi|17474|33.335|3.127|0|1069171|2492246|11959500|22726620|https://www.speedtest.net/result/c/7dba07e5-610f-4434-9c20-74a192fb5243|1
2022-06-10T16:30:04+02:00|INNOVA-tel - Caltagirone|19305|16.173|6.269|N/A|2973694|2416934|18611106|13552320|https://www.speedtest.net/result/c/36986cea-affe-4f30-84f9-a407440494ee|1
2022-06-10T17:00:04+02:00|INNOVA-tel - Caltagirone|19305|18.347|2.732|N/A|3343245|2501710|24336292|19650240|https://www.speedtest.net/result/c/8c9f0700-a5a6-404d-ae66-722ee7e59b76|1
2022-06-10T17:30:01+02:00|INNOVA-tel - Caltagirone|19305|19.287|6.223|N/A|3220528|2497977|21904136|16206464|https://www.speedtest.net/result/c/1ff5df72-f3e3-41b5-90fc-0cf4c4139b62|1

## script batch

questo script serve per inviare i dati in un repository GitHub:

```batch
@echo off
git add -A -- "D:\GitHub\speedtest-parabola\output\toto-migliorato.csv"
git commit -m "update"
git push
```

## Unità di pianificazione win 10

Per automatizzare i due script, avviarli ogni giorno a partire dalle 8:00 di mattino e ripeterli ogni 30 minuti, ho usato l'unità di pianificazione di win 10 e quindi ho creato due Attività:

1. Automazione SpeedTest: che avvia ogni 30 minuti il primo script bash;
![](https://user-images.githubusercontent.com/7631137/173425139-bbfe8927-aa23-47a2-959a-94cdd31ac798.png)

2. Automazione SpeedTest push: che avvia ogni 30 minuti il secondo script batch;
![](https://user-images.githubusercontent.com/7631137/173417179-2009bf9f-2e40-4294-a67b-ae41fd678059.png)

## repository

In questo repository raccolgo i dati:

<https://github.com/pigreco/speedtest-parabola>

## Riferimenti utili

- [**speedtest by Ookla**](https://www.speedtest.net/)
- [**bash**](https://it.wikipedia.org/wiki/Bash)
- [**batch**](https://en.wikipedia.org/wiki/Batch_file)
- [**git**](https://git-scm.com/)
- [**guida: How to Launch Cron Automatically in WSL on Windows 10**](https://www.howtogeek.com/746532/how-to-launch-cron-automatically-in-wsl-on-windows-10-and-11/)

