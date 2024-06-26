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
    "/app/browser/firefox"
  ]);

  home.packages = with pkgs; [
    unzip
    oh-my-zsh
    syncthing
    syncthingtray
    usbutils
    pciutils
    python3
    libressl
  ];

}
