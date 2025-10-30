{ config, lib, pkgs, ... }:

{  
  home.packages = with pkgs; [
    nil
  ];
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      # Languages
      nix-mode
      nix-ts-mode
    ];

    extraConfig = '' 
    (use-package lsp-nix
      :ensure lsp-mode
      :after (lsp-mode)
      :demand t
      :custom
      (lsp-nix-nil-formatter ["nixfmt"]))
      (setq lsp-nix-nil-auto-eval-inputs nil)
                          
    (use-package nix-mode
      :hook (nix-mode . lsp-deferred)
      :ensure t)

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
    '';
  };  
}

