#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

# print an error message to the console
echo_error() {
  echo "Error:" "$@" 1>&2
}

test_commands() {
  local flags=$-
  local exit=false
  # disable exit on error
  if [[ $flags =~ e ]]; then set +e; fi
  # for each argument
  while [[ $# -gt 0 ]]; do
    # check that command is defined
    if [ ! -x "$(command -v "$1")" ]; then
      echo_error "The required program \"$1\" is not installed"
      exit=true
    fi
    shift
  done
  # re-enable exit on error
  if [[ $flags =~ e ]]; then set -e; fi
  if $exit; then exit 1; fi
}

test_env_variables() {
  local flags=$-
  local exit=false
  # disable exit on undefined variables
  if [[ $flags =~ u ]]; then set +u; fi
  # for each argument
  while [[ $# -gt 0 ]]; do
    # check that env variable is defined
    if [ -z "${!1}" ]; then
      echo_error "The required environment variable \"$1\" is not defined"
      exit=true
    fi
    shift
  done
  # re-enable exit on undefined variables
  if [[ $flags =~ u ]]; then set -u; fi
  if $exit; then exit 1; fi
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
  :
}

script_start_prod() {
  :
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
