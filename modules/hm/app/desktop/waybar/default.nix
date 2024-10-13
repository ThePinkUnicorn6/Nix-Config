{ config, pkgs, settings, lib, ... }:
let
  colours = config.lib.stylix.colors;
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
      format = "{:%I:%M}";
      max-length = 25;
    };
    wireplumber = {
      format = "{icon}  {volume}%";
      format-icons = ["󰕿" "󰖀" "󰕾"];
      format-muted = "󰖁 ";
      scroll-step = 5;
      on-click = "pavucontrol";
      on-click-right = "amixer set Master toggle";
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
    "hyprland/workspaces" = {
      format = "{icon}";
      on-click = "activate";
      persistent-workspaces = {
        HDMI-A-1 = [ 1 2 3 4 5 ];
        DP-2 = [ 6 7 8 9 10 ];
      };
      format-icons = {
        active = "";
        default = "";
        empty = "";
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
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "wireplumber" "network" "disk" "cpu" "memory" "tray"];
        inherit (moduleConfig) cpu clock wireplumber network disk memory "hyprland/workspaces";
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
  home.file.".config/waybar/colours.css".text = ''
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
