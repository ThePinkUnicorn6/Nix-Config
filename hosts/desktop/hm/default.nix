{ lib, config, pkgs, settings, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = settings.username;
  home.homeDirectory = "/home/"+settings.username;
  home.stateVersion = "22.11";

  imports = [
    ../../desktop-base/hm
  ] ++
  (map (m: ../../../modules/hm + m) [
#    "/app/chat/discord"
    "/app/music-prod/reaper"
    "/app/video/mpv"
    "/app/emacs"
    "/app/programming/vscode"
    "/lang/csharp"
    "/app/tex"
    "/lang/python"
    "/lang/python/python-packages"
    "/lang/rust"
    "/app/llm/ollama"
    "/app/desktop/gammastep"
    "/app/fido2"
    "/app/calibre"
    "/app/browser/firefox"
    #./app/distrobox

    "/wm/${settings.wm}"
    "/style"
  ]);

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
    gnome.gnome-disk-utility
    gnome.nautilus
    gnome.file-roller
    jdk17
    gcc
    du-dust
    mission-center

    # Wine
    wine
    bottles

    # Text
    gnome-text-editor
    libreoffice-fresh
    hunspell
    hunspellDicts.en_GB-ise

    # Video
    yt-dlp
    vlc
    delfin
    freetube
    blender

    # Photo
    loupe
    gthumb
    ansel

    # Audio
    g4music
    mpris-scrobbler

    # Chat
    whatsapp-for-linux
    discord

    # Games
    prismlauncher

    # Other
    pandoc
    activitywatch
    microcom
    flowtime
    picard

    # Fonts
    pkgs.${settings.fontPkg}
  ];
}
