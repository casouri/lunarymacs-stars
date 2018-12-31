;;; config.el --- Javascript support      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;

;;; Typescripte

;; switch to eglot

(moon-lsp/eglot
 (progn
   (add-hook 'js-mode-hook #'lsp t)
   (add-hook 'typescript-mode-hook #'lsp t)
   (push '(js-mode . lsp-format-buffer) moon-smart-format-alist)
   (push '(typescript-mode . lsp-format-buffer) moon-smart-format-alist))
 (progn
   (add-hook 'js-mode-hook #'eglot-ensure)
   (add-hook 'typescript-mode #'eglot-ensure)
   (push '(js-mode . eglot-format-buffer) moon-smart-format-alist)
   (push '(typescript-mode . eglot-format-buffer) moon-smart-format-alist)))


;;; indent

(setq js-indent-level 2)


;;; config.el ends here
