{ pkgs, ... }:
{
  imports = [
    ../../app/desktop/fuzzel
    ../../app/desktop/mako
  ];
  home.packages = with pkgs; [
    swaybg
  ];
}
