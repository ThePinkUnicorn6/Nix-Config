{ config, lib, pkgs, settings, ... }:

{
  services.redshift = {
    enable = true;
    tray = true;
    temperature.night = 2500;
    latitude = settings.user.location.lat;
    longitude = settings.user.location.lon;
  };
}
