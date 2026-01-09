{ config, lib, pkgs, ... }:

{
  imports = [
    ./wayland.nix
    ./pipewire.nix
  ];
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    config = {
      common = {
        default = [
          "gtk"
          "wlr"
        ];
      };
      sway = {
        default = [ "wlr" "gtk" ];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
