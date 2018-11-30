#!/bin/bash

curl "http://localhost:4741/ships/${ID}" \
  --include \
  --request PATCH \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "ship": {
      "pilot": "'"${PILOT}"'",
      "notes": "'"${NOTES}"'"
    }
  }'

echo
