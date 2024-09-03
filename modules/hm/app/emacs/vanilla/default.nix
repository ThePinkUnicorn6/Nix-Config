{ config, lib, pkgs, ... }:

{
  imports = [
    ./theme.nix
  ] ++ (map (m: ./config + m) [
    "/meow.nix"
    "/vertico.nix"
    #"/roam.nix"
  ]);
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      use-package
      nix-mode
      org-roam
      org-roam-ui
      vertico
    ];

    extraConfig = ''
      ;; Turn off some unneeded UI elements
      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      
      ;; Display line numbers in every buffer
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers-type 'relative)
      (setq standard-indent 2)

    '';
  };  
}
