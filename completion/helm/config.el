;;; config.el --- Helm completion      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs


;;; Commentary:
;;

;;; Code:
;;

;;; Keys

(post-config| gerneral
  (moon-default-leader
    "fr" #'helm-recentf
    "ss" #'helm-swoop)
  (general-define-key
   :keymaps 'override
   "C-x C-p" #'helm-show-kill-ring
   "C-x C-n" #'helm-recentf
   [remap apropos]                   #'helm-apropos
   [remap find-file]                 #'helm-find-files
   [remap recentf-open-files]        #'helm-recentf
   [remap projectile-switch-to-buffer] #'helm-projectile-switch-to-buffer
   [remap projectile-recentf]        #'helm-projectile-recentf
   [remap projectile-find-file]      #'helm-projectile-find-file
   [remap imenu]                     #'helm-semantic-or-imenu
   [remap bookmark-jump]             #'helm-bookmarks
   [remap noop-show-kill-ring]       #'helm-show-kill-ring
   [remap projectile-switch-project] #'helm-projectile-switch-project
   [remap projectile-find-file]      #'helm-projectile-find-file
   [remap imenu-anywhere]            #'helm-imenu-anywhere
   [remap execute-extended-command]  #'helm-M-x
   ))

;;; Packages

(use-package| helm
  :config
  (setq
   ;; Speedier without fuzzy matching
   helm-mode-fuzzy-match nil
   helm-buffers-fuzzy-matching nil
   helm-apropos-fuzzy-match nil
   helm-M-x-fuzzy-match nil
   helm-recentf-fuzzy-match nil
   helm-projectile-fuzzy-match nil
   ;; Display extraineous helm UI elements
   ;; helm-display-header-line nil
   ;; helm-ff-auto-update-initial-value nil
   ;; helm-find-files-doc-header nil
   ;; Don't override evil-ex's completion
   ;; helm-mode-handle-completion-in-region nil
   ;; helm-candidate-number-limit 50
   ;; Don't wrap item cycling
   ;; helm-move-to-line-cycle-in-source t
   ;; helm-split-window-in-side-p t
   helm-ff-file-name-history-use-recentf t
   helm-autoresize-max-height 30
   helm-autoresize-min-height 30)
  (helm-autoresize-mode)
  (helm-mode))

(use-package| helm-swoop
  :commands helm-swoop)

;;; config.el ends here
