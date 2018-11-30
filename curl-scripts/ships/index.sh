#!/bin/bash

curl "http://localhost:4741/ships" \
  --include \
  --request GET \
  --header "Authorization: Token token=${TOKEN}"

echo
