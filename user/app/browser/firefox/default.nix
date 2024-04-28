{ config, lib, pkgs, ... }:

{
  home.file.".mozilla/firefox/yo7bc8tq/chrome".source = ./FF-ULTIMA;
  programs.firefox = {
    enable = true;
    profiles.yo7bc8tq = {
      extraConfig = (builtins.readFile ./FF-ULTIMA/user.js);
    };
  };
}
