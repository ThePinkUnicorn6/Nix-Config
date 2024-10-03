{ config, lib, pkgs, settings, ... }:
let
  stateVersion = config.system.stateVersion;
in{
  systemd.services."container@blocky" = {
    requires = [ "tailscaled.service" "network-online.target" ];
    after = [ "sys-subsystem-net-devices-tailscale0.device" "tailscaled.service" "network-online.target" ];
  };
  containers.blocky = {
    autoStart = true;
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
      system.stateVersion = stateVersion;
    };
  };
}
