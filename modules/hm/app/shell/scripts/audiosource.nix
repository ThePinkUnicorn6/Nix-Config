{ config, lib, pkgs, ... }:
let
  audiosource = lib.fetchurl{
    url = "https://github.com/gdzx/audiosource/releases/download/v1.4/audiosource";
    hash = "";
  };
in{
  home.packages = with pkgs; [
    (pkgs.writeScriptBin "nu" autdiosource)
  ];
}
