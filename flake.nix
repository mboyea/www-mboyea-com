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
            START_DEV_WEBSERVER = pkgs.lib.getExe modules.sveltekit.packages.dev;
            START_DEV_DATABASE = pkgs.lib.getExe modules.postgres.packages.container;
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
            # kill program at <port> using: fuser -k <port>/tcp
            pkgs.psmisc
            # run docker containers without starting a daemon
            pkgs.podman
          ];
          shellHook = ''
            export START_DEV_WEBSERVER="${pkgs.lib.getExe modules.sveltekit.packages.dev}"
            export START_DEV_DATABASE="${pkgs.lib.getExe modules.postgres.packages.container}"
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
