{ config, lib, pkgs, ... }:

{
  services.mako = {
    enable = true;
    settings = {
      border-size = 2;
      border-radius = 8;
      default-timeout = 5000;
    };
  };
}
