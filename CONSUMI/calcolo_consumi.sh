#!/bin/bash 

echo "Aspetta la fine dei vari run"
#Individua i processi attivi per ogni secondo di tempo di simulazione (ci mette circa 50 secondi)
top -d1 n780 -b>>CONSUMI/output_top_every_sec.txt

#Estrapola i dati che ci interessano (CPU e Ram) e li salva, cancella il vecchio file
awk -f CONSUMI/consumo.awk CONSUMI/output_top_every_sec.txt>>CONSUMI/consumi_ogni_secondo.txt
rm CONSUMI/output_top_every_sec.txt


#Sposta i due file file ottenuti in una sottodirectory "risultati"
mkdir -p CONSUMI/risultati_consumi
mv CONSUMI/consumi_ogni_secondo.txt CONSUMI/risultati_consumi





