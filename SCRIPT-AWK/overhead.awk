BEGIN {


	cont_byte_tcp_rcv = 0;
	cont_byte_ack_tx = 0;
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
start_flow = $9;
end_flow = $10;
seq_id = $11;
pkt_id = $12;

if (type == "tcp")
{
	#CONTO IL PESO DEI PACCHETTI TCP GIUNTI CORRETTAMENTE A DESTINAZIONE
	if ((dst == int(end_flow))&&(event == "r"))
	{
		received[pkt_id] = 1;
		cont_byte_tcp_rcv = cont_byte_tcp_rcv + size;
	}
}
else if (type == "ack")
{
	#if ((dst == end_flow)&&(event == "r"))

	#CONTO IL PESO DEI PACCHETTI ACK TRASMESSI DAL NODO DI DESTINAZIONE DEL FLUSSO
	if ((src == int(start_flow))&&(event == "+"))
	{
		sent[pkt_id] = 1;
		cont_byte_ack_tx = cont_byte_ack_tx + size;
	}
}

}
END {
#calcolo overhead in BYTE:

overhead = cont_byte_ack_tx / cont_byte_tcp_rcv *100;


printf (" %-12g %-12g %-12g %-12g%% \n", LINKrate, CBRrate, RUN, overhead)

}
