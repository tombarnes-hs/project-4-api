#!/bin/bash

curl 'http://localhost:4741/ships' \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "ship": {
      "name": "'"${NAME}"'",
      "pilot": "'"${PILOT}"'",
      "notes": "'"${NOTES}"'"
    }
  }'

echo
