{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ../../base/system
    ../../../system/polkit
  ];

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      dns = "none";
    };

    firewall = {
      allowedTCPPorts = [ 8384 22000 ];
      allowedTCPPortRanges = [ { from = 1714; to = 1764;} ];
      allowedUDPPorts = [ 22000 21027 ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764;} ];
    };
  };

  # Enable tailscale
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${settings.user.username} = {
    isNormalUser = true;
    description = settings.user.name;
    extraGroups = [ "networkmanager" "wheel" "adbusers" "dialout" "audio" ];
  };

    # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    efibootmgr
    zip
    zsh
    home-manager
    git
    wget
    openssl
    libnotify
    killall
  ];

  programs.adb.enable = true;

  services.gnome.gnome-keyring.enable = true;  
  services.gvfs.enable = true;
  services.devmon.enable = true;
  services.udisks2.enable = true;
  environment.localBinInPath = true;
}
