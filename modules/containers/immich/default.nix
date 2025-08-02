{ config, settings, ... }:
{
  systemd.tmpfiles.rules = [
    "d ${settings.dataDir}/postgresql 0700 postgres - - -"
    "d ${settings.mediaDir}/Photos 0775 ${settings.username} - - -"
    "d ${settings.mediaDir}/Photos/immich 0775 immich - - -"
  ];
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    openFirewall = true;
    port = 3002;
    mediaLocation = "${settings.mediaDir}/Photos/immich";
  };
  services.postgresql.dataDir = "${settings.dataDir}/postgresql";
  services.caddy = {
    virtualHosts."http://photos.home.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:3002
    '';
  };  
}
