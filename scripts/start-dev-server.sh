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

# start dev server
vite dev

