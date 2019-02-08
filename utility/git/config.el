;; -*- lexical-binding: t -*-

(use-package| magit
  :init (add-to-list 'moon-package-sub-dir-white-list "magit/lisp$")
  :commands magit-status
  :config (define-key magit-mode-map (kbd "<tab>") 'magit-section-toggle))

(post-config| general
  (moon-default-leader
    "gs" #'magit-status
    "gf" '(:ignore t :which-key "file")
    "gfc" #'magit-file-checkout
    "gfl" #'magit-log-buffer-file))

(use-package| (magit-todos :repo "alphapapa/magit-todos" :fetcher github)
  :hook (magit-mode . magit-todos-mode))
