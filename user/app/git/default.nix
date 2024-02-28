{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    gitFull
  ];
  programs.git = {
    enable = true;
    userName = "Example Username";
    userEmail = "example@example.com";
  };
}
