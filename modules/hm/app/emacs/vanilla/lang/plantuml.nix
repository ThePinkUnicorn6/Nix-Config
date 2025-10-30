{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      plantuml-mode
      flycheck-plantuml
    ];

    extraConfig = '' 
    (setq plantuml-executable-path "${pkgs.plantuml}/bin/plantuml")
    (setq plantuml-default-exec-mode 'executable)
    '';
  };  
}
