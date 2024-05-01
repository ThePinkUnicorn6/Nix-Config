{ config, pkgs, inputs, settings, ... }:

{
  imports =[
    ../../base/system
  ];
  networking = {
    hostName = "nixos-server"; # Define your hostname.
  };
}
