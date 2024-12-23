{ config, lib, pkgs, ... }:

{
  systemd.user.services."immich-tunnel-to-dietpi" = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''ssh -N -R 0.0.0.0:80:localhost:3002 dietpi@dietpi'';
    };
  };
}
