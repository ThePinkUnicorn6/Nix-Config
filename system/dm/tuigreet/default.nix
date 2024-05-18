{ config, lib, pkgs, settings, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland -r";
        user = settings.user.username;
      };
    };
  };
}
