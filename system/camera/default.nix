{ config, lib, pkgs, ... }:

{
  services.gvfs.enable = true;
  programs.gphoto2.enable = true;
  environment.systemPackages = with pkgs; [
    gphoto2
    gphoto2fs
  ];
}
