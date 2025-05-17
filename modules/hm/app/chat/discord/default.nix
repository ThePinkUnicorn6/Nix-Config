{ config, pkgs, ... }:
let
  colours = config.lib.stylix.colors;
in{
  home.packages = with pkgs; [
    vesktop
  ];
}
