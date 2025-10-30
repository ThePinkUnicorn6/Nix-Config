{ config, lib, pkgs, ... }:

{
  imports = [
    ./rust.nix
    # ./c.nix
    # ./cpp.nix
    ./nix.nix
    ./planuml.nix
    ./python.nix
  ];
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      lsp-mode
      sideline-lsp
      lsp-treemacs
      lsp-ui
      flycheck
      company
      
      tree-sitter
      tree-sitter-langs
      treesit-grammars.with-all-grammars
    ];
    extraConfig = '' 
    (use-package lsp-mode
      :ensure t)
    '';
  };
}

  
