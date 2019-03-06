#!/bin/bash

python progetto.py
echo "Digitare 1 per avere il grafico del rate 10Mb, 2 per quello da 500kb e premere INVIO (digitare altro non darà risultati)"
read a
if [ "$a" -eq "1" ]; then  
gnuplot plot10Mb.gp
xdg-open andamento10Mb.jpeg
elif [ "$a" -eq "2" ]; then
gnuplot plot500kb.gp
xdg-open andamento500kb.jpeg
fi
mn -c
fuser -k 6653/tcp
fuser -k 5566/tcp

echo "Eseguito correttamente, i grafici si trovano in questa directory"


