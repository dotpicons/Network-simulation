mkdir -p GNUPLOT-DATA

	
#j indica il rate del collegamento tra il nodo 2 e il nodo 3, il quale può variare tra 500kb e 10Mb
for j in 500 10000
do
	rate_linkN2N3=$j

	#k indica il rate del flusso cbr, il quale può variare tra i seguenti valori: NO-CBR, 128kb, 256kb, 1Mb, 2Mb, 10Mb
	for k in 0 128 256 1000 2000 10000
	do
		CBRvalue=$k

		#calcola le medie su 10 run del throughput, dati il rate del link intermedio (LINKrate) e il rate del CBR (CBRrate)
		awk -v LINKrate=$rate_linkN2N3 -v CBRrate=$CBRvalue -f SCRIPT-AWK/GNUPLOT-SCRIPT/formatta-dati-throughput.awk RISULTATI-AWK/risultati-throughput.txt >> GNUPLOT-DATA/plot-thr.txt
		#calcola le medie su 10 run dell'overhead, dati il rate del link intermedio (LINKrate) e il rate del CBR (CBRrate)
		awk -v LINKrate=$rate_linkN2N3 -v CBRrate=$CBRvalue -f SCRIPT-AWK/GNUPLOT-SCRIPT/formatta-dati-overhead.awk RISULTATI-AWK/risultati-overhead.txt >> GNUPLOT-DATA/plot-overhead.txt

		while read fid_line
		do
			FID=$(sed -n "$fid_line"p flow_ids.log)
			#FID=$fid_line

			#calcola le medie su 10 run del throughput per ogni flusso, dati il rate del link intermedio (LINKrate) e il rate del CBR (CBRrate)
			awk -v LINKrate=$rate_linkN2N3 -v CBRrate=$CBRvalue -v flow_id=$FID -f SCRIPT-AWK/GNUPLOT-SCRIPT/formatta-dati-throughput-by-fid.awk RISULTATI-AWK/risultati-thr-by-fid.txt >> GNUPLOT-DATA/plot-thr-by-fid.txt
			
			#calcola le medie su 10 run del delay per ogni flusso, dati il rate del link intermedio (LINKrate) e il rate del CBR (CBRrate)
			awk -v LINKrate=$rate_linkN2N3 -v CBRrate=$CBRvalue -v flow_id=$FID -f SCRIPT-AWK/GNUPLOT-SCRIPT/formatta-dati-delay-by-fid.awk RISULTATI-AWK/risultati-delay-by-fid.txt >> GNUPLOT-DATA/plot-delay-by-fid.txt

			#calcola le medie su 10 run del rate di pacchetti persi, dati il rate del link intermedio (LINKrate) e il rate del CBR (CBRrate)	
			awk -v LINKrate=$rate_linkN2N3 -v CBRrate=$CBRvalue -v flow_id=$FID -f SCRIPT-AWK/GNUPLOT-SCRIPT/formatta-dati-lost-pkt-ratio-by-fid.awk RISULTATI-AWK/risultati-lost-pkt-ratio.txt >> GNUPLOT-DATA/plot-lost-pkt-ratio-by-fid.txt

			fid_line=$((fid_line+1))
		done < flow_ids.log
	done
done

#Manipola i risultati in un formato leggibile da gnuplot

#throughput cumulativo
awk 'NR%6==1{x="THROUGHPUT-GRAPH-DATA-BY-LINKRATE-"++i;}{print > x;}' GNUPLOT-DATA/plot-thr.txt
rm GNUPLOT-DATA/plot-thr.txt
mkdir -p GNUPLOT-DATA/THROUGHPUT-CUMULATIVO
mv THROUGHPUT-GRAPH-DATA-BY-LINKRATE-1 GNUPLOT-DATA/THROUGHPUT-CUMULATIVO/
mv THROUGHPUT-GRAPH-DATA-BY-LINKRATE-2 GNUPLOT-DATA/THROUGHPUT-CUMULATIVO/

#overhead
awk 'NR%6==1{x="OVERHEAD-GRAPH-DATA-BY-LINKRATE-"++i;}{print > x;}' GNUPLOT-DATA/plot-overhead.txt
rm GNUPLOT-DATA/plot-overhead.txt
mkdir -p GNUPLOT-DATA/OVERHEAD
mv OVERHEAD-GRAPH-DATA-BY-LINKRATE-1 GNUPLOT-DATA/OVERHEAD/
mv OVERHEAD-GRAPH-DATA-BY-LINKRATE-2 GNUPLOT-DATA/OVERHEAD/

#lost-pkt-ratio
awk '{print $0|"sort -n -k3,3 -k2,2 "}' GNUPLOT-DATA/plot-lost-pkt-ratio-by-fid.txt >> GNUPLOT-DATA/plot-lp-ratio.txt
awk 'NR%12==1{x="LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-"++i;}{print > x;}' GNUPLOT-DATA/plot-lp-ratio.txt
rm GNUPLOT-DATA/plot-lost-pkt-ratio-by-fid.txt
rm GNUPLOT-DATA/plot-lp-ratio.txt

awk '{print $0|"sort -n -k1,1 -k2,2"}' LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1 >> LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1-SORTED
awk '{print $0|"sort -n -k1,1 -k2,2"}' LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2 >> LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2-SORTED
rm LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1
rm LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2

