{ stylix, config, settings, pkgs, ... }:

let
  emacsOpacity = builtins.toString (builtins.ceil (config.stylix.opacity.applications * 100));
in
{
home.file.".config/doom/config.el".text = ''

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq custom-theme-directory "~/.config/emacs/themes")
(setq doom-theme 'doom-stylix)
;; +unicode-init-fonts-h often errors out
(remove-hook 'doom-init-ui-hook '+unicode-init-fonts-h)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Theming
(setq
    org-superstar-headline-bullets-list '("•")
)

(set-frame-parameter nil 'alpha-background ${emacsOpacity})
(add-to-list 'default-frame-alist '(alpha-background . ${emacsOpacity}))

(setq display-line-numbers-type 'relative)

;; Word count in line
(setq doom-modeline-enable-word-count t)

;; Minted code highlighting
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
(setq org-latex-minted-options '(("breaklines" "true")
                                 ("breakanywhere" "true")))
;; Plantuml config
(setq plantuml-executable-path "${pkgs.yq}/bin/plantuml")
(setq plantuml-default-exec-mode 'executable)

;; Writeroom
(setq writeroom-width 120)
(map! :leader
      :desc "Toggle writeroom mode"
      "W" #'writeroom-mode)

;; Latex export settings
(with-eval-after-load 'ox-latex
(add-to-list 'org-latex-classes
   '("org-article"
     "\\documentclass{article}
      \\usepackage[reset, a4paper, height=9in, width=6in, hmarginratio=1:1, vmarginratio=1:1, marginparsep=0pt, marginparwidth=0pt, headheight=15pt]{geometry}
      \\usepackage{lmodern}")
   ))
(setq org-latex-default-class "org-article")

;; Org-Roam
(setq org-roam-directory "~/roam/")

;; Bibtex
(after! citar
  (setq! citar-bibliography '("~/roam/calibre-library.bib"))
  (setq! citar-notes-paths '("~/roam"))
  (setq! org-cite-insert-processor 'citar)
  (setq! org-cite-activate-processor 'citar)
  (setq! org-cite-follow-processor 'citar))

;; Org Roam
(setq org-roam-capture-templates
      '(("b" "book" plain "%?"
         :target
         (file+head "''${citekey}.org"
                    "#+TITLE: ''${title}\n#FILETAGS: #book\n:INFO:\n:author: ''${author}\n:year: ''${year}\n:END:\n* Notes\n")
         :unnarrowed t)
      ("d" "default" plain "%?"
         :target
         (file+head "%<%Y%m%d%H%M%S>-''${slug}.org"
                    "#+title: ''${title}\n")
         :unnarrowed t)))

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
(map! :leader
      :desc "Toggle org-roam-ui-mode"
      "n r u" #'org-roam-ui-mode)

;; C sharp
(setq lsp-csharp-omnisharp-roslyn-binary-path "${pkgs.omnisharp-roslyn}/bin/OmniSharp")
(require 'dap-netcore)
(map! :map csharp-mode-map
      :desc "Start debugger" "<f5>" #'dap-debug)
(setq dap-default-terminal-kind "external")

;; Rust
(map! :map rustic-mode-map
      :desc "Run program interactivly" "<f5>" #'rustic-cargo-comint-run)

'';
}
