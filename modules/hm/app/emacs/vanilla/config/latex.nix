{ config, lib, pkgs, ... }:

{
    programs.emacs = {
      extraPackages = epkgs: with epkgs; [
        AUCTeX
      ];
      
      extraConfig = ''
(setq +latex-viewers '(pdf-tools))

'';
    };
}
