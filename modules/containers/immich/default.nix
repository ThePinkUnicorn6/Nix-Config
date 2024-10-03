{ config, settings, ... }:

{
  systemd.tmpfiles.rules = [
    "d ${settings.dataRoot}/immich 0775 ${settings.username} - - -"
    "d ${settings.mediaRoot}/Photos 0775 ${settings.username} - - -"
    "d ${settings.mediaRoot}/Photos/Immich 0775 ${settings.username} - - -"
  ];
  containers.immich = {
    autoStart = true;
    config =  { config, pkgs, lib, ... }: {
      services.immich = {
        enable = true;
        openFirewall = true;
        mediaLocation = "${settings.mediaRoot}/Photos";
      };
      services.postgresql.dataDir = "${settings.dataRoot}/immich/";
    };
  };

}
