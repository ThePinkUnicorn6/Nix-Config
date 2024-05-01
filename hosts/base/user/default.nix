{ lib, config, pkgs, settings, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = settings.user.username;
  home.homeDirectory = "/home/"+settings.user.username;
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
  ];
}
