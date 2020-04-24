#!/bin/bash

# http://${HOST}:${PORT}/#/login?useApiKey=true
# apiKey: auBy4eDWrKWsyhiDp3AQiw

OPEN_CMD=open
if [ "$(uname -s)" = "Linux" ]; then
  OPEN_CMD=xdg-open
fi

URL=`minikube service concord-console --url`
$OPEN_CMD "${URL}/#/login?useApiKey=true"
