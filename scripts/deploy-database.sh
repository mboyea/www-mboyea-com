#!/bin/bash

cleanup() {
	# kill proxy
	kill -INT "$proxy_program_PID"
	sleep 0.4
}

# trap exit of script and call cleanup()
trap cleanup EXIT

# create proxy to connect to database on port 5432
coproc proxy_program (flyctl proxy 5432 -a mboyea-database-test)

# load .env
set -a; source .env; set +a

# wait for output from proxy program
read output <&"${proxy_program[0]}"
# print output from proxy program
echo $output
echo

# standup database
PGPASSWORD=$PG_PASSWORD psql -h localhost -p 5432 -U postgres -d postgres -f scripts/sql/main_deploy.psql

