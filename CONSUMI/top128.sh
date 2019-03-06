#!/bin/bash
top -d780 n1 -b>>CONSUMI/top_128.txt
awk -f CONSUMI/consumo.awk CONSUMI/top_128.txt>>CONSUMI/consumi_128Kb.txt
rm CONSUMI/top_128.txt
mkdir -p CONSUMI/risultati_consumi
mv CONSUMI/consumi_128Kb.txt CONSUMI/risultati_consumi

#& if [[ $CBRvalue=="128Kb" ]]
#then bash top128.sh
#fi
