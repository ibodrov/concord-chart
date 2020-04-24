#!/bin/bash

# - Deletes all the concord related pods
# - deploys concord with a helm chart
# - starts a process and validates it has executed correctly

# Need to do this for concord specific pods
echo "Waiting for all Concord pods to be deleted"
./chart-delete.sh
while [ "$(kubectl get pod -o name)" != "" ]
do
  printf '.'
  sleep 2
done

echo
echo

./chart-install.sh

./test.sh
