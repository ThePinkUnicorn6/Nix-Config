{ config, pkgs, lib, osConfig, ... }:
let
  moduleConfig = {
    cpu = {
      interval = 3;
      format= "  {usage}%";
    };
    memory = {
      format = "  {percentage}%";
    };
    clock = {
      interval = 60;
      format = "{:%I:%M%p}";
      max-length = 25;
    };
    wireplumber = {
      format = "{icon}  {volume}%";
      format-icons = ["󰕿" "󰖀" "󰕾"];
      format-muted = "󰖁";
      scroll-step = 2;
      reverse-scrolling = true;
      on-click = "pavucontrol";
      on-click-right = "${lib.getExe pkgs.pamixer} --toggle-mute";

    };
    network = {
      interval = 1;
      format-wifi = "{icon}  {bandwidthTotalBits}";
      format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
      format-ethernet = "󰈀  {bandwidthTotalBits}";
      format-disconnected = "󰤭";
      tooltip-format = "{ifname} via {gwaddr}";
      tooltip-format-wifi = "{essid} ({signalStrength}%) on {ifname}";
      tooltip-format-disconnected = "Disconnected";
    };
    disk = {
      format = "󰋊  {percentage_free}%";
      tooltip-format = "Used {used}/{total}";
      path = "/";
      on-click = "baobab";
      on-click-right = "gnome-disks";
    };
    battery = {
      format = "{capacity}% {icon}";
      format-charging = "{capacity}% 󱐋{icon}";
      format-plugged = "{capacity}% ";
      states = {
        "warning" = 30;
        "critical" = 15;
      };
      interval = 5;
      format-icons = [ "" "" "" "" "" ];
    };
    backlight = {
      device = "intel_backlight";
      format = "{icon}  {percent}%";
      reverse-scrolling = true;
      format-icons = [ "󰃞" "󰃟" "󰃠" ];
    };
    temperature = {
      format = " {temperatureC}°C";
    };
    "hyprland/workspaces" = {
      format = "{icon}";
      on-click = "activate";
      persistent-workspaces = {
        "*" = [ 1 2 3 4 5 ];
        DP-2 = [ 6 7 8 9 10 ];
      };
      format-icons = {
        active = "";
        default = "";
        empty = "";
      };
    };
    "sway/workspaces" = {
      format = "{icon}";
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
      format-icons = {
        focused = "";
        default = "";
        persistent = "";
      };
    };
  };

in{
  programs.waybar = {
    enable = true;
    settings = {
      leftBar = {
        height = 15;
        layer = "top";
        position = "top";
        output = "!DP-2";
        
        modules-left = let
          extraModules = if osConfig.networking.hostName == "laptop" then [ "battery" "backlight"] else [];
        in [ "hyprland/workspaces" "sway/workspaces" ] ++ extraModules;
        modules-center = [ "clock" ];
        modules-right = [ "wireplumber" "network" "temperature" "disk" "cpu" "memory" "tray"];
        inherit (moduleConfig) cpu clock wireplumber network disk memory "hyprland/workspaces" "sway/workspaces" battery temperature backlight;
      };

      rightBar = {
        layer = "top";
        position = "top";
        output = "DP-2";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ ];
        inherit (moduleConfig) clock "hyprland/workspaces";
      };
    };
    style = ''
      * {
        border: none;
        font-family: ${config.stylix.fonts.monospace.name};
        font-size: 15px;
        min-height: 10px;
      }
''+(builtins.readFile ./style.css);
  };
  home.file.".config/waybar/colours.css".text = with config.lib.stylix.colors.withHashtag; ''
    @define-color base00 ${base00};
    @define-color base01 ${base01};
    @define-color base02 ${base02};
    @define-color base03 ${base03};
    @define-color base04 ${base04};
    @define-color base05 ${base05};
    @define-color base06 ${base06};
    @define-color base07 ${base07};
    @define-color base08 ${base08};
    @define-color base09 ${base09};
    @define-color base0A ${base0A};
    @define-color base0B ${base0B};
    @define-color base0C ${base0C};
    @define-color base0D ${base0D};
    @define-color base0E ${base0E};
    @define-color base0F ${base0F};
  '';
}
