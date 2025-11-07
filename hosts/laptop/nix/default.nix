{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../desktop-base/nix
  ]++
  (map (m: ../../../modules/nix + m) [
    "/wm/${settings.wm}.nix"
    #"/wm/xfce.nix"
    "/style"
    "/app/fido2"
    "/services/kanata"
    /services/tlp
  ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.name;
    extraGroups = [ "networkmanager" "wheel" "adbusers" "dialout" "audio" "camera" "uinput" ];
  };

  networking = {
    hostName = "laptop"; # Define your hostname.
  };
  nix.settings.trusted-users = [ "root" settings.username ];

  # Configure keymap in X11
  services = {
    xserver.xkb = {
      layout = "gb";
      variant = "";
    };
    
    flatpak.enable = true;
    openssh.enable = true;
  };
  programs = {
    steam.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
#  services.blueman.enable = true;
  system.stateVersion = "24.11"; 
}

