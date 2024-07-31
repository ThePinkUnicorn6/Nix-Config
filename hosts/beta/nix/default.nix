{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../server-base/nix
    ../../../modules/nix/gpu/intel-igpu
  ]++
  (map (m: ../../../modules/containers + m) [
#   "/immich"
    "/blocky"
    "/homarr"
    "/jellyfin"
    "/dashdot"
  ]);

  # Networking
  networking = {
    hostName = "beta"; # Define your hostname.
    firewall.enable = true;
  };

  services.caddy = {
    enable = true;
    globalConfig = ''
      auto_https off
    '';
    virtualHosts."http://home.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:7575
    '';
    virtualHosts."http://jf.home.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:8096
    '';
    virtualHosts."http://dd.home.lan".extraConfig = ''
      reverse_proxy http://127.0.0.1:3001
    '';
  };

  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.name;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Filesystem
  fileSystems = {
    "/nix" = {
      device = "/dev/disk/by-label/nix";
      fsType = "ext4";
      neededForBoot = true;
      options = [ "noatime" ];
    };
    "/drive" = {
      device = "/dev/disk/by-uuid/a25ae181-9f2c-4603-8094-09b097021735";
      fsType = "ext4";
    };
  };

  systemd.tmpfiles.rules = [
    "d ${settings.serviceMediaRoot} 0775 ${settings.username} - - -"
    "d ${settings.serviceMediaRoot}/Video 0775 ${settings.username} - - -"
    "d ${settings.serviceMediaRoot}/Photos 0775 ${settings.username} - - -"
    "d ${settings.serviceMediaRoot}/Documents 0775 ${settings.username} - - -"
  ];

  system.stateVersion = "24.05";
}
