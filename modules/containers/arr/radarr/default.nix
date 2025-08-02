{ config, lib, pkgs, settings, ... }:

let
  stateVersion = config.system.stateVersion;
  dataDir = "${settings.dataDir}/radarr";
in{
  systemd.tmpfiles.rules = [
    "d ${dataDir} 0775 ${settings.username} - - -"
  ];
  containers.radarr = {
    autoStart = true;
    bindMounts = {
      "/var/lib/radarr/.config/Radarr" = {
        hostPath = dataDir;
      };
      "/media/" = {
        hostPath = "${settings.mediaDir}/";
      };
    };
    
    config =  { config, pkgs, lib, ... }: {
      services.radarr = {
        enable = true;
        dataDir = dataDir;
      };
      system.stateVersion = stateVersion;
    };
  };
  services.caddy = {
    virtualHosts."http://radarr.home.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:7878
    '';
  };
}
