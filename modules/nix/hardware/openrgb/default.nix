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
    package = with pkgs; (openrgb.withPlugins [
      openrgb-plugin-effects
      openrgb-plugin-hardwaresync
      (libsForQt5.callPackage ./visualmap { })
    ]);
  };
  environment.systemPackages = with pkgs; [
    (openrgb.withPlugins [
      openrgb-plugin-effects
      openrgb-plugin-hardwaresync
      (libsForQt5.callPackage ./visualmap { })
    ])
  ];
}
