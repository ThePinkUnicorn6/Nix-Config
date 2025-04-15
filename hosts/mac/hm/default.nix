{ lib, config, pkgs, settings, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = settings.username;
  home.homeDirectory = "/home/"+settings.username;
  home.stateVersion = "23.11";

  imports = [
    ../../desktop-base/hm
  ] ++
  (map (m: ../../../modules/hm + m) [
#    "/app/chat/discord"
    "/app/video/mpv"
#    "/app/emacs"
    "/app/desktop/gammastep"

    "/wm/${settings.wm}"
    /wm/xfce
    "/style"
  ]);

#  services = {
#    kdeconnect = {
#      enable = true;
#      indicator = true;
#    };
#  };

  #services.syncthing.tray.enable = true;
  home.packages = with pkgs; [
    # System
    librewolf
    baobab
    gnome-disk-utility
    nautilus
    file-roller
    mission-center
 
    # Text
    gnome-text-editor

    # Video
    yt-dlp
    vlc
    delfin
    freetube

    # Chat

  ];
}
