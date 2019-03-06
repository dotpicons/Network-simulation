#!/usr/local/bin/gnuplot

reset

# set jpeg output
set terminal jpeg
set output 'overhead.jpeg'

set xlabel 'CBR rate (Kb/sec - logscale)'
set ylabel 'overhead (%)'

set xrange [1:10200]
set yrange [0:10]


set logscale x; set xtics ('0' 0, '128Kb' 128,'256Kb' 256, '1Mb' 1000, '2M' 2000, '10M' 10000)

set ytics 1

set style data linespoints

plot 'GNUPLOT-DATA/OVERHEAD/OVERHEAD-GRAPH-DATA-BY-LINKRATE-1'  title '500Kb Linkrate', \
     'GNUPLOT-DATA/OVERHEAD/OVERHEAD-GRAPH-DATA-BY-LINKRATE-2'  title '10000Kb Linkrate'


