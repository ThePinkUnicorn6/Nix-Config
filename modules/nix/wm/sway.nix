{ config, lib, pkgs, ... }:

{
  imports = [
    ./wayland.nix
    ./pipewire.nix
  ];
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  xdg.portal.wlr.enable = true;
}
