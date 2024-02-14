#!/bin/bash

print_help() {
	echo "Use a secure tunnel to access or modify articles stored in the postgres databse from the command line"
	echo
	echo "Usage: article [OPTION]... [URL]"
	echo
	echo "OPTIONS:"
	echo "  ACTION OPTIONS"
	echo "  -h         display this help & exit"
	echo "  -p         print data & exit"
	echo "  -u         upload data to url & exit"
	echo "             requires TEXT, TITLE, URL"
	echo "  DATA OPTIONS"
	echo "  -D <string> DESCRIPTION string (markdown)"
	echo "  -d <file>   DESCRIPTION target file (markdown)"
	echo "  -S <string> SUMMARY string (markdown)"
	echo "  -s <file>   SUMMARY target file (markdown)"
	echo "  -I <string> TITLE string"
	echo "  -i <file>   TITLE target file"
	echo "  -T <string> TEXT string (markdown)"
	echo "  -t <file>   TEXT target file (markdown)"
	echo
}

print_vars() {
	echo "TEXT: $text"
	echo "SUMMARY: $summary"
	echo "DESCRIPTION: $description"
	echo "TITLE: $title"
	echo "URL: $url"
}

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

upload_article() {
	# check options for validity
	[[ -z "$url" ]] && echo "Error: Could not resolve article URL. Run with -h for help." && exit
	[[ -z "$text" ]] && echo "Error: Could not resolve article TEXT. Run with -h for help." && exit
	[[ -z "$title" ]] && echo "Error: Could not resolve article TITLE. Run with -h for help." && exit
	# query the SQL database
	PGPASSWORD=$PG_PASSWORD psql -h localhost -p 5432 -U postgres -d mboyea_main <<EOF
INSERT INTO article (
$([[ -n "$description" ]] && echo "  description_md,")
$([[ -n "$summary" ]] && echo "  summary_md,")
  text_md,
  title,
  url
) VALUES (
$([[ -n "$description" ]] && echo "  E'$(echo "$description" | sed -e s/\'/\\\\\'/g)',")
$([[ -n "$summary" ]] && echo "  E'$(echo "$summary" | sed -e s/\'/\\\\\'/g)',")
  E'$(echo "$text" | sed -e s/\'/\\\\\'/g)',
  '$(echo "$title" | sed -e s/\'/\\\\\'/g)',
  '$(echo "$url" | sed -e s/\'/\\\\\'/g)'
);
EOF
}

parse_data_options() {
	local OPTIND
	while getopts ":d:D:s:S:i:I:t:T:" opt; do
		case $opt in
			D) description="$OPTARG" ;;
			d) description="$(<$OPTARG)" ;;
			S) summary="$OPTARG" ;;
			s) summary="$(<$OPTARG)" ;;
			I) title="$OPTARG" ;;
			i) title="$(<$OPTARG)" ;;
			T) text="$OPTARG" ;;
			t) text="$(<$OPTARG)" ;;
		esac
	done
	shift $((OPTIND-1))
	url=$1
}

parse_action_options() {
	local OPTIND
	while getopts ":hpu" opt; do
		case $opt in
			h) print_help && exit ;;
			p) print_vars && exit ;;
			u) create_proxy && load_env && upload_article && exit ;;
		esac
	done
}

parse_data_options "$@"
parse_action_options "$@"

# if not matched with any action option, print help
print_help

