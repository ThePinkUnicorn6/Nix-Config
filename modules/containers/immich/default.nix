{ config, settings, ... }:
let
  stateVersion = config.system.stateVersion;
in{
  systemd.tmpfiles.rules = [
    "d ${settings.dataDir}/postgresql 0700 postgres - - -"
    "d ${settings.mediaDir}/Photos 0775 ${settings.username} - - -"
    "d ${settings.mediaDir}/Photos/immich 0775 immich - - -"
  ];
  services.immich = {
    enable = true;
    host = "100.100.212.90";
    openFirewall = true;
    port = 3002;
    mediaLocation = "${settings.mediaDir}/Photos/immich";
  };
  services.postgresql.dataDir = "${settings.dataDir}/postgresql";
  services.caddy = {
    virtualHosts."http://photos.home.lan".extraConfig = ''
      reverse_proxy http://100.100.212.90:3002
    '';
  };  
  # containers.immich = {
  #   autoStart = true;
  #   bindMounts = {
  #     "/var/lib/postgresql" = {
  #       hostPath = "${settings.dataDir}/postgresql";
  #       isReadOnly = false;
  #     };
  #     "/var/lib/immich" = {
  #       hostPath = "${settings.mediaDir}/Photos/immich";
  #       isReadOnly = false;
  #     };
  #   };
  #   config =  { config, pkgs, lib, ... }: {
  #     services.immich = {
  #       enable = true;
  #       host = "100.100.212.90";
  #       openFirewall = true;
  #       port = 3002;
  #     };
  #     system.stateVersion = stateVersion;
  #   };
  # };

}
