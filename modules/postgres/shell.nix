{
  pkgs ? import <nixpkgs> {},
}: pkgs.mkShell {
  packages = [
    pkgs.postgresql_17        # psql # 17.2 pinned by flake.nix
    pkgs.nix-prefetch-docker  # see packages/docker-image.nix
  ];
}
