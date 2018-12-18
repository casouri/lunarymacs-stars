;; -*- lexical-binding: t -*-

;; (use-package| flycheck
;;   ;; :commands global-flycheck-mode
;;   ;; :init (add-hook-for-once| prog-mode-hook (lambda () (global-flycheck-mode 1)))
;;   :commands flycheck-mode)

;;; Key

(post-config| general
  (moon-default-leader
    "en" #'hydra-error/flymake-goto-next-error
    "ep" #'hydra-error/flymake-goto-prev-error))

;;; Package

;; (use-package| flymake-diagnostic-at-point
;;   :after flymake
;;   :init (setq flymake-diagnostic-at-point-error-prefix "|")
;;   :config (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

;;; Config

(post-config| hydra
  (require 'hydra)
  (defhydra hydra-error ()
    "goto-error"
    ("n" flymake-goto-next-error "next")
    ("p" flymake-goto-prev-error "prev")
    ("q" nil "quit")))
