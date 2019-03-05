#!/bin/sh

# http://${HOST}:${PORT}/#/login?useApiKey=true
# apiKey: auBy4eDWrKWsyhiDp3AQiw

URL=`minikube service concord-console --url`
open "${URL}/#/login?useApiKey=true"
