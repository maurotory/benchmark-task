 #!/bin/bash
 

 for i in {100,1000,10000,100000,1000000}
 do
    for j in {1,20,50,80,100}
    do  
        go run ./goab/goab.go -c $j -n $i  http://localhost:3000/ >> results.tmp & \
        top -n 1 -b | grep $1 | awk '{print $9}' >> cpu.tmp & \
        wait


        cat results.tmp | grep -m 1 "Time per request" | awk '{print $4}' >> latency.tmp
        cat results.tmp | grep -m 1 "Transfer rate" | awk '{print $3}' >> TPS.tmp

        rm results.tmp
    done

    x=$(cat latency.tmp)
    echo $x | sed "s/^/$i /" >> latency.dat
    x=$(cat TPS.tmp)
    echo $x | sed "s/^/$i /" >> TPS.dat
    x=$(cat cpu.tmp)
    echo $x | sed "s/^/$i /" >> cpu.dat

    rm latency.tmp
    rm TPS.tmp
    rm cpu.tmp

 done

