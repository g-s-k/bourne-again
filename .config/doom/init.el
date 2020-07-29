;;; init.el -*- lexical-binding: t; -*-

(doom! :input

       :completion
       company ivy ;; helm ido

       :ui
       doom hl-todo indent-guides modeline nav-flash ophints
       (popup +defaults) treemacs unicode vc-gutter vi-tilde-fringe workspaces
       ;; doom-dashboard doom-quit fill-column hydra minimap neotree
       ;; pretty-code tabs window-select zen

       :editor
       (evil +everywhere) file-templates fold (format +onsave) snippets
       ;; god lispy multiple-cursors objed parinfer rotate-text word-wrap

       :emacs
       dired electric undo vc ibuffer

       :term
       ;; eshell shell term vterm

       :checkers
       syntax spell grammar

       :tools
       docker (eval +overlay) lookup lsp macos magit make pass rgb tmux

       :lang
       cc coq data emacs-lisp (go +lsp) java (javascript +lsp) json markdown org
       rest (rust +lsp) sh yaml
       ;; java julia latex

       :email
       ;;(mu4e +gmail) notmuch (wanderlust +gmail)

       :app
       ;; calendar irc (rss +org) twitter

       :config
       ;; literate
       (default +bindings +smartparens))
