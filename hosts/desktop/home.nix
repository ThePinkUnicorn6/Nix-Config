{ lib, config, pkgs, settings, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = settings.username;
  home.homeDirectory = "/home/"+settings.username;
  home.stateVersion = "22.11";

  imports = [
    ../desktop-base/user
    ../../user/app/chat/discord
    ../../user/app/music/production
    ../../user/app/video/mpv
    ../../user/app/emacs
    ../../user/app/programming/vscode
    ../../user/lang/csharp
    ../../user/app/tex
    ../../user/lang/python
    ../../user/lang/python/python-packages
    ../../user/lang/rust
    ../../user/app/llm/ollama
    ../../user/app/desktop/gammastep
    ../../user/app/fido2
    ../../user/app/calibre
    ../../user/app/browser/firefox
    #../../user/app/distrobox

    ../../user/wm/${settings.wm}
    ../../user/style
  ];
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
