{ config, lib, pkgs, settings, ... }:
let
  stateVersion = config.system.stateVersion;
  dataDir = "${settings.serviceConfigRoot}/jellyfin";
in{

  systemd.tmpfiles.rules = [
    "d ${settings.serviceConfigRoot}/jellyfin 0775 jellyfin jellyfin - -"
  ];
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
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    dataDir = dataDir;
  };
  users.users.jellyfin.extraGroups = [ "render" ];
  environment.systemPackages = with pkgs; [
    jellyfin-ffmpeg
    libva-utils
  ];
}
