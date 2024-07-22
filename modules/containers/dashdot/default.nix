{ pkgs, lib, ... }:
{
  # Containers
  virtualisation.oci-containers.containers."dashdot-dash" = {
    image = "mauricenino/dashdot:latest";
    environment = {
      "DASHDOT_ENABLE_CPU_TEMPS" = "true";
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
}
