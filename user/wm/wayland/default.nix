{ pkgs, ... }:
{
  imports = [
    ../../app/desktop/fuzzel
    ../../app/desktop/mako
  ];
  home.packages = with pkgs; [
    hyprpaper
  ];
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "gtk"
        ];
      };
      hyprland = {
        default = [
          "gtk"
          "kde"
          "hyprland"
        ];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-kde
    ];
  };
}
