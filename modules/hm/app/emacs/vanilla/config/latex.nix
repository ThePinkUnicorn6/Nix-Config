{ config, lib, pkgs, ... }:

{
    programs.emacs = {
      extraPackages = epkgs: with epkgs; [
        auctex
        pdf-tools
      ];
      
      extraConfig = ''
;; Use pdf-tools to open PDF files
(use-package pdf-tools
  :init
  (pdf-tools-install))
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
           #'TeX-revert-document-buffer)

(add-hook 'pdf-view-mode-hook (lambda () (blink-cursor-mode -1)))
'';
    };
}
