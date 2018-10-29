;;; config.el --- Language server protocol      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;

;;; Keys

(post-config| general
  (with-eval-after-load 'lsp-mode
    (with-eval-after-load 'lsp-ui
      (moon-default-leader
        "lr" #'lsp-ui-peek-find-references
        "ld" #'lsp-ui-peek-find-definitions
        "lR" #'lsp-rename
        "lf" #'lsp-format-buffer
        ))))

;;; Variales

(defvar moon-use-eglot nil)

;;; Packages

(use-package| lsp-mode
  :defer t)
(use-package| lsp-ui
  :defer t)
(use-package| company-lsp
  :defer t)

(with-eval-after-load 'lsp-mode
  (require 'lsp-imenu)
  (add-hook 'lsp-after-open-hook #'lsp-enable-imenu)
  (setq lsp-enable-eldoc nil)
  (add-hook 'lsp-after-ope-hook (lambda () (eldoc-mode -1)))
  (setq lsp-message-project-root-warning t)
  (setq create-lckfiles nil)
  (dolist (face '(lsp-face-highlight-read
                  lsp-face-highlight-textual
                  lsp-face-highlight-write))
    (set-face-attribute face nil
                        :foreground nil
                        :distant-foreground nil
                        :background nil
                        :inherit 'lazy-highlight))

  (require 'lsp-ui)
  (add-hook 'lsp-mode-hook #'lsp-ui-mode)
  ;; completion
  (setq lsp-enable-completion-at-point t)
  ;; ui
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t)
  ;; peek color
  (add-hook 'moon-startup-hook-2 #'moon/sync-peek-face)
  (add-hook 'moon-load-theme-hook #'moon/sync-peek-face)

  (with-eval-after-load 'company
    (require 'company-lsp)
    (setq company-lsp-async t)
    (add-to-list 'company-backends 'company-lsp)))


;;; config.el ends here
