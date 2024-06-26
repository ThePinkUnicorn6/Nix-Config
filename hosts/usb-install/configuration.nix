{ config, pkgs, inputs, settings, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../common.nix
      ../../system/wm/${settings.wm}.nix
      ../../system/style
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos-usb"; # Define your hostname.
    nameservers = [ "100.100.100.100" "100.85.99.93" "1.1.1.1" ];
    networkmanager.dns = "none";
  };
  security.polkit.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  
  system.stateVersion = "23.11"; # Did you read the comment?
}

