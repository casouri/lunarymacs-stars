;;; config.el --- Shell      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;;

;;; Code:
;;

(post-config| general
  (moon-default-leader
    "y" '(:ignore t :which-key "fshell")
    "ys" #'fshell-switch-buffer
    "yn" #'fshell-next
    "yp" #'fshell-prev
    "yN" #'fshell-new)
  (general-define-key
   "s-e" #'fshell-toggle))

(use-package| fshell
  :commands (fshell-switch-buffer
             fshell-next
             fshell-prev
             fshell-new
             fshell
             fshell-toggle))


;;; config.el ends here
