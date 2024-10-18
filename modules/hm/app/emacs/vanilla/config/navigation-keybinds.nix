{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    extraConfig = ''
      ;; (require 'bind-key)
      ;; (bind-keys*
      ;;   ("C-c ," . 'switch-to-buffer)

      ;;   ("C-c b k" . 'kill-buffer)
      ;;   ("C-c b i" . 'list-buffers)
        
      ;;   ("C-c w c" . 'delete-window))

(keymap-set global-map "C-c ," #'switch-to-buffer)
(keymap-set global-map "C-c ." #'find-file)
(keymap-set global-map "C-c b k" #'kill-buffer)
(keymap-set global-map "C-c b i" #'list-buffers)
(keymap-set global-map "C-c w c"  #'delete-window)
    '';
  };
}
