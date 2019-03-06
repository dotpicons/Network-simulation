reset

# set jpeg output
set terminal jpeg
set output 'throughput-cumulativo.jpeg'

set xlabel 'CBR rate (Kb/sec - logscale)'
set ylabel 'throughput (Kb/sec)'

set xrange [1:10200]
set yrange [400:4100]

set format y ''


set logscale x; set xtics ('0' 0, '128Kb' 128,'256Kb' 256, '1Mb' 1000, '2M' 2000, '10M' 10000)

set ytics 50

set style data linespoints

plot 'GNUPLOT-DATA/THROUGHPUT-CUMULATIVO/THROUGHPUT-GRAPH-DATA-BY-LINKRATE-1'  title '500Kb Linkrate', \
     'GNUPLOT-DATA/THROUGHPUT-CUMULATIVO/THROUGHPUT-GRAPH-DATA-BY-LINKRATE-2'  title '10000Kb Linkrate'


