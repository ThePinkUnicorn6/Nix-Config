{ config, lib, pkgs, ... }:
let
  audiosource = pkgs.fetchurl{
    url = "https://github.com/gdzx/audiosource/releases/download/v1.4/audiosource";
    hash = "sha256-A7P7ac0Q7OLeTkMs40np18Hj2ByW/N4NQ/Bkq/7x/3Q=";
  };
in{
  home.packages = with pkgs; [
    (pkgs.writeScriptBin "audiosource" audiosource)
  ];
}
