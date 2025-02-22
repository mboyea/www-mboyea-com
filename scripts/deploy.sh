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

go_to_base_directory() {
  test_commands git
  # if current directory is not a git directory, return
  if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    return
  fi
  # go to the base of the git directory
  cd "$(git rev-parse --show-toplevel)"
}

load_env_files() {
  # go to base directory
  go_to_base_directory
  # for each file
  while [[ $# -gt 0 ]]; do
    # if file isn't readable, continue
    if [ ! -r "$1" ]; then
      shift
      continue
    fi
    # load file
    set -a
    # shellcheck disable=SC1091 source=/dev/null
    source "$1"
    set +a
    shift
  done
  # return to last directory
  cd - > /dev/null
}

# expects $1 to be the name of the Fly app
verify_fly_app_created() {
  if ! flyctl apps list | tail -n +2 | grep -q "^$1"; then
    flyctl apps create --org "$FLY_ORGANIZATION" --name "$1"
    echo "Created app $1."
  fi
}

script_stage_secrets() {
  test_env_variables FLY_APP_NAME FLY_DB_NAME POSTGRES_WEBSERVER_PASSWORD
  echo "Deploying secrets..."
  verify_fly_app_created "$FLY_APP_NAME"
  : "${POSTGRES_NETLOC:="$FLY_DB_NAME.flycast"}"
  # get webserver secrets
  webserver_env=(
    POSTGRES_DATABASE_MAIN
    POSTGRES_WEBSERVER_USERNAME
    POSTGRES_WEBSERVER_PASSWORD
    POSTGRES_NETLOC
    POSTGRES_PORT
  )
  for i in "${!webserver_env[@]}"; do
    webserver_env[i]="${webserver_env[i]}=${!webserver_env[i]}"
  done
  # stage webserver secrets
  flyctl secrets set --app "$FLY_APP_NAME" --stage "${webserver_env[@]}"
}

script_deploy_secrets() {
  script_stage_secrets
  # deploy webserver secrets
  flyctl secrets deploy --app "$FLY_APP_NAME"
}

script_deploy_webserver() {
  test_commands gzip skopeo
  test_env_variables FLY_APP_NAME WEBSERVER_IMAGE_STREAM WEBSERVER_IMAGE_TAG
  echo "Deploying webserver..."
  verify_fly_app_created "$FLY_APP_NAME"
  : "${FLY_API_TOKEN:="$(flyctl tokens create deploy --app "$FLY_APP_NAME" --expiry 0h10m0s)"}"
  # deploy docker image to fly registry
  "$WEBSERVER_IMAGE_STREAM" | gzip --fast | skopeo --insecure-policy copy --dest-creds="x:$FLY_API_TOKEN" "docker-archive:/dev/stdin" "docker://registry.fly.io/$FLY_APP_NAME:$WEBSERVER_IMAGE_TAG"
  # load docker image on fly server
  go_to_base_directory
  flyctl deploy --app "$FLY_APP_NAME" -c "$FLY_TOML_FILE" -i "registry.fly.io/$FLY_APP_NAME:$WEBSERVER_IMAGE_TAG"
  cd - > /dev/null
}

script_deploy_database() {
  test_env_variables FLY_DB_NAME POSTGRES_PASSWORD
  echo "Deploying database..."
  if ! flyctl postgres list | tail -n +2 | grep -q "^$FLY_DB_NAME"; then
    flyctl postgres create --org "$FLY_ORGANIZATION" --name "$FLY_DB_NAME" --password "$POSTGRES_PASSWORD"
  fi
  # TODO: execute modules/postgres/schema/ in database
}

script_deploy_all() {
  script_deploy_database
  script_stage_secrets
  script_deploy_webserver
}

script_deploy_help() {
  echo "Start the app locally."
  echo
  echo "Usage:"
  echo "  nix run .#deploy             | Alias for \"nix run .#deploy help\""
  echo "  nix run .#deploy [SCRIPT]... | Run the specified scripts"
  echo
  echo "SCRIPTS:"
  echo "  help|--help|-h      | Print this helpful information"
  echo "  all                 | Deploy the entire website to Fly"
  echo "  database|postgres   | Deploy the Postgres database and its schema to Fly"
  echo "  webserver|sveltekit | Deploy the Node webserver generated by SvelteKit to Fly"
  echo "  secrets             | Deploy the secrets to Fly for the webserver"
  echo
}

scripts=()
script_args=()
interpret_script() {
  # if no arguments passed, run the default script
  if [[ $# -eq 0 ]]; then
    scripts+=("script_deploy_help")
    return;
  fi
  # otherwise run the scripts specified by arguments, until an option is encountered that is not recognized as a script
  while [[ $# -gt 0 ]]; do
    case $1 in
      help|--help|-h)
        scripts=("script_deploy_help")
        return;
      ;;
      all)
        scripts+=("script_deploy_all")
      ;;
      database|postgres)
        scripts+=("script_deploy_database")
      ;;
      webserver|sveltekit)
        scripts+=("script_deploy_webserver")
      ;;
      secrets)
        scripts+=("script_deploy_secrets")
      ;;
      *)
        break
      ;;
    esac
    shift
  done
  # if no script was identified, print an error
  if [[ -z "${scripts[*]}" ]]; then
    echo_error "The argument \"$1\" is not a recognized script"
    echo_error "Try \"help\" to show available scripts"
    exit 1
  fi
  # remaining 
  script_args+=("$@")
}

main() {
  : "${DEPLOY_ENV_FILE:=".env"}"
  load_env_files "$DEPLOY_ENV_FILE"
  : "${FLY_TOML_FILE:="fly.toml"}"
  : "${FLY_ORGANIZATION:="personal"}"
  : "${POSTGRES_WEBSERVER_USERNAME:="webserver"}"
  : "${POSTGRES_DATABASE_MAIN:="main"}"
  : "${POSTGRES_PORT:="5432"}"
  interpret_script "$@"
  for script in "${scripts[@]}"; do
    "$script" "${script_args[@]}"
  done
}

main "$@"
