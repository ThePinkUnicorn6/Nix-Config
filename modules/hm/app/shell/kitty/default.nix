{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      window_margin_width = 12;
      editor = "emacs -nw";
      cursor_trail = 1;
    };
  };
}
