{ config, lib, pkgs, ... }:

{
   musnix = {
    enable = true;
  };
  environment.sessionVariables = {
    WINEFSYNC = "1";
  };
}
