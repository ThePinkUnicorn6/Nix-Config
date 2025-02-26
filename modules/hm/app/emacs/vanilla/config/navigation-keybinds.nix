{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    extraConfig = ''
(keymap-set global-map "C-c ." #'find-file)

;; Buffer 
(keymap-set global-map "C-c ," #'switch-to-buffer)
(keymap-set global-map "C-c b k" #'kill-this-buffer)
(keymap-set global-map "C-c b i" #'list-buffers)

;; Window
(keymap-set global-map "C-c w c"  #'delete-window)
(keymap-set global-map "C-c w v"  #'split-window-right)
(keymap-set global-map "C-c w h"  #'split-window-below)
    '';
  };
}
