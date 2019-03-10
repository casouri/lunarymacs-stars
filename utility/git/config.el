;; -*- lexical-binding: t -*-

(use-package| magit
  :commands magit-status
  :config (define-key magit-mode-map (kbd "<tab>") 'magit-section-toggle))

;; put outside so it is evaluated asap
(add-to-list 'moon-package-sub-dir-white-list "magit/lisp$")

(post-config| general
  (moon-default-leader
    "gs" #'magit-status
    "gf" '(:ignore t :which-key "file")
    "gfc" #'magit-file-checkout
    "gfl" #'magit-log-buffer-file))

(use-package| magit-todos
  :hook (magit-mode . magit-todos-mode))
