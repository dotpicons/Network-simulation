BEGIN {
	
	cont_pkt_tx = 0;
	cont_pkt_dr = 0;
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
pkt_id = $12;

if (event == "+" && send[pkt_id] == 0 && fid = flow_id)
{
	send[pkt_id] = 1;
	cont_pkt_tx = cont_pkt_tx + 1;

}
else if (event == "d" && receive[pkt_id] == 0 && fid = flow_id)
{	
	drop[pkt_id] = 1;
	cont_pkt_dr = cont_pkt_dr + 1;
}

}
END {
#calcolo lost packet ratio in percentuale
l_pkt_ratio = (cont_pkt_dr / cont_pkt_tx)*100;

printf ("%-12g %-12g %-12g %-12g %-12g%%\n", LINKrate, CBRrate, RUN, flow_id, l_pkt_ratio)

}
