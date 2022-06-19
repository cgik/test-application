package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
)

type BodyReq struct {
	Content string
}

func DatabaseHandler(action string, contents string) {
	db, err := sql.Open("mysql", "testuser:mypassword@tcp(127.0.0.1:3306)/testdb")
	if err != nil {
		log.Panic(err)
	}

	if err := db.Ping(); err != nil {
		log.Panic(err)
	}
	log.Print("Database Connected")

	defer db.Close()
}

func Reverse(s string) string {
	r := []rune(s)
	for i, j := 0, len(r)-1; i < len(r)/2; i, j = i+1, j-1 {
		r[i], r[j] = r[j], r[i]
	}
	return string(r)
}

func HealthCheck(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
}

func ReverseHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == "POST" {
		var b BodyReq

		err := json.NewDecoder(r.Body).Decode(&b)

		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
		}

		DatabaseHandler("1", "2")
		fmt.Fprintf(w, "%v", Reverse("Hello World"))
	} else {
		http.Error(w, "Error: Not using POST method.", http.StatusBadRequest)
	}
}

func ReadDatabase(w http.ResponseWriter, r *http.Request) {
	// if r.Method == "POST" {
	// 	stmtOut, err := db.Prepare("SELECT squareNumber FROM squarenum WHERE number = ?")
	// }

}

func main() {

	http.HandleFunc("/call", ReverseHandler)
	http.HandleFunc("/ping", HealthCheck)
	http.HandleFunc("/read", ReadDatabase)

	log.Print("Server Start on 0.0.0.0:9999")
	if err := http.ListenAndServe(":9999", nil); err != nil {
		log.Panic(err)
	}
}
