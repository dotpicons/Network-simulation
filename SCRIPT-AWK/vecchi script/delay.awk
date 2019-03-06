BEGIN {
	delay = avg_delay = recvdNum = 0
	
}

{
	event = $1;
	time = $2;
	pkt_id = $12;
	src=$3;
	dst=$4;


	# Store packets send time
	if (event == "+") {
		
#memorizzo l'istante di tempo in cui il pacchetto identificato da pkt_id è generato a livello applicativo dalla sorgente
#sendTime è un vettore indicizzato con l'id del pacchetto
		sendTime[pkt_id] = time
		
	}

	# Update total received packets' size and store packets arrival time
	if (event == "r"){
	
#memorizzo l'istante di tempo in cui il pacchetto identificato da pkt_id è ricevuto a livello applicativo dalla destinazione
#recvTime è un vettore indicizzato con l'id del pacchetto
		recvTime[pkt_id] = time;
	
	
	}

}

END {
	

	
	for (i in recvTime) {

# sintassi del for: per ogni valore di i per cui esiste un elemento non vuoto nel vettore recvTime che memorizza i valori di "time" 
# si può usare anche la classica sintassi, es: for (i=0;i<i_max;i++) {
# oppure: for (i=0;i<length(rx_agt);i++) {
# dove rx_agt è un vettore  

	
# Compute average delay: somma dei delay dei pacchetti /numero di pacchetti ricevuti a destinazione
#il delay di ogni singolo pacchetto è calcolato come: istante di tempo in cui il pacchetto è ricevuto - istante di tempo in cui il pacchetto è trasmesso
		
		delay += recvTime[i] - sendTime[i]
		recvdNum ++
	}

	if (recvdNum != 0) {
		avg_delay = delay / recvdNum
	} else {
		avg_delay = 0
	}

	
	# Output
	if (recvdNum == 0) {
		printf("####################################################################\n" \
		       "#  Warning: no packets were received, simulation may be too short  #\n" \
		       "####################################################################\n\n")
	}

	#stampa il delay end-to-end calcolato in msec
	printf("%g\n", avg_delay*1000)



}


