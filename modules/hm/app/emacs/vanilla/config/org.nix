{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      org-superstar
      writeroom-mode
    ];

    extraConfig = ''
;; Latex export settings
(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
   '("org-article"
     "\\documentclass{article}
      \\usepackage[reset, a4paper, left=1.25in, right=1.25in, top=1in, bottom=1in]{geometry}
      \\usepackage{lmodern}")
))
(setq org-latex-default-class "org-article")

;; Styling
(require 'org-superstar)
    (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-superstar-headline-bullets-list '("•"))
(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (add-hook 'org-mode-hook #'visual-line-mode))

;; Writeroom
(setq writeroom-width 120)
'';
  };
}