{ config, lib, pkgs, settings, ... }:

{
  hardware.rtl-sdr.enable = true;
  environment.systemPackages = with pkgs; [
    rtl-sdr
  ];
  users.users.${settings.username}.extraGroups = [ "plugdev" ];
}
