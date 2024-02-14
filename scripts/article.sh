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

upload() {
	# TODO: pass -c "" code w/ INSERT statement
	PGPASSWORD=$PG_PASSWORD psql -h localhost -p 5432 -U postgres -d mboyea_main #-c ""
	# PGPASSWORD=$PG_PASSWORD psql -h localhost -p 5432 -U postgres -d postgres -f scripts/sql/main_deploy.psql
	echo "$description $summary $title $text"
	# https://stackoverflow.com/questions/3953645/ternary-operator-in-bash

	# /*
	# INSERT INTO article (title, url, description_md, summary_md, text_md)
	# VALUES (
	# 	'Mock Article',
	# 	'mock-article',
	# 	E'This is a brief article to be used for testing.',
	# 	E'In summary:\n> all functionality should be working!\n\n- *Lists*\n- **Text decoration**\n- `Code snippets`',
	# 	E'## Headers should work.\n### H3\n#### H4\n##### H5\n###### H6\n## Blockquotes should be functional.\n> This way, we can draw attention to important words.\n\n## Code blocks should also work.\n```cpp\nint main() {\nstd::cout << "Hello world!";\n}\n```'
	# );
	# */
}

OPTIND=1
while getopts ":d:s:T:t:" data; do
	case $data in
		d)
			description="$OPTARG"
			;;
		s)
			summary="$OPTARG"
			;;
		T)
			title="$OPTARG"
			;;
		t)
			text="$OPTARG"
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
			create_proxy
			load_env
			upload
			exit
			;;
	esac
done

usage

