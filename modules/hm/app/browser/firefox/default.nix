{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
#    languagePacks = [ "en-GB" ];
    profiles = {
      default = {
        id = 0;
        isDefault = true;
        extensions.force = true;
      };
    };
  };
  stylix.targets.firefox.profileNames = [ "default"];
}
