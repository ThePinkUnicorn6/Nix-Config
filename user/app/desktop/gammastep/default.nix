{ config, lib, pkgs, settings, ... }:

{
  services.gammastep = {
    enable = true;
    tray = true;
    temperature.night = 3500;
    latitude = settings.user.location.lat;
    longitude = settings.user.location.lon;
  };
}
