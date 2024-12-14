{ config, lib, pkgs, ... }:

{
  programs.envision = {
    enable = true;
    openFirewall = true;
  };
}
