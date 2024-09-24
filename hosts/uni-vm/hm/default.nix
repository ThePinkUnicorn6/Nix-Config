{ lib, config, pkgs, settings, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = settings.username;
  home.homeDirectory = "/home/"+settings.username;
  home.stateVersion = "24.05";

  imports = [
    ../../desktop-base/hm
  ] ++
  (map (m: ../../../modules/hm + m) [
#    "/app/chat/discord"
    "/app/video/mpv"
    "/app/emacs"
    "/app/programming/vscode"
    "/lang/csharp"
    "/app/tex"
    "/lang/python"
    "/lang/python/python-packages"
    "/lang/rust"
    "/app/fido2"
    "/app/browser/firefox"

    "/wm/${settings.wm}"
    "/style"
  ]);

  #services.syncthing.tray.enable = true;
  home.packages = with pkgs; [
    # System
    baobab
    nautilus
    file-roller
    mission-center

    # Wine
    wine

    # Text
    gnome-text-editor
    hunspell
    hunspellDicts.en_GB-ise

    # Photo
    loupe
    gthumb

    # Chat
#    whatsapp-for-linux
    #discord

    # Other
    pandoc
  ];
}
