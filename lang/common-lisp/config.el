;;; config.el --- Common Lisp IDE      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;; 

;;; Code:
;;

;;; Package

(use-package| sly
  :commands sly
  :init
  (add-hook 'common-lisp-mode-hook #'sly-mode)
  (setq inferior-lisp-program "ccl64"))

(use-package| aggressive-indent
  :commands aggressive-indent-mode
  :init
  (add-hook 'common-lisp-mode-hook #'aggressive-indent-mode))

;;; Config

(dolist (hook '(common-lisp-mode-hook
                sly-mrepl-mode))
  (add-hook hook (lambda () (local-set-key (kbd "<tab>") #'company-complete))))





;;; config.el ends here
