{ lib, config, pkgs, settings, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = settings.user.username;
  home.homeDirectory = "/home/"+settings.user.username;
  home.stateVersion = "22.11";

  imports = [
    ../common-home.nix
    ../../user/wm/${settings.user.wm}
    ../../user/style
  ];
  home.packages = with pkgs; [
  ];
}
