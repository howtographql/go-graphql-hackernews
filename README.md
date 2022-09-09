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
finally run the server: 
```bash
make run
```
Now navigate to https://localhost:8080 you can see graphiql playground and query the graphql server.

#### createUser

Execute createUser

```graphql
mutation createUser {
  createUser(input: {username: "usr2", password: "pwd"})
}
```

Expected output similar to:

```json
{
  "data": {
    "createUser": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3MzgyNDQsInVzZXJuYW1lIjoidXNyMiJ9.z0yrV6ajZO8IqFBlEuTwAnKRP-C15MuL1REmjJ5YYU8"
  }
}
```

#### loginUser

Execute loginUser

```graphql
mutation loginUser {
  login(input: {username: "usr2", password: "pwd"})
}
```

Expected output similar to:

```json
{
  "data": {
    "login": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3MzgyNDQsInVzZXJuYW1lIjoidXNyMiJ9.z0yrV6ajZO8IqFBlEuTwAnKRP-C15MuL1REmjJ5YYU8"
  }
}
```

#### createLink

Set Authorization Header, use token from loginUser

```graphql
{
  "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3MzgyNDQsInVzZXJuYW1lIjoidXNyMiJ9.z0yrV6ajZO8IqFBlEuTwAnKRP-C15MuL1REmjJ5YYU8"
}
```

Execute createLink


```graphql
mutation createLink {
  createLink(input: {title: "real link!", address: "www.graphql.org"}) {
    user {
      name
    }
  }
}
```

Expected output similar to:

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

Execute findLinks


```graphql
query findLinks {
  links {
    title
    address
    id
  }
}
```

Expected output similar to:

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

Execute refreshToken, provide current token as an input 


```graphql
mutation refreshToken{
  refreshToken(input: {
    token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3MzgyNDQsInVzZXJuYW1lIjoidXNyMiJ9.z0yrV6ajZO8IqFBlEuTwAnKRP-C15MuL1REmjJ5YYU8"
  })
}
```

Expected output similar to:

```json
{
  "data": {
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjI3Mzg5NjYsInVzZXJuYW1lIjoidXNyMiJ9.fKK07Zv6iuq6ep9FtV3CE7z_KDm7ljnZqRvePokSOEs"
  }
}
```

### Tutorial
to see the tutorial visit https://www.howtographql.com/graphql-go/0-introduction/

