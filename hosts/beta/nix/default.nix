{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../server-base/nix
  ]++
  (map (m: ../../../modules/containers + m) [
    "/immich"
    "/jellyfin"
    "/dasdot"
  ]);
  networking = {
    hostName = "beta"; # Define your hostname.
  };

  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.name;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "24.05";
}
