{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    pyright
  ];
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      lsp-pyright
    ];

    extraConfig = '' 
    (use-package lsp-pyright
       :ensure t
       :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
       :hook (python-mode . (lambda ()
                              (require 'lsp-pyright)
                              (lsp))))  ; or lsp-deferred
    '';
  };
}
