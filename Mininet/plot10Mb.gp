#!/usr/local/bin/gnuplot
# set jpeg output
set terminal jpeg
set output 'andamento10Mb.jpeg'

set xlabel 'misure'
set ylabel 'Bandwidth'
set xrange [0:16]
set yrange [1.88:1.95]

plot 'nuovi' title 'ftp flow' with linespoints
