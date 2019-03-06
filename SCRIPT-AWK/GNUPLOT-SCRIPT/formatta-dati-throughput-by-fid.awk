BEGIN {
	avg_thr = 0;
	run_count = 0;
}

{

LINK_RATE = $1;
CBR_RATE = $2;
RUN_NUMBER = $3;
fid_number = $4;
simulation_time = $5;
throughput = $6;

if (LINK_RATE == LINKrate) {

	if ((CBR_RATE == CBRrate)&&(fid_number == flow_id))
	{	
		if (simulation_time != -1)
		{
			ARRAY_CBR[CBR_RATE] += throughput;
			run_count++;
		} 
		else 
		{
			
			ARRAY_CBR[CBR_RATE] += "-nan";
		}

	}

}

}
END {

for (i in ARRAY_CBR)
{
	if (ARRAY_CBR[CBR_RATE] != "-nan")
	{
		avg_thr = ARRAY_CBR[i]/run_count;
	} else {
		avg_thr = "-nan"
	}

}



	printf ("%-12g %-12g %-4g %-12g \n", LINKrate, CBRrate, flow_id, avg_thr)

}
