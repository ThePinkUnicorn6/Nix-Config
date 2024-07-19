{ config, lib, pkgs, ... }:

let
  stateVersion = config.system.stateVersion;
in{
  containers.jellyfin = {
    autoStart = true;
    config = { config, pkgs, lib, ... }: {
      services.jellyfin = {
        enable = true;
      };
      environment.systemPackages = with pkgs; [
        jellyfin-ffmpeg
      ];
      system.stateVersion = stateVersion;
    };
  };
}
