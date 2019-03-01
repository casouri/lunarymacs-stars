;;; config.el --- Java      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;;

;;; Code:
;;

;;;; Key

;;;; Package
;;
;;;;; LSP

(moon-lsp/eglot
 (progn
   (add-hook 'java-mode-hook #'lsp t)
   (push '(java-mode . lsp-format-buffer) moon-smart-format-alist))
 (progn
   (add-hook 'java-mode-hook #'eglot-ensure)
   (add-hook 'java-mode-hook (lambda () (setq-local tab-width 2)))
   (push '(java-mode . eglot-format-buffer) moon-smart-format-alist)))

;;;; Function

(defun moon-capfirst (str)
  "Cap STR’s first char."
  (concat (upcase (substring str 0 1))
          (substring str 1)))

(defun moon-downfirst (str)
  "Downcase STR’s first char."
  (concat (downcase (substring str 0 1))
          (substring str 1)))

;;; config.el ends here
