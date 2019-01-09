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

;; don't use lsp yet
;;
;; (moon-lsp/eglot
;;  (progn
;;    (add-hook 'java-mode-hook #'lsp t)
;;    (push '(java-mode . lsp-format-buffer) moon-smart-format-alist))
;;  (progn
;;    (add-hook 'java-mode-hook #'eglot-ensure)
;;    (push '(java-mode . eglot-format-buffer) moon-smart-format-alist)))

;; https://github.com/mopemope/meghanada-emacs
;;

(use-package| meghanada
  :config
  (add-hook 'java-mode-hook
            (lambda ()
              (meghanada-mode)
              (flycheck-mode)
              ))
  (add-to-list 'moon-smart-format-alist '(java-mode . meghanada-code-beautify-before-save))
  (cond
   ((eq system-type 'windows-nt)
    (setq meghanada-java-path (expand-file-name "bin/java.exe" (getenv "JAVA_HOME")))
    (setq meghanada-maven-path "mvn.cmd"))
   (t
    (setq meghanada-java-path "java")
    (setq meghanada-maven-path "mvn")))
  )



;;; config.el ends here
