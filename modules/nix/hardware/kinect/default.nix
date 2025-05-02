{ config, lib, pkgs, ... }:
let
  kinect-udev-rules = pkgs.callPackage ./udev.nix { };
in{
  environment.systemPackages = with pkgs; [
      freenect
      kinect-audio-setup
  ];
  services.udev.packages = [ kinect-udev-rules ];
  users.groups.plugdev = { };
}
