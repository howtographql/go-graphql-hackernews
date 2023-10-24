[![CI](https://github.com/AndriyKalashnykov/graphql-golang/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/AndriyKalashnykov/graphql-golang/actions/workflows/ci.yml)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FAndriyKalashnykov%2Fgraphql-golang&count_bg=%2340C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://app.renovatebot.com/dashboard#github/AndriyKalashnykov/graphql-golang)
# GraphQL Server (schema-first) With Golang

## Table Of Contents
- [GraphQL Server (schema-first) With Golang](#graphql-server-schema-first-with-golang)
  - [Table Of Contents](#table-of-contents)
    - [How to Run The Project <a name="how-to-run-project"></a>](#how-to-run-the-project-)
      - [createUser](#createuser)
      - [loginUser](#loginuser)
      - [createLink](#createlink)
      - [findLinks](#findlinks)
      - [refreshToken](#refreshtoken)
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

Run the server: 

```bash
make run
```
Navigate to https://localhost:8080 you can see graphiql playground and query the graphql server.

```bash
xdg-open http://localhost:8080/
```

#### createUser

Execute createUser mutation

```graphql
mutation createUser {
  createUser(input: {username: "usr2", password: "pwd"})
}
```

Expected JSON result:

```json
{
  "data": {
    "createUser": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3MzgyNDQsInVzZXJuYW1lIjoidXNyMiJ9.z0yrV6ajZO8IqFBlEuTwAnKRP-C15MuL1REmjJ5YYU8"
  }
}
```

#### loginUser

Execute loginUser mutation

```graphql
mutation loginUser {
  login(input: {username: "usr2", password: "pwd"})
}
```

Expected JSON result:

```json
{
  "data": {
    "login": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3MzgyNDQsInVzZXJuYW1lIjoidXNyMiJ9.z0yrV6ajZO8IqFBlEuTwAnKRP-C15MuL1REmjJ5YYU8"
  }
}
```

#### createLink

Set Authorization Header, use token from loginUser

```json
{
  "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3MzgyNDQsInVzZXJuYW1lIjoidXNyMiJ9.z0yrV6ajZO8IqFBlEuTwAnKRP-C15MuL1REmjJ5YYU8"
}
```

Execute createLink mutation


```graphql
mutation createLink {
  createLink(input: {title: "real link!", address: "www.graphql.org"}) {
    user {
      name
    }
  }
}
```

Expected JSON result:

```json
{
  "data": {
    "createLink": {
      "user": {
        "name": "usr2"
      }
    }
  }
}
```

#### findLinks

Execute findLinks query


```graphql
query findLinks {
  links {
    title
    address
    id
  }
}
```

Expected JSON result:

```json
{
  "data": {
    "links": [
      {
        "title": "real link!",
        "address": "www.graphql.org",
        "id": "1"
      },
      {
        "title": "real link!",
        "address": "www.graphql.org",
        "id": "2"
      }
    ]
  }
}
```


#### refreshToken

Execute refreshToken mutation, provide current token as an input 


```graphql
mutation refreshToken{
  refreshToken(input: {
    token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3MzgyNDQsInVzZXJuYW1lIjoidXNyMiJ9.z0yrV6ajZO8IqFBlEuTwAnKRP-C15MuL1REmjJ5YYU8"
  })
}
```

Expected JSON result:

```json
{
  "data": {
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3Mzg5NjYsInVzZXJuYW1lIjoidXNyMiJ9.fKK07Zv6iuq6ep9FtV3CE7z_KDm7ljnZqRvePokSOEs"
  }
}
```

### Tutorial
to see the tutorial visit https://www.howtographql.com/graphql-go/0-introduction/
