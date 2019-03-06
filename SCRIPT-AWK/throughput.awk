
BEGIN{

	cont_byte_tx = 0;
	first_pkt_rx = 0;

}
{

#assegno le etichette alle colonne del file trace_stat.tr
event = $1;
time = $2;
src = $3;
dst = $4;
type = $5;
size = $6;
fid = $8;
flow_start = $9;
flow_end = $10;
seq_number = $11;
pkt_id = $12;

	if (event == "+")
	{	
		if (first_pkt_rx == 0)
		{		
			start_time = time;
			first_pkt_rx = 1;
		}
	}

	if ((event == "r")&&(dst == flow_end))
	{	
		cont_byte_rx = cont_byte_rx + size;
		last_time = time;
	}

}

END{

#calcolo throughput normalizzato su 1000 bit (1 kbit)

simulation_time = last_time - start_time;
throughput = (cont_byte_rx * 8/simulation_time)/1000;

printf (" %-12g %-12g %-12g %-12g %-12g Kb/sec \n", LINKrate, CBRrate, RUN, simulation_time, throughput)

}
