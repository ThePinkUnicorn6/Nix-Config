{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      vertico
    ];

    extraConfig = ''
(vertico-mode)
  (use-package vertico-directory
   :after vertico
   :ensure nil
   :init
   (require 'bind-key)
   ;; More convenient directory navigation commands
   :bind (:map vertico-map
               ("RET" . vertico-directory-enter)
               ("M-DEL" . vertico-directory-delete-char)
               ("DEL" . vertico-directory-delete-word))
   ;; Tidy shadowed file names
   :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

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
