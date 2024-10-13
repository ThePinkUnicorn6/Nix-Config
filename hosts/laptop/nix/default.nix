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

  networking = {
    hostName = "laptop"; # Define your hostname.
  };
<<<<<<< HEAD
  
=======
  nix.settings.trusted-users = [ "root" settings.username ];

>>>>>>> ab2f56e (laptop changes)
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

  system.stateVersion = "24.05"; 
}

