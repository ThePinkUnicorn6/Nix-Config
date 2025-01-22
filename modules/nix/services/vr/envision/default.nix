{ config, lib, pkgs, ... }:

{
  programs.envision = {
    enable = true;
    openFirewall = true;
  };
  programs.corectrl = {
    enable = true;
    gpuOverclock.enable = true;
  };
}
