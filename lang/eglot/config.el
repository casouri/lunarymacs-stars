;;; config.el --- Eglot Config      -*- lexical-binding: t; -*-


;;; Commentary:
;;
;; This star must run before any specific language star
;; because they depends on `moon-use-eglot'.

;;; Code:
;;

;;; Keys

(post-config| general
  (moon-default-leader
    "l f" #'eglot-format-buffer
    "l R" #'eglot-rename))

;;; Variables

(defvar moon-use-eglot t
  "Whether to use eglot instead of lsp.")

;;; Packages

(use-package| eglot
  :defer t
  :config
  ;; don't pop doc in minibuffer on hover
  ;; (setq eglot-ignored-server-capabilites '(:hoverProvider))
  ;; additional language server support
  (add-to-list 'eglot-server-programs '((typescript-mode js-mode js2-mode) . ("typescript-language-server" "--stdio")))
  ;; format on save
  (add-hook 'after-save-hook (lambda () (when moon-format-on-save (eglot-format-buffer)))))

;;; config.el ends here
