BEGIN {
	avg_lost_pkt_ratio = 0;
	run_count = 0;
}

{

LINK_RATE = $1;
CBR_RATE = $2;
RUN_NUMBER = $3;
fid_number = $4;
lost_pkt_ratio = $5;

if (LINK_RATE == LINKrate) {

	if ((CBR_RATE == CBRrate)&&(fid_number == flow_id))
	{	
		ARRAY_LPR[CBR_RATE] += lost_pkt_ratio;
		run_count++;
	}

}
	

}

END {

for (i in ARRAY_LPR)
{
	if (ARRAY_LPR[i]!=0)
	{
		avg_lost_pkt_ratio = ARRAY_LPR[i]/run_count;

	} else {
		avg_lost_pkt_ratio = 0;
	}
}

	printf ("%-12g %-12g %-4g %-12g \n", LINKrate, CBRrate, flow_id, avg_lost_pkt_ratio)

}
