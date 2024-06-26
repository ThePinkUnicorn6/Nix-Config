{ config, lib, pkgs, settings, ... }:

{
  services.gammastep = {
    enable = true;
    tray = true;
    provider = "geoclue2";
    temperature.night = 3500;
    temperature.day = 6500;
  };
}
