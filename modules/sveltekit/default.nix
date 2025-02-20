{
  pkgs ? import <nixpkgs> {},
}: let
  nodePackage = builtins.fromJSON (builtins.readFile ./package.json);
  name = nodePackage.name;
  version = nodePackage.version;
in rec {
  packages = {
    dev = pkgs.callPackage ./packages/dev.nix {
      inherit name version;
    };
    preview = pkgs.callPackage ./packages/prod.nix {
      inherit name version;
    };
    app = pkgs.callPackage ./packages/app.nix {
      inherit name version;
    };
    dockerImage = pkgs.callPackage ./packages/docker-image.nix {
      inherit name version;
      app = packages.app;
    };
    container = pkgs.callPackage ./packages/container.nix {
      image = packages.dockerImage;
    };
  };
  devShells.default = import ./shell.nix { inherit pkgs; };
}
