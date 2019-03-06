BEGIN {
	avg_thr = 0;
	run_count = 0;
}

{

LINK_RATE = $1;
CBR_RATE = $2;
RUN_NUMBER = $3;
SIMULATION_TIME = $4;
THROUGHPUT = $5;

if (LINK_RATE == LINKrate) {

	if (CBR_RATE == CBRrate)
	{	
		ARRAY_CBR[CBR_RATE] += THROUGHPUT;
		run_count++;
	}

}
	

}

END {

for (i in ARRAY_CBR)
{
	if (ARRAY_CBR[i]!=0)
	{
		avg_thr = ARRAY_CBR[i]/run_count;
	} else {
		avg_thr = 0;
	}
}



	printf (" %-12g %-12g \n", CBRrate, avg_thr)

}
