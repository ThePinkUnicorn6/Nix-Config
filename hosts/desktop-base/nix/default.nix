{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ../../base/nix
  ] ++
  (map (m: ../../../modules/nix + m) [
    "/polkit"
    "/dm/${settings.dm}"
    "/camera"
  ]);

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

  # Delete tmp on boot
  boot.tmp.cleanOnBoot = true;

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

  # Enable location services for gammastep;
  services.geoclue2.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${settings.name} = {
    isNormalUser = true;
    description = settings.name;
    extraGroups = [ "networkmanager" "wheel" "adbusers" "dialout" "audio" "camera" ];
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
