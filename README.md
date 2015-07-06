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
<td><strong>credentials</strong></td>
<td>200, OK</td>
<td><strong>token</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>401, Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>POST</td>
<td>`/register`</td>
<td><strong>credentials</strong></td>
<td>201, Created</td>
<td><strong>user</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td><em>empty</em></td>
</tr>
</table>

### login

The `login` action expects a *POST* with `credentials` identifying a previously registered user, e.g.:
```json
{
  "credentials": {
    "email": "an@example.email",
    "password": "an example password"
  }
}
```
If the request is successful, the response will have an HTTP Status of 200, OK, and the body will be JSON containing a token used to authenticate other requests, e.g.:
```json
{
  "token": "an example authentication token"
}
```
If the request is unsuccessful, the response will have an HTTP Status of 401, Unauthorized, and the response body will be empty.

### create

The `create` action expects a *POST* of `credentials` identifying a new user to create, e.g.:
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

Games are associated with users, `player_x` and `player_o`.  Actions, other than update, will only retrieve a game if the user associated with the `Authorization` header is one of those two users.  If this requirement is unmet, the response will be 404, Not Found, except for the index action which will return an empty games array.  

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
<td>200, OK</td>
<td><strong>games found</strong></td>
</tr>
<tr>
  <td colspan="3">
  The optional `over` query parameter specifies whether to retrieve games that have been marked completed
  </td>
  <td>200, OK</td>
  <td><em>empty games</em></td>
</tr>
<tr>
  <td colspan="3">
  The default is to retrieve only those games that have `over` equal to false.
  </td>
  <td>401, Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>POST</td>
<td>`/games`</td>
<td>n/a</td>
<td>201, Created</td>
<td><strong>game created</strong></td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>401, Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>400, Bad Request</td>
  <td><strong>errors</strong></td>
</tr>
<tr>
<td>GET</td>
<td>`/games/:id`</td>
<td>n/a</td>
<td>200, OK</td>
<td><strong>game found</strong</td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>401, Unauthorized</td>
  <td><em>empty</em></td>
</tr>
<tr>
  <td colspan="3">
  </td>
  <td>404, Not Found</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>PATCH</td>
<td>`/games/:id`</td>
<td><em>empty</em></td>
<td>200, OK</td>
<td><strong>game joined</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td><strong>errors</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td><em>empty</em></td>
</tr>
<tr>
<td>PATCH</td>
<td>`/games/:id`</td>
<td><strong>game delta</strong></td>
<td>200, OK</td>
<td><strong>game updated</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td><strong>errors</strong></td>
</tr>
<tr>
  <td colspan="3"></td>
  <td>400, Bad Request</td>
  <td><em>empty</em></td>
</tr>
</table>

### index


```json
{
  "games": [
    {
      "id": 1,
      "cells": ["o","x","o","x","o","x","o","x","o"],
      "over": true,
      "player_x": {
        "id": 1,
        "email": "and@and.com"
      },
      "player_o": {
        "id": 3,
        "email": "dna@dna.com"
      }
    },
    {
      "id": 2,
      "cells": ["","","","","","","","",""],
      "over": false,
      "player_x": {
        "id": 3,
        "email": "dna@dna.com"
      },
      "player_o": {
        "id": 1,
        "email": "and@and.com"
      }
    }
  ]
}
```

### create
```json
{
  "game": {
    "id": 3,
    "cells": ["","","","","","","","",""],
    "over": false,
    "player_x": {
      "id": 1,
      "email": "and@and.com"
    },
    "player_o": null
  }
}
```

### show

### update

#### join a game as player 'o'
The `update` action expects an empty *PATCH*, to join an existing game

If the request is successful, the response will have an HTTP Status of 200, OK, and the body will be JSON containing the game joined, e.g.:
```json
{
  "game": {
    "id": 1,
    "cells": ["","","","","","","","",""],
    "over":false,
    "player_x": {
      "id": 1,
      "email": "and@and.com"
      },
    "player_o": {
      "id": 3,
      "email":
      "dna@dna.com"
    }
  }
}
```
If the request is unsuccessful, the response will have an HTTP Status of 401, Unauthorized, and the response body will be empty.

#### update a game's states
Or a *PATCH* with changes to to an existing game

```json
{
  "game": {
    "cell": {
      "index": 0,
      "value": "x"
    },
    "over": false
  }
}
```


```json
{
  "game": {
    "id": 1,
    "cells": ["x","","","","","","","",""],
    "over":false,
    "player_x": {
      "id": 1,
      "email": "and@and.com"
      },
    "player_o": {
      "id": 3,
      "email":
      "dna@dna.com"
    }
  }
}
```

### watch

The `watch` action is handled differently than all the others.  Because `watch` implements a streaming source of data, we'll use a wrapper around the html5 object EventSource.

You can find this wrapper in `vendor/assets/scripts/resource-watcher-0.1.0.js`.

```js
var gameWatcher =
  resourceWatcher('<server>/games/:id/watch', {
      Authorization: 'Token token=<token>'[,
      timeout: <timeout>]
});
```
