#!/bin/bash

# create proxy to connect to database on port 5432
flyctl proxy 5432 -a mboyea-database-test &

# start dev server
vite dev

# kill proxy
kill $!
