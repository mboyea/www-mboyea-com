{
  description = "www-mboyea-com CLI";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }: let
    name = "www-mboyea-com";
    version = "0.2.0";
    utils = flake-utils;
  in utils.lib.eachDefaultSystem (
    system: let
      pkgs = import nixpkgs { inherit system; };
      modules = pkgs.lib.attrsets.mapAttrs
        (n: v: import (./. + "/modules/${n}") { inherit pkgs; })
        (builtins.readDir ./modules);
    in rec {
      packages = {
        help = pkgs.callPackage utils/run.nix {
          name = "${name}-${version}-help";
          target = scripts/help.sh;
        };
        start = pkgs.callPackage utils/run.nix {
          name = "${name}-${version}-start";
          target = scripts/start.sh;
          runtimeInputs = [
            pkgs.expect
          ];
          runtimeEnv = {
            START_DEV_DATABASE = pkgs.lib.getExe modules.postgres.packages.container;
            START_DEV_WEBSERVER = pkgs.lib.getExe modules.sveltekit.packages.dev;
            START_PROD_DATABASE = pkgs.lib.getExe modules.postgres.packages.container;
            START_PROD_WEBSERVER = pkgs.lib.getExe modules.sveltekit.packages.container;
          };
          envFiles = [ ".env.development" ];
        };
        default = packages.start.override { cliArgs = [ "dev" ]; };
      };
      apps = {
        help = utils.lib.mkApp { drv = packages.help; };
        start = utils.lib.mkApp { drv = packages.start; };
        default = utils.lib.mkApp { drv = packages.default; };
      };
      # the default devShell for each module is provided
      devShells = (pkgs.lib.attrsets.mapAttrs
        (n: v: v.devShells.default)
        modules
      ) // {
        # the root devShell provides packages used within scripts/
        root = pkgs.mkShell {
          packages = [
            # run docker containers without starting a daemon
            pkgs.podman
            # install program unbuffer to preserve formatting when piping to tee
            pkgs.expect
            # kill program at <port> using: fuser -k <port>/tcp
            pkgs.psmisc
            # get information about the project like modified files and 
            pkgs.git
          ];
          shellHook = ''
            export START_DEV_DATABASE="${pkgs.lib.getExe modules.postgres.packages.container}"
            export START_DEV_WEBSERVER="${pkgs.lib.getExe modules.sveltekit.packages.dev}"
            export START_PROD_DATABASE="${pkgs.lib.getExe modules.postgres.packages.container}"
            export START_PROD_WEBSERVER="${pkgs.lib.getExe modules.sveltekit.packages.container}"
            go_to_base_directory() {
              # if current directory is not a git directory, return
              if ! "${pkgs.lib.getExe pkgs.git}" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
                return
              fi
              # go to the base of the git directory
              cd "$("${pkgs.lib.getExe pkgs.git}" rev-parse --show-toplevel)"
            }
            load_env_files() {
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
              cd -
            }
            load_env_files ${pkgs.lib.strings.concatStringsSep " " [ ".env.development" ]}
          '';
        };
        # the default devShell is a combination of every devShell
        default = pkgs.mkShell {
          inputsFrom = (
            pkgs.lib.attrsets.mapAttrsToList
            (n: v: devShells."${n}")
            modules
          ) ++ [ devShells.root ];
        };
      };
    }
  );
}
