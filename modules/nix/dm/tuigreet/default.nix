{ config, lib, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --command 'dbus-run-session say' --remember --asterisks";
        user = "greeter";
      };
    };
  };
}
