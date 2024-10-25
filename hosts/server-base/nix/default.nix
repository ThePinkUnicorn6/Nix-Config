{ config, pkgs, inputs, lib, ... }:
{
  imports = [
    ../../base/nix
  ];
  networking = {
    hostName = lib.mkDefault "nixos-server"; # Define your hostname.
    firewall = {
      allowedTCPPorts = [];
    };
  };

  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
      };
    };
  };
}
