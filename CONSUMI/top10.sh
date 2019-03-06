#!/bin/bash
#Fai una singola "foto" per un tempo superiore a quello di simulazione
top -d780 n1 -b>>CONSUMI/top_10.txt
#Estrapola i dati che ci interessano (CPU e Ram) e li salva, cancella il vecchio file
awk -f CONSUMI/consumo.awk CONSUMI/top_10.txt>>CONSUMI/consumi_10Mb.txt
rm CONSUMI/top_10.txt
#Sposta i due file file ottenuti in una sottodirectory "risultati_consumi"
mkdir -p CONSUMI/risultati_consumi
mv CONSUMI/consumi_10Mb.txt CONSUMI/risultati_consumi


