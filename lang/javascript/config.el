;;; config.el --- Javascript support      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;

;;; Typescripte

(use-package| lsp-typescript
  :defer t)

(use-package| typescript-mode)

(add-hook 'js-mode-hook #'lsp-javascript-setup)
(add-hook 'typescript-mode-hook #'lsp-javascript-setup) ;; for typescript support

(defun lsp-company-transformer (candidates)
  (let ((completion-ignore-case t))
    (all-completions (company-grab-symbol) candidates)))

(defun lsp-js-hook ()
  "Add company support."
  (make-local-variable 'company-transformers)
  (push 'lsp-company-transformer company-transformers))

(defun lsp-javascript-setup ()
  "Setup lsp for javascript."
  (require 'lsp-mode)
  (require 'lsp-typescript)
  (lsp-typescript-enable))

(add-hook 'js-mode-hook 'lsp-js-hook)

;;; indent

(setq js-indent-level 2)


;;; config.el ends here
