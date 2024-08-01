{ config, lib, pkgs, settings, ... }:

{
  systemd.tmpfiles.rules = [
    "d ${settings.dataDir}/syncthing 0775 syncthing - - -"
  ];
  networking.firewall = {
    allowedTCPPorts = [
      8384 # Syncthing
      22000 # Syncthing
    ];
    allowedUDPPorts = [
      22000 # Syncthing
      21027 # Syncthing
    ];
  };
  services.syncthing = {
    enable = true;
    dataDir = "${settings.mediaDir}/Documents/syncthing";
    configDir = "${settings.dataDir}/syncthing";
    settings.options.relaysEnabled = false;
    guiAddress = "${settings.tailscaleIP}:8384";
  };
}
