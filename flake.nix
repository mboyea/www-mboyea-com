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
    in rec {
      packages = {
        help = pkgs.callPackage scripts/run.nix {
          name = "${name}-${version}-help";
          target = scripts/help.sh;
        };
        start = pkgs.callPackage scripts/run.nix {
          name = "${name}-${version}-start";
          target = scripts/start.sh;
        };
      };
      apps = {
        help = utils.lib.mkApp { drv = packages.help; };
      };
      devShells = {};
    }
  );
}
