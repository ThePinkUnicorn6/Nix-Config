{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    libfido2
  ];
}
