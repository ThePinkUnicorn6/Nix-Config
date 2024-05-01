{ lib, config, pkgs, settings, ... }:

{
  imports = [
    ../../base/user
  ];

  home.packages = with pkgs; [
  ];
}
