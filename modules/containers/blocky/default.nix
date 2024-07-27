{ config, lib, pkgs, settings, ... }:

{
  containers.blocky = {
    autoStart = true;
    forwardPorts = [
      {
        containerPort = 53;
        hostPort = 53;
        protocol = "tcp";
      }
      {
        containerPort = 53;
        hostPort = 53;
        protocol = "udp";
      }
    ];
    config =  { config, pkgs, lib, ... }: {
      services.blocky = {
        enable = true;
        settings = {
          # For initially solving DoH/DoT Requests when no system Resolver is available.
          upstreams = {
            init.strategy = "fast";
            groups = {
              default = [
                "1.1.1.1"
                "1.0.0.1"
              ];
            };
          };
          customDNS.mapping = {
            "home.lan" = settings.tailscaleIP;
          };
          blocking = {
            denylists = {
              ads = [
                "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
              ];
            };
            clientGroupsBlock = {
              default = [ "ads" ];
            };
          };
          ports = {
            dns = "${settings.tailscaleIP}:53";
          };
          log = {
            privacy = true;
          };
        };
      };
    };
  };
}
