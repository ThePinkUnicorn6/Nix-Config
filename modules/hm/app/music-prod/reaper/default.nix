{ pkgs, inputs, lib, config, ... }:
{
  imports = [
    ../yabridge
    ../vsts
  ];
  home.packages = with pkgs; [
    reaper
    reaper-sws-extension
    reaper-reapack-extension
  ];
}
