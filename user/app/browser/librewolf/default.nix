{ config, lib, pkgs, inputs, ... }:
let
  profile = "cg4k8m1m.default";
  chromeDir = ".librewolf/${profile}/chrome";
  colours = config.lib.stylix.colors;
in{
  # Move chrome directory down a subdirectory to avoid files coliding.
  home.file."${chromeDir}/userChrome.css".source = ./FF-ULTIMA/userChrome.css;

  home.file."${chromeDir}/stylix.css".source = config.lib.stylix.colors {
      template = builtins.readFile ./stylix.css.mustache;
      extension = ".css";
  };
  home.file."${chromeDir}/userContent.css".source = ./FF-ULTIMA/userContent.css;
  home.file."${chromeDir}/theme".source = ./FF-ULTIMA/theme;
  programs.librewolf = {
    enable = true;
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
      "ultima.OS.linux" = false;

      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "svg.context-properties.content.enabled" = true;
      "toolkit.tabbox.switchByScrolling" = false;

      # Librefox
      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "general.autoScroll" = true;
    };
  };
}
