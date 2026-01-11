{ config, lib, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
       command = "${pkgs.tuigreet}/bin/tuigreet --time --c 'dbus-run-session sway' --remember --asterisks";
        user = "greeter";
      };
    };
  };
}
