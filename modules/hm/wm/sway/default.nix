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
    sway-contrib.grimshot
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
      terminal = "${lib.getExe pkgs.kitty}";
      menu = "${lib.getExe pkgs.fuzzel}";
      startup = [
        {command = "waybar";}
      ];
      defaultWorkspace = "workspace number 1";
      output = {
        "HDMI-A-1" = {
          position = "0 550";
        };
        "DP-2" = {
          position = "1920 0";
          transform = "90";
        };
      };
      workspaceOutputAssign = [
        {
          output = "HDMI-A-1 *";
          workspace = "1";
        }
        {
          output = "HDMI-A-1 *";
          workspace = "2";
        }
        {
          output = "HDMI-A-1 *";
          workspace = "3";
        }
        {
          output = "HDMI-A-1 *";
          workspace = "4";
        }
        {
          output = "HDMI-A-1 *";
          workspace = "5";
        }
        {
          output = "DP-2 *";
          workspace = "6";
        }
        {
          output = "DP-2 *";
          workspace = "7";
        }
        {
          output = "DP-2 *";
          workspace = "8";
        }
        {
          output = "DP-2 *";
          workspace = "9";
        }
        {
          output = "DP-2 *";
          workspace = "10";
        }
      ];
      keybindings ={
        "${modifier}+Return" = "exec kitty";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+q" = "kill";
        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";

        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";

        "${modifier}+a" = "layout toggle split";

        "${modifier}+space" = "floating toggle";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        
        "${modifier}+p" = "exec power-menu";
        "${modifier}+r" = "exec ${menu}";
        "${modifier}+y" = "exec freetube $(wl-paste) & notify-send \"Opening $(wl-paste) in freetube.\"";
        "${modifier}+t" = "exec emacsclient -c -a=''";
        "${modifier}+l" = "exec ${lib.getExe pkgs.swaylock}";
        "${modifier}+h" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+Shift+l" =
          "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
        
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";
        "${modifier}+period" = "mode resize";
        
        "XF86AudioRaiseVolume" = "exec ${lib.getExe pkgs.pamixer} -i 5";
        "XF86AudioLowerVolume" = "exec ${lib.getExe pkgs.pamixer} -d 5";
        "XF86AudioMute" = "exec ${lib.getExe pkgs.pamixer} --toggle-mute";

        "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} s 10%+";
        "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} s 10%-";
        "XF86LaunchA" = "exec emacsclient -c ~/nix";
        
        "${modifier}+Shift+s" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} savecopy area --notify";
        "${modifier}+s" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} copy area --notify";
        "${modifier}+Control+s" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} copy active --notify";
        "${modifier}+Control+Shift+s" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} savecopy active --notify";
        "${modifier}+Alt+s" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} copy screen --notify";
        "${modifier}+Alt+Shift+s" = "exec ${lib.getExe pkgs.sway-contrib.grimshot} savecopy screen --notify";
        
        "XF86Search" = "exec ${menu}";
      };
      left = "n";
      right = "o";
      down = "e";
      up = "i";
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
        hideEdgeBorders = "smart";
      };
      bars = [];
    };
    extraConfig = ''
      blur enable
      shadows enable

      smart_gaps on
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
      corner_radius 8

      workspace 1
      exec firefox
    '';
  };
}
