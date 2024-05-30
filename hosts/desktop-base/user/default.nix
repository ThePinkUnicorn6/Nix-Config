{ inputs, pkgs, settings, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
  [
    ../../base/user
    ../../../user/app/shell
    ../../../user/app/shell/scripts/update.nix
    ../../../user/app/git
    ../../../user/app/shell/kitty
    ../../../user/app/browser/firefox
    ../../../user/app/browser/librewolf
  ];

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
