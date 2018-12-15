;;; lsp.el --- Language server protocol      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;

;;; Keys


(post-config| general
  (moon-default-leader
    "lr" #'lsp-ui-peek-find-references
    "ld" #'lsp-ui-peek-find-definitions
    "lR" #'lsp-rename
    "lf" #'lsp-format-buffer
    ))

;;; Packages

(use-package| lsp
  :commands lsp
  :init (setq lsp-auto-guess-root t)
  :config
  (require 'lsp-ui)
  (require 'lsp-clients)
  (require 'company-lsp))

(defun lsp--auto-configure ()
  "Auto configure `lsp-ui', `company-lsp' if they are installed.
Override by me."
  (lsp-ui-mode)
  (require 'lsp-ui-flycheck)
  (lsp-ui-flycheck-enable t)
  (flycheck-mode 1)

  (lsp-enable-imenu)

  (company-mode 1)
  (setq-local company-backends '(company-lsp)))

(use-package| lsp-ui
  :defer t
  :config
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-position 'top)
  (setq lsp-ui-doc-header t)
  (setq lsp-ui-doc-include-signature t))

(use-package| company-lsp
  :defer t)

;;; lsp.el ends here
