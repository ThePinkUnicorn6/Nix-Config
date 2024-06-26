{ pkgs, inputs, lib, config, ... }:
{
  imports = [
    ../yabridge
    ../vsts
  ];
  home.packages = with pkgs; [
    reaper
  ];
}
