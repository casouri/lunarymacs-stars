;;; eglot.el --- Eglot Config      -*- lexical-binding: t; -*-


;;; Commentary:
;;

;;; Code:
;;

;;; Keys

(post-config| general
  (moon-default-leader
    "l f" #'eglot-format-buffer
    "l R" #'eglot-rename
    "l d" #'xref-find-definitions
    "l r" #'xref-find-references))

;;; Packages

(use-package| eglot
  :defer t
  :config
  ;; don't pop doc in minibuffer on hover
  ;; (setq eglot-ignored-server-capabilites '(:hoverProvider))
  ;; additional language server support
  (add-to-list 'eglot-server-programs '((typescript-mode js-mode js2-mode) . ("typescript-language-server" "--stdio"))))

(use-package| eldoc-box
  :commands (eldoc-box-hover-mode
             eldoc-box-help-at-point)
  :init (add-hook 'eglot--managed-mode-hook #'eldoc-box-hover-mode t))

;;; eglot.el ends here
