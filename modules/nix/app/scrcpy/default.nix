{ config, lib, pkgs, ... }:

{
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
  boot.kernelModules = ["v4l2loopback"];

  programs.adb.enable = true; # enable android proper data tethering
  environment.systemPackages = with pkgs; [
    scrcpy
  ];
}
