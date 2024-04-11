{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary.background = "#"+config.lib.stylix.colors.base00;
        primary.foreground = "#"+config.lib.stylix.colors.base07;
        cursor.text = "#"+config.lib.stylix.colors.base00;
        cursor.cursor = "#"+config.lib.stylix.colors.base07;
        normal.black = "#"+config.lib.stylix.colors.base00;
        normal.red = "#"+config.lib.stylix.colors.base08;
        normal.green = "#"+config.lib.stylix.colors.base0B;
        normal.yellow = "#"+config.lib.stylix.colors.base0A;
        normal.blue = "#"+config.lib.stylix.colors.base0D;
        normal.magenta = "#"+config.lib.stylix.colors.base0E;
        normal.cyan = "#"+config.lib.stylix.colors.base0B;
        normal.white = "#"+config.lib.stylix.colors.base05;
        bright.black = "#"+config.lib.stylix.colors.base03;
        bright.red = "#"+config.lib.stylix.colors.base09;
        bright.green = "#"+config.lib.stylix.colors.base01;
        bright.yellow = "#"+config.lib.stylix.colors.base02;
        bright.blue = "#"+config.lib.stylix.colors.base04;
        bright.magenta = "#"+config.lib.stylix.colors.base06;
        bright.cyan = "#"+config.lib.stylix.colors.base0F;
        bright.white = "#"+config.lib.stylix.colors.base07;
      };
      window.opacity = 0.65;
      window.padding ={
        x = 15;
        y = 15;
      };
      font.size = config.stylix.fonts.sizes.terminal;
    };
  };
}
