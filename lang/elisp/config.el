;; -*- lexical-binding: t -*-

(use-package| lispyville
  :hook (emacs-lisp-mode . lispyville-mode)
  :config
  (lispyville-set-key-theme
   '(operators
     prettify
     text-objects
     additional-motions
     slurp/barf-cp)))


(post-config| general
  (moon-cx-leader
   :keymaps 'emacs-lisp-mode-map
   ;; eval
   "C-e" '(:ignore t :which-key "eval")
   "C-e e" #'eval-last-sexp
   "C-e r" #'eval-region
   "C-e f" #'eval-defun
   "C-e b" #'eval-buffer))
