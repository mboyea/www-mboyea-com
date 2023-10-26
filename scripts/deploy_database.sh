#!/bin/bash

# load .env
set -a; source .env; set +a
set -a; source .env.development; set +a

# create proxy to connect to database on port 5432
flyctl proxy 5432 -a mboyea-database-test & proxy_program="$!"

# standup database
PGPASSWORD=$PG_PASSWORD psql -h localhost -p 5432 -U postgres -d postgres -f scripts/sql/main_deploy.psql

# kill proxy
kill $proxy_program
