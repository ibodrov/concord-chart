#!/bin/sh

# http://${HOST}:${PORT}/#/login?useApiKey=true
# apiKey: auBy4eDWrKWsyhiDp3AQiw

OPEN_CMD=open
if [ "$(uname -s)" = "Linux" ]; then
  OPEN_CMD=xdg-open
fi

HOST_PORT=`kubectl get service concord-console --no-headers |  awk {'print $4 ":" $5'} | awk 'BEGIN { FS = ":" } ; { print $1 ":" $2 }'`
$OPEN_CMD "http://${HOST_PORT}/#/login?useApiKey=true"
