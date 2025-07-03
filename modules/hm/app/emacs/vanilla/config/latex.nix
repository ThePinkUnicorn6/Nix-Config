{ config, lib, pkgs, ... }:

{
    programs.emacs = {
      extraPackages = epkgs: with epkgs; [
        auctex
        pdf-tools
      ];
      
      extraConfig = ''
(setq +latex-viewers '(pdf-tools))

'';
    };
}
