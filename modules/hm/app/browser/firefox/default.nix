{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
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
