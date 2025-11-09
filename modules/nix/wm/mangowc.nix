{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./wayland.nix
    ./pipewire.nix
    inputs.mango.nixosModules.mango
  ];
  services.gnome.gnome-keyring.enable = true;
  programs.mango.enable = true;
}
