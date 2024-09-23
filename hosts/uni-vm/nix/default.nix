{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../desktop-base/nix
  ]++
  (map (m: ../../../modules/nix + m) [
    "/wm/${settings.wm}.nix"
#    "/wm/plasma.nix"
    "/style"
    "/app/fido2"
  ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.name;
    extraGroups = [ "networkmanager" "wheel" "adbusers" "dialout" "audio" "camera" ];
  };

  networking = {
    hostName = "nixos-vm"; # Define your hostname.
  };

  # Configure keymap in X11
  services = {
    xserver.xkb = {
      layout = "gb";
      variant = "";
    };
    flatpak.enable = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}

