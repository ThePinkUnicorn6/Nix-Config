{ pkgs, lib, ... }:
{
  # Containers
  virtualisation.oci-containers.containers."dashdot-dash" = {
    image = "mauricenino/dashdot:latest";
    environment = {
      "DASHDOT_ENABLE_CPU_TEMPS" = "true";
      "DASHDOT_FS_DEVICE_FILTER" = "mmcblk0boot0,mmcblk0boot1";
    };
    volumes = [
      "/:/mnt/host:ro"
    ];
    ports = [
      "3001:3001/tcp"
    ];
    extraOptions = [
      "--privileged"
    ];
  };
  services.caddy = {
    virtualHosts."http://dd.home.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:3001
    '';
  };
}
