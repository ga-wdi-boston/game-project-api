![General Assembly Logo](http://i.imgur.com/ke8USTq.png)

# A Tic-tac-toe data store API

## API end-points

Verb  | URI Pattern        | Controller#Action
----  | -----------        | -----------------
POST  | `/login`           | `users#login`
POST  | `/register`        | `users#create`
GET   | `/games`           | `games#index`
POST  | `/games`           | `games#create`
GET   | `/games/:id`       | `games#show`
PATCH | `/games/:id`       | `games#update`
GET   | `/games/:id/watch` | `games#watch`


All API actions, except `watch`, expect data in the request body to be JSON,  `Content-Type:application/json; charset=utf-8`, and return data, if any, as JSON in the response body.

---
## User actions
*Summary:*
<table>
<tr>
  <th colspan="3">Request</th>
  <th colspan="2">Response</th>
</tr>
<tr>
  <th>Verb</th>
  <th>URI</th>
  <th>body</th>
  <th>Status</th>
  <th>body</th>
</tr>
<tr>
<td>POST</td>
<td>`/login`</td>
<td>**credentials**</td>
<td>200, Success</td>
<td>**token**</td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>401, Unauthorized</td>
  <td>_empty_</td>
</tr>
<tr>
<td>POST</td>
<td>`/register`</td>
<td>**credentials**</td>
<td>201, Created</td>
<td>**user**</td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td>_empty_</td>
</tr>
</table>

### login

The `login` action expects *POST*-ed `credentials` identifying a previously registered user, e.g.:
```json
{
  "credentials": {
    "email": "an@example.email",
    "password": "an example password"
  }
}
```
If the request is successful, the response will have an HTTP Status of 200, Success, and the body will be JSON containing a token used to authenticate other requests, e.g.:
```json
{
  "token": "an example authentication token"
}
```
If the request is unsuccessful, the response will have an HTTP Status of 401, Unauthorized, and the response body will be empty.

### create

The `create` action expects *POST*-ed `credentials` identifying a new user to create, e.g.:
```json
{
  "credentials": {
    "email": "an@example.email",
    "password": "an example password",
    "password_confirmation": "an example password"
  }
}
```
If the request is successful, the response will have an HTTP Status of 201, Created, and the body will be JSON containing the `id` and `email` of the new user, e.g.:
```json
{
  "id": 1,
  "email": "an@example.email"
}
```
If the request is unsuccessful, the response will have an HTTP Status of 400, Bad Request, and the response body will be empty.

## Game actions
All games action requests must include a valid HTTP header `Authorization: Token token=<token>` or they will be rejected with a status of 401, Unauthorized.

Games are associated with users, `player_x` and `player_o`.  Actions will only retrieve a game if the user associated with the `Authorization` header is one of those two users.

*Summary:*
<table>
<tr>
  <th colspan="3">Request</th>
  <th colspan="2">Response</th>
</tr>
<tr>
  <th>Verb</th>
  <th>URI</th>
  <th>body</th>
  <th>Status</th>
  <th>body</th>
</tr>
<tr>
<td>GET</td>
<td>`/games[?over=<true|false>]`</td>
<td>n/a</td>
<td>200, Success</td>
<td>**games found**</td>
</tr>
<tr>
  <td colspan="3">
  The optional `over` query parameter specifies whether to retrieve games that have been marked completed
  </td>
  <td>401, Unauthorized</td>
  <td>_empty_</td>
</tr>
<tr>
  <td colspan="3">
  The default is to retrieve only those games that have over equal to false.
  </td>
  <td>404, Not Found</td>
  <td>_empty_</td>
</tr>
<tr>
<td>POST</td>
<td>`/games`</td>
<td>n/a</td>
<td>201, Created</td>
<td>**game created**</td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>401, Unauthorized</td>
  <td>_empty_</td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>404, Not Found</td>
  <td>_empty_</td>
</tr>
<tr>
<td>GET</td>
<td>`/games/:id`</td>
<td>n/a</td>
<td>200, Success</td>
<td>**game found**</td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>401, Unauthorized</td>
  <td>_empty_</td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>404, Not Found</td>
  <td>_empty_</td>
</tr>
<tr>
<td>PATCH</td>
<td>`/games/:id`</td>
<td>_empty_</td>
<td>200, Success</td>
<td>**game joined**</td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td>**errors**</td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td>_empty_</td>
</tr>
<tr>
<td>PATCH</td>
<td>`/games/:id`</td>
<td>**game delta**</td>
<td>200, Success</td>
<td>**game updated**</td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td>**errors**</td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td>_empty_</td>
</tr>
</table>

### index

### create

### show

### update

#### Join a game as player 'o'

#### Update a games states

```json
{
  "game": {
    "cell": {
      "index": -1,
      "value": ""
    },
    "over": false
  }
}
```

### watch
