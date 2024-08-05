{ config, lib, pkgs, settings, ... }:

{
  services.gammastep = {
    enable = true;
    tray = true;
    provider = "manual";
    latitude = settings.loc.lat;
    longitude = settings.loc.lon;
    temperature.night = 3500;
    temperature.day = 6500;
  };
}
