#!/bin/bash

usage() {
	echo "Usage: article <url> [Option]..."
	echo
}

help() {
	echo "Use a secure tunnel to access or modify articles stored in the postgres databse from the command line"
	echo
	usage
	echo "Options:"
	echo "  ACTION OPTIONS"
	echo "  -h         display this help & exit"
	echo "  -u         upload data to URL & exit"
	echo "  DATA OPTIONS"
	echo "  -d <file>  description target file"
	echo "  -s <file>  summary target file"
	echo "  -T <file>  title target file"
	echo "  -t <file>  text target file"
	echo
}

OPTIND=1
while getopts ":T:t:d:s:" data; do
	case $data in
		d)
			;;
		s)
			;;
		T)
			;;
		t)
			;;
	esac
done

OPTIND=1
while getopts ":hu" action; do
	case $action in
		h)
			help
			exit
			;;
		u)
			echo "Feature not yet implemented."
			echo
			exit
			;;
	esac
done


#TODO: given input files for article title, text, description, summary, etc as command line arguments upload the article into the database


# create proxy to connect to database on port 5432
# flyctl proxy 5432 -a mboyea-database-test & proxy_program="$!"

# standup database
# PGPASSWORD=$PG_PASSWORD psql -h localhost -p 5432 -U postgres -d postgres -f scripts/sql/main_deploy.psql

# kill proxy
# kill $proxy_program

usage

