{ pkgs, ... }:
{
  imports = [
    ./wayland.nix
    ./pipewire.nix
  ];
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
  };
  xdg.portal = {
    enable = true;
    # config = {
    #   common = {
    #     default = [
    #       "gtk"
    #       "hyprland"
    #     ];
    #   };
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
