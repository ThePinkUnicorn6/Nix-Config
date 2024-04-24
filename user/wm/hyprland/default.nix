{ pkgs, lib, settings, ... }:
{
  imports = [ 
    ../wayland
    ../../app/desktop/waybar
  ];

  home.packages = with pkgs; [
    wl-clipboard
    hyprland-protocols
    wl-clipboard
    grim
    grimblast
    slurp
    (pkgs.writeScriptBin "power-menu" ''
        #!/usr/bin/env bash

        option0="󰏥 Suspend"
        option1="󰐥 Shutdown"
        option2="󰜉 Reboot"
        option3=" Windows"

        options="$option0\n$option1\n$option2\n$option3"

        chosen="$(echo -e "$options" | fuzzel --lines 4 --dmenu)"
        case $chosen in
            $option0)
                systemctl suspend;;
            $option1)
                systemctl poweroff;;
            $option2)
                systemctl reboot;;
            $option3)
                systemctl reboot --boot-loader-entry=auto-windows;;
        esac
    '')
  ];
  services.copyq.enable = true;

  # Hyprland Config
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = { enable = true; };
    systemd.enable = true;
    settings = {
        monitor = if (settings.system.profile == "desktop") then [
            "HDMI-A-1,1920x1080@60,0x550,1"
            "DP-2,1920x1080@60,1920x0,1"
            "DP-2,transform,3"
        ] else [];

        # Workspace monitor binding
        workspace =  if (settings.system.profile == "desktop") then [
            "1,monitor:HDMI-A-1"
            "2,monitor:HDMI-A-1"
            "3,monitor:HDMI-A-1"
            "4,monitor:HDMI-A-1"
            "5,monitor:HDMI-A-1"
            "6,monitor:DP-2"
            "7,monitor:DP-2"
            "8,monitor:DP-2"
            "9,monitor:DP-2"
            "10,monitor:DP-2"
        ] else [];

        input = {
            kb_layout = "gb";
            follow_mouse = 1;
            touchpad = {
                natural_scroll = "no";
            };
        };
        #force_default_wallpaper = 0;

        general = {
            sensitivity = 1.0; # for mouse cursor
            gaps_in = 3;
            gaps_out = 8;
            border_size = 2;
            apply_sens_to_raw = 0; # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
        };
        decoration = {
            rounding = 8;
            blur = {
                enabled = true;
                size = 12;
                passes = 4;
                new_optimizations = true;
                ignore_opacity = true;
                xray = true;
                popups = true;
            };
            active_opacity = 0.95;
            inactive_opacity = 0.9;
            fullscreen_opacity = 1;
            drop_shadow = true;
            shadow_range = 30;
            shadow_render_power = 3;
        };

        animations = {
            enabled = 1;
            animation = [
                "windows,1,7,default"
                "border,1,10,default"
                "fade,1,10,default"
                "workspaces,1,6,default"
            ];
        };

        dwindle = {
            pseudotile = 0; # enable pseudotiling on dwindle
            preserve_split = true;
        };

        gestures = {
            workspace_swipe = true;
            #workspace_swipe_touch = true;
        };

        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
          enable_swallow = true;
          swallow_regex = "^(alacritty)$";
        };

        # Autostart
        exec-once = [
            "waybar"
            "mako"
            "hyprpaper"
            "emacs --daemon"
            "ollama serve"
            "sleep 10 && aw-qt"

            "[workspace 1 silent] firefox"
            "[workspace 2 silent] sleep 5 && emacsclient --create-frame --alternate-editor=\"\" -a=\"\""
        ];
        # Window rules
        windowrule = [
            "monitor 0,discord"
            "workspace 6,discord"
            "monitor 0,WebCord"
            "workspace 6,WebCord"
            "monitor 0,whatsapp"
            "workspace 6,whatsapp"
            "monitor 1,waterfox"
            "workspace 1,waterfox"

            "float,com.usebottles.bottles"
        ];
        # Binds
        bindm = [
            "SUPER,mouse:272,movewindow"
            "SUPER,mouse:273,resizewindow"
        ];
        bind = [
            "SUPER,RETURN,exec,alacritty"
            "SUPER,Q,killactive"
            "SUPER,L,exit"
            "SUPER,space,togglefloating"
            "SUPER,R,exec,fuzzel"
            "SUPERSHIFT,space,pseudo"
            "SUPER,F,fullscreen"
            "SUPER,N,exec,dolphin"
            "SUPER,M,exec,firefox"
            "SUPER,E,exec,emacsclient --create-frame --alternate-editor=\"\" -a=\"\""
            "SUPERSHIFT,E,exec,power-menu"
            "SUPER,V,exec,mpv $(wl-paste) & notify-send \"Opening $(wl-paste) in mpv.\""
            "SUPER,Y,exec,freetube $(wl-paste) & notify-send \"Opening $(wl-paste) in freetube.\""

            # Screenshots
            ",Print,exec,grimblast --notify --cursor copy active"
            "SHIFT,Print,exec,grimblast --notify --cursor copysave active"
            "SUPER,S,exec,grimblast --notify --cursor copy area"
            "SUPERSHIFT,S,exec,grimblast --notify --cursor copysave area"

            "SUPER,left,movefocus,l"
            "SUPER,right,movefocus,r"
            "SUPER,up,movefocus,u"
            "SUPER,down,movefocus,d"

            "SUPERSHIFT,left,swapwindow,l"
            "SUPERSHIFT,right,swapwindow,r"
            "SUPERSHIFT,up,swapwindow,u"
            "SUPERSHIFT,down,swapwindow,d"

            "SUPER,1,workspace,1"
            "SUPER,2,workspace,2"
            "SUPER,3,workspace,3"
            "SUPER,4,workspace,4"
            "SUPER,5,workspace,5"
            "SUPER,6,workspace,6"
            "SUPER,7,workspace,7"
            "SUPER,8,workspace,8"
            "SUPER,9,workspace,9"
            "SUPER,0,workspace,10"

            "SUPERSHIFT,1,movetoworkspacesilent,1"
            "SUPERSHIFT,2,movetoworkspacesilent,2"
            "SUPERSHIFT,3,movetoworkspacesilent,3"
            "SUPERSHIFT,4,movetoworkspacesilent,4"
            "SUPERSHIFT,5,movetoworkspacesilent,5"
            "SUPERSHIFT,6,movetoworkspacesilent,6"
            "SUPERSHIFT,7,movetoworkspacesilent,7"
            "SUPERSHIFT,8,movetoworkspacesilent,8"
            "SUPERSHIFT,9,movetoworkspacesilent,9"
            "SUPERSHIFT,0,movetoworkspacesilent,10"

            "SUPER,mouse_down,workspace,e+1"
            "SUPER,mouse_up,workspace,e-1"
            "SUPER,f4,exec,hyprctl kill"
        ];
    };
    extraConfig = ''
        # Fix Steam
        windowrulev2 = stayfocused, title:^()$,class:^(steam)$
        windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$

        # Fix Reaper
        windowrule=noanim,^(REAPER)$
        windowrulev2 = nofocus,class:REAPER,title:^$
    '';
  };
}
