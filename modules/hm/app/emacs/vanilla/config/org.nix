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
      \\usepackage[reset, a4paper, height=9in, width=6in, hmarginratio=1:1, vmarginratio=1:1, marginparsep=0pt, marginparwidth=0pt, headheight=15pt]{geometry}
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
