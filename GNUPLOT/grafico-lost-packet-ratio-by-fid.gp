reset

# set jpeg output
set terminal jpeg
set output 'lost-packet-ratio-by-fid.jpeg'

set xlabel 'CBR rate (Kb/sec - logscale)'
set ylabel 'lost packet ratio (%)'

set xrange [1:10200]
set yrange [0:100]

set logscale x; set xtics ('0' 0, '128Kb' 128,'256Kb' 256, '1Mb' 1000, '2M' 2000, '10M' 10000)

set ytics 2.5

set style data linespoints

plot 'GNUPLOT-DATA/LOST-PACKET-RATIO-BY-FID/LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1-LINKRATE-1' using 2:4 title '500Kb Linkrate - fid FTP', \
     'GNUPLOT-DATA/LOST-PACKET-RATIO-BY-FID/LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2-LINKRATE-1' using 2:4 title '500Kb Linkrate - fid CBR', \
     'GNUPLOT-DATA/LOST-PACKET-RATIO-BY-FID/LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-1-LINKRATE-2' using 2:4 title '10000Kb Linkrate - fid FTP', \
     'GNUPLOT-DATA/LOST-PACKET-RATIO-BY-FID/LOST-PACKET-RATIO-GRAPH-DATA-BY-FID-2-LINKRATE-2' using 2:4 title '10000Kb Linkrate - fid CBR'
