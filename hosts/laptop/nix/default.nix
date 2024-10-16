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
  boot.blacklistedKernelModules = [ 
    "ipu3_imgu"
  ]; 

  networking = {
    hostName = "laptop"; # Define your hostname.
  };
  nix.settings.trusted-users = [ "root" settings.username ];

  fileSystems."/home/${settings.username}/shared-files" = {
    device = "/dev/nvme0n1p4";
    fsType = "ntfs";
  };
  
  # Configure keymap in X11
  services = {
    xserver.xkb = {
      layout = "gb";
      variant = "";
    };
    iptsd.config.Touchscreen.DisableOnPalm = true;
    
    flatpak.enable = true;
    openssh.enable = true;
  };
  programs = {
    steam.enable = true;
  };

  system.stateVersion = "24.05"; 
}

