;;; eglot.el --- Eglot Config      -*- lexical-binding: t; -*-


;;; Commentary:
;;

;;; Code:
;;

;;; Keys

(post-config| general
  (moon-default-leader
    "l f" #'eglot-format-buffer
    "l R" #'eglot-rename))

;;; Packages

(use-package| eglot
  :defer t
  :config
  ;; don't pop doc in minibuffer on hover
  ;; (setq eglot-ignored-server-capabilites '(:hoverProvider))
  ;; additional language server support
  (add-to-list 'eglot-server-programs '((typescript-mode js-mode js2-mode) . ("typescript-language-server" "--stdio"))))

;;; eglot.el ends here
