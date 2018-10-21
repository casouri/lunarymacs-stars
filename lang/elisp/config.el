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
    "w" '(:ignore t :which-key "eval")
    "w e" #'eval-last-sexp
    "w r" #'eval-region
    "w f" #'eval-defun
    "w b" #'eval-buffer))

(use-package| aggressive-indent
  :defer t
  :init
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'css-mode-hook #'aggressive-indent-mode))
