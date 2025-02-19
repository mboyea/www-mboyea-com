{
  pkgs ? import <nixpkgs> {},
}: pkgs.mkShell {
  packages = [
    pkgs.nodejs               # npm & npx
    pkgs.prefetch-npm-deps    # see packages/server.nix
    pkgs.nix-prefetch-docker  # see packages/docker-image.nix
  ];
}
