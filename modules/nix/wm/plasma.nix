{ config, lib, pkgs, ... }:

{

  services = {
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
  };
  xdg.portal.enable = true;
}
