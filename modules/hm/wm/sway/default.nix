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
        "${modifier}+p" = "exec power-menu";
        "${modifier}+r" = "exec fuzzel";
        "${modifier}+y" = "exec freetube $(wl-paste) & notify-send \"Opening $(wl-paste) in freetube.\"";
        "${modifier}+t" = "exec emacsclient -c -a=''";
        "${modifier}+Shift+s" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} copy area";
        "${modifier}+l" = "exec ${lib.getExe pkgs.swaylock}";
        "XF86AudioRaiseVolume" = "exec ${lib.getExe pkgs.pamixer} -i 5";
        "XF86AudioLowerVolume" = "exec ${lib.getExe pkgs.pamixer} -d 5";
        "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} s 10%+";
        "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} s 10%-";
      };
      input = {
        "type:keyboard" = {
          xkb_layout = "gb";
        };
        "type:touchpad" = {
          dwt = "enabled";
          dwtp = "enabled";
          tap = "enabled";
          tap_button_map = "lrm";
          natural_scroll = "enabled";
        };
      };
      gaps = {
        inner = 3;
        outer = 8;
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
      corner_radius 8
    '';
  };
}
