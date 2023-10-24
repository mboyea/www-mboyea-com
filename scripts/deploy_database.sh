#!/bin/bash

# load .env
set -a; source .env; set +a

# create proxy to connect to database on port 5432
flyctl proxy 5432 -a mboyea-database-test & proxy_program="$!"

# standup database
PGPASSWORD=$PG_PASSWORD psql -p 5432 -U postgres -d postgres -f scripts/sql/deploy_databases.sql

# kill proxy
kill $proxy_program
