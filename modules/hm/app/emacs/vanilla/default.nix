{ config, lib, pkgs, ... }:

{
  imports = [
    ./theme.nix
  ];
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      meow
      org-roam
      org-roam-ui
    ];

    extraConfig = ''

    '' +
    (builtins.readFile ./config/meow.el) ;
#    (builtins.readFile ./config/roam.el;
  };  
}
