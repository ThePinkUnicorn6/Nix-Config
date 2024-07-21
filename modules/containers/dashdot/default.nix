{ pkgs, lib, ... }:
{
  # Containers
  virtualisation.oci-containers.containers."dashdot-dash" = {
    image = "mauricenino/dashdot:latest";
    volumes = [
      "/:/mnt/host:ro"
    ];
    ports = [
      "3001:3001/tcp"
    ];
    extraOptions = [
      "--env DASHDOT_ENABLE_CPU_TEMPS=\"true\""
      "--privileged"
    ];
  };
}
