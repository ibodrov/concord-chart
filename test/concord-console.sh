#!/bin/bash

# http://${HOST}:${PORT}/#/login?useApiKey=true
# apiKey: auBy4eDWrKWsyhiDp3AQiw

OPEN_CMD=open
if [ "$(uname -s)" = "Linux" ]; then
  OPEN_CMD=xdg-open
fi

# Could possibly use an ingress controller, but for now minikube just works
# differently than a real cluster.
if [ "$(kubectl config view -o jsonpath='{.clusters[].name}')" == "minikube" ];
then
  echo "Using Minikube!"
  URL=`minikube service concord-console --url`
  $OPEN_CMD "${URL}/#/login?useApiKey=true"
else
  echo "Using EKS"
  HOST_PORT=`kubectl get service concord-console --no-headers |  awk {'print $4 ":" $5'} | awk 'BEGIN { FS = ":" } ; { print $1 ":" $2 }'`
  $OPEN_CMD "http://${HOST_PORT}/#/login?useApiKey=true"
fi
