 #!/bin/bash


#Creates plots

gnuplot ./plotting-scripts/latency.gp
gnuplot ./plotting-scripts/TPS.gp
gnuplot ./plotting-scripts/cpu.gp


#Creates tables for markdown

echo "|Requests | c=1  | c=20 | c=50  | c=80 | c=100|" >> latency.md
echo "| ------ | :---: | :---: | :---: | :---: | ----: |" >> latency.md
sed 's/ /|/g' latency.dat | sed 's/^/|/g' | sed 's/$/|/g' >> latency.md
echo "|Requests | c=1  | c=20 | c=50  | c=80 | c=100|" >> TPS.md
echo "| ------ | :---: | :---: | :---: | :---: | ----: |" >> TPS.md
sed 's/ /|/g' TPS.dat | sed 's/^/|/g' | sed 's/$/|/g' >> TPS.md
echo "|Requests | c=1  | c=20 | c=50  | c=80 | c=100|" >> cpu.md
echo "| ------ | :---: | :---: | :---: | :---: | ----: |" >> cpu.md
sed 's/ /|/g' cpu.dat | sed 's/^/|/g' | sed 's/$/|/g' >> cpu.md
