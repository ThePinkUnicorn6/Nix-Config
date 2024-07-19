{ config, pkgs, inputs, lib, ... }:
{
  imports = [
    ../../base/nix
    ../../../modules/nix/services/comin
  ];
  networking = {
    hostName = lib.mkDefault "nixos-server"; # Define your hostname.
    firewall = {
      allowedTCPPorts = [];
    };
  };

  services = {
    tailscale.enable = true;
    tailscale.useRoutingFeatures = "both";
  };

}
