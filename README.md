# Concord Helm Chart

This is the simplest of charts for Concord. Not parameterized, or productionalized in any way right now but simply to get a fully working Concord setup working in K8s.

It's assumed you have minikube setup, and all the resource requirements listed assume very restricted resources.

Janky scripts:
- `chart-install.sh`: install chart
- `chart-delete.sh`: delete chart
- `concord-console.sh`: jump to concord console in the browser
- `connect-to-pg.sh`: connect to pg using psql
- `test.sh`: submit a test non-dind process
- `test-dind.sh`: submit a test dind process


TODO:
- sort out issues with running a docker step in dind
- use templating properly
- provide a set of local development values
- provide a set of production values
- integrate with stable/postgresql helm chart
- integrate with AWS RDS for Postgres
