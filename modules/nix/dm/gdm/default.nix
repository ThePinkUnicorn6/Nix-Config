{ config, lib, pkgs, ... }:

{
  services = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
}
