package main

import (
	"encoding/binary"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"os"
	"time"
)


type data struct {
    latency time.Duration
    bytes int
}



func main() {

    nFlag := flag.Int("n", 1, "number of requests")
    cFlag := flag.Int("c", 1, "number of concurrent requests")
    flag.Parse()


    var latencies []time.Duration
    var bytes []int


    if *cFlag > *nFlag {
        fmt.Fprintf(os.Stderr, "The number of concurent requests can not be greater than the number of requests\n")
        os.Exit(1)
    }

    /*
    if *nFlag % *cFlag != 0 {
        fmt.Printf("The number of concurrent requests is not proportional to the number of requests, requests sended: %v\n", *nFlag / *cFlag * *cFlag)
    }
    */

    transport := &http.Transport{
		Proxy: http.ProxyFromEnvironment,
		Dial: (&net.Dialer{
			Timeout:   30 * time.Second,
			KeepAlive: 10 * time.Minute,
		}).Dial,
		TLSHandshakeTimeout: 10 * time.Second,
	}

	client := &http.Client{
		Transport: transport,
	}


    initial_time := time.Now()


    for i := 0; i < *nFlag / *cFlag; i++ {

        ch := make(chan data)

        for j := 0; j < *cFlag; j++ {
            go sendRequest(ch, client)
        }

        for j := 0; j < *cFlag; j++ { 
            data := <- ch 
            latencies = append(latencies, data.latency)
            bytes = append(bytes, data.bytes)
        }

    }

    total_time := time.Since(initial_time)


    fmt.Printf("Time per request: %f [ms]\n", calcAverageLatency(latencies))
    fmt.Printf("Transfer rate: %f [Kbytes/s]\n", calcTPS(bytes, total_time))

}


func sendRequest(ch chan data, client *http.Client) {
    time_start := time.Now()
    resp, err := client.Get("http://localhost:3000")
    if err != nil {
        log.Fatal(err)
    }
    latency := time.Since(time_start)

    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        log.Fatal(err)
    }
    resp.Body.Close()

    bytes := binary.Size(body)

    d := data{latency: latency, bytes: bytes}

    ch <- d


}


func calcAverageLatency(s []time.Duration) float64 {
    var sum float64 = 0
    for i := range s {
        sum += float64(s[i].Milliseconds())
    }

    avg := sum/float64(len(s))

    return avg
}


func calcTPS(s []int, t time.Duration) float64 {
    var sum float64 = 0
    totalTime := t.Seconds()
    for i := range s {
        sum += float64(s[i])
    }

    fmt.Printf("Total of time of execution: %v\n [s]", totalTime)
    fmt.Printf("Total of bytes of execution: %v\n [bytes]", sum)

    avg := sum/totalTime/1000

    return avg
}