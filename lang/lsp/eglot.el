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
    "l r" #'xref-find-references)
  (general-define-key
   "C-h C-h" #'moon-help-at-point))

;;; Packages

(use-package| eglot
  :defer t
  :config
  ;; don't pop doc in minibuffer on hover
  ;; (setq eglot-ignored-server-capabilites '(:hoverProvider))
  ;; additional language server support
  )

(use-package| eldoc-box
  :commands (eldoc-box-hover-mode
             eldoc-box-help-at-point)
  :init
  ;; (add-hook 'eglot--managed-mode-hook #'eldoc-box-hover-mode t)
  (setq eldoc-box-cleanup-interval 0.2))

;;; Function

(defun moon-help-at-point ()
  (interactive)
  (when eglot--managed-mode
    (require 'eldoc-box)
    (let ((eldoc-box-position-function #'eldoc-box--default-at-point-position-function))
      (eldoc-box--display
       (eglot--dbind ((Hover) contents range)
           (jsonrpc-request (eglot--current-server-or-lose) :textDocument/hover
                            (eglot--TextDocumentPositionParams))
         (when (seq-empty-p contents) (eglot--error "No hover info here"))
         (eglot--hover-info contents range))))
    (add-hook 'pre-command-hook #'eldoc-box-quit-frame t t)))

;;; eglot.el ends here
