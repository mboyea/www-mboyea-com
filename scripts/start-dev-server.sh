#!/bin/bash

cleanup() {
	# kill proxy
	kill $!
}

# trap exit of script and call cleanup()
trap cleanup EXIT

# create proxy to connect to database on port 5432
flyctl proxy 5432 -a mboyea-database-test &

# start dev server
vite dev

