{
  pkgs,
  image,
}: pkgs.callPackage ../../../utils/mk-container.nix {
  inherit image;
  podmanArgs = [
    "--network=host"
    "--env" "POSTGRES_WEBSERVER_USERNAME"
    "--env" "POSTGRES_WEBSERVER_PASSWORD"
    "--env" "POSTGRES_NETLOC"
    "--env" "POSTGRES_PORT"
  ];
  ensureStopOnExit = true;
  useInteractiveTTY = true;
}
