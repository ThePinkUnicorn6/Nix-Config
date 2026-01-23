{ config, lib, pkgs, ... }:
{
  # For WiVRn:
  home.packages = with pkgs; [
    wayvr
  ];
}
