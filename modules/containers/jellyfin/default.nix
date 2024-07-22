{ config, lib, pkgs, ... }:
let
  stateVersion = config.system.stateVersion;
in{
  # Hardware encoding
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.graphics = { # hardware.opengl in 24.05
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver # previously vaapiIntel
      vaapiVdpau
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      vpl-gpu-rt # QSV on 11th gen or newer
      intel-media-sdk # QSV up to 11th gen
    ];
  };

  # Networking
  networking = {
    firewall = {
      allowedTCPPorts = [
        8096 # HTTP
      ];
      allowedUDPPorts = [
        1900 # Service Discovery
        7359 # Client Discovery
      ];
    };
  };

  # JF service
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
