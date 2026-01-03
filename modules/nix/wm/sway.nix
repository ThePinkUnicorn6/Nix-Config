{ config, lib, pkgs, ... }:

{
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
