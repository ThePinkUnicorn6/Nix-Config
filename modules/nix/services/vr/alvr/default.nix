{ config, lib, pkgs, ... }:

{
  programs.alvr = {
    enable = true;
    openFirewall = true;
  };
}
