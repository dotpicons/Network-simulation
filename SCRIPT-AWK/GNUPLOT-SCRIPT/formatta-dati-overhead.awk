BEGIN {
	run_count = 0;
}

{

LINK_RATE = $1;
CBR_RATE = $2;
RUN_NUMBER = $3;
overhead = $4;

if (LINK_RATE == LINKrate) {

	if (CBR_RATE == CBRrate)
	{	
		if (overhead != "-nan")
			{
				ARRAY_CBR[CBR_RATE] += overhead;
				run_count++;
			}
	}

}
	

}

END {

for (i in ARRAY_CBR)
{
	#if (ARRAY_CBR[i]!=0)
	#{
		avg_overhead = ARRAY_CBR[i]/run_count;
	#} 
	# else {
	#	avg_overhead = "-nan";
	# }
}



	printf (" %-12g %-12s \n", CBRrate, avg_overhead)

}
