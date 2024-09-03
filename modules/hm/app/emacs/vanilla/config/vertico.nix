{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      vertico
    ];

    extraConfig = ''
(use-package vertico
  :init
  (vertico-mode))
(use-package emacs
  :custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
  ;; mode.  Vertico commands are hidden in normal buffers. This setting is
  ;; useful beyond Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p))
    '';
  };
}
