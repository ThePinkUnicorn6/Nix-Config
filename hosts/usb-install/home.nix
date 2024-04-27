{ lib, config, pkgs, settings, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = settings.user.username;
  home.homeDirectory = "/home/"+settings.user.username;
  home.stateVersion = "22.11";

  imports = [
    ../common-home.nix
    ../../user/app/video/mpv
    ../../user/app/emacs
    ../../user/app/tex

    ../../user/wm/${settings.user.wm}
    ../../user/style
  ];
  programs.alacritty.enable = true;
  services = {
    syncthing.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
  #services.syncthing.tray.enable = true;
  home.packages = with pkgs; [
    # System
    gparted
    baobab

    # Text
    libreoffice-fresh
    hunspell
    hunspellDicts.en_GB-ise

    # Video
    yt-dlp
    
    # Other
    pandoc
    # Fonts
    pkgs.${settings.user.fontPkg}
  ];
}
