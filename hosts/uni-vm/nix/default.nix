{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../desktop-base/nix
  ]++
  (map (m: ../../../modules/nix + m) [
    "/wm/${settings.wm}.nix"
    "/style"
    "/app/fido2"
  ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.name;
    extraGroups = [ "networkmanager" "wheel" "adbusers" "dialout" "audio" "camera" ];
  };
  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = pkgs.lib.mkForce false;
    };
    grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  networking = {
    hostName = "uni-vm"; # Define your hostname.
  };

  # Configure keymap in X11
  services = {
    xserver.xkb = {
      layout = "gb";
      variant = "";
    };
    flatpak.enable = true;
  };
  
  virtualisation.virtualbox.guest = {
    enable = true;
    draganddrop = true;
    seamless = true;
    clipboard = true;
  };
  
  system.stateVersion = "24.05"; # Did you read the comment?
}

