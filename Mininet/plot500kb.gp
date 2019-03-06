#!/usr/local/bin/gnuplot
# set jpeg output
set terminal jpeg
set output 'andamento500kb.jpeg'

set xlabel 'misure'
set ylabel 'Bandwidth'
set xrange [0:16]

plot 'nuovi' title 'ftp flow' with linespoints
