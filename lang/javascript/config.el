;;; config.el --- Javascript support      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;

;;; Typescripte

;; switch to eglot

(if moon-use-eglot
    (progn
      (add-hook 'js-mode-hook #'eglot-ensure)
      (add-hook 'typescript-mode #'eglot-ensure)
      (push '(js-mode . eglot-format-buffer) moon-smart-format-alist)
      (push '(typescript-mode . eglot-format-buffer) moon-smart-format-alist)
      ;; KLUDGE https://github.com/joaotavora/eglot/issues/157
      (add-hook 'javascript-mode-hook (lambda () (setq-local tab-width 2))))
  (use-package| lsp-typescript
    :defer t)

  (use-package| typescript-mode
    :defer t)

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

  (push '(js-mode . lsp-format-buffer) moon-smart-format-alist)
  (push '(typescript-mode . lsp-format-buffer) moon-smart-format-alist))


;;; indent

(setq js-indent-level 2)


;;; config.el ends here
