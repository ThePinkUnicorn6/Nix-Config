{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../server-base/nix
  ]++
  (map (m: ../../../modules/containers + m) [
#   "/immich"
    "/technitium-dns"
    "/homarr"
    "/jellyfin"
    "/dashdot"
  ]);
  networking = {
    hostName = "beta"; # Define your hostname.
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
