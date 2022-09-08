package main

import (
	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/go-chi/chi"
	"log"
	"net/http"
	"os"

	"github.com/AndriyKalashnykov/graphlq-golang/graph"
	"github.com/AndriyKalashnykov/graphlq-golang/graph/generated"
	"github.com/AndriyKalashnykov/graphlq-golang/internal/auth"
	_ "github.com/AndriyKalashnykov/graphlq-golang/internal/auth"
	database "github.com/AndriyKalashnykov/graphlq-golang/internal/pkg/db/mysql"
)

const defaultPort = "8080"

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	router := chi.NewRouter()

	router.Use(auth.Middleware())

	database.InitDB()
	defer database.CloseDB()
	database.Migrate()
	server := handler.NewDefaultServer(generated.NewExecutableSchema(generated.Config{Resolvers: &graph.Resolver{}}))
	router.Handle("/", playground.Handler("GraphQL playground", "/query"))
	router.Handle("/query", server)

	log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)
	log.Fatal(http.ListenAndServe(":"+port, router))
}
