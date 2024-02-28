{ pkgs, settings, ... }:
{
  imports =
  [
    ../user/app/shell
    ../user/app/shell/scripts/update.nix
  ];
  programs.git = {
    enable = true;
    userName = settings.user.gitName;
    userEmail = settings.user.email;
  };
  home.packages = with pkgs; [
    oh-my-zsh
    alacritty
    firefox
    syncthing
    syncthingtray
    usbutils
    pciutils
    python3
    libressl
  ];

}
