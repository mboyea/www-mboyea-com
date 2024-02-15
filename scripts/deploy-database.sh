#!/bin/bash

create_proxy() {
	# prepare proxy program cleanup
	cleanup() {
		# kill proxy
		kill -INT "$proxy_program_PID"
		sleep 0.4
	}
	trap cleanup EXIT

	# create proxy to connect to database on port 5432
	coproc proxy_program (flyctl proxy 5432 -a mboyea-database-test)

	# wait for output from proxy program
	read output <&"${proxy_program[0]}"
	echo $output
}

load_env() {
	# load .env
	set -a; source .env; set +a
}

create_proxy
load_env

# standup database
PGPASSWORD=$PG_PASSWORD psql -h localhost -p 5432 -U postgres -d postgres -f scripts/sql/main_deploy.psql

