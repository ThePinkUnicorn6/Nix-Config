{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = with pkgs; [
    (final: prev: {
      openrgb = (prev.openrgb.overrideAttrs (oldAttrs: {
        patches = [ ./nzxt_f120_core_fan.patch ];
      }));
    })
  ];
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };
  environment.systemPackages = with pkgs; [
    openrgb-with-all-plugins
  ];
}
