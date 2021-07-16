set xlabel "Requests"
set ylabel "%CPU"
set logscale x

plot "cpu.dat" using 1:2 with lines title "c=1", "cpu.dat" using 1:3 with lines title "c=20", "cpu.dat" using 1:4 with lines title "c=50", "cpu.dat" using 1:5 with lines title "c=80", "cpu.dat" using 1:6 with lines title "c=100"

set key right top
set terminal png size 400,300 enhanced font "Helvetica,10"
set output "cpu.png"
replot