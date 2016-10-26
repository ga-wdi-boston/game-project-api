#!/bin/bash

curl --include --request GET http://localhost:3000/users \
  --header "Authorization: Token token=$TOKEN"
