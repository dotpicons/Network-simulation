BEGIN {
	avg_delay = 0;
	run_count = 0;
}

{

LINK_RATE = $1;
CBR_RATE = $2;
RUN_NUMBER = $3;
fid_number = $4;
delay = $5;

if (LINK_RATE == LINKrate) {

	if ((CBR_RATE == CBRrate)&&(fid_number == flow_id))
	{

		ARRAY_DELAY[CBR_RATE] += delay;
		run_count++;

	}

}
	

}

END {

for (i in ARRAY_DELAY)
{
	if (ARRAY_DELAY[i]!=0)
	{
		avg_delay = ARRAY_DELAY[i]/run_count;
	} else {
		avg_delay = " -nan";
	}
}



	printf ("%-12g %-12g %-4g %-12g \n", LINKrate, CBRrate, flow_id, avg_delay)

}
