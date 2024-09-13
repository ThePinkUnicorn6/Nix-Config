{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
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
      
      # Languages
      nix-mode
      nix-ts-mode
#      lsp-nix # Sort out nix lsp later
      
      rust-mode
      flycheck-rust
      
      plantuml-mode
      flycheck-plantuml
    ];

    extraConfig = ''
    (require 'lsp-mode)
    (add-hook 'prog-mode-hook #'lsp)

    ;; File templates
    (auto-insert-mode t)

    (eval-after-load 'autoinsert
      '(define-auto-insert
        '(nix-mode . "Nix skeleton")
          '("Template to insert bolerplate nix code"
          "{ config, lib, pkgs, ... }:" \n \n
          "{" \n
          > _ \n
          "}" > \n)))
    (eval-after-load 'autoinsert
      '(define-auto-insert
        '("\\.txt\\'" . "Test on")
        '("Decription"
        "Hello World")))    
    '';
  };  
}
