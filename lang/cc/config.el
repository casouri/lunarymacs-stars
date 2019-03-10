;;; config.el --- C/C++      -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Yuan Fu

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;;

;;; Code:
;;

;;; Package

(moon-lsp/eglot
 (progn
   (dolist (mode '(c-mode c++-mode objc-mode cuda-mode))
     (add-hook (intern (format "%s-hook" (symbol-name mode))) (lambda () (require 'ccls) (lsp)) t)
     (push (cons mode 'lsp-format-buffer) moon-smart-format-alist)))
 (progn
   (add-hook 'c-mode #'eglot-ensure t)
   ;; (push '(c-mode . eglot-format-buffer) moon-smart-format-alist)
   ))

;; C/C++/Objective-C support
;; Install: brew tap twlz0ne/homebrew-ccls && brew install ccls
;;          refer to  https://github.com/MaskRay/ccls/wiki/Getting-started
(use-package| ccls
  :defer t
  :config
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json"
                    ".ccls")
                  projectile-project-root-files-top-down-recurring))))

;;; Config

(setq-default c-basic-offset 2)

;;; config.el ends here
