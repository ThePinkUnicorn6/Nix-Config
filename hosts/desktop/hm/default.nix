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
    /app/browser/zen
    /app/chat/discord
    /app/music-prod/reaper
    /app/video/mpv
    /app/emacs
    /app/programming/vscode
    /lang/csharp
    /app/tex
    /lang/python
    /lang/python/python-packages
    /lang/rust
    /app/llm/ollama
    /app/llm/mods
    /app/desktop/gammastep
    /app/fido2
    /app/calibre
    /service/vr
    #./app/distrobox

    "/wm/${settings.wm}"
    /style
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
    baobab
    gnome-disk-utility
    nautilus
    file-roller
    jdk17
    gcc
    du-dust
    mission-center
 
    # Wine
    wine
    bottles

    # Text
    gnome-text-editor
    libreoffice
    onlyoffice-desktopeditors
    hunspell
    hunspellDicts.en_GB-ise

    # Video
    yt-dlp
    vlc
    delfin
    freetube
    #blender

    # Photo
    loupe
    gthumb
    freenect
    
    #ansel

    # Audio
    lollypop
    gqrx
    
    # Chat
    whatsapp-for-linux
    #discord
    signal-desktop

    # Games
    prismlauncher
    r2modman
    
    # Uni
    zotero
    
    # Other
    pandoc
    microcom
    flowtime
    picard
  ];
}
