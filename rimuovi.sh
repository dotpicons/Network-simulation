#!/bin/bash

runs=10;
rm -f out.nam
rm -f trace_stat.tr
rm -r -f CONSUMI/risultati_consumi
rm -r -f RISULTATI-AWK
rm -r -f GNUPLOT-DATA
rm -f delay-by-fid.jpeg
rm -f lost-packet-ratio-by-fid.jpeg
rm -f overhead.jpeg
rm -f throughput-cumulativo.jpeg
rm -f throughput-by-fid.jpeg
#j indica il rate del collegamento tra il nodo 2 e il nodo 3, il quale può variare tra 500kb e 10Mb
for j in 500Kb 10000Kb
do
#k indica il rate del flusso cbr, il quale può variare tra i seguenti valori: NO-CBR, 128kb, 256kb, 1Mb, 2Mb, 10Mb
	for k in 0 128Kb 256Kb 1000Kb 2000Kb 10000Kb
	do
	#i indica la simulazione corrente per il flusso con valore di CBR: 128kb, 256kb, 1Mb, 2Mb, 10Mb (1 < k < 5)
		for (( i = 1; $i <= $runs; i = $i+1 ))
		do			
		rm -r -f sim$j-$k;
		done
	done
done
