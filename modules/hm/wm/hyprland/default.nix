{ pkgs, lib, settings, osConfig, inputs, ... }:
let
  isLaptop = (osConfig.networking.hostName == "laptop");
  isDesktop = (osConfig.networking.hostName == "desktop");
  run-package = (pkgs.writeScriptBin "run-package" "PKG=$(fuzzel -d -l 0) && nix run nixpkgs#$PKG || notify-send \"Failed to run package: $PKG\"");
in{
  imports = [ 
    ../wayland
    ../../app/desktop/waybar
    ../../app/desktop/power
    ../../app/desktop/wl-kbptr
  ];

  home.packages = with pkgs; [
    wl-clipboard
#    hyprland-protocols
    wl-clipboard
    grim
    grimblast
    slurp
  ];
  programs.swaylock.enable = true;

  # Hyprland Config
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = { enable = true; };
    systemd.enable = true;
    settings = {
      monitor = if isDesktop then [
            "HDMI-A-1,1920x1080@60,0x550,1"
            "DP-2,1920x1080@60,1920x0,1"
            "DP-2,transform,3"
      ] else [
            "eDP-1, 1920x1080@60, 0x0, 1"
      ];

      # Workspace monitor binding
      workspace =  if isDesktop then [
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
          natural_scroll = "yes";
        };
      };
      #force_default_wallpaper = 0;

      general = {
        gaps_in = 3;
        gaps_out = 8;
        border_size = 2;
      };
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 12;
          passes = 4;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
          popups = true;
        };
        active_opacity = 1;
        inactive_opacity = 0.9;
        fullscreen_opacity = 1;
        shadow = {
          enabled = true;
          range = 30;
          render_power = 3;
        };
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

      # gestures = {
      #   workspace_swipe = true;
      #   workspace_swipe_touch = true;
      # };

      gesture = [
        "3, horizontal, workspace"
      ];
      
      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        enable_swallow = true;
        vfr = true;
        #swallow_regex = "^(kitty|alacritty)$";
      };

      # Autostart
      exec-once = [
        "waybar"
        "mako"
        #"hyprpaper"
        "sleep 5 && emacs --daemon"
        "sleep 3 && openrgb --startminimized"
        "[workspace 1 silent] sleep 3 && firefox"
        "nm-applet"
      ];
      # Window rules
      windowrule = [
        # "monitor:0, class:wasistlos, title:WasIstLos"
        # "workspace:6, class:wasistlos, title:WasIstLos"

        "float,class:com.usebottles.bottles"
      ];
      # Binds
      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];
      bind = [
        "SUPER,RETURN,exec,${pkgs.kitty}/bin/kitty"
        "SUPER,Q,killactive"
        "SUPER,L,exec,swaylock"
        "SUPERSHIFT,L,exit"
        "SUPER,space,togglefloating"
        "SUPER,R,exec,fuzzel"
        # Runs any package from the nix repository without installing.
        "SUPERSHIFT,R,exec,${run-package}/bin/run-package"
        "SUPERSHIFT,space,pseudo"
        "SUPER,F,fullscreen"
        "SUPER,N,exec,nautilus -w"
        "SUPER,M,exec,firefox"
        "SUPER,E,exec,emacsclient --create-frame --alternate-editor=\"\" -a=\"\""
        "SUPERSHIFT,E,exec,power-menu"
        "SUPER,V,exec,mpv $(wl-paste) & notify-send \"Opening $(wl-paste) in mpv.\""
        "SUPER,Y,exec,freetube $(wl-paste) & notify-send \"Opening $(wl-paste) in freetube.\""
        "CTRL_SHIFT,escape,exec,${pkgs.resources}/bin/resources"
        "SUPER,X,exec,${pkgs.wl-kbptr}/bin/wl-kbptr -c .config/wl-kbptr/config"
        
        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"
        "SUPERALT,n,movefocus,l"
        "SUPERALT,i,movefocus,r"
        "SUPERALT,u,movefocus,u"
        "SUPERALT,e,movefocus,d"

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

        # Screenshots
        ",Print,exec,grimblast --notify --cursor copy active"
        "SHIFT,Print,exec,grimblast --notify --cursor copysave active"
        ",XF86Explorer,exec,grimblast --notify --cursor copy active"
        "SHIFT,XF86Explorer,exec,grimblast --notify --cursor copysave active"
        
        "SUPER,S,exec,grimblast --notify copy area"
        "SUPERSHIFT,S,exec,grimblast --notify copysave area"
        
      ];
      bindl = [
        ",switch:Lid Switch,exec,swaylock"
        
        ",XF86AudioMute, exec, ${lib.getExe pkgs.pamixer} --toggle-mute"
        ",XF86AudioRaiseVolume, exec, ${lib.getExe pkgs.pamixer} -i 5"  
        ",XF86AudioLowerVolume, exec, ${lib.getExe pkgs.pamixer} -d 5"
        ",XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} s 10%+"
        ",XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} s 10%-"
        ",XF86Tools, exec, emacsclient -c ~/nix"
        ",XF86Search, exec, fuzzel"
      ];
      "plugin:touch" = {
        sensitivity = "4.0";
      };
      "plugin:touch_gestures" = {
        hyprgrass-bind = [
          ", swipe:3:u, exec, fuzzel"
          ", edge:r:l, workspace, +1"
          ", longpress:3, resizewindow"
        ];
      };
    };
  };
}
