{ config, lib, pkgs, ... }:

{
  containers.jellyfin = {
    autoStart = true;
    config = { config, pkgs, lib, ... }: {
      services.jellyfin = {
        enable = true;
      };
      environment.systemPackages = with pkgs; [
        jellyfin-ffmpeg
      ];
    };
  };
}
