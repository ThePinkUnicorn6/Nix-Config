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
    "/style"
  ]);

  home.packages = with pkgs; [
    syncthing
    syncthingtray
    networkmanagerapplet
    python3
    mullvad

    # Fonts
    arkpandora_ttf
  ];
}
