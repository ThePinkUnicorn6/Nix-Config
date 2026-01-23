{ config, lib, pkgs, ... }:

{
  boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="Virtual Webcam"
    '';
  };

  environment.systemPackages = with pkgs; [
    scrcpy
    linuxPackages.v4l2loopback
    v4l-utils
  ];
}
