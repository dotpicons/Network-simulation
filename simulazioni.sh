#!/bin/bash
SECONDS=0
bash CONSUMI/calcolo_consumi.sh &
echo ''
echo '############# script bash che lancia le simulazioni e calcola le statistiche ##############'
echo -e '\n'

#indica il numero di runs, il seed dello scenario e la randomizzazione dei pacchetti CBR lato sorgente

runs=10
seed_line=1

if [[ $CBRvalue=="128Kb" ]]
then bash CONSUMI/top128.sh
fi &
if [[ $CBRvalue=="10Mb" ]]
then bash CONSUMI/top10.sh
fi &

#CBR_RANDOM_0="false"
#CBR_RANDOM_1=1
echo -e "La simulazione utilizza tre parametri numerici per categorizzare i dati risultanti, scritti nell'ordine: #1 - #2 - #3"
echo -e '\n################################################LEGENDA##############################################'
echo -e '\n#1 indica il rate del link tra il nodo 2 e il nodo 3;'
echo -e '\n#2 indica il rate del flusso CBR;'
echo -e '\n#3 indica il run corrente'
echo -e '\n'

mkdir -p RISULTATI-AWK
	
	#j indica il rate del collegamento tra il nodo 2 e il nodo 3, il quale può variare tra 500kb e 10Mb
	for j in 500Kb 10000Kb
	do
		rate_linkN2N3=$j

		#k indica il rate del flusso cbr, il quale può variare tra i seguenti valori: NO-CBR, 128kb, 256kb, 1Mb, 2Mb, 10Mb
		for k in 0 128Kb 256Kb 1000Kb 2000Kb 10000Kb
		do
			CBRvalue=$k

			#i indica la simulazione corrente per il flusso con valore di CBR: 128kb, 256kb, 1Mb, 2Mb, 10Mb (1 < k < 5)
			for (( i = 1; $i <= $runs; i = $i+1 ))
			do
				seed=$(sed -n "$seed_line"p random.log)			

				mkdir -p sim$j-$k/runs/$i-run

				echo -e '\n'
				echo "simulazioni in corso: $j rate del link tra n2 e n3 - $k rate del flusso CBR - $i #run"
				echo -e '\n'
				ns scenario.tcl $seed $rate_linkN2N3 $CBRvalue;

				mv out.nam sim$j-$k/runs/$i-run/
				mv trace_stat.tr sim$j-$k/runs/$i-run/
				
				#bash esecuzione-script.sh
				
				#calcola il THROUGHPUT cumulativo senza considerare i nodi intermedi
				awk -v RUN=$i -v CBRrate=$CBRvalue -v LINKrate=$rate_linkN2N3 -f SCRIPT-AWK/throughput.awk sim$j-$k/runs/$i-run/trace_stat.tr >> RISULTATI-AWK/risultati-throughput.txt;
				#calcola l'OVERHEAD senza considerare i pacchetti spediti ("inoltrati") dai nodi intermedi
				awk -v RUN=$i -v CBRrate=$CBRvalue -v LINKrate=$rate_linkN2N3 -f SCRIPT-AWK/overhead.awk sim$j-$k/runs/$i-run/trace_stat.tr >> RISULTATI-AWK/risultati-overhead.txt;
				
				while read fid_line
					do
					FID=$(sed -n "$fid_line"p flow_ids.log)
					
					#FID=$fid_line
					
					#calcola il RITARDO (DELAY) tra la trasmissione e la ricezione di un pacchetto al nodo di destinazione del flusso
					awk -v RUN=$i -v CBRrate=$CBRvalue -v LINKrate=$rate_linkN2N3 -v flow_id=$FID -f SCRIPT-AWK/delay-by-fid.awk sim$j-$k/runs/$i-run/trace_stat.tr >> RISULTATI-AWK/risultati-delay-by-fid.txt;

					#calcola il THROUGHPUT per ogni TIPO di FLUSSO senza considerare i nodi intermedi
					awk -v RUN=$i -v CBRrate=$CBRvalue -v LINKrate=$rate_linkN2N3 -v flow_id=$FID -f SCRIPT-AWK/thr-by-fid.awk sim$j-$k/runs/$i-run/trace_stat.tr >> RISULTATI-AWK/risultati-thr-by-fid.txt;

					#calcola il RATE di PACCHETTI PERSI in percentuale
					awk -v RUN=$i -v CBRrate=$CBRvalue -v LINKrate=$rate_linkN2N3 -v flow_id=$FID -f SCRIPT-AWK/lost-packet-ratio.awk sim$j-$k/runs/$i-run/trace_stat.tr >> RISULTATI-AWK/risultati-lost-pkt-ratio.txt;
					fid_line=$((fid_line+1))
				done < flow_ids.log

				seed_line=$((seed_line+1))
				
			done
		done
	done

duration=$SECONDS
echo "$(($duration / 60)) minuti e $(($duration % 60)) secondi passati."
