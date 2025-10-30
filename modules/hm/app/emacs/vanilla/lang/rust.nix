{ config, lib, pkgs, ... }:

{
  imports = [ ../../../../lang/rust ];
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      rust-mode
      flycheck-rust
    ];

    extraConfig = '' 
    (use-package rust-mode
      :hook (rust-mode . lsp-deferred)
      :ensure t)
    '';
  };
}
