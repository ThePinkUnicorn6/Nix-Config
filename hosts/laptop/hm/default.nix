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
    "/app/chat/discord"
    "/app/video/mpv"
    "/app/emacs"
    "/app/programming/vscode"
    "/lang/csharp"
    "/app/tex"
    "/lang/python"
    "/lang/python/python-packages"
    "/lang/rust"
    "/app/desktop/gammastep"
    "/app/fido2"
 
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
    brightnessctl
    baobab
    gnome-disk-utility
    nautilus
    file-roller
    du-dust
    resources
 
    # Wine
    wine
    bottles

    # Text
    gnome-text-editor
    libreoffice
    hunspell
    hunspellDicts.en_GB-ise
    rnote

    # Video
    yt-dlp
    vlc
    delfin
    freetube

    # Photo
    loupe
    gthumb
    
    # Audio
    lollypop
    gqrx

    # Chat
    whatsapp-for-linux
    #discord

    # Uni
#    ciscoPacketTracer8
    
    # Other
    pandoc
  ];
}
