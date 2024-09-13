{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    extraConfig = ''
      (require 'bind-key)
      (bind-keys*
        ("C-c ," . 'switch-to-buffer)

        ("C-c b k" . 'kill-buffer)
        ("C-c b i" . 'list-buffers)
        
        ("C-c w c" . 'delete-window))
    '';
  };
}
