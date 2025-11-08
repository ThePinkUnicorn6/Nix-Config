{ config, lib, pkgs, ... }:

{
  imports = [
    ./wayland.nix
    ./pipewire.nix
  ];
  services.gnome.gnome-keyring.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
