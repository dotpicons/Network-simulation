BEGIN {

	delay = avg_delay = recvdNum = 0
	
}

{
	event = $1;
	time = $2;
	src = $3;
	dst = $4;
	fid = $8;
	pkt_id = $12;

	# Salva l'istante di partenza dei pacchetti.
	if ((event == "+") && (fid == flow_id)) {
		
		#memorizzo l'istante di tempo in cui il pacchetto identificato da pkt_id è generato a livello applicativo dalla sorgente
		#sendTime è un vettore indicizzato con l'id del pacchetto
		sendTime[pkt_id] = time
		
	}
	
	# Aggiorna il la dimensione totale dei pacchetti ricevuti e salva il tempo di arrivo di ciascuno.
	if ((event == "r") && (fid == flow_id)){
	
		#memorizzo l'istante di tempo in cui il pacchetto identificato da pkt_id è ricevuto a livello applicativo dalla destinazione
		#recvTime è un vettore indicizzato con l'id del pacchetto
		recvTime[pkt_id] = time;
	
	}

}

END {
	
	for (i in recvTime) { 

	
	# Compute average delay: somma dei delay dei pacchetti /numero di pacchetti ricevuti a destinazione
	# il delay di ogni singolo pacchetto è calcolato come: istante di tempo in cui il pacchetto è ricevuto - istante di tempo in cui il pacchetto è trasmesso
		
		delay += recvTime[i] - sendTime[i]
		recvdNum ++
	}

	if (recvdNum != 0) {
		avg_delay = delay / recvdNum
	} else {
		avg_delay = 0
	}

	
	# Output
	#if (recvdNum == 0) {
	#	printf ("#  Warning: no packets were received, simulation may be too short  #\n")
	#}

	#stampa il delay end-to-end calcolato in msec

	printf ("%-12g %-12g %-12g %-12g %-12gmsec \n", LINKrate, CBRrate, RUN, flow_id, avg_delay*1000)



}


