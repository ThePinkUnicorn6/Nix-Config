{ config, lib, pkgs, ... }:

{
  imports = [
    ./theme.nix
  ] ++ (map (m: ./config + m) [
    "/meow.nix"
    "/vertico.nix"
    "/roam.nix"
    "/lang.nix"
    "/navigation-keybinds.nix"
  ]);
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      use-package
      treemacs
      bind-key
      org-superstar
    ];

    extraConfig = /*lisp*/ ''
      ;; Turn off some unneeded UI elements
      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      
      ;; Display line numbers in every buffer
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)
      (setq standard-indent 2)

      ;; Org
      (require 'org-superstar)
          (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
      (setq
          org-superstar-headline-bullets-list '("•"))
    '';
  };  
}
