{ config, lib, pkgs, ... }:

{
  services = {
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
  };
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  
  xdg.portal.enable = true;
}
