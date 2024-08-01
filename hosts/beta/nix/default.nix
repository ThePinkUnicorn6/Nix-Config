{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./syncthing.nix
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
    "d ${settings.mediaDir} 0775 ${settings.username} - - -"
    "d ${settings.mediaDir}/Video 0775 ${settings.username} - - -"
    "d ${settings.mediaDir}/Photos 0775 ${settings.username} - - -"
    "d ${settings.mediaDir}/Documents 0775 ${settings.username} - - -"
    "d ${settings.mediaDir}/Music 0775 ${settings.username} - - -"
  ];

  system.stateVersion = "24.05";
}
