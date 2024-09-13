{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    extraPackages = epkgs: with epkgs; [
      org-roam
      org-roam-ui
      websocket
      citar
      citar-org-roam
    ];

    extraConfig = ''
(use-package org-roam
  :init
  (require 'bind-key)
  :custom
  (org-roam-directory (file-truename "~/roam/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "''${title:*} " (propertize "''${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

;; Citar
(setq citar-bibliography '("~/roam/calibre-library.bib")
      citar-notes-paths '("~/roam")
      org-cite-insert-processor 'citar
      org-cite-activate-processor 'citar
      org-cite-follow-processor 'citar)

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

(use-package websocket
    :after org-roam)

(use-package org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
    '';
  };
}
