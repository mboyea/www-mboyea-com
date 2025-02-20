{
  pkgs,
  image,
}: pkgs.callPackage ../../../utils/mk-container.nix {
  inherit image;
  podmanArgs = [
    "--publish" "5432:5432"
    "--env" "POSTGRES*"
    "--volume" "\"${image.name}-${image.tag}:/var/lib/postgresql/data\""
  ];
  runtimeInputs = [ pkgs.git ];
  preStart = ''
    flags=$-
    if [[ $flags =~ e ]]; then set +e; fi
    create_new_volume() {
      podman volume create "${image.name}-${image.tag}" > /dev/null 2>&1
      echo "New volume created at ${image.name}-${image.tag}"
      # TODO: initialize the volume using schema/
    }
    # if volume doesn't exist, create one
    if ! podman volume exists "${image.name}-${image.tag}" > /dev/null 2>&-; then
      create_new_volume
    # else volume exists; if schema modified, backup old volume and make a new one
    elif git status --porcelain | grep -q "modules/postgres/schema/"; then
      echo "PostgreSQL Database schema appears to be modified; Replacing old volume"
      volume_backup_number=$(($(podman volume ls \
        | grep "${image.name}-${image.tag}" \
        | grep -o "backup.*" \
        | grep -oE '[0-9]+' \
        | sort -n \
        | tail -n 1 \
      ) + 1))
      volume_backup_name="${image.name}-${image.tag}-backup-$volume_backup_number"
      podman volume create "$volume_backup_name" > /dev/null 2>&1
      podman run -it \
        "--volume" "${image.name}-${image.tag}:/from" \
        "--volume" "$volume_backup_name:/to" \
        docker.io/library/bash \
        cp -rpf /from /to
      echo "Copied old volume to $volume_backup_name; Use 'podman volume prune' to delete unused backups"
      podman volume rm --force "${image.name}-${image.tag}" > /dev/null 2>&1
      create_new_volume
    fi
    if [[ $flags =~ e ]]; then set -e; fi
  '';
  ensureStopOnExit = true;
  useInteractiveTTY = false;
}
