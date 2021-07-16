set xlabel "Requests"
set ylabel "Latency (ms)"
set logscale x
plot "latency.dat" using 1:2 with lines title "c=1", "latency.dat" using 1:3 with lines title "c=20", "latency.dat" using 1:4 with lines title "c=50", "latency.dat" using 1:5 with lines title "c=80", "latency.dat" using 1:6 with lines title "c=100"

set key right top
set terminal png size 400,300 enhanced font "Helvetica,10"
set output "latency.png"
replot
