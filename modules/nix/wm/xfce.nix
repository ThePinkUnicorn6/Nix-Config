{ config, pkgs, callPackage, ... }: {
  nixpkgs.config.pulseaudio = true;
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
      displayManager.startx.enable = true;
    };
  };
}
