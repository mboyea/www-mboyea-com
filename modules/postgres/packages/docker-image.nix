{
  pkgs,
  name,
  version,
}: let
  _name = "${name}-docker-image";
  tag = version;
  # update base image using variables from:
  #   xdg-open https://hub.docker.com/r/flyio/postgres-flex/tags
  #   nix-prefetch-docker --quiet --image-name flyio/postgres-flex --image-tag _ --image-digest _
  baseImage = pkgs.dockerTools.pullImage {
    imageName = "flyio/postgres-flex";
    imageDigest = "sha256:f4301ae20d193ab3c3539eb9df9a8f8d3736dd331aeec1bfb2e34b539dc353c5";
    sha256 = "1w76kk6bpgbwfpb7yf0i6nmgrhxgiw661sljpvfzqix4pba5w8mf";
    finalImageName = "flyio/postgres-flex";
    finalImageTag = "17"; # 17.2
  };
in {
  name = _name;
  inherit version tag;
  stream = pkgs.dockerTools.streamLayeredImage {
    name = _name;
    inherit tag;
    fromImage = baseImage;
    # TODO: initialize database using schema
    # enableFakechroot = true;
    # fakeRootCommands = '''';
    config = {
      # TODO: configure image
      Cmd = [];
      Entrypoint = [];
      ExposedPorts = {};
      Volumes = {};
    };
  };
}
