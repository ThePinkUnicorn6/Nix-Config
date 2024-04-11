{ inputs, pkgs, settings, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
  [
    ../user/app/shell
    ../user/app/shell/scripts/update.nix
    ../user/app/git
    ../user/app/shell/alacritty
  ];

  home.packages = with pkgs; [
    gh
    unzip
    oh-my-zsh
    firefox
    syncthing
    syncthingtray
    usbutils
    pciutils
    python3
    libressl
  ];

}
