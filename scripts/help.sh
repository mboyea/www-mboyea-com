#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

echo "This is the www-mboyea-com command line interface."
echo
echo "Usage:"
echo "  nix run                 | Alias for \"nix run .#start dev\""
echo "  nix run .#[SCRIPT] ...  | Run a script"
echo "  nix run .#[SCRIPT] help | Print usage information about a script"
echo "  nix develop             | Start a subshell with the software dependencies installed"
echo
echo "SCRIPTS:"
echo "  help    Print this helpful information"
echo "  start   Start the app locally"
echo
