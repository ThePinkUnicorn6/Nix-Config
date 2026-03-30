{ config, pkgs, inputs, lib, settings, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../desktop-base/nix
  ]++
  (map (m: ../../../modules/nix + m) [
    /gpu/intel-igpu
    "/style"
    "/app/fido2"
    "/services/kanata"
    /services/tlp
    
  ])++(map (wm: ../../../modules/nix/wm/${wm}.nix) settings.wm);

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
    logind.settings.Login = {
      HandlePowerKey = "suspend-then-hibernate";
      HandleLidSwitch = "suspend-then-hibernate";
    };
    
    flatpak.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
  };
  programs = {
    steam.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
 # services.udev.extraRules = "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"05c6\", ATTR{idProduct}==\"9008\", MODE=\"0666\", GROUP=\"plugdev\"";

  services.udev.packages = lib.singleton (pkgs.writeTextFile
      { name = "qdl-rules";
        text = ''
         SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", ATTR{idProduct}=="9008", MODE="0666", GROUP="plugdev"
        '';
        destination = "/etc/udev/rules.d/60-qdl.rules";
      });
#  services.blueman.enable = true;
  system.stateVersion = "25.05"; 
}

