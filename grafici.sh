#!/bin/bash

gnuplot GNUPLOT/grafico-overhead.gp

gnuplot GNUPLOT/grafico-thr-cumulativo.gp

gnuplot GNUPLOT/grafico-thr-by-fid.gp

gnuplot GNUPLOT/grafico-delay-by-fid.gp

gnuplot GNUPLOT/grafico-lost-packet-ratio-by-fid.gp
