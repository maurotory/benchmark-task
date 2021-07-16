package main

import (
	"log"
	"fmt"
	"net/http"
)


func main() {
	
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
        fmt.Fprintf(w, "<h1>Hello World</h1>")
    })


    fmt.Printf("Starting server at port 3000\n")
    if err := http.ListenAndServe(":3000", nil); err != nil {
        log.Fatal(err)
    }
}