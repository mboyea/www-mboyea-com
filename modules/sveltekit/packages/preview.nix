{
  pkgs,
  name,
  version,
}: pkgs.writeShellApplication {
  name = "${name}-${version}-preview";
  runtimeInputs = [
    pkgs.nodejs
  ];
  text = ''
    cd "$(${pkgs.lib.getExe pkgs.git} rev-parse --show-toplevel)/modules/sveltekit"
    npm i
    npm run build
    npm run preview
  '';
}

