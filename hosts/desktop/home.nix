{ lib, config, pkgs, settings, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = settings.user.username;
  home.homeDirectory = "/home/"+settings.user.username;
  home.stateVersion = "22.11";

  imports = [
    ../common-home.nix
    ../../user/app/chat/discord
    ../../user/app/music/production
    ../../user/app/video/mpv
    ../../user/app/emacs
    ../../user/app/programming/vscode
    ../../user/lang/csharp
    ../../user/app/tex
    ../../user/lang/python
    ../../user/lang/python/python-packages
    ../../user/app/llm/ollama
    ../../user/app/desktop/gammastep
    ../../user/app/fido2

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
    gnome.gnome-disk-utility
    dolphin
    jdk17
    gcc

    # Wine
    wine
    bottles

    # Text
    gnome-text-editor
    kate
    libreoffice-fresh
    hunspell
    hunspellDicts.en_GB-ise

    # Video
    yt-dlp
    vlc
    delfin
    # Photo
    loupe
    gthumb

    # Chat
    whatsapp-for-linux

    # Other
    pandoc
    activitywatch
    g4music
    microcom
    flowtime
    (calibre.overrideAttrs (attrs: {
      preFixup = (
        builtins.replaceStrings[''
          --prefix PYTHONPATH : $PYTHONPATH \
        ''] [''
          --prefix LD_LIBRARY_PATH : ${pkgs.libressl.out}/lib \
          --prefix PYTHONPATH : $PYTHONPATH \
        '']
      attrs.preFixup
      );
    }))

    # Fonts
    pkgs.${settings.user.fontPkg}
  ];
}
