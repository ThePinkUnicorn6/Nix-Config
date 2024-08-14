{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../desktop-base/nix
  ]++
  (map (m: ../../../modules/nix + m) [
    "/gpu/amd-rx570"
    "/app/production"
#    "/wm/${settings.wm}.nix"
    "/wm/xfce-i3.nix"
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
    hostName = "nixos-desktop"; # Define your hostname.
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };
  services.flatpak.enable = true;
  programs.steam.enable = true;

  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}

