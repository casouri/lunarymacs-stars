;; -*- lexical-binding: t -*-

;; (use-package| lispyville
;;   :hook (emacs-lisp-mode . lispyville-mode)
;;   :config
;;   (lispyville-set-key-theme
;;    '(operators
;;      prettify
;;      text-objects
;;      additional-motions
;;      slurp/barf-cp)))


(post-config| general
  (moon-cx-leader
    :keymaps 'emacs-lisp-mode-map
    ;; eval
    "e" '(:ignore t :which-key "eval")
    "ee" #'eval-last-sexp
    "er" #'eval-region
    "ef" #'eval-defun
    "eb" #'eval-buffer))

(use-package| aggressive-indent
  :defer t
  :init
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'css-mode-hook #'aggressive-indent-mode))
