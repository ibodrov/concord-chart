#!/bin/sh

HOST_PORT=`minikube service concord-server --url | sed 's@^http:\/\/@@'`
HOST=`echo $HOST_PORT | awk -F':' '{print $1}'`
PORT=`echo $HOST_PORT | awk -F':' '{print $2}'`

curl -i -H 'Authorization: auBy4eDWrKWsyhiDp3AQiw' -F concord.yml=@test.yml http://${HOST}:${PORT}/api/v1/process
