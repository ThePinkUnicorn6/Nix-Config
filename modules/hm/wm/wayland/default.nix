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
    # config = {
    #   common = {
    #     default = [
    #       "gtk"
    #       "hyprland"
    #     ];
    #   };
    #   hyprland = {
    #     default = [
    #       "gtk"
    #       "hyprland"
    #     ];
    #   };
    # };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
