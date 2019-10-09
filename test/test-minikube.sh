#!/bin/sh

# Could possibly use an ingress controller, but for now minikube just works
# differently than a real cluster.
HOST_PORT=`minikube service concord-server --url | sed 's@^http:\/\/@@'`

echo
echo

#echo "${HOST_PORT}"
#HOST=`echo $HOST_PORT | awk -F':' '{print $1}'`
#PORT=`echo $HOST_PORT | awk -F':' '{print $2}'`
#echo "Concord server: ${HOST}:${PORT}"

# wait for the server to start
echo "Waiting for the Concord server to start"
echo "http://${HOST_PORT}/api/v1/server/ping"
until $(curl --output /dev/null --silent --head --fail "http://${HOST_PORT}/api/v1/server/ping"); do
  printf '.'
  sleep 2
done

echo
echo "Submitting process..."

# Submit process
RESULT=`curl --silent -H 'Authorization: auBy4eDWrKWsyhiDp3AQiw' -F concord.yml=@test.yml http://${HOST_PORT}/api/v1/process`
#echo ${RESULT}
ID=`echo ${RESULT} | jq -r .instanceId`
echo ${ID}

#sleep 20

echo
echo "Waiting for the Concord process to finish"
while [ "$(curl --silent -H 'Authorization: auBy4eDWrKWsyhiDp3AQiw' http://${HOST_PORT}/api/v1/process/${ID} | jq -r .status)" != "FINISHED" ]
do
  printf '.'
  sleep 2
done

echo

#echo ${RESULT}
#STATUS=`echo ${RESULT} | jq -r .status`
#echo ${STATUS}

# Something like the following will be emitted:
#
# {
#   "instanceId" : "2a0c5238-1102-4eaa-857a-80c252cb91fc",
#   "kind" : "DEFAULT",
#   "createdAt" : "2019-03-06T13:59:22.186Z",
#   "initiator" : "admin",
#   "initiatorId" : "230c5c9c-d9a7-11e6-bcfd-bb681c07b26c",
#   "status" : "FINISHED",
#   "lastAgentId" : "ab3632f9-42d0-4b13-a210-1fdbaaeb22a4",
#   "lastUpdatedAt" : "2019-03-06T13:59:39.375Z",
#   "logFileName" : "2a0c5238-1102-4eaa-857a-80c252cb91fc.log",
#   "meta" : {
#     "_system" : {
#       "requestId" : "35e1cee9-a8b6-4668-94ff-247c11f218d6"
#     }
#   }
# }

echo
echo "Looking for completion message in process log..."
echo
# Inspect logs from executed process
RESULT=`curl --silent -H 'Authorization: auBy4eDWrKWsyhiDp3AQiw' http://${HOST_PORT}/api/v1/process/${ID}/log`
#echo ${LOG}
if echo ${RESULT} | grep -q 'COMPLETED'; then
    echo "SUCCESS!"
else
    echo "FAILED :("
fi
