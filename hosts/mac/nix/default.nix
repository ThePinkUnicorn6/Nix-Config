{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../desktop-base/nix
  ]++
  (map (m: ../../../modules/nix + m) [
    "/wm/${settings.wm}.nix"
#    "/wm/plasma.nix"
    /services/kanata
    "/wm/xfce.nix"
    /wm/i3.nix
    "/style"
  ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.name;
    extraGroups = [ "networkmanager" "wheel" "adbusers" "dialout" "audio" "camera" "uinput" ];
  };

  networking = {
    hostName = "mac"; # Define your hostname.
  };

  # Configure keymap in X11
  services = {
    xserver.xkb = {
      layout = "gb";
      variant = "";
    };
    flatpak.enable = true;
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
  };
  
  system.stateVersion = "23.05"; # Did you read the comment?
}

