{ config, lib, pkgs, ... }:
{
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     openrgb = (prev.openrgb.overrideAttrs {
  #       patches = [
  #         ./nzxt_f120_core_fan.patch
  #         ./qlist-include.patch
  #       ];
  #     });
  #     openrgb-with-all-plugins = final.openrgb.withPlugins [
  #       final.openrgb-plugin-effects
  #       final.openrgb-plugin-hardwaresync
  #       (final.libsForQt5.callPackage ./visualmap { })
  #     ];
  #   })
  # ];
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };
  environment.systemPackages = [
    pkgs.openrgb-with-all-plugins
  ];
}
