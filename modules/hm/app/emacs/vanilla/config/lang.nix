{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    pyright
    rust-analyzer
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

      lsp-pyright
      
      rust-mode
      flycheck-rust
      
      
      plantuml-mode
      flycheck-plantuml
    ];

    extraConfig = '' 
    (use-package lsp-mode
      :ensure t)

    (use-package lsp-nix
      :ensure lsp-mode
      :after (lsp-mode)
      :demand t
      :custom
      (lsp-nix-nil-formatter ["nixfmt"]))
      (setq lsp-nix-nil-auto-eval-inputs nil)

    (use-package lsp-pyright
       :ensure t
       :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
       :hook (python-mode . (lambda ()
                              (require 'lsp-pyright)
                              (lsp))))  ; or lsp-deferred
                          
    (use-package nix-mode
      :hook (nix-mode . lsp-deferred)
      :ensure t)

    (use-package rust-mode
      :hook (rust-mode . lsp-deferred)
      :ensure t)

    ;; Plantuml config
    (setq plantuml-executable-path "${pkgs.plantuml}/bin/plantuml")
    (setq plantuml-default-exec-mode 'executable)

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
        '("\\.org\\'" . "Org skeleton")
        '("Template for a default org mode document"
        "#+TITLE: " _
        \n \n
        "* ")))
    '';
  };  
}
