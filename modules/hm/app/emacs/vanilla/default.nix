{ config, lib, pkgs, ... }:

{
  imports = [
    ./theme.nix
  ] ++ (map (m: ./config + m) [
    "/meow.nix"
    "/vertico.nix"
    "/roam.nix"
    "/lang.nix"
    "/org.nix"
    "/navigation-keybinds.nix"
  ]);
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      use-package
      treemacs
      bind-key
      pdf-tools

      (epkgs.callPackage ./packages/ultra-scroll.nix {})
    ];

    extraConfig = /*lisp*/ ''
      ;; Turn off some unneeded UI elements
      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)

      (electric-pair-mode 1) ;; Enable bracket pairing
      
      ;; Display line numbers in every buffer
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)
      (setq standard-indent 2)

      (setq inhibit-startup-screen t)

      ;; Enable smooth scrolling
      (use-package ultra-scroll
        :init
        (setq scroll-conservatively 101 ; important!
          scroll-margin 0) 
        :config
        (ultra-scroll-mode 1))
    '';
  };  
}
