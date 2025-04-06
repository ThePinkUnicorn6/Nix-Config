{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.wl-kbptr ];
  home.file.".config/wl-kbptr/config".text = ''
[general]
home_row_keys=arstneiogmk

[mode_tile]
label_color=#fffd
label_select_color=#fd0d
unselectable_bg_color=#2226
selectable_bg_color=#0304
selectable_border_color=#040c
label_font_family=sans-serif

[mode_bisect]
label_color=#fffd
label_font_size=20
label_font_family=sans-serif
label_padding=12
pointer_size=20
pointer_color=#e22d
unselectable_bg_color=#2226
even_area_bg_color=#0304
even_area_border_color=#0408
odd_area_bg_color=#0034
odd_area_border_color=#0048
history_border_color=#3339
'';

}
