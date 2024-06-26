{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    yubikey-manager
    libfido2
    yubikey-manager-qt
  ];
}
