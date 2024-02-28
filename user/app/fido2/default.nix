{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    pkgs.yubikey-manager
    pkgs.libfido2
  ];
}
