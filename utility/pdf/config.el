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

;;; config.el ends here
