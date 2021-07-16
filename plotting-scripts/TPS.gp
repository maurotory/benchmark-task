set xlabel "Requests"
set ylabel "Kbytes/sec"
set logscale x
plot "TPS.dat" using 1:2 with lines title "c=1", "TPS.dat" using 1:3 with lines title "c=20", "TPS.dat" using 1:4 with lines title "c=50", "TPS.dat" using 1:5 with lines title "c=80", "TPS.dat" using 1:6 with lines title "c=100"

set key right top
set terminal png size 400,300 enhanced font "Helvetica,10"
set output "TPS.png"
replot