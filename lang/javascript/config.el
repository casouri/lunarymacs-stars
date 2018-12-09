;;; config.el --- Javascript support      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;

;;; Typescripte

;; switch to eglot

(moon-lsp/eglot
 (progn
   (add-hook 'js-mode #'lsp t)
   (add-hook 'typescript-mode #'lsp t)
   (push '(js-mode . lsp-format-buffer) moon-smart-format-alist)
   (push '(typescript-mode . lsp-format-buffer) moon-smart-format-alist))
 (progn
   (add-hook 'js-mode-hook #'eglot-ensure)
   (add-hook 'typescript-mode #'eglot-ensure)
   (push '(js-mode . eglot-format-buffer) moon-smart-format-alist)
   (push '(typescript-mode . eglot-format-buffer) moon-smart-format-alist)
   ;; KLUDGE https://github.com/joaotavora/eglot/issues/157
   (add-hook 'javascript-mode-hook (lambda () (setq-local tab-width 2)))))


;;; indent

(setq js-indent-level 2)


;;; config.el ends here
