reset

# set jpeg output
set terminal jpeg
set output 'delay-by-fid.jpeg'

set xlabel 'CBR rate (Kb/sec - logscale)'
set ylabel 'delay (sec)'

set xrange [1:10200]
set yrange [0:16]

set logscale x; set xtics ('0' 0, '128Kb' 128,'256Kb' 256, '1Mb' 1000, '2M' 2000, '10M' 10000)

set ytics 1

set style data linespoints

plot 'GNUPLOT-DATA/DELAY-BY-FID/DELAY-GRAPH-DATA-BY-FID-1-LINKRATE-1' using 2:4 title '500Kb Linkrate - fid FTP', \
     'GNUPLOT-DATA/DELAY-BY-FID/DELAY-GRAPH-DATA-BY-FID-2-LINKRATE-1' using 2:4 title '500Kb Linkrate - fid CBR', \
     'GNUPLOT-DATA/DELAY-BY-FID/DELAY-GRAPH-DATA-BY-FID-1-LINKRATE-2' using 2:4 title '10000Kb Linkrate - fid FTP', \
     'GNUPLOT-DATA/DELAY-BY-FID/DELAY-GRAPH-DATA-BY-FID-2-LINKRATE-2' using 2:4 title '10000Kb Linkrate - fid CBR'


