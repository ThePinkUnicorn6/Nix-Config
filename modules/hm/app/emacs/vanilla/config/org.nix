{ config, lib, pkgs, ... }:
let
  styles = builtins.fetchGit {
    url = "https://github.com/zotero/bundled-styles";
    rev = "a653811f3eaa0e9d849ab6019493c7b8867fc96f";
  };
in{
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

;; Citing
(setq org-cite-export-processors '((t csl)))
(setq org-cite-csl-styles-dir "${styles}")

(org-cite-export-processors
 '((t . (csl "harvard-cite-them-right.csl"))))


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
