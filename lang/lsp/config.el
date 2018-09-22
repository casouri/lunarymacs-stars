;;; config.el --- Language server protocol      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;


(defvar moon-smart-toggle-lsp-ui t
  "Whether to toggle lsp-ui doc and sideline automatically depending on window width.")

(defvar moon-smart-toggle-threshold 120
  "If window width is above threshold, keep lsp-ui-doc/sideline on, if under, turn them off.")

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
  (with-eval-after-load 'fly-check
    (require 'lsp-flycheck))
  (add-hook 'lsp-mode-hook #'lsp-ui-mode)
  ;; completion
  (setq lsp-enable-completion-at-point t)
  ;; ui
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t)
  ;; smart toggle lsp-ui doc & sideline
  (add-hook 'window-configuration-change-hook
            #'moon/smart-toggle-lsp-ui)
  (add-hook 'lsp-ui-mode-hook
            #'moon/smart-toggle-lsp-ui)
  ;; if manually toggled doc or sideline, disable smart-toggle
  (advice-add 'lsp-ui-doc-mode :after #'moon-force-lsp-ui)
  (advice-add 'lsp-ui-sideline-mode :after #'moon-force-lsp-ui)
  ;; peek color
  (moon/sync-peek-face)
  (add-hook 'moon-load-theme-hook #'moon/sync-peek-face)

  (with-eval-after-load 'company
    (require 'company-lsp)
    (setq company-lsp-async t)
    (add-to-list 'company-backends 'company-lsp)))

;; (use-package| lsp-ui
;;   :after lsp-mode
;;   :config
;;   (require 'lsp-flycheck)
;;   (add-hook 'lsp-mode-hook #'lsp-ui-mode)
;;   ;; completion
;;   (setq lsp-enable-completion-at-point t)
;;   ;; ui
;;   (setq lsp-ui-sideline-enable t)
;;   (setq lsp-ui-doc-enable t)
;;   (setq lsp-ui-doc-position 'top)
;;   (setq lsp-ui-doc-header t)
;;   (setq lsp-ui-doc-include-signature t)
;;   ;; smart toggle lsp-ui doc & sideline
;;   (add-hook 'window-configuration-change-hook
;;             #'moon/smart-toggle-lsp-ui)
;;   (add-hook 'lsp-ui-mode-hook
;;             #'moon/smart-toggle-lsp-ui)
;;   ;; if manually toggled doc or sideline, disable smart-toggle
;;   (advice-add 'lsp-ui-doc-mode :after #'moon-force-lsp-ui)
;;   (advice-add 'lsp-ui-sideline-mode :after #'moon-force-lsp-ui)
;;   ;; peek color
;;   (moon/sync-peek-face)
;;   (add-hook 'moon-load-theme-hook #'moon/sync-peek-face))

;; (use-package| company-lsp
;;   :after (company lsp-mode)
;;   :init  
;;   (setq company-lsp-async t)
;;   (add-to-list 'company-backends 'company-lsp))

(post-config| general
  (with-eval-after-load 'lsp-mode
    (with-eval-after-load 'lsp-ui
      (moon-default-leader
        "lr" #'lsp-ui-peek-find-references
        "ld" #'lsp-ui-peek-find-definitions
        "lR" #'lsp-rename
        "lf" #'lsp-format-buffer
        ))))

;;; config.el ends here
