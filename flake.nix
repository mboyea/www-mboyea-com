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
            pkgs.git
            pkgs.expect
          ];
          runtimeEnv = {
            START_DEV_DATABASE = pkgs.lib.getExe modules.postgres.packages.container;
            START_DEV_WEBSERVER = pkgs.lib.getExe modules.sveltekit.packages.dev;
            START_PROD_DATABASE = pkgs.lib.getExe modules.postgres.packages.container;
            START_PROD_WEBSERVER = pkgs.lib.getExe modules.sveltekit.packages.container;
            START_ENV_FILE = ".env.development";
          };
        };
        deploy = pkgs.callPackage utils/run.nix {
          name = "${name}-${version}-deploy";
          target = scripts/deploy.sh;
          runtimeInputs = [
            pkgs.git
            pkgs.flyctl
            pkgs.gzip
            pkgs.skopeo
          ];
          runtimeEnv = {
            WEBSERVER_IMAGE_NAME = modules.sveltekit.packages.dockerImage.name;
            WEBSERVER_IMAGE_TAG = modules.sveltekit.packages.dockerImage.tag;
            WEBSERVER_IMAGE_STREAM = modules.sveltekit.packages.dockerImage.stream;
            DEPLOY_ENV_FILE = ".env";
            POSTGRES_SCHEMA_FILE = "modules/postgres/schema/init.sql";
          };
        };
        default = packages.start.override { cliArgs = [ "dev" ]; };
      };
      apps = {
        help = utils.lib.mkApp { drv = packages.help; };
        start = utils.lib.mkApp { drv = packages.start; };
        deploy = utils.lib.mkApp { drv = packages.deploy; };
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
            # manage deployments on hosting provider Fly.io
            pkgs.flyctl
            # zip Docker images for deployment
            pkgs.gzip
            # deploy Docker images to a remote server
            pkgs.skopeo
          ];
          shellHook = ''
            export START_DEV_DATABASE="${pkgs.lib.getExe modules.postgres.packages.container}"
            export START_DEV_WEBSERVER="${pkgs.lib.getExe modules.sveltekit.packages.dev}"
            export START_PROD_DATABASE="${pkgs.lib.getExe modules.postgres.packages.container}"
            export START_PROD_WEBSERVER="${pkgs.lib.getExe modules.sveltekit.packages.container}"
            export WEBSERVER_IMAGE_NAME="${modules.sveltekit.packages.dockerImage.name}"
            export WEBSERVER_IMAGE_TAG="${modules.sveltekit.packages.dockerImage.tag}"
            export WEBSERVER_IMAGE_STREAM="${modules.sveltekit.packages.dockerImage.stream}"
            export DATABASE_IMAGE_NAME="${modules.sveltekit.packages.dockerImage.name}"
            export DATABASE_IMAGE_TAG="${modules.sveltekit.packages.dockerImage.tag}"
            export DATABASE_IMAGE_STREAM="${modules.sveltekit.packages.dockerImage.stream}"
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
