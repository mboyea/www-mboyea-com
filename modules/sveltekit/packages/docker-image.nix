{
  pkgs,
  name,
  version,
  server ? pkgs.callPackage ./server.nix { inherit name version; },
}: let
  _name = "${name}-docker-image";
  tag = version;
  baseImage = null;
in {
  name = _name;
  inherit version tag;
  stream = pkgs.dockerTools.streamLayeredImage {
    name = _name;
    inherit tag;
    fromImage = baseImage;
    contents = [ server ];
    config = {
      # TODO: configure image
      Cmd = [];
      Entrypoint = [];
      ExposedPorts = {};
    };
  };
}
