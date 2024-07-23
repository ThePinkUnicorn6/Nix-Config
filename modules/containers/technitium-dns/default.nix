{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      53 # DNS
      5380 # HTTP
#      53443
    ];
    allowedUDPPorts = [
      53 # DNS
    ];
  };
  containers.technitium = {
    autoStart = true;
    config =  { config, pkgs, lib, ... }: {
      services.technitium-dns-server = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
