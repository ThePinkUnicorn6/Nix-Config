{ config, lib, pkgs, ... }:

{
  imports = [ 
    ../wayland
    ../../app/desktop/waybar
    ../../app/desktop/power
    ../../app/desktop/wl-kbptr
  ];

  home.packages = with pkgs; [
    wl-clipboard
    wl-clipboard
    grim
    grimblast
    slurp
  ];
  programs.swaylock.enable = true;
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    swaynag.enable = true;
    systemd.enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
        {command = "waybar";}
      ];
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec kitty";
        "${modifier}+q" = "kill";
        "${modifier}+r" = "exec fuzzel";
      };
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          dwtp = "enabled";
          tap = "enabled";
          tap_button_map = "lrm";
          natural_scroll = "enabled";
        };
      };
      window = {
        titlebar = false;
      };
      bars = [];
    };
    extraConfig = ''
      blur enable
      shadows enable

      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
    '';
  };
}
