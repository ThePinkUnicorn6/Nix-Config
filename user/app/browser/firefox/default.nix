{ config, lib, pkgs, inputs, ... }:

{
  home.file.".mozilla/firefox/yo7bc8tq/chrome".source = ./FF-ULTIMA;
  programs.firefox = {
    enable = true;
    profiles.yo7bc8tq = {
      settings = {
        "ultima.tabs.vertical" = false;
        "ultima.tabs.xs" = false;
        "ultima.tabs.s" = false;
        "ultima.tabs.l" = true;
        "ultima.tabs.autohide" = true;

        "ultima.sidebar.autohide" = true;

        "ultima.xstyle.squared" = false;
        "ultima.xstyle.containertabs.i" = false;
        "ultima.xstyle.containertabs.ii" = false;
        "ultima.xstyle.containertabs.iii" = true;
        "ultima.theme.extensions" = true;

        "ultima.OS.kde" = true;
        "ultima.OS.gnome" = false;
        "ultima.OS.mac" = false;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "toolkit.tabbox.switchByScrolling" = false;
      };
      # extraConfig = (builtins.readFile ./FF-ULTIMA/user.js);
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        ublock-origin
        sidebery
      ];
    };
  };
}