awk 'NR%6==1{x="LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1-LINKRATE-"++i;}{print > x;}' LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1-SORTED
awk 'NR%6==1{x="LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2-LINKRATE-"++i;}{print > x;}' LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2-SORTED
rm LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1-SORTED
rm LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2-SORTED
mkdir -p GNUPLOT-DATA/LOST-PACKET-RATIO-BY-FID
mv LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1-LINKRATE-1 GNUPLOT-DATA/LOST-PACKET-RATIO-BY-FID/
mv LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2-LINKRATE-1 GNUPLOT-DATA/LOST-PACKET-RATIO-BY-FID/
mv LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1-LINKRATE-2 GNUPLOT-DATA/LOST-PACKET-RATIO-BY-FID/
mv LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2-LINKRATE-2 GNUPLOT-DATA/LOST-PACKET-RATIO-BY-FID/

#thr_by_fid
awk '{print $0|"sort -n -k3,3 -k2,2 "}' GNUPLOT-DATA/plot-thr-by-fid.txt >> GNUPLOT-DATA/plot-thr-by-flow-id.txt
awk 'NR%12==1{x="THR-GRAPH-DATA-BY-FID-"++i;}{print > x;}' GNUPLOT-DATA/plot-thr-by-flow-id.txt
rm GNUPLOT-DATA/plot-thr-by-fid.txt
rm GNUPLOT-DATA/plot-thr-by-flow-id.txt

awk '{print $0|"sort -n -k1,1 -k2,2"}' THR-GRAPH-DATA-BY-FID-1 >> THR-GRAPH-DATA-BY-FID-1-SORTED
awk '{print $0|"sort -n -k1,1 -k2,2"}' THR-GRAPH-DATA-BY-FID-2 >> THR-GRAPH-DATA-BY-FID-2-SORTED
rm THR-GRAPH-DATA-BY-FID-1
rm THR-GRAPH-DATA-BY-FID-2

awk 'NR%6==1{x="THR-GRAPH-DATA-BY-FID-1-LINKRATE-"++i;}{print > x;}' THR-GRAPH-DATA-BY-FID-1-SORTED
awk 'NR%6==1{x="THR-GRAPH-DATA-BY-FID-2-LINKRATE-"++i;}{print > x;}' THR-GRAPH-DATA-BY-FID-2-SORTED
rm THR-GRAPH-DATA-BY-FID-1-SORTED
rm THR-GRAPH-DATA-BY-FID-2-SORTED
mkdir -p GNUPLOT-DATA/THR-BY-FID
mv THR-GRAPH-DATA-BY-FID-1-LINKRATE-1 GNUPLOT-DATA/THR-BY-FID/
mv THR-GRAPH-DATA-BY-FID-2-LINKRATE-1 GNUPLOT-DATA/THR-BY-FID/
mv THR-GRAPH-DATA-BY-FID-1-LINKRATE-2 GNUPLOT-DATA/THR-BY-FID/
mv THR-GRAPH-DATA-BY-FID-2-LINKRATE-2 GNUPLOT-DATA/THR-BY-FID/

#delay_by_fid
awk '{print $0|"sort -n -k3,3 -k2,2 "}' GNUPLOT-DATA/plot-delay-by-fid.txt >> GNUPLOT-DATA/plot-delay-by-flow-id.txt
awk 'NR%12==1{x="DELAY-GRAPH-DATA-BY-FID-"++i;}{print > x;}' GNUPLOT-DATA/plot-delay-by-flow-id.txt
rm GNUPLOT-DATA/plot-delay-by-fid.txt
rm GNUPLOT-DATA/plot-delay-by-flow-id.txt

awk '{print $0|"sort -n -k1,1 -k2,2"}' DELAY-GRAPH-DATA-BY-FID-1 >> DELAY-GRAPH-DATA-BY-FID-1-SORTED
awk '{print $0|"sort -n -k1,1 -k2,2"}' DELAY-GRAPH-DATA-BY-FID-2 >> DELAY-GRAPH-DATA-BY-FID-2-SORTED
rm DELAY-GRAPH-DATA-BY-FID-1
rm DELAY-GRAPH-DATA-BY-FID-2

awk 'NR%6==1{x="DELAY-GRAPH-DATA-BY-FID-1-LINKRATE-"++i;}{print > x;}' DELAY-GRAPH-DATA-BY-FID-1-SORTED
awk 'NR%6==1{x="DELAY-GRAPH-DATA-BY-FID-2-LINKRATE-"++i;}{print > x;}' DELAY-GRAPH-DATA-BY-FID-2-SORTED
rm DELAY-GRAPH-DATA-BY-FID-1-SORTED
rm DELAY-GRAPH-DATA-BY-FID-2-SORTED
mkdir -p GNUPLOT-DATA/DELAY-BY-FID
mv DELAY-GRAPH-DATA-BY-FID-1-LINKRATE-1 GNUPLOT-DATA/DELAY-BY-FID/
mv DELAY-GRAPH-DATA-BY-FID-2-LINKRATE-1 GNUPLOT-DATA/DELAY-BY-FID/
mv DELAY-GRAPH-DATA-BY-FID-1-LINKRATE-2 GNUPLOT-DATA/DELAY-BY-FID/
mv DELAY-GRAPH-DATA-BY-FID-2-LINKRATE-2 GNUPLOT-DATA/DELAY-BY-FID/
