{ lib, config, pkgs, inputs, settings, ... }:
{
  imports = [
    ../../base/nix
  ] ++
  (map (m: ../../../modules/nix + m) [
    "/polkit"
    "/dm/${settings.dm}"
    "/camera"
    "/hardware/rtl-sdr"
    /app/fido2
  ]);

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      dns = "none";
    };

    firewall = {
      allowedTCPPorts = [
        8384 # Syncthing
        22000 # Syncthing
      ];
      allowedTCPPortRanges = [
        { from = 1714; to = 1764;} # KDE Connect
      ];
      allowedUDPPorts = [
        22000 # Syncthing
        21027 # Syncthing
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764;} # KDE Connect
      ];
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
  hardware.keyboard.qmk.enable = true;
  nix.settings.trusted-users = [ "root" settings.username ];
  # Packages
  environment.systemPackages = with pkgs; [
    openssl
    libressl
    libnotify
    gparted # Doesn't work in hm
  ];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
  programs.adb.enable = true;

  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.devmon.enable = true;
  services.udisks2.enable = true;
  environment.localBinInPath = true;
}
