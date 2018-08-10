;; -*- lexical-binding: t -*-

(use-package| magit
  :commands magit-status
  :config (define-key magit-mode-map (kbd "<tab>") 'magit-section-toggle))

(post-config| general
  (moon-default-leader
    "gs" #'magit-status
    "gf" '(:ignore t :which-key "file")
    "gfc" #'magit-file-checkout
    "gfl" #'magit-log-buffer-file))

(use-package| evil-magit
  :defer t
  :hook (magit-mode . (lambda () (require 'evil-magit))))

(use-package| (magit-todos :repo "alphapapa/magit-todos" :fetcher github)
  :hook (magit-mode . magit-todos-mode)
  :config
  (evil-define-key 'normal 'magit-status-mode-map "gT" #'magit-todos-jump-to-todos)
  (setq magit-todos-section-map (make-sparse-keymap)))
