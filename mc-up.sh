#!/bin/bash
if [[ -z $SERVER_ADDR]]
then
    echo "Provide the SERVER_ADDR environment variable"
    exit 1
fi
ONLINE=$(curl "https://api.mcstatus.io/v2/status/java/${SERVER_ADDR}" | jq '.online')
if [[ $ONLINE == "true" ]]
then
    exit 0
fi
exit 1
