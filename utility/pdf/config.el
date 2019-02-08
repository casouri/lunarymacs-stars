;;; config.el --- PDF viewing      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;;

;;; Code:
;;

(setq doc-view-resolution 320)

(use-package| pdf-tools
  :mode "\\.pdf%"
  :commands pdf-view-mode)

;; put outside so it is evaluated asap
(add-to-list 'moon-package-sub-dir-white-list "pdf-tools/lisp$")

;;; config.el ends here
