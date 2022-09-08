---
title: ‌Introduction To GraphQL Server With Golang
published: false
description: Introduction to GraphQL Server with Golang and Gqlgen.
tags: graphql, go, api, gqlgen
---
## Table Of Contents
- [Table Of Contents](#table-of-contents)
  - [How to Run The Project <a name="how-to-run-project"></a>](#how-to-run-the-project-)
  - [Tutorial](#tutorial)
  
  
### How to Run The Project <a name="how-to-run-project"></a>
First start mysql server with docker:
```bash
docker run -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=dbpass -e MYSQL_DATABASE=hackernews -d mysql:latest
```
Then create a Table names hackernews for our app:
```sql
docker exec -it mysql bash
mysql -u root -p
CREATE DATABASE hackernews;
```
finally run the server: 
```bash
go run server.go
```
Now navigate to https://localhost:8080 you can see graphiql playground and query the graphql server.


### Tutorial
to see the latest version of tutorial visit https://www.howtographql.com/graphql-go/0-introduction/
