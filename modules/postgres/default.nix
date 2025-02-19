{
  pkgs ? import <nixpkgs> {},
}: let
  name = "www-mboyea-com-postgres";
  version = "0.17.2";
in rec {
  packages = {
    dockerImage = pkgs.callPackage ./packages/docker-image.nix {
      inherit name version;
    };
  };
  devShells.default = import ./shell.nix { inherit pkgs; };
}
