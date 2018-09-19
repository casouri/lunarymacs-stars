;;; config.el --- Javascript support      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;

;;; Typescripte

(use-package| lsp-typescript
  :config
  (dolist (hook (list
                 'js2-mode-hook
                 'rjsx-mode-hook
                 'typescript-mode-hook
                 ))
    (add-hook hook (lambda ()
                     ;; setup tide
                     (tide-setup)
                     ;; automatically restart
                     (unless (tide-current-server)
                       (tide-restart-server))
                     ))))

(add-hook 'js-mode-hook #'lsp-typescript-enable)
(add-hook 'typescript-mode-hook #'lsp-typescript-enable) ;; for typescript support
(add-hook 'js3-mode-hook #'lsp-typescript-enable) ;; for js3-mode support
(add-hook 'rjsx-mode #'lsp-typescript-enable) ;; for rjsx-mode support

(defun lsp-company-transformer (candidates)
  (let ((completion-ignore-case t))
    (all-completions (company-grab-symbol) candidates)))

(defun lsp-js-hook ()
  (make-local-variable 'company-transformers)
  (push 'lsp-company-transformer company-transformers))

(add-hook 'js-mode-hook 'lsp-js-hook)

;;; indent

(setq js-indent-level 2)


;;; config.el ends here
