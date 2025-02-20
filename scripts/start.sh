#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

echo_error() {
  echo "Error:" "$@" 1>&2
}

test_commands() {
  local flags=$-
  local exit=false
  if [[ $flags =~ e ]]; then set +e; fi # disable exit on error
  # for each argument
  while [[ $# -gt 0 ]]; do
    # check that command is defined
    if [ ! -x "$(command -v "$1")" ]; then
      echo_error "The required program \"$1\" is not installed"
      exit=true
    fi
    shift
  done
  if [[ $flags =~ e ]]; then set -e; fi # re-enable exit on error
  if $exit; then exit 1; fi
}

test_env_variables() {
  local flags=$-
  local exit=false
  if [[ $flags =~ u ]]; then set +u; fi # disable exit on undefined variables
  # for each argument
  while [[ $# -gt 0 ]]; do
    # check that env variable is defined
    if [ -z "${!1}" ]; then
      echo_error "The required environment variable \"$1\" is not defined"
      exit=true
    fi
    shift
  done
  if [[ $flags =~ u ]]; then set -u; fi # re-enable exit on undefined variables
  if $exit; then exit 1; fi
}

process_ids=()
kill_processes() {
  local flags=$-
  if [[ $flags =~ e ]]; then set +e; fi # disable exit on error
  # send kill signal to each process
  for process_id in "${process_ids[@]}"; do
    kill -9 -- "-$process_id" > /dev/null 2>&1
  done
  # wait for each process to exit
  for process_id in "${process_ids[@]}"; do
    wait "$process_id" 2>/dev/null
  done
  if [[ $flags =~ e ]]; then set -e; fi # re-enable exit on error
}

# expects $1 to start a postgres database and $2 to start a webserver
start_processes() {
  test_commands unbuffer
  test_env_variables POSTGRES_PASSWORD POSTGRES_WEBSERVER_USERNAME POSTGRES_WEBSERVER_PASSWORD
  trap kill_processes EXIT
  # start database as background process
  database_log_file="$(mktemp)"
  (unbuffer "$1" | tee "$database_log_file") & process_ids+=($!)
  local database_process_id="${process_ids[-1]}"
  # wait for database to be ready to accept connections
  until \
    grep -q "^.*\[1\].*database system is ready to accept connections" "$database_log_file"
  do
    if ! ps -p "$database_process_id" > /dev/null; then
      echo_error "The database failed to start"
      exit 1
    fi
    sleep 0.1
  done
  # set default webserver env
  set -a
  : "${POSTGRES_NETLOC:="localhost"}"
  : "${POSTGRES_PORT:="5432"}"
  set +a
  # start webserver as main process
  "$2"
}

script_start_help() {
  echo "Start the app locally."
  echo
  echo "Usage:"
  echo "  nix run .#start          | Alias for \"nix run .#start help\""
  echo "  nix run .#start [SCRIPT] | Run the specified script"
  echo
  echo "SCRIPTS:"
  echo "  help --help -h | Print this helpful information"
  echo "  dev            | Start each server using devtools"
  echo "  prod           | Start each server image in a container, as similar to the production server as possible"
  echo
}

script_start_dev() {
  test_env_variables START_DEV_DATABASE START_DEV_WEBSERVER
  start_processes "$START_DEV_DATABASE" "$START_DEV_WEBSERVER"
}

script_start_prod() {
  test_env_variables START_PROD_DATABASE START_PROD_WEBSERVER
  start_processes "$START_PROD_DATABASE" "$START_PROD_WEBSERVER"
}

interpret_script() {
  # if no arguments passed, run the default script
  if [[ $# -eq 0 ]]; then
    script="script_start_help"
    script_args=()
    return;
  fi
  # otherwise run the script specified by the first argument
  case $1 in
    help|--help|-h)
      script="script_start_help"
    ;;
    dev)
      script="script_start_dev"
    ;;
    prod)
      script="script_start_prod"
    ;;
    *)
      echo_error "The argument \"$1\" is not a recognized script"
      echo_error "Try \"help\" to show available scripts"
      exit 1
    ;;
  esac
  shift
  script_args=("$@")
}

main() {
  interpret_script "$@"
  "$script" "${script_args[@]}"
}

main "$@"
