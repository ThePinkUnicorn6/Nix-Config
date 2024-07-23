{ config, lib, pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      # Required for container networking to be able to use names.
      dns_enabled = true;
    };
  };

  virtualisation.oci-containers.backend = "podman";
  systemd.timers."podman-auto-update".wantedBy = [ "timers.target" ];
}
