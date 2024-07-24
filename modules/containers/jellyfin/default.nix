{ config, lib, pkgs, settings, ... }:
let
  stateVersion = config.system.stateVersion;
  dataDir = "${settings.serviceConfigRoot}/jellyfin";
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
  systemd.tmpfiles.rules = [
    "d ${settings.serviceConfigRoot}/jellyfin 0775 - - - -"
  ];
  # JF service
  containers.jellyfin = {
    autoStart = true;
    forwardPorts = [
      {
        containerPort = 8096;
        hostPort = 8096;
        protocol = "tcp";
      }
      {
        containerPort = 1900;
        hostPort = 1900;
        protocol = "udp";
      }
      {
        containerPort = 7359;
        hostPort = 7359;
        protocol = "udp";
      }
    ];
    bindMounts = {
      "/home/Video" = {
        hostPath = "${settings.serviceMediaRoot}/Video";
        isReadOnly = false;
      };
      "/var/lib/jellyfin" = {
        hostPath = dataDir;
        isReadOnly = false;
      };
    };
    allowedDevices = [
      {
        modifier = "rw";
        node = "/dev/dri";
      }
    ];
    config = { config, pkgs, lib, ... }: {
      services.jellyfin = {
        enable = true;
        openFirewall = true;
      };
      users.users.jellyfin.extraGroups = [ "render" ];
      environment.systemPackages = with pkgs; [
        jellyfin-ffmpeg
      ];
      system.stateVersion = stateVersion;
    };
  };
}
