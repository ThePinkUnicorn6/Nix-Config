{ config, lib, pkgs, ... }:

{
  systemd.services."immich-tunnel-to-dietpi" = {
    enable = true;
    requires = [ "tailscaled.service" "network-online.target" ];
    after = [ "sys-subsystem-net-devices-tailscale0.device" "tailscaled.service" "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.openssh}/bin/ssh -N -R 0.0.0.0:80:localhost:3002 dietpi@dietpi'';
    };
  };
}
