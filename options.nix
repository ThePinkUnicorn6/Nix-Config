{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib.types;
{
  options.settings = {
    name = {
      type = str;
    };
    personal-email = {
      type = str;
    };
    git-email = {
      type = str;
      default = config.settings.email;
    };
    git-name = {
      type = str;
      default = "ThePinkUnicorn6";
    };
    username = {
      type = str;
      default = config.settings.name;
    };
    wm = {
      type = enum [ "hyprland" "plasma" ];
      default = "hyprland";
    };
    dm = {
      type = enum [ "tuigreet" "gdm" ];
      default = "tuigreet";
    };
    theme = {
      type = str;
      default = "catppucchin-mocha";
    };
    wallpaper = {
      type = path;
      default = ./wallpapers/city_sunset.png;
    };
    reThemeWall = {
      type = bool;
      default = true;
    };
    font = {
      type = str;
      default = "Iosevka Aile";
    };
    fontPkg = {
      type = str;
      default = "iosevka";
    };
  };
}
