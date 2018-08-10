;; -*- lexical-binding: t -*-

(use-package| lispyville
  :hook (emacs-lisp-mode . lispyville-mode))


(post-config| general
  (moon-cc-leader
   :keymaps 'emacs-lisp-mode-map
   ;; eval
   "e" '(:ignore t :which-key "eval")
   "ee" #'eval-last-sexp
   "er" #'eval-region
   "ef" #'eval-defun
   "eb" #'eval-buffer))
