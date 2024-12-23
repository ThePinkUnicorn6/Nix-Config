{ config, lib, pkgs, ... }:

{
  services.autossh.sessions = [
    {
      name = "immich-dietpi-tunnel";
      user = "beta";
      extraArguments = "-N -R 0.0.0.0:80:localhost:3002 dietpi@dietpi";
    }
  ];
}
