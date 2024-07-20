{ pkgs, lib, ... }:
{
  # Containers
  virtualisation.oci-containers.containers."dashdot-dash" = {
    image = "mauricenino/dashdot:latest";
    volumes = [
      "/:/mnt/host:ro"
    ];
    ports = [
      "80:3001/tcp"
    ];
    extraOptions = [
      "--privileged"
    ];
  };
}
