#!/bin/bash

curl "http://localhost:4741/ships/${ID}" \
  --include \
  --request DELETE \
  --header "Authorization: Token token=${TOKEN}" \
