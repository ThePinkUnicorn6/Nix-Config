{ config, pkgs, inputs, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../desktop-base/nix
  ]++
  (map (m: ../../../modules/nix + m) [
    "/gpu/amd-rx5700xt"
    "/app/production"
    "/wm/${settings.wm}.nix"
#    "/wm/plasma.nix"
    "/wm/xfce.nix"
    "/style"
    "/app/fido2"
    /services/podman
    /services/vr/wivrn
    /hardware/openrgb
#    /services/vr/envision
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
    flatpak.enable = true;
    openssh.enable = true;
  };
  hardware.steam-hardware.enable = true;
  programs = {
    steam.enable = true;
  };
  
  fileSystems."/home/${settings.username}/shared-files" = {
    device = "/dev/nvme0n1p4";
    fsType = "ntfs";
  };
  environment.systemPackages = with pkgs; [
    protonup-qt # For cutstom proton versions
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
}

