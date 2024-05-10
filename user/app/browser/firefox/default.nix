{ config, lib, pkgs, inputs, ... }:
let
  profile = "yo7bc8tq";
  chromeDir = ".mozilla/firefox/${profile}/chrome";
  colours = config.lib.stylix.colors;
in{
  home.file."${chromeDir}/theme".source = ./FF-ULTIMA/theme;
  home.file."${chromeDir}/userChrome.css".source = ./FF-ULTIMA/userChrome.css;
  home.file."${chromeDir}/userContent.css".source = ./FF-ULTIMA/userContent.css;
  programs.firefox = {
    enable = true;
    profiles.${profile} = {
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
  home.file.".mozilla/firefox/${profile}/chrome/colours.css".text = ''
    @define-color base00 #''+colours.base00+'';
    @define-color base01 #''+colours.base01+'';
    @define-color base02 #''+colours.base02+'';
    @define-color base03 #''+colours.base03+'';
    @define-color base04 #''+colours.base04+'';
    @define-color base05 #''+colours.base05+'';
    @define-color base06 #''+colours.base06+'';
    @define-color base07 #''+colours.base07+'';
    @define-color base08 #''+colours.base08+'';
    @define-color base09 #''+colours.base09+'';
    @define-color base0A #''+colours.base0A+'';
    @define-color base0B #''+colours.base0B+'';
    @define-color base0C #''+colours.base0C+'';
    @define-color base0D #''+colours.base0D+'';
    @define-color base0E #''+colours.base0E+'';
    @define-color base0F #''+colours.base0F+'';
  '';
}
