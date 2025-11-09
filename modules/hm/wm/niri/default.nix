{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.niri.homeModules.niri
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
    swaybg
  ];
  programs.swaylock.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      binds = with config.lib.niri.actions; {
        "Mod+Return".action.spawn = ["kitty"];
        "Mod+R".action.spawn = "fuzzel";
        "Mod+Shift+E".action.spawn = "power-menu";
        "Mod+Q".action = close-window;
        
      };
      prefer-no-csd = true;
      window-rules = [
        {
          matches = [{}];
          geometry-corner-radius = {
            top-left = 12.0;
            top-right = 12.0;
            bottom-left = 12.0;
            bottom-right = 12.0;
          };
          clip-to-geometry = true;
          
        }
      ];
      input = {
        focus-follows-mouse = {
          enable = true;
        };
      };
      spawn-at-startup = [
        { argv = ["waybar"]; }
        { argv = ["swaybg" "--image" "${config.stylix.image}" ]; }
      ];
    };
  };
}
