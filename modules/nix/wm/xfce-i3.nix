{ config, lib, pkgs, ... }:

{

  services = {
    xserver.enable = true;
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
  };
  xdg.portal.enable = true;
}
