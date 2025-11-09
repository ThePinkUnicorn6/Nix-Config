{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.mango.hmModules.mango
    ../wayland
    ../../app/desktop/waybar
    ../../app/desktop/wl-kbptr
    ../../app/desktop/power
  ];
  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      bind=SUPER,Return,spawn,kitty
      bind=SUPER,r,spawn,fuzzel
      bind=SUPER,q,killclient,
      bind=SUPER,e,spawn,emacsclient --create-frame --alternate-editor=\"\" -a=\"\""

      gesturebind=none,left,3,focusdir,right
      gesturebind=none,right,3,focusdir,left
      gesturebind=none,up,3,focusdir,up
      gesturebind=none,down,3,focusdir,down
      gesturebind=none,left,4,viewtoleft_have_client
      gesturebind=none,right,4,viewtoright_have_client
      gesturebind=none,up,4,toggleoverview
      gesturebind=none,down,4,toggleoverview

      trackpad_natural_scrolling=1
      blur=1
    '';
    autostart_sh = ''
      waybar >/dev/null 2>&1 &
      swaybg -i ${config.stylix.image} >/dev/null 2>&1 &
      emacs --daemon >/dev/null 2>&1 &

    '';
  };
}
