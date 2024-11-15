{ inputs, pkgs, settings, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ../../base/hm
  ] ++
  (map (m: ../../../modules/hm + m) [
    "/app/shell"
    "/app/shell/scripts/update.nix"
    "/app/git"
    "/app/shell/kitty"
    "/app/browser/zen"
    /app/fido2
  ]);

  home.packages = with pkgs; [
    syncthing
    syncthingtray
    python3

    # Fonts
    arkpandora_ttf
  ];
}
