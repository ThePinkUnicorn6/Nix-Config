{ config, lib, pkgs, inputs, ... }:

{
  home.file.".mozilla/firefox/yo7bc8tq/chrome".source = ./FF-ULTIMA;
  programs.firefox = {
    enable = true;
    profiles.yo7bc8tq = {
      extraConfig = (builtins.readFile ./FF-ULTIMA/user.js);
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        sidebery
      ];
    };
  };
}
