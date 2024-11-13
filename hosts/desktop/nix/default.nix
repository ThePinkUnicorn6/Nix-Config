{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../desktop-base/nix
  ]++
  (map (m: ../../../modules/nix + m) [
    "/gpu/amd-rx570"
    "/app/production"
    "/wm/${settings.wm}.nix"
#    "/wm/plasma.nix"
    "/wm/xfce.nix"
    "/style"
    "/app/fido2"
    /services/vr/alvr
  ]);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${settings.username} = {
    isNormalUser = true;
    description = settings.name;
    extraGroups = [ "networkmanager" "wheel" "adbusers" "dialout" "audio" "camera" ];
  };

  networking = {
    hostName = "desktop"; # Define your hostname.
  };

  # Configure keymap in X11
  services = {
    xserver.xkb = {
      layout = "gb";
      variant = "";
    };
    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };

    flatpak.enable = true;
    openssh.enable = true;
  };
  programs = {
    steam.enable = true;
  };
  fileSystems."/home/${settings.username}/shared-files" = {
    device = "/dev/nvme0n1p4";
    fsType = "ntfs";
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}

