{ config, lib, pkgs, settings, ... }:
let
  stateVersion = config.system.stateVersion;
  dataDir = "${settings.dataDir}/jellyfin";
in{

  systemd.tmpfiles.rules = [
    "d ${dataDir} 0775 jellyfin jellyfin - -"
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
  services.caddy = {
    virtualHosts."http://jf.home.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8096
    '';
  };

}
