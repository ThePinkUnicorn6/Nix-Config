# Acts as a base configuration that all other hosts add to.

{ config, pkgs, lib, inputs, settings, ... }:

{
  imports = [

  ];
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = lib.mkDefault "nixos"; # Define your hostname.
    nameservers = [ "100.100.100.100" "1.1.1.1" "1.0.0.1" ];
    networkmanager.dns = "none";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Zsh
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    efibootmgr
    zip
    unzip
    git
    wget
    openssl
    killall
    usbutils
    pciutils
    comma
  ];

  # Garbage collect
  nix.gc = {
    automatic = true;
    dates = ["daily"];
    options = "--delete-older-than 7d";
  };
}

