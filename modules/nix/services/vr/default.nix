{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    opencomposite
  ];
  services = {
    wivrn = {
      enable = true;
      openFirewall = true;
      autoStart = true;
      defaultRuntime = false;
      config = {
        enable = true;
        json = {
          application = [ pkgs.wlx-overlay-s ];
        };
      };
    };
  };
}
