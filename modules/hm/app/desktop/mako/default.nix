{ config, lib, pkgs, ... }:

{
  services.mako = {
    enable = true;
    settings = {
      borderSize = 2;
      borderRadius = 8;
      defaultTimeout = 5000;
    };
  };
}
