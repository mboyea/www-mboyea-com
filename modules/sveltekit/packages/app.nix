# TODO: consider switching to pnpm: https://nixos.org/manual/nixpkgs/stable/#javascript-pnpm
{
  pkgs,
  name,
  version,
  runtimeShell ? pkgs.runtimeShell,
}: let
  _name = "${name}-app";
in pkgs.buildNpmPackage {
  pname = _name;
  inherit version;
  src = ../.;
  # Generate a new dependency hash using:
  #   prefetch-npm-deps path/to/sveltekit/package-lock.json
  npmDepsHash = "sha256-g8ED0uPC2nb49Fd1Ze4MI6P4jf1/1WBOqLmrUAf9Aq4=";
  npmBuildScript = "build";
  installPhase = ''
    mkdir -p "$out/bin" "$out/lib"
    cp -rv {build,node_modules,package.json} "$out/lib"
    cat > $out/bin/${_name} << EOF
    #!${runtimeShell}
    "${pkgs.lib.getExe pkgs.nodejs}" "$out/lib/build"
    EOF
    chmod +x $out/bin/${_name}
  '';
  meta.mainProgram = "${_name}";
}
