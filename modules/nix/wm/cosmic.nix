{ config, lib, pkgs, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.power-profiles-daemon.enable = false;
}
