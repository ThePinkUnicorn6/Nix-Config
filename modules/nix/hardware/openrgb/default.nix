{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      openrgb = (prev.openrgb.overrideAttrs {
        patches = [ ./nzxt_f120_core_fan.patch ];
      });
    })
  ];
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };
  environment.systemPackages = [
    pkgs.openrgb-with-all-plugins
  ];
}
