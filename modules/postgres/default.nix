{
  pkgs ? import <nixpkgs> {},
}: let
  name = "www-mboyea-com-database";
  version = "0.17.2";
in rec {
  packages = {
    dockerImage = pkgs.callPackage ./packages/docker-image.nix {
      inherit name version;
    };
    container = pkgs.callPackage ./packages/container.nix {
      image = packages.dockerImage;
    };
  };
  devShells.default = import ./shell.nix { inherit pkgs; };
}
